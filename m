Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A606C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 07:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5E620702
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 07:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5E620702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jusyS-0000l1-89
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 03:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jussh-0007iV-Cz; Mon, 13 Jul 2020 03:28:07 -0400
Received: from relay.sw.ru ([185.231.240.75]:35070 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jussc-0007TD-F7; Mon, 13 Jul 2020 03:28:07 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jussP-0001Vx-UZ; Mon, 13 Jul 2020 10:27:49 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v9 10/10] qcow2_format.py: support dumping metadata in JSON
 format
Date: Mon, 13 Jul 2020 10:27:56 +0300
Message-Id: <1594625276-134500-11-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594625276-134500-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1594625276-134500-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:27:59
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
                        "bitmap_table": {
                            "entries": [
                                {
                                    "type": "serialized",
                                    "offset": 655360
                                },
                                ...

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 59 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 4ce6d95..1b953c1 100644
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
+        if hasattr(obj, 'get_fields_dict'):
+            return obj.get_fields_dict()
+        else:
+            return json.JSONEncoder.default(self, obj)
 
 
 class Qcow2Field:
@@ -112,6 +121,11 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
         self.fields_dict = self.__dict__.copy()
 
     def dump(self, dump_json=None):
+        if dump_json:
+            print(json.dumps(self.get_fields_dict(), indent=4,
+                             cls=ComplexEncoder))
+            return
+
         for f in self.fields:
             value = self.__dict__[f[2]]
             if isinstance(f[1], str):
@@ -149,6 +163,9 @@ class Qcow2BitmapExt(Qcow2Struct):
             print()
             entry.dump()
 
+    def get_fields_dict(self):
+        return self.fields_dict
+
 
 class Qcow2BitmapDirEntry(Qcow2Struct):
 
@@ -194,6 +211,11 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
         super(Qcow2BitmapDirEntry, self).dump()
         self.bitmap_table.dump()
 
+    def get_fields_dict(self):
+        bmp_name = dict(name=self.name)
+        bme_dict = {**bmp_name, **self.fields_dict}
+        return bme_dict
+
 
 class Qcow2BitmapTableEntry:
 
@@ -209,6 +231,9 @@ class Qcow2BitmapTableEntry:
         else:
             self.type = 'all-zeroes'
 
+    def get_fields_dict(self):
+        return dict(type=self.type, offset=self.offset)
+
 
 class Qcow2BitmapTable:
 
@@ -225,6 +250,18 @@ class Qcow2BitmapTable:
         for i, entry in bitmap_table:
             print(f'{i:<14} {entry.type:<15} {entry.offset:<24} {size}')
 
+    def get_fields_dict(self):
+        return dict(entries=self.entries)
+
+
+class Qcow2HeaderExtensionsDoc:
+
+    def __init__(self, extensions):
+        self.extensions = extensions
+
+    def get_fields_dict(self):
+        return dict(Header_extensions=self.extensions)
+
 
 QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
 
@@ -240,6 +277,9 @@ class QcowHeaderExtension(Qcow2Struct):
             0x44415441: 'Data file'
         }
 
+        def get_fields_dict(self):
+            return self.mapping.get(self.value, "<unknown>")
+
     fields = (
         ('u32', Magic, 'magic'),
         ('u32', '{}', 'length')
@@ -305,6 +345,16 @@ class QcowHeaderExtension(Qcow2Struct):
         else:
             self.obj.dump(dump_json)
 
+    def get_fields_dict(self):
+        ext_name = dict(name=self.Magic(self.magic))
+        he_dict = {**ext_name, **self.fields_dict}
+        if self.obj is not None:
+            he_dict.update(data=self.obj)
+        else:
+            he_dict.update(data_str=self.data_str)
+
+        return he_dict
+
     @classmethod
     def create(cls, magic, data):
         return QcowHeaderExtension(magic, len(data), data)
@@ -403,7 +453,16 @@ class QcowHeader(Qcow2Struct):
         fd.write(buf)
 
     def dump_extensions(self, dump_json=None):
+        if dump_json:
+            ext_doc = Qcow2HeaderExtensionsDoc(self.extensions)
+            print(json.dumps(ext_doc.get_fields_dict(), indent=4,
+                             cls=ComplexEncoder))
+            return
+
         for ex in self.extensions:
             print('Header extension:')
             ex.dump(dump_json)
             print()
+
+    def get_fields_dict(self):
+        return self.fields_dict
-- 
1.8.3.1


