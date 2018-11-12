Received: from eggs.gnu.org ([2001:4830:134:3::10]:59724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfF-0000HL-29
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfE-0006n9-Cj
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:17 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 12 Nov 2018 18:05:51 +0100
Message-Id: <20181112170603.23986-3-kwolf@redhat.com>
In-Reply-To: <20181112170603.23986-1-kwolf@redhat.com>
References: <20181112170603.23986-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/14] blockdev: handle error on block latency
 histogram set error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: zhenwei pi <pizhenwei@bytedance.com>

Function block_latency_histogram_set may return error, but qapi ignore th=
is.
This can be reproduced easily by qmp command:
virsh qemu-monitor-command INSTANCE '{"execute":"x-block-latency-histogra=
m-set",
"arguments":{"device":"drive-virtio-disk1","boundaries":[10,200,40]}}'
In fact this command does not work, but we still get success result.

qmp_x_block_latency_histogram_set is a batch setting API, report error AS=
AP.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index e5b5eb46e2..9310ff3e7c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4413,6 +4413,7 @@ void qmp_x_block_latency_histogram_set(
 {
     BlockBackend *blk =3D blk_by_name(device);
     BlockAcctStats *stats;
+    int ret;
=20
     if (!blk) {
         error_setg(errp, "Device '%s' not found", device);
@@ -4428,21 +4429,33 @@ void qmp_x_block_latency_histogram_set(
     }
=20
     if (has_boundaries || has_boundaries_read) {
-        block_latency_histogram_set(
+        ret =3D block_latency_histogram_set(
             stats, BLOCK_ACCT_READ,
             has_boundaries_read ? boundaries_read : boundaries);
+        if (ret) {
+            error_setg(errp, "Device '%s' set read boundaries fail", dev=
ice);
+            return;
+        }
     }
=20
     if (has_boundaries || has_boundaries_write) {
-        block_latency_histogram_set(
+        ret =3D block_latency_histogram_set(
             stats, BLOCK_ACCT_WRITE,
             has_boundaries_write ? boundaries_write : boundaries);
+        if (ret) {
+            error_setg(errp, "Device '%s' set write boundaries fail", de=
vice);
+            return;
+        }
     }
=20
     if (has_boundaries || has_boundaries_flush) {
-        block_latency_histogram_set(
+        ret =3D block_latency_histogram_set(
             stats, BLOCK_ACCT_FLUSH,
             has_boundaries_flush ? boundaries_flush : boundaries);
+        if (ret) {
+            error_setg(errp, "Device '%s' set flush boundaries fail", de=
vice);
+            return;
+        }
     }
 }
=20
--=20
2.19.1
