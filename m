Received: from eggs.gnu.org ([2001:4830:134:3::10]:44633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d45HP-0000KC-AA
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d45HM-00054Q-4P
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:45:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d45HL-00053r-S1
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:45:44 -0400
From: marcandre.lureau@redhat.com
Date: Fri, 28 Apr 2017 16:45:09 +0400
Message-Id: <20170428124510.23654-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170428124510.23654-1-marcandre.lureau@redhat.com>
References: <20170428124510.23654-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] fw_cfg: do DMA read operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: somlo@cmu.edu, linux-kernel@vger.kernel.org, mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Modify fw_cfg_read_blob() to use DMA if the device supports it.
Return errors, because the operation may fail.

This is a proof-of-concept patch with some FIXME. It uses yield() to
wait for the memory to be cleared, and it uses 2 iowrite32() to write a
64bit value. Help on how to improve this is welcome.

We may also want to switch the *buf address to use only kmalloc'ed
buffer (instead of allowing stack/image addresses with dma=3Dfalse).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 drivers/firmware/qemu_fw_cfg.c | 125 +++++++++++++++++++++++++++++++++++=
------
 1 file changed, 109 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cf=
g.c
index 614037703530..430289332c95 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -33,6 +33,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/dma-mapping.h>
=20
 MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
 MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
@@ -43,12 +44,22 @@ MODULE_LICENSE("GPL");
 #define FW_CFG_ID         0x01
 #define FW_CFG_FILE_DIR   0x19
=20
+#define FW_CFG_VERSION_DMA     2
+#define FW_CFG_DMA_CTL_ERROR   0x01
+#define FW_CFG_DMA_CTL_READ    0x02
+#define FW_CFG_DMA_CTL_SKIP    0x04
+#define FW_CFG_DMA_CTL_SELECT  0x08
+#define FW_CFG_DMA_CTL_WRITE   0x10
+
 /* size in bytes of fw_cfg signature */
 #define FW_CFG_SIG_SIZE 4
=20
 /* fw_cfg "file name" is up to 56 characters (including terminating nul)=
 */
 #define FW_CFG_MAX_FILE_PATH 56
=20
+/* fw_cfg revision attribute, in /sys/firmware/qemu_fw_cfg top-level dir=
. */
+static u32 fw_cfg_rev;
+
 /* fw_cfg file directory entry type */
 struct fw_cfg_file {
 	u32 size;
@@ -57,6 +68,12 @@ struct fw_cfg_file {
 	char name[FW_CFG_MAX_FILE_PATH];
 };
=20
+struct fw_cfg_dma {
+	u32 control;
+	u32 length;
+	u64 address;
+} __packed;
+
 /* fw_cfg device i/o register addresses */
 static bool fw_cfg_is_mmio;
 static phys_addr_t fw_cfg_p_base;
@@ -75,12 +92,73 @@ static inline u16 fw_cfg_sel_endianness(u16 key)
 	return fw_cfg_is_mmio ? cpu_to_be16(key) : cpu_to_le16(key);
 }
=20
+static inline bool fw_cfg_dma_enabled(void)
+{
+	return fw_cfg_rev & FW_CFG_VERSION_DMA && fw_cfg_reg_dma;
+}
+
+static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 contro=
l)
+{
+	dma_addr_t dma_addr =3D 0;
+	struct fw_cfg_dma *d;
+	dma_addr_t dma;
+	ssize_t ret =3D length;
+	enum dma_data_direction dir =3D
+		(control & FW_CFG_DMA_CTL_READ ? DMA_FROM_DEVICE : 0);
+
+	if (address && length) {
+		dma_addr =3D dma_map_single(NULL, address, length, dir);
+		if (dma_mapping_error(NULL, dma_addr)) {
+			WARN(1, "fw_cfg_dma_transfer: failed to map address\n");
+			return -EFAULT;
+		}
+	}
+
+	d =3D kmalloc(sizeof(*d), GFP_KERNEL | GFP_DMA);
+	if (!d) {
+		ret =3D -ENOMEM;
+		goto end;
+	}
+
+	dma =3D dma_map_single(NULL, d, sizeof(*d), DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(NULL, dma)) {
+		WARN(1, "fw_cfg_dma_transfer: failed to map fw_cfg_dma\n");
+		ret =3D -EFAULT;
+		goto end;
+	}
+
+	*d =3D (struct fw_cfg_dma) {
+		.address =3D cpu_to_be64(dma_addr),
+		.length =3D cpu_to_be32(length),
+		.control =3D cpu_to_be32(control)
+	};
+	/* fixme: no iowrite64? */
+	iowrite32(cpu_to_be32(dma >> 32), fw_cfg_reg_dma);
+	iowrite32(cpu_to_be32(dma), fw_cfg_reg_dma + 4);
+	while (be32_to_cpu(d->control) & ~FW_CFG_DMA_CTL_ERROR)
+		yield(); /* fixme: wait_event? */
+
+	if (be32_to_cpu(d->control) & FW_CFG_DMA_CTL_ERROR)
+		ret =3D -EIO;
+
+	dma_unmap_single(NULL, dma, sizeof(*d), DMA_BIDIRECTIONAL);
+
+end:
+	kfree(d);
+	if (dma_addr)
+		dma_unmap_single(NULL, dma_addr, length, dir);
+
+	return ret;
+}
+
 /* read chunk of given fw_cfg blob (caller responsible for sanity-check)=
 */
-static inline void fw_cfg_read_blob(u16 key,
-				    void *buf, loff_t pos, size_t count)
+static ssize_t fw_cfg_read_blob(u16 key,
+				void *buf, loff_t pos, size_t count,
+				bool dma)
 {
 	u32 glk =3D -1U;
 	acpi_status status;
+	ssize_t ret =3D count;
=20
 	/* If we have ACPI, ensure mutual exclusion against any potential
 	 * device access by the firmware, e.g. via AML methods:
@@ -90,17 +168,36 @@ static inline void fw_cfg_read_blob(u16 key,
 		/* Should never get here */
 		WARN(1, "fw_cfg_read_blob: Failed to lock ACPI!\n");
 		memset(buf, 0, count);
-		return;
+		return -EBUSY;
 	}
=20
 	mutex_lock(&fw_cfg_dev_lock);
-	iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
-	while (pos-- > 0)
-		ioread8(fw_cfg_reg_data);
-	ioread8_rep(fw_cfg_reg_data, buf, count);
+	if (dma && fw_cfg_dma_enabled()) {
+		if (pos =3D=3D 0) {
+			ret =3D fw_cfg_dma_transfer(buf, count, key << 16
+						  | FW_CFG_DMA_CTL_SELECT
+						  | FW_CFG_DMA_CTL_READ);
+		} else {
+			iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
+			ret =3D fw_cfg_dma_transfer(0, pos, FW_CFG_DMA_CTL_SKIP);
+			if (ret < 0)
+				goto end;
+			ret =3D fw_cfg_dma_transfer(buf, count,
+						  FW_CFG_DMA_CTL_READ);
+		}
+	} else {
+		iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
+		while (pos-- > 0)
+			ioread8(fw_cfg_reg_data);
+		ioread8_rep(fw_cfg_reg_data, buf, count);
+	}
+
+end:
 	mutex_unlock(&fw_cfg_dev_lock);
=20
 	acpi_release_global_lock(glk);
+
+	return ret;
 }
=20
 /* clean up fw_cfg device i/o */
@@ -192,7 +289,7 @@ static int fw_cfg_do_platform_probe(struct platform_d=
evice *pdev)
 #endif
=20
 	/* verify fw_cfg device signature */
-	fw_cfg_read_blob(FW_CFG_SIGNATURE, sig, 0, FW_CFG_SIG_SIZE);
+	fw_cfg_read_blob(FW_CFG_SIGNATURE, sig, 0, FW_CFG_SIG_SIZE, false);
 	if (memcmp(sig, "QEMU", FW_CFG_SIG_SIZE) !=3D 0) {
 		fw_cfg_io_cleanup();
 		return -ENODEV;
@@ -201,9 +298,6 @@ static int fw_cfg_do_platform_probe(struct platform_d=
evice *pdev)
 	return 0;
 }
=20
-/* fw_cfg revision attribute, in /sys/firmware/qemu_fw_cfg top-level dir=
. */
-static u32 fw_cfg_rev;
-
 static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, ch=
ar *buf)
 {
 	return sprintf(buf, "%u\n", fw_cfg_rev);
@@ -351,8 +445,7 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *fil=
p, struct kobject *kobj,
 	if (count > entry->f.size - pos)
 		count =3D entry->f.size - pos;
=20
-	fw_cfg_read_blob(entry->f.select, buf, pos, count);
-	return count;
+	return fw_cfg_read_blob(entry->f.select, buf, pos, count, true);
 }
=20
 static struct bin_attribute fw_cfg_sysfs_attr_raw =3D {
@@ -505,7 +598,7 @@ static int fw_cfg_register_dir_entries(void)
 	struct fw_cfg_file *dir;
 	size_t dir_size;
=20
-	fw_cfg_read_blob(FW_CFG_FILE_DIR, &count, 0, sizeof(count));
+	fw_cfg_read_blob(FW_CFG_FILE_DIR, &count, 0, sizeof(count), false);
 	count =3D be32_to_cpu(count);
 	dir_size =3D count * sizeof(struct fw_cfg_file);
=20
@@ -513,7 +606,7 @@ static int fw_cfg_register_dir_entries(void)
 	if (!dir)
 		return -ENOMEM;
=20
-	fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(count), dir_size);
+	fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(count), dir_size, true);
=20
 	for (i =3D 0; i < count; i++) {
 		dir[i].size =3D be32_to_cpu(dir[i].size);
@@ -562,7 +655,7 @@ static int fw_cfg_sysfs_probe(struct platform_device =
*pdev)
 		goto err_probe;
=20
 	/* get revision number, add matching top-level attribute */
-	fw_cfg_read_blob(FW_CFG_ID, &fw_cfg_rev, 0, sizeof(fw_cfg_rev));
+	fw_cfg_read_blob(FW_CFG_ID, &fw_cfg_rev, 0, sizeof(fw_cfg_rev), false);
 	fw_cfg_rev =3D le32_to_cpu(fw_cfg_rev);
 	err =3D sysfs_create_file(fw_cfg_top_ko, &fw_cfg_rev_attr.attr);
 	if (err)
--=20
2.12.0.191.gc5d8de91d
