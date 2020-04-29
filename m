Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC73BC83007
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999F42076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUt1L/rK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999F42076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTh3t-0001Qv-Nn
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1t-0007ta-Kr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1c-0003uA-DR
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41392
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh1b-0003qV-Vn
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588144854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WFwTmY5izH7vt1PFzmbOpOPKretwC0f3JKTKzMM1H/Y=;
 b=MUt1L/rKGkcWmajys6VCZRuDnc6KHk+RB5MU1qo0QACmFkg/0BV9gQalf8jd4sFz12BXAD
 FtMm+B1ASp+3M1TSyxAXKSsxU8fuKy56ssVae/GkvVAlGkGFGLPR0g4E5T+tVRSXobLzXo
 MfImfLN1CIatsBnHGKOn5ewRhWqLaGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-zpFDKbq9PCyPSXJHuJBrhg-1; Wed, 29 Apr 2020 03:20:52 -0400
X-MC-Unique: zpFDKbq9PCyPSXJHuJBrhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 265A3BFC3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 07:20:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9EC9648C8;
 Wed, 29 Apr 2020 07:20:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D984B11358C3; Wed, 29 Apr 2020 09:20:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/32] qemu-option: Avoid has_help_option() in
 qemu_opts_parse_noisily()
Date: Wed, 29 Apr 2020 09:20:23 +0200
Message-Id: <20200429072048.29963-8-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-1-armbru@redhat.com>
References: <20200429072048.29963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When opts_parse() sets @invalidp to true, qemu_opts_parse_noisily()
uses has_help_option() to decide whether to print help.  This parses
the input string a second time.

Easy to avoid: replace @invalidp by @help_wanted.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200415074927.19897-7-armbru@redhat.com>
---
 util/qemu-option.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 0abf26b61f..2d0d24ee27 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -519,7 +519,7 @@ int qemu_opt_unset(QemuOpts *opts, const char *name)
 }
=20
 static void opt_set(QemuOpts *opts, const char *name, char *value,
-                    bool prepend, bool *invalidp, Error **errp)
+                    bool prepend, bool *help_wanted, Error **errp)
 {
     QemuOpt *opt;
     const QemuOptDesc *desc;
@@ -529,8 +529,8 @@ static void opt_set(QemuOpts *opts, const char *name, c=
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
@@ -827,7 +827,7 @@ static const char *get_opt_name_value(const char *param=
s,
=20
 static void opts_do_parse(QemuOpts *opts, const char *params,
                           const char *firstname, bool prepend,
-                          bool *invalidp, Error **errp)
+                          bool *help_wanted, Error **errp)
 {
     Error *local_err =3D NULL;
     char *option, *value;
@@ -843,7 +843,7 @@ static void opts_do_parse(QemuOpts *opts, const char *p=
arams,
             continue;
         }
=20
-        opt_set(opts, option, value, prepend, invalidp, &local_err);
+        opt_set(opts, option, value, prepend, help_wanted, &local_err);
         g_free(option);
         if (local_err) {
             error_propagate(errp, local_err);
@@ -903,7 +903,7 @@ void qemu_opts_do_parse(QemuOpts *opts, const char *par=
ams,
=20
 static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
                             bool permit_abbrev, bool defaults,
-                            bool *invalidp, Error **errp)
+                            bool *help_wanted, Error **errp)
 {
     const char *firstname;
     char *id =3D opts_parse_id(params);
@@ -928,7 +928,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const c=
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
@@ -964,11 +964,11 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list,=
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


