Received: from eggs.gnu.org ([2001:4830:134:3::10]:52255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1edwpc-0005lE-RO
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1edwpZ-0007PG-Hv
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:33:36 -0500
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:35154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1edwpZ-0007Cd-5q
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:33:33 -0500
Received: from player698.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 6A601B9C0B
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 12:33:23 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 23 Jan 2018 12:33:17 +0100
Message-ID: <151670719721.7533.6287116389556641300.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: Correctly handle cancelled requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Keno Fischer <keno@juliacomputing.com>

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
[groug, send a zero-sized reply instead of detaching the buffer]
Signed-off-by: Greg Kurz <groug@kaod.org>
---

To be effective, a patch is needed for the 9pnet_virtio driver in Linux as
well:

https://sourceforge.net/p/v9fs/mailman/message/36200555/


Stefano,

As you suggested, the right thing to do is indeed to inform the transport
layer that the request was consumed, even if we don't send a 9p reply to
the client (MST suggested the same for the kernel-side patches I had sent
a month ago on the v9fs-developper list).

So in the end the following patch is not needed:

http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg00175.html

Zeroing the PDU size before pushing it back does job for virtio, and
it seems it will also work for Xen (at least that's my impression
after reading the code in QEMU and Linux). But before merging that,
I'd appreciate an ack from you.

Cheers,

--
Greg
---
 hw/9pfs/9p.c         |   18 ++++++++++++++++++
 hw/9pfs/trace-events |    1 +
 2 files changed, 19 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 909a61139405..73dafffe239f 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -630,6 +630,24 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
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
+        pdu->size = 0;
+        goto out_notify;
+    }
+
     if (len < 0) {
         int err = -len;
         len = 7;
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
