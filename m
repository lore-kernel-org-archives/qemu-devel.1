Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17911C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D311F20873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6loyAwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D311F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1xd-0000YK-Vw
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1ml-0003li-6B
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1mj-0002Ps-7i
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57436
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1mj-0002O3-1y
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qq6XgEjo+qIMXWXCWiN9rXOHiAaiICEsYe0CUsnYDWw=;
 b=P6loyAwlIv3vA4XtIzRTRh8DQNL2h3BBSnSv+M0KzKyRJpxKu2Bb5b31cfRGelVrU2tD8O
 gDe1XhNPjBiSAxgK6KwWoiD6rpbvWseTnaqLRgkQoPzJnLG8Sd9Vr6SLuCM/u35rvtmrbc
 lprXtIwQ5YAQE+hYOGJYmZ7xXft3jPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-LOV-fndVNb2Ltn3ovZy0Xg-1; Wed, 11 Mar 2020 09:52:28 -0400
X-MC-Unique: LOV-fndVNb2Ltn3ovZy0Xg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 835E6800EBC;
 Wed, 11 Mar 2020 13:52:27 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F275092D2F;
 Wed, 11 Mar 2020 13:52:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/19] iotests: add 288 luks qemu-img measure test
Date: Wed, 11 Mar 2020 14:51:58 +0100
Message-Id: <20200311135213.1242028-5-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
References: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

This test exercises the block/crypto.c "luks" block driver
.bdrv_measure() code.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200221112522.1497712-5-stefanha@redhat.com>
[mreitz: Renamed test from 282 to 288]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/288     | 93 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/288.out | 30 ++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 124 insertions(+)
 create mode 100755 tests/qemu-iotests/288
 create mode 100644 tests/qemu-iotests/288.out

diff --git a/tests/qemu-iotests/288 b/tests/qemu-iotests/288
new file mode 100755
index 0000000000..6c62065aef
--- /dev/null
+++ b/tests/qemu-iotests/288
@@ -0,0 +1,93 @@
+#!/usr/bin/env bash
+#
+# qemu-img measure tests for LUKS images
+#
+# Copyright (C) 2020 Red Hat, Inc.
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
+owner=3Dstefanha@redhat.com
+
+seq=3D`basename $0`
+echo "QA output created by $seq"
+
+status=3D1    # failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    rm -f "$TEST_IMG.converted"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.pattern
+
+_supported_fmt luks
+_supported_proto file
+_supported_os Linux
+
+SECRET=3Dsecret,id=3Dsec0,data=3Dpassphrase
+
+echo "=3D=3D measure 1G image file =3D=3D"
+echo
+
+$QEMU_IMG measure --object "$SECRET" \
+=09          -O "$IMGFMT" \
+=09=09  -o key-secret=3Dsec0,iter-time=3D10 \
+=09=09  --size 1G
+
+echo
+echo "=3D=3D create 1G image file (size should be no greater than measured=
) =3D=3D"
+echo
+
+_make_test_img 1G
+stat -c "image file size in bytes: %s" "$TEST_IMG_FILE"
+
+echo
+echo "=3D=3D modified 1G image file (size should be no greater than measur=
ed) =3D=3D"
+echo
+
+$QEMU_IO --object "$SECRET" --image-opts "$TEST_IMG" -c "write -P 0x51 0x1=
0000 0x400" | _filter_qemu_io | _filter_testdir
+stat -c "image file size in bytes: %s" "$TEST_IMG_FILE"
+
+echo
+echo "=3D=3D measure preallocation=3Dfalloc 1G image file =3D=3D"
+echo
+
+$QEMU_IMG measure --object "$SECRET" \
+=09          -O "$IMGFMT" \
+=09=09  -o key-secret=3Dsec0,iter-time=3D10,preallocation=3Dfalloc \
+=09=09  --size 1G
+
+echo
+echo "=3D=3D measure with input image file =3D=3D"
+echo
+
+IMGFMT=3Draw IMGKEYSECRET=3D IMGOPTS=3D _make_test_img 1G | _filter_imgfmt
+QEMU_IO_OPTIONS=3D IMGOPTSSYNTAX=3D $QEMU_IO -f raw -c "write -P 0x51 0x10=
000 0x400" "$TEST_IMG_FILE" | _filter_qemu_io | _filter_testdir
+$QEMU_IMG measure --object "$SECRET" \
+=09          -O "$IMGFMT" \
+=09=09  -o key-secret=3Dsec0,iter-time=3D10 \
+=09=09  -f raw \
+=09=09  "$TEST_IMG_FILE"
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/288.out b/tests/qemu-iotests/288.out
new file mode 100644
index 0000000000..4bc593dc48
--- /dev/null
+++ b/tests/qemu-iotests/288.out
@@ -0,0 +1,30 @@
+QA output created by 288
+=3D=3D measure 1G image file =3D=3D
+
+required size: 1075810304
+fully allocated size: 1075810304
+
+=3D=3D create 1G image file (size should be no greater than measured) =3D=
=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
+image file size in bytes: 1075810304
+
+=3D=3D modified 1G image file (size should be no greater than measured) =
=3D=3D
+
+wrote 1024/1024 bytes at offset 65536
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+image file size in bytes: 1075810304
+
+=3D=3D measure preallocation=3Dfalloc 1G image file =3D=3D
+
+required size: 1075810304
+fully allocated size: 1075810304
+
+=3D=3D measure with input image file =3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1073741824
+wrote 1024/1024 bytes at offset 65536
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+required size: 1075810304
+fully allocated size: 1075810304
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 0317667695..559edc139a 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -293,3 +293,4 @@
 283 auto quick
 284 rw
 286 rw quick
+288 quick
--=20
2.24.1


