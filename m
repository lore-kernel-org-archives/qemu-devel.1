Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570D5C2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5366206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgX5d51A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5366206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihx8t-0005RG-FX
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwxO-0005QT-E0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwxM-0006hH-IQ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20861
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwxK-0006e6-Lg
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ffRzfq38Al1pdRx6YANczdj/eG/OvU/BRdE9lNBxUOA=;
 b=OgX5d51A2IJq/WYha4EJ0tPGILILyQIGzgTi0aM+gC0mzgxOoF5V1TCvaGoQHfVdXt+QXj
 nXmScodFUV8HzSq4nty55WLTCM6vITIdxSxpz6cEB1f0lmisIUQPAgxW9VNTRe0MW0yk+M
 EtoDrjMXB4x8+iVjVImGWqu5yR670vY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-uadsuKKsPVGVZkReeASkVQ-1; Thu, 19 Dec 2019 09:39:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D4BB80257A;
 Thu, 19 Dec 2019 14:39:00 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4052B28980;
 Thu, 19 Dec 2019 14:38:59 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 10/18] iotests: Use convert -n in some cases
Date: Thu, 19 Dec 2019 15:38:10 +0100
Message-Id: <20191219143818.1646168-11-mreitz@redhat.com>
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: uadsuKKsPVGVZkReeASkVQ-1
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

qemu-img convert (without -n) can often be replaced by a combination of
_make_test_img + qemu-img convert -n.  Doing so allows converting to
protocols that do not allow direct file creation, such as FUSE exports.

So do it for some iotests, so they can run on FUSE exports.

Note that doing this allows us to remove a 9-line comment from 028 that
used to explain why we cannot safely filter drive-backup's image
creation output.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/013     |  3 ++-
 tests/qemu-iotests/013.out |  1 +
 tests/qemu-iotests/018     |  3 ++-
 tests/qemu-iotests/018.out |  1 +
 tests/qemu-iotests/028     | 14 ++++----------
 tests/qemu-iotests/028.out |  3 +++
 tests/qemu-iotests/072     |  3 ++-
 tests/qemu-iotests/072.out |  1 +
 tests/qemu-iotests/089     |  3 ++-
 tests/qemu-iotests/089.out |  1 +
 10 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/tests/qemu-iotests/013 b/tests/qemu-iotests/013
index 5cb9032f16..b977290480 100755
--- a/tests/qemu-iotests/013
+++ b/tests/qemu-iotests/013
@@ -64,7 +64,8 @@ echo "Compressing image"
 echo
=20
 mv "$TEST_IMG" "$TEST_IMG.orig"
-$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -c "$TEST_IMG.orig" "$TEST_IMG"
+_make_test_img 6G
+$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -c -n "$TEST_IMG.orig" "$TEST_IMG"
=20
 echo "Testing compressed image"
 echo
diff --git a/tests/qemu-iotests/013.out b/tests/qemu-iotests/013.out
index 317cdf4b48..07323a742b 100644
--- a/tests/qemu-iotests/013.out
+++ b/tests/qemu-iotests/013.out
@@ -17592,6 +17592,7 @@ read 12288/12288 bytes at offset 4315947008
 No errors were found on the image.
 Compressing image
=20
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6442450944
 Testing compressed image
=20
 With offset 0:
diff --git a/tests/qemu-iotests/018 b/tests/qemu-iotests/018
index c69ce09209..04e0a76cf3 100755
--- a/tests/qemu-iotests/018
+++ b/tests/qemu-iotests/018
@@ -81,7 +81,8 @@ done
 _check_test_img
=20
 TEST_IMG=3D"$TEST_IMG_SAVE"
-$QEMU_IMG convert -f $IMGFMT -O $IMGFMT "$TEST_IMG.orig" "$TEST_IMG"
+_make_test_img 6G
+$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG.orig" "$TEST_IMG"
=20
 echo "Reading"
 echo
diff --git a/tests/qemu-iotests/018.out b/tests/qemu-iotests/018.out
index 5df966727f..834900a1ab 100644
--- a/tests/qemu-iotests/018.out
+++ b/tests/qemu-iotests/018.out
@@ -537,6 +537,7 @@ wrote 512/512 bytes at offset 4295032320
 wrote 65536/65536 bytes at offset 4295098368
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6442450944
 Reading
=20
 =3D=3D=3D IO: pattern 0
diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index e2556d8e57..8b0ce4e96a 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -116,16 +116,10 @@ else
     QEMU_COMM_TIMEOUT=3D1
 fi
=20
-# Silence output since it contains the disk image path and QEMU's readline
-# character echoing makes it very hard to filter the output. Plus, there
-# is no telling how many times the command will repeat before succeeding.
-# (Note that creating the image results in a "Formatting..." message over
-# stdout, which is the same channel the monitor uses.  We cannot reliably
-# wait for it because the monitor output may interact with it in such a
-# way that _timed_wait_for cannot read it.  However, once the block job is
-# done, we know that the "Formatting..." message must have appeared
-# already, so the output is still deterministic.)
-silent=3Dy _send_qemu_cmd $h "drive_backup disk ${TEST_IMG}.copy" "(qemu)"
+TEST_IMG=3D"$TEST_IMG.copy" _make_test_img $image_size
+_send_qemu_cmd $h "drive_backup -n disk ${TEST_IMG}.copy" "(qemu)" \
+    | _filter_imgfmt
+
 silent=3Dy qemu_cmd_repeat=3D20 _send_qemu_cmd $h "info block-jobs" "No ac=
tive jobs"
 _send_qemu_cmd $h "info block-jobs" "No active jobs"
 _send_qemu_cmd $h 'quit' ""
diff --git a/tests/qemu-iotests/028.out b/tests/qemu-iotests/028.out
index 37aed84436..2bbdabc18f 100644
--- a/tests/qemu-iotests/028.out
+++ b/tests/qemu-iotests/028.out
@@ -468,6 +468,9 @@ No errors were found on the image.
=20
 block-backup
=20
+Formatting 'TEST_DIR/t.IMGFMT.copy', fmt=3DIMGFMT size=3D4294968832
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) drive_backup -n disk TEST_DIR/t.IMGFMT.copy
 (qemu) info block-jobs
 No active jobs
 =3D=3D=3D IO: pattern 195
diff --git a/tests/qemu-iotests/072 b/tests/qemu-iotests/072
index f0b73e7e65..3a9861bf24 100755
--- a/tests/qemu-iotests/072
+++ b/tests/qemu-iotests/072
@@ -51,7 +51,8 @@ TEST_IMG=3D"$TEST_IMG.base" _make_test_img $IMG_SIZE
 $QEMU_IO -c 'write -P 42 0 512' -c 'write -P 23 512 512' \
          -c 'write -P 66 1024 512' "$TEST_IMG.base" | _filter_qemu_io
=20
-$QEMU_IMG convert -f raw -O $IMGFMT "$TEST_IMG.base" "$TEST_IMG"
+_make_test_img $IMG_SIZE
+$QEMU_IMG convert -f raw -O $IMGFMT -n "$TEST_IMG.base" "$TEST_IMG"
=20
 $QEMU_IO -c "open -o driver=3D$IMGFMT,file.driver=3D$IMGFMT,file.file.file=
name=3D$TEST_IMG" \
          -c 'read -P 42 0 512' -c 'read -P 23 512 512' \
diff --git a/tests/qemu-iotests/072.out b/tests/qemu-iotests/072.out
index fe949d4781..46d24ade16 100644
--- a/tests/qemu-iotests/072.out
+++ b/tests/qemu-iotests/072.out
@@ -9,6 +9,7 @@ wrote 512/512 bytes at offset 512
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 512/512 bytes at offset 1024
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 512/512 bytes at offset 512
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index ad029f1f09..82c1d19680 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -62,7 +62,8 @@ TEST_IMG=3D"$TEST_IMG.base" _make_test_img $IMG_SIZE
 $QEMU_IO -c 'write -P 42 0 512' -c 'write -P 23 512 512' \
          -c 'write -P 66 1024 512' "$TEST_IMG.base" | _filter_qemu_io
=20
-$QEMU_IMG convert -f raw -O $IMGFMT "$TEST_IMG.base" "$TEST_IMG"
+_make_test_img $IMG_SIZE
+$QEMU_IMG convert -f raw -O $IMGFMT -n "$TEST_IMG.base" "$TEST_IMG"
=20
 $QEMU_IO_PROG --cache $CACHEMODE \
          -c 'read -P 42 0 512' -c 'read -P 23 512 512' \
diff --git a/tests/qemu-iotests/089.out b/tests/qemu-iotests/089.out
index 20c8ce8f0e..8ed5884f68 100644
--- a/tests/qemu-iotests/089.out
+++ b/tests/qemu-iotests/089.out
@@ -9,6 +9,7 @@ wrote 512/512 bytes at offset 512
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 512/512 bytes at offset 1024
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 512/512 bytes at offset 512
--=20
2.23.0


