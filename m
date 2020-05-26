Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9995C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4BD2068D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4BD2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdazN-000233-NC
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 10:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jdayX-0000hf-5J; Tue, 26 May 2020 10:54:41 -0400
Received: from relay.sw.ru ([185.231.240.75]:37058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jdayU-0005yA-FQ; Tue, 26 May 2020 10:54:39 -0400
Received: from dhcp-172-16-25-136.sw.ru ([172.16.25.136] helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jdayL-0001Qx-0O; Tue, 26 May 2020 17:54:29 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests: Dump QCOW2 dirty bitmaps metadata
Date: Tue, 26 May 2020 17:54:26 +0300
Message-Id: <1590504866-679474-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:54:34
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Add dirty bitmap information to QCOW2 metadata dump in qcow2.py script.
The sample output:

Header extension (Bitmaps):
magic                     0x23852875
length                    24
nb_bitmaps                2
reserved32                0
bitmap_directory_size     0x40
bitmap_directory_offset   0x100000

Bitmap name               bitmap-1
flag                      "auto"
bitmap_table_offset       0x90000
bitmap_table_size         8
flags                     2
type                      1
granularity_bits          15
name_size                 8
extra_data_size           0

Bitmap table
   0     serialized, offset 0xa0000
   1     all-zeroes, offset 0x0
   2     all-zeroes, offset 0x0
   3     all-zeroes, offset 0x0
   4     all-zeroes, offset 0x0
   5     all-zeroes, offset 0x0
   6     all-zeroes, offset 0x0
   7     all-zeroes, offset 0x0

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2.py | 149 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 141 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 91e4420..41aa030 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -5,6 +5,122 @@ import sys
 import struct
 import string
 
+
+class Qcow2BitmapDirEntry:
+
+    name = ''
+    BME_FLAG_IN_USE = 1
+    BME_FLAG_AUTO = 1 << 1
+
+    uint8_t = 'B'
+    uint16_t = 'H'
+    uint32_t = 'I'
+    uint64_t = 'Q'
+
+    fields = [
+        [uint64_t, '%#x', 'bitmap_table_offset'],
+        [uint32_t, '%d',  'bitmap_table_size'],
+        [uint32_t, '%d',  'flags'],
+        [uint8_t,  '%d',  'type'],
+        [uint8_t,  '%d',  'granularity_bits'],
+        [uint16_t, '%d',  'name_size'],
+        [uint32_t, '%d',  'extra_data_size']
+    ]
+
+    fmt = '>' + ''.join(field[0] for field in fields)
+
+    def __init__(self, data):
+
+        entry = struct.unpack(Qcow2BitmapDirEntry.fmt, data)
+        self.__dict__ = dict((field[2], entry[i])
+                             for i, field in enumerate(
+                                 Qcow2BitmapDirEntry.fields))
+
+        self.bitmap_table_size = self.bitmap_table_size \
+            * struct.calcsize(self.uint64_t)
+
+    def bitmap_dir_entry_size(self):
+        size = struct.calcsize(self.fmt) + self.name_size + \
+            self.extra_data_size
+        return (size + 7) & ~7
+
+    def dump_bitmap_dir_entry(self):
+        print("%-25s" % 'Bitmap name', self.name)
+        if (self.flags & self.BME_FLAG_IN_USE) != 0:
+            print("%-25s" % 'flag', '"in-use"')
+        if (self.flags & self.BME_FLAG_AUTO) != 0:
+            print("%-25s" % 'flag', '"auto"')
+        for f in Qcow2BitmapDirEntry.fields:
+            value = self.__dict__[f[2]]
+            value_str = f[1] % value
+
+            print("%-25s" % f[2], value_str)
+        print("")
+
+    def dump_bitmap_table(self, fd):
+        fd.seek(self.bitmap_table_offset)
+        table_size = self.bitmap_table_size * struct.calcsize(self.uint64_t)
+        bitmap_table = [e[0] for e in struct.iter_unpack('>Q',
+                                                         fd.read(table_size))]
+        BME_TABLE_ENTRY_OFFSET_MASK = 0x00fffffffffffe00
+        BME_TABLE_ENTRY_FLAG_ALL_ONES = 1
+        bmt_type = ['all-zeroes', 'all-ones', 'serialized']
+        items = enumerate(bitmap_table)
+        print("Bitmap table")
+        for i, entry in items:
+            offset = entry & BME_TABLE_ENTRY_OFFSET_MASK
+            if offset != 0:
+                index = 2
+            else:
+                index = entry & BME_TABLE_ENTRY_FLAG_ALL_ONES
+            print("   %-4d  %s, offset %#x" % (i, bmt_type[index], offset))
+        print("")
+
+
+class Qcow2BitmapExt:
+
+    uint32_t = 'I'
+    uint64_t = 'Q'
+
+    fields = [
+        [uint32_t, '%d',  'nb_bitmaps'],
+        [uint32_t, '%d',  'reserved32'],
+        [uint64_t, '%#x', 'bitmap_directory_size'],
+        [uint64_t, '%#x', 'bitmap_directory_offset']
+    ]
+
+    fmt = '>' + ''.join(field[0] for field in fields)
+
+    def __init__(self, data):
+
+        extension = struct.unpack(Qcow2BitmapExt.fmt, data)
+        self.__dict__ = dict((field[2], extension[i])
+                             for i, field in enumerate(Qcow2BitmapExt.fields))
+
+    def dump_bitmap_ext(self):
+        for f in Qcow2BitmapExt.fields:
+            value = self.__dict__[f[2]]
+            value_str = f[1] % value
+
+            print("%-25s" % f[2], value_str)
+        print("")
+
+    def bitmap_directory(self, fd):
+        offset = self.bitmap_directory_offset
+        buf_size = struct.calcsize(Qcow2BitmapDirEntry.fmt)
+
+        for n in range(self.nb_bitmaps):
+            fd.seek(offset)
+            buf = fd.read(buf_size)
+            dir_entry = Qcow2BitmapDirEntry(buf)
+            fd.seek(dir_entry.extra_data_size, 1)
+            bitmap_name = fd.read(dir_entry.name_size)
+            dir_entry.name = bitmap_name.decode('ascii')
+            dir_entry.dump_bitmap_dir_entry()
+            dir_entry.dump_bitmap_table(fd)
+            offset += dir_entry.bitmap_dir_entry_size()
+
+
 class QcowHeaderExtension:
 
     def __init__(self, magic, length, data):
@@ -22,6 +138,8 @@ class QcowHeaderExtension:
 
 class QcowHeader:
 
+    QCOW2_EXT_MAGIC_FEATURE_TABLE = 0x6803f857
+    QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
     uint32_t = 'I'
     uint64_t = 'Q'
 
@@ -128,6 +246,12 @@ class QcowHeader:
         buf = buf[0:header_bytes-1]
         fd.write(buf)
 
+    def extension_name(self, magic):
+       return {
+            self.QCOW2_EXT_MAGIC_FEATURE_TABLE: 'Feature table',
+            self.QCOW2_EXT_MAGIC_BITMAPS: 'Bitmaps',
+        }.get(magic, 'Unknown')
+
     def dump(self):
         for f in QcowHeader.fields:
             value = self.__dict__[f[2]]
@@ -143,30 +267,39 @@ class QcowHeader:
             print("%-25s" % f[2], value_str)
         print("")
 
-    def dump_extensions(self):
+    def dump_extensions(self, fd):
         for ex in self.extensions:
 
+            print("Header extension (%s):" % self.extension_name(ex.magic))
+            print("%-25s %#x" % ("magic", ex.magic))
+            print("%-25s %d" % ("length", ex.length))
+
             data = ex.data[:ex.length]
             if all(c in string.printable.encode('ascii') for c in data):
                 data = "'%s'" % data.decode('ascii')
+                print("%-25s %s" % ("data", data))
             else:
-                data = "<binary>"
+                self.dump_extension_data(fd, ex)
 
-            print("Header extension:")
-            print("%-25s %#x" % ("magic", ex.magic))
-            print("%-25s %d" % ("length", ex.length))
-            print("%-25s %s" % ("data", data))
             print("")
 
+    def dump_extension_data(self, fd, ext):
+        if ext.magic == self.QCOW2_EXT_MAGIC_BITMAPS:
+            b_ext = Qcow2BitmapExt(ext.data)
+            b_ext.dump_bitmap_ext()
+            b_ext.bitmap_directory(fd)
+        else:
+            print("%-25s %s" % ("data", "<binary>"))
+
 
 def cmd_dump_header(fd):
     h = QcowHeader(fd)
     h.dump()
-    h.dump_extensions()
+    h.dump_extensions(fd)
 
 def cmd_dump_header_exts(fd):
     h = QcowHeader(fd)
-    h.dump_extensions()
+    h.dump_extensions(fd)
 
 def cmd_set_header(fd, name, value):
     try:
-- 
1.8.3.1


