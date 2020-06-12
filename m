Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B31EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 00:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36CB92078C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 00:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CB92078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjXI0-0002iE-Dm
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 20:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjXC4-0008PM-JK; Thu, 11 Jun 2020 20:05:12 -0400
Received: from relay.sw.ru ([185.231.240.75]:52850 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjXBy-0006IC-Ou; Thu, 11 Jun 2020 20:05:12 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjXBr-0002Yd-N6; Fri, 12 Jun 2020 03:04:59 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 6/9] qcow2_format.py: Dump bitmap table serialized entries
Date: Fri, 12 Jun 2020 03:04:59 +0300
Message-Id: <1591920302-1002219-7-git-send-email-andrey.shinkevich@virtuozzo.com>
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

Add bitmap table information to the QCOW2 metadata dump.
It extends the output of the test case #291

Bitmap name               bitmap-1
...
Bitmap table   type            offset                   size
0              serialized      4718592                  65536
1              serialized      4294967296               65536
2              serialized      5348033147437056         65536
3              serialized      13792273858822144        65536
4              serialized      4718592                  65536
5              serialized      4294967296               65536
6              serialized      4503608217305088         65536
7              serialized      14073748835532800        65536

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/291.out         | 50 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/qcow2_format.py | 40 ++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
index d847419..595327c 100644
--- a/tests/qemu-iotests/291.out
+++ b/tests/qemu-iotests/291.out
@@ -42,6 +42,16 @@ type                      1
 granularity_bits          19
 name_size                 2
 extra_data_size           0
+Bitmap table   type            offset                   size
+0              serialized      5046272                  65536
+1              all-zeroes      0                        65536
+2              all-zeroes      0                        65536
+3              all-zeroes      0                        65536
+4              all-zeroes      0                        65536
+5              all-zeroes      0                        65536
+6              all-zeroes      0                        65536
+7              all-zeroes      0                        65536
+
 
 Bitmap name               b2
 flag                      auto
@@ -53,6 +63,16 @@ type                      1
 granularity_bits          16
 name_size                 2
 extra_data_size           0
+Bitmap table   type            offset                   size
+0              serialized      5177344                  65536
+1              all-zeroes      0                        65536
+2              all-zeroes      0                        65536
+3              all-zeroes      0                        65536
+4              all-zeroes      0                        65536
+5              all-zeroes      0                        65536
+6              all-zeroes      0                        65536
+7              all-zeroes      0                        65536
+
 
 
 === Bitmap preservation not possible to non-qcow2 ===
@@ -128,6 +148,16 @@ type                      1
 granularity_bits          19
 name_size                 2
 extra_data_size           0
+Bitmap table   type            offset                   size
+0              serialized      4587520                  65536
+1              all-zeroes      0                        65536
+2              all-zeroes      0                        65536
+3              all-zeroes      0                        65536
+4              all-zeroes      0                        65536
+5              all-zeroes      0                        65536
+6              all-zeroes      0                        65536
+7              all-zeroes      0                        65536
+
 
 Bitmap name               b2
 flag                      auto
@@ -139,6 +169,16 @@ type                      1
 granularity_bits          16
 name_size                 2
 extra_data_size           0
+Bitmap table   type            offset                   size
+0              serialized      4718592                  65536
+1              serialized      4294967296               65536
+2              serialized      5348033147437056         65536
+3              serialized      13792273858822144        65536
+4              serialized      4718592                  65536
+5              serialized      4294967296               65536
+6              serialized      4503608217305088         65536
+7              serialized      14073748835532800        65536
+
 
 Bitmap name               b0
 table size                8 (bytes)
@@ -149,6 +189,16 @@ type                      1
 granularity_bits          16
 name_size                 2
 extra_data_size           0
+Bitmap table   type            offset                   size
+0              serialized      5242880                  65536
+1              all-zeroes      0                        65536
+2              all-zeroes      0                        65536
+3              all-zeroes      0                        65536
+4              all-zeroes      0                        65536
+5              all-zeroes      0                        65536
+6              all-zeroes      0                        65536
+7              all-zeroes      0                        65536
+
 
 
 === Check bitmap contents ===
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index eb99119..c1c2773 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -137,6 +137,9 @@ class Qcow2BitmapExt(Qcow2Struct):
             shift = ((entry_raw_size + 7) & ~7) - entry_raw_size
             fd.seek(shift, FROM_CURRENT)
 
+        for bm in self.bitmaps:
+            bm.read_bitmap_table(fd)
+
     def load(self, fd):
         self.read_bitmap_directory(fd)
 
@@ -181,6 +184,12 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
         return struct.calcsize(self.fmt) + self.name_size + \
             self.extra_data_size
 
+    def read_bitmap_table(self, fd):
+        fd.seek(self.bitmap_table_offset)
+        table_size = self.bitmap_table_bytes * struct.calcsize('Q')
+        table = [e[0] for e in struct.iter_unpack('>Q', fd.read(table_size))]
+        self.bitmap_table = Qcow2BitmapTable(table)
+
     def dump_bitmap_dir_entry(self):
         print()
         print(f'{"Bitmap name":<25} {self.name}')
@@ -188,6 +197,37 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
             print(f'{"flag":<25} {fl}')
         print(f'{"table size":<25} {self.bitmap_table_bytes} {"(bytes)"}')
         super().dump()
+        self.bitmap_table.print_bitmap_table(self.cluster_size)
+
+
+class Qcow2BitmapTableEntry:
+
+    BME_TABLE_ENTRY_OFFSET_MASK = 0x00fffffffffffe00
+    BME_TABLE_ENTRY_FLAG_ALL_ONES = 1
+
+    def __init__(self, entry):
+        self.offset = entry & self.BME_TABLE_ENTRY_OFFSET_MASK
+        if self.offset:
+            self.type = 'serialized'
+        elif entry & self.BME_TABLE_ENTRY_FLAG_ALL_ONES:
+            self.type = 'all-ones'
+        else:
+            self.type = 'all-zeroes'
+
+
+class Qcow2BitmapTable:
+
+    def __init__(self, raw_table):
+        self.entries = []
+        for entry in raw_table:
+            self.entries.append(Qcow2BitmapTableEntry(entry))
+
+    def print_bitmap_table(self, cluster_size):
+        bitmap_table = enumerate(self.entries)
+        print(f'{"Bitmap table":<14} {"type":<15} {"offset":<24} {"size"}')
+        for i, entry in bitmap_table:
+            print(f'{i:<14} {entry.type:<15} {entry.offset:<24} {cluster_size}')
+        print("")
 
 
 QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
-- 
1.8.3.1


