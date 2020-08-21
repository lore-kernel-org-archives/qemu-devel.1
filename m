Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BD2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127382177B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UfUEOe5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127382177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97lM-0003iO-Ba
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97iy-0007HY-Eo
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97iw-0004XR-HS
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598018933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ITtCRSoAJ/tFdQGx3yupOIQKm7eEYRXmBMA6aBINiA=;
 b=UfUEOe5oXikZxY+GL9tCjcxAyE1ZJrEzEueF3MubAfZF39wFG3gMmohhVOFD7IlF1aH4Xt
 B8SFH33cA5sKQCnLnkqGFwl/lo2B2pMGPZ4rFWzfczTJR1jDPCb0izh9OAOvtfriI8XurQ
 MZqX4ogWXgkzTwqZBTYNYWXt1QjeQu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-QRQJ3Gu2MpGGZwHc164rgA-1; Fri, 21 Aug 2020 10:08:37 -0400
X-MC-Unique: QRQJ3Gu2MpGGZwHc164rgA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C375A85C70A;
 Fri, 21 Aug 2020 14:08:35 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-220.phx2.redhat.com [10.3.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CAC87AEC9;
 Fri, 21 Aug 2020 14:08:32 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/14] qcow2_format.py: pass cluster size to substructures
Date: Fri, 21 Aug 2020 09:08:18 -0500
Message-Id: <20200821140826.194322-7-eblake@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

The cluster size of an image is the QcowHeader class member and may be
obtained by dependent extension structures such as Qcow2BitmapExt for
further bitmap table details print.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1596742557-320265-7-git-send-email-andrey.shinkevich@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/qcow2_format.py | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 05a8aa98f72c..ca0d3501e0a2 100644
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
2.28.0


