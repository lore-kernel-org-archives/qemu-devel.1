Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE785C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 21:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D348A206CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 21:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D348A206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5z8N-0003SC-Ce
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 17:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5z6c-0001oc-SG
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 17:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5z6b-0002Fz-4y
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 17:15:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60066)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i5z6X-0002CY-69; Thu, 05 Sep 2019 17:15:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8413A305B41E;
 Thu,  5 Sep 2019 21:15:44 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12D3960619;
 Thu,  5 Sep 2019 21:15:44 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  5 Sep 2019 16:15:16 -0500
Message-Id: <20190905211522.2824-4-eblake@redhat.com>
In-Reply-To: <20190905211522.2824-1-eblake@redhat.com>
References: <20190905211522.2824-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 05 Sep 2019 21:15:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 3/9] nbd: Tolerate more errors to structured
 reply request
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A server may have a reason to reject a request for structured replies,
beyond just not recognizing them as a valid request; similarly, it may
have a reason for rejecting a request for a meta context.  It doesn't
hurt us to continue talking to such a server; otherwise 'qemu-nbd
--list' of such a server fails to display all available details about
the export.

Encountered when temporarily tweaking nbdkit to reply with
NBD_REP_ERR_POLICY.  Present since structured reply support was first
added (commit d795299b reused starttls handling, but starttls is
different in that we can't fall back to other behavior on any error).

Note that for an unencrypted client trying to connect to a server that
requires encryption, this defers the point of failure to when we
finally execute a strict command (such as NBD_OPT_GO or NBD_OPT_LIST),
now that the intermediate NBD_OPT_STRUCTURED_REPLY does not diagnose
NBD_REP_ERR_TLS_REQD as fatal; but as the protocol eventually gets us
to a command where we can't continue onwards, the changed error
message doesn't cause any security concerns.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190824172813.29720-3-eblake@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
[eblake: fix iotest 233]
---
 nbd/client.c               | 63 ++++++++++++++++++++------------------
 nbd/trace-events           |  2 +-
 tests/qemu-iotests/233.out |  8 ++---
 3 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index a9d8d32feff7..b9dc829175f9 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2018 Red Hat, Inc.
+ *  Copyright (C) 2016-2019 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device Client Side
@@ -142,17 +142,18 @@ static int nbd_receive_option_reply(QIOChannel *ioc=
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
-    char *msg =3D NULL;
-    int result =3D -1;
+    g_autofree char *msg =3D NULL;

     if (!(reply->type & (1 << 31))) {
         return 1;
@@ -163,26 +164,28 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NB=
DOptionReply *reply,
             error_setg(errp, "server error %" PRIu32
                        " (%s) message is too long",
                        reply->type, nbd_rep_lookup(reply->type));
-            goto cleanup;
+            goto err;
         }
         msg =3D g_malloc(reply->length + 1);
         if (nbd_read(ioc, msg, reply->length, NULL, errp) < 0) {
             error_prepend(errp, "Failed to read option error %" PRIu32
                           " (%s) message: ",
                           reply->type, nbd_rep_lookup(reply->type));
-            goto cleanup;
+            goto err;
         }
         msg[reply->length] =3D '\0';
         trace_nbd_server_error_msg(reply->type,
                                    nbd_reply_type_lookup(reply->type), m=
sg);
     }

+    if (reply->type =3D=3D NBD_REP_ERR_UNSUP || !strict) {
+        trace_nbd_reply_err_ignored(reply->option,
+                                    nbd_opt_lookup(reply->option),
+                                    reply->type, nbd_rep_lookup(reply->t=
ype));
+        return 0;
+    }
+
     switch (reply->type) {
-    case NBD_REP_ERR_UNSUP:
-        trace_nbd_reply_err_unsup(reply->option, nbd_opt_lookup(reply->o=
ption));
-        result =3D 0;
-        goto cleanup;
-
     case NBD_REP_ERR_POLICY:
         error_setg(errp, "Denied by server for option %" PRIu32 " (%s)",
                    reply->option, nbd_opt_lookup(reply->option));
@@ -227,12 +230,9 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBD=
OptionReply *reply,
         error_append_hint(errp, "server reported: %s\n", msg);
     }

- cleanup:
-    g_free(msg);
-    if (result < 0) {
-        nbd_send_opt_abort(ioc);
-    }
-    return result;
+ err:
+    nbd_send_opt_abort(ioc);
+    return -1;
 }

 /* nbd_receive_list:
@@ -257,7 +257,7 @@ static int nbd_receive_list(QIOChannel *ioc, char **n=
ame, char **description,
     if (nbd_receive_option_reply(ioc, NBD_OPT_LIST, &reply, errp) < 0) {
         return -1;
     }
-    error =3D nbd_handle_reply_err(ioc, &reply, errp);
+    error =3D nbd_handle_reply_err(ioc, &reply, true, errp);
     if (error <=3D 0) {
         return error;
     }
@@ -363,7 +363,7 @@ static int nbd_opt_info_or_go(QIOChannel *ioc, uint32=
_t opt,
         if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
             return -1;
         }
-        error =3D nbd_handle_reply_err(ioc, &reply, errp);
+        error =3D nbd_handle_reply_err(ioc, &reply, true, errp);
         if (error <=3D 0) {
             return error;
         }
@@ -538,12 +538,15 @@ static int nbd_receive_query_exports(QIOChannel *io=
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
@@ -555,7 +558,7 @@ static int nbd_request_simple_option(QIOChannel *ioc,=
 int opt, Error **errp)
     if (nbd_receive_option_reply(ioc, opt, &reply, errp) < 0) {
         return -1;
     }
-    error =3D nbd_handle_reply_err(ioc, &reply, errp);
+    error =3D nbd_handle_reply_err(ioc, &reply, strict, errp);
     if (error <=3D 0) {
         return error;
     }
@@ -587,7 +590,7 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *i=
oc,
     QIOChannelTLS *tioc;
     struct NBDTLSHandshakeData data =3D { 0 };

-    ret =3D nbd_request_simple_option(ioc, NBD_OPT_STARTTLS, errp);
+    ret =3D nbd_request_simple_option(ioc, NBD_OPT_STARTTLS, true, errp)=
;
     if (ret <=3D 0) {
         if (ret =3D=3D 0) {
             error_setg(errp, "Server don't support STARTTLS option");
@@ -687,7 +690,7 @@ static int nbd_receive_one_meta_context(QIOChannel *i=
oc,
         return -1;
     }

-    ret =3D nbd_handle_reply_err(ioc, &reply, errp);
+    ret =3D nbd_handle_reply_err(ioc, &reply, false, errp);
     if (ret <=3D 0) {
         return ret;
     }
@@ -943,7 +946,7 @@ static int nbd_start_negotiate(AioContext *aio_contex=
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
diff --git a/nbd/trace-events b/nbd/trace-events
index 7ab6b3788cb2..f6cde967903a 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -4,7 +4,7 @@
 nbd_send_option_request(uint32_t opt, const char *name, uint32_t len) "S=
ending option request %" PRIu32" (%s), len %" PRIu32
 nbd_receive_option_reply(uint32_t option, const char *optname, uint32_t =
type, const char *typename, uint32_t length) "Received option reply %" PR=
Iu32" (%s), type %" PRIu32" (%s), len %" PRIu32
 nbd_server_error_msg(uint32_t err, const char *type, const char *msg) "s=
erver reported error 0x%" PRIx32 " (%s) with additional message: %s"
-nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't u=
nderstand request %" PRIu32 " (%s), attempting fallback"
+nbd_reply_err_ignored(uint32_t option, const char *name, uint32_t reply,=
 const char *reply_name) "server failed request %" PRIu32 " (%s) with err=
or 0x%" PRIx32 " (%s), attempting fallback"
 nbd_receive_list(const char *name, const char *desc) "export list includ=
es '%s', description '%s'"
 nbd_opt_info_go_start(const char *opt, const char *name) "Attempting %s =
for export '%s'"
 nbd_opt_info_go_success(const char *opt) "Export is ready after %s reque=
st"
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 9b46284ab0de..a3ecc4eb5ccf 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -20,10 +20,10 @@ qemu-nbd: Denied by server for option 5 (starttls)
 server reported: TLS not configured

 =3D=3D check plain client to TLS server fails =3D=3D
-qemu-img: Could not open 'nbd://localhost:PORT': TLS negotiation require=
d before option 8 (structured reply)
-server reported: Option 0x8 not permitted before TLS
-qemu-nbd: TLS negotiation required before option 8 (structured reply)
-server reported: Option 0x8 not permitted before TLS
+qemu-img: Could not open 'nbd://localhost:PORT': TLS negotiation require=
d before option 7 (go)
+server reported: Option 0x7 not permitted before TLS
+qemu-nbd: TLS negotiation required before option 3 (list)
+server reported: Option 0x3 not permitted before TLS

 =3D=3D check TLS works =3D=3D
 image: nbd://127.0.0.1:PORT
--=20
2.21.0


