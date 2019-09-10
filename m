Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2A4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60092084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60092084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7fVa-0004a9-7F
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 08:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7fSv-0002Mn-U4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7fSv-00054r-1Q
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:41:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48734)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7fSt-00054C-3M; Tue, 10 Sep 2019 08:41:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 571EA7E424;
 Tue, 10 Sep 2019 12:41:46 +0000 (UTC)
Received: from localhost (ovpn-117-90.ams2.redhat.com [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A849B5D9DC;
 Tue, 10 Sep 2019 12:41:43 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 14:41:30 +0200
Message-Id: <20190910124136.10565-2-mreitz@redhat.com>
In-Reply-To: <20190910124136.10565-1-mreitz@redhat.com>
References: <20190910124136.10565-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 10 Sep 2019 12:41:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/7] curl: Keep pointer to the CURLState in
 CURLSocket
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A follow-up patch will make curl_multi_do() and curl_multi_read() take a
CURLSocket instead of the CURLState.  They still need the latter,
though, so add a pointer to it to the former.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/curl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index d4c8e94f3e..92dc2f630e 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -80,6 +80,7 @@ static CURLMcode __curl_multi_socket_action(CURLM *mult=
i_handle,
 #define CURL_BLOCK_OPT_TIMEOUT_DEFAULT 5
=20
 struct BDRVCURLState;
+struct CURLState;
=20
 static bool libcurl_initialized;
=20
@@ -97,6 +98,7 @@ typedef struct CURLAIOCB {
=20
 typedef struct CURLSocket {
     int fd;
+    struct CURLState *state;
     QLIST_ENTRY(CURLSocket) next;
 } CURLSocket;
=20
@@ -180,6 +182,7 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd,=
 int action,
     if (!socket) {
         socket =3D g_new0(CURLSocket, 1);
         socket->fd =3D fd;
+        socket->state =3D state;
         QLIST_INSERT_HEAD(&state->sockets, socket, next);
     }
     socket =3D NULL;
--=20
2.21.0


