Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415B3C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD402072A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/f+BqGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD402072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAxqP-0004XE-8x
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 11:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxiR-0000gB-E9
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxiP-0001j7-Qa
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24015
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jAxiO-0001iv-Sj
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583680780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Ah/tmZyr8UJx6UGn32u/Yn+vCUitWbQbZSebTWpa2Y=;
 b=D/f+BqGW9NpDBER1OEJPvRbt8hmyfC25PIT05sUHYnoPETmDcKv9D5ESjbYaSCwvwWLyM8
 uRCcmS+uk4n/xqtPCGVpseXp9bTleDEAof/erSMnSn4rPHEBu952S4GheEYMxWAjrK5LDe
 LKi0W72ndp2lM/NkWEOtzoYg9/pHZ5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-S5s8AQo0MKe3_i0kpDOlPQ-1; Sun, 08 Mar 2020 11:19:37 -0400
X-MC-Unique: S5s8AQo0MKe3_i0kpDOlPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2362184C800;
 Sun,  8 Mar 2020 15:19:35 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 978E65C1B0;
 Sun,  8 Mar 2020 15:19:33 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/14] iotests: filter few more luks specific create options
Date: Sun,  8 Mar 2020 17:18:58 +0200
Message-Id: <20200308151903.25941-10-mlevitsk@redhat.com>
In-Reply-To: <20200308151903.25941-1-mlevitsk@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 tests/qemu-iotests/263.out       | 4 ++--
 tests/qemu-iotests/284.out       | 6 +++---
 tests/qemu-iotests/common.filter | 6 ++++--
 9 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index f23bffbbf1..d5ff53302e 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -34,7 +34,7 @@ QMP_VERSION
=20
 =3D=3D=3D Encrypted image QCow =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don encrypt.key-s=
ecret=3Dsec0 size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don size=3D134217=
728
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -46,7 +46,7 @@ QMP_VERSION
=20
 =3D=3D=3D Encrypted image LUKS =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Dluks encrypt=
.key-secret=3Dsec0 size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -58,7 +58,7 @@ QMP_VERSION
=20
 =3D=3D=3D Missing driver =3D=3D=3D
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don encrypt.key-s=
ecret=3Dsec0 size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don size=3D134217=
728
 Testing: -S
 QMP_VERSION
 {"return": {}}
diff --git a/tests/qemu-iotests/134.out b/tests/qemu-iotests/134.out
index f2878f5f3a..e4733c0b81 100644
--- a/tests/qemu-iotests/134.out
+++ b/tests/qemu-iotests/134.out
@@ -1,5 +1,5 @@
 QA output created by 134
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don encrypt.key-s=
ecret=3Dsec0 size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don size=3D134217=
728
=20
 =3D=3D reading whole image =3D=3D
 read 134217728/134217728 bytes at offset 0
diff --git a/tests/qemu-iotests/158.out b/tests/qemu-iotests/158.out
index fa2294bb85..52ea9a488f 100644
--- a/tests/qemu-iotests/158.out
+++ b/tests/qemu-iotests/158.out
@@ -1,6 +1,6 @@
 QA output created by 158
 =3D=3D create base =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT encryption=3Don encrypt.=
key-secret=3Dsec0 size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT encryption=3Don size=3D1=
34217728
=20
 =3D=3D writing whole image =3D=3D
 wrote 134217728/134217728 bytes at offset 0
@@ -10,7 +10,7 @@ wrote 134217728/134217728 bytes at offset 0
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 =3D=3D create overlay =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don encrypt.key-s=
ecret=3Dsec0 size=3D134217728 backing_file=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encryption=3Don size=3D134217=
728 backing_file=3DTEST_DIR/t.IMGFMT.base
=20
 =3D=3D writing part of a cluster =3D=3D
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/188.out b/tests/qemu-iotests/188.out
index 4b9aadd51c..5426861b18 100644
--- a/tests/qemu-iotests/188.out
+++ b/tests/qemu-iotests/188.out
@@ -1,5 +1,5 @@
 QA output created by 188
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Dluks encrypt=
.key-secret=3Dsec0 encrypt.iter-time=3D10 size=3D16777216
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216
=20
 =3D=3D reading whole image =3D=3D
 read 16777216/16777216 bytes at offset 0
diff --git a/tests/qemu-iotests/189.out b/tests/qemu-iotests/189.out
index e536d95d53..bc213cbe14 100644
--- a/tests/qemu-iotests/189.out
+++ b/tests/qemu-iotests/189.out
@@ -1,6 +1,6 @@
 QA output created by 189
 =3D=3D create base =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT encrypt.format=3Dluks en=
crypt.key-secret=3Dsec0 encrypt.iter-time=3D10 size=3D16777216
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D16777216
=20
 =3D=3D writing whole image =3D=3D
 wrote 16777216/16777216 bytes at offset 0
@@ -10,7 +10,7 @@ wrote 16777216/16777216 bytes at offset 0
 read 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 =3D=3D create overlay =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Dluks encrypt=
.key-secret=3Dsec1 encrypt.iter-time=3D10 size=3D16777216 backing_file=3DTE=
ST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 backing_file=
=3DTEST_DIR/t.IMGFMT.base
=20
 =3D=3D writing part of a cluster =3D=3D
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index b0f2d417af..acfdf96b0c 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -1,12 +1,12 @@
 QA output created by 198
 =3D=3D create base =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT encrypt.format=3Dluks en=
crypt.key-secret=3Dsec0 encrypt.iter-time=3D10 size=3D16777216
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D16777216
=20
 =3D=3D writing whole image base =3D=3D
 wrote 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 =3D=3D create overlay =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Dluks encrypt=
.key-secret=3Dsec1 encrypt.iter-time=3D10 size=3D16777216 backing_file=3DTE=
ST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D16777216 backing_file=
=3DTEST_DIR/t.IMGFMT.base
=20
 =3D=3D writing whole image layer =3D=3D
 wrote 16777216/16777216 bytes at offset 0
diff --git a/tests/qemu-iotests/263.out b/tests/qemu-iotests/263.out
index 4cf5c79ed8..54bfbeeff8 100644
--- a/tests/qemu-iotests/263.out
+++ b/tests/qemu-iotests/263.out
@@ -2,7 +2,7 @@ QA output created by 263
=20
 testing LUKS qcow2 encryption
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Dluks encrypt=
.key-secret=3Dsec0 encrypt.iter-time=3D10 size=3D1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
 =3D=3D reading the whole image =3D=3D
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -21,7 +21,7 @@ read 982528/982528 bytes at offset 66048
=20
 testing legacy AES qcow2 encryption
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT encrypt.format=3Daes encrypt.=
key-secret=3Dsec0 size=3D1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
 =3D=3D reading the whole image =3D=3D
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/284.out b/tests/qemu-iotests/284.out
index 48216f5742..a929239302 100644
--- a/tests/qemu-iotests/284.out
+++ b/tests/qemu-iotests/284.out
@@ -2,7 +2,7 @@ QA output created by 284
=20
 testing LUKS qcow2 encryption
=20
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 encrypt.format=
=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
=20
 =3D=3D cluster size 512
 =3D=3D checking image refcounts =3D=3D
@@ -21,7 +21,7 @@ wrote 1/1 bytes at offset 512
=20
 =3D=3D rechecking image refcounts =3D=3D
 No errors were found on the image.
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 encrypt.format=
=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
=20
 =3D=3D cluster size 2048
 =3D=3D checking image refcounts =3D=3D
@@ -40,7 +40,7 @@ wrote 1/1 bytes at offset 2048
=20
 =3D=3D rechecking image refcounts =3D=3D
 No errors were found on the image.
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 encrypt.format=
=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
=20
 =3D=3D cluster size 32768
 =3D=3D checking image refcounts =3D=3D
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


