Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1823C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF0D2085B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQhGbVfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF0D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSkyQ-0008Hd-Ci
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSknG-0003Z1-6v
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSknE-0005pb-1C
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46515
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSknD-0005pR-UV
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573144675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RTeaD7I/xXq2+gPXGgG0f0Ah+wXSnx5sIY70PD2oAnY=;
 b=EQhGbVfza65TNoFy/HouoKf3TiMPUK6ys0W5MRPkayv+80mHGG+QABYoIqsZCJrUzQpn0G
 o0J5sOeKZ5pDDaRYwyw7oB9ERzErrFStm/wh+CSoqI22BEl/X6oevRQZRr6mPLVgr4CuTo
 162cicIIzdFP+d4DIwYlZPtB2+JTWIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-3G74XWgcPTqbzt9Ezc4YnA-1; Thu, 07 Nov 2019 11:37:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B700477;
 Thu,  7 Nov 2019 16:37:51 +0000 (UTC)
Received: from localhost (ovpn-117-149.ams2.redhat.com [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87BAC600D1;
 Thu,  7 Nov 2019 16:37:50 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 19/22] iotests: Make 137 work with data_file
Date: Thu,  7 Nov 2019 17:37:05 +0100
Message-Id: <20191107163708.833192-20-mreitz@redhat.com>
In-Reply-To: <20191107163708.833192-1-mreitz@redhat.com>
References: <20191107163708.833192-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 3G74XWgcPTqbzt9Ezc4YnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

With those two changes, the test will work both with and without
external data files (once that options works with the iotests at all).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
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
+if $PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features \
+    | grep -q '\<0\>'
+then
+    echo 'ERROR: Dirty bit set'
+else
+    echo 'OK: Dirty bit not set'
+fi
=20
 # Similarly we can test whether corruption detection has been enabled:
-# Create L1/L2, overwrite first entry in refcount block, allocate somethin=
g.
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
@@ -36,11 +36,9 @@ qemu-io: Unsupported value 'blubb' for qcow2 option 'ove=
rlap-check'. Allowed are
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 ./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_IO=
}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"=
 )
-incompatible_features     []
+OK: Dirty bit not set
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-wrote 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-io: Parameter 'lazy-refcounts' expects 'on' or 'off'
-qcow2: Marking image as corrupt: Preventing invalid write on metadata (ove=
rlaps with qcow2_header); further corruption events will be suppressed
+qcow2: Marking image as corrupt: Preventing invalid allocation of L2 table=
 at offset 0; further corruption events will be suppressed
 write failed: Input/output error
 *** done
--=20
2.23.0


