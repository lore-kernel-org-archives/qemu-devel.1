Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06E8ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56F72054F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56F72054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKOAF-0006dE-TR
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 10:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iKNoL-0007Iy-LV
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iKNoK-0000KU-A0
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:28:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50048)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iKNoH-0000IB-D9; Tue, 15 Oct 2019 10:28:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A2D4E30BE7DB;
 Tue, 15 Oct 2019 14:28:24 +0000 (UTC)
Received: from localhost (ovpn-117-226.ams2.redhat.com [10.36.117.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4773860628;
 Tue, 15 Oct 2019 14:28:24 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 18/21] iotests: Make 137 work with data_file
Date: Tue, 15 Oct 2019 16:27:26 +0200
Message-Id: <20191015142729.18123-19-mreitz@redhat.com>
In-Reply-To: <20191015142729.18123-1-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 15 Oct 2019 14:28:24 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using an external data file, there are no refcounts for data
clusters.  We thus have to adjust the corruption test in this patch to
not be based around a data cluster allocation, but the L2 table
allocation (L2 tables are still refcounted with external data files).

Furthermore, we should not print qcow2.py's list of incompatible
features because it differs depending on whether there is an external
data file or not.

With those two changes, the test will work both with an external data
files (once that options works with the iotests at all).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/137     | 15 +++++++++++----
 tests/qemu-iotests/137.out |  6 ++----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 6cf2997577..7ae86892f7 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -138,14 +138,21 @@ $QEMU_IO \
     "$TEST_IMG" 2>&1 | _filter_qemu_io
=20
 # The dirty bit must not be set
-$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
+# (Filter the external data file bit)
+if $PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features=
 \
+    | grep -q '\<0\>'
+then
+    echo 'ERROR: Dirty bit set'
+else
+    echo 'OK: Dirty bit not set'
+fi
=20
 # Similarly we can test whether corruption detection has been enabled:
-# Create L1/L2, overwrite first entry in refcount block, allocate someth=
ing.
+# Create L1, overwrite refcounts, force allocation of L2 by writing
+# data.
 # Disabling the checks should fail, so the corruption must be detected.
 _make_test_img 64M
-$QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
-poke_file "$TEST_IMG" "$((0x20000))" "\x00\x00"
+poke_file "$TEST_IMG" "$((0x20000))" "\x00\x00\x00\x00\x00\x00\x00\x00"
 $QEMU_IO \
     -c "reopen -o overlap-check=3Dnone,lazy-refcounts=3D42" \
     -c "write 64k 64k" \
diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
index bd4523a853..86377c80cd 100644
--- a/tests/qemu-iotests/137.out
+++ b/tests/qemu-iotests/137.out
@@ -36,11 +36,9 @@ qemu-io: Unsupported value 'blubb' for qcow2 option 'o=
verlap-check'. Allowed are
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 ./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS =
"$@" )
-incompatible_features     []
+OK: Dirty bit not set
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-wrote 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-io: Parameter 'lazy-refcounts' expects 'on' or 'off'
-qcow2: Marking image as corrupt: Preventing invalid write on metadata (o=
verlaps with qcow2_header); further corruption events will be suppressed
+qcow2: Marking image as corrupt: Preventing invalid allocation of L2 tab=
le at offset 0; further corruption events will be suppressed
 write failed: Input/output error
 *** done
--=20
2.21.0


