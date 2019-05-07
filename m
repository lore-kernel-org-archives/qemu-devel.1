Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A8AC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363D420578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363D420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48262 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1fY-0007yY-F4
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:06:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO1bY-0004yW-NO
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO1bX-0002Sh-I5
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:02:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hO1bU-0002RE-Vn; Tue, 07 May 2019 11:02:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55936308A107;
	Tue,  7 May 2019 15:01:59 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B30E65C46B;
	Tue,  7 May 2019 15:01:58 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 10:01:52 -0500
Message-Id: <20190507150153.26859-5-eblake@redhat.com>
In-Reply-To: <20190507150153.26859-1-eblake@redhat.com>
References: <20190507150153.26859-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 07 May 2019 15:01:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/5] iotests: Tweak 221 sizing for different
 hole granularities
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For some particular configurations of ext4, sizing an image to 84
sectors + 1 byte causes test failures when the size of the hole is
rounded to a 4k alignment. Let's instead size things to 128 sectors +
1 byte, as the 64k boundary is more likely to work with various hole
granularities.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190506172111.31594-1-eblake@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/221     | 10 +++++-----
 tests/qemu-iotests/221.out | 20 ++++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/221 b/tests/qemu-iotests/221
index 808cd9a289c..25dd47bcfe4 100755
--- a/tests/qemu-iotests/221
+++ b/tests/qemu-iotests/221
@@ -2,7 +2,7 @@
 #
 # Test qemu-img vs. unaligned images
 #
-# Copyright (C) 2018 Red Hat, Inc.
+# Copyright (C) 2018-2019 Red Hat, Inc.
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -41,16 +41,16 @@ echo
 echo "=3D=3D=3D Check mapping of unaligned raw image =3D=3D=3D"
 echo

-_make_test_img 43009 # qemu-img create rounds size up
+_make_test_img 65537 # qemu-img create rounds size up
 $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map

-truncate --size=3D43009 "$TEST_IMG" # so we resize it and check again
+truncate --size=3D65537 "$TEST_IMG" # so we resize it and check again
 $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map

-$QEMU_IO -c 'w 43008 1' "$TEST_IMG" | _filter_qemu_io # writing also rou=
nds up
+$QEMU_IO -c 'w 65536 1' "$TEST_IMG" | _filter_qemu_io # writing also rou=
nds up
 $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map

-truncate --size=3D43009 "$TEST_IMG" # so we resize it and check again
+truncate --size=3D65537 "$TEST_IMG" # so we resize it and check again
 $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map

 # success, all done
diff --git a/tests/qemu-iotests/221.out b/tests/qemu-iotests/221.out
index a9c0190aadc..9f9dd52bb0b 100644
--- a/tests/qemu-iotests/221.out
+++ b/tests/qemu-iotests/221.out
@@ -2,15 +2,15 @@ QA output created by 221

 =3D=3D=3D Check mapping of unaligned raw image =3D=3D=3D

-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D43009
-[{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET}]
-[{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET}]
-wrote 1/1 bytes at offset 43008
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D65537
+[{ "start": 0, "length": 66048, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET}]
+[{ "start": 0, "length": 66048, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET}]
+wrote 1/1 bytes at offset 65536
 1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 40960, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET},
-{ "start": 40960, "length": 2049, "depth": 0, "zero": false, "data": tru=
e, "offset": OFFSET},
-{ "start": 43009, "length": 511, "depth": 0, "zero": true, "data": false=
, "offset": OFFSET}]
-[{ "start": 0, "length": 40960, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET},
-{ "start": 40960, "length": 2049, "depth": 0, "zero": false, "data": tru=
e, "offset": OFFSET},
-{ "start": 43009, "length": 511, "depth": 0, "zero": true, "data": false=
, "offset": OFFSET}]
+[{ "start": 0, "length": 65536, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET},
+{ "start": 65536, "length": 1, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
+{ "start": 65537, "length": 511, "depth": 0, "zero": true, "data": false=
, "offset": OFFSET}]
+[{ "start": 0, "length": 65536, "depth": 0, "zero": true, "data": false,=
 "offset": OFFSET},
+{ "start": 65536, "length": 1, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
+{ "start": 65537, "length": 511, "depth": 0, "zero": true, "data": false=
, "offset": OFFSET}]
 *** done
--=20
2.20.1


