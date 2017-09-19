Received: from eggs.gnu.org ([2001:4830:134:3::10]:40763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duHAq-0007Vw-5q
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duHAn-00025r-5X
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:58:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duHAn-00025c-0V
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:58:41 -0400
From: marcandre.lureau@redhat.com
Date: Tue, 19 Sep 2017 13:58:14 +0200
Message-Id: <20170919115814.14724-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170919115814.14724-1-marcandre.lureau@redhat.com>
References: <20170919115814.14724-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/4] RFC: fw_cfg: add DMA write operation in
 sysfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: somlo@cmu.edu, qemu-devel@nongnu.org, mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Since qemu 2.9, DMA write operations are allowed. However, usage of this
interface from kernel or user-space is strongly discouraged by the
maintainers. This patch is meant for experimentations for now.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 drivers/firmware/qemu_fw_cfg.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cf=
g.c
index 26152bfc7805..1ca3382e98df 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -524,9 +524,28 @@ static ssize_t fw_cfg_sysfs_read_raw(struct file *fi=
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
+	if (pos > entry->f.size)
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
+	.attr =3D { .name =3D "raw", .mode =3D S_IRUSR | S_IWUSR },
 	.read =3D fw_cfg_sysfs_read_raw,
+	.write =3D fw_cfg_sysfs_write_raw,
 };
=20
 /*
--=20
2.14.1.146.gd35faa819
