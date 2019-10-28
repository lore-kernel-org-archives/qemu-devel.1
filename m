Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4A3CA9EC1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:43:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62CC21721
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IT+PTfjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62CC21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4NE-0003dE-DV
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3wV-0002IX-KK
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3wU-0001iS-8S
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22212
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3wU-0001ha-3S
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nzYfsrvbFcvTUAC4fmCCmaulR3gKaiRr0GcI/WZnGqs=;
 b=IT+PTfjH0+vOP5bOV2x406QYCDWdWsdJYgbxhdFSKiRxLcWIWnB9/DMOY3m8RcvtvthxlD
 h4ecgDS5piMksI5Tk3aVPccp1k31BBdlQ8CKCKnE0FwZjpoSaqcEVTiYRgiCjKl7BQDkAD
 31g51KGeBpXZat4BxP4sWXff4nyPxBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-xz8P0AQ2PDusQ9eD_d9U9g-1; Mon, 28 Oct 2019 08:16:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2649180496E;
 Mon, 28 Oct 2019 12:16:09 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4774A60850;
 Mon, 28 Oct 2019 12:16:09 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 32/69] iotests/223: Create socket in $SOCK_DIR
Date: Mon, 28 Oct 2019 13:14:24 +0100
Message-Id: <20191028121501.15279-33-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: xz8P0AQ2PDusQ9eD_d9U9g-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20191017133155.5327-21-mreitz@redhat.com
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/223 | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 2ba3d8124b..b5a80e50bb 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -28,7 +28,7 @@ _cleanup()
     nbd_server_stop
     _cleanup_test_img
     _cleanup_qemu
-    rm -f "$TEST_DIR/nbd"
+    rm -f "$SOCK_DIR/nbd"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -125,11 +125,11 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-a=
dd",
   "arguments":{"device":"n"}}' "error" # Attempt add without server
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
   "arguments":{"addr":{"type":"unix",
-    "data":{"path":"'"$TEST_DIR/nbd"'"}}}}' "return"
+    "data":{"path":"'"$SOCK_DIR/nbd"'"}}}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
   "arguments":{"addr":{"type":"unix",
-    "data":{"path":"'"$TEST_DIR/nbd"1'"}}}}' "error" # Attempt second serv=
er
-$QEMU_NBD_PROG -L -k "$TEST_DIR/nbd"
+    "data":{"path":"'"$SOCK_DIR/nbd"1'"}}}}' "error" # Attempt second serv=
er
+$QEMU_NBD_PROG -L -k "$SOCK_DIR/nbd"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n", "bitmap":"b"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
@@ -145,14 +145,14 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-a=
dd",
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n", "name":"n2", "writable":true,
   "bitmap":"b2"}}' "return"
-$QEMU_NBD_PROG -L -k "$TEST_DIR/nbd"
+$QEMU_NBD_PROG -L -k "$SOCK_DIR/nbd"
=20
 echo
 echo "=3D=3D=3D Contrast normal status to large granularity dirty-bitmap =
=3D=3D=3D"
 echo
=20
 QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
-IMG=3D"driver=3Dnbd,export=3Dn,server.type=3Dunix,server.path=3D$TEST_DIR/=
nbd"
+IMG=3D"driver=3Dnbd,export=3Dn,server.type=3Dunix,server.path=3D$SOCK_DIR/=
nbd"
 $QEMU_IO -r -c 'r -P 0x22 512 512' -c 'r -P 0 512k 512k' -c 'r -P 0x11 1m =
1m' \
   -c 'r -P 0x33 2m 2m' --image-opts "$IMG" | _filter_qemu_io
 $QEMU_IMG map --output=3Djson --image-opts \
@@ -164,7 +164,7 @@ echo
 echo "=3D=3D=3D Contrast to small granularity dirty-bitmap =3D=3D=3D"
 echo
=20
-IMG=3D"driver=3Dnbd,export=3Dn2,server.type=3Dunix,server.path=3D$TEST_DIR=
/nbd"
+IMG=3D"driver=3Dnbd,export=3Dn2,server.type=3Dunix,server.path=3D$SOCK_DIR=
/nbd"
 $QEMU_IMG map --output=3Djson --image-opts \
   "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:b2" | _filter_qemu_img_map
=20
--=20
2.21.0


