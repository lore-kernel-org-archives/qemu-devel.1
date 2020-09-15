Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4595DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6C9206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxyuPH2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6C9206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8YE-00068B-Qj
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8U1-0000Nm-Hz
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:46:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8Ty-0004Wq-C6
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=USfin5nSJkYWkXjVzSXutltb7DcQHN1F5Lbpdtqi6WA=;
 b=PxyuPH2HzZvJkwa3/ToE6hh5EKUVgdFKc6HaFOkUmvdoj0Yfst4Cmwnj6+2+XEFB0RGLSa
 E1Gx81IDkE6SylAkBSECRvtAWfu1sxc110s2YrMeRoe1E6zk62G8YwLzoSjCQMj23di94W
 CaJ4awjZxj0Yxvb4PtgR5+GXSwj6/LI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-rA5M_AUuM22sVZYHqmKAew-1; Tue, 15 Sep 2020 06:46:39 -0400
X-MC-Unique: rA5M_AUuM22sVZYHqmKAew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8580C10059AC;
 Tue, 15 Sep 2020 10:46:38 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B4FC5DDB5;
 Tue, 15 Sep 2020 10:46:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/22] qemu-iotests: Merge FilePaths and FilePath
Date: Tue, 15 Sep 2020 12:46:09 +0200
Message-Id: <20200915104627.699552-5-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
References: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nir Soffer <nirsof@gmail.com>

FilePath creates now one temporary file:

    with FilePath("a") as a:

Or more:

    with FilePath("a", "b", "c") as (a, b, c):

This is also the behavior of the file_path() helper, used by some of the
tests. Now we have only 2 helpers for creating temporary files instead
of 3.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200828232152.205833-5-nsoffer@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/194        |  2 +-
 tests/qemu-iotests/208        |  2 +-
 tests/qemu-iotests/222        |  2 +-
 tests/qemu-iotests/257        |  4 ++--
 tests/qemu-iotests/iotests.py | 23 ++++++++++-------------
 5 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 08389f474e..7a4863ab18 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -26,7 +26,7 @@ iotests.script_initialize(supported_fmts=['qcow2', 'qed', 'raw'],
 
 with iotests.FilePath('source.img') as source_img_path, \
      iotests.FilePath('dest.img') as dest_img_path, \
-     iotests.FilePaths('migration.sock', 'nbd.sock', base_dir=iotests.sock_dir) \
+     iotests.FilePath('migration.sock', 'nbd.sock', base_dir=iotests.sock_dir) \
         as (migration_sock_path, nbd_sock_path), \
      iotests.VM('source') as source_vm, \
      iotests.VM('dest') as dest_vm:
diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
index 6cb642f821..54aa4be273 100755
--- a/tests/qemu-iotests/208
+++ b/tests/qemu-iotests/208
@@ -26,7 +26,7 @@ iotests.script_initialize(supported_fmts=['generic'])
 
 with iotests.FilePath('disk.img') as disk_img_path, \
      iotests.FilePath('disk-snapshot.img') as disk_snapshot_img_path, \
-     iotests.FilePath('nbd.sock', iotests.sock_dir) as nbd_sock_path, \
+     iotests.FilePath('nbd.sock', base_dir=iotests.sock_dir) as nbd_sock_path, \
      iotests.VM() as vm:
 
     img_size = '10M'
diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
index 6602f6b4ba..14d67c875b 100755
--- a/tests/qemu-iotests/222
+++ b/tests/qemu-iotests/222
@@ -49,7 +49,7 @@ remainder = [("0xd5", "0x108000",  "32k"), # Right-end of partial-left [1]
 
 with iotests.FilePath('base.img') as base_img_path, \
      iotests.FilePath('fleece.img') as fleece_img_path, \
-     iotests.FilePath('nbd.sock', iotests.sock_dir) as nbd_sock_path, \
+     iotests.FilePath('nbd.sock', base_dir=iotests.sock_dir) as nbd_sock_path, \
      iotests.VM() as vm:
 
     log('--- Setting up images ---')
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index a9aa65bbe3..c80e06ae28 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -275,7 +275,7 @@ def test_bitmap_sync(bsync_mode, msync_mode='bitmap', failure=None):
                         an incomplete backup. Testing limitations prevent
                         testing competing writes.
     """
-    with iotests.FilePaths(
+    with iotests.FilePath(
             'img', 'bsync1', 'bsync2', 'fbackup0', 'fbackup1', 'fbackup2') as \
             (img_path, bsync1, bsync2, fbackup0, fbackup1, fbackup2), \
          iotests.VM() as vm:
@@ -440,7 +440,7 @@ def test_backup_api():
     """
     Test malformed and prohibited invocations of the backup API.
     """
-    with iotests.FilePaths('img', 'bsync1') as (img_path, backup_path), \
+    with iotests.FilePath('img', 'bsync1') as (img_path, backup_path), \
          iotests.VM() as vm:
 
         log("\n=== API failure tests ===\n")
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 635ec99431..1799338f8b 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -448,14 +448,14 @@ class Timeout:
 def file_pattern(name):
     return "{0}-{1}".format(os.getpid(), name)
 
-class FilePaths:
+class FilePath:
     """
     Context manager generating multiple file names. The generated files are
     removed when exiting the context.
 
     Example usage:
 
-        with FilePaths('a.img', 'b.img') as (img_a, img_b):
+        with FilePath('a.img', 'b.img') as (img_a, img_b):
             # Use img_a and img_b here...
 
         # a.img and b.img are automatically removed here.
@@ -463,7 +463,10 @@ class FilePaths:
     By default images are created in iotests.test_dir. To create sockets use
     iotests.sock_dir:
 
-       with FilePaths('a.sock', base_dir=iotests.sock_dir) as (sock,):
+       with FilePath('a.sock', base_dir=iotests.sock_dir) as sock:
+
+    For convenience, calling with one argument yields a single file instead of
+    a tuple with one item.
 
     """
     def __init__(self, *names, base_dir=test_dir):
@@ -472,7 +475,10 @@ class FilePaths:
             self.paths.append(os.path.join(base_dir, file_pattern(name)))
 
     def __enter__(self):
-        return self.paths
+        if len(self.paths) == 1:
+            return self.paths[0]
+        else:
+            return self.paths
 
     def __exit__(self, exc_type, exc_val, exc_tb):
         for path in self.paths:
@@ -482,15 +488,6 @@ class FilePaths:
                 pass
         return False
 
-class FilePath(FilePaths):
-    """
-    FilePath is a specialization of FilePaths that takes a single filename.
-    """
-    def __init__(self, name, base_dir=test_dir):
-        super(FilePath, self).__init__(name, base_dir=base_dir)
-
-    def __enter__(self):
-        return self.paths[0]
 
 def file_path_remover():
     for path in reversed(file_path_remover.paths):
-- 
2.26.2


