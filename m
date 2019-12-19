Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BBCC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3158D2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qg305LWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3158D2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihx9G-00068T-5p
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwxl-0005ok-73
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwxc-0007W5-8R
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37043
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwxc-0007S5-1l
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nLvDvqO7VVRdCvfrW5YGs4xy/uOmBT9M65MoDXGnhlc=;
 b=Qg305LWo3jaHMYbN1vw8DNUw52a3OeXZTckmvfJxBKGSj2QSYvy2JgUjV/ttOoAuUO0VmL
 uNFERpmJsU+ajrHLTUqzzzFMTjulgbOoq4uDrTE3OJbJlGJ7oBUq8VSvlaoYE0DEBCAn0m
 4lneY1sg27YioXl65TB7sveWk2Y9p8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-sOpP-ndkMQ6qRcpTz1Jy0g-1; Thu, 19 Dec 2019 09:39:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAA601083AE6;
 Thu, 19 Dec 2019 14:39:22 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CCE26E702;
 Thu, 19 Dec 2019 14:39:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 17/18] iotests: Enable fuse for many tests
Date: Thu, 19 Dec 2019 15:38:17 +0100
Message-Id: <20191219143818.1646168-18-mreitz@redhat.com>
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: sOpP-ndkMQ6qRcpTz1Jy0g-1
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

Many tests (that do not support generic protocols) can run just fine
with FUSE-exported images, so allow them to.

Note that 221 and 250 only pass when .lseek is correctly implemented,
which is only possible with a libfuse that is 3.8 or newer.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/013 | 2 +-
 tests/qemu-iotests/018 | 2 +-
 tests/qemu-iotests/020 | 2 +-
 tests/qemu-iotests/025 | 2 +-
 tests/qemu-iotests/026 | 2 +-
 tests/qemu-iotests/028 | 2 +-
 tests/qemu-iotests/031 | 2 +-
 tests/qemu-iotests/034 | 2 +-
 tests/qemu-iotests/036 | 2 +-
 tests/qemu-iotests/037 | 2 +-
 tests/qemu-iotests/038 | 2 +-
 tests/qemu-iotests/039 | 2 +-
 tests/qemu-iotests/046 | 2 +-
 tests/qemu-iotests/050 | 2 +-
 tests/qemu-iotests/054 | 2 +-
 tests/qemu-iotests/060 | 2 +-
 tests/qemu-iotests/071 | 2 +-
 tests/qemu-iotests/072 | 2 +-
 tests/qemu-iotests/079 | 2 +-
 tests/qemu-iotests/080 | 2 +-
 tests/qemu-iotests/089 | 2 +-
 tests/qemu-iotests/090 | 2 +-
 tests/qemu-iotests/091 | 2 +-
 tests/qemu-iotests/095 | 2 +-
 tests/qemu-iotests/097 | 2 +-
 tests/qemu-iotests/098 | 2 +-
 tests/qemu-iotests/102 | 2 +-
 tests/qemu-iotests/103 | 2 +-
 tests/qemu-iotests/106 | 2 +-
 tests/qemu-iotests/107 | 2 +-
 tests/qemu-iotests/108 | 2 +-
 tests/qemu-iotests/111 | 2 +-
 tests/qemu-iotests/112 | 2 +-
 tests/qemu-iotests/115 | 2 +-
 tests/qemu-iotests/117 | 2 +-
 tests/qemu-iotests/120 | 2 +-
 tests/qemu-iotests/121 | 2 +-
 tests/qemu-iotests/127 | 2 +-
 tests/qemu-iotests/133 | 2 +-
 tests/qemu-iotests/137 | 2 +-
 tests/qemu-iotests/138 | 2 +-
 tests/qemu-iotests/140 | 2 +-
 tests/qemu-iotests/154 | 2 +-
 tests/qemu-iotests/161 | 2 +-
 tests/qemu-iotests/171 | 2 +-
 tests/qemu-iotests/175 | 2 +-
 tests/qemu-iotests/176 | 2 +-
 tests/qemu-iotests/177 | 2 +-
 tests/qemu-iotests/179 | 2 +-
 tests/qemu-iotests/183 | 2 +-
 tests/qemu-iotests/186 | 2 +-
 tests/qemu-iotests/187 | 2 +-
 tests/qemu-iotests/191 | 2 +-
 tests/qemu-iotests/195 | 2 +-
 tests/qemu-iotests/200 | 2 +-
 tests/qemu-iotests/204 | 2 +-
 tests/qemu-iotests/214 | 2 +-
 tests/qemu-iotests/217 | 2 +-
 tests/qemu-iotests/220 | 2 +-
 tests/qemu-iotests/221 | 2 +-
 tests/qemu-iotests/229 | 2 +-
 tests/qemu-iotests/247 | 2 +-
 tests/qemu-iotests/249 | 2 +-
 tests/qemu-iotests/250 | 2 +-
 tests/qemu-iotests/252 | 2 +-
 tests/qemu-iotests/265 | 2 +-
 tests/qemu-iotests/268 | 2 +-
 tests/qemu-iotests/272 | 2 +-
 tests/qemu-iotests/273 | 2 +-
 tests/qemu-iotests/279 | 2 +-
 70 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/tests/qemu-iotests/013 b/tests/qemu-iotests/013
index a2c748c55e..8e17a43cf0 100755
--- a/tests/qemu-iotests/013
+++ b/tests/qemu-iotests/013
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # much of this could be generic for any format supporting compression.
 _supported_fmt qcow qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
 TEST_OFFSETS=3D"0 4294967296"
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index 04e0a76cf3..bc7797ffe5 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 _unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxExt=
entFlat" \
                      "streamOptimized"
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 20f8f185d0..fef5cdf429 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -41,7 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
-_supported_proto file
+_supported_proto file fuse
 _unsupported_imgopts "subformat=3DmonolithicFlat" \
                      "subformat=3DtwoGbMaxExtentFlat" \
                      "subformat=3DtwoGbMaxExtentSparse" \
diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index e05d833452..1569d912f4 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.pattern
=20
 _supported_fmt raw qcow2 qed luks
-_supported_proto file sheepdog rbd nfs
+_supported_proto file sheepdog rbd nfs fuse
=20
 echo "=3D=3D=3D Creating image"
 echo
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index a4aa74764f..9623e54998 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -40,7 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # Currently only qcow2 supports rebasing
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _default_cache_mode writethrough
 _supported_cache_modes writethrough none
 # The refcount table tests expect a certain minimum width for refcount ent=
ries
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 8b0ce4e96a..3c975f3e6f 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -46,7 +46,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files except vmdk and qcow which do not su=
pport
 # smaller backing files.
 _supported_fmt qcow2 qed
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
 # Choose a size that is not necessarily a cluster size multiple for image
diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index 646ecd593f..2bcbc5886e 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # We want to test compat=3D0.10, which does not support external data
 # files or refcount widths other than 16
 _unsupported_imgopts data_file 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
diff --git a/tests/qemu-iotests/034 b/tests/qemu-iotests/034
index da4cea1571..6f283177ef 100755
--- a/tests/qemu-iotests/034
+++ b/tests/qemu-iotests/034
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow qcow2 vmdk qed
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 _unsupported_imgopts "subformat=3DmonolithicFlat" \
                      "subformat=3DtwoGbMaxExtentFlat" \
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index 512598421c..626f295935 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -42,7 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # Only qcow2v3 and later supports feature bits;
 # qcow2.py does not support external data files
 _unsupported_imgopts 'compat=3D0.10' data_file
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index e6517acbd4..9bf5bbd6a0 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow qcow2 vmdk qed
-_supported_proto file
+_supported_proto file fuse
 _unsupported_imgopts "subformat=3DmonolithicFlat" \
                      "subformat=3DtwoGbMaxExtentFlat" \
                      "subformat=3DtwoGbMaxExtentSparse" \
diff --git a/tests/qemu-iotests/038 b/tests/qemu-iotests/038
index 707e2d72e9..9367b91d23 100755
--- a/tests/qemu-iotests/038
+++ b/tests/qemu-iotests/038
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2 qed
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
 CLUSTER_SIZE=3D2M
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index ddce48ab47..329896307f 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -40,7 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 _default_cache_mode writethrough
 _supported_cache_modes writethrough
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index 1dca1f4f30..8d0c338a42 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # data_file does not support compressed clusters
 _unsupported_imgopts data_file
=20
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index cdc5356541..75b8fd6f6e 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2 qed
-_supported_proto file
+_supported_proto file fuse
=20
 echo
 echo "=3D=3D Creating images =3D=3D"
diff --git a/tests/qemu-iotests/054 b/tests/qemu-iotests/054
index a8905b60d0..40922db2b1 100755
--- a/tests/qemu-iotests/054
+++ b/tests/qemu-iotests/054
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
=20
 echo
 echo "creating too large image (1 EB)"
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 043f12904a..c8f7d2523f 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -46,7 +46,7 @@ _filter_io_error()
=20
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # These tests only work for compat=3D1.1 images without an external
 # data file with refcount_bits=3D16
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 18fe9054b0..49faae6684 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _require_drivers blkdebug blkverify
 # blkdebug can only inject errors on bs->file, not on the data_file,
 # so thie test does not work with external data files
diff --git a/tests/qemu-iotests/072 b/tests/qemu-iotests/072
index 3a9861bf24..7ee52dca42 100755
--- a/tests/qemu-iotests/072
+++ b/tests/qemu-iotests/072
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt vpc vmdk vhdx vdi qed qcow2 qcow
-_supported_proto file
+_supported_proto file fuse
 _unsupported_imgopts "subformat=3DstreamOptimized"
=20
 IMG_SIZE=3D64M
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index 3642b51feb..0f0d94a2ac 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file nfs
+_supported_proto file nfs fuse
=20
 # Some containers (e.g. non-x86 on Travis) do not allow large files
 _require_large_file 4G
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index a3d13c414e..906e82bd19 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # - Internal snapshots are (currently) impossible with refcount_bits=3D1,
 #   and generally impossible with external data files
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index 82c1d19680..298dc60b6f 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # Because anything other than 16 would change the output of qemu_io -c inf=
o
 _unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
=20
diff --git a/tests/qemu-iotests/090 b/tests/qemu-iotests/090
index 1246e4f910..87e872ebf4 100755
--- a/tests/qemu-iotests/090
+++ b/tests/qemu-iotests/090
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file nfs
+_supported_proto file nfs fuse
 # External data files do not support compressed clusters
 _unsupported_imgopts data_file
=20
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index 7d23a6862b..838af79f86 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -44,7 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 _default_cache_mode none
 _supported_cache_modes writethrough none writeback
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 155ae86aa7..98ae0ce015 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -44,7 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
=20
 size_smaller=3D5M
 size_larger=3D100M
diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index 690f3d3ce1..aa7b431c93 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -41,7 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # Any format supporting backing files and bdrv_make_empty
 _supported_fmt qcow qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
=20
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index 1e29d96b3d..3a9361ea3e 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.pattern
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # The code path we want to test here only works for compat=3D1.1 images;
 # blkdebug can only inject errors on bs->file, so external data files
 # do not work with this test
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index b898df436f..2cc3efd1ed 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
=20
 IMG_SIZE=3D64K
=20
diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index 8c1ebe0443..220481db4c 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file nfs
+_supported_proto file nfs fuse
 # Internal snapshots are (currently) impossible with refcount_bits=3D1,
 # and generally impossible with external data files
 _unsupported_imgopts 'refcount_bits=3D1[^0-9]' data_file
diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index b5d1ec4078..b4fa6669e1 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt raw
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
 # in kB
diff --git a/tests/qemu-iotests/107 b/tests/qemu-iotests/107
index 268ba27688..d24829ccf9 100755
--- a/tests/qemu-iotests/107
+++ b/tests/qemu-iotests/107
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file nfs
+_supported_proto file nfs fuse
=20
=20
 IMG_SIZE=3D64K
diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index 5f7076fba4..ba67748bdf 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # This test directly modifies a refblock so it relies on refcount_bits bei=
ng 16;
 # and the low-level modification it performs are not tuned for external da=
ta
diff --git a/tests/qemu-iotests/111 b/tests/qemu-iotests/111
index 3b43d1bd83..bd839a39f4 100755
--- a/tests/qemu-iotests/111
+++ b/tests/qemu-iotests/111
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qed qcow qcow2 vmdk
-_supported_proto file
+_supported_proto file fuse
 _unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxExt=
entFlat"
=20
 _make_test_img -b "$TEST_IMG.inexistent"
diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
index 20ff5c224a..6e413f5651 100755
--- a/tests/qemu-iotests/112
+++ b/tests/qemu-iotests/112
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # This test will set refcount_bits on its own which would conflict with th=
e
 # manual setting; compat will be overridden as well;
 # and external data files do not work well with our refcount testing
diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index d254b18342..7f53987d1b 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # This test relies on refcounts being 64 bits wide (which does not work wi=
th
 # compat=3D0.10)
 _unsupported_imgopts 'refcount_bits=3D\([^6]\|.\([^4]\|$\)\)' 'compat=3D0.=
10'
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index f37b34f8b1..9039555ac4 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
=20
 _make_test_img 64k
=20
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index 2931a7550f..45c55c1c01 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt generic
-_supported_proto file
+_supported_proto file fuse
 _unsupported_fmt luks
 _require_drivers raw
=20
diff --git a/tests/qemu-iotests/121 b/tests/qemu-iotests/121
index 90ea0db737..8357ce089a 100755
--- a/tests/qemu-iotests/121
+++ b/tests/qemu-iotests/121
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # Refcount structures are used much differently with external data
 # files
diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index b64926ab31..a2d5556909 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -41,7 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
=20
 IMG_SIZE=3D64K
=20
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 6f7cacc091..1b88c15c0f 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
=20
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
 _make_test_img -b "$TEST_IMG.base"
diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 7ae86892f7..de555a91c9 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # We are going to use lazy-refcounts
 _unsupported_imgopts 'compat=3D0.10'
diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
index 54b01046ad..08cd9e17bb 100755
--- a/tests/qemu-iotests/138
+++ b/tests/qemu-iotests/138
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # With an external data file, data clusters are not refcounted
 # (and so qemu-img check does not check their refcount)
diff --git a/tests/qemu-iotests/140 b/tests/qemu-iotests/140
index 8d2ce5d9e3..3125e89064 100755
--- a/tests/qemu-iotests/140
+++ b/tests/qemu-iotests/140
@@ -44,7 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
=20
 _supported_fmt generic
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
 _make_test_img 64k
diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
index d68f66b9e0..26664a91de 100755
--- a/tests/qemu-iotests/154
+++ b/tests/qemu-iotests/154
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
 CLUSTER_SIZE=3D4k
diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
index f9b44e52cf..eeb8ccf2b5 100755
--- a/tests/qemu-iotests/161
+++ b/tests/qemu-iotests/161
@@ -42,7 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # Any format implementing BlockDriver.bdrv_change_backing_file
 _supported_fmt qcow2 qed
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
 IMG_SIZE=3D1M
diff --git a/tests/qemu-iotests/171 b/tests/qemu-iotests/171
index 341064a1c6..f3582edb10 100755
--- a/tests/qemu-iotests/171
+++ b/tests/qemu-iotests/171
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt raw
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
=20
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index 2d164b6b5d..7792fdcaca 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -71,7 +71,7 @@ EOF
 . ./common.filter
=20
 _supported_fmt raw
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
 _default_cache_mode none
diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
index 117c8b6954..15b83829a6 100755
--- a/tests/qemu-iotests/176
+++ b/tests/qemu-iotests/176
@@ -45,7 +45,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # This test is specific to qcow2
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # Persistent dirty bitmaps require compat=3D1.1;
 # Internal snapshots forbid using an external data file
diff --git a/tests/qemu-iotests/177 b/tests/qemu-iotests/177
index 752d29f8ad..d26bcaf45f 100755
--- a/tests/qemu-iotests/177
+++ b/tests/qemu-iotests/177
@@ -40,7 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # tests specific to compat=3D1.1.
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
=20
 CLUSTER_SIZE=3D1M
 size=3D128M
diff --git a/tests/qemu-iotests/179 b/tests/qemu-iotests/179
index 9372dc30ef..eaffac3fae 100755
--- a/tests/qemu-iotests/179
+++ b/tests/qemu-iotests/179
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
 # v2 images can't mark clusters as zero
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index 3f74b9f62d..218e22e282 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -43,7 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
=20
 _supported_fmt qcow2 raw qed quorum
-_supported_proto file
+_supported_proto file fuse
=20
 size=3D64M
 _make_test_img $size
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 3ea0442d44..0db25b0e68 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _require_drivers null-co
=20
 if [ "$QEMU_DEFAULT_MACHINE" !=3D "pc" ]; then
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index c6e1dc57a0..f262d83e3a 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
=20
 size=3D64M
 _make_test_img $size
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index b05db68141..b5ebea4c28 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -42,7 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # An external data file would change the query-named-block-nodes output
 _unsupported_imgopts data_file
=20
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index 48984b7ac1..6553fcbda9 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
=20
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index 616b632a86..98d95b1482 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -42,7 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
=20
 _supported_fmt qcow2 qed
-_supported_proto file
+_supported_proto file fuse
=20
 BACKING_IMG=3D"$TEST_IMG.base"
=20
diff --git a/tests/qemu-iotests/204 b/tests/qemu-iotests/204
index abb73dc381..7d4554ea96 100755
--- a/tests/qemu-iotests/204
+++ b/tests/qemu-iotests/204
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 # This test assumes that discard leaves zero clusters; see test 177 for
 # other tests that also work in older images
 _unsupported_imgopts 'compat=3D0.10'
diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
index 0f2e61280a..f2e0b14d55 100755
--- a/tests/qemu-iotests/214
+++ b/tests/qemu-iotests/214
@@ -35,7 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
=20
 # Repairing the corrupted image requires qemu-img check to store a
 # refcount up to 3, which requires at least two refcount bits.
diff --git a/tests/qemu-iotests/217 b/tests/qemu-iotests/217
index d89116ccad..7385342498 100755
--- a/tests/qemu-iotests/217
+++ b/tests/qemu-iotests/217
@@ -36,7 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # This test is specific to qcow2
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
=20
 # This test needs clusters with at least a refcount of 2 so that
 # OFLAG_COPIED is not set.  refcount_bits=3D1 is therefore unsupported.
diff --git a/tests/qemu-iotests/220 b/tests/qemu-iotests/220
index a9259b7127..9ba3b3fdcb 100755
--- a/tests/qemu-iotests/220
+++ b/tests/qemu-iotests/220
@@ -35,7 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.pattern
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # To use a different refcount width but 16 bits we need compat=3D1.1,
 # and external data files do not support compressed clusters.
diff --git a/tests/qemu-iotests/221 b/tests/qemu-iotests/221
index 0e9096fec7..ca62b3baa1 100755
--- a/tests/qemu-iotests/221
+++ b/tests/qemu-iotests/221
@@ -35,7 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt raw
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
 _default_cache_mode writeback
diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
index abc88f881f..b6ca941f6b 100755
--- a/tests/qemu-iotests/229
+++ b/tests/qemu-iotests/229
@@ -43,7 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # Needs backing file and backing format support
 _supported_fmt qcow2 qed
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
=20
diff --git a/tests/qemu-iotests/247 b/tests/qemu-iotests/247
index 87e37b39e2..6cf2679750 100755
--- a/tests/qemu-iotests/247
+++ b/tests/qemu-iotests/247
@@ -41,7 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # Requires backing files and .bdrv_change_backing_file support
 _supported_fmt qcow2 qed
-_supported_proto file
+_supported_proto file fuse
=20
 size=3D128M
=20
diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
index 4b0f810795..bf874edc73 100755
--- a/tests/qemu-iotests/249
+++ b/tests/qemu-iotests/249
@@ -42,7 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # Any format implementing BlockDriver.bdrv_change_backing_file
 _supported_fmt qcow2 qed
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
 IMG_SIZE=3D1M
diff --git a/tests/qemu-iotests/250 b/tests/qemu-iotests/250
index 9bb6b94d74..3df275c76b 100755
--- a/tests/qemu-iotests/250
+++ b/tests/qemu-iotests/250
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # This test does not make much sense with external data files
 _unsupported_imgopts data_file
diff --git a/tests/qemu-iotests/252 b/tests/qemu-iotests/252
index 83280c1715..e0db2616de 100755
--- a/tests/qemu-iotests/252
+++ b/tests/qemu-iotests/252
@@ -42,7 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # zero cluster support
 _supported_fmt qcow2
 _unsupported_imgopts 'compat=3D0.10'
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
 CLUSTER_SIZE=3D65536
diff --git a/tests/qemu-iotests/265 b/tests/qemu-iotests/265
index 00f2ec769e..0e800fb524 100755
--- a/tests/qemu-iotests/265
+++ b/tests/qemu-iotests/265
@@ -35,7 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # qcow2-specific test
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
 echo '--- Writing to the image ---'
diff --git a/tests/qemu-iotests/268 b/tests/qemu-iotests/268
index 78c3f4db3a..ddf4312284 100755
--- a/tests/qemu-iotests/268
+++ b/tests/qemu-iotests/268
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
=20
 echo
 echo "=3D=3D Required alignment larger than cluster size =3D=3D"
diff --git a/tests/qemu-iotests/272 b/tests/qemu-iotests/272
index c2f782d47b..de475bf6f0 100755
--- a/tests/qemu-iotests/272
+++ b/tests/qemu-iotests/272
@@ -35,7 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # This is a qcow2 regression test
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
=20
 # External data files do not support compression;
 # We need an exact cluster size (2M) and refcount width (2) so we can
diff --git a/tests/qemu-iotests/273 b/tests/qemu-iotests/273
index 00ff79bcf8..a40c55eb3b 100755
--- a/tests/qemu-iotests/273
+++ b/tests/qemu-iotests/273
@@ -35,7 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # This is a qcow2 regression test
 _supported_fmt qcow2
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
 # External data files would add nodes to the block graph, so it would
 # not match the reference output
diff --git a/tests/qemu-iotests/279 b/tests/qemu-iotests/279
index 6682376808..78ff039372 100755
--- a/tests/qemu-iotests/279
+++ b/tests/qemu-iotests/279
@@ -36,7 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 # Backing files are required...
 _supported_fmt qcow qcow2 vmdk qed
-_supported_proto file
+_supported_proto file fuse
 _supported_os Linux
=20
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
--=20
2.23.0


