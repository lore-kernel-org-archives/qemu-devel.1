Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF45C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFEE720738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EL3tcgNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEE720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJTm-0006iG-VT
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 17:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEJLC-0002qm-3V
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEJL9-0002oj-IT
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEJL5-0002ie-3n
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584478886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wnWA83ts1HSjQlC0Ygsek2bFmmtPohUJxCiSNfFCXfc=;
 b=EL3tcgNRAwH0kFMCp2y0VR8hisUFMpaxZoz1c/7RRC+K7w4Kp5cFQA95Mi1W+wxOzpO/ss
 e3SjV73CFD6iM8wYFkciB9HS/cDZoMYEBhJqDp7iCQQltoNu5EIiaXno1GCVo+qmVZP2MN
 VtMwA5kPnMTa+fC9gaxjyApjtJijuN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-aUW3i2u-OoOCDxLgcH57tQ-1; Tue, 17 Mar 2020 17:01:24 -0400
X-MC-Unique: aUW3i2u-OoOCDxLgcH57tQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6635C800D55;
 Tue, 17 Mar 2020 21:01:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04A0273894;
 Tue, 17 Mar 2020 21:01:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A4D791135245; Tue, 17 Mar 2020 22:01:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/30] qmp: constify QmpCommand and list
Date: Tue, 17 Mar 2020 22:01:13 +0100
Message-Id: <20200317210115.8864-29-armbru@redhat.com>
In-Reply-To: <20200317210115.8864-1-armbru@redhat.com>
References: <20200317210115.8864-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Since 0b69f6f72ce47a37a749b056b6d5ec64c61f11e8 "qapi: remove
qmp_unregister_command()", the command list can be declared const.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
Message-Id: <20200316171824.2319695-1-marcandre.lureau@redhat.com>
[Rebased]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/dispatch.h | 9 +++++----
 monitor/monitor-internal.h  | 2 +-
 monitor/qmp-cmds-control.c  | 2 +-
 qapi/qmp-dispatch.c         | 4 ++--
 qapi/qmp-registry.c         | 6 +++---
 qga/commands.c              | 2 +-
 qga/main.c                  | 6 +++---
 7 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 9aa426a398..5a9cf82472 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -39,7 +39,8 @@ typedef QTAILQ_HEAD(QmpCommandList, QmpCommand) QmpComman=
dList;
=20
 void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options);
-QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name);
+const QmpCommand *qmp_find_command(const QmpCommandList *cmds,
+                                   const char *name);
 void qmp_disable_command(QmpCommandList *cmds, const char *name);
 void qmp_enable_command(QmpCommandList *cmds, const char *name);
=20
@@ -47,13 +48,13 @@ bool qmp_command_is_enabled(const QmpCommand *cmd);
 const char *qmp_command_name(const QmpCommand *cmd);
 bool qmp_has_success_response(const QmpCommand *cmd);
 QDict *qmp_error_response(Error *err);
-QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
+QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
                     bool allow_oob);
 bool qmp_is_oob(const QDict *dict);
=20
-typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
+typedef void (*qmp_cmd_callback_fn)(const QmpCommand *cmd, void *opaque);
=20
-void qmp_for_each_command(QmpCommandList *cmds, qmp_cmd_callback_fn fn,
+void qmp_for_each_command(const QmpCommandList *cmds, qmp_cmd_callback_fn =
fn,
                           void *opaque);
=20
 #endif
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 3e6baba88f..8f60ccc70a 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -133,7 +133,7 @@ typedef struct {
      * qmp_capabilities succeeds, we go into command mode, and
      * @command becomes &qmp_commands.
      */
-    QmpCommandList *commands;
+    const QmpCommandList *commands;
     bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered */
     bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted */
     /*
diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
index 5cd9bb817c..8f04cfa6e6 100644
--- a/monitor/qmp-cmds-control.c
+++ b/monitor/qmp-cmds-control.c
@@ -101,7 +101,7 @@ VersionInfo *qmp_query_version(Error **errp)
     return info;
 }
=20
-static void query_commands_cb(QmpCommand *cmd, void *opaque)
+static void query_commands_cb(const QmpCommand *cmd, void *opaque)
 {
     CommandInfoList *info, **list =3D opaque;
=20
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 44fc368d61..c30c7ff9e1 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -88,14 +88,14 @@ bool qmp_is_oob(const QDict *dict)
         && !qdict_haskey(dict, "execute");
 }
=20
-QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
+QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
                     bool allow_oob)
 {
     Error *err =3D NULL;
     bool oob;
     const char *command;
     QDict *args;
-    QmpCommand *cmd;
+    const QmpCommand *cmd;
     QDict *dict;
     QObject *id;
     QObject *ret =3D NULL;
diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
index ca00f74795..d0f9a1d3e3 100644
--- a/qapi/qmp-registry.c
+++ b/qapi/qmp-registry.c
@@ -27,7 +27,7 @@ void qmp_register_command(QmpCommandList *cmds, const cha=
r *name,
     QTAILQ_INSERT_TAIL(cmds, cmd, node);
 }
=20
-QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name)
+const QmpCommand *qmp_find_command(const QmpCommandList *cmds, const char =
*name)
 {
     QmpCommand *cmd;
=20
@@ -77,10 +77,10 @@ bool qmp_has_success_response(const QmpCommand *cmd)
     return !(cmd->options & QCO_NO_SUCCESS_RESP);
 }
=20
-void qmp_for_each_command(QmpCommandList *cmds, qmp_cmd_callback_fn fn,
+void qmp_for_each_command(const QmpCommandList *cmds, qmp_cmd_callback_fn =
fn,
                           void *opaque)
 {
-    QmpCommand *cmd;
+    const QmpCommand *cmd;
=20
     QTAILQ_FOREACH(cmd, cmds, node) {
         fn(cmd, opaque);
diff --git a/qga/commands.c b/qga/commands.c
index 43c323cead..f8852beb9c 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -54,7 +54,7 @@ void qmp_guest_ping(Error **errp)
     slog("guest-ping called");
 }
=20
-static void qmp_command_info(QmpCommand *cmd, void *opaque)
+static void qmp_command_info(const QmpCommand *cmd, void *opaque)
 {
     GuestAgentInfo *info =3D opaque;
     GuestAgentCommandInfo *cmd_info;
diff --git a/qga/main.c b/qga/main.c
index e5c39c189a..8ee2736f8e 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -359,7 +359,7 @@ static gint ga_strcmp(gconstpointer str1, gconstpointer=
 str2)
 }
=20
 /* disable commands that aren't safe for fsfreeze */
-static void ga_disable_non_whitelisted(QmpCommand *cmd, void *opaque)
+static void ga_disable_non_whitelisted(const QmpCommand *cmd, void *opaque=
)
 {
     bool whitelisted =3D false;
     int i =3D 0;
@@ -378,7 +378,7 @@ static void ga_disable_non_whitelisted(QmpCommand *cmd,=
 void *opaque)
 }
=20
 /* [re-]enable all commands, except those explicitly blacklisted by user *=
/
-static void ga_enable_non_blacklisted(QmpCommand *cmd, void *opaque)
+static void ga_enable_non_blacklisted(const QmpCommand *cmd, void *opaque)
 {
     GList *blacklist =3D opaque;
     const char *name =3D qmp_command_name(cmd);
@@ -918,7 +918,7 @@ int64_t ga_get_fd_handle(GAState *s, Error **errp)
     return handle;
 }
=20
-static void ga_print_cmd(QmpCommand *cmd, void *opaque)
+static void ga_print_cmd(const QmpCommand *cmd, void *opaque)
 {
     printf("%s\n", qmp_command_name(cmd));
 }
--=20
2.21.1


