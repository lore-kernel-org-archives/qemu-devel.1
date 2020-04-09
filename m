Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BBFC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1A020753
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2E6bZcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1A020753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMZFB-00030s-05
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 11:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jMZ8k-000170-34
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jMZ8i-0003fX-IP
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28881
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jMZ8i-0003ev-DV
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586446248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fcSuBaAbHjMGVuJ6BNqgEJ7D9xgolLjUFkT2uLU/lQE=;
 b=f2E6bZcqmn4BgBmfphWfba5bWxjv+ZUVK/qaxiEAsWkyekZElQw3H7NGwCf6CDyYVoFf89
 s6pIKaldV6T6GxEtjcErU/2C6yxrN1gyxK/Wg0Gsgs42chIrDC58gS6Is+NvSee0FnCWdr
 /diPx/lPAx54J9/MX7sXOjmr+Xjdc4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-u6545Eh2PkWG10piBksIqA-1; Thu, 09 Apr 2020 11:30:44 -0400
X-MC-Unique: u6545Eh2PkWG10piBksIqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFA7D800D5B;
 Thu,  9 Apr 2020 15:30:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB9381195A4;
 Thu,  9 Apr 2020 15:30:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4068311358B1; Thu,  9 Apr 2020 17:30:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 4/8] qemu-option: Avoid has_help_option() in
 qemu_opts_parse_noisily()
Date: Thu,  9 Apr 2020 17:30:37 +0200
Message-Id: <20200409153041.17576-5-armbru@redhat.com>
In-Reply-To: <20200409153041.17576-1-armbru@redhat.com>
References: <20200409153041.17576-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When opts_parse() sets @invalidp to true, qemu_opts_parse_noisily()
uses has_help_option() to decide whether to print help.  This parses
the input string a second time, in a slightly different way.

Easy to avoid: replace @invalidp by @help_wanted.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/qemu-option.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index d2956082bd..6403e521fc 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -539,7 +539,7 @@ int qemu_opt_unset(QemuOpts *opts, const char *name)
 }
=20
 static void opt_set(QemuOpts *opts, const char *name, char *value,
-                    bool prepend, bool *invalidp, Error **errp)
+                    bool prepend, bool *help_wanted, Error **errp)
 {
     QemuOpt *opt;
     const QemuOptDesc *desc;
@@ -549,8 +549,8 @@ static void opt_set(QemuOpts *opts, const char *name, c=
har *value,
     if (!desc && !opts_accepts_any(opts)) {
         g_free(value);
         error_setg(errp, QERR_INVALID_PARAMETER, name);
-        if (invalidp) {
-            *invalidp =3D true;
+        if (help_wanted && is_help_option(name)) {
+            *help_wanted =3D true;
         }
         return;
     }
@@ -847,7 +847,7 @@ static const char *get_opt_name_value(const char *param=
s,
=20
 static void opts_do_parse(QemuOpts *opts, const char *params,
                           const char *firstname, bool prepend,
-                          bool *invalidp, Error **errp)
+                          bool *help_wanted, Error **errp)
 {
     Error *local_err =3D NULL;
     char *option, *value;
@@ -863,7 +863,7 @@ static void opts_do_parse(QemuOpts *opts, const char *p=
arams,
             continue;
         }
=20
-        opt_set(opts, option, value, prepend, invalidp, &local_err);
+        opt_set(opts, option, value, prepend, help_wanted, &local_err);
         g_free(option);
         if (local_err) {
             error_propagate(errp, local_err);
@@ -904,7 +904,7 @@ void qemu_opts_do_parse(QemuOpts *opts, const char *par=
ams,
=20
 static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
                             bool permit_abbrev, bool defaults,
-                            bool *invalidp, Error **errp)
+                            bool *help_wanted, Error **errp)
 {
     const char *firstname;
     char *id =3D opts_parse_id(params);
@@ -929,7 +929,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const c=
har *params,
         return NULL;
     }
=20
-    opts_do_parse(opts, params, firstname, defaults, invalidp, &local_err)=
;
+    opts_do_parse(opts, params, firstname, defaults, help_wanted, &local_e=
rr);
     if (local_err) {
         error_propagate(errp, local_err);
         qemu_opts_del(opts);
@@ -965,11 +965,11 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list,=
 const char *params,
 {
     Error *err =3D NULL;
     QemuOpts *opts;
-    bool invalidp =3D false;
+    bool help_wanted =3D false;
=20
-    opts =3D opts_parse(list, params, permit_abbrev, false, &invalidp, &er=
r);
+    opts =3D opts_parse(list, params, permit_abbrev, false, &help_wanted, =
&err);
     if (err) {
-        if (invalidp && has_help_option(params)) {
+        if (help_wanted) {
             qemu_opts_print_help(list, true);
             error_free(err);
         } else {
--=20
2.21.1


