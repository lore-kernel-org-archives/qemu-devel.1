Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE2DC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980CC20658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkHIRAID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980CC20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6bHc-0006hX-Pb
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j6bFR-0002oc-9d
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j6bFQ-0008Eu-6E
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:31:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51649
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j6bFQ-0008ER-2s
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582641103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8NrlLHdPEWlYNVKMX5mYs4xVk+uC86xfgXcftrsMAm4=;
 b=PkHIRAIDVEkG0BGzaXJDJB63N1EpeYsju9qUmxNdXfFdedzO4w1M2Rv6GvZZ61G8QS/vmP
 lfyydv6OOWNCfbXk3SSSRVNo1HS700bDg14mbHOLygIens4hZhk7jxF+z83nQeGSABcAkR
 8goGBIj+fxhB4k/5z/FUqZvA/lJixIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-Sbe32j4YNeik9p6GPuPgVw-1; Tue, 25 Feb 2020 09:31:40 -0500
X-MC-Unique: Sbe32j4YNeik9p6GPuPgVw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3971477;
 Tue, 25 Feb 2020 14:31:38 +0000 (UTC)
Received: from localhost (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 610165DA60;
 Tue, 25 Feb 2020 14:31:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/3] iotests/026: Test EIO on allocation in a data-file
Date: Tue, 25 Feb 2020 15:31:30 +0100
Message-Id: <20200225143130.111267-4-mreitz@redhat.com>
In-Reply-To: <20200225143130.111267-1-mreitz@redhat.com>
References: <20200225143130.111267-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test what happens when writing data to an external data file, where the
write requires an L2 entry to be allocated, but the data write fails.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/026             | 32 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/026.out         |  6 ++++++
 tests/qemu-iotests/026.out.nocache |  6 ++++++
 3 files changed, 44 insertions(+)

diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index 0c1273c339..b05a4692cf 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -30,6 +30,7 @@ _cleanup()
 {
 =09_cleanup_test_img
     rm "$TEST_DIR/blkdebug.conf"
+    rm -f "$TEST_IMG.data_file"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -239,6 +240,37 @@ $QEMU_IO -c "write 0 $CLUSTER_SIZE" "$BLKDBG_TEST_IMG"=
 | _filter_qemu_io
=20
 _check_test_img
=20
+echo
+echo =3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
+echo
+
+# Similar test as the last one, except we test what happens when there
+# is an error when writing to an external data file instead of when
+# writing to a preallocated zero cluster
+_make_test_img -o "data_file=3D$TEST_IMG.data_file" $CLUSTER_SIZE
+
+# Put blkdebug above the data-file, and a raw node on top of that so
+# that blkdebug will see a write_aio event and emit an error
+$QEMU_IO -c "write 0 $CLUSTER_SIZE" \
+    "json:{
+         'driver': 'qcow2',
+         'file': { 'driver': 'file', 'filename': '$TEST_IMG' },
+         'data-file': {
+             'driver': 'raw',
+             'file': {
+                 'driver': 'blkdebug',
+                 'config': '$TEST_DIR/blkdebug.conf',
+                 'image': {
+                     'driver': 'file',
+                     'filename': '$TEST_IMG.data_file'
+                 }
+             }
+         }
+     }" \
+    | _filter_qemu_io
+
+_check_test_img
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index 83989996ff..c1b3b58482 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -653,4 +653,10 @@ wrote 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 write failed: Input/output error
 No errors were found on the image.
+
+=3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1024 data_file=3DTEST_=
DIR/t.IMGFMT.data_file
+write failed: Input/output error
+No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.ou=
t.nocache
index 9359d26d7e..8d5001648a 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -661,4 +661,10 @@ wrote 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 write failed: Input/output error
 No errors were found on the image.
+
+=3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1024 data_file=3DTEST_=
DIR/t.IMGFMT.data_file
+write failed: Input/output error
+No errors were found on the image.
 *** done
--=20
2.24.1


