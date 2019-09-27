Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE590C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7E42146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7E42146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDn27-0003yN-CT
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDmmc-0003lU-Ot
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDmmb-00086D-Em
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:43:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDmmX-0007zN-Rf; Fri, 27 Sep 2019 05:43:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 19B9B3099F56;
 Fri, 27 Sep 2019 09:43:21 +0000 (UTC)
Received: from localhost (ovpn-204-76.brq.redhat.com [10.40.204.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A68095C21A;
 Fri, 27 Sep 2019 09:43:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 15/18] iotests: Make 137 work with data_file
Date: Fri, 27 Sep 2019 11:42:39 +0200
Message-Id: <20190927094242.11152-16-mreitz@redhat.com>
In-Reply-To: <20190927094242.11152-1-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 27 Sep 2019 09:43:21 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using an external data file, there are no refcounts for data
clusters.  We thus have to adjust the corruption test in this patch to
not be based around a data cluster allocation, but the L2 table
allocation (L2 tables are still refcounted with external data files).

Doing so means this test works both with and without external data
files.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/137     | 10 ++++++----
 tests/qemu-iotests/137.out |  4 +---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 6cf2997577..dd3484205e 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -138,14 +138,16 @@ $QEMU_IO \
     "$TEST_IMG" 2>&1 | _filter_qemu_io
=20
 # The dirty bit must not be set
-$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
+# (Filter the external data file bit)
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features \
+    | sed -e 's/0x4/0x0/'
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
index 1c6569eb2c..bd5f76d604 100644
--- a/tests/qemu-iotests/137.out
+++ b/tests/qemu-iotests/137.out
@@ -38,9 +38,7 @@ wrote 512/512 bytes at offset 0
 ./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS =
"$@" )
 incompatible_features     0x0
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


