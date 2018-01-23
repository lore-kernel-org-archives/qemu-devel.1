Received: from eggs.gnu.org ([2001:4830:134:3::10]:52105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ee1dK-0004Aj-53
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ee1dF-00062z-Rq
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:41:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ee1dF-000625-J0
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:41:09 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jan 2018 17:40:39 +0100
Message-Id: <20180123164041.30339-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180123164041.30339-1-marcandre.lureau@redhat.com>
References: <20180123164041.30339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 2/4] fw_cfg: do DMA read operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, slp@redhat.com, mst@redhat.com, somlo@cmu.edu, xiaolong.ye@intel.com, peterx@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Modify fw_cfg_read_blob() to use DMA if the device supports it.
Return errors, because the operation may fail.

The DMA operation is expected to run synchronously with today qemu,
but the specification states that it may become async, so we run
"control" field check in a loop for eventual changes.

We may want to switch all the *buf addresses to use only kmalloc'ed
buffers (instead of using stack/image addresses with dma=3Dfalse).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 drivers/firmware/qemu_fw_cfg.c | 131 ++++++++++++++++++++++++++++++++++-=
------
 1 file changed, 111 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cf=
g.c
index 740df0df2260..686f0e839858 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -33,6 +33,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/delay.h>
=20
 MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
 MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
@@ -43,12 +44,22 @@ MODULE_LICENSE("GPL");
 #define FW_CFG_ID         0x01
 #define FW_CFG_FILE_DIR   0x19
=20
+#define FW_CFG_VERSION_DMA     0x02
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
@@ -75,12 +92,68 @@ static inline u16 fw_cfg_sel_endianness(u16 key)
 	return fw_cfg_is_mmio ? cpu_to_be16(key) : cpu_to_le16(key);
 }
=20
+static inline bool fw_cfg_dma_enabled(void)
+{
+	return fw_cfg_rev & FW_CFG_VERSION_DMA && fw_cfg_reg_dma;
+}
+
+/* qemu fw_cfg device is sync today, but spec says it may become async *=
/
+static void fw_cfg_wait_for_control(struct fw_cfg_dma *d)
+{
+	do {
+		u32 ctrl =3D be32_to_cpu(READ_ONCE(d->control));
+
+		if ((ctrl & ~FW_CFG_DMA_CTL_ERROR) =3D=3D 0)
+			return;
+
+		usleep_range(50, 100);
+	} while (true);
+}
+
+static ssize_t fw_cfg_dma_transfer(struct device *dev,
+				void *address, u32 length, u32 control)
+{
+	phys_addr_t dma;
+	struct fw_cfg_dma *d =3D NULL;
+	ssize_t ret =3D length;
+
+	d =3D kmalloc(sizeof(*d), GFP_KERNEL);
+	if (!d) {
+		ret =3D -ENOMEM;
+		goto end;
+	}
+
+	*d =3D (struct fw_cfg_dma) {
+		.address =3D cpu_to_be64(virt_to_phys(address)),
+		.length =3D cpu_to_be32(length),
+		.control =3D cpu_to_be32(control)
+	};
+
+	dma =3D virt_to_phys(d);
+
+	iowrite32be((u64)dma >> 32, fw_cfg_reg_dma);
+	iowrite32be(dma, fw_cfg_reg_dma + 4);
+
+	fw_cfg_wait_for_control(d);
+
+	if (be32_to_cpu(READ_ONCE(d->control)) & FW_CFG_DMA_CTL_ERROR) {
+		ret =3D -EIO;
+	}
+
+end:
+	kfree(d);
+
+	return ret;
+}
+
 /* read chunk of given fw_cfg blob (caller responsible for sanity-check)=
 */
-static inline void fw_cfg_read_blob(u16 key,
-				    void *buf, loff_t pos, size_t count)
+static ssize_t fw_cfg_read_blob(struct device *dev, u16 key,
+				void *buf, loff_t pos, size_t count,
+				bool dma)
 {
 	u32 glk =3D -1U;
 	acpi_status status;
+	ssize_t ret =3D count;
=20
 	/* If we have ACPI, ensure mutual exclusion against any potential
 	 * device access by the firmware, e.g. via AML methods:
@@ -90,17 +163,36 @@ static inline void fw_cfg_read_blob(u16 key,
 		/* Should never get here */
 		WARN(1, "fw_cfg_read_blob: Failed to lock ACPI!\n");
 		memset(buf, 0, count);
-		return;
+		return -EINVAL;
 	}
=20
 	mutex_lock(&fw_cfg_dev_lock);
-	iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
-	while (pos-- > 0)
-		ioread8(fw_cfg_reg_data);
-	ioread8_rep(fw_cfg_reg_data, buf, count);
+	if (dma && fw_cfg_dma_enabled()) {
+		if (pos =3D=3D 0) {
+			ret =3D fw_cfg_dma_transfer(dev, buf, count, key << 16
+						  | FW_CFG_DMA_CTL_SELECT
+						  | FW_CFG_DMA_CTL_READ);
+		} else {
+			iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
+			ret =3D fw_cfg_dma_transfer(dev, NULL, pos, FW_CFG_DMA_CTL_SKIP);
+			if (ret < 0)
+				goto end;
+			ret =3D fw_cfg_dma_transfer(dev, buf, count,
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
@@ -192,7 +284,7 @@ static int fw_cfg_do_platform_probe(struct platform_d=
evice *pdev)
 #endif
=20
 	/* verify fw_cfg device signature */
-	fw_cfg_read_blob(FW_CFG_SIGNATURE, sig, 0, FW_CFG_SIG_SIZE);
+	fw_cfg_read_blob(&pdev->dev, FW_CFG_SIGNATURE, sig, 0, FW_CFG_SIG_SIZE,=
 false);
 	if (memcmp(sig, "QEMU", FW_CFG_SIG_SIZE) !=3D 0) {
 		fw_cfg_io_cleanup();
 		return -ENODEV;
@@ -201,9 +293,6 @@ static int fw_cfg_do_platform_probe(struct platform_d=
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
@@ -222,6 +311,7 @@ struct fw_cfg_sysfs_entry {
 	struct kobject kobj;
 	struct fw_cfg_file f;
 	struct list_head list;
+	struct device *dev;
 };
=20
 /* get fw_cfg_sysfs_entry from kobject member */
@@ -344,6 +434,7 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *fil=
p, struct kobject *kobj,
 				     char *buf, loff_t pos, size_t count)
 {
 	struct fw_cfg_sysfs_entry *entry =3D to_entry(kobj);
+	struct device *dev =3D entry->dev;
=20
 	if (pos > entry->f.size)
 		return -EINVAL;
@@ -351,8 +442,7 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *fil=
p, struct kobject *kobj,
 	if (count > entry->f.size - pos)
 		count =3D entry->f.size - pos;
=20
-	fw_cfg_read_blob(entry->f.select, buf, pos, count);
-	return count;
+	return fw_cfg_read_blob(dev, entry->f.select, buf, pos, count, true);
 }
=20
 static struct bin_attribute fw_cfg_sysfs_attr_raw =3D {
@@ -459,7 +549,7 @@ static struct kobject *fw_cfg_sel_ko;
 static struct kset *fw_cfg_fname_kset;
=20
 /* register an individual fw_cfg file */
-static int fw_cfg_register_file(const struct fw_cfg_file *f)
+static int fw_cfg_register_file(struct device *dev, const struct fw_cfg_=
file *f)
 {
 	int err;
 	struct fw_cfg_sysfs_entry *entry;
@@ -471,6 +561,7 @@ static int fw_cfg_register_file(const struct fw_cfg_f=
ile *f)
=20
 	/* set file entry information */
 	memcpy(&entry->f, f, sizeof(struct fw_cfg_file));
+	entry->dev =3D dev;
=20
 	/* register entry under "/sys/firmware/qemu_fw_cfg/by_key/" */
 	err =3D kobject_init_and_add(&entry->kobj, &fw_cfg_sysfs_entry_ktype,
@@ -498,14 +589,14 @@ static int fw_cfg_register_file(const struct fw_cfg=
_file *f)
 }
=20
 /* iterate over all fw_cfg directory entries, registering each one */
-static int fw_cfg_register_dir_entries(void)
+static int fw_cfg_register_dir_entries(struct device *dev)
 {
 	int ret =3D 0;
 	u32 count, i;
 	struct fw_cfg_file *dir;
 	size_t dir_size;
=20
-	fw_cfg_read_blob(FW_CFG_FILE_DIR, &count, 0, sizeof(count));
+	fw_cfg_read_blob(dev, FW_CFG_FILE_DIR, &count, 0, sizeof(count), false)=
;
 	count =3D be32_to_cpu(count);
 	dir_size =3D count * sizeof(struct fw_cfg_file);
=20
@@ -513,12 +604,12 @@ static int fw_cfg_register_dir_entries(void)
 	if (!dir)
 		return -ENOMEM;
=20
-	fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(count), dir_size);
+	fw_cfg_read_blob(dev, FW_CFG_FILE_DIR, dir, sizeof(count), dir_size, tr=
ue);
=20
 	for (i =3D 0; i < count; i++) {
 		dir[i].size =3D be32_to_cpu(dir[i].size);
 		dir[i].select =3D be16_to_cpu(dir[i].select);
-		ret =3D fw_cfg_register_file(&dir[i]);
+		ret =3D fw_cfg_register_file(dev, &dir[i]);
 		if (ret)
 			break;
 	}
@@ -562,14 +653,14 @@ static int fw_cfg_sysfs_probe(struct platform_devic=
e *pdev)
 		goto err_probe;
=20
 	/* get revision number, add matching top-level attribute */
-	fw_cfg_read_blob(FW_CFG_ID, &fw_cfg_rev, 0, sizeof(fw_cfg_rev));
+	fw_cfg_read_blob(&pdev->dev, FW_CFG_ID, &fw_cfg_rev, 0, sizeof(fw_cfg_r=
ev), false);
 	fw_cfg_rev =3D le32_to_cpu(fw_cfg_rev);
 	err =3D sysfs_create_file(fw_cfg_top_ko, &fw_cfg_rev_attr.attr);
 	if (err)
 		goto err_rev;
=20
 	/* process fw_cfg file directory entry, registering each file */
-	err =3D fw_cfg_register_dir_entries();
+	err =3D fw_cfg_register_dir_entries(&pdev->dev);
 	if (err)
 		goto err_dir;
=20
--=20
2.16.0.rc1.1.gef27df75a1
