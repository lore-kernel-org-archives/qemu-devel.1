Received: from eggs.gnu.org ([2001:4830:134:3::10]:57695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqKXT-00086J-Ou
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqKXP-0002sZ-Mk
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:13:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44453
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cqKXP-0002sL-GH
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:13:27 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2LE93hp147417
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 10:13:26 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29b50cajqw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 10:13:26 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 21 Mar 2017 14:13:24 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 21 Mar 2017 15:12:59 +0100
In-Reply-To: <1490105580-5008-1-git-send-email-groug@kaod.org>
References: <1490105580-5008-1-git-send-email-groug@kaod.org>
Message-Id: <1490105580-5008-2-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 1/2] 9pfs: don't try to flush self and avoid
 QEMU hang on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

According to the 9P spec [*], when a client wants to cancel a pending I/O
request identified by a given tag (uint16), it must send a Tflush message
and wait for the server to respond with a Rflush message before reusing this
tag for another I/O. The server may still send a completion message for the
I/O if it wasn't actually cancelled but the Rflush message must arrive after
that.

QEMU hence waits for the flushed PDU to complete before sending the Rflush
message back to the client.

If a client sends 'Tflush tag oldtag' and tag == oldtag, QEMU will then
allocate a PDU identified by tag, find it in the PDU list and wait for
this same PDU to complete... i.e. wait for a completion that will never
happen. This causes a tag and ring slot leak in the guest, and a PDU
leak in QEMU, all of them limited by the maximal number of PDUs (128).
But, worse, this causes QEMU to hang on device reset since v9fs_reset()
wants to drain all pending I/O.

This insane behavior is likely to denote a bug in the client, and it would
deserve an Rerror message to be sent back. Unfortunately, the protocol
allows it and requires all flush requests to suceed (only a Tflush response
is expected).

The only option is to detect when we have to handle a self-referencing
flush request and report success to the client right away.

[*] http://man.cat-v.org/plan_9/5/flush

Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 76c9247c777d..b8c0b993580c 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2353,7 +2353,7 @@ static void coroutine_fn v9fs_flush(void *opaque)
     ssize_t err;
     int16_t tag;
     size_t offset = 7;
-    V9fsPDU *cancel_pdu;
+    V9fsPDU *cancel_pdu = NULL;
     V9fsPDU *pdu = opaque;
     V9fsState *s = pdu->s;
 
@@ -2364,9 +2364,13 @@ static void coroutine_fn v9fs_flush(void *opaque)
     }
     trace_v9fs_flush(pdu->tag, pdu->id, tag);
 
-    QLIST_FOREACH(cancel_pdu, &s->active_list, next) {
-        if (cancel_pdu->tag == tag) {
-            break;
+    if (pdu->tag == tag) {
+        error_report("Warning: the guest sent a self-referencing 9P flush request");
+    } else {
+        QLIST_FOREACH(cancel_pdu, &s->active_list, next) {
+            if (cancel_pdu->tag == tag) {
+                break;
+            }
         }
     }
     if (cancel_pdu) {
-- 
2.7.4
