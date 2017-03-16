Received: from eggs.gnu.org ([2001:4830:134:3::10]:42718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1coYKz-0007UX-SM
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1coYKw-00044L-FN
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:33:17 -0400
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:43012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1coYKw-00041v-8W
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:33:14 -0400
Received: from player738.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id D3C2C1DC2C
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 17:33:11 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 16 Mar 2017 17:33:05 +0100
Message-ID: <148968198512.5555.1880820193606077571.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: don't try to flush self and avoid QEMU
 hang on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>

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
 hw/9pfs/9p.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 76c9247c777d..e20417fbb0db 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2369,7 +2369,7 @@ static void coroutine_fn v9fs_flush(void *opaque)
             break;
         }
     }
-    if (cancel_pdu) {
+    if (cancel_pdu && cancel_pdu != pdu) {
         cancel_pdu->cancelled = 1;
         /*
          * Wait for pdu to complete.
