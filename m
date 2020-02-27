Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A461BC4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 07:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D84320732
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 07:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D84320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Dj2-0007jo-M7
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 02:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7DcY-0000G3-La
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7DcW-0000AW-85
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:30:10 -0500
Received: from relay.sw.ru ([185.231.240.75]:33970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j7DcU-00005e-LY; Thu, 27 Feb 2020 02:30:07 -0500
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j7DcO-0003Tx-SL; Thu, 27 Feb 2020 10:30:00 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 5/8] iotests: fix header size,
 feature table size and backing file offset
Date: Thu, 27 Feb 2020 10:29:50 +0300
Message-Id: <20200227072953.25445-6-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 den@vrtuozzo.com, armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Affected tests: 031, 036, 061

Because of adding the compression type feature, some size values in the
qcow2 v3 header are changed:

header_size +=8: 1 byte compression type
                 7 bytes padding
feature_table += 48: incompatible feture compression type

backing_file_offset += 56 (8 + 48 -> header_change + fature_table_change)

Change the values for the test output comparison accordingly.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 tests/qemu-iotests/031.out | 14 +++++++-------
 tests/qemu-iotests/036.out |  4 ++--
 tests/qemu-iotests/061.out | 28 ++++++++++++++--------------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
index d535e407bc..ed51afe9ce 100644
--- a/tests/qemu-iotests/031.out
+++ b/tests/qemu-iotests/031.out
@@ -113,11 +113,11 @@ incompatible_features     []
 compatible_features       []
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    240
 data                      <binary>
 
 Header extension:
@@ -146,11 +146,11 @@ incompatible_features     []
 compatible_features       []
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    240
 data                      <binary>
 
 Header extension:
@@ -164,7 +164,7 @@ No errors were found on the image.
 
 magic                     0x514649fb
 version                   3
-backing_file_offset       0x178
+backing_file_offset       0x1b0
 backing_file_size         0x17
 cluster_bits              16
 size                      67108864
@@ -179,7 +179,7 @@ incompatible_features     []
 compatible_features       []
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0xe2792aca
@@ -188,7 +188,7 @@ data                      'host_device'
 
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    240
 data                      <binary>
 
 Header extension:
diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index 0b52b934e1..fb509f6357 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -26,7 +26,7 @@ compatible_features       []
 autoclear_features        [63]
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    240
 data                      <binary>
 
 
@@ -38,7 +38,7 @@ compatible_features       []
 autoclear_features        []
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    240
 data                      <binary>
 
 *** done
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 8b3091a412..cea7fedfdc 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -22,11 +22,11 @@ incompatible_features     []
 compatible_features       [0]
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    240
 data                      <binary>
 
 magic                     0x514649fb
@@ -80,11 +80,11 @@ incompatible_features     []
 compatible_features       [0]
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    240
 data                      <binary>
 
 magic                     0x514649fb
@@ -136,11 +136,11 @@ incompatible_features     [0]
 compatible_features       [0]
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    240
 data                      <binary>
 
 ERROR cluster 5 refcount=0 reference=1
@@ -191,11 +191,11 @@ incompatible_features     []
 compatible_features       [42]
 autoclear_features        [42]
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    240
 data                      <binary>
 
 magic                     0x514649fb
@@ -260,11 +260,11 @@ incompatible_features     []
 compatible_features       [0]
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    240
 data                      <binary>
 
 read 65536/65536 bytes at offset 44040192
@@ -294,11 +294,11 @@ incompatible_features     [0]
 compatible_features       [0]
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    240
 data                      <binary>
 
 ERROR cluster 5 refcount=0 reference=1
@@ -323,11 +323,11 @@ incompatible_features     []
 compatible_features       []
 autoclear_features        []
 refcount_order            4
-header_length             104
+header_length             112
 
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    240
 data                      <binary>
 
 read 131072/131072 bytes at offset 0
-- 
2.17.0


