Received: from eggs.gnu.org ([2001:4830:134:3::10]:41375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYU-00079P-Nl
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYQ-0004A4-NM
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:26 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYQ-00047a-H0
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:22 -0500
Received: by mail-wm0-x243.google.com with SMTP id r78so11276327wme.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:25 +0100
Message-Id: <1515756676-3860-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/52] scsi-generic: Add share-rw option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Add the property to the device model, then parse it by calling
blkconf_apply_backend_options().

In addition to blk_set_perm(), the called function also handles error
options and wce. For error options we've already checked that the
default values are used, for wce we don't have the option either so it
is always the default (true). In other words there is no change of
behavior in these regards.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20171205151553.7834-1-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index bd0d9ff..ba70c0d 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -482,6 +482,7 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
     int rc;
     int sg_version;
     struct sg_scsi_id scsiid;
+    Error *local_err = NULL;
 
     if (!s->conf.blk) {
         error_setg(errp, "drive property not set");
@@ -515,6 +516,13 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
         error_setg(errp, "SG_GET_SCSI_ID ioctl failed");
         return;
     }
+    blkconf_apply_backend_options(&s->conf,
+                                  blk_is_read_only(s->conf.blk),
+                                  true, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     /* define device state */
     s->type = scsiid.scsi_type;
@@ -565,6 +573,7 @@ static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
 
 static Property scsi_generic_properties[] = {
     DEFINE_PROP_DRIVE("drive", SCSIDevice, conf.blk),
+    DEFINE_PROP_BOOL("share-rw", SCSIDevice, conf.share_rw, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
1.8.3.1
