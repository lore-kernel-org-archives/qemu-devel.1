Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3067EC7619F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF76E20725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWKeYmga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF76E20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3ey1-0001Id-5V
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j3esV-0002Bt-6g
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:47:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1j3esT-0004SJ-NH
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:47:55 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1j3esT-0004RT-Ey
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:47:53 -0500
Received: by mail-wm1-x341.google.com with SMTP id b17so18127700wmb.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 03:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5FmZo3kfqSxY/nBaqvmnwPDPSKJwRrASqwzsEjuaiOo=;
 b=kWKeYmgaQ59FYdUChPOK7wjyNYQ4Ae8JuWL+6PPMB3zIMfFlB5L0InSKG8at+N153q
 KOo9ULlxlMFGSsDgzOnLo0YBZ/Vf15HKOB9CPm7AJnbPyVBcQH0yON1W4bv0sqFF+eJK
 hxnrhYLLVyXzK62P6TNVq1YrIjeZaU2L54/Y+gpClBNxqh3uaudSCcjTsSiHTOwGcPad
 3wxYJIO1FWntjG2IbVojSqjDwahhN73C3QadaePrDFMZatyQ1KMBreTkBF+vOWKhxSEQ
 JQfqhx/gjpawUTVPmHJqDlOL9pP7fMZiMNeSEUo9q0SuxPIGTML1eXEx28Ye3ho1XCUO
 K9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5FmZo3kfqSxY/nBaqvmnwPDPSKJwRrASqwzsEjuaiOo=;
 b=OCEM03dksrpg1SlFaub+Dt/Udm9SxxCP2IcAskFvJxMnHgMIfh+2DazKs7kT7T6Z0V
 SSdUXTjGHNl7b16A1rVzLpcbiA8far7mH7XIm3uKBFGCme/TE4Xg8KAzzxu3vwHG9I49
 k+Tf4pgaeLZjgsVnr/t8GhFaYhdsc/PCQmBLIbt2jSWrAWgCnrrUJ9BV3pXhv5PVRSCp
 UilAF/1tW4eW0mlyufW9EAOyJKBbf6yPDqNaDOsb/U4rsIq962stYqRO1RpN7GNp/0nd
 CGvrWusaCY+pOUeYPuROJXNN0nezmavozi0Xg4B6sFtdFgF5fIUGFykEyntY2g++Y43H
 rGhA==
X-Gm-Message-State: APjAAAWNxUDJuuttm/5g6AG8UtgLGL3dlmjwgH4MMBdFWYdZKiS2MGUU
 HBFDeMmz9IMZZORBKz60uvkK9U5E52J7JaTOFxo=
X-Google-Smtp-Source: APXvYqxHFP8Ygb5RsJjDpxtq4hoA7cBDoReoXCWIFF4SkGKgqYEPQ+ZvxntMUAbmnHP7ugXpm3GJAyDjNsAa9oWkjx0=
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr20902447wmi.37.1581940072409; 
 Mon, 17 Feb 2020 03:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20191108150123.12213-1-marcandre.lureau@redhat.com>
 <20191108150123.12213-2-marcandre.lureau@redhat.com>
 <cc27aa10-c6e2-0de8-a55f-b9a8da67dde2@greensocs.com>
In-Reply-To: <cc27aa10-c6e2-0de8-a55f-b9a8da67dde2@greensocs.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 17 Feb 2020 12:47:40 +0100
Message-ID: <CAJ+F1CJks+3y6Wh93w+tT6YyO3-iW9kDFNqzW96OyXJ-O+xdaA@mail.gmail.com>
Subject: Re: [PATCH v6 01/25] qmp: constify QmpCommand and list
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, QEMU <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus,

Can you review/queue this patch?

thanks

On Fri, Nov 8, 2019 at 5:52 PM Damien Hedde <damien.hedde@greensocs.com> wr=
ote:
>
>
>
> On 11/8/19 4:00 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Since 0b69f6f72ce47a37a749b056b6d5ec64c61f11e8 "qapi: remove
> > qmp_unregister_command()", the command list can be declared const.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/qapi/qmp/dispatch.h | 9 +++++----
> >  monitor/misc.c              | 2 +-
> >  monitor/monitor-internal.h  | 2 +-
> >  qapi/qmp-dispatch.c         | 6 +++---
> >  qapi/qmp-registry.c         | 6 +++---
> >  qga/commands.c              | 2 +-
> >  qga/main.c                  | 6 +++---
> >  7 files changed, 17 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> > index 9aa426a398..5a9cf82472 100644
> > --- a/include/qapi/qmp/dispatch.h
> > +++ b/include/qapi/qmp/dispatch.h
> > @@ -39,7 +39,8 @@ typedef QTAILQ_HEAD(QmpCommandList, QmpCommand) QmpCo=
mmandList;
> >
> >  void qmp_register_command(QmpCommandList *cmds, const char *name,
> >                            QmpCommandFunc *fn, QmpCommandOptions option=
s);
> > -QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name);
> > +const QmpCommand *qmp_find_command(const QmpCommandList *cmds,
> > +                                   const char *name);
> >  void qmp_disable_command(QmpCommandList *cmds, const char *name);
> >  void qmp_enable_command(QmpCommandList *cmds, const char *name);
> >
> > @@ -47,13 +48,13 @@ bool qmp_command_is_enabled(const QmpCommand *cmd);
> >  const char *qmp_command_name(const QmpCommand *cmd);
> >  bool qmp_has_success_response(const QmpCommand *cmd);
> >  QDict *qmp_error_response(Error *err);
> > -QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
> > +QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
> >                      bool allow_oob);
> >  bool qmp_is_oob(const QDict *dict);
> >
> > -typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
> > +typedef void (*qmp_cmd_callback_fn)(const QmpCommand *cmd, void *opaqu=
e);
> >
> > -void qmp_for_each_command(QmpCommandList *cmds, qmp_cmd_callback_fn fn=
,
> > +void qmp_for_each_command(const QmpCommandList *cmds, qmp_cmd_callback=
_fn fn,
> >                            void *opaque);
> >
> >  #endif
> > diff --git a/monitor/misc.c b/monitor/misc.c
> > index 3baa15f3bf..3052bfe8f1 100644
> > --- a/monitor/misc.c
> > +++ b/monitor/misc.c
> > @@ -230,7 +230,7 @@ static void hmp_info_help(Monitor *mon, const QDict=
 *qdict)
> >      help_cmd(mon, "info");
> >  }
> >
> > -static void query_commands_cb(QmpCommand *cmd, void *opaque)
> > +static void query_commands_cb(const QmpCommand *cmd, void *opaque)
> >  {
> >      CommandInfoList *info, **list =3D opaque;
> >
> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > index d78f5ca190..3e7dac5910 100644
> > --- a/monitor/monitor-internal.h
> > +++ b/monitor/monitor-internal.h
> > @@ -132,7 +132,7 @@ typedef struct {
> >       * qmp_capabilities succeeds, we go into command mode, and
> >       * @command becomes &qmp_commands.
> >       */
> > -    QmpCommandList *commands;
> > +    const QmpCommandList *commands;
> >      bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered *=
/
> >      bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted *=
/
> >      /*
> > diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> > index bc264b3c9b..857399c5fe 100644
> > --- a/qapi/qmp-dispatch.c
> > +++ b/qapi/qmp-dispatch.c
> > @@ -75,14 +75,14 @@ static QDict *qmp_dispatch_check_obj(const QObject =
*request, bool allow_oob,
> >      return dict;
> >  }
> >
> > -static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request=
,
> > +static QObject *do_qmp_dispatch(const QmpCommandList *cmds, QObject *r=
equest,
> >                                  bool allow_oob, Error **errp)
> >  {
> >      Error *local_err =3D NULL;
> >      bool oob;
> >      const char *command;
> >      QDict *args, *dict;
> > -    QmpCommand *cmd;
> > +    const QmpCommand *cmd;
> >      QObject *ret =3D NULL;
> >
> >      dict =3D qmp_dispatch_check_obj(request, allow_oob, errp);
> > @@ -164,7 +164,7 @@ bool qmp_is_oob(const QDict *dict)
> >          && !qdict_haskey(dict, "execute");
> >  }
> >
> > -QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
> > +QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
> >                      bool allow_oob)
> >  {
> >      Error *err =3D NULL;
> > diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
> > index ca00f74795..d0f9a1d3e3 100644
> > --- a/qapi/qmp-registry.c
> > +++ b/qapi/qmp-registry.c
> > @@ -27,7 +27,7 @@ void qmp_register_command(QmpCommandList *cmds, const=
 char *name,
> >      QTAILQ_INSERT_TAIL(cmds, cmd, node);
> >  }
> >
> > -QmpCommand *qmp_find_command(QmpCommandList *cmds, const char *name)
> > +const QmpCommand *qmp_find_command(const QmpCommandList *cmds, const c=
har *name)
> >  {
> >      QmpCommand *cmd;
> >
> > @@ -77,10 +77,10 @@ bool qmp_has_success_response(const QmpCommand *cmd=
)
> >      return !(cmd->options & QCO_NO_SUCCESS_RESP);
> >  }
> >
> > -void qmp_for_each_command(QmpCommandList *cmds, qmp_cmd_callback_fn fn=
,
> > +void qmp_for_each_command(const QmpCommandList *cmds, qmp_cmd_callback=
_fn fn,
> >                            void *opaque)
> >  {
> > -    QmpCommand *cmd;
> > +    const QmpCommand *cmd;
> >
> >      QTAILQ_FOREACH(cmd, cmds, node) {
> >          fn(cmd, opaque);
> > diff --git a/qga/commands.c b/qga/commands.c
> > index 0c7d1385c2..05e9ab6c3d 100644
> > --- a/qga/commands.c
> > +++ b/qga/commands.c
> > @@ -54,7 +54,7 @@ void qmp_guest_ping(Error **errp)
> >      slog("guest-ping called");
> >  }
> >
> > -static void qmp_command_info(QmpCommand *cmd, void *opaque)
> > +static void qmp_command_info(const QmpCommand *cmd, void *opaque)
> >  {
> >      GuestAgentInfo *info =3D opaque;
> >      GuestAgentCommandInfo *cmd_info;
> > diff --git a/qga/main.c b/qga/main.c
> > index c35c2a2120..f23614528e 100644
> > --- a/qga/main.c
> > +++ b/qga/main.c
> > @@ -359,7 +359,7 @@ static gint ga_strcmp(gconstpointer str1, gconstpoi=
nter str2)
> >  }
> >
> >  /* disable commands that aren't safe for fsfreeze */
> > -static void ga_disable_non_whitelisted(QmpCommand *cmd, void *opaque)
> > +static void ga_disable_non_whitelisted(const QmpCommand *cmd, void *op=
aque)
> >  {
> >      bool whitelisted =3D false;
> >      int i =3D 0;
> > @@ -378,7 +378,7 @@ static void ga_disable_non_whitelisted(QmpCommand *=
cmd, void *opaque)
> >  }
> >
> >  /* [re-]enable all commands, except those explicitly blacklisted by us=
er */
> > -static void ga_enable_non_blacklisted(QmpCommand *cmd, void *opaque)
> > +static void ga_enable_non_blacklisted(const QmpCommand *cmd, void *opa=
que)
> >  {
> >      GList *blacklist =3D opaque;
> >      const char *name =3D qmp_command_name(cmd);
> > @@ -918,7 +918,7 @@ int64_t ga_get_fd_handle(GAState *s, Error **errp)
> >      return handle;
> >  }
> >
> > -static void ga_print_cmd(QmpCommand *cmd, void *opaque)
> > +static void ga_print_cmd(const QmpCommand *cmd, void *opaque)
> >  {
> >      printf("%s\n", qmp_command_name(cmd));
> >  }
> >
>
> Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
>
> Damien
>


--=20
Marc-Andr=C3=A9 Lureau

