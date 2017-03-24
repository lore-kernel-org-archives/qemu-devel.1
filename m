Received: from eggs.gnu.org ([2001:4830:134:3::10]:48417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1crPto-000354-0C
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1crPtl-0006vF-E2
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:09:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1crPtl-0006v0-82
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:09:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 24 Mar 2017 14:08:51 +0000
Message-Id: <20170324140854.28134-2-stefanha@redhat.com>
In-Reply-To: <20170324140854.28134-1-stefanha@redhat.com>
References: <20170324140854.28134-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 1/3] trace: Fix backwards mirror_yield
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Eric Blake <eblake@redhat.com>

block/trace-events lists the parameters for mirror_yield
consistently with other mirror events (cnt just after s, like in
mirror_before_sleep; in_flight last, like in mirror_yield_in_flight).
But the callers were passing parameters in the wrong order, leading
to poor trace messages, including type truncation when there are
more than 4G dirty sectors involved.  Broken since its introduction
in commit bd48bde.

While touching this, ensure that all callers use the same type
(uint64_t) for cnt, as a later patch will enable the compiler to do
stricter type-checking.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/mirror.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index ca4baa5..9e2fecc 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -634,7 +634,8 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
             }
 
             if (s->in_flight >= MAX_IN_FLIGHT) {
-                trace_mirror_yield(s, s->in_flight, s->buf_free_count, -1);
+                trace_mirror_yield(s, UINT64_MAX, s->buf_free_count,
+                                   s->in_flight);
                 mirror_wait_for_io(s);
                 continue;
             }
@@ -809,7 +810,7 @@ static void coroutine_fn mirror_run(void *opaque)
             s->common.iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
             if (s->in_flight >= MAX_IN_FLIGHT || s->buf_free_count == 0 ||
                 (cnt == 0 && s->in_flight > 0)) {
-                trace_mirror_yield(s, s->in_flight, s->buf_free_count, cnt);
+                trace_mirror_yield(s, cnt, s->buf_free_count, s->in_flight);
                 mirror_wait_for_io(s);
                 continue;
             } else if (cnt != 0) {
-- 
2.9.3
