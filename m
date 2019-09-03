Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A56EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B6D2343A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B6D2343A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i591f-0005CH-Gg
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i58yf-0002CB-U3
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i58ye-0006G5-HP
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i58yb-0006Cb-VB; Tue, 03 Sep 2019 09:36:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 421D189810B;
 Tue,  3 Sep 2019 13:36:05 +0000 (UTC)
Received: from localhost (ovpn-204-98.brq.redhat.com [10.40.204.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCA3E60C63;
 Tue,  3 Sep 2019 13:36:04 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  3 Sep 2019 15:35:41 +0200
Message-Id: <20190903133553.6500-5-mreitz@redhat.com>
In-Reply-To: <20190903133553.6500-1-mreitz@redhat.com>
References: <20190903133553.6500-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 03 Sep 2019 13:36:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 04/16] iotests: Test allocate_first_block()
 with O_DIRECT
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

Using block_resize we can test allocate_first_block() with file
descriptor opened with O_DIRECT, ensuring that it works for any size
larger than 4096 bytes.

Testing smaller sizes is tricky as the result depends on the filesystem
used for testing. For example on NFS any size will work since O_DIRECT
does not require any alignment.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190827010528.8818-3-nsoffer@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/175     | 28 ++++++++++++++++++++++++++++
 tests/qemu-iotests/175.out |  8 ++++++++
 2 files changed, 36 insertions(+)

diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index 7ba28b3c1b..55db2803ed 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -49,6 +49,23 @@ _filter_blocks()
         -e "s/blocks=3D$((extra_blocks + img_size / 512))\\(\$\\|[^0-9]\=
\)/max allocation/"
 }
=20
+# Resize image using block_resize.
+# Parameter 1: image path
+# Parameter 2: new size
+_block_resize()
+{
+    local path=3D$1
+    local size=3D$2
+
+    $QEMU -qmp stdio -nographic -nodefaults \
+        -blockdev file,node-name=3Dfile,filename=3D$path,cache.direct=3D=
on \
+        <<EOF
+{'execute': 'qmp_capabilities'}
+{'execute': 'block_resize', 'arguments': {'node-name': 'file', 'size': $=
size}}
+{'execute': 'quit'}
+EOF
+}
+
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
@@ -57,6 +74,9 @@ _supported_fmt raw
 _supported_proto file
 _supported_os Linux
=20
+_default_cache_mode none
+_supported_cache_modes none directsync
+
 size=3D$((1 * 1024 * 1024))
=20
 touch "$TEST_DIR/empty"
@@ -79,6 +99,14 @@ for mode in off full falloc; do
     stat -c "size=3D%s, blocks=3D%b" $TEST_IMG | _filter_blocks $extra_b=
locks $min_blocks $size
 done
=20
+for new_size in 4096 1048576; do
+    echo
+    echo "=3D=3D resize empty image with block_resize =3D=3D"
+    _make_test_img 0 | _filter_imgfmt
+    _block_resize $TEST_IMG $new_size >/dev/null
+    stat -c "size=3D%s, blocks=3D%b" $TEST_IMG | _filter_blocks $extra_b=
locks $min_blocks $new_size
+done
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/175.out b/tests/qemu-iotests/175.out
index 263e521262..39c2ee0f62 100644
--- a/tests/qemu-iotests/175.out
+++ b/tests/qemu-iotests/175.out
@@ -15,4 +15,12 @@ size=3D1048576, max allocation
 =3D=3D creating image with preallocation falloc =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 preallocatio=
n=3Dfalloc
 size=3D1048576, max allocation
+
+=3D=3D resize empty image with block_resize =3D=3D
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D0
+size=3D4096, min allocation
+
+=3D=3D resize empty image with block_resize =3D=3D
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D0
+size=3D1048576, min allocation
  *** done
--=20
2.21.0


