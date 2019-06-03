Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9910AC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6124D251B3
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6124D251B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34331 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXlwB-0002DM-89
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 08:19:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXlqV-00067O-4t
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXldW-0001in-MO
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:00:25 -0400
Received: from relay.sw.ru ([185.231.240.75]:39512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hXldU-000129-CF; Mon, 03 Jun 2019 08:00:20 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hXldH-0002hc-7u; Mon, 03 Jun 2019 15:00:07 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 15:00:05 +0300
Message-Id: <20190603120005.37394-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190603120005.37394-1-vsementsov@virtuozzo.com>
References: <20190603120005.37394-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 4/4] iotests: test bitmap moving inside 254
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
	armbru@redhat.com, mreitz@redhat.com,
	nshirokovskiy@virtuozzo.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test persistent bitmap copying with and without removal of original
bitmap.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/254     | 30 +++++++++++++-
 tests/qemu-iotests/254.out | 82 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/254 b/tests/qemu-iotests/254
index 33cb80a512..05afc6d6f1 100755
--- a/tests/qemu-iotests/254
+++ b/tests/qemu-iotests/254
@@ -1,6 +1,6 @@
 #!/usr/bin/env python
 #
-# Test external snapshot with bitmap copying.
+# Test external snapshot with bitmap copying and moving.
 #
 # Copyright (c) 2019 Virtuozzo International GmbH. All rights reserved.
 #
@@ -30,6 +30,10 @@ vm = iotests.VM().add_drive(disk, opts='node-name=base')
 vm.launch()
 
 vm.qmp_log('block-dirty-bitmap-add', node='drive0', name='bitmap0')
+vm.qmp_log('block-dirty-bitmap-add', node='drive0', name='bitmap1',
+           persistent=True)
+vm.qmp_log('block-dirty-bitmap-add', node='drive0', name='bitmap2',
+           persistent=True)
 
 vm.hmp_qemu_io('drive0', 'write 0 512K')
 
@@ -37,16 +41,38 @@ vm.qmp_log('transaction', indent=2, actions=[
     {'type': 'blockdev-snapshot-sync',
      'data': {'device': 'drive0', 'snapshot-file': top,
               'snapshot-node-name': 'snap'}},
+
+    # copy non-persistent bitmap0
     {'type': 'block-dirty-bitmap-add',
      'data': {'node': 'snap', 'name': 'bitmap0'}},
     {'type': 'block-dirty-bitmap-merge',
      'data': {'node': 'snap', 'target': 'bitmap0',
-              'bitmaps': [{'node': 'base', 'name': 'bitmap0'}]}}
+              'bitmaps': [{'node': 'base', 'name': 'bitmap0'}]}},
+
+    # copy persistent bitmap1, original will be saved to base image
+    {'type': 'block-dirty-bitmap-add',
+     'data': {'node': 'snap', 'name': 'bitmap1', 'persistent': True}},
+    {'type': 'block-dirty-bitmap-merge',
+     'data': {'node': 'snap', 'target': 'bitmap1',
+              'bitmaps': [{'node': 'base', 'name': 'bitmap1'}]}},
+
+    # move persistent bitmap1, original will be removed and not saved
+    # to base image
+    {'type': 'block-dirty-bitmap-add',
+     'data': {'node': 'snap', 'name': 'bitmap2', 'persistent': True}},
+    {'type': 'block-dirty-bitmap-merge',
+     'data': {'node': 'snap', 'target': 'bitmap2',
+              'bitmaps': [{'node': 'base', 'name': 'bitmap2'}]}},
+    {'type': 'block-dirty-bitmap-remove',
+     'data': {'node': 'base', 'name': 'bitmap2'}}
 ], filters=[iotests.filter_qmp_testfiles])
 
 result = vm.qmp('query-block')['return'][0]
 log("query-block: device = {}, node-name = {}, dirty-bitmaps:".format(
     result['device'], result['inserted']['node-name']))
 log(result['dirty-bitmaps'], indent=2)
+log("\nbitmaps in backing image:")
+log(result['inserted']['image']['backing-image']['format-specific'] \
+    ['data']['bitmaps'], indent=2)
 
 vm.shutdown()
diff --git a/tests/qemu-iotests/254.out b/tests/qemu-iotests/254.out
index d7394cf002..d185c0532f 100644
--- a/tests/qemu-iotests/254.out
+++ b/tests/qemu-iotests/254.out
@@ -1,5 +1,9 @@
 {"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "node": "drive0"}}
 {"return": {}}
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap1", "node": "drive0", "persistent": true}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap2", "node": "drive0", "persistent": true}}
+{"return": {}}
 {
   "execute": "transaction",
   "arguments": {
@@ -31,6 +35,55 @@
           "target": "bitmap0"
         },
         "type": "block-dirty-bitmap-merge"
+      },
+      {
+        "data": {
+          "name": "bitmap1",
+          "node": "snap",
+          "persistent": true
+        },
+        "type": "block-dirty-bitmap-add"
+      },
+      {
+        "data": {
+          "bitmaps": [
+            {
+              "name": "bitmap1",
+              "node": "base"
+            }
+          ],
+          "node": "snap",
+          "target": "bitmap1"
+        },
+        "type": "block-dirty-bitmap-merge"
+      },
+      {
+        "data": {
+          "name": "bitmap2",
+          "node": "snap",
+          "persistent": true
+        },
+        "type": "block-dirty-bitmap-add"
+      },
+      {
+        "data": {
+          "bitmaps": [
+            {
+              "name": "bitmap2",
+              "node": "base"
+            }
+          ],
+          "node": "snap",
+          "target": "bitmap2"
+        },
+        "type": "block-dirty-bitmap-merge"
+      },
+      {
+        "data": {
+          "name": "bitmap2",
+          "node": "base"
+        },
+        "type": "block-dirty-bitmap-remove"
       }
     ]
   }
@@ -40,6 +93,24 @@
 }
 query-block: device = drive0, node-name = snap, dirty-bitmaps:
 [
+  {
+    "busy": false,
+    "count": 524288,
+    "granularity": 65536,
+    "name": "bitmap2",
+    "persistent": true,
+    "recording": true,
+    "status": "active"
+  },
+  {
+    "busy": false,
+    "count": 524288,
+    "granularity": 65536,
+    "name": "bitmap1",
+    "persistent": true,
+    "recording": true,
+    "status": "active"
+  },
   {
     "busy": false,
     "count": 524288,
@@ -50,3 +121,14 @@ query-block: device = drive0, node-name = snap, dirty-bitmaps:
     "status": "active"
   }
 ]
+
+bitmaps in backing image:
+[
+  {
+    "flags": [
+      "auto"
+    ],
+    "granularity": 65536,
+    "name": "bitmap1"
+  }
+]
-- 
2.18.0


