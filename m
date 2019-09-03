Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C0DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 14:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37227233A1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 14:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37227233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59OI-0000sk-W9
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 10:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i58yu-0002YE-B0
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i58ys-0006WJ-Er
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i58yn-0006OT-Mn; Tue, 03 Sep 2019 09:36:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 042F23001ACB;
 Tue,  3 Sep 2019 13:36:17 +0000 (UTC)
Received: from localhost (ovpn-204-98.brq.redhat.com [10.40.204.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66C7560C18;
 Tue,  3 Sep 2019 13:36:16 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  3 Sep 2019 15:35:46 +0200
Message-Id: <20190903133553.6500-10-mreitz@redhat.com>
In-Reply-To: <20190903133553.6500-1-mreitz@redhat.com>
References: <20190903133553.6500-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 03 Sep 2019 13:36:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 09/16] iotests: Disable broken
 streamOptimized tests
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

streamOptimized does not support writes that do not span exactly one
cluster.  Furthermore, it cannot rewrite already allocated clusters.
As such, many iotests do not work with it.  Disable them.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190815153638.4600-6-mreitz@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/002 | 1 +
 tests/qemu-iotests/003 | 1 +
 tests/qemu-iotests/005 | 3 ++-
 tests/qemu-iotests/009 | 1 +
 tests/qemu-iotests/010 | 1 +
 tests/qemu-iotests/011 | 1 +
 tests/qemu-iotests/017 | 3 ++-
 tests/qemu-iotests/018 | 3 ++-
 tests/qemu-iotests/019 | 3 ++-
 tests/qemu-iotests/020 | 3 ++-
 tests/qemu-iotests/027 | 1 +
 tests/qemu-iotests/032 | 1 +
 tests/qemu-iotests/033 | 1 +
 tests/qemu-iotests/034 | 3 ++-
 tests/qemu-iotests/037 | 3 ++-
 tests/qemu-iotests/063 | 3 ++-
 tests/qemu-iotests/072 | 1 +
 tests/qemu-iotests/105 | 3 ++-
 tests/qemu-iotests/197 | 1 +
 tests/qemu-iotests/215 | 1 +
 tests/qemu-iotests/251 | 1 +
 21 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/002 b/tests/qemu-iotests/002
index fd413bce48..1a0d411df5 100755
--- a/tests/qemu-iotests/002
+++ b/tests/qemu-iotests/002
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
+_unsupported_imgopts "subformat=3DstreamOptimized"
=20
=20
 size=3D128M
diff --git a/tests/qemu-iotests/003 b/tests/qemu-iotests/003
index ccd3a39dfb..33eeade0de 100755
--- a/tests/qemu-iotests/003
+++ b/tests/qemu-iotests/003
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
+_unsupported_imgopts "subformat=3DstreamOptimized"
=20
 size=3D128M
 offset=3D67M
diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
index 9c7681c19b..58442762fe 100755
--- a/tests/qemu-iotests/005
+++ b/tests/qemu-iotests/005
@@ -43,7 +43,8 @@ _supported_fmt generic
 _supported_proto generic
 _supported_os Linux
 _unsupported_imgopts "subformat=3DtwoGbMaxExtentFlat" \
-                     "subformat=3DtwoGbMaxExtentSparse"
+                     "subformat=3DtwoGbMaxExtentSparse" \
+                     "subformat=3DstreamOptimized"
=20
 # vpc is limited to 127GB, so we can't test it here
 if [ "$IMGFMT" =3D "vpc" ]; then
diff --git a/tests/qemu-iotests/009 b/tests/qemu-iotests/009
index 51b200db1d..4dc7d210f9 100755
--- a/tests/qemu-iotests/009
+++ b/tests/qemu-iotests/009
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
+_unsupported_imgopts "subformat=3DstreamOptimized"
=20
=20
 size=3D6G
diff --git a/tests/qemu-iotests/010 b/tests/qemu-iotests/010
index 48c533f632..df809b3088 100755
--- a/tests/qemu-iotests/010
+++ b/tests/qemu-iotests/010
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
+_unsupported_imgopts "subformat=3DstreamOptimized"
=20
=20
 size=3D6G
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index 56f704b5b9..57b99ae4a9 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
+_unsupported_imgopts "subformat=3DstreamOptimized"
=20
=20
 size=3D6G
diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index 79875de454..0a4b854e65 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -41,7 +41,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto generic
 _unsupported_proto vxhs
-_unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxE=
xtentFlat"
+_unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxE=
xtentFlat" \
+                     "subformat=3DstreamOptimized"
=20
 TEST_OFFSETS=3D"0 4294967296"
=20
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index 78169838ba..c69ce09209 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -41,7 +41,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto file
 _supported_os Linux
-_unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxE=
xtentFlat"
+_unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxE=
xtentFlat" \
+                     "streamOptimized"
=20
 TEST_OFFSETS=3D"0 4294967296"
=20
diff --git a/tests/qemu-iotests/019 b/tests/qemu-iotests/019
index a56dd30bed..b4f5234609 100755
--- a/tests/qemu-iotests/019
+++ b/tests/qemu-iotests/019
@@ -47,7 +47,8 @@ _supported_proto file
 _supported_os Linux
 _unsupported_imgopts "subformat=3DmonolithicFlat" \
                      "subformat=3DtwoGbMaxExtentFlat" \
-                     "subformat=3DtwoGbMaxExtentSparse"
+                     "subformat=3DtwoGbMaxExtentSparse" \
+                     "subformat=3DstreamOptimized"
=20
 TEST_OFFSETS=3D"0 4294967296"
 CLUSTER_SIZE=3D65536
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 6b0ebb37d2..f41b92f35f 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -44,7 +44,8 @@ _supported_fmt qcow qcow2 vmdk qed
 _supported_proto file
 _unsupported_imgopts "subformat=3DmonolithicFlat" \
                      "subformat=3DtwoGbMaxExtentFlat" \
-                     "subformat=3DtwoGbMaxExtentSparse"
+                     "subformat=3DtwoGbMaxExtentSparse" \
+                     "subformat=3DstreamOptimized"
=20
 TEST_OFFSETS=3D"0 4294967296"
=20
diff --git a/tests/qemu-iotests/027 b/tests/qemu-iotests/027
index 4cb638022a..494be0921f 100755
--- a/tests/qemu-iotests/027
+++ b/tests/qemu-iotests/027
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt vmdk qcow qcow2 qed
 _supported_proto generic
+_unsupported_imgopts "subformat=3DstreamOptimized"
=20
=20
 size=3D128M
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index 988a8c5d8f..8337a4d825 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This works for any image format (though unlikely to segfault for raw)
 _supported_fmt generic
 _supported_proto generic
+_unsupported_imgopts "subformat=3DstreamOptimized"
=20
 echo
 echo =3D=3D=3D Prepare image =3D=3D=3D
diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index 362a48c0a0..8b40991d55 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
+_unsupported_imgopts "subformat=3DstreamOptimized"
=20
=20
 size=3D128M
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index 324bed28c6..da4cea1571 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -41,7 +41,8 @@ _supported_proto file
 _supported_os Linux
 _unsupported_imgopts "subformat=3DmonolithicFlat" \
                      "subformat=3DtwoGbMaxExtentFlat" \
-                     "subformat=3DtwoGbMaxExtentSparse"
+                     "subformat=3DtwoGbMaxExtentSparse" \
+                     "subformat=3DstreamOptimized"
=20
 CLUSTER_SIZE=3D4k
 size=3D128M
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index 4946b9be92..e6517acbd4 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -40,7 +40,8 @@ _supported_fmt qcow qcow2 vmdk qed
 _supported_proto file
 _unsupported_imgopts "subformat=3DmonolithicFlat" \
                      "subformat=3DtwoGbMaxExtentFlat" \
-                     "subformat=3DtwoGbMaxExtentSparse"
+                     "subformat=3DtwoGbMaxExtentSparse" \
+                     "subformat=3DstreamOptimized"
=20
 CLUSTER_SIZE=3D4k
 size=3D128M
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index fe4892e467..7cf0427af4 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -43,7 +43,8 @@ _supported_fmt qcow qcow2 vmdk qed raw
 _supported_proto file
 _unsupported_imgopts "subformat=3DmonolithicFlat" \
                      "subformat=3DtwoGbMaxExtentFlat" \
-                     "subformat=3DtwoGbMaxExtentSparse"
+                     "subformat=3DtwoGbMaxExtentSparse" \
+                     "subformat=3DstreamOptimized"
=20
 _make_test_img 4M
=20
diff --git a/tests/qemu-iotests/072 b/tests/qemu-iotests/072
index 661b36da2d..f0b73e7e65 100755
--- a/tests/qemu-iotests/072
+++ b/tests/qemu-iotests/072
@@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt vpc vmdk vhdx vdi qed qcow2 qcow
 _supported_proto file
+_unsupported_imgopts "subformat=3DstreamOptimized"
=20
 IMG_SIZE=3D64M
=20
diff --git a/tests/qemu-iotests/105 b/tests/qemu-iotests/105
index 3346e8cb25..4d55a2d3ef 100755
--- a/tests/qemu-iotests/105
+++ b/tests/qemu-iotests/105
@@ -39,7 +39,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2 vmdk vhdx qed
 _supported_proto generic
 _unsupported_imgopts "subformat=3DtwoGbMaxExtentFlat" \
-                     "subformat=3DtwoGbMaxExtentSparse"
+                     "subformat=3DtwoGbMaxExtentSparse" \
+                     "subformat=3DstreamOptimized"
=20
 echo
 echo "creating large image"
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 383d7d7f61..1d4f6786db 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -53,6 +53,7 @@ _supported_fmt generic
 _supported_proto generic
 # LUKS support may be possible, but it complicates things.
 _unsupported_fmt luks
+_unsupported_imgopts "subformat=3DstreamOptimized"
=20
 echo
 echo '=3D=3D=3D Copy-on-read =3D=3D=3D'
diff --git a/tests/qemu-iotests/215 b/tests/qemu-iotests/215
index 958c14f5a0..2eb377d682 100755
--- a/tests/qemu-iotests/215
+++ b/tests/qemu-iotests/215
@@ -50,6 +50,7 @@ _supported_fmt generic
 _supported_proto generic
 # LUKS support may be possible, but it complicates things.
 _unsupported_fmt luks
+_unsupported_imgopts "subformat=3DstreamOptimized"
=20
 echo
 echo '=3D=3D=3D Copy-on-read =3D=3D=3D'
diff --git a/tests/qemu-iotests/251 b/tests/qemu-iotests/251
index 13f85de9cd..7918ba3559 100755
--- a/tests/qemu-iotests/251
+++ b/tests/qemu-iotests/251
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt generic
 _supported_proto file
 _supported_os Linux
+_unsupported_imgopts "subformat=3DstreamOptimized"
=20
 if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
     # We use json:{} filenames here, so we cannot work with additional o=
ptions.
--=20
2.21.0


