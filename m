Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96786C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2582053B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2582053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sjI-0006k5-NI
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i9ruX-0003NM-PT
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i9ruW-0000q1-42
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:23:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i9ruT-0000oj-2b; Mon, 16 Sep 2019 10:23:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 29DA918C427A;
 Mon, 16 Sep 2019 14:23:20 +0000 (UTC)
Received: from localhost (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9876B600C1;
 Mon, 16 Sep 2019 14:23:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 16 Sep 2019 16:22:40 +0200
Message-Id: <20190916142246.31474-11-mreitz@redhat.com>
In-Reply-To: <20190916142246.31474-1-mreitz@redhat.com>
References: <20190916142246.31474-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Mon, 16 Sep 2019 14:23:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/16] curl: Report only ready sockets
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

Instead of reporting all sockets to cURL, only report the one that has
caused curl_multi_do_locked() to be called.  This lets us get rid of the
QLIST_FOREACH_SAFE() list, which was actually wrong: SAFE foreaches are
only safe when the current element is removed in each iteration.  If it
possible for the list to be concurrently modified, we cannot guarantee
that only the current element will be removed.  Therefore, we must not
use QLIST_FOREACH_SAFE() here.

Fixes: ff5ca1664af85b24a4180d595ea6873fd3deac57
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190910124136.10565-6-mreitz@redhat.com
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/curl.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index cf2686218d..fd70f1ebc4 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -392,24 +392,19 @@ static void curl_multi_check_completion(BDRVCURLSta=
te *s)
 }
=20
 /* Called with s->mutex held.  */
-static void curl_multi_do_locked(CURLSocket *ready_socket)
+static void curl_multi_do_locked(CURLSocket *socket)
 {
-    CURLSocket *socket, *next_socket;
-    CURLState *s =3D ready_socket->state;
+    BDRVCURLState *s =3D socket->state->s;
     int running;
     int r;
=20
-    if (!s->s->multi) {
+    if (!s->multi) {
         return;
     }
=20
-    /* Need to use _SAFE because curl_multi_socket_action() may trigger
-     * curl_sock_cb() which might modify this list */
-    QLIST_FOREACH_SAFE(socket, &s->sockets, next, next_socket) {
-        do {
-            r =3D curl_multi_socket_action(s->s->multi, socket->fd, 0, &=
running);
-        } while (r =3D=3D CURLM_CALL_MULTI_PERFORM);
-    }
+    do {
+        r =3D curl_multi_socket_action(s->multi, socket->fd, 0, &running=
);
+    } while (r =3D=3D CURLM_CALL_MULTI_PERFORM);
 }
=20
 static void curl_multi_do(void *arg)
--=20
2.21.0


