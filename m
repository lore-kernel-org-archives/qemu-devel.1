Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F55BC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5F520409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv+SlBdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5F520409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuJG-0006K9-5k
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDtV8-0007bY-50
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDtV6-0008Jl-Gr
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:26:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDtV6-0008Dk-8z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:26:04 -0400
Received: by mail-wm1-x344.google.com with SMTP id x3so13809250wmj.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dXWR932K4HOgQCUPYucSc3bUlAFTBYQcNOphnZlIFpc=;
 b=fv+SlBdrX8TRZQIAicysyorbZwmp3ZkC67WsjChMoUwA9Hcw/9hRfi0M4dCAafobUg
 j1/R3VeAUmzRxTaRHsbWfmpNJk4RTvs83WgaRQCAUyigYyWlLFUkApKz8D6hgJRDfd4h
 399ckE1SMn8LMVq3KQt64O089bZ9k3M5MF2ytScyoEuXia+0jYcBOfbKwFu5al2hXWov
 gclT7eSO6gM+KBDzJVTGvw4xhmfTNwrtrRfiatVhh5Zm3A4hLL/kYCNd9NGw/1oGt/ch
 E2qkDhyy5QYIu9ZVsjbi4GclnxXeWgfkEiE9GOK3R5M9lA3C2fJ1BqtPPJLdtZcTdaF0
 GbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dXWR932K4HOgQCUPYucSc3bUlAFTBYQcNOphnZlIFpc=;
 b=hS/CrhJy16XE+mxXygcEuNXVPTk+8QU1myxbac1BDbgFkGSljicZzC6AiSn5TPRzK2
 R40LGNpZGGOUeWEXHIQqcGY2BRrbHx/5jkwxfVg0pEDZj0S0e0MF0zcqXWgljfXUGOJH
 E9d7GjD2AD2itUyQJ+FhsC8Kz5DfzcUg5NtYAHvXNLCDqeQk/jCAsCb9LpeIYLXWvCMV
 L1jKsNc9KXgZsSoyobhnUySKLEmVnl3XG3prNi08wSVV3g3RZB3h2j8VqK3+7npY+F/0
 CN8oYuELB5RK0mdN+qpzbTT9qhM5URghnG5UOfhzkk0V9TTfdZutsslByASShuCB1wfR
 RoFw==
X-Gm-Message-State: ANhLgQ0POTD+oQkrodJ84HlbEdaTLtYDMKxS6Fv5j+CaYnQ7zY+E9EyG
 ZnzlcbZtscSwiDakDppk1UnxYEVdo4Rt/ULJa2o=
X-Google-Smtp-Source: ADFU+vvzi71oXMJPGrWQ2WRoRdqDWonUtAUiBQ1BYWVSun4bGncARKF6BSfGgmEwbnkJKnbM8zDRXJLKYXX8z+t1cDE=
X-Received: by 2002:a7b:c7d9:: with SMTP id z25mr174858wmk.25.1584379563024;
 Mon, 16 Mar 2020 10:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-22-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-22-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 18:25:50 +0100
Message-ID: <CAJ+F1CLTwBajW=8gNx1o3c7+A0AfyeLwDPdyCHhqXnfi7+J+mA@mail.gmail.com>
Subject: Re: [PATCH v3 21/34] qapi: Inline do_qmp_dispatch() into
 qmp_dispatch()
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 15, 2020 at 4:05 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Both functions check @request is a QDict, and both have code for
> QCO_NO_SUCCESS_RESP.  This wasn't the case back when they were
> created.  It's a sign of muddled responsibilities.  Inline.  The next
> commits will clean up some more.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qapi/qmp-dispatch.c | 90 +++++++++++++++++++++------------------------
>  1 file changed, 41 insertions(+), 49 deletions(-)
>
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index bc264b3c9b..a588072523 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -75,19 +75,42 @@ static QDict *qmp_dispatch_check_obj(const QObject *r=
equest, bool allow_oob,
>      return dict;
>  }
>
> -static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
> -                                bool allow_oob, Error **errp)
> +QDict *qmp_error_response(Error *err)
>  {
> -    Error *local_err =3D NULL;
> +    QDict *rsp;
> +
> +    rsp =3D qdict_from_jsonf_nofail("{ 'error': { 'class': %s, 'desc': %=
s } }",
> +                                  QapiErrorClass_str(error_get_class(err=
)),
> +                                  error_get_pretty(err));
> +    error_free(err);
> +    return rsp;
> +}
> +
> +/*
> + * Does @qdict look like a command to be run out-of-band?
> + */
> +bool qmp_is_oob(const QDict *dict)
> +{
> +    return qdict_haskey(dict, "exec-oob")
> +        && !qdict_haskey(dict, "execute");
> +}
> +
> +QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
> +                    bool allow_oob)
> +{
> +    Error *err =3D NULL;
>      bool oob;
>      const char *command;
> -    QDict *args, *dict;
> +    QDict *args;
>      QmpCommand *cmd;
> +    QDict *dict =3D qobject_to(QDict, request);
> +    QObject *id =3D dict ? qdict_get(dict, "id") : NULL;
>      QObject *ret =3D NULL;
> +    QDict *rsp;
>
> -    dict =3D qmp_dispatch_check_obj(request, allow_oob, errp);
> +    dict =3D qmp_dispatch_check_obj(request, allow_oob, &err);
>      if (!dict) {
> -        return NULL;
> +        goto out;
>      }
>
>      command =3D qdict_get_try_str(dict, "execute");
> @@ -99,27 +122,27 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds=
, QObject *request,
>      }
>      cmd =3D qmp_find_command(cmds, command);
>      if (cmd =3D=3D NULL) {
> -        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
> +        error_set(&err, ERROR_CLASS_COMMAND_NOT_FOUND,
>                    "The command %s has not been found", command);
> -        return NULL;
> +        goto out;
>      }
>      if (!cmd->enabled) {
> -        error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
> +        error_set(&err, ERROR_CLASS_COMMAND_NOT_FOUND,
>                    "The command %s has been disabled for this instance",
>                    command);
> -        return NULL;
> +        goto out;
>      }
>      if (oob && !(cmd->options & QCO_ALLOW_OOB)) {
> -        error_setg(errp, "The command %s does not support OOB",
> +        error_setg(&err, "The command %s does not support OOB",
>                     command);
> -        return NULL;
> +        goto out;
>      }
>
>      if (runstate_check(RUN_STATE_PRECONFIG) &&
>          !(cmd->options & QCO_ALLOW_PRECONFIG)) {
> -        error_setg(errp, "The command '%s' isn't permitted in '%s' state=
",
> +        error_setg(&err, "The command '%s' isn't permitted in '%s' state=
",
>                     cmd->name, RunState_str(RUN_STATE_PRECONFIG));
> -        return NULL;
> +        goto out;
>      }
>
>      if (!qdict_haskey(dict, "arguments")) {
> @@ -129,9 +152,9 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds,=
 QObject *request,
>          qobject_ref(args);
>      }
>
> -    cmd->fn(args, &ret, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    cmd->fn(args, &ret, &err);
> +    if (err) {
> +        ;
>      } else if (cmd->options & QCO_NO_SUCCESS_RESP) {
>          g_assert(!ret);
>      } else if (!ret) {
> @@ -141,38 +164,7 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds=
, QObject *request,
>
>      qobject_unref(args);
>
> -    return ret;
> -}
> -
> -QDict *qmp_error_response(Error *err)
> -{
> -    QDict *rsp;
> -
> -    rsp =3D qdict_from_jsonf_nofail("{ 'error': { 'class': %s, 'desc': %=
s } }",
> -                                  QapiErrorClass_str(error_get_class(err=
)),
> -                                  error_get_pretty(err));
> -    error_free(err);
> -    return rsp;
> -}
> -
> -/*
> - * Does @qdict look like a command to be run out-of-band?
> - */
> -bool qmp_is_oob(const QDict *dict)
> -{
> -    return qdict_haskey(dict, "exec-oob")
> -        && !qdict_haskey(dict, "execute");
> -}
> -
> -QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
> -                    bool allow_oob)
> -{
> -    Error *err =3D NULL;
> -    QDict *dict =3D qobject_to(QDict, request);
> -    QObject *ret, *id =3D dict ? qdict_get(dict, "id") : NULL;
> -    QDict *rsp;
> -
> -    ret =3D do_qmp_dispatch(cmds, request, allow_oob, &err);
> +out:
>      if (err) {
>          rsp =3D qmp_error_response(err);
>      } else if (ret) {
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

