Received: from eggs.gnu.org ([2001:4830:134:3::10]:44516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimS8-0004KK-78
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimS4-0004to-AJ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:20 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimS4-0004tT-2u
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:16 -0500
Received: by mail-wm0-x242.google.com with SMTP id f3so28128817wmc.1
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:22 +0100
Message-Id: <1517858941-5538-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/47] scsi-generic: Simplify error handling code
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

Coverity doesn't like the ignored return value introduced in
9d3b155186c278 (hw/block: Fix the return type), and other callers are
converted already in ceff3e1f01.

This one was added lately in d9bcd6f7f23a and missed the train. Do it
now.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180118025245.13042-1-famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index ba70c0d..7414fe2 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -482,7 +482,6 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
     int rc;
     int sg_version;
     struct sg_scsi_id scsiid;
-    Error *local_err = NULL;
 
     if (!s->conf.blk) {
         error_setg(errp, "drive property not set");
@@ -516,11 +515,9 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
         error_setg(errp, "SG_GET_SCSI_ID ioctl failed");
         return;
     }
-    blkconf_apply_backend_options(&s->conf,
-                                  blk_is_read_only(s->conf.blk),
-                                  true, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!blkconf_apply_backend_options(&s->conf,
+                                       blk_is_read_only(s->conf.blk),
+                                       true, errp)) {
         return;
     }
 
-- 
1.8.3.1
