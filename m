Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ACEC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 19:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9FBE24655
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 19:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQh/rrvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FBE24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irS9f-0001xG-2P
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 14:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1irRyQ-0003LW-RV
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1irRyN-0007oq-KF
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:35:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53699
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1irRyN-0007nE-Gq
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579030531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V/E8chs2P88S+DZ+voRqJwD6HlRvP4yhEAQqXQdSGnM=;
 b=ZQh/rrvLBZggutO/pBAPkn/fGXZYhkrRRUpFwkXyuiC4mcAdIJd5+juqWM/9ZFy+Xhq4xr
 CRcdmJjTAMDatqEjtj1FQfo1GE15dmfyJQqQsG0lWaNq6EGHO9UxvVqYEk271BwLNzleQg
 Jb+xNIjJ4XohnheNwpFPtqKfJHir3QI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-_ph_fYAoNJSgBgMrHdmDDg-1; Tue, 14 Jan 2020 14:34:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 416A4100551C;
 Tue, 14 Jan 2020 19:34:21 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 052C37C83A;
 Tue, 14 Jan 2020 19:34:18 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/13] iotests: filter few more luks specific create options
Date: Tue, 14 Jan 2020 21:33:45 +0200
Message-Id: <20200114193350.10830-9-mlevitsk@redhat.com>
In-Reply-To: <20200114193350.10830-1-mlevitsk@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _ph_fYAoNJSgBgMrHdmDDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows more tests to be able to have same output on both qcow2 luks en=
crypted images
and raw luks images

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/087.out       | 6 +++---
 tests/qemu-iotests/134.out       | 2 +-
 tests/qemu-iotests/158.out       | 4 ++--
 tests/qemu-iotests/188.out       | 2 +-
 tests/qemu-iotests/189.out       | 4 ++--
 tests/qemu-iotests/198.out       | 4 ++--
 tests/qemu-iotests/common.filter | 6 ++++--
 7 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index 2d92ea847b..b61ba638af 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -34,7 +34,7 @@ QMP_VERSION
=20
 =3D=3D=3D Encrypted image QCow =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encryption=
=3Don encrypt.key-secret=3Dsec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encryption=
=3Don
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -46,7 +46,7 @@ QMP_VERSION
=20
 =3D=3D=3D Encrypted image LUKS =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encrypt.form=
at=3Dluks encrypt.key-secret=3Dsec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -58,7 +58,7 @@ QMP_VERSION
=20
 =3D=3D=3D Missing driver =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encryption=
=3Don encrypt.key-secret=3Dsec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encryption=
=3Don
 Testing: -S
 QMP_VERSION
 {"return": {}}
diff --git a/tests/qemu-iotests/134.out b/tests/qemu-iotests/134.out
index 09d46f6b17..4abc5b5f7d 100644
--- a/tests/qemu-iotests/134.out
+++ b/tests/qemu-iotests/134.out
@@ -1,5 +1,5 @@
 QA output created by 134
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encryption=
=3Don encrypt.key-secret=3Dsec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 encryption=
=3Don
=20
 =3D=3D reading whole image =3D=3D
 read 134217728/134217728 bytes at offset 0
diff --git a/tests/qemu-iotests/158.out b/tests/qemu-iotests/158.out
index 6def216e55..f28a17626b 100644
--- a/tests/qemu-iotests/158.out
+++ b/tests/qemu-iotests/158.out
@@ -1,6 +1,6 @@
 QA output created by 158
 =3D=3D create base =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728 encrypt=
ion=3Don encrypt.key-secret=3Dsec0
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728 encrypt=
ion=3Don
=20
 =3D=3D writing whole image =3D=3D
 wrote 134217728/134217728 bytes at offset 0
@@ -10,7 +10,7 @@ wrote 134217728/134217728 bytes at offset 0
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 =3D=3D create overlay =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base encryption=3Don encrypt.key-secret=3Dsec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base encryption=3Don
=20
 =3D=3D writing part of a cluster =3D=3D
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/188.out b/tests/qemu-iotests/188.out
index c568ef3701..5426861b18 100644
--- a/tests/qemu-iotests/188.out
+++ b/tests/qemu-iotests/188.out
@@ -1,5 +1,5 @@
 QA output created by 188
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 encrypt.forma=
t=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216
=20
 =3D=3D reading whole image =3D=3D
 read 16777216/16777216 bytes at offset 0
diff --git a/tests/qemu-iotests/189.out b/tests/qemu-iotests/189.out
index a0b7c9c24c..bc213cbe14 100644
--- a/tests/qemu-iotests/189.out
+++ b/tests/qemu-iotests/189.out
@@ -1,6 +1,6 @@
 QA output created by 189
 =3D=3D create base =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D16777216 encrypt.=
format=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D16777216
=20
 =3D=3D writing whole image =3D=3D
 wrote 16777216/16777216 bytes at offset 0
@@ -10,7 +10,7 @@ wrote 16777216/16777216 bytes at offset 0
 read 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 =3D=3D create overlay =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 backing_file=
=3DTEST_DIR/t.IMGFMT.base encrypt.format=3Dluks encrypt.key-secret=3Dsec1 e=
ncrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 backing_file=
=3DTEST_DIR/t.IMGFMT.base
=20
 =3D=3D writing part of a cluster =3D=3D
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index 831ce3a289..acfdf96b0c 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -1,12 +1,12 @@
 QA output created by 198
 =3D=3D create base =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D16777216 encrypt.=
format=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D16777216
=20
 =3D=3D writing whole image base =3D=3D
 wrote 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 =3D=3D create overlay =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 backing_file=
=3DTEST_DIR/t.IMGFMT.base encrypt.format=3Dluks encrypt.key-secret=3Dsec1 e=
ncrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 backing_file=
=3DTEST_DIR/t.IMGFMT.base
=20
 =3D=3D writing whole image layer =3D=3D
 wrote 16777216/16777216 bytes at offset 0
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.f=
ilter
index 3f8ee3e5f7..bcc4495d52 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -150,8 +150,10 @@ _filter_img_create()
         -e "s# block_state_zero=3D\\(on\\|off\\)##g" \
         -e "s# log_size=3D[0-9]\\+##g" \
         -e "s# refcount_bits=3D[0-9]\\+##g" \
-        -e "s# key-secret=3D[a-zA-Z0-9]\\+##g" \
-        -e "s# iter-time=3D[0-9]\\+##g" \
+        -e "s# \\(encrypt\\.\\)\\?key-secret=3D[a-zA-Z0-9]\\+##g" \
+        -e "s# \\(encrypt\\.\\)\\?slot=3D[0-9]\\+##g" \
+        -e "s# \\(encrypt\\.\\)\\?iter-time=3D[0-9]\\+##g" \
+        -e "s# encrypt\\.format=3D[a-zA-Z0-9]\\+##g" \
         -e "s# force_size=3D\\(on\\|off\\)##g"
 }
=20
--=20
2.17.2


