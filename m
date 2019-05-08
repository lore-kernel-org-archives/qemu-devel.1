Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950C6C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A18320675
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A18320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37827 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOND5-0001a9-Jn
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 10:06:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hON90-0006ob-U9
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hON8z-00024T-Jr
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:02:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hON8s-0001vr-Ou; Wed, 08 May 2019 10:01:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA661806A6;
	Wed,  8 May 2019 14:01:48 +0000 (UTC)
Received: from localhost (ovpn-204-94.brq.redhat.com [10.40.204.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E6AC10027C2;
	Wed,  8 May 2019 14:01:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  8 May 2019 16:01:39 +0200
Message-Id: <20190508140139.32722-4-mreitz@redhat.com>
In-Reply-To: <20190508140139.32722-1-mreitz@redhat.com>
References: <20190508140139.32722-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 08 May 2019 14:01:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 3/3] iotests: Add test for rebase without
 input base
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds a test for rebasing an image that currently does not
have a backing file.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/024     | 70 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/024.out | 37 ++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index 23298c6f59..baf8ec9f28 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -198,6 +198,76 @@ echo
 # $BASE_OLD and $BASE_NEW)
 $QEMU_IMG map "$OVERLAY" | _filter_qemu_img_map
=20
+echo
+echo "=3D=3D=3D Test rebase without input base =3D=3D=3D"
+echo
+
+# Cluster allocations to be tested:
+#
+# Backing (new) 11 -- 11 -- 11 --
+# COW image     22 22 11 11 -- --
+#
+# Expected result:
+#
+# COW image     22 22 11 11 00 --
+#
+# (Cluster 2 might be "--" after the rebase, too, but rebase just
+#  compares the new backing file to the old one and disregards the
+#  overlay.  Therefore, it will never discard overlay clusters.)
+
+_make_test_img $((6 * CLUSTER_SIZE))
+TEST_IMG=3D"$TEST_IMG_SAVE.base_new" _make_test_img $((6 * CLUSTER_SIZE)=
)
+
+echo
+
+$QEMU_IO "$TEST_IMG" \
+    -c "write -P 0x22 $((0 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "write -P 0x11 $((2 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    | _filter_qemu_io
+
+$QEMU_IO "$TEST_IMG.base_new" \
+    -c "write -P 0x11 $((0 * CLUSTER_SIZE)) $CLUSTER_SIZE" \
+    -c "write -P 0x11 $((2 * CLUSTER_SIZE)) $CLUSTER_SIZE" \
+    -c "write -P 0x11 $((4 * CLUSTER_SIZE)) $CLUSTER_SIZE" \
+    | _filter_qemu_io
+
+echo
+
+# This should be a no-op
+$QEMU_IMG rebase -b "" "$TEST_IMG"
+
+# Verify the data is correct
+$QEMU_IO "$TEST_IMG" \
+    -c "read -P 0x22 $((0 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "read -P 0x11 $((2 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "read -P 0x00 $((4 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    | _filter_qemu_io
+
+echo
+
+# Verify the allocation status (first four cluster should be allocated
+# in TEST_IMG, clusters 4 and 5 should be unallocated (marked as zero
+# clusters here because there is no backing file))
+$QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
+
+echo
+
+$QEMU_IMG rebase -b "$TEST_IMG.base_new" "$TEST_IMG"
+
+# Verify the data is correct
+$QEMU_IO "$TEST_IMG" \
+    -c "read -P 0x22 $((0 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "read -P 0x11 $((2 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    -c "read -P 0x00 $((4 * CLUSTER_SIZE)) $((2 * CLUSTER_SIZE))" \
+    | _filter_qemu_io
+
+echo
+
+# Verify the allocation status (first four cluster should be allocated
+# in TEST_IMG, cluster 4 should be zero, and cluster 5 should be
+# unallocated (signified by '"depth": 1'))
+$QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
+
=20
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
index 024dc786b3..830abe013d 100644
--- a/tests/qemu-iotests/024.out
+++ b/tests/qemu-iotests/024.out
@@ -171,4 +171,41 @@ read 65536/65536 bytes at offset 196608
 Offset          Length          File
 0               0x30000         TEST_DIR/subdir/t.IMGFMT
 0x30000         0x10000         TEST_DIR/subdir/t.IMGFMT.base_new
+
+=3D=3D=3D Test rebase without input base =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D393216
+Formatting 'TEST_DIR/t.IMGFMT.base_new', fmt=3DIMGFMT size=3D393216
+
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 131072
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 131072
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 262144
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+read 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 131072
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 262144
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+[{ "start": 0, "length": 262144, "depth": 0, "zero": false, "data": true=
, "offset": OFFSET},
+{ "start": 262144, "length": 131072, "depth": 0, "zero": true, "data": f=
alse}]
+
+read 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 131072
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 131072/131072 bytes at offset 262144
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+[{ "start": 0, "length": 262144, "depth": 0, "zero": false, "data": true=
, "offset": OFFSET},
+{ "start": 262144, "length": 65536, "depth": 0, "zero": true, "data": fa=
lse},
+{ "start": 327680, "length": 65536, "depth": 1, "zero": true, "data": fa=
lse}]
 *** done
--=20
2.20.1


