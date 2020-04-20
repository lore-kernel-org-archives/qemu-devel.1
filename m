Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2E6C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497C320857
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfpkXb8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497C320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWbr-0001fe-EC
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 09:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60918 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jQWXl-0004N8-FL
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:33:06 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jQWXd-0004iI-1H
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:33:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52509
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jQWXc-0004dw-Fv
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587389570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2XnrMwGu/xHrxu+4elEdDQvksopg+zhKpBMUt0ExzpQ=;
 b=IfpkXb8GGxFxILKvrDsCYM3qVtNem1FU2deZe7jY0KTr5ozHRhvbM5FwRB2EeYkWfMpq2u
 KjUi3ShMMPj+FoNjtzp7Q3fHz1YMIUAy8mzwViQEDPr6O9uMHhOvwCz6y1b3dDwKd9gA86
 4cIgv1mKZAXeWhmidYGSqge2CN5o8Bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-9U83nwtZMpGQUB-bF50CLA-1; Mon, 20 Apr 2020 09:32:48 -0400
X-MC-Unique: 9U83nwtZMpGQUB-bF50CLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C376DDBA9;
 Mon, 20 Apr 2020 13:32:47 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-38.ams2.redhat.com [10.36.114.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B1ED118DF5;
 Mon, 20 Apr 2020 13:32:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 8/9] iotests: Filter testfiles out in img_info_log()
Date: Mon, 20 Apr 2020 15:32:13 +0200
Message-Id: <20200420133214.28921-9-kwolf@redhat.com>
In-Reply-To: <20200420133214.28921-1-kwolf@redhat.com>
References: <20200420133214.28921-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 04:32:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This changes the output of some files where instead of filter_img_info()
now filter_testfiles() takes precedence, so update the reference output.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py |  5 ++++-
 tests/qemu-iotests/206.out    | 12 ++++++------
 tests/qemu-iotests/242.out    | 12 ++++++------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7bc4934cd2..3eaf29411b 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -152,7 +152,10 @@ def img_info_log(filename, filter_path=3DNone, imgopts=
=3DFalse, extra_args=3D[]):
     output =3D qemu_img_pipe(*args)
     if not filter_path:
         filter_path =3D filename
-    log(filter_img_info(output, filter_path))
+
+    output =3D filter_testfiles(output)
+    output =3D filter_img_info(output, filter_path)
+    log(output)
=20
 def qemu_io(*args):
     '''Run qemu-io and return the stdout data'''
diff --git a/tests/qemu-iotests/206.out b/tests/qemu-iotests/206.out
index 61e7241e0b..adde82f9b8 100644
--- a/tests/qemu-iotests/206.out
+++ b/tests/qemu-iotests/206.out
@@ -12,7 +12,7 @@
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-image: TEST_IMG
+image: TEST_DIR/PID-t.IMGFMT
 file format: IMGFMT
 virtual size: 128 MiB (134217728 bytes)
 cluster_size: 65536
@@ -34,7 +34,7 @@ Format specific information:
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-image: TEST_IMG
+image: TEST_DIR/PID-t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
 cluster_size: 65536
@@ -56,7 +56,7 @@ Format specific information:
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-image: TEST_IMG
+image: TEST_DIR/PID-t.IMGFMT
 file format: IMGFMT
 virtual size: 32 MiB (33554432 bytes)
 cluster_size: 2097152
@@ -78,11 +78,11 @@ Format specific information:
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-image: TEST_IMG
+image: TEST_DIR/PID-t.IMGFMT
 file format: IMGFMT
 virtual size: 32 MiB (33554432 bytes)
 cluster_size: 512
-backing file: TEST_IMG.base
+backing file: TEST_DIR/PID-t.IMGFMT.base
 backing file format: IMGFMT
 Format specific information:
     compat: 0.10
@@ -95,7 +95,7 @@ Format specific information:
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
-image: TEST_IMG
+image: TEST_DIR/PID-t.IMGFMT
 file format: IMGFMT
 virtual size: 32 MiB (33554432 bytes)
 encrypted: yes
diff --git a/tests/qemu-iotests/242.out b/tests/qemu-iotests/242.out
index 7ac8404d11..0cc3a78bb2 100644
--- a/tests/qemu-iotests/242.out
+++ b/tests/qemu-iotests/242.out
@@ -6,7 +6,7 @@ wrote 262144/262144 bytes at offset 0
=20
 qemu-img info dump:
=20
-image: TEST_IMG
+image: TEST_DIR/PID-disk
 file format: IMGFMT
 virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
@@ -26,7 +26,7 @@ wrote 262144/262144 bytes at offset 262144
=20
 qemu-img info dump:
=20
-image: TEST_IMG
+image: TEST_DIR/PID-disk
 file format: IMGFMT
 virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
@@ -58,7 +58,7 @@ wrote 262144/262144 bytes at offset 524288
=20
 qemu-img info dump:
=20
-image: TEST_IMG
+image: TEST_DIR/PID-disk
 file format: IMGFMT
 virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
@@ -98,7 +98,7 @@ Test 4
 Checking "in-use" flag...
 qemu-img info dump:
=20
-image: TEST_IMG
+image: TEST_DIR/PID-disk
 file format: IMGFMT
 virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
@@ -143,11 +143,11 @@ Test 5
 {"execute": "block-dirty-bitmap-add", "arguments": {"disabled": false, "gr=
anularity": 16384, "name": "bitmap-0", "node": "drive0", "persistent": true=
}}
 {"return": {}}
 Write an unknown bitmap flag '0x4' into a new QCOW2 image at offset 327695
-qemu-img: Could not open 'TEST_IMG': Bitmap 'bitmap-0' doesn't satisfy the=
 constraints
+qemu-img: Could not open 'TEST_DIR/PID-disk': Bitmap 'bitmap-0' doesn't sa=
tisfy the constraints
=20
 Unset the unknown bitmap flag '0x4' in the bitmap directory entry:
=20
-image: TEST_IMG
+image: TEST_DIR/PID-disk
 file format: IMGFMT
 virtual size: 1 MiB (1048576 bytes)
 cluster_size: 65536
--=20
2.20.1


