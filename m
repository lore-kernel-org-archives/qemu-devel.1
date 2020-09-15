Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1B5C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B444206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJd+r8e6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B444206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8Xj-0005fW-1M
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8Tz-0000Km-SD
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:46:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24212
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8Tw-0004WW-Nb
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJPpvV6IltYiPr20vjj9EGkrUcbzVVF1bqmrz/6gk+c=;
 b=WJd+r8e6vr64Hraa/m5W8OR0mS28yoGRRqGoW+V1kkDpK28eFPxU/gadOA8RObvFbF6AYg
 uXzjt4P7baqoQTgvDOvKHP8gkTsqwwmmUAd0EPSpXQRmfEp/6BOo8UDwbVpijndNycSw1I
 io3v8xOXMsfBw1fC2nkESlitDCCBbsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-eY1XsI4mOOyxmnMdevQvwg-1; Tue, 15 Sep 2020 06:46:37 -0400
X-MC-Unique: eY1XsI4mOOyxmnMdevQvwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64BEF801F9B;
 Tue, 15 Sep 2020 10:46:36 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 063F15DC08;
 Tue, 15 Sep 2020 10:46:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 03/22] qemu-iotests: Support varargs syntax in FilePaths
Date: Tue, 15 Sep 2020 12:46:08 +0200
Message-Id: <20200915104627.699552-4-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
References: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
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

Accept variable number of names instead of a sequence:

    with FilePaths("a", "b", "c") as (a, b, c):

The disadvantage is that base_dir must be used as kwarg:

    with FilePaths("a", "b", base_dir=soc_dir) as (sock1, sock2):

But this is more clear and calling optional argument as positional
arguments is bad idea anyway.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200828232152.205833-4-nsoffer@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/194        |  4 ++--
 tests/qemu-iotests/257        | 10 ++++------
 tests/qemu-iotests/iotests.py |  8 ++++----
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index da7c4265ec..08389f474e 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -26,8 +26,8 @@ iotests.script_initialize(supported_fmts=['qcow2', 'qed', 'raw'],
 
 with iotests.FilePath('source.img') as source_img_path, \
      iotests.FilePath('dest.img') as dest_img_path, \
-     iotests.FilePaths(['migration.sock', 'nbd.sock'], iotests.sock_dir) as \
-         [migration_sock_path, nbd_sock_path], \
+     iotests.FilePaths('migration.sock', 'nbd.sock', base_dir=iotests.sock_dir) \
+        as (migration_sock_path, nbd_sock_path), \
      iotests.VM('source') as source_vm, \
      iotests.VM('dest') as dest_vm:
 
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index e1e6077219..a9aa65bbe3 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -275,10 +275,9 @@ def test_bitmap_sync(bsync_mode, msync_mode='bitmap', failure=None):
                         an incomplete backup. Testing limitations prevent
                         testing competing writes.
     """
-    with iotests.FilePaths(['img', 'bsync1', 'bsync2',
-                            'fbackup0', 'fbackup1', 'fbackup2']) as \
-                            (img_path, bsync1, bsync2,
-                             fbackup0, fbackup1, fbackup2), \
+    with iotests.FilePaths(
+            'img', 'bsync1', 'bsync2', 'fbackup0', 'fbackup1', 'fbackup2') as \
+            (img_path, bsync1, bsync2, fbackup0, fbackup1, fbackup2), \
          iotests.VM() as vm:
 
         mode = "Mode {:s}; Bitmap Sync {:s}".format(msync_mode, bsync_mode)
@@ -441,8 +440,7 @@ def test_backup_api():
     """
     Test malformed and prohibited invocations of the backup API.
     """
-    with iotests.FilePaths(['img', 'bsync1']) as \
-         (img_path, backup_path), \
+    with iotests.FilePaths('img', 'bsync1') as (img_path, backup_path), \
          iotests.VM() as vm:
 
         log("\n=== API failure tests ===\n")
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index bbe63a6da0..635ec99431 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -455,7 +455,7 @@ class FilePaths:
 
     Example usage:
 
-        with FilePaths(['a.img', 'b.img']) as (img_a, img_b):
+        with FilePaths('a.img', 'b.img') as (img_a, img_b):
             # Use img_a and img_b here...
 
         # a.img and b.img are automatically removed here.
@@ -463,10 +463,10 @@ class FilePaths:
     By default images are created in iotests.test_dir. To create sockets use
     iotests.sock_dir:
 
-       with FilePaths(['a.sock'], base_dir=iotests.sock_dir) as (sock,):
+       with FilePaths('a.sock', base_dir=iotests.sock_dir) as (sock,):
 
     """
-    def __init__(self, names, base_dir=test_dir):
+    def __init__(self, *names, base_dir=test_dir):
         self.paths = []
         for name in names:
             self.paths.append(os.path.join(base_dir, file_pattern(name)))
@@ -487,7 +487,7 @@ class FilePath(FilePaths):
     FilePath is a specialization of FilePaths that takes a single filename.
     """
     def __init__(self, name, base_dir=test_dir):
-        super(FilePath, self).__init__([name], base_dir)
+        super(FilePath, self).__init__(name, base_dir=base_dir)
 
     def __enter__(self):
         return self.paths[0]
-- 
2.26.2


