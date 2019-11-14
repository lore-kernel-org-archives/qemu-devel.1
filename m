Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D23C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA5D20709
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHZKhd0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA5D20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVMp7-0007Ed-LS
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 16:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iVMkz-0002Vf-1x
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:34:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iVMkx-0004Mu-S9
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:34:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iVMkx-0004Mm-PB
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573767263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pULa/xs6+FCOf9U0sNxrjD7lju2T+ptwptlYWCXWeGo=;
 b=BHZKhd0qo6lboe3ZGTKVAH28fsQBcJIz6bre/FLh8PoZcRcMLtwKC701L0ZZc1klTwQRRQ
 DwaAzV3uIG4q6WAzi15ehecwTGrCeRh2vVUZNBhDIFJCnjNP2fd/VinWbgmVhxYVEYmYSy
 xl+Aj8reWJLUeSY5Mc5cw1/Z7hsm3HM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-WCI62-22NzSl9EKx9xZsBg-1; Thu, 14 Nov 2019 16:34:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE7F064A7D;
 Thu, 14 Nov 2019 21:34:18 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-242.phx2.redhat.com [10.3.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B2126609E;
 Thu, 14 Nov 2019 21:34:18 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] iotests: Switch nbd tests to use Unix rather than TCP
Date: Thu, 14 Nov 2019 15:34:13 -0600
Message-Id: <20191114213415.23499-3-eblake@redhat.com>
In-Reply-To: <20191114213415.23499-1-eblake@redhat.com>
References: <20191114213415.23499-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: WCI62-22NzSl9EKx9xZsBg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Up to now, all it took to cause a lot of iotest failures was to have a
background process such as 'nbdkit -p 10810 null' running, because we
hard-coded the TCP port.  Switching to a Unix socket eliminates this
contention.  We still have TCP coverage in test 233, and that test is
more careful to not pick a hard-coded port.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/common.filter | 6 ++++--
 tests/qemu-iotests/common.rc     | 8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.f=
ilter
index f870e00e4421..5367deea398e 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -127,7 +127,8 @@ _filter_img_create()
         -e "s#$TEST_DIR#TEST_DIR#g" \
         -e "s#$SOCK_DIR#SOCK_DIR#g" \
         -e "s#$IMGFMT#IMGFMT#g" \
-        -e 's#nbd:127.0.0.1:10810#TEST_DIR/t.IMGFMT#g' \
+        -e 's#nbd:127.0.0.1:[0-9]\\+#TEST_DIR/t.IMGFMT#g' \
+        -e 's#nbd+unix:///\??socket=3DSOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g' \
         -e "s# encryption=3Doff##g" \
         -e "s# cluster_size=3D[0-9]\\+##g" \
         -e "s# table_size=3D[0-9]\\+##g" \
@@ -164,7 +165,8 @@ _filter_img_info()
         -e "s#$TEST_DIR#TEST_DIR#g" \
         -e "s#$SOCK_DIR#SOCK_DIR#g" \
         -e "s#$IMGFMT#IMGFMT#g" \
-        -e 's#nbd://127.0.0.1:10810$#TEST_DIR/t.IMGFMT#g' \
+        -e 's#nbd://127.0.0.1:[0-9]\\+$#TEST_DIR/t.IMGFMT#g' \
+        -e 's#nbd+unix:///\??socket=3DSOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g' \
         -e 's#json.*vdisk-id.*vxhs"}}#TEST_DIR/t.IMGFMT#' \
         -e "/encrypted: yes/d" \
         -e "/cluster_size: [0-9]\\+/d" \
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index fa7bae24226a..f772dcb67322 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -217,7 +217,7 @@ if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
         TEST_IMG=3D"$DRIVER,file.filename=3D$TEST_DIR/t.$IMGFMT"
     elif [ "$IMGPROTO" =3D "nbd" ]; then
         TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
-        TEST_IMG=3D"$DRIVER,file.driver=3Dnbd,file.host=3D127.0.0.1,file.p=
ort=3D10810"
+        TEST_IMG=3D"$DRIVER,file.driver=3Dnbd,file.type=3Dunix,file.path=
=3D$SOCKDIR/$IMGFMT"
     elif [ "$IMGPROTO" =3D "ssh" ]; then
         TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
         TEST_IMG=3D"$DRIVER,file.driver=3Dssh,file.host=3D127.0.0.1,file.p=
ath=3D$TEST_IMG_FILE"
@@ -233,7 +233,7 @@ else
         TEST_IMG=3D$TEST_DIR/t.$IMGFMT
     elif [ "$IMGPROTO" =3D "nbd" ]; then
         TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
-        TEST_IMG=3D"nbd:127.0.0.1:10810"
+        TEST_IMG=3D"nbd+unix:///?socket=3D$SOCK_DIR/nbd"
     elif [ "$IMGPROTO" =3D "ssh" ]; then
         TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
         REMOTE_TEST_DIR=3D"ssh://\\($USER@\\)\\?127.0.0.1\\(:[0-9]\\+\\)\\=
?$TEST_DIR"
@@ -293,7 +293,7 @@ _stop_nbd_server()
         local QEMU_NBD_PID
         read QEMU_NBD_PID < "${QEMU_TEST_DIR}/qemu-nbd.pid"
         kill ${QEMU_NBD_PID}
-        rm -f "${QEMU_TEST_DIR}/qemu-nbd.pid"
+        rm -f "${QEMU_TEST_DIR}/qemu-nbd.pid" "$SOCK_DIR/nbd"
     fi
 }

@@ -353,7 +353,7 @@ _make_test_img()
     if [ $IMGPROTO =3D "nbd" ]; then
         # Pass a sufficiently high number to -e that should be enough for =
all
         # tests
-        eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT -e 42 -x ''=
 $TEST_IMG_FILE >/dev/null &"
+        eval "$QEMU_NBD -v -t -k '$SOCK_DIR/nbd' -f $IMGFMT -e 42 -x '' $T=
EST_IMG_FILE >/dev/null &"
         sleep 1 # FIXME: qemu-nbd needs to be listening before we continue
     fi

--=20
2.21.0


