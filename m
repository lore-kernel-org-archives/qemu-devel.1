Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37DAECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD18B2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD18B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXOM-0002E0-HX
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWqj-0006HO-Ay
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWqg-00084Y-6m
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43082)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWqX-00081N-Vo; Thu, 10 Oct 2019 07:43:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0CF0C059B80;
 Thu, 10 Oct 2019 11:43:04 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40D4360920;
 Thu, 10 Oct 2019 11:43:04 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/36] qemu-iotests: ignore leaks on failure paths in 026
Date: Thu, 10 Oct 2019 13:42:25 +0200
Message-Id: <20191010114300.7746-2-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 10 Oct 2019 11:43:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Upcoming asynchronous handling of sub-parts of qcow2 requests will
change number of leaked clusters and even make it racy. As a
preparation, ignore leaks on failure parts in 026.

It's not trivial to just grep or substitute qemu-img output for such
thing. Instead do better: 3 is a error code of qemu-img check, if only
leaks are found. Catch this case and print success output.

Suggested-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190916175324.18478-2-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/026             |  6 +--
 tests/qemu-iotests/026.out         | 80 ++++++++----------------------
 tests/qemu-iotests/026.out.nocache | 80 ++++++++----------------------
 tests/qemu-iotests/common.rc       | 17 +++++++
 4 files changed, 60 insertions(+), 123 deletions(-)

diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index ffb18ab6b5..3430029ed6 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -107,7 +107,7 @@ if [ "$event" =3D=3D "l2_load" ]; then
     $QEMU_IO -c "read $vmstate 0 128k " "$BLKDBG_TEST_IMG" | _filter_qem=
u_io
 fi
=20
-_check_test_img 2>&1 | grep -v "refcount=3D1 reference=3D0"
+_check_test_img_ignore_leaks 2>&1 | grep -v "refcount=3D1 reference=3D0"
=20
 done
 done
@@ -152,7 +152,7 @@ echo
 echo "Event: $event; errno: $errno; imm: $imm; once: $once; write $vmsta=
te"
 $QEMU_IO -c "write $vmstate 0 64M" "$BLKDBG_TEST_IMG" | _filter_qemu_io
=20
-_check_test_img 2>&1 | grep -v "refcount=3D1 reference=3D0"
+_check_test_img_ignore_leaks 2>&1 | grep -v "refcount=3D1 reference=3D0"
=20
 done
 done
@@ -191,7 +191,7 @@ echo
 echo "Event: $event; errno: $errno; imm: $imm; once: $once"
 $QEMU_IO -c "write -b 0 64k" "$BLKDBG_TEST_IMG" | _filter_qemu_io
=20
-_check_test_img 2>&1 | grep -v "refcount=3D1 reference=3D0"
+_check_test_img_ignore_leaks 2>&1 | grep -v "refcount=3D1 reference=3D0"
=20
 done
 done
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index fb89b8480c..ff0817b6f2 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -17,18 +17,14 @@ Event: l1_update; errno: 5; imm: off; once: off; writ=
e
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l1_update; errno: 5; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l1_update; errno: 28; imm: off; once: on; write
@@ -45,18 +41,14 @@ Event: l1_update; errno: 28; imm: off; once: off; wri=
te
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l1_update; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l2_load; errno: 5; imm: off; once: on; write
@@ -137,18 +129,14 @@ Event: l2_update; errno: 5; imm: off; once: off; wr=
ite
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-127 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l2_update; errno: 5; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-127 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l2_update; errno: 28; imm: off; once: on; write
@@ -165,18 +153,14 @@ Event: l2_update; errno: 28; imm: off; once: off; w=
rite
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-127 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l2_update; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-127 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l2_alloc_write; errno: 5; imm: off; once: on; write
@@ -200,9 +184,7 @@ Event: l2_alloc_write; errno: 5; imm: off; once: off;=
 write -b
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l2_alloc_write; errno: 28; imm: off; once: on; write
@@ -226,9 +208,7 @@ Event: l2_alloc_write; errno: 28; imm: off; once: off=
; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: write_aio; errno: 5; imm: off; once: on; write
@@ -480,18 +460,14 @@ Event: refblock_alloc_hookup; errno: 28; imm: off; =
once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-55 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-251 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_alloc_write; errno: 28; imm: off; once: on; write
@@ -532,18 +508,14 @@ Event: refblock_alloc_write_blocks; errno: 28; imm:=
 off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-10 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; writ=
e -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-23 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write
@@ -560,18 +532,14 @@ Event: refblock_alloc_write_table; errno: 28; imm: =
off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-10 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write=
 -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-23 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write
@@ -588,18 +556,14 @@ Event: refblock_alloc_switch_table; errno: 28; imm:=
 off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-10 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; writ=
e -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-23 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
=20
 =3D=3D=3D L1 growth tests =3D=3D=3D
=20
@@ -658,9 +622,7 @@ Event: l1_grow_activate_table; errno: 5; imm: off; on=
ce: off
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-96 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
=20
 Event: l1_grow_activate_table; errno: 28; imm: off; once: on
@@ -672,9 +634,7 @@ Event: l1_grow_activate_table; errno: 28; imm: off; o=
nce: off
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-96 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
=20
 =3D=3D=3D Avoid cluster leaks after temporary failure =3D=3D=3D
=20
diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.=
out.nocache
index 6dda95dfb4..495d013007 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -17,18 +17,14 @@ Event: l1_update; errno: 5; imm: off; once: off; writ=
e
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l1_update; errno: 5; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l1_update; errno: 28; imm: off; once: on; write=20
@@ -45,18 +41,14 @@ Event: l1_update; errno: 28; imm: off; once: off; wri=
te
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l1_update; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l2_load; errno: 5; imm: off; once: on; write=20
@@ -140,9 +132,7 @@ qemu-io: Failed to flush the L2 table cache: Input/ou=
tput error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-127 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l2_update; errno: 5; imm: off; once: off; write -b
@@ -150,9 +140,7 @@ qemu-io: Failed to flush the L2 table cache: Input/ou=
tput error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-127 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l2_update; errno: 28; imm: off; once: on; write=20
@@ -172,9 +160,7 @@ qemu-io: Failed to flush the L2 table cache: No space=
 left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-127 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l2_update; errno: 28; imm: off; once: off; write -b
@@ -182,9 +168,7 @@ qemu-io: Failed to flush the L2 table cache: No space=
 left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 wrote 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-127 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l2_alloc_write; errno: 5; imm: off; once: on; write=20
@@ -208,9 +192,7 @@ Event: l2_alloc_write; errno: 5; imm: off; once: off;=
 write -b
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l2_alloc_write; errno: 28; imm: off; once: on; write=20
@@ -234,9 +216,7 @@ Event: l2_alloc_write; errno: 28; imm: off; once: off=
; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-1 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: write_aio; errno: 5; imm: off; once: on; write=20
@@ -488,18 +468,14 @@ Event: refblock_alloc_hookup; errno: 28; imm: off; =
once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-55 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-251 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_write; errno: 28; imm: off; once: on; write=20
@@ -540,18 +516,14 @@ Event: refblock_alloc_write_blocks; errno: 28; imm:=
 off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-10 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; writ=
e -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-23 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: on; write=20
@@ -568,18 +540,14 @@ Event: refblock_alloc_write_table; errno: 28; imm: =
off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-10 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write=
 -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-23 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: on; write=
=20
@@ -596,18 +564,14 @@ Event: refblock_alloc_switch_table; errno: 28; imm:=
 off; once: off; write
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-10 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; writ=
e -b
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-23 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
=20
 =3D=3D=3D L1 growth tests =3D=3D=3D
=20
@@ -666,9 +630,7 @@ Event: l1_grow_activate_table; errno: 5; imm: off; on=
ce: off
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
-
-96 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824=20
=20
 Event: l1_grow_activate_table; errno: 28; imm: off; once: on
@@ -680,9 +642,7 @@ Event: l1_grow_activate_table; errno: 28; imm: off; o=
nce: off
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on devi=
ce
 write failed: No space left on device
-
-96 leaked clusters were found on the image.
-This means waste of disk space, but no harm to data.
+No errors were found on the image.
=20
 =3D=3D=3D Avoid cluster leaks after temporary failure =3D=3D=3D
=20
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index e45cdfa66b..12b4751848 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -405,6 +405,23 @@ _check_test_img()
             $QEMU_IMG check "$@" -f $IMGFMT "$TEST_IMG" 2>&1
         fi
     ) | _filter_testdir | _filter_qemu_img_check
+
+    # return real qemu_img check status, to analyze in
+    # _check_test_img_ignore_leaks
+    return ${PIPESTATUS[0]}
+}
+
+_check_test_img_ignore_leaks()
+{
+    out=3D$(_check_test_img "$@")
+    status=3D$?
+    if [ $status =3D 3 ]; then
+        # This must correspond to success output in dump_human_image_che=
ck()
+        echo "No errors were found on the image."
+        return 0
+    fi
+    echo "$out"
+    return $status
 }
=20
 _img_info()
--=20
2.21.0


