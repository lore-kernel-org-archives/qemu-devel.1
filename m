Received: from eggs.gnu.org ([2001:4830:134:3::10]:57245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJ6-0006ee-FO
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SJ5-00071e-IV
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:04 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:45504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f0SJ5-00071I-C1
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:03 -0400
Received: by mail-wr0-x22b.google.com with SMTP id u11so6645037wri.12
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:37:03 -0700 (PDT)
Received: from 640k.lan (94-36-194-48.adsl-ull.clienti.tiscali.it.
	[94.36.194.48]) by smtp.gmail.com with ESMTPSA id
	g186sm6710105wmd.41.2018.03.26.06.37.00 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 26 Mar 2018 06:37:01 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Mar 2018 15:36:40 +0200
Message-Id: <1522071403-52486-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
References: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/16] scsi: turn "is this a SCSI device?" into
 a conditional hint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If the user does not have permissions to send ioctls to the device (due to
SELinux or cgroups, for example), the output can look like

qemu-kvm: -device scsi-block,drive=disk: cannot get SG_IO version number:
  Operation not permitted.  Is this a SCSI device?

but this is confusing because the ioctl was blocked _before_ the device
even received the SG_GET_VERSION_NUM ioctl.  Therefore, for EPERM errors
the suggestion should be eliminated.  To make that simpler, change the
code to use error_append_hint.

Reported-by: Ala Hino <ahino@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c    | 7 ++++---
 hw/scsi/scsi-generic.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 5b7a48f..f5ab767 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2607,9 +2607,10 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
     /* check we are using a driver managing SG_IO (version 3 and after) */
     rc = blk_ioctl(s->qdev.conf.blk, SG_GET_VERSION_NUM, &sg_version);
     if (rc < 0) {
-        error_setg(errp, "cannot get SG_IO version number: %s.  "
-                     "Is this a SCSI device?",
-                     strerror(-rc));
+        error_setg_errno(errp, -rc, "cannot get SG_IO version number");
+        if (rc != -EPERM) {
+            error_append_hint(errp, "Is this a SCSI device?\n");
+        }
         return;
     }
     if (sg_version < 30000) {
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 7414fe2..4753f87 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -500,9 +500,10 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
     /* check we are using a driver managing SG_IO (version 3 and after */
     rc = blk_ioctl(s->conf.blk, SG_GET_VERSION_NUM, &sg_version);
     if (rc < 0) {
-        error_setg(errp, "cannot get SG_IO version number: %s.  "
-                         "Is this a SCSI device?",
-                         strerror(-rc));
+        error_setg_errno(errp, -rc, "cannot get SG_IO version number");
+        if (rc != -EPERM) {
+            error_append_hint(errp, "Is this a SCSI device?\n");
+        }
         return;
     }
     if (sg_version < 30000) {
-- 
1.8.3.1
