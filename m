Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E78C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1519205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1519205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58936 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNgAC-00058g-WA
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 12:08:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hNg7a-0003JR-SO
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hNg7Z-0002qk-NU
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:05:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hNg7S-0002eT-Tl; Mon, 06 May 2019 12:05:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A11F987633;
	Mon,  6 May 2019 16:05:31 +0000 (UTC)
Received: from localhost (ovpn-204-185.brq.redhat.com [10.40.204.185])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 336147C43D;
	Mon,  6 May 2019 16:05:31 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  6 May 2019 18:05:29 +0200
Message-Id: <20190506160529.6955-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 06 May 2019 16:05:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] iotests: Fix 233 for ports other than 10809
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

233 generally filters the port, but in two cases does not.  If some
other concurrently running application has already taken port 10809,
this will result in an output mismatch.  Fix this by applying the
filter in these two cases, too.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/233     | 6 ++++--
 tests/qemu-iotests/233.out | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
index b8b6c8cc4c..41b4d46560 100755
--- a/tests/qemu-iotests/233
+++ b/tests/qemu-iotests/233
@@ -139,11 +139,13 @@ nbd_server_start_tcp_socket \
=20
 $QEMU_IMG info --image-opts \
     --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,i=
d=3Dtls0 \
-    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0
+    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0 \
+    2>&1 | sed "s/$nbd_tcp_port/PORT/g"
=20
 $QEMU_IMG info --image-opts \
     --object tls-creds-x509,dir=3D${tls_dir}/client3,endpoint=3Dclient,i=
d=3Dtls0 \
-    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0
+    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0 \
+    2>&1 | sed "s/$nbd_tcp_port/PORT/g"
=20
 echo
 echo "=3D=3D final server log =3D=3D"
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 4edc2dd5cf..9b46284ab0 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -57,8 +57,8 @@ read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 =3D=3D check TLS with authorization =3D=3D
-qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3D10809,tls=
-creds=3Dtls0': Failed to read option reply: Cannot read from TLS channel=
: Software caused connection abort
-qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3D10809,tls=
-creds=3Dtls0': Failed to read option reply: Cannot read from TLS channel=
: Software caused connection abort
+qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-=
creds=3Dtls0': Failed to read option reply: Cannot read from TLS channel:=
 Software caused connection abort
+qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-=
creds=3Dtls0': Failed to read option reply: Cannot read from TLS channel:=
 Software caused connection abort
=20
 =3D=3D final server log =3D=3D
 qemu-nbd: option negotiation failed: Verify failed: No certificate was f=
ound.
--=20
2.20.1


