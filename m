Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BF5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A670A2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A670A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjUgx-0002kY-UY
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 17:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjUbi-00034W-HL; Thu, 11 Jun 2020 17:19:30 -0400
Received: from relay.sw.ru ([185.231.240.75]:40360 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjUbf-00057s-2N; Thu, 11 Jun 2020 17:19:30 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjUbW-0001xE-Pv; Fri, 12 Jun 2020 00:19:18 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 3/8] qcow2_format.py: Dump bitmap directory info
Date: Fri, 12 Jun 2020 00:19:15 +0300
Message-Id: <1591910360-867499-4-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591910360-867499-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1591910360-867499-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 17:19:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Read and dump entries from the bitmap directory of QCOW2 image with the
script qcow2.py.

Header extension:
magic                     0x23852875 (Bitmaps)
...
Bitmap name               bitmap-1
flag                      auto
table size                8 (bytes)
bitmap_table_offset       0x90000
bitmap_table_size         1
flags                     0
type                      1
granularity_bits          16
name_size                 8
extra_data_size           0

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 75 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index d4f0000..a7868a7 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -103,6 +103,10 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
             print('{:<25} {}'.format(f[2], value_str))
 
 
+# seek relative to the current position in the file
+FROM_CURRENT = 1
+
+
 class Qcow2BitmapExt(Qcow2Struct):
 
     fields = (
@@ -112,6 +116,73 @@ class Qcow2BitmapExt(Qcow2Struct):
         ('u64', '{:#x}', 'bitmap_directory_offset')
     )
 
+    def read_bitmap_directory(self, fd):
+        self.bitmaps = []
+        fd.seek(self.bitmap_directory_offset)
+        buf_size = struct.calcsize(Qcow2BitmapDirEntry.fmt)
+
+        for n in range(self.nb_bitmaps):
+            buf = fd.read(buf_size)
+            dir_entry = Qcow2BitmapDirEntry(data=buf)
+            fd.seek(dir_entry.extra_data_size, FROM_CURRENT)
+            bitmap_name = fd.read(dir_entry.name_size)
+            dir_entry.name = bitmap_name.decode('ascii')
+            self.bitmaps.append(dir_entry)
+            entry_raw_size = dir_entry.bitmap_dir_entry_raw_size()
+            shift = ((entry_raw_size + 7) & ~7) - entry_raw_size
+            fd.seek(shift, FROM_CURRENT)
+
+    def load(self, fd):
+        self.read_bitmap_directory(fd)
+
+    def dump(self):
+        super().dump()
+        for bm in self.bitmaps:
+            bm.dump_bitmap_dir_entry()
+
+
+BME_FLAG_IN_USE = 1 << 0
+BME_FLAG_AUTO = 1 << 1
+
+
+class Qcow2BitmapDirEntry(Qcow2Struct):
+
+    name = ''
+
+    fields = (
+        ('u64', '{:#x}', 'bitmap_table_offset'),
+        ('u32', '{}',    'bitmap_table_size'),
+        ('u32', '{}',    'flags'),
+        ('u8',  '{}',    'type'),
+        ('u8',  '{}',    'granularity_bits'),
+        ('u16', '{}',    'name_size'),
+        ('u32', '{}',    'extra_data_size')
+    )
+
+    def __init__(self, data):
+        super().__init__(data=data)
+
+        self.bitmap_table_bytes = self.bitmap_table_size \
+            * struct.calcsize('Q')
+
+        self.bitmap_flags = []
+        if (self.flags & BME_FLAG_IN_USE):
+            self.bitmap_flags.append("in-use")
+        if (self.flags & BME_FLAG_AUTO):
+            self.bitmap_flags.append("auto")
+
+    def bitmap_dir_entry_raw_size(self):
+        return struct.calcsize(self.fmt) + self.name_size + \
+            self.extra_data_size
+
+    def dump_bitmap_dir_entry(self):
+        print()
+        print(f'{"Bitmap name":<25} {self.name}')
+        for fl in self.bitmap_flags:
+            print(f'{"flag":<25} {fl}')
+        print(f'{"table size ":<25} {self.bitmap_table_bytes} {"(bytes)"}')
+        super().dump()
+
 
 QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
 
@@ -253,6 +324,10 @@ class QcowHeader(Qcow2Struct):
             else:
                 self.extensions.append(ext)
 
+        for ext in self.extensions:
+            if ext.obj is not None:
+                ext.obj.load(fd)
+
     def update_extensions(self, fd):
 
         fd.seek(self.header_length)
-- 
1.8.3.1


