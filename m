Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71968C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C69820FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQJ2hNUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C69820FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97kl-0002Oh-Be
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97j0-0007Md-42
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21958
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97ix-0004Xd-5j
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598018934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dFTJI66gXbHFJpiFeUt37MLvYmD4RYoxQkVSz55LzJM=;
 b=CQJ2hNUcIdQ79whHcWqgGE46c5FfKLQ23u9LgJ1LKumdPqKvRzkvoqJClDRZV34uAPYpaA
 PQYO6I6anwl++yclR3lqWgGXFWfuWA6jmvtJX7WuPkDBokHKfK16sClFadLj6RW0ry69DB
 75kZoP12wayCvvPUKdu6cO8ixHdM3yQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-co64W7f9MSOUk9jMUFP85Q-1; Fri, 21 Aug 2020 10:08:37 -0400
X-MC-Unique: co64W7f9MSOUk9jMUFP85Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65B1B101962B;
 Fri, 21 Aug 2020 14:08:36 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-220.phx2.redhat.com [10.3.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED4D07AEC9;
 Fri, 21 Aug 2020 14:08:35 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/14] qcow2_format.py: Dump bitmap table serialized entries
Date: Fri, 21 Aug 2020 09:08:19 -0500
Message-Id: <20200821140826.194322-8-eblake@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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

Add bitmap table information to the QCOW2 metadata dump.

Bitmap name               bitmap-1
...
Bitmap table   type            size         offset
0              serialized      65536        10092544
1              all-zeroes      0            0
2              all-zeroes      0            0

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1596742557-320265-8-git-send-email-andrey.shinkevich@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/303.out         |  4 +++
 tests/qemu-iotests/qcow2_format.py | 50 ++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/tests/qemu-iotests/303.out b/tests/qemu-iotests/303.out
index 038ba93a87d7..70828e05f11f 100644
--- a/tests/qemu-iotests/303.out
+++ b/tests/qemu-iotests/303.out
@@ -66,6 +66,8 @@ type                      1
 granularity_bits          15
 name_size                 8
 extra_data_size           0
+Bitmap table   type            size         offset
+0              serialized      65536        10092544

 Bitmap name               bitmap-2
 bitmap_table_offset       0x9c0000
@@ -75,4 +77,6 @@ type                      1
 granularity_bits          16
 name_size                 8
 extra_data_size           0
+Bitmap table   type            size         offset
+0              all-zeroes      0            0

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index ca0d3501e0a2..574249bc463c 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -175,6 +175,10 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
         entry_raw_size = self.bitmap_dir_entry_raw_size()
         padding = ((entry_raw_size + 7) & ~7) - entry_raw_size
         fd.seek(padding, 1)
+        self.bitmap_table = Qcow2BitmapTable(fd=fd,
+                                             offset=self.bitmap_table_offset,
+                                             nb_entries=self.bitmap_table_size,
+                                             cluster_size=self.cluster_size)

     def bitmap_dir_entry_raw_size(self):
         return struct.calcsize(self.fmt) + self.name_size + \
@@ -183,6 +187,52 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
     def dump(self):
         print(f'{"Bitmap name":<25} {self.name}')
         super(Qcow2BitmapDirEntry, self).dump()
+        self.bitmap_table.dump()
+
+
+class Qcow2BitmapTableEntry(Qcow2Struct):
+
+    fields = (
+        ('u64',  '{}', 'entry'),
+    )
+
+    BME_TABLE_ENTRY_RESERVED_MASK = 0xff000000000001fe
+    BME_TABLE_ENTRY_OFFSET_MASK = 0x00fffffffffffe00
+    BME_TABLE_ENTRY_FLAG_ALL_ONES = 1
+
+    def __init__(self, fd):
+        super().__init__(fd=fd)
+        self.reserved = self.entry & self.BME_TABLE_ENTRY_RESERVED_MASK
+        self.offset = self.entry & self.BME_TABLE_ENTRY_OFFSET_MASK
+        if self.offset:
+            if self.entry & self.BME_TABLE_ENTRY_FLAG_ALL_ONES:
+                self.type = 'invalid'
+            else:
+                self.type = 'serialized'
+        elif self.entry & self.BME_TABLE_ENTRY_FLAG_ALL_ONES:
+            self.type = 'all-ones'
+        else:
+            self.type = 'all-zeroes'
+
+
+class Qcow2BitmapTable:
+
+    def __init__(self, fd, offset, nb_entries, cluster_size):
+        self.cluster_size = cluster_size
+        position = fd.tell()
+        fd.seek(offset)
+        self.entries = [Qcow2BitmapTableEntry(fd) for _ in range(nb_entries)]
+        fd.seek(position)
+
+    def dump(self):
+        bitmap_table = enumerate(self.entries)
+        print(f'{"Bitmap table":<14} {"type":<15} {"size":<12} {"offset"}')
+        for i, entry in bitmap_table:
+            if entry.type == 'serialized':
+                size = self.cluster_size
+            else:
+                size = 0
+            print(f'{i:<14} {entry.type:<15} {size:<12} {entry.offset}')


 QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
-- 
2.28.0


