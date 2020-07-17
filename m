Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A3FC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 08:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DDD720737
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 08:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDD720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwLZr-0007yF-J8
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 04:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jwLWg-0002OP-Nx; Fri, 17 Jul 2020 04:15:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:49986 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jwLWe-0007JM-FR; Fri, 17 Jul 2020 04:15:26 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jwLWC-0003cP-Me; Fri, 17 Jul 2020 11:14:56 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v11 06/11] qcow2_format.py: pass cluster size to substructures
Date: Fri, 17 Jul 2020 11:14:54 +0300
Message-Id: <1594973699-781898-7-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 04:15:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

The cluster size of an image is the QcowHeader class member and may be
obtained by dependent extension structures such as Qcow2BitmapExt for
further bitmap table details print.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 05a8aa9..ca0d350 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -129,19 +129,21 @@ class Qcow2BitmapExt(Qcow2Struct):
         ('u64', '{:#x}', 'bitmap_directory_offset')
     )
 
-    def __init__(self, fd):
+    def __init__(self, fd, cluster_size):
         super().__init__(fd=fd)
         tail = struct.calcsize(self.fmt) % 8
         if tail:
             fd.seek(8 - tail, 1)
         position = fd.tell()
+        self.cluster_size = cluster_size
         self.read_bitmap_directory(fd)
         fd.seek(position)
 
     def read_bitmap_directory(self, fd):
         fd.seek(self.bitmap_directory_offset)
         self.bitmap_directory = \
-            [Qcow2BitmapDirEntry(fd) for _ in range(self.nb_bitmaps)]
+            [Qcow2BitmapDirEntry(fd, cluster_size=self.cluster_size)
+             for _ in range(self.nb_bitmaps)]
 
     def dump(self):
         super().dump()
@@ -162,8 +164,9 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
         ('u32', '{}', 'extra_data_size')
     )
 
-    def __init__(self, fd):
+    def __init__(self, fd, cluster_size):
         super().__init__(fd=fd)
+        self.cluster_size = cluster_size
         # Seek relative to the current position in the file
         fd.seek(self.extra_data_size, 1)
         bitmap_name = fd.read(self.name_size)
@@ -203,11 +206,13 @@ class QcowHeaderExtension(Qcow2Struct):
         # then padding to next multiply of 8
     )
 
-    def __init__(self, magic=None, length=None, data=None, fd=None):
+    def __init__(self, magic=None, length=None, data=None, fd=None,
+                 cluster_size=None):
         """
         Support both loading from fd and creation from user data.
         For fd-based creation current position in a file will be used to read
         the data.
+        The cluster_size value may be obtained by dependent structures.
 
         This should be somehow refactored and functionality should be moved to
         superclass (to allow creation of any qcow2 struct), but then, fields
@@ -230,7 +235,7 @@ class QcowHeaderExtension(Qcow2Struct):
             assert all(v is None for v in (magic, length, data))
             super().__init__(fd=fd)
             if self.magic == QCOW2_EXT_MAGIC_BITMAPS:
-                self.obj = Qcow2BitmapExt(fd=fd)
+                self.obj = Qcow2BitmapExt(fd=fd, cluster_size=cluster_size)
                 self.data = None
             else:
                 padded = (self.length + 7) & ~7
@@ -319,7 +324,7 @@ class QcowHeader(Qcow2Struct):
             end = self.cluster_size
 
         while fd.tell() < end:
-            ext = QcowHeaderExtension(fd=fd)
+            ext = QcowHeaderExtension(fd=fd, cluster_size=self.cluster_size)
             if ext.magic == 0:
                 break
             else:
-- 
1.8.3.1


