Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7742CC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9CA2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9CA2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKlQ-0001c4-7f
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hyKXD-00030z-P6
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hyKXA-00020n-9T
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:31:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58812)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hyKX1-0001fx-I8; Thu, 15 Aug 2019 14:31:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 67CE930BC824;
 Thu, 15 Aug 2019 18:31:24 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA5F112A72;
 Thu, 15 Aug 2019 18:31:23 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 13:30:36 -0500
Message-Id: <20190815183039.4264-7-eblake@redhat.com>
In-Reply-To: <20190815183039.4264-1-eblake@redhat.com>
References: <20190815183039.4264-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 15 Aug 2019 18:31:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 6/9] block/nbd: use non-blocking io channel for
 nbd negotiation
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

No reason to use blocking channel for negotiation and we'll benefit in
further reconnect feature, as qio_channel reads and writes will do
qemu_coroutine_yield while waiting for io completion.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190618114328.55249-3-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h |  3 ++-
 block/nbd.c         | 16 +++++++---------
 nbd/client.c        | 16 +++++++++++-----
 qemu-nbd.c          |  2 +-
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index bb9f5bc0216f..7b36d672f046 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -304,7 +304,8 @@ struct NBDExportInfo {
 };
 typedef struct NBDExportInfo NBDExportInfo;

-int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
+int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
+                          QCryptoTLSCreds *tlscreds,
                           const char *hostname, QIOChannel **outioc,
                           NBDExportInfo *info, Error **errp);
 void nbd_free_export_list(NBDExportInfo *info, int count);
diff --git a/block/nbd.c b/block/nbd.c
index c16d02528b2f..3a243d9de96e 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1175,6 +1175,7 @@ static int nbd_client_connect(BlockDriverState *bs,
                               Error **errp)
 {
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
+    AioContext *aio_context =3D bdrv_get_aio_context(bs);
     int ret;

     /*
@@ -1189,15 +1190,16 @@ static int nbd_client_connect(BlockDriverState *b=
s,

     /* NBD handshake */
     trace_nbd_client_connect(export);
-    qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
+    qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
+    qio_channel_attach_aio_context(QIO_CHANNEL(sioc), aio_context);

     s->info.request_sizes =3D true;
     s->info.structured_reply =3D true;
     s->info.base_allocation =3D true;
     s->info.x_dirty_bitmap =3D g_strdup(x_dirty_bitmap);
     s->info.name =3D g_strdup(export ?: "");
-    ret =3D nbd_receive_negotiate(QIO_CHANNEL(sioc), tlscreds, hostname,
-                                &s->ioc, &s->info, errp);
+    ret =3D nbd_receive_negotiate(aio_context, QIO_CHANNEL(sioc), tlscre=
ds,
+                                hostname, &s->ioc, &s->info, errp);
     g_free(s->info.x_dirty_bitmap);
     g_free(s->info.name);
     if (ret < 0) {
@@ -1231,18 +1233,14 @@ static int nbd_client_connect(BlockDriverState *b=
s,
         object_ref(OBJECT(s->ioc));
     }

-    qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    qio_channel_attach_aio_context(s->ioc, bdrv_get_aio_context(bs));
-
     trace_nbd_client_connect_success(export);

     return 0;

  fail:
     /*
-     * We have connected, but must fail for other reasons. The
-     * connection is still blocking; send NBD_CMD_DISC as a courtesy
-     * to the server.
+     * We have connected, but must fail for other reasons.
+     * Send NBD_CMD_DISC as a courtesy to the server.
      */
     {
         NBDRequest request =3D { .type =3D NBD_CMD_DISC };
diff --git a/nbd/client.c b/nbd/client.c
index 4de30630c738..8f524c3e3502 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -867,7 +867,8 @@ static int nbd_list_meta_contexts(QIOChannel *ioc,
  *          2: server is newstyle, but lacks structured replies
  *          3: server is newstyle and set up for structured replies
  */
-static int nbd_start_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscred=
s,
+static int nbd_start_negotiate(AioContext *aio_context, QIOChannel *ioc,
+                               QCryptoTLSCreds *tlscreds,
                                const char *hostname, QIOChannel **outioc=
,
                                bool structured_reply, bool *zeroes,
                                Error **errp)
@@ -934,6 +935,10 @@ static int nbd_start_negotiate(QIOChannel *ioc, QCry=
ptoTLSCreds *tlscreds,
                     return -EINVAL;
                 }
                 ioc =3D *outioc;
+                if (aio_context) {
+                    qio_channel_set_blocking(ioc, false, NULL);
+                    qio_channel_attach_aio_context(ioc, aio_context);
+                }
             } else {
                 error_setg(errp, "Server does not support STARTTLS");
                 return -EINVAL;
@@ -998,7 +1003,8 @@ static int nbd_negotiate_finish_oldstyle(QIOChannel =
*ioc, NBDExportInfo *info,
  * Returns: negative errno: failure talking to server
  *          0: server is connected
  */
-int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
+int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
+                          QCryptoTLSCreds *tlscreds,
                           const char *hostname, QIOChannel **outioc,
                           NBDExportInfo *info, Error **errp)
 {
@@ -1009,7 +1015,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoT=
LSCreds *tlscreds,
     assert(info->name);
     trace_nbd_receive_negotiate_name(info->name);

-    result =3D nbd_start_negotiate(ioc, tlscreds, hostname, outioc,
+    result =3D nbd_start_negotiate(aio_context, ioc, tlscreds, hostname,=
 outioc,
                                  info->structured_reply, &zeroes, errp);

     info->structured_reply =3D false;
@@ -1129,8 +1135,8 @@ int nbd_receive_export_list(QIOChannel *ioc, QCrypt=
oTLSCreds *tlscreds,
     QIOChannel *sioc =3D NULL;

     *info =3D NULL;
-    result =3D nbd_start_negotiate(ioc, tlscreds, hostname, &sioc, true,=
 NULL,
-                                 errp);
+    result =3D nbd_start_negotiate(NULL, ioc, tlscreds, hostname, &sioc,=
 true,
+                                 NULL, errp);
     if (tlscreds && sioc) {
         ioc =3D sioc;
     }
diff --git a/qemu-nbd.c b/qemu-nbd.c
index a8cb39e51043..049645491dab 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -362,7 +362,7 @@ static void *nbd_client_thread(void *arg)
         goto out;
     }

-    ret =3D nbd_receive_negotiate(QIO_CHANNEL(sioc),
+    ret =3D nbd_receive_negotiate(NULL, QIO_CHANNEL(sioc),
                                 NULL, NULL, NULL, &info, &local_error);
     if (ret < 0) {
         if (local_error) {
--=20
2.20.1


