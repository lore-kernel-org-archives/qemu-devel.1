Received: from eggs.gnu.org ([2001:4830:134:3::10]:54036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eMEyF-0001Pq-01
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eMEx9-00010u-3p
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:17:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eMEx8-0000zS-6S
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:16:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C38D4693D6
	for <qemu-devel@nongnu.org>; Tue,  5 Dec 2017 15:16:08 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  5 Dec 2017 23:15:53 +0800
Message-Id: <20171205151553.7834-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] scsi-generic: Add share-rw option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, famz@redhat.com

Add the property to the device model, then parse it by calling
blkconf_apply_backend_options().

In addition to blk_set_perm(), the called function also handles error
options and wce. For error options we've already checked that the
default values are used, for wce we don't have the option either so it
is always the default (true). In other words there is no change of
behavior in these regards.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/scsi/scsi-generic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index bd0d9ff355..ba70c0dc19 100644
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
2.14.3
