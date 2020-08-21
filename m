Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0823FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51032177B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6krHWy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51032177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97oV-0001u5-Rm
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97iz-0007KF-Br
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46210
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97ix-0004Xg-8e
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598018934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ft+sZwk9gcDvF38VuUsUZ21PepdX21tQNatQ9qp1XgI=;
 b=Z6krHWy8fYMAbsQHxiLgJPLB2q3Tk78AzNFoOPAvDji4V8/esFUSj9h9/fdpAjNhtrWDmX
 4//T62zHVmVBdb26axNsNDKdzslRRAzon/DKnzOLyWtETthctp0/Xza9p0aI2AKx08iwue
 IJhkPeCFoNy6SBusW66a6zjFBdEgTRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-wIc2WR9CPPOCtde7RYdzLA-1; Fri, 21 Aug 2020 10:08:33 -0400
X-MC-Unique: wIc2WR9CPPOCtde7RYdzLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44A441019633;
 Fri, 21 Aug 2020 14:08:32 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-220.phx2.redhat.com [10.3.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE8617A40B;
 Fri, 21 Aug 2020 14:08:31 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/14] qcow2_format.py: Dump bitmap directory information
Date: Fri, 21 Aug 2020 09:08:17 -0500
Message-Id: <20200821140826.194322-6-eblake@redhat.com>
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

Read and dump entries from the bitmap directory of QCOW2 image.

Header extension:
magic                     0x23852875 (Bitmaps)
...
Bitmap name               bitmap-1
bitmap_table_offset       0xf0000
bitmap_table_size         1
flags                     0x2 (['auto'])
type                      1
granularity_bits          16
name_size                 8
extra_data_size           0

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1596742557-320265-6-git-send-email-andrey.shinkevich@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/303.out         | 18 ++++++++++++
 tests/qemu-iotests/qcow2_format.py | 47 ++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/tests/qemu-iotests/303.out b/tests/qemu-iotests/303.out
index 8d7973ccc201..038ba93a87d7 100644
--- a/tests/qemu-iotests/303.out
+++ b/tests/qemu-iotests/303.out
@@ -58,3 +58,21 @@ reserved32                0
 bitmap_directory_size     0x40
 bitmap_directory_offset   0x9d0000

+Bitmap name               bitmap-1
+bitmap_table_offset       0x9b0000
+bitmap_table_size         1
+flags                     0x2 (['auto'])
+type                      1
+granularity_bits          15
+name_size                 8
+extra_data_size           0
+
+Bitmap name               bitmap-2
+bitmap_table_offset       0x9c0000
+bitmap_table_size         1
+flags                     0x0 ([])
+type                      1
+granularity_bits          16
+name_size                 8
+extra_data_size           0
+
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index b4473442c9d4..05a8aa98f72c 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -134,6 +134,53 @@ class Qcow2BitmapExt(Qcow2Struct):
         tail = struct.calcsize(self.fmt) % 8
         if tail:
             fd.seek(8 - tail, 1)
+        position = fd.tell()
+        self.read_bitmap_directory(fd)
+        fd.seek(position)
+
+    def read_bitmap_directory(self, fd):
+        fd.seek(self.bitmap_directory_offset)
+        self.bitmap_directory = \
+            [Qcow2BitmapDirEntry(fd) for _ in range(self.nb_bitmaps)]
+
+    def dump(self):
+        super().dump()
+        for entry in self.bitmap_directory:
+            print()
+            entry.dump()
+
+
+class Qcow2BitmapDirEntry(Qcow2Struct):
+
+    fields = (
+        ('u64', '{:#x}', 'bitmap_table_offset'),
+        ('u32', '{}', 'bitmap_table_size'),
+        ('u32', BitmapFlags, 'flags'),
+        ('u8',  '{}', 'type'),
+        ('u8',  '{}', 'granularity_bits'),
+        ('u16', '{}', 'name_size'),
+        ('u32', '{}', 'extra_data_size')
+    )
+
+    def __init__(self, fd):
+        super().__init__(fd=fd)
+        # Seek relative to the current position in the file
+        fd.seek(self.extra_data_size, 1)
+        bitmap_name = fd.read(self.name_size)
+        self.name = bitmap_name.decode('ascii')
+        # Move position to the end of the entry in the directory
+        entry_raw_size = self.bitmap_dir_entry_raw_size()
+        padding = ((entry_raw_size + 7) & ~7) - entry_raw_size
+        fd.seek(padding, 1)
+
+    def bitmap_dir_entry_raw_size(self):
+        return struct.calcsize(self.fmt) + self.name_size + \
+            self.extra_data_size
+
+    def dump(self):
+        print(f'{"Bitmap name":<25} {self.name}')
+        super(Qcow2BitmapDirEntry, self).dump()
+

 QCOW2_EXT_MAGIC_BITMAPS = 0x23852875

-- 
2.28.0


