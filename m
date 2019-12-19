Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3CFC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5545D21655
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wfwmh2kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5545D21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzeL-0005Oz-9G
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzY8-0006fa-EN
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzY6-0007BE-Og
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28741
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzY5-00078G-BB
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XP3z2u17AeMkGWh3JcAijiW2am7KHBDX5/Yd+Ds14ZY=;
 b=Wfwmh2kpX1R5fualBLVsJ6Mzq2hSM/7hEVZoYlLLEmhL3C+j9xJRCO9evyQ69wUHQ9yHhL
 UL7jKkY036iNVi8nPLDm5rpNPERHk6kXN6G+uu2phkT53HiyWEg+51hssPnnK8Mlsk8AVt
 rm+tfYbkyxdjh/t70A08LrhbZ6i70Vs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-vgKE5_FSMVixmU9BwmzVjA-1; Thu, 19 Dec 2019 12:25:12 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46F8E800D4C;
 Thu, 19 Dec 2019 17:25:11 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A430563B95;
 Thu, 19 Dec 2019 17:25:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 15/30] iotests/273: Filter format-specific information
Date: Thu, 19 Dec 2019 18:24:26 +0100
Message-Id: <20191219172441.7289-16-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
References: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: vgKE5_FSMVixmU9BwmzVjA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Doing this allows running this test with e.g. -o compat=3D0.10 or
-o compat=3Drefcount_bits=3D1.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/273     |  3 ++-
 tests/qemu-iotests/273.out | 27 ---------------------------
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/tests/qemu-iotests/273 b/tests/qemu-iotests/273
index 98a672516d..d598c47d9b 100755
--- a/tests/qemu-iotests/273
+++ b/tests/qemu-iotests/273
@@ -48,7 +48,8 @@ do_run_qemu()
 run_qemu()
 {
     do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp |
-        _filter_generated_node_ids | _filter_imgfmt | _filter_actual_image=
_size
+        _filter_generated_node_ids | _filter_imgfmt |
+        _filter_actual_image_size | _filter_img_info
 }
=20
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
diff --git a/tests/qemu-iotests/273.out b/tests/qemu-iotests/273.out
index c410fee5c4..684b8d6f77 100644
--- a/tests/qemu-iotests/273.out
+++ b/tests/qemu-iotests/273.out
@@ -38,15 +38,6 @@ Testing: -blockdev file,node-name=3Dbase,filename=3DTEST=
_DIR/t.IMGFMT.base -blockdev
                     "cluster-size": 65536,
                     "format": "IMGFMT",
                     "actual-size": SIZE,
-                    "format-specific": {
-                        "type": "IMGFMT",
-                        "data": {
-                            "compat": "1.1",
-                            "lazy-refcounts": false,
-                            "refcount-bits": 16,
-                            "corrupt": false
-                        }
-                    },
                     "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
                     "backing-filename": "TEST_DIR/t.IMGFMT.base",
                     "dirty-flag": false
@@ -57,15 +48,6 @@ Testing: -blockdev file,node-name=3Dbase,filename=3DTEST=
_DIR/t.IMGFMT.base -blockdev
                 "cluster-size": 65536,
                 "format": "IMGFMT",
                 "actual-size": SIZE,
-                "format-specific": {
-                    "type": "IMGFMT",
-                    "data": {
-                        "compat": "1.1",
-                        "lazy-refcounts": false,
-                        "refcount-bits": 16,
-                        "corrupt": false
-                    }
-                },
                 "full-backing-filename": "TEST_DIR/t.IMGFMT.mid",
                 "backing-filename": "TEST_DIR/t.IMGFMT.mid",
                 "dirty-flag": false
@@ -136,15 +118,6 @@ Testing: -blockdev file,node-name=3Dbase,filename=3DTE=
ST_DIR/t.IMGFMT.base -blockdev
                 "cluster-size": 65536,
                 "format": "IMGFMT",
                 "actual-size": SIZE,
-                "format-specific": {
-                    "type": "IMGFMT",
-                    "data": {
-                        "compat": "1.1",
-                        "lazy-refcounts": false,
-                        "refcount-bits": 16,
-                        "corrupt": false
-                    }
-                },
                 "full-backing-filename": "TEST_DIR/t.IMGFMT.base",
                 "backing-filename": "TEST_DIR/t.IMGFMT.base",
                 "dirty-flag": false
--=20
2.20.1


