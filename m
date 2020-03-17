Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF29C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 07:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E4B205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 07:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLfnMOTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E4B205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE6nd-0000sK-CE
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 03:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jE6n5-0000RJ-Sn
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 03:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jE6n4-0008Dd-Oy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 03:37:31 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jE6n4-00088Y-FD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 03:37:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id z15so24240260wrl.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 00:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Y7NrFQfTm69+MjGp3K5mXD1S8kG1BEKp0aPoo00lWxI=;
 b=PLfnMOTJf2iLRbO2FZhA91iMqiDK6ZrSb5TWejqEnIWKG1X0WmFlW6pjBR+BRYqlKY
 9Kd9TXQED1LTjcy6T01JqUe50iNdw4TYYzjmXkNottENb9lIFNEtTtCl+OAusWbi9xI+
 mecokHzawJHXNTV9uURqpzSw89rL44OwkKEauDLC6XoHNKioap6MwIcHX6U02rzLMPXD
 MDiGrxCe/JFewcGOPjx3o7FzkSg8PAskwvBUV8PJp7YoSh5eA/1txfWjHMHDR1r8/KZ5
 lTjzPxtFuRCMBWMAGtOfBBksksKVBSOxLmviBBYGL6MDHGjeqJ2poFvUvlW8zri3vLBG
 99pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Y7NrFQfTm69+MjGp3K5mXD1S8kG1BEKp0aPoo00lWxI=;
 b=Ul2K1lXbkg4H4638tMc0qQuGP+nbcLCgIHWPnTjwyZJbfVUZ7JGFI9EbPxp+WkjVtu
 GpqqxLPMDbSIkSmz2HoTm67iRjJqdH6C89qNAC14OyJtucbZ1H14cTrA/Hjecp2cRie9
 VACpjHAP6RiVuN0ersuK0jK1RWQud6vSoCYRKbFNRD9bOiw3SGq86zoYTg/01JSVWMjM
 0CD4HMp+vJ8eTHNClUATkd5SpiZ9nTHQwH593cLYyo7D1DhfK47/rC6SCRZeQa2uEnMW
 ksEztyr6wLm2186T5x6BMgLsbCy7r7X2ab2EaEqy8X0lbJ1Yr+UNtELXx0sQLjP20w5m
 WIcQ==
X-Gm-Message-State: ANhLgQ2cvwIg5+hcvSw6gxnYUiV8ABJQnxWgPxCyhbh8ZkoT6DLhAfZj
 xU4Rwli1/xx/vf5wF0MNothlB0/mgtOXKShhKGc=
X-Google-Smtp-Source: ADFU+vt7jhaaavXdQF/MvAgHcEF1npyurfYOw4XZ73KnGsHVcGAIw88y426HNiC4UJloiKRy6tg78Bef2JKu+HZNmnM=
X-Received: by 2002:adf:cc85:: with SMTP id p5mr4291339wrj.196.1584430649067; 
 Tue, 17 Mar 2020 00:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-24-armbru@redhat.com>
 <CAJ+F1CLUikxRN2nH8h_9zGXLLpsxz4H-cMxxLbctAzavWjAcWw@mail.gmail.com>
 <874kunv60w.fsf@dusky.pond.sub.org>
In-Reply-To: <874kunv60w.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Mar 2020 08:37:17 +0100
Message-ID: <CAJ+F1CKxM9VK-VeQNzfZQw+yZJ9tt4oEP0fqcMBNKwP4YqarxQ@mail.gmail.com>
Subject: Re: [PATCH v3 23/34] qapi: Simplify how qmp_dispatch() gets the
 request ID
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Hi

On Tue, Mar 17, 2020 at 7:40 AM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > On Sun, Mar 15, 2020 at 3:51 PM Markus Armbruster <armbru@redhat.com> w=
rote:
> >>
> >> We convert the request object to a QDict twice: first in
> >> qmp_dispatch() to get the request ID, and then again in
> >> qmp_dispatch_check_obj(), which converts to QDict, then checks and
> >> returns it.  We can't get the request ID from the latter, because it's
> >> null when the qdict flunks the checks.
> >>
> >> Move getting the request ID into qmp_dispatch_check_obj().
> >>
> >
> > I don't see this is a an improvement. qmp_dispatch_check_obj() doesn't
> > care about id.
> >
> > And it doesn't look like it is saving cycles either.
> >
> > Is that worth it?
> >
> > Code change is ok otherwise,
>
> The duplicated conversion to QDict annoys me, mostly because both copies
> can fail.
>
> But you're right, my solution is hamfisted.  What about this one?
>
>
> From 46a1719be9503f86636ff672325c5430d4063b8b Mon Sep 17 00:00:00 2001
> From: Markus Armbruster <armbru@redhat.com>
> Date: Mon, 21 Oct 2019 15:52:20 +0200
> Subject: [PATCH] qapi: Simplify how qmp_dispatch() gets the request ID
>
> We convert the request object to a QDict twice: first in
> qmp_dispatch() to get the request ID, and then again in
> qmp_dispatch_check_obj(), which converts to QDict, then checks and
> returns it.  We can't get the request ID from the latter, because it's
> null when the qdict flunks the checks.
>
> Move the checked conversion to QDict from qmp_dispatch_check_obj() to
> qmp_dispatch(), and drop the duplicate there.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/qmp-dispatch.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index 550d1fe8d2..91e50fa0dd 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -19,20 +19,13 @@
>  #include "sysemu/runstate.h"
>  #include "qapi/qmp/qbool.h"
>
> -static QDict *qmp_dispatch_check_obj(const QObject *request, bool allow_=
oob,
> +static QDict *qmp_dispatch_check_obj(QDict *dict, bool allow_oob,
>                                       Error **errp)
>  {
>      const char *exec_key =3D NULL;
>      const QDictEntry *ent;
>      const char *arg_name;
>      const QObject *arg_obj;
> -    QDict *dict;
> -
> -    dict =3D qobject_to(QDict, request);
> -    if (!dict) {
> -        error_setg(errp, "QMP input must be a JSON object");
> -        return NULL;
> -    }
>
>      for (ent =3D qdict_first(dict); ent;
>           ent =3D qdict_next(dict, ent)) {
> @@ -103,13 +96,21 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *r=
equest,
>      const char *command;
>      QDict *args;
>      QmpCommand *cmd;
> -    QDict *dict =3D qobject_to(QDict, request);
> -    QObject *id =3D dict ? qdict_get(dict, "id") : NULL;
> +    QDict *dict;
> +    QObject *id;
>      QObject *ret =3D NULL;
>      QDict *rsp =3D NULL;
>
> -    dict =3D qmp_dispatch_check_obj(request, allow_oob, &err);
> +    dict =3D qobject_to(QDict, request);
>      if (!dict) {
> +        id =3D NULL;
> +        error_setg(&err, "QMP input must be a JSON object");
> +        goto out;
> +    }
> +
> +    id =3D qdict_get(dict, "id");
> +
> +    if (!qmp_dispatch_check_obj(dict, allow_oob, &err)) {
>          goto out;
>      }
>
> --
> 2.21.1
>

It seems cleaner to me,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>




--=20
Marc-Andr=C3=A9 Lureau

