Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E4CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8859E20829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8859E20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k19RW-0001SF-Nh
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k19L9-0004yp-CI; Thu, 30 Jul 2020 10:15:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:44428 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k19L4-00052a-FK; Thu, 30 Jul 2020 10:15:22 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k19Kn-0004Cz-1M; Thu, 30 Jul 2020 17:15:01 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v12 10/11] qcow2_format.py: support dumping metadata in JSON
 format
Date: Thu, 30 Jul 2020 17:15:11 +0300
Message-Id: <1596118512-424960-11-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596118512-424960-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1596118512-424960-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 10:15:15
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

Implementation of dumping QCOW2 image metadata.
The sample output:
{
    "Header_extensions": [
        {
            "name": "Feature table",
            "magic": 1745090647,
            "length": 192,
            "data_str": "<binary>"
        },
        {
            "name": "Bitmaps",
            "magic": 595929205,
            "length": 24,
            "data": {
                "nb_bitmaps": 2,
                "reserved32": 0,
                "bitmap_directory_size": 64,
                "bitmap_directory_offset": 1048576,
                "bitmap_directory": [
                    {
                        "name": "bitmap-1",
                        "bitmap_table_offset": 589824,
                        "bitmap_table_size": 1,
                        "flags": 2,
                        "type": 1,
                        "granularity_bits": 15,
                        "name_size": 8,
                        "extra_data_size": 0,
                        "bitmap_table": [
                            {
                                "type": "serialized",
                                "offset": 655360
                            },
                            ...

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index a4114cb..7487720 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -19,6 +19,15 @@
 
 import struct
 import string
+import json
+
+
+class ComplexEncoder(json.JSONEncoder):
+    def default(self, obj):
+        if hasattr(obj, 'to_dict'):
+            return obj.to_dict()
+        else:
+            return json.JSONEncoder.default(self, obj)
 
 
 class Qcow2Field:
@@ -110,6 +119,10 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
                              for i, field in enumerate(self.fields))
 
     def dump(self, is_json=False):
+        if is_json:
+            print(json.dumps(self.to_dict(), indent=4, cls=ComplexEncoder))
+            return
+
         for f in self.fields:
             value = self.__dict__[f[2]]
             if isinstance(f[1], str):
@@ -440,6 +453,10 @@ class QcowHeader(Qcow2Struct):
         fd.write(buf)
 
     def dump_extensions(self, is_json=False):
+        if is_json:
+            print(json.dumps(self.extensions, indent=4, cls=ComplexEncoder))
+            return
+
         for ex in self.extensions:
             print('Header extension:')
             ex.dump()
-- 
1.8.3.1


