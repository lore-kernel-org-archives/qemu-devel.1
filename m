Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F29FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 00:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C8D20835
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 00:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C8D20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjXGe-0000u1-MJ
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 20:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjXC3-0008NP-Pg; Thu, 11 Jun 2020 20:05:11 -0400
Received: from relay.sw.ru ([185.231.240.75]:52838 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjXBy-0006IB-Oy; Thu, 11 Jun 2020 20:05:11 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jjXBr-0002Yd-Lz; Fri, 12 Jun 2020 03:04:59 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 5/9] qcow2_format.py: pass cluster size to substructures
Date: Fri, 12 Jun 2020 03:04:58 +0300
Message-Id: <1591920302-1002219-6-git-send-email-andrey.shinkevich@virtuozzo.com>
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

The cluster size of an image is the QcowHeader class member and may be
obtained by dependent extension structures such as Qcow2BitmapExt for
further bitmap table details print.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 90eff92..eb99119 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -116,6 +116,10 @@ class Qcow2BitmapExt(Qcow2Struct):
         ('u64', '{:#x}', 'bitmap_directory_offset')
     )
 
+    def __init__(self, data, cluster_size):
+        super().__init__(data=data)
+        self.cluster_size = cluster_size
+
     def read_bitmap_directory(self, fd):
         self.bitmaps = []
         fd.seek(self.bitmap_directory_offset)
@@ -123,7 +127,8 @@ class Qcow2BitmapExt(Qcow2Struct):
 
         for n in range(self.nb_bitmaps):
             buf = fd.read(buf_size)
-            dir_entry = Qcow2BitmapDirEntry(data=buf)
+            dir_entry = Qcow2BitmapDirEntry(data=buf,
+                                            cluster_size=self.cluster_size)
             fd.seek(dir_entry.extra_data_size, FROM_CURRENT)
             bitmap_name = fd.read(dir_entry.name_size)
             dir_entry.name = bitmap_name.decode('ascii')
@@ -159,8 +164,9 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
         ('u32', '{}',    'extra_data_size')
     )
 
-    def __init__(self, data):
+    def __init__(self, data, cluster_size):
         super().__init__(data=data)
+        self.cluster_size = cluster_size
 
         self.bitmap_table_bytes = self.bitmap_table_size \
             * struct.calcsize('Q')
@@ -205,11 +211,13 @@ class QcowHeaderExtension(Qcow2Struct):
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
@@ -243,7 +251,8 @@ class QcowHeaderExtension(Qcow2Struct):
         self.data_str = data_str
 
         if self.magic == QCOW2_EXT_MAGIC_BITMAPS:
-            self.obj = Qcow2BitmapExt(data=self.data)
+            self.obj = Qcow2BitmapExt(data=self.data,
+                                      cluster_size=cluster_size)
         else:
             self.obj = None
 
@@ -318,7 +327,7 @@ class QcowHeader(Qcow2Struct):
             end = self.cluster_size
 
         while fd.tell() < end:
-            ext = QcowHeaderExtension(fd=fd)
+            ext = QcowHeaderExtension(fd=fd, cluster_size=self.cluster_size)
             if ext.magic == 0:
                 break
             else:
-- 
1.8.3.1


