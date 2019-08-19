Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573B6C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 17:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF1C22CEB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 17:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF1C22CEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzlvY-00065m-8U
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 13:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hzluq-0005Z2-VX
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 13:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hzlup-00076l-MF
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 13:58:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45162)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hzlum-00075d-Lu; Mon, 19 Aug 2019 13:57:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1EB273081D8F;
 Mon, 19 Aug 2019 17:57:55 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-3.phx2.redhat.com [10.3.117.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9B585C1D6;
 Mon, 19 Aug 2019 17:57:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 12:57:51 -0500
Message-Id: <20190819175751.18075-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 19 Aug 2019 17:57:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] nbd: Tolerate more errors to structured reply
 request
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
Cc: vsementsov@virtuozzo.com, rjones@redhat.com,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A server may have a reason to reject a request for structured replies,
beyond just not recognizing them as a valid request.  It doesn't hurt
us to continue talking to such a server; otherwise 'qemu-nbd --list'
of such a server fails to display all possible details about the
export.

Encountered when temporarily tweaking nbdkit to reply with
NBD_REP_ERR_POLICY.  Present since structured reply support was first
added (commit d795299b reused starttls handling, but starttls has to
reject all errors).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/client.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 8f524c3e3502..204f6e928d14 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2018 Red Hat, Inc.
+ *  Copyright (C) 2016-2019 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device Client Side
@@ -141,17 +141,19 @@ static int nbd_receive_option_reply(QIOChannel *ioc=
, uint32_t opt,
     return 0;
 }

-/* If reply represents success, return 1 without further action.
- * If reply represents an error, consume the optional payload of
- * the packet on ioc.  Then return 0 for unsupported (so the client
- * can fall back to other approaches), or -1 with errp set for other
- * errors.
+/*
+ * If reply represents success, return 1 without further action.  If
+ * reply represents an error, consume the optional payload of the
+ * packet on ioc.  Then return 0 for unsupported (so the client can
+ * fall back to other approaches), where @strict determines if only
+ * ERR_UNSUP or all errors fit that category, or -1 with errp set for
+ * other errors.
  */
 static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
-                                Error **errp)
+                                bool strict, Error **errp)
 {
     char *msg =3D NULL;
-    int result =3D -1;
+    int result =3D strict ? -1 : 0;

     if (!(reply->type & (1 << 31))) {
         return 1;
@@ -162,6 +164,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBDO=
ptionReply *reply,
             error_setg(errp, "server error %" PRIu32
                        " (%s) message is too long",
                        reply->type, nbd_rep_lookup(reply->type));
+            result =3D -1;
             goto cleanup;
         }
         msg =3D g_malloc(reply->length + 1);
@@ -169,6 +172,7 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBDO=
ptionReply *reply,
             error_prepend(errp, "Failed to read option error %" PRIu32
                           " (%s) message: ",
                           reply->type, nbd_rep_lookup(reply->type));
+            result =3D -1;
             goto cleanup;
         }
         msg[reply->length] =3D '\0';
@@ -257,7 +261,7 @@ static int nbd_receive_list(QIOChannel *ioc, char **n=
ame, char **description,
     if (nbd_receive_option_reply(ioc, NBD_OPT_LIST, &reply, errp) < 0) {
         return -1;
     }
-    error =3D nbd_handle_reply_err(ioc, &reply, errp);
+    error =3D nbd_handle_reply_err(ioc, &reply, true, errp);
     if (error <=3D 0) {
         return error;
     }
@@ -370,7 +374,7 @@ static int nbd_opt_info_or_go(QIOChannel *ioc, uint32=
_t opt,
         if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
             return -1;
         }
-        error =3D nbd_handle_reply_err(ioc, &reply, errp);
+        error =3D nbd_handle_reply_err(ioc, &reply, true, errp);
         if (error <=3D 0) {
             return error;
         }
@@ -545,12 +549,15 @@ static int nbd_receive_query_exports(QIOChannel *io=
c,
     }
 }

-/* nbd_request_simple_option: Send an option request, and parse the repl=
y
+/*
+ * nbd_request_simple_option: Send an option request, and parse the repl=
y.
+ * @strict controls whether ERR_UNSUP or all errors produce 0 status.
  * return 1 for successful negotiation,
  *        0 if operation is unsupported,
  *        -1 with errp set for any other error
  */
-static int nbd_request_simple_option(QIOChannel *ioc, int opt, Error **e=
rrp)
+static int nbd_request_simple_option(QIOChannel *ioc, int opt, bool stri=
ct,
+                                     Error **errp)
 {
     NBDOptionReply reply;
     int error;
@@ -562,7 +569,7 @@ static int nbd_request_simple_option(QIOChannel *ioc,=
 int opt, Error **errp)
     if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
         return -1;
     }
-    error =3D nbd_handle_reply_err(ioc, &reply, errp);
+    error =3D nbd_handle_reply_err(ioc, &reply, strict, errp);
     if (error <=3D 0) {
         return error;
     }
@@ -594,7 +601,7 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *i=
oc,
     QIOChannelTLS *tioc;
     struct NBDTLSHandshakeData data =3D { 0 };

-    ret =3D nbd_request_simple_option(ioc, NBD_OPT_STARTTLS, errp);
+    ret =3D nbd_request_simple_option(ioc, NBD_OPT_STARTTLS, true, errp)=
;
     if (ret <=3D 0) {
         if (ret =3D=3D 0) {
             error_setg(errp, "Server don't support STARTTLS option");
@@ -694,7 +701,7 @@ static int nbd_receive_one_meta_context(QIOChannel *i=
oc,
         return -1;
     }

-    ret =3D nbd_handle_reply_err(ioc, &reply, errp);
+    ret =3D nbd_handle_reply_err(ioc, &reply, true, errp);
     if (ret <=3D 0) {
         return ret;
     }
@@ -950,7 +957,7 @@ static int nbd_start_negotiate(AioContext *aio_contex=
t, QIOChannel *ioc,
             if (structured_reply) {
                 result =3D nbd_request_simple_option(ioc,
                                                    NBD_OPT_STRUCTURED_RE=
PLY,
-                                                   errp);
+                                                   false, errp);
                 if (result < 0) {
                     return -EINVAL;
                 }
--=20
2.20.1


