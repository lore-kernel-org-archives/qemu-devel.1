Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C04FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B73C2178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="ebIeFKlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B73C2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT7Wj-0007SI-9F
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 11:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iT7TB-0005yt-2s
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iT7T9-0008EI-FA
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:50:44 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:36080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iT7T8-0007xF-9D
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:50:42 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 5C0AF96EF0;
 Fri,  8 Nov 2019 16:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1573231839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+9tE0DETWQYpJXS67JXpnNPmDD6hnQXbcAhcIpT4+g=;
 b=ebIeFKlEXgP3S5OEQjjnE9brv/IlnsrB7KOHP7pCCRix+AfvHUeGxv+UCR49/xAMADncMh
 2fcL3etQMwpjfAbE1Jup9UPp5cGehcrETV5bqckQBMStWi2nJICEPJ4uZOIO1yFOPGk4qk
 dMgH8cwjqOqJ3SjX7jrkUShtVye5g9A=
Subject: Re: [PATCH v6 01/25] qmp: constify QmpCommand and list
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
 <20191108150123.12213-2-marcandre.lureau@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <cc27aa10-c6e2-0de8-a55f-b9a8da67dde2@greensocs.com>
Date: Fri, 8 Nov 2019 17:50:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191108150123.12213-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1573231839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+9tE0DETWQYpJXS67JXpnNPmDD6hnQXbcAhcIpT4+g=;
 b=JynvSUVsZdlSdYTicXOEIUJ1cd/4u1JDmh5HHZz/+ejr1eStipbjUy7p7ju+I4+9T8Br7C
 Ku549mmmkMYscHKeq+kFe4lbfOymSHS4upLpKRFMZ8n7auLGCTC4Z7YsnilPMs82rPG9ud
 2vJle+PdU+ArRZpPkMEajNrgkELi0dQ=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1573231839; a=rsa-sha256; cv=none;
 b=i/crOpoMNR8pC3XE8MI5gMA95Q0UibDsczPQ74jH/HLqnox8wzPB/EOWavUNeH/NjCGv3U
 LO8fKmbjGuP6Emw+QsLsHbA1nUD7WqVTvy4Fiyig/IqLpw0bvcE5CrkKQeWOcYF0mJjQ7M
 8tPAenB2jhWuLzZSarG5Aq4ozP/qAxU=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: armbru@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/8/19 4:00 PM, Marc-Andr=C3=A9 Lureau wrote:
> Since 0b69f6f72ce47a37a749b056b6d5ec64c61f11e8 "qapi: remove
> qmp_unregister_command()", the command list can be declared const.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/dispatch.h | 9 +++++----
>  monitor/misc.c              | 2 +-
>  monitor/monitor-internal.h  | 2 +-
>  qapi/qmp-dispatch.c         | 6 +++---
>  qapi/qmp-registry.c         | 6 +++---
>  qga/commands.c              | 2 +-
>  qga/main.c                  | 6 +++---
>  7 files changed, 17 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> index 9aa426a398..5a9cf82472 100644
> --- a/include/qapi/qmp/dispatch.h
> +++ b/include/qapi/qmp/dispatch.h
> @@ -39,7 +39,8 @@ typedef QTAILQ_HEAD(QmpCommandList, QmpCommand) QmpCo=
mmandList;
> =20
>  void qmp_register_command(QmpCommandList *cmds, const char *name,
>                            QmpCommandFunc *fn, QmpCommandOptions option=
s);
> -QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name);
> +const QmpCommand *qmp_find_command(const QmpCommandList *cmds,
> +                                   const char *name);
>  void qmp_disable_command(QmpCommandList *cmds, const char *name);
>  void qmp_enable_command(QmpCommandList *cmds, const char *name);
> =20
> @@ -47,13 +48,13 @@ bool qmp_command_is_enabled(const QmpCommand *cmd);
>  const char *qmp_command_name(const QmpCommand *cmd);
>  bool qmp_has_success_response(const QmpCommand *cmd);
>  QDict *qmp_error_response(Error *err);
> -QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
> +QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
>                      bool allow_oob);
>  bool qmp_is_oob(const QDict *dict);
> =20
> -typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
> +typedef void (*qmp_cmd_callback_fn)(const QmpCommand *cmd, void *opaqu=
e);
> =20
> -void qmp_for_each_command(QmpCommandList *cmds, qmp_cmd_callback_fn fn=
,
> +void qmp_for_each_command(const QmpCommandList *cmds, qmp_cmd_callback=
_fn fn,
>                            void *opaque);
> =20
>  #endif
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 3baa15f3bf..3052bfe8f1 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -230,7 +230,7 @@ static void hmp_info_help(Monitor *mon, const QDict=
 *qdict)
>      help_cmd(mon, "info");
>  }
> =20
> -static void query_commands_cb(QmpCommand *cmd, void *opaque)
> +static void query_commands_cb(const QmpCommand *cmd, void *opaque)
>  {
>      CommandInfoList *info, **list =3D opaque;
> =20
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index d78f5ca190..3e7dac5910 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -132,7 +132,7 @@ typedef struct {
>       * qmp_capabilities succeeds, we go into command mode, and
>       * @command becomes &qmp_commands.
>       */
> -    QmpCommandList *commands;
> +    const QmpCommandList *commands;
>      bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered *=
/
>      bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted *=
/
>      /*
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index bc264b3c9b..857399c5fe 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -75,14 +75,14 @@ static QDict *qmp_dispatch_check_obj(const QObject =
*request, bool allow_oob,
>      return dict;
>  }
> =20
> -static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request=
,
> +static QObject *do_qmp_dispatch(const QmpCommandList *cmds, QObject *r=
equest,
>                                  bool allow_oob, Error **errp)
>  {
>      Error *local_err =3D NULL;
>      bool oob;
>      const char *command;
>      QDict *args, *dict;
> -    QmpCommand *cmd;
> +    const QmpCommand *cmd;
>      QObject *ret =3D NULL;
> =20
>      dict =3D qmp_dispatch_check_obj(request, allow_oob, errp);
> @@ -164,7 +164,7 @@ bool qmp_is_oob(const QDict *dict)
>          && !qdict_haskey(dict, "execute");
>  }
> =20
> -QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
> +QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
>                      bool allow_oob)
>  {
>      Error *err =3D NULL;
> diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
> index ca00f74795..d0f9a1d3e3 100644
> --- a/qapi/qmp-registry.c
> +++ b/qapi/qmp-registry.c
> @@ -27,7 +27,7 @@ void qmp_register_command(QmpCommandList *cmds, const=
 char *name,
>      QTAILQ_INSERT_TAIL(cmds, cmd, node);
>  }
> =20
> -QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name)
> +const QmpCommand *qmp_find_command(const QmpCommandList *cmds, const c=
har *name)
>  {
>      QmpCommand *cmd;
> =20
> @@ -77,10 +77,10 @@ bool qmp_has_success_response(const QmpCommand *cmd=
)
>      return !(cmd->options & QCO_NO_SUCCESS_RESP);
>  }
> =20
> -void qmp_for_each_command(QmpCommandList *cmds, qmp_cmd_callback_fn fn=
,
> +void qmp_for_each_command(const QmpCommandList *cmds, qmp_cmd_callback=
_fn fn,
>                            void *opaque)
>  {
> -    QmpCommand *cmd;
> +    const QmpCommand *cmd;
> =20
>      QTAILQ_FOREACH(cmd, cmds, node) {
>          fn(cmd, opaque);
> diff --git a/qga/commands.c b/qga/commands.c
> index 0c7d1385c2..05e9ab6c3d 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -54,7 +54,7 @@ void qmp_guest_ping(Error **errp)
>      slog("guest-ping called");
>  }
> =20
> -static void qmp_command_info(QmpCommand *cmd, void *opaque)
> +static void qmp_command_info(const QmpCommand *cmd, void *opaque)
>  {
>      GuestAgentInfo *info =3D opaque;
>      GuestAgentCommandInfo *cmd_info;
> diff --git a/qga/main.c b/qga/main.c
> index c35c2a2120..f23614528e 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -359,7 +359,7 @@ static gint ga_strcmp(gconstpointer str1, gconstpoi=
nter str2)
>  }
> =20
>  /* disable commands that aren't safe for fsfreeze */
> -static void ga_disable_non_whitelisted(QmpCommand *cmd, void *opaque)
> +static void ga_disable_non_whitelisted(const QmpCommand *cmd, void *op=
aque)
>  {
>      bool whitelisted =3D false;
>      int i =3D 0;
> @@ -378,7 +378,7 @@ static void ga_disable_non_whitelisted(QmpCommand *=
cmd, void *opaque)
>  }
> =20
>  /* [re-]enable all commands, except those explicitly blacklisted by us=
er */
> -static void ga_enable_non_blacklisted(QmpCommand *cmd, void *opaque)
> +static void ga_enable_non_blacklisted(const QmpCommand *cmd, void *opa=
que)
>  {
>      GList *blacklist =3D opaque;
>      const char *name =3D qmp_command_name(cmd);
> @@ -918,7 +918,7 @@ int64_t ga_get_fd_handle(GAState *s, Error **errp)
>      return handle;
>  }
> =20
> -static void ga_print_cmd(QmpCommand *cmd, void *opaque)
> +static void ga_print_cmd(const QmpCommand *cmd, void *opaque)
>  {
>      printf("%s\n", qmp_command_name(cmd));
>  }
>=20

Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>

Damien

