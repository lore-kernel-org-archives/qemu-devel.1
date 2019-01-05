Received: from eggsout.gnu.org ([209.51.188.92]:56543 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfmVs-0003qW-4b
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 09:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfmVn-0007ib-Oy
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 09:01:19 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat,  5 Jan 2019 08:00:55 -0600
Message-Id: <20190105140100.26913-4-eblake@redhat.com>
In-Reply-To: <20190105140100.26913-1-eblake@redhat.com>
References: <20190105140100.26913-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/8] block/nbd-client: use traces instead of
 noisy error_report_err
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reduce extra noise of nbd-client, change 083 correspondingly.

In various commits (be41c100 in 2.10, f140e300 in 2.11, 78a33ab
in 2.12), we added spots where qemu as an NBD client would report
problems communicating with the server to stderr, because there
was no where else to send the error to.  However, this is racy,
particularly since the most common source of these errors is when
either the client or the server abruptly hangs up, leaving one
coroutine to report the error only if it wins (or loses) the
race in attempting the read from the server before another
thread completes its cleanup of a protocol error that caused the
disconnect in the first place.  The race is also apparent in the
fact that differences in the flush behavior of the server can
alter the frequency of encountering the race in the client (see
commit 6d39db96).

Rather than polluting stderr, it's better to just trace these
situations, for use by developers debugging a flaky connection,
particularly since the real error that either triggers the abrupt
disconnection in the first place, or that results from the EIO
when a request can't receive a reply, DOES make it back to the
user in the normal Error propagation channels.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20181102151152.288399-4-vsementsov@virtuozzo.com>
[eblake: drop depedence on error hint, enhance commit message]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c         | 23 +++++++++++++++++++----
 block/trace-events         |  4 ++++
 tests/qemu-iotests/083.out | 28 ----------------------------
 3 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index fc5b7eda8ee..ef320759716 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -28,6 +28,8 @@
  */

 #include "qemu/osdep.h"
+
+#include "trace.h"
 #include "qapi/error.h"
 #include "nbd-client.h"

@@ -79,7 +81,8 @@ static coroutine_fn void nbd_read_reply_entry(void *opa=
que)
         assert(s->reply.handle =3D=3D 0);
         ret =3D nbd_receive_reply(s->ioc, &s->reply, &local_err);
         if (local_err) {
-            error_report_err(local_err);
+            trace_nbd_read_reply_entry_fail(ret, error_get_pretty(local_=
err));
+            error_free(local_err);
         }
         if (ret <=3D 0) {
             break;
@@ -771,7 +774,11 @@ static int nbd_co_request(BlockDriverState *bs, NBDR=
equest *request,

     ret =3D nbd_co_receive_return_code(client, request->handle, &local_e=
rr);
     if (local_err) {
-        error_report_err(local_err);
+        trace_nbd_co_request_fail(request->from, request->len, request->=
handle,
+                                  request->flags, request->type,
+                                  nbd_cmd_lookup(request->type),
+                                  ret, error_get_pretty(local_err));
+        error_free(local_err);
     }
     return ret;
 }
@@ -802,7 +809,11 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint6=
4_t offset,
     ret =3D nbd_co_receive_cmdread_reply(client, request.handle, offset,=
 qiov,
                                        &local_err);
     if (local_err) {
-        error_report_err(local_err);
+        trace_nbd_co_request_fail(request.from, request.len, request.han=
dle,
+                                  request.flags, request.type,
+                                  nbd_cmd_lookup(request.type),
+                                  ret, error_get_pretty(local_err));
+        error_free(local_err);
     }
     return ret;
 }
@@ -925,7 +936,11 @@ int coroutine_fn nbd_client_co_block_status(BlockDri=
verState *bs,
     ret =3D nbd_co_receive_blockstatus_reply(client, request.handle, byt=
es,
                                            &extent, &local_err);
     if (local_err) {
-        error_report_err(local_err);
+        trace_nbd_co_request_fail(request.from, request.len, request.han=
dle,
+                                  request.flags, request.type,
+                                  nbd_cmd_lookup(request.type),
+                                  ret, error_get_pretty(local_err));
+        error_free(local_err);
     }
     if (ret < 0) {
         return ret;
diff --git a/block/trace-events b/block/trace-events
index 3e8c47bb243..693c14c4435 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -156,3 +156,7 @@ nvme_cmd_map_qiov_iov(void *s, int i, void *page, int=
 pages) "s %p iov[%d] %p pa

 # block/iscsi.c
 iscsi_xcopy(void *src_lun, uint64_t src_off, void *dst_lun, uint64_t dst=
_off, uint64_t bytes, int ret) "src_lun %p offset %"PRIu64" dst_lun %p of=
fset %"PRIu64" bytes %"PRIu64" ret %d"
+
+# block/nbd-client.c
+nbd_read_reply_entry_fail(int ret, const char *err) "ret =3D %d, err: %s=
"
+nbd_co_request_fail(uint64_t from, uint32_t len, uint64_t handle, uint16=
_t flags, uint16_t type, const char *name, int ret, const char *err) "Req=
uest failed { .from =3D %" PRIu64", .len =3D %" PRIu32 ", .handle =3D %" =
PRIu64 ", .flags =3D 0x%" PRIx16 ", .type =3D %" PRIu16 " (%s) } ret =3D =
%d, err: %s"
diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
index f9af8bb6918..7419722cd7a 100644
--- a/tests/qemu-iotests/083.out
+++ b/tests/qemu-iotests/083.out
@@ -41,8 +41,6 @@ can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect after neg2 =3D=3D=3D

-Unable to read from socket: Connection reset by peer
-Connection closed
 read failed: Input/output error

 =3D=3D=3D Check disconnect 8 neg2 =3D=3D=3D
@@ -55,40 +53,30 @@ can't open device nbd+tcp://127.0.0.1:PORT/foo

 =3D=3D=3D Check disconnect before request =3D=3D=3D

-Unable to read from socket: Connection reset by peer
-Connection closed
 read failed: Input/output error

 =3D=3D=3D Check disconnect after request =3D=3D=3D

-Connection closed
 read failed: Input/output error

 =3D=3D=3D Check disconnect before reply =3D=3D=3D

-Connection closed
 read failed: Input/output error

 =3D=3D=3D Check disconnect after reply =3D=3D=3D

-Unexpected end-of-file before all bytes were read
 read failed: Input/output error

 =3D=3D=3D Check disconnect 4 reply =3D=3D=3D

-Unexpected end-of-file before all bytes were read
-Connection closed
 read failed: Input/output error

 =3D=3D=3D Check disconnect 8 reply =3D=3D=3D

-Unexpected end-of-file before all bytes were read
-Connection closed
 read failed: Input/output error

 =3D=3D=3D Check disconnect before data =3D=3D=3D

-Unexpected end-of-file before all bytes were read
 read failed: Input/output error

 =3D=3D=3D Check disconnect after data =3D=3D=3D
@@ -118,8 +106,6 @@ can't open device nbd+tcp://127.0.0.1:PORT/

 =3D=3D=3D Check disconnect after neg-classic =3D=3D=3D

-Unable to read from socket: Connection reset by peer
-Connection closed
 read failed: Input/output error

 =3D=3D=3D Check disconnect before neg1 =3D=3D=3D
@@ -164,8 +150,6 @@ can't open device nbd+unix:///foo?socket=3DTEST_DIR/n=
bd.sock

 =3D=3D=3D Check disconnect after neg2 =3D=3D=3D

-Unable to read from socket: Connection reset by peer
-Connection closed
 read failed: Input/output error

 =3D=3D=3D Check disconnect 8 neg2 =3D=3D=3D
@@ -178,40 +162,30 @@ can't open device nbd+unix:///foo?socket=3DTEST_DIR=
/nbd.sock

 =3D=3D=3D Check disconnect before request =3D=3D=3D

-Unable to read from socket: Connection reset by peer
-Connection closed
 read failed: Input/output error

 =3D=3D=3D Check disconnect after request =3D=3D=3D

-Connection closed
 read failed: Input/output error

 =3D=3D=3D Check disconnect before reply =3D=3D=3D

-Connection closed
 read failed: Input/output error

 =3D=3D=3D Check disconnect after reply =3D=3D=3D

-Unexpected end-of-file before all bytes were read
 read failed: Input/output error

 =3D=3D=3D Check disconnect 4 reply =3D=3D=3D

-Unexpected end-of-file before all bytes were read
-Connection closed
 read failed: Input/output error

 =3D=3D=3D Check disconnect 8 reply =3D=3D=3D

-Unexpected end-of-file before all bytes were read
-Connection closed
 read failed: Input/output error

 =3D=3D=3D Check disconnect before data =3D=3D=3D

-Unexpected end-of-file before all bytes were read
 read failed: Input/output error

 =3D=3D=3D Check disconnect after data =3D=3D=3D
@@ -241,8 +215,6 @@ can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.=
sock

 =3D=3D=3D Check disconnect after neg-classic =3D=3D=3D

-Unable to read from socket: Connection reset by peer
-Connection closed
 read failed: Input/output error

 *** done
--=20
2.20.1
