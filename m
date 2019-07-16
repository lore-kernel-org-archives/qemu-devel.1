Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC38C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F3E20659
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F3E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnKNG-0007tL-Ft
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 06:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41110)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hnKN6-0007SM-T4
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hnKN4-0002Gs-W8
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:07:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50480)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hnKN1-0002Dx-QH; Tue, 16 Jul 2019 06:07:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9542B8667E;
 Tue, 16 Jul 2019 10:07:37 +0000 (UTC)
Received: from localhost (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46B2F60C44;
 Tue, 16 Jul 2019 10:07:33 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 14:07:31 +0400
Message-Id: <20190716100731.29843-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 16 Jul 2019 10:07:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] nbd: fix uninitialized variable warning
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
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

../block/nbd.c: In function 'nbd_co_request':
../block/nbd.c:745:8: error: 'local_reply.type' may be used uninitialized=
 in this function [-Werror=3Dmaybe-uninitialized]
     if (chunk->type =3D=3D NBD_REPLY_TYPE_NONE) {
        ^
../block/nbd.c:710:14: note: 'local_reply.type' was declared here
     NBDReply local_reply;
              ^~~~~~~~~~~
../block/nbd.c:710:14: error: 'local_reply.flags' may be used uninitializ=
ed in this function [-Werror=3Dmaybe-uninitialized]
../block/nbd.c:738:8: error: 'local_reply.<U4be0>.magic' may be used unin=
itialized in this function [-Werror=3Dmaybe-uninitialized]
     if (nbd_reply_is_simple(reply) || s->quit) {
        ^
../block/nbd.c:710:14: note: 'local_reply.<U4be0>.magic' was declared her=
e
     NBDReply local_reply;
              ^~~~~~~~~~~
cc1: all warnings being treated as errors

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nbd.c b/block/nbd.c
index 81edabbf35..0f74c1e455 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -707,7 +707,7 @@ static bool nbd_reply_chunk_iter_receive(BDRVNBDState=
 *s,
                                          void **payload)
 {
     int ret, request_ret;
-    NBDReply local_reply;
+    NBDReply local_reply =3D {};
     NBDStructuredReplyChunk *chunk;
     Error *local_err =3D NULL;
     if (s->quit) {
--=20
2.22.0.428.g6d5b264208


