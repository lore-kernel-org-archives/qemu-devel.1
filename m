Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4D5C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBF821741
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBF821741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37403 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEJnN-0003Jg-4Z
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 16:26:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEJiY-000755-TD
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEJiX-0004Vc-R5
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:21:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hEJiV-0004Sn-2V; Wed, 10 Apr 2019 16:21:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D07C3007C2F;
	Wed, 10 Apr 2019 20:21:06 +0000 (UTC)
Received: from localhost (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D7A61619A2;
	Wed, 10 Apr 2019 20:21:05 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 10 Apr 2019 22:20:32 +0200
Message-Id: <20190410202033.28617-11-mreitz@redhat.com>
In-Reply-To: <20190410202033.28617-1-mreitz@redhat.com>
References: <20190410202033.28617-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 10 Apr 2019 20:21:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 10/11] iotests: Add test for commit in sub
 directory
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410202032.u1TajKYYTKx98zAfhfbPYxsclhOxOhCE5BVFYc3oSp0@z>

Add a test for committing an overlay in a sub directory to one of the
images in its backing chain, using both relative and absolute filenames.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/020     | 36 ++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/020.out | 10 ++++++++++
 2 files changed, 46 insertions(+)

diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 71fa753b4e..cfcbc0cf45 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -31,6 +31,11 @@ _cleanup()
 	_cleanup_test_img
     rm -f "$TEST_IMG.base"
     rm -f "$TEST_IMG.orig"
+
+    rm -f "$TEST_DIR/subdir/t.$IMGFMT.base"
+    rm -f "$TEST_DIR/subdir/t.$IMGFMT.mid"
+    rm -f "$TEST_DIR/subdir/t.$IMGFMT"
+    rmdir "$TEST_DIR/subdir" &> /dev/null
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -134,6 +139,37 @@ $QEMU_IO -c 'writev 0 64k' "$TEST_IMG" | _filter_qem=
u_io
 $QEMU_IMG commit "$TEST_IMG"
 _cleanup
=20
+
+echo
+echo 'Testing commit in sub-directory with relative filenames'
+echo
+
+pushd "$TEST_DIR" > /dev/null
+
+mkdir subdir
+
+TEST_IMG=3D"subdir/t.$IMGFMT.base" _make_test_img 1M
+TEST_IMG=3D"subdir/t.$IMGFMT.mid" _make_test_img -b "t.$IMGFMT.base"
+TEST_IMG=3D"subdir/t.$IMGFMT" _make_test_img -b "t.$IMGFMT.mid"
+
+# Should work
+$QEMU_IMG commit -b "t.$IMGFMT.mid" "subdir/t.$IMGFMT"
+
+# Might theoretically work, but does not in practice (we have to
+# decide between this and the above; and since we always represent
+# backing file names as relative to the overlay, we go for the above)
+$QEMU_IMG commit -b "subdir/t.$IMGFMT.mid" "subdir/t.$IMGFMT" 2>&1 | \
+    _filter_imgfmt
+
+# This should work as well
+$QEMU_IMG commit -b "$TEST_DIR/subdir/t.$IMGFMT.mid" "subdir/t.$IMGFMT"
+
+popd > /dev/null
+
+# Now let's try with just absolute filenames
+$QEMU_IMG commit -b "$TEST_DIR/subdir/t.$IMGFMT.mid" \
+    "$TEST_DIR/subdir/t.$IMGFMT"
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/020.out b/tests/qemu-iotests/020.out
index 4b722b2dd0..228c37dded 100644
--- a/tests/qemu-iotests/020.out
+++ b/tests/qemu-iotests/020.out
@@ -1094,4 +1094,14 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D=
1048576 backing_file=3Djson:{'driv
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Block job failed: No space left on device
+
+Testing commit in sub-directory with relative filenames
+
+Formatting 'subdir/t.IMGFMT.base', fmt=3DIMGFMT size=3D1048576
+Formatting 'subdir/t.IMGFMT.mid', fmt=3DIMGFMT size=3D1048576 backing_fi=
le=3Dt.IMGFMT.base
+Formatting 'subdir/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=3D=
t.IMGFMT.mid
+Image committed.
+qemu-img: Did not find 'subdir/t.IMGFMT.mid' in the backing chain of 'su=
bdir/t.IMGFMT'
+Image committed.
+Image committed.
 *** done
--=20
2.20.1


