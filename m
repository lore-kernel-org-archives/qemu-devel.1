Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B77C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB9F206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRYWwMjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB9F206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxAW-0008Dt-WB
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwxP-0005Rq-La
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwxO-0006jE-DH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwxM-0006e9-IK
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8BsVxTHP0LkBab6ZspcAKAGv/IC3QN54ftjntgQfuw=;
 b=YRYWwMjHSSesYjkc+UeYDKFjuELPxI2QQvx3ku3s7O4L3WkRV44xTge63rQkv2+uApgVhb
 hwISakAegnMP4GX6fv40J4O81dmOLumMJiQu9WvXB6fr3eT/O/sJYjhQaqhEfnBaN4uXhO
 BOxJ1rMAsK3Jx9lmgfF4jTCWf22WLa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-DKrwkmGkPq2_JzbeqSTwzA-1; Thu, 19 Dec 2019 09:39:04 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFE27102C86C;
 Thu, 19 Dec 2019 14:39:03 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F085B6F43E;
 Thu, 19 Dec 2019 14:39:01 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 11/18] iotests: Avoid renaming images
Date: Thu, 19 Dec 2019 15:38:11 +0100
Message-Id: <20191219143818.1646168-12-mreitz@redhat.com>
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: DKrwkmGkPq2_JzbeqSTwzA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This generally does not work on non-file protocols.  It is better to
create the image with the final name from the start, and most tests do
this already.  Let 013 and 046 follow suit.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/013     | 4 +++-
 tests/qemu-iotests/013.out | 2 +-
 tests/qemu-iotests/046     | 5 +++--
 tests/qemu-iotests/046.out | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/013 b/tests/qemu-iotests/013
index b977290480..a2c748c55e 100755
--- a/tests/qemu-iotests/013
+++ b/tests/qemu-iotests/013
@@ -46,6 +46,8 @@ TEST_OFFSETS=3D"0 4294967296"
 TEST_OPS=3D"writev read write readv"
 CLUSTER_SIZE=3D4096
=20
+TEST_IMG_SAVE=3D$TEST_IMG
+TEST_IMG=3D"$TEST_IMG.orig"
 _make_test_img 6G
=20
 echo "Testing empty image"
@@ -63,7 +65,7 @@ done
 echo "Compressing image"
 echo
=20
-mv "$TEST_IMG" "$TEST_IMG.orig"
+TEST_IMG=3D$TEST_IMG_SAVE
 _make_test_img 6G
 $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -c -n "$TEST_IMG.orig" "$TEST_IMG"
=20
diff --git a/tests/qemu-iotests/013.out b/tests/qemu-iotests/013.out
index 07323a742b..23e3160b49 100644
--- a/tests/qemu-iotests/013.out
+++ b/tests/qemu-iotests/013.out
@@ -1,5 +1,5 @@
 QA output created by 013
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6442450944
+Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D6442450944
 Testing empty image
=20
 At offset 0:
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index a066eec605..1dca1f4f30 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -47,6 +47,8 @@ size=3D128M
 echo
 echo "=3D=3D creating backing file for COW tests =3D=3D"
=20
+TEST_IMG_SAVE=3D$TEST_IMG
+TEST_IMG=3D"$TEST_IMG.base"
 _make_test_img $size
=20
 backing_io()
@@ -67,8 +69,7 @@ backing_io()
=20
 backing_io 0 32 write | $QEMU_IO "$TEST_IMG" | _filter_qemu_io
=20
-mv "$TEST_IMG" "$TEST_IMG.base"
-
+TEST_IMG=3D$TEST_IMG_SAVE
 _make_test_img -b "$TEST_IMG.base" 6G
=20
 echo
diff --git a/tests/qemu-iotests/046.out b/tests/qemu-iotests/046.out
index ca2c7404a9..15d9ebd232 100644
--- a/tests/qemu-iotests/046.out
+++ b/tests/qemu-iotests/046.out
@@ -1,7 +1,7 @@
 QA output created by 046
=20
 =3D=3D creating backing file for COW tests =3D=3D
-Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 65536
--=20
2.23.0


