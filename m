Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74823C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48CA72074B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CA72074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjUgL-0001Dp-En
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 17:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjUbj-000363-S3; Thu, 11 Jun 2020 17:19:31 -0400
Received: from relay.sw.ru ([185.231.240.75]:40358 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjUbf-00057n-7e; Thu, 11 Jun 2020 17:19:31 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjUbW-0001xE-S3; Fri, 12 Jun 2020 00:19:18 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 5/8] qcow2_format.py: Dump bitmap table serialized entries
Date: Fri, 12 Jun 2020 00:19:17 +0300
Message-Id: <1591910360-867499-6-git-send-email-andrey.shinkevich@virtuozzo.com>
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

Add bitmap table information to the QCOW2 metadata dump.

Bitmap name               bitmap-1
...
Bitmap table    type            offset          size
        0       serialized      0xa0000         65536
        1       all-zeroes      0x0             65536
        2       all-zeroes      0x0             65536
        3       all-zeroes      0x0             65536
        4       all-zeroes      0x0             65536
        5       all-zeroes      0x0             65536
        6       all-zeroes      0x0             65536
        7       all-zeroes      0x0             65536

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/qcow2_format.py | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 6589f68..2e7c058 100644
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
@@ -188,6 +197,39 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
             print(f'{"flag":<25} {fl}')
         print(f'{"table size ":<25} {self.bitmap_table_bytes} {"(bytes)"}')
         super().dump()
+        self.bitmap_table.print_bitmap_table(self.cluster_size)
+
+
+class Qcow2BitmapTableEntry:
+
+    BME_TABLE_ENTRY_OFFSET_MASK = 0x00fffffffffffe00
+    BME_TABLE_ENTRY_FLAG_ALL_ONES = 1
+    bmte_type = ['all-zeroes', 'all-ones', 'serialized']
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
+        print("Bitmap table\ttype\t\toffset\t\tsize")
+        for i, entry in bitmap_table:
+            print("\t%-4d\t%s\t%#x\t\t%d" % (i, entry.type, entry.offset,
+                                             cluster_size))
+        print("")
 
 
 QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
-- 
1.8.3.1


