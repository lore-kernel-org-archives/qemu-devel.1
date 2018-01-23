Received: from eggs.gnu.org ([2001:4830:134:3::10]:52351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ee1e1-0004j1-TX
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ee1e0-0006h8-RO
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:41:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ee1e0-0006fD-Iq
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:41:56 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jan 2018 17:40:41 +0100
Message-Id: <20180123164041.30339-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180123164041.30339-1-marcandre.lureau@redhat.com>
References: <20180123164041.30339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 4/4] fw_cfg: write vmcoreinfo details
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

If the "etc/vmcoreinfo" fw_cfg file is present and we are not running
the kdump kernel, write the addr/size of the vmcoreinfo ELF note.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Gabriel Somlo <somlo@cmu.edu>
---
 drivers/firmware/qemu_fw_cfg.c | 83 ++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cf=
g.c
index 686f0e839858..b4904649f316 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -34,6 +34,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
+#include <linux/crash_dump.h>
=20
 MODULE_AUTHOR("Gabriel L. Somlo <somlo@cmu.edu>");
 MODULE_DESCRIPTION("QEMU fw_cfg sysfs support");
@@ -57,6 +58,8 @@ MODULE_LICENSE("GPL");
 /* fw_cfg "file name" is up to 56 characters (including terminating nul)=
 */
 #define FW_CFG_MAX_FILE_PATH 56
=20
+#define VMCOREINFO_FORMAT_ELF 0x1
+
 /* fw_cfg revision attribute, in /sys/firmware/qemu_fw_cfg top-level dir=
. */
 static u32 fw_cfg_rev;
=20
@@ -195,6 +198,47 @@ static ssize_t fw_cfg_read_blob(struct device *dev, =
u16 key,
 	return ret;
 }
=20
+#ifdef CONFIG_CRASH_CORE
+/* write chunk of given fw_cfg blob (caller responsible for sanity-check=
) */
+static ssize_t fw_cfg_write_blob(struct device *dev, u16 key,
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
+		WARN(1, "%s: Failed to lock ACPI!\n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&fw_cfg_dev_lock);
+	if (pos =3D=3D 0) {
+		ret =3D fw_cfg_dma_transfer(dev, buf, count, key << 16
+					  | FW_CFG_DMA_CTL_SELECT
+					  | FW_CFG_DMA_CTL_WRITE);
+	} else {
+		iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
+		ret =3D fw_cfg_dma_transfer(dev, NULL, pos, FW_CFG_DMA_CTL_SKIP);
+		if (ret < 0)
+			goto end;
+		ret =3D fw_cfg_dma_transfer(dev, buf, count, FW_CFG_DMA_CTL_WRITE);
+	}
+
+end:
+	mutex_unlock(&fw_cfg_dev_lock);
+
+	acpi_release_global_lock(glk);
+
+	return ret;
+}
+#endif /* CONFIG_CRASH_CORE */
+
 /* clean up fw_cfg device i/o */
 static void fw_cfg_io_cleanup(void)
 {
@@ -314,6 +358,37 @@ struct fw_cfg_sysfs_entry {
 	struct device *dev;
 };
=20
+#ifdef CONFIG_CRASH_CORE
+static ssize_t write_vmcoreinfo(struct device *dev, const struct fw_cfg_=
file *f)
+{
+	struct vmci {
+		__le16 host_format;
+		__le16 guest_format;
+		__le32 size;
+		__le64 paddr;
+	} __packed;
+	static struct vmci *data;
+	ssize_t ret;
+
+	data =3D kmalloc(sizeof(struct vmci), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	*data =3D (struct vmci) {
+		.guest_format =3D cpu_to_le16(VMCOREINFO_FORMAT_ELF),
+		.size =3D cpu_to_le32(VMCOREINFO_NOTE_SIZE),
+		.paddr =3D cpu_to_le64(paddr_vmcoreinfo_note())
+	};
+	/* spare ourself reading host format support for now since we
+	 * don't know what else to format - host may ignore ours
+	 */
+	ret =3D fw_cfg_write_blob(dev, f->select, data, 0, sizeof(struct vmci))=
;
+
+	kfree(data);
+	return ret;
+}
+#endif /* CONFIG_CRASH_CORE */
+
 /* get fw_cfg_sysfs_entry from kobject member */
 static inline struct fw_cfg_sysfs_entry *to_entry(struct kobject *kobj)
 {
@@ -554,6 +629,14 @@ static int fw_cfg_register_file(struct device *dev, =
const struct fw_cfg_file *f)
 	int err;
 	struct fw_cfg_sysfs_entry *entry;
=20
+#ifdef CONFIG_CRASH_CORE
+	if (fw_cfg_dma_enabled() &&
+		strcmp(f->name, "etc/vmcoreinfo") =3D=3D 0 && !is_kdump_kernel()) {
+		if (write_vmcoreinfo(dev, f) < 0)
+			pr_warn("fw_cfg: failed to write vmcoreinfo");
+	}
+#endif
+
 	/* allocate new entry */
 	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
--=20
2.16.0.rc1.1.gef27df75a1
