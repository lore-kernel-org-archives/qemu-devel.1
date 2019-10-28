Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0DBCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59159208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6ceNBth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59159208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4HC-0002p8-0W
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3w4-0001oK-IY
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3w2-0001T5-Px
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42786
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3w2-0001Ss-LL
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+T5sUsAMqhzKjQpHaXLv+CzeSkI65I6IV4Nh3mOMPA=;
 b=b6ceNBthCxyl3DSvmUldGXgdsMjUMPDEkex8Nmr/80vcR/N9QMebF065dK39nb1gj1iCA8
 PXd5wWZSrsdkyQwkBUuG6r6rGgAApJZgdphScSWQuo0sKyLMIetAqPVSLLP2dXx/NGP3MY
 j1sjoBOcG3JOIYQbt6ofoh1sPzEjYjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-7Pwjz-gIMKGGzMA2AFvzoQ-1; Mon, 28 Oct 2019 08:15:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB47310052E0;
 Mon, 28 Oct 2019 12:15:40 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91EBF60BF7;
 Mon, 28 Oct 2019 12:15:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 18/69] iotests/083: Create socket in $SOCK_DIR
Date: Mon, 28 Oct 2019 13:14:10 +0100
Message-Id: <20191028121501.15279-19-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 7Pwjz-gIMKGGzMA2AFvzoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20191017133155.5327-7-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/083     |  6 +++---
 tests/qemu-iotests/083.out | 34 +++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tests/qemu-iotests/083 b/tests/qemu-iotests/083
index b270550d3e..10fdfc8ebb 100755
--- a/tests/qemu-iotests/083
+++ b/tests/qemu-iotests/083
@@ -28,7 +28,7 @@ status=3D1=09# failure is the default!
=20
 _cleanup()
 {
-=09rm -f nbd.sock
+=09rm -f "$SOCK_DIR/nbd.sock"
 =09rm -f nbd-fault-injector.out
 =09rm -f nbd-fault-injector.conf
 }
@@ -80,10 +80,10 @@ EOF
 =09if [ "$proto" =3D "tcp" ]; then
 =09=09nbd_addr=3D"127.0.0.1:0"
 =09else
-=09=09nbd_addr=3D"$TEST_DIR/nbd.sock"
+=09=09nbd_addr=3D"$SOCK_DIR/nbd.sock"
 =09fi
=20
-=09rm -f "$TEST_DIR/nbd.sock"
+=09rm -f "$SOCK_DIR/nbd.sock"
=20
         echo > "$TEST_DIR/nbd-fault-injector.out"
 =09$PYTHON nbd-fault-injector.py $extra_args "$nbd_addr" "$TEST_DIR/nbd-fa=
ult-injector.conf" >"$TEST_DIR/nbd-fault-injector.out" 2>&1 &
diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
index eee6dd1379..2090ee693c 100644
--- a/tests/qemu-iotests/083.out
+++ b/tests/qemu-iotests/083.out
@@ -110,43 +110,43 @@ read failed: Input/output error
=20
 =3D=3D=3D Check disconnect before neg1 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect after neg1 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 8 neg1 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 16 neg1 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect before export =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect after export =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 4 export =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 12 export =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 16 export =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect before neg2 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect after neg2 =3D=3D=3D
=20
@@ -154,11 +154,11 @@ read failed: Input/output error
=20
 =3D=3D=3D Check disconnect 8 neg2 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 10 neg2 =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///foo?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect before request =3D=3D=3D
=20
@@ -195,23 +195,23 @@ read 512/512 bytes at offset 0
=20
 =3D=3D=3D Check disconnect before neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 8 neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 16 neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 24 neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect 28 neg-classic =3D=3D=3D
=20
-qemu-io: can't open device nbd+unix:///?socket=3DTEST_DIR/nbd.sock
+qemu-io: can't open device nbd+unix:///?socket=3DSOCK_DIR/nbd.sock
=20
 =3D=3D=3D Check disconnect after neg-classic =3D=3D=3D
=20
--=20
2.21.0


