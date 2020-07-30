Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E1DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A9552074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9552074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k19Oo-0003hu-9K
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k19LA-00052I-Vb; Thu, 30 Jul 2020 10:15:24 -0400
Received: from relay.sw.ru ([185.231.240.75]:44426 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k19L4-00052Y-On; Thu, 30 Jul 2020 10:15:24 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k19Km-0004Cz-V2; Thu, 30 Jul 2020 17:15:01 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v12 09/11] qcow2_format.py: collect fields to dump in JSON
 format
Date: Thu, 30 Jul 2020 17:15:10 +0300
Message-Id: <1596118512-424960-10-git-send-email-andrey.shinkevich@virtuozzo.com>
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

As __dict__ is being extended with class members we do not want to
print, add the to_dict() method to classes that returns a dictionary
with desired fields and their values. Extend it in subclass when
necessary to print the final dictionary in the JSON output which
follows.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 2000de3..a4114cb 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -119,6 +119,9 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
 
             print('{:<25} {}'.format(f[2], value_str))
 
+    def to_dict(self):
+        return dict((f[2], self.__dict__[f[2]]) for f in self.fields)
+
 
 class Qcow2BitmapExt(Qcow2Struct):
 
@@ -151,6 +154,11 @@ class Qcow2BitmapExt(Qcow2Struct):
             print()
             entry.dump()
 
+    def to_dict(self):
+        fields_dict = super().to_dict()
+        fields_dict['bitmap_directory'] = self.bitmap_directory
+        return fields_dict
+
 
 class Qcow2BitmapDirEntry(Qcow2Struct):
 
@@ -189,6 +197,14 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
         super(Qcow2BitmapDirEntry, self).dump()
         self.bitmap_table.dump()
 
+    def to_dict(self):
+        fields_dict = super().to_dict()
+        fields_dict['bitmap_table'] = self.bitmap_table.entries
+        bmp_name = dict(name=self.name)
+        # Put the name ahead of the dict
+        bme_dict = {**bmp_name, **fields_dict}
+        return bme_dict
+
 
 class Qcow2BitmapTableEntry(Qcow2Struct):
 
@@ -214,6 +230,9 @@ class Qcow2BitmapTableEntry(Qcow2Struct):
         else:
             self.type = 'all-zeroes'
 
+    def to_dict(self):
+        return dict(type=self.type, offset=self.offset, reserved=self.reserved)
+
 
 class Qcow2BitmapTable:
 
@@ -246,6 +265,9 @@ class QcowHeaderExtension(Qcow2Struct):
             0x44415441: 'Data file'
         }
 
+        def to_dict(self):
+            return self.mapping.get(self.value, "<unknown>")
+
     fields = (
         ('u32', Magic, 'magic'),
         ('u32', '{}', 'length')
@@ -308,6 +330,18 @@ class QcowHeaderExtension(Qcow2Struct):
         else:
             self.obj.dump()
 
+    def to_dict(self):
+        fields_dict = super().to_dict()
+        ext_name = dict(name=self.Magic(self.magic))
+        # Put the name ahead of the dict
+        he_dict = {**ext_name, **fields_dict}
+        if self.obj is not None:
+            he_dict['data'] = self.obj
+        else:
+            he_dict['data_str'] = self.data_str
+
+        return he_dict
+
     @classmethod
     def create(cls, magic, data):
         return QcowHeaderExtension(magic, len(data), data)
-- 
1.8.3.1


