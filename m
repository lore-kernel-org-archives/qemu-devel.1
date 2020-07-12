Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF741C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 17:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AD520725
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 17:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AD520725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jug7t-0004qs-Oo
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 13:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jug6P-000398-Nv; Sun, 12 Jul 2020 13:49:25 -0400
Received: from relay.sw.ru ([185.231.240.75]:60382 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jug6N-0001lD-66; Sun, 12 Jul 2020 13:49:24 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jug6B-0005LT-KT; Sun, 12 Jul 2020 20:49:11 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 3/3] scripts/simplebench: add unaligned data case to
 bench_write_req
Date: Sun, 12 Jul 2020 20:49:18 +0300
Message-Id: <1594576158-75884-4-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594576158-75884-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1594576158-75884-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 13:17:17
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a test case with writhing data unaligned to the image clusters.
This case does not involve the COW optimization introduced with the
patch "qcow2: skip writing zero buffers to empty COW areas"
(git commit ID: c8bb23cbdbe32f5).

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 scripts/simplebench/bench_write_req.py | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/scripts/simplebench/bench_write_req.py b/scripts/simplebench/bench_write_req.py
index f758f90..9f3a520 100755
--- a/scripts/simplebench/bench_write_req.py
+++ b/scripts/simplebench/bench_write_req.py
@@ -58,7 +58,7 @@ def bench_write_req(qemu_img, image_name, block_size, block_offset, requests,
     image_name   -- QCOW2 image name to create
     block_size   -- size of a block to write to clusters
     block_offset -- offset of the block in clusters
-    requests     -- number of write requests per cluster
+    requests     -- number of write requests per cluster, customize if zero
     empty_image  -- if not True, fills image with random data
 
     Returns {'seconds': int} on success and {'error': str} on failure.
@@ -83,8 +83,17 @@ def bench_write_req(qemu_img, image_name, block_size, block_offset, requests,
                    f'cluster_size={cluster_size}',
                    image_name, str(image_size)]
 
-    count = requests * int(image_size / cluster_size)
-    step = str(cluster_size)
+    if requests:
+        count = requests * int(image_size / cluster_size)
+        step = str(cluster_size)
+    else:
+        # Create unaligned write requests
+        assert block_size
+        shift = int(block_size * 1.01)
+        count = int((image_size - block_offset) / shift)
+        step = str(shift)
+        depth = ['-d', '2']
+
     offset = str(block_offset)
     cnt = str(count)
     size = []
@@ -95,6 +104,8 @@ def bench_write_req(qemu_img, image_name, block_size, block_offset, requests,
                   '-S', step, '-o', offset, '-f', 'qcow2', image_name]
     if block_size:
         args_bench.extend(size)
+    if not requests:
+        args_bench.extend(depth)
 
     try:
         qemu_img_pipe(*args_create)
@@ -165,6 +176,13 @@ if __name__ == '__main__':
             'requests': 2,
             'empty_image': True
         },
+        {
+            'id': '<unaligned>',
+            'block_size': 104857600,
+            'block_offset': 524288,
+            'requests': 0,
+            'empty_image': False
+        },
     ]
 
     # Test-envs are "columns" in benchmark resulting table, 'id is a caption
-- 
1.8.3.1


