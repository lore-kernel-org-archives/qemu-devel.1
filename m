Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A32C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ADA0214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYU2BNVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADA0214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSizj-0004SJ-BL
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSirZ-0002tT-IM
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSirX-0004jC-1B
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:34:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34977
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSirW-0004is-5Y
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573137253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwdFC7oQTGsEL9kJ3nbZjPDNCd3b12TNmsXjvR8S1OU=;
 b=gYU2BNVYxC5TI8qrY3Z6MhK9sCYZMLPIvYDIfzp5vsM/htBBJC7XqB8PoD7zf89jGiIuOt
 UPdDKz34380zcGqEe1RgV0zsgL9S+V9yTCPxBY4/9qmBf3K4a5HnstQ71sTJuObvwzQKS6
 vOlManMyDtd2x407GLTol/ZcnmQm8PU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-q9lEkRTKP3O69NoxKSEjiw-1; Thu, 07 Nov 2019 09:34:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BD561800D6B;
 Thu,  7 Nov 2019 14:34:09 +0000 (UTC)
Received: from localhost (ovpn-117-149.ams2.redhat.com [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E58660BFB;
 Thu,  7 Nov 2019 14:34:07 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 3/3] iotests: Add test for 4G+ compressed qcow2 write
Date: Thu,  7 Nov 2019 15:33:56 +0100
Message-Id: <20191107143356.579334-4-mreitz@redhat.com>
In-Reply-To: <20191107143356.579334-1-mreitz@redhat.com>
References: <20191107143356.579334-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: q9lEkRTKP3O69NoxKSEjiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test what qemu-img check says about an image after one has written
compressed data to an offset above 4 GB.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20191028161841.1198-3-mreitz@redhat.com
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/272     | 79 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/272.out | 10 +++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 90 insertions(+)
 create mode 100755 tests/qemu-iotests/272
 create mode 100644 tests/qemu-iotests/272.out

diff --git a/tests/qemu-iotests/272 b/tests/qemu-iotests/272
new file mode 100755
index 0000000000..c2f782d47b
--- /dev/null
+++ b/tests/qemu-iotests/272
@@ -0,0 +1,79 @@
+#!/usr/bin/env bash
+#
+# Test compressed write to a qcow2 image at an offset above 4 GB
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
+seq=3D$(basename "$0")
+echo "QA output created by $seq"
+
+status=3D1=09# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+# This is a qcow2 regression test
+_supported_fmt qcow2
+_supported_proto file
+
+# External data files do not support compression;
+# We need an exact cluster size (2M) and refcount width (2) so we can
+# get this test quickly over with; and this in turn require
+# compat=3D1.1
+_unsupported_imgopts data_file cluster_size refcount_bits 'compat=3D0.10'
+
+# The idea is: Create an empty file, mark the first 4 GB as used, then
+# do a compressed write that thus must be put beyond 4 GB.
+# (This used to fail because the compressed sector mask was just a
+# 32 bit mask, so qemu-img check will count a cluster before 4 GB as
+# referenced twice.)
+
+# We would like to use refcount_bits=3D1 here, but then qemu-img check
+# will throw an error when trying to count a cluster as referenced
+# twice.
+_make_test_img -o cluster_size=3D2M,refcount_bits=3D2 64M
+
+reft_offs=3D$(peek_file_be "$TEST_IMG" 48 8)
+refb_offs=3D$(peek_file_be "$TEST_IMG" $reft_offs 8)
+
+# We want to cover 4 GB, those are 2048 clusters, equivalent to
+# 4096 bit =3D 512 B.
+truncate -s 4G "$TEST_IMG"
+for ((in_refb_offs =3D 0; in_refb_offs < 512; in_refb_offs +=3D 8)); do
+    poke_file "$TEST_IMG" $((refb_offs + in_refb_offs)) \
+        '\x55\x55\x55\x55\x55\x55\x55\x55'
+done
+
+$QEMU_IO -c 'write -c -P 42 0 2M' "$TEST_IMG" | _filter_qemu_io
+
+echo
+echo '--- Check ---'
+
+# This should only print the leaked clusters in the first 4 GB
+_check_test_img | grep -v '^Leaked cluster '
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/272.out b/tests/qemu-iotests/272.out
new file mode 100644
index 0000000000..35698b0e73
--- /dev/null
+++ b/tests/qemu-iotests/272.out
@@ -0,0 +1,10 @@
+QA output created by 272
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+wrote 2097152/2097152 bytes at offset 0
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+--- Check ---
+
+2044 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 095ed1b880..065040398d 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -283,3 +283,4 @@
 267 rw auto quick snapshot
 268 rw auto quick
 270 rw backing quick
+272 rw
--=20
2.23.0


