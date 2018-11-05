Received: from eggs.gnu.org ([2001:4830:134:3::10]:39624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pizhenwei@bytedance.com>) id 1gJVCX-0002om-Uc
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 22:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pizhenwei@bytedance.com>) id 1gJVCU-0007iZ-2r
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 22:05:17 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pizhenwei@bytedance.com>)
	id 1gJVCT-0007hp-QE
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 22:05:13 -0500
Received: by mail-pl1-x642.google.com with SMTP id s5-v6so3687159plq.11
	for <qemu-devel@nongnu.org>; Sun, 04 Nov 2018 19:05:12 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
Date: Mon,  5 Nov 2018 11:04:56 +0800
Message-Id: <1541387096-19513-1-git-send-email-pizhenwei@bytedance.com>
Subject: [Qemu-devel] [PATCH] blockdev: handle error on block latency
 histogram set error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com
Cc: pizhenwei@bytedance.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

Function block_latency_histogram_set may return error, but qapi ignore this.
This can be reproduced easily by qmp command:
virsh qemu-monitor-command INSTANCE '{"execute":"x-block-latency-histogram-set",
"arguments":{"device":"drive-virtio-disk1","boundaries":[10,200,40]}}'
In fact this command does not work, but we still get success result.

qmp_x_block_latency_histogram_set is a batch setting API, report error ASAP.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 blockdev.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index a8755bd..03b1aa3 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -4377,6 +4377,7 @@ void qmp_x_block_latency_histogram_set(
 {
     BlockBackend *blk = blk_by_name(device);
     BlockAcctStats *stats;
+    int ret;
 
     if (!blk) {
         error_setg(errp, "Device '%s' not found", device);
@@ -4392,21 +4393,33 @@ void qmp_x_block_latency_histogram_set(
     }
 
     if (has_boundaries || has_boundaries_read) {
-        block_latency_histogram_set(
+        ret = block_latency_histogram_set(
             stats, BLOCK_ACCT_READ,
             has_boundaries_read ? boundaries_read : boundaries);
+        if (ret) {
+            error_setg(errp, "Device '%s' set read boundaries fail", device);
+            return;
+        }
     }
 
     if (has_boundaries || has_boundaries_write) {
-        block_latency_histogram_set(
+        ret = block_latency_histogram_set(
             stats, BLOCK_ACCT_WRITE,
             has_boundaries_write ? boundaries_write : boundaries);
+        if (ret) {
+            error_setg(errp, "Device '%s' set write boundaries fail", device);
+            return;
+        }
     }
 
     if (has_boundaries || has_boundaries_flush) {
-        block_latency_histogram_set(
+        ret = block_latency_histogram_set(
             stats, BLOCK_ACCT_FLUSH,
             has_boundaries_flush ? boundaries_flush : boundaries);
+        if (ret) {
+            error_setg(errp, "Device '%s' set flush boundaries fail", device);
+            return;
+        }
     }
 }
 
-- 
2.7.4
