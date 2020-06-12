Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5EEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 00:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA33A20835
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 00:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA33A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjXFn-00078L-VT
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 20:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjXC5-0008Qj-73; Thu, 11 Jun 2020 20:05:13 -0400
Received: from relay.sw.ru ([185.231.240.75]:52874 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjXBy-0006IG-Ln; Thu, 11 Jun 2020 20:05:12 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjXBr-0002Yd-QV; Fri, 12 Jun 2020 03:04:59 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 9/9] qcow2_format.py: support dumping metadata in JSON
 format
Date: Fri, 12 Jun 2020 03:05:02 +0300
Message-Id: <1591920302-1002219-10-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591920302-1002219-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1591920302-1002219-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 20:05:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
                "entries": [
                    {
                        "name": "bitmap-1",
                        "bitmap_table_offset": 589824,
                        "bitmap_table_size": 1,
                        "flags": [
                            "auto"
                        ],
                        "type": 1,
                        "granularity_bits": 16,
                        "name_size": 8,
                        "extra_data_size": 0,
                        "bitmap_table": {
                            "table_entries": [
                                {
                                    "type": "serialized",
                                    "offset": 655360
                                },
                                ...

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 60 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index bdd5f68..35daec9 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -18,6 +18,15 @@
 
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
@@ -95,6 +104,11 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
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
@@ -150,6 +164,9 @@ class Qcow2BitmapExt(Qcow2Struct):
         for bm in self.bitmaps:
             bm.dump_bitmap_dir_entry(dump_json)
 
+    def get_fields_dict(self):
+        return self.fields_dict
+
 
 BME_FLAG_IN_USE = 1 << 0
 BME_FLAG_AUTO = 1 << 1
@@ -202,6 +219,12 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
         super().dump()
         self.bitmap_table.print_bitmap_table(self.cluster_size)
 
+    def get_fields_dict(self):
+        bmp_name = dict(name=self.name)
+        bme_dict = {**bmp_name, **self.fields_dict}
+        bme_dict['flags'] = self.bitmap_flags
+        return bme_dict
+
 
 class Qcow2BitmapTableEntry:
 
@@ -217,6 +240,9 @@ class Qcow2BitmapTableEntry:
         else:
             self.type = 'all-zeroes'
 
+    def get_fields_dict(self):
+        return dict(type=self.type, offset=self.offset)
+
 
 class Qcow2BitmapTable:
 
@@ -232,6 +258,18 @@ class Qcow2BitmapTable:
             print(f'{i:<14} {entry.type:<15} {entry.offset:<24} {cluster_size}')
         print("")
 
+    def get_fields_dict(self):
+        return dict(table_entries=self.entries)
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
 
@@ -247,6 +285,9 @@ class QcowHeaderExtension(Qcow2Struct):
             0x44415441: 'Data file'
         }
 
+        def get_fields_dict(self):
+            return self.mapping.get(self.value, "<unknown>")
+
     fields = (
         ('u32', Magic, 'magic'),
         ('u32', '{}', 'length')
@@ -307,6 +348,16 @@ class QcowHeaderExtension(Qcow2Struct):
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
@@ -409,7 +460,16 @@ class QcowHeader(Qcow2Struct):
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


