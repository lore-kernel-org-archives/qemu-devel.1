Received: from eggs.gnu.org ([2001:4830:134:3::10]:44652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d45HR-0000M1-UB
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d45HQ-00056f-Py
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:45:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d45HQ-000565-GT
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:45:48 -0400
From: marcandre.lureau@redhat.com
Date: Fri, 28 Apr 2017 16:45:10 +0400
Message-Id: <20170428124510.23654-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170428124510.23654-1-marcandre.lureau@redhat.com>
References: <20170428124510.23654-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] fw_cfg: add DMA write operation
 proof-of-concept
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

Since qemu 2.9, DMA write operations are allowed. However, usage of this
interface from kernel or user-space is strongly discouraged by the
maintainers. This patch is only meant as an experiment.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 drivers/firmware/qemu_fw_cfg.c | 64 ++++++++++++++++++++++++++++++++++++=
++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cf=
g.c
index 430289332c95..7da47fffe833 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -104,7 +104,8 @@ static ssize_t fw_cfg_dma_transfer(void *address, u32=
 length, u32 control)
 	dma_addr_t dma;
 	ssize_t ret =3D length;
 	enum dma_data_direction dir =3D
-		(control & FW_CFG_DMA_CTL_READ ? DMA_FROM_DEVICE : 0);
+		(control & FW_CFG_DMA_CTL_READ ? DMA_FROM_DEVICE : 0) |
+		(control & FW_CFG_DMA_CTL_WRITE ? DMA_TO_DEVICE : 0);
=20
 	if (address && length) {
 		dma_addr =3D dma_map_single(NULL, address, length, dir);
@@ -200,6 +201,46 @@ static ssize_t fw_cfg_read_blob(u16 key,
 	return ret;
 }
=20
+/* write chunk of given fw_cfg blob (caller responsible for sanity-check=
) */
+static ssize_t fw_cfg_write_blob(u16 key,
+				 void *buf, loff_t pos, size_t count)
+{
+	u32 glk =3D -1U;
+	acpi_status status;
+	ssize_t ret =3D count;
+
+	/* If we have ACPI, ensure mutual exclusion against any potential
+	 * device access by the firmware, e.g. via AML methods:
+	 */
+	status =3D acpi_acquire_global_lock(ACPI_WAIT_FOREVER, &glk);
+	if (ACPI_FAILURE(status) && status !=3D AE_NOT_CONFIGURED) {
+		/* Should never get here */
+		WARN(1, "fw_cfg_write_blob: Failed to lock ACPI!\n");
+		memset(buf, 0, count);
+		return -EBUSY;
+	}
+
+	mutex_lock(&fw_cfg_dev_lock);
+	if (pos =3D=3D 0) {
+		ret =3D fw_cfg_dma_transfer(buf, count, key << 16
+					  | FW_CFG_DMA_CTL_SELECT
+					  | FW_CFG_DMA_CTL_WRITE);
+	} else {
+		iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
+		ret =3D fw_cfg_dma_transfer(0, pos, FW_CFG_DMA_CTL_SKIP);
+		if (ret < 0)
+			goto end;
+		ret =3D fw_cfg_dma_transfer(buf, count, FW_CFG_DMA_CTL_WRITE);
+	}
+
+end:
+	mutex_unlock(&fw_cfg_dev_lock);
+
+	acpi_release_global_lock(glk);
+
+	return ret;
+}
+
 /* clean up fw_cfg device i/o */
 static void fw_cfg_io_cleanup(void)
 {
@@ -448,9 +489,28 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *fi=
lp, struct kobject *kobj,
 	return fw_cfg_read_blob(entry->f.select, buf, pos, count, true);
 }
=20
+static ssize_t fw_cfg_sysfs_write_raw(struct file *filp, struct kobject =
*kobj,
+				      struct bin_attribute *bin_attr,
+				      char *buf, loff_t pos, size_t count)
+{
+	struct fw_cfg_sysfs_entry *entry =3D to_entry(kobj);
+
+	if (!fw_cfg_dma_enabled())
+		return -ENOTSUPP;
+
+	if (pos >=3D entry->f.size && count)
+		return -EINVAL;
+
+	if (count > entry->f.size - pos)
+		count =3D entry->f.size - pos;
+
+	return fw_cfg_write_blob(entry->f.select, buf, pos, count);
+}
+
 static struct bin_attribute fw_cfg_sysfs_attr_raw =3D {
-	.attr =3D { .name =3D "raw", .mode =3D S_IRUSR },
+	.attr =3D { .name =3D "raw", .mode =3D 0600 },
 	.read =3D fw_cfg_sysfs_read_raw,
+	.write =3D fw_cfg_sysfs_write_raw,
 };
=20
 /*
--=20
2.12.0.191.gc5d8de91d
