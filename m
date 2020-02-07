Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76906C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31BDE20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYQAkaqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BDE20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j047O-0007hB-Cw
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 08:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j046a-00078e-JJ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j046Y-0006NP-Li
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:55:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55729
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j046Y-0006JX-IR
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581083733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qz4yieI6vQxXyW2OEURqr0zWf+t2yMhR16RorPIM84M=;
 b=BYQAkaqBogndmZSeEUIC1Ho867wHiT2XBeyvhkkTCgWcfsP8ilaTxEF/az7PE3aXKZrQSC
 KVEtxZY3qJwaT+zevgeNvjjK2xY9lMMuqkSQLfovhc4XC+hokKZtLpVEyb4vbWz/5KMzrp
 WuhFjFfX0UuHnEwUqSq3I/NfseFdSPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-DfiPZP6CMu-QQmZGZ5eVSQ-1; Fri, 07 Feb 2020 08:55:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B2258024FA;
 Fri,  7 Feb 2020 13:55:28 +0000 (UTC)
Received: from dhcp-16-105.lcy.redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 863F6790D7;
 Fri,  7 Feb 2020 13:55:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] block: always fill entire LUKS header space with zeros
Date: Fri,  7 Feb 2020 13:55:20 +0000
Message-Id: <20200207135520.2669430-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: DfiPZP6CMu-QQmZGZ5eVSQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When initializing the LUKS header the size with default encryption
parameters will currently be 2068480 bytes. This is rounded up to
a multiple of the cluster size, 2081792, with 64k sectors. If the
end of the header is not the same as the end of the cluster we fill
the extra space with zeros. This was forgetting that not even the
space allocated for the header will be fully initialized, as we
only write key material for the first key slot. The space left
for the other 7 slots is never written to.

An optimization to the ref count checking code:

  commit a5fff8d4b4d928311a5005efa12d0991fe3b66f9 (refs/bisect/bad)
  Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
  Date:   Wed Feb 27 16:14:30 2019 +0300

    qcow2-refcount: avoid eating RAM

made the assumption that every cluster which was allocated would
have at least some data written to it. This was violated by way
the LUKS header is only partially written, with much space simply
reserved for future use.

Depending on the cluster size this problem was masked by the
logic which wrote zeros between the end of the LUKS header and
the end of the cluster.

$ qemu-img create --object secret,id=3Dcluster_encrypt0,data=3D123456 \
   -f qcow2 -o cluster_size=3D2k,encrypt.iter-time=3D1,\
               encrypt.format=3Dluks,encrypt.key-secret=3Dcluster_encrypt0 =
\
               cluster_size_check.qcow2 100M
  Formatting 'cluster_size_check.qcow2', fmt=3Dqcow2 size=3D104857600
    encrypt.format=3Dluks encrypt.key-secret=3Dcluster_encrypt0
    encrypt.iter-time=3D1 cluster_size=3D2048 lazy_refcounts=3Doff refcount=
_bits=3D16

$ qemu-img check --object secret,id=3Dcluster_encrypt0,data=3Dredhat \
    'json:{"driver": "qcow2", "encrypt.format": "luks", \
           "encrypt.key-secret": "cluster_encrypt0", \
           "file.driver": "file", "file.filename": "cluster_size_check.qcow=
2"}'
ERROR: counting reference for region exceeding the end of the file by one c=
luster or more: offset 0x2000 size 0x1f9000
Leaked cluster 4 refcount=3D1 reference=3D0
...snip...
Leaked cluster 130 refcount=3D1 reference=3D0

1 errors were found on the image.
Data may be corrupted, or further writes to the image may corrupt it.

127 leaked clusters were found on the image.
This means waste of disk space, but no harm to data.
Image end offset: 268288

The problem only exists when the disk image is entirely empty. Writing
data to the disk image payload will solve the problem by causing the
end of the file to be extended further.

The change fixes it by ensuring that the entire allocated LUKS header
region is fully initialized with zeros. The qemu-img check will still
fail for any pre-existing disk images created prior to this change,
unless at least 1 byte of the payload is written to.

Fully writing zeros to the entire LUKS header is a good idea regardless
as it ensures that space has been allocated on the host filesystem (or
whatever block storage backend is used).

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---

In v2:

 - Cut down test scenarios to speed up
 - Use _check_test_img helper
 - Fix outdated comments
 - Use space not tabs

 block/qcow2.c              | 11 +++--
 tests/qemu-iotests/284     | 97 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/284.out | 62 ++++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 167 insertions(+), 4 deletions(-)
 create mode 100755 tests/qemu-iotests/284
 create mode 100644 tests/qemu-iotests/284.out

diff --git a/block/qcow2.c b/block/qcow2.c
index ef96606f8d..b2ab25cce5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -135,13 +135,16 @@ static ssize_t qcow2_crypto_hdr_init_func(QCryptoBloc=
k *block, size_t headerlen,
     s->crypto_header.length =3D headerlen;
     s->crypto_header.offset =3D ret;
=20
-    /* Zero fill remaining space in cluster so it has predictable
-     * content in case of future spec changes */
+    /*
+     * Zero fill all space in cluster so it has predictable
+     * content, as we may not initialize some regions of the
+     * header (eg only 1 out of 8 key slots will be initialized)
+     */
     clusterlen =3D size_to_clusters(s, headerlen) * s->cluster_size;
     assert(qcow2_pre_write_overlap_check(bs, 0, ret, clusterlen, false) =
=3D=3D 0);
     ret =3D bdrv_pwrite_zeroes(bs->file,
-                             ret + headerlen,
-                             clusterlen - headerlen, 0);
+                             ret,
+                             clusterlen, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not zero fill encryption heade=
r");
         return -1;
diff --git a/tests/qemu-iotests/284 b/tests/qemu-iotests/284
new file mode 100755
index 0000000000..071e89b33e
--- /dev/null
+++ b/tests/qemu-iotests/284
@@ -0,0 +1,97 @@
+#!/usr/bin/env bash
+#
+# Test ref count checks on encrypted images
+#
+# Copyright (C) 2019 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=3Dberrange@redhat.com
+
+seq=3D`basename $0`
+echo "QA output created by $seq"
+
+status=3D1        # failure is the default!
+
+_cleanup()
+{
+        _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto generic
+_supported_os Linux
+
+
+size=3D1M
+
+SECRET=3D"secret,id=3Dsec0,data=3Dastrochicken"
+
+IMGSPEC=3D"driver=3D$IMGFMT,file.filename=3D$TEST_IMG,encrypt.key-secret=
=3Dsec0"
+QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
+
+_run_test()
+{
+        IMGOPTSSYNTAX=3Dtrue
+        OLD_TEST_IMG=3D"$TEST_IMG"
+        TEST_IMG=3D"driver=3D$IMGFMT,file.filename=3D$TEST_IMG,encrypt.key=
-secret=3Dsec0"
+        QEMU_IMG_EXTRA_ARGS=3D"--image-opts --object $SECRET"
+
+        echo
+        echo "=3D=3D cluster size $csize"
+        echo "=3D=3D checking image refcounts =3D=3D"
+        _check_test_img
+
+        echo
+        echo "=3D=3D writing some data =3D=3D"
+        $QEMU_IO -c "write -P 0x9 0 1"  $QEMU_IMG_EXTRA_ARGS $TEST_IMG | _=
filter_qemu_io | _filter_testdir
+        echo
+        echo "=3D=3D rechecking image refcounts =3D=3D"
+        _check_test_img
+
+        echo
+        echo "=3D=3D writing some more data =3D=3D"
+        $QEMU_IO -c "write -P 0x9 $csize 1" $QEMU_IMG_EXTRA_ARGS $TEST_IMG=
 | _filter_qemu_io | _filter_testdir
+        echo
+        echo "=3D=3D rechecking image refcounts =3D=3D"
+        _check_test_img
+
+        TEST_IMG=3D"$OLD_TEST_IMG"
+        QEMU_IMG_EXTRA_ARGS=3D
+        IMGOPTSSYNTAX=3D
+}
+
+
+echo
+echo "testing LUKS qcow2 encryption"
+echo
+
+for csize in 512 2048 32768
+do
+  _make_test_img --object $SECRET -o "encrypt.format=3Dluks,encrypt.key-se=
cret=3Dsec0,encrypt.iter-time=3D10,cluster_size=3D$csize" $size
+  _run_test
+  _cleanup_test_img
+done
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/284.out b/tests/qemu-iotests/284.out
new file mode 100644
index 0000000000..48216f5742
--- /dev/null
+++ b/tests/qemu-iotests/284.out
@@ -0,0 +1,62 @@
+QA output created by 284
+
+testing LUKS qcow2 encryption
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 encrypt.format=
=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+
+=3D=3D cluster size 512
+=3D=3D checking image refcounts =3D=3D
+No errors were found on the image.
+
+=3D=3D writing some data =3D=3D
+wrote 1/1 bytes at offset 0
+1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D rechecking image refcounts =3D=3D
+No errors were found on the image.
+
+=3D=3D writing some more data =3D=3D
+wrote 1/1 bytes at offset 512
+1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D rechecking image refcounts =3D=3D
+No errors were found on the image.
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 encrypt.format=
=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+
+=3D=3D cluster size 2048
+=3D=3D checking image refcounts =3D=3D
+No errors were found on the image.
+
+=3D=3D writing some data =3D=3D
+wrote 1/1 bytes at offset 0
+1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D rechecking image refcounts =3D=3D
+No errors were found on the image.
+
+=3D=3D writing some more data =3D=3D
+wrote 1/1 bytes at offset 2048
+1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D rechecking image refcounts =3D=3D
+No errors were found on the image.
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 encrypt.format=
=3Dluks encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10
+
+=3D=3D cluster size 32768
+=3D=3D checking image refcounts =3D=3D
+No errors were found on the image.
+
+=3D=3D writing some data =3D=3D
+wrote 1/1 bytes at offset 0
+1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D rechecking image refcounts =3D=3D
+No errors were found on the image.
+
+=3D=3D writing some more data =3D=3D
+wrote 1/1 bytes at offset 32768
+1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D rechecking image refcounts =3D=3D
+No errors were found on the image.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 1904223020..818380a8f0 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -290,3 +290,4 @@
 280 rw migration quick
 281 rw quick
 283 auto quick
+284 rw
--=20
2.24.1


