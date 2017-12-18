Received: from eggs.gnu.org ([2001:4830:134:3::10]:48796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQsrd-0003Bs-Np
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQsrY-0002i3-QJ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:41:41 -0500
Received: from 17.mo1.mail-out.ovh.net ([87.98.179.142]:59409)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQsrY-0002fG-FX
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:41:36 -0500
Received: from player691.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id B8998B253A
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 11:41:34 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 18 Dec 2017 11:41:31 +0100
Message-ID: <151359369131.6820.6589067560403425412.stgit@bahia.lan>
In-Reply-To: <151359366858.6820.6567549632253797169.stgit@bahia.lan>
References: <151359366858.6820.6567549632253797169.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 2/2] 9pfs: Correctly handle cancelled
 requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>, keno@juliacomputing.com

From: Keno Fischer <keno@juliacomputing.com>

# Background

I was investigating spurious non-deterministic EINTR returns from
various 9p file system operations in a Linux guest served from the
qemu 9p server.

 ## EINTR, ERESTARTSYS and the linux kernel

When a signal arrives that the Linux kernel needs to deliver to user-space
while a given thread is blocked (in the 9p case waiting for a reply to its
request in 9p_client_rpc -> wait_event_interruptible), it asks whatever
driver is currently running to abort its current operation (in the 9p case
causing the submission of a TFLUSH message) and return to user space.
In these situations, the error message reported is generally ERESTARTSYS.
If the userspace processes specified SA_RESTART, this means that the
system call will get restarted upon completion of the signal handler
delivery (assuming the signal handler doesn't modify the process state
in complicated ways not relevant here). If SA_RESTART is not specified,
ERESTARTSYS gets translated to EINTR and user space is expected to handle
the restart itself.

 ## The 9p TFLUSH command

The 9p TFLUSH commands requests that the server abort an ongoing operation.
The man page [1] specifies:

```
If it recognizes oldtag as the tag of a pending transaction, it should abort any
pending response and discard that tag.
[...]
When the client sends a Tflush, it must wait to receive the corresponding Rflush
before reusing oldtag for subsequent messages. If a response to the flushed request
is received before the Rflush, the client must honor the response as if it had not
been flushed, since the completed request may signify a state change in the server
```

In particular, this means that the server must not send a reply with the orignal
tag in response to the cancellation request, because the client is obligated
to interpret such a reply as a coincidental reply to the original request.

 # The bug

When qemu receives a TFlush request, it sets the `cancelled` flag on the relevant
pdu. This flag is periodically checked, e.g. in `v9fs_co_name_to_path`, and if
set, the operation is aborted and the error is set to EINTR. However, the server
then violates the spec, by returning to the client an Rerror response, rather
than discarding the message entirely. As a result, the client is required
to assume that said Rerror response is a result of the original request, not
a result of the cancellation and thus passes the EINTR error back to user space.
This is not the worst thing it could do, however as discussed above, the correct
error code would have been ERESTARTSYS, such that user space programs with
SA_RESTART set get correctly restarted upon completion of the signal handler.
Instead, such programs get spurious EINTR results that they were not expecting
to handle.

It should be noted that there are plenty of user space programs that do not
set SA_RESTART and do not correctly handle EINTR either. However, that is then
a userspace bug. It should also be noted that this bug has been mitigated by
a recent commit to the Linux kernel [2], which essentially prevents the kernel
from sending Tflush requests unless the process is about to die (in which case
the process likely doesn't care about the response). Nevertheless, for older
kernels and to comply with the spec, I believe this change is beneficial.

 # Implementation

The fix is fairly simple, just skipping notification of a reply if
the pdu was previously cancelled. We do however, also notify the transport
layer that we're doing this, so it can clean up any resources it may be
holding. I also added a new trace event to distinguish
operations that caused an error reply from those that were cancelled.

One complication is that we only omit sending the message on EINTR errors in
order to avoid confusing the rest of the code (which may assume that a
client knows about a fid if it sucessfully passed it off to pud_complete
without checking for cancellation status). This does mean that if the server
acts upon the cancellation flag, it always needs to set err to EINTR. I believe
this is true of the current code.

[1] https://9fans.github.io/plan9port/man/man9/flush.html
[2] https://github.com/torvalds/linux/commit/9523feac272ccad2ad8186ba4fcc89103754de52

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
[groug, use new pdu_complete transport API]
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c         |   19 ++++++++++++++++++-
 hw/9pfs/trace-events |    1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index dd8b7c6d69c6..ccbc75265a52 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -630,6 +630,23 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
     V9fsState *s = pdu->s;
     int ret;
 
+    /*
+     * The 9p spec requires that successfully cancelled pdus receive no reply.
+     * Sending a reply would confuse clients because they would
+     * assume that any EINTR is the actual result of the operation,
+     * rather than a consequence of the cancellation. However, if
+     * the operation completed (succesfully or with an error other
+     * than caused be cancellation), we do send out that reply, both
+     * for efficiency and to avoid confusing the rest of the state machine
+     * that assumes passing a non-error here will mean a successful
+     * transmission of the reply.
+     */
+    bool discard = pdu->cancelled && len == -EINTR;
+    if (discard) {
+        trace_v9fs_rcancel(pdu->tag, pdu->id);
+        goto out_complete;
+    }
+
     if (len < 0) {
         int err = -len;
         len = 7;
@@ -670,7 +687,7 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
     pdu->id = id;
 
 out_complete:
-    pdu->s->transport->pdu_complete(pdu, false);
+    pdu->s->transport->pdu_complete(pdu, discard);
 
     /* Now wakeup anybody waiting in flush for this request */
     if (!qemu_co_queue_next(&pdu->complete)) {
diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events
index 08a4abf22ea4..1aee350c42f1 100644
--- a/hw/9pfs/trace-events
+++ b/hw/9pfs/trace-events
@@ -1,6 +1,7 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # hw/9pfs/virtio-9p.c
+v9fs_rcancel(uint16_t tag, uint8_t id) "tag %d id %d"
 v9fs_rerror(uint16_t tag, uint8_t id, int err) "tag %d id %d err %d"
 v9fs_version(uint16_t tag, uint8_t id, int32_t msize, char* version) "tag %d id %d msize %d version %s"
 v9fs_version_return(uint16_t tag, uint8_t id, int32_t msize, char* version) "tag %d id %d msize %d version %s"
