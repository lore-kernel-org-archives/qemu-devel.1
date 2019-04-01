Received: from eggs.gnu.org ([209.51.188.92]:46032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcv-0002FD-Qq
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAxcs-00050l-5Z
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:09:27 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  1 Apr 2019 09:09:03 -0500
Message-Id: <20190401140903.19186-15-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-1-eblake@redhat.com>
References: <20190401140903.19186-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/14] nbd/client: Trace server noncompliance on
 structured reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Just as we recently added a trace for a server sending block status
that doesn't match the server's advertised minimum block alignment,
let's do the same for read chunks.  But since qemu 3.1 is such a
server (because it advertised 512-byte alignment, but when serving a
file that ends in data but is not sector-aligned, NBD_CMD_READ would
detect a mid-sector change between data and hole at EOF and the
resulting read chunks are unaligned), we don't want to change our
behavior of otherwise tolerating unaligned reads.

Note that even though we fixed the server for 4.0 to advertise an
actual block alignment (which gets rid of the unaligned reads at EOF
for posix files), we can still trigger it via other means:

$ qemu-nbd --image-opts driver=3Dblkdebug,align=3D512,image.driver=3Dfile=
,image.filename=3D/path/to/non-aligned-file

Arguably, that is a bug in the blkdebug block status function, for
leaking a block status that is not aligned. It may also be possible to
observe issues with a backing layer with smaller alignment than the
active layer, although so far I have been unable to write a reliable
iotest for that scenario.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190330165349.32256-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 12 ++++++++++--
 block/trace-events |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 409c2171bc3..790ecc1ee1c 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -211,7 +211,8 @@ static inline uint64_t payload_advance64(uint8_t **pa=
yload)
     return ldq_be_p(*payload - 8);
 }

-static int nbd_parse_offset_hole_payload(NBDStructuredReplyChunk *chunk,
+static int nbd_parse_offset_hole_payload(NBDClientSession *client,
+                                         NBDStructuredReplyChunk *chunk,
                                          uint8_t *payload, uint64_t orig=
_offset,
                                          QEMUIOVector *qiov, Error **err=
p)
 {
@@ -233,6 +234,10 @@ static int nbd_parse_offset_hole_payload(NBDStructur=
edReplyChunk *chunk,
                          " region");
         return -EINVAL;
     }
+    if (client->info.min_block &&
+        !QEMU_IS_ALIGNED(hole_size, client->info.min_block)) {
+        trace_nbd_structured_read_compliance("hole");
+    }

     qemu_iovec_memset(qiov, offset - orig_offset, 0, hole_size);

@@ -390,6 +395,9 @@ static int nbd_co_receive_offset_data_payload(NBDClie=
ntSession *s,
                          " region");
         return -EINVAL;
     }
+    if (s->info.min_block && !QEMU_IS_ALIGNED(data_size, s->info.min_blo=
ck)) {
+        trace_nbd_structured_read_compliance("data");
+    }

     qemu_iovec_init(&sub_qiov, qiov->niov);
     qemu_iovec_concat(&sub_qiov, qiov, offset - orig_offset, data_size);
@@ -712,7 +720,7 @@ static int nbd_co_receive_cmdread_reply(NBDClientSess=
ion *s, uint64_t handle,
              * in qiov */
             break;
         case NBD_REPLY_TYPE_OFFSET_HOLE:
-            ret =3D nbd_parse_offset_hole_payload(&reply.structured, pay=
load,
+            ret =3D nbd_parse_offset_hole_payload(s, &reply.structured, =
payload,
                                                 offset, qiov, &local_err=
);
             if (ret < 0) {
                 s->quit =3D true;
diff --git a/block/trace-events b/block/trace-events
index debb25c0ac8..7335a425404 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -158,6 +158,7 @@ iscsi_xcopy(void *src_lun, uint64_t src_off, void *ds=
t_lun, uint64_t dst_off, ui

 # nbd-client.c
 nbd_parse_blockstatus_compliance(const char *err) "ignoring extra data f=
rom non-compliant server: %s"
+nbd_structured_read_compliance(const char *type) "server sent non-compli=
ant unaligned read %s chunk"
 nbd_read_reply_entry_fail(int ret, const char *err) "ret =3D %d, err: %s=
"
 nbd_co_request_fail(uint64_t from, uint32_t len, uint64_t handle, uint16=
_t flags, uint16_t type, const char *name, int ret, const char *err) "Req=
uest failed { .from =3D %" PRIu64", .len =3D %" PRIu32 ", .handle =3D %" =
PRIu64 ", .flags =3D 0x%" PRIx16 ", .type =3D %" PRIu16 " (%s) } ret =3D =
%d, err: %s"

--=20
2.20.1
