Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44983C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA4820FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdM1LeoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA4820FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97mx-0006nq-9L
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97j1-0007Qo-Kl
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29935
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97iz-0004Yf-5L
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598018936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6byl7PYJtPbf4q/rlmARLiYl1eSQpVb4EhYzY2wJOU=;
 b=DdM1LeoVnX6JDGwWRbXj9FdpWDEaF1/M75uwqK7A4eGDZEoAEtLBRibS/uD5dCtEyuICp2
 NpFDXJJ2zpfMTpy4QEldj+KTFx0fK4ucNlDRaVRfVyRyxrfLGRopS51ZoVD7jaxMoub7cG
 pGVUNwPRZaaw8wHumNMcvqAPO5MHYT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-m_OJ_mQwMSSjK5RV4ZVlTw-1; Fri, 21 Aug 2020 10:08:39 -0400
X-MC-Unique: m_OJ_mQwMSSjK5RV4ZVlTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0834101963B;
 Fri, 21 Aug 2020 14:08:38 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-220.phx2.redhat.com [10.3.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66E097AECA;
 Fri, 21 Aug 2020 14:08:38 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/14] iotests: dump QCOW2 header in JSON in #303
Date: Fri, 21 Aug 2020 09:08:23 -0500
Message-Id: <20200821140826.194322-12-eblake@redhat.com>
In-Reply-To: <20200821140826.194322-1-eblake@redhat.com>
References: <20200821140826.194322-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Extend the test case #303 by dumping QCOW2 image metadata in JSON
format.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1596742557-320265-12-git-send-email-andrey.shinkevich@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/303     |  3 ++
 tests/qemu-iotests/303.out | 76 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/tests/qemu-iotests/303 b/tests/qemu-iotests/303
index e9accdc7bc92..6c2177448348 100755
--- a/tests/qemu-iotests/303
+++ b/tests/qemu-iotests/303
@@ -58,3 +58,6 @@ add_bitmap(1, 0, 6, False)
 add_bitmap(2, 6, 8, True)
 dump = ['qcow2.py', disk, 'dump-header']
 subprocess.run(dump)
+# Dump the metadata in JSON format
+dump.append('-j')
+subprocess.run(dump)
diff --git a/tests/qemu-iotests/303.out b/tests/qemu-iotests/303.out
index 70828e05f11f..7fa1edef0d89 100644
--- a/tests/qemu-iotests/303.out
+++ b/tests/qemu-iotests/303.out
@@ -80,3 +80,79 @@ extra_data_size           0
 Bitmap table   type            size         offset
 0              all-zeroes      0            0

+{
+    "magic": 1363560955,
+    "version": 3,
+    "backing_file_offset": 0,
+    "backing_file_size": 0,
+    "cluster_bits": 16,
+    "size": 10485760,
+    "crypt_method": 0,
+    "l1_size": 1,
+    "l1_table_offset": 196608,
+    "refcount_table_offset": 65536,
+    "refcount_table_clusters": 1,
+    "nb_snapshots": 0,
+    "snapshot_offset": 0,
+    "incompatible_features": 0,
+    "compatible_features": 0,
+    "autoclear_features": 1,
+    "refcount_order": 4,
+    "header_length": 112
+}
+
+[
+    {
+        "name": "Feature table",
+        "magic": 1745090647,
+        "length": 336,
+        "data_str": "<binary>"
+    },
+    {
+        "name": "Bitmaps",
+        "magic": 595929205,
+        "length": 24,
+        "data": {
+            "nb_bitmaps": 2,
+            "reserved32": 0,
+            "bitmap_directory_size": 64,
+            "bitmap_directory_offset": 10289152,
+            "bitmap_directory": [
+                {
+                    "name": "bitmap-1",
+                    "bitmap_table_offset": 10158080,
+                    "bitmap_table_size": 1,
+                    "flags": 2,
+                    "type": 1,
+                    "granularity_bits": 15,
+                    "name_size": 8,
+                    "extra_data_size": 0,
+                    "bitmap_table": [
+                        {
+                            "type": "serialized",
+                            "offset": 10092544,
+                            "reserved": 0
+                        }
+                    ]
+                },
+                {
+                    "name": "bitmap-2",
+                    "bitmap_table_offset": 10223616,
+                    "bitmap_table_size": 1,
+                    "flags": 0,
+                    "type": 1,
+                    "granularity_bits": 16,
+                    "name_size": 8,
+                    "extra_data_size": 0,
+                    "bitmap_table": [
+                        {
+                            "type": "all-zeroes",
+                            "offset": 0,
+                            "reserved": 0
+                        }
+                    ]
+                }
+            ]
+        }
+    }
+]
-- 
2.28.0


