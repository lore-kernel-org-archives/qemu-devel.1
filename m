Received: from eggs.gnu.org ([209.51.188.92]:45766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxce-0001tZ-Jn
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcd-0004ih-6b
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:12 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  1 Apr 2019 09:08:51 -0500
Message-Id: <20190401140903.19186-3-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-1-eblake@redhat.com>
References: <20190401140903.19186-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/14] nbd: Tolerate some server non-compliance
 in NBD_CMD_BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

The NBD spec states that NBD_CMD_FLAG_REQ_ONE (which we currently
always use) should not reply with an extent larger than our request,
and that the server's response should be exactly one extent. Right
now, that means that if a server sends more than one extent, we treat
the server as broken, fail the block status request, and disconnect,
which prevents all further use of the block device. But while good
software should be strict in what it sends, it should be tolerant in
what it receives.

While trying to implement NBD_CMD_BLOCK_STATUS in nbdkit, we
temporarily had a non-compliant server sending too many extents in
spite of REQ_ONE. Oddly enough, 'qemu-img convert' with qemu 3.1
failed with a somewhat useful message:
  qemu-img: Protocol error: invalid payload for NBD_REPLY_TYPE_BLOCK_STAT=
US

which then disappeared with commit d8b4bad8, on the grounds that an
error message flagged only at the time of coroutine teardown is
pointless, and instead we should rely on the actual failed API to
report an error - in other words, the 3.1 behavior was masking the
fact that qemu-img was not reporting an error. That has since been
fixed in the previous patch, where qemu-img convert now fails with:
  qemu-img: error while reading block status of sector 0: Invalid argumen=
t

But even that is harsh.  Since we already partially relaxed things in
commit acfd8f7a to tolerate a server that exceeds the cap (although
that change was made prior to the NBD spec actually putting a cap on
the extent length during REQ_ONE - in fact, the NBD spec change was
BECAUSE of the qemu behavior prior to that commit), it's not that much
harder to argue that we should also tolerate a server that sends too
many extents.  But at the same time, it's nice to trace when we are
being tolerant of server non-compliance, in order to help server
writers fix their implementations to be more portable (if they refer
to our traces, rather than just stderr).

Reported-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190323212639.579-3-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 21 ++++++++++++++++-----
 block/trace-events |  1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index bfbaf7ebe94..8fe660b6093 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -240,8 +240,8 @@ static int nbd_parse_offset_hole_payload(NBDStructure=
dReplyChunk *chunk,
 }

 /* nbd_parse_blockstatus_payload
- * support only one extent in reply and only for
- * base:allocation context
+ * Based on our request, we expect only one extent in reply, for the
+ * base:allocation context.
  */
 static int nbd_parse_blockstatus_payload(NBDClientSession *client,
                                          NBDStructuredReplyChunk *chunk,
@@ -250,7 +250,8 @@ static int nbd_parse_blockstatus_payload(NBDClientSes=
sion *client,
 {
     uint32_t context_id;

-    if (chunk->length !=3D sizeof(context_id) + sizeof(*extent)) {
+    /* The server succeeded, so it must have sent [at least] one extent =
*/
+    if (chunk->length < sizeof(context_id) + sizeof(*extent)) {
         error_setg(errp, "Protocol error: invalid payload for "
                          "NBD_REPLY_TYPE_BLOCK_STATUS");
         return -EINVAL;
@@ -276,10 +277,20 @@ static int nbd_parse_blockstatus_payload(NBDClientS=
ession *client,
         return -EINVAL;
     }

-    /* The server is allowed to send us extra information on the final
-     * extent; just clamp it to the length we requested. */
+    /*
+     * We used NBD_CMD_FLAG_REQ_ONE, so the server should not have
+     * sent us any more than one extent, nor should it have included
+     * status beyond our request in that extent. However, it's easy
+     * enough to ignore the server's noncompliance without killing the
+     * connection; just ignore trailing extents, and clamp things to
+     * the length of our request.
+     */
+    if (chunk->length > sizeof(context_id) + sizeof(*extent)) {
+        trace_nbd_parse_blockstatus_compliance("more than one extent");
+    }
     if (extent->length > orig_length) {
         extent->length =3D orig_length;
+        trace_nbd_parse_blockstatus_compliance("extent length too large"=
);
     }

     return 0;
diff --git a/block/trace-events b/block/trace-events
index e6bb5a8f05c..debb25c0ac8 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -157,6 +157,7 @@ nvme_cmd_map_qiov_iov(void *s, int i, void *page, int=
 pages) "s %p iov[%d] %p pa
 iscsi_xcopy(void *src_lun, uint64_t src_off, void *dst_lun, uint64_t dst=
_off, uint64_t bytes, int ret) "src_lun %p offset %"PRIu64" dst_lun %p of=
fset %"PRIu64" bytes %"PRIu64" ret %d"

 # nbd-client.c
+nbd_parse_blockstatus_compliance(const char *err) "ignoring extra data f=
rom non-compliant server: %s"
 nbd_read_reply_entry_fail(int ret, const char *err) "ret =3D %d, err: %s=
"
 nbd_co_request_fail(uint64_t from, uint32_t len, uint64_t handle, uint16=
_t flags, uint16_t type, const char *name, int ret, const char *err) "Req=
uest failed { .from =3D %" PRIu64", .len =3D %" PRIu32 ", .handle =3D %" =
PRIu64 ", .flags =3D 0x%" PRIx16 ", .type =3D %" PRIu16 " (%s) } ret =3D =
%d, err: %s"

--=20
2.20.1
