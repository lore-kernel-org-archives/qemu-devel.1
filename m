Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50166CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C0920873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OweeTwfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C0920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53431 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4Wy-0006eK-1j
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3wH-00024w-Bb
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3wG-0001a3-2Q
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40192
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3wF-0001Zs-VG
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WUZxlFAlgm2HeSYNVOY/MIClvfbL18TqjsSWOMeUolA=;
 b=OweeTwfivDgjXR8SkhB/Svink2dJIBJdmdvzrKZvHwI5nur135ACFiALStKed1/8azqjl2
 pBWT4VQ4tlz7QU6AgH+MHGWrCQeql51DulgOciAJl1zYguMdWnNzZBbPWbJB7s4Z4BZ5Dc
 IHUyeFILDnE35N5r6cNvSofSLdr9qJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-l_Sj_xUqOoiyovzyAo_nGA-1; Mon, 28 Oct 2019 08:15:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74EAE476;
 Mon, 28 Oct 2019 12:15:55 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17EE660C4B;
 Mon, 28 Oct 2019 12:15:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 25/69] iotests/192: Create socket in $SOCK_DIR
Date: Mon, 28 Oct 2019 13:14:17 +0100
Message-Id: <20191028121501.15279-26-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: l_Sj_xUqOoiyovzyAo_nGA-1
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20191017133155.5327-14-mreitz@redhat.com
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/192     | 4 ++--
 tests/qemu-iotests/192.out | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index 034432272f..d2ba55dd90 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -31,7 +31,7 @@ _cleanup()
 {
     _cleanup_qemu
     _cleanup_test_img
-    rm -f "$TEST_DIR/nbd"
+    rm -f "$SOCK_DIR/nbd"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -66,7 +66,7 @@ else
     QEMU_COMM_TIMEOUT=3D1
 fi
=20
-_send_qemu_cmd $h "nbd_server_start unix:$TEST_DIR/nbd" "(qemu)"
+_send_qemu_cmd $h "nbd_server_start unix:$SOCK_DIR/nbd" "(qemu)"
 _send_qemu_cmd $h "nbd_server_add -w drive0" "(qemu)"
 _send_qemu_cmd $h "q" "(qemu)"
=20
diff --git a/tests/qemu-iotests/192.out b/tests/qemu-iotests/192.out
index 1e0be4c4d7..b9429dbe36 100644
--- a/tests/qemu-iotests/192.out
+++ b/tests/qemu-iotests/192.out
@@ -1,7 +1,7 @@
 QA output created by 192
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) nbd_server_start unix:TEST_DIR/nbd
+(qemu) nbd_server_start unix:SOCK_DIR/nbd
 (qemu) nbd_server_add -w drive0
 (qemu) q
 *** done
--=20
2.21.0


