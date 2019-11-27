Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350DAC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32C32068E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JifsjBES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32C32068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZw6D-0001h8-3Q
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 07:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZw5P-0001Hl-3G
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:06:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZw5N-0005zI-8l
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:06:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44693
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZw5N-0005z5-5O
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574856380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AVHED5i48SVpCTqJ7GfKU6p0cdBwsBBw/lFZ1WCgBSI=;
 b=JifsjBESqeoPN1fgiIAROnnOfGlaAAT+eTQFuWELcW6DiaUo556GWVqB/uNAjjNQjFkd7Y
 RdtMHphFDCCZ51h4MpnL0devodPhyoXOUZv1WfAcGbcL5fKdi8wvnjRuJquxSJ0Xl023am
 giZqSlSUdKENgD7qAmwu+OoWwVPXSqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-gOwXNsziO4KsHzuyJbdRSg-1; Wed, 27 Nov 2019 07:06:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EFC3184CAA6;
 Wed, 27 Nov 2019 12:06:16 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05AA33BE;
 Wed, 27 Nov 2019 12:06:15 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests/273: Filter format-specific information
Date: Wed, 27 Nov 2019 13:06:14 +0100
Message-Id: <20191127120614.513834-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: gOwXNsziO4KsHzuyJbdRSg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Doing this allows running this test with e.g. -o compat=3D0.10 or
-o compat=3Drefcount_bits=3D1.

Signed-off-by: Max Reitz <mreitz@redhat.com>
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
2.23.0


