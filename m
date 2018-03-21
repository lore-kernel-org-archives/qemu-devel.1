Received: from eggs.gnu.org ([2001:4830:134:3::10]:37328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eybSG-0000fs-Ch
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 06:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eybSF-0003Rb-Le
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 06:58:52 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 21 Mar 2018 11:58:30 +0100
Message-Id: <20180321105830.22412-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] scsi: turn "is this a SCSI device?" into a
 conditional hint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

If the user does not have permissions to send ioctls to the device (due to
SELinux or cgroups, for example), the output can look like

qemu-kvm: -device scsi-block,drive=disk: cannot get SG_IO version number:
  Operation not permitted.  Is this a SCSI device?

but this is confusing because the ioctl was blocked _before_ the device
even received the SG_GET_VERSION_NUM ioctl.  Therefore, for EPERM errors
the suggestion should be eliminated.  To make that simpler, change the
code to use error_append_hint.

Reported-by: Ala Hino <ahino@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c    | 7 ++++---
 hw/scsi/scsi-generic.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 94043ed024..ccc245589a 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2637,9 +2637,10 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
     /* check we are using a driver managing SG_IO (version 3 and after) */
     rc = blk_ioctl(s->qdev.conf.blk, SG_GET_VERSION_NUM, &sg_version);
     if (rc < 0) {
-        error_setg(errp, "cannot get SG_IO version number: %s.  "
-                     "Is this a SCSI device?",
-                     strerror(-rc));
+        error_setg(errp, "cannot get SG_IO version number: %s", strerror(-rc));
+        if (rc != -EPERM) {
+            error_append_hint(errp, "Is this a SCSI device?");
+        }
         return;
     }
     if (sg_version < 30000) {
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 7414fe2d67..b3de5df324 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -500,9 +500,10 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
     /* check we are using a driver managing SG_IO (version 3 and after */
     rc = blk_ioctl(s->conf.blk, SG_GET_VERSION_NUM, &sg_version);
     if (rc < 0) {
-        error_setg(errp, "cannot get SG_IO version number: %s.  "
-                         "Is this a SCSI device?",
-                         strerror(-rc));
+        error_setg(errp, "cannot get SG_IO version number: %s", strerror(-rc));
+        if (rc != -EPERM) {
+            error_append_hint(errp, "Is this a SCSI device?");
+        }
         return;
     }
     if (sg_version < 30000) {
-- 
2.16.2
