Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A3CC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BAE6206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9xGO7DN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAE6206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHkya-0005GM-BH
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 05:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHkxy-0004rr-Rm
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHkxx-0001ni-CR
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:07:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHkxx-0001lU-26
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:07:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id p10so10454239wrt.6
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 02:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xXACT3yOLoBasvUhAI59brexatvgAkSpmbxuVkkNYcw=;
 b=w9xGO7DNATToExK6QY7ObUp7BjDa/daHWHT1w7dfIhQfbUFZ+4MlXRqEQEbLqYYlHY
 TymWH89hDo8Kapb1tmC+0XjX1oCzITkiyZq65XY0pG08PGQtwTfwQpt4XGDBkQnYU0RF
 +KzSrXYfCrr1awANFzQyWBjFQOwNU3xFnHZipGTinpWXf4ZU7vnYFsFLnjpzuhv//IKz
 FQGnyUaCsrOYwRr/244sjYtH6o9NXyVrvI5fWwa0V42kIylAtyQDzncRbjyS760+Rvnn
 sCa4GoABnd3xrK/dFM53JD9NvkiI29CpGx6EUrnM6p3+N3yH/MFHp8pAZa13eNJQ24Qs
 ddAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xXACT3yOLoBasvUhAI59brexatvgAkSpmbxuVkkNYcw=;
 b=PQWgZYVY517/2P29Kae7m7imcq8TxSkLbkVUxuoUs9TrBbrsUpV9NgLP0wkhdS3PCr
 s93Av1OxAkigOVT8R5PZTIkTX/1zA28qvemVhx94yyt7lWI9GeI5xYq9N9gBgxpkeMVr
 LHsUIkUUQ+flsV8tUYGUdgh3rspdSc4k/mOdu4rhlzBqr6h2f8FZTXxrj6tgmJPGWJWU
 SryiA4PhXYbIPfJFyF4H4cifC9WBY+ORUDompfCcg3rV+VH5aSfj8I3J252eZXYTVG/L
 mbWUuBGogW9XUAmB3yBzZ27Rk2OZMgTVSIxK1kki1Vww2aJJlDVGDrbY3yfaXD3/kUjL
 ei+Q==
X-Gm-Message-State: ANhLgQ3LVtDMwP0j0pKRLaSab1KUJbtrME5HNJR6fU91pUh8b0R6VJs/
 JL++zNeCUv6RhYhwTl7j3ftMC9Ogm3A=
X-Google-Smtp-Source: ADFU+vu+kDzx9qgFp3Sf+l5cCzuN8yO63QHZ+/qwy9A4MrcesVvqxj7QT/jbfI0UkJ8lyx8JNIR68w==
X-Received: by 2002:adf:83c4:: with SMTP id 62mr14792087wre.105.1585300066101; 
 Fri, 27 Mar 2020 02:07:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o16sm3893523wrw.75.2020.03.27.02.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 02:07:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0BC6E1FF7E;
 Fri, 27 Mar 2020 09:07:44 +0000 (GMT)
References: <20200326151407.25046-1-dplotnikov@virtuozzo.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH] gdbstub: fix compiler complaining
In-reply-to: <20200326151407.25046-1-dplotnikov@virtuozzo.com>
Date: Fri, 27 Mar 2020 09:07:43 +0000
Message-ID: <877dz6np28.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Denis Plotnikov <dplotnikov@virtuozzo.com> writes:

>     ./gdbstub.c: In function =E2=80=98handle_query_thread_extra=E2=80=99:
>         /usr/include/glib-2.0/glib/glib-autocleanups.h:28:10:
>     error: =E2=80=98cpu_name=E2=80=99 may be used uninitialized in this f=
unction
>     [-Werror=3Dmaybe-uninitialized]
>         g_free (*pp);
>                ^
>     ./gdbstub.c:2063:26: note: =E2=80=98cpu_name=E2=80=99 was declared he=
re
>         g_autofree char *cpu_name;
>                          ^
>     cc1: all warnings being treated as errors
>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>

Queued to for-5.0/random-fixes, thanks.

> ---
>  gdbstub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 013fb1ac0f..171e150950 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2060,8 +2060,8 @@ static void handle_query_thread_extra(GdbCmdContext=
 *gdb_ctx, void *user_ctx)
>          /* Print the CPU model and name in multiprocess mode */
>          ObjectClass *oc =3D object_get_class(OBJECT(cpu));
>          const char *cpu_model =3D object_class_get_name(oc);
> -        g_autofree char *cpu_name;
> -        cpu_name  =3D object_get_canonical_path_component(OBJECT(cpu));
> +        g_autofree char *cpu_name =3D
> +            object_get_canonical_path_component(OBJECT(cpu));
>          g_string_printf(rs, "%s %s [%s]", cpu_model, cpu_name,
>                          cpu->halted ? "halted " : "running");
>      } else {


--=20
Alex Benn=C3=A9e

