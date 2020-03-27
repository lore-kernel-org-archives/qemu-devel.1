Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DC7C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B73A7206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWilbccF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73A7206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHl3E-0006iQ-Tg
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 05:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHl2d-0006DH-3e
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHl2Y-0005Oy-4N
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:12:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHl2X-0005Lr-LM
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:12:34 -0400
Received: by mail-wm1-x343.google.com with SMTP id a9so11443645wmj.4
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 02:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=VDKz5xj4Ag35S/nd/UOQDRJeyFgs4jGAjtuHHsGBYig=;
 b=rWilbccFXwYKObj51DLNPAnmhhMN2BppaN8gywMRgfR80CVww2X5chv9BmAmPrG2uu
 XVHhyR8vdMQ8dN3PLO32WBg0v15a+JpwQdWiNDVm8RN+gRfM3XxVxaUt6veU6uEIK6Oy
 crkMWOMgL5iAGcZ9mXCoRS7N+9uLn6mr7sLNh2rb7RSop93kKqfNVAI1twhdR/8OkQJv
 nAYISuOx56hAzz/ATQIiPC7xCt8hC+2eSgDYaSKl29UPiE+7mcxSJRg6vSRNg95kqgdE
 NkBrkmfKP2p3BZrTB9m7J5c+I6qcnhv7F1eGJNKzswDYaSPUjZAUtic1VhYqI5u48JQL
 STsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=VDKz5xj4Ag35S/nd/UOQDRJeyFgs4jGAjtuHHsGBYig=;
 b=MW2/AjJedsI+El4g8fsh8IxKfMiBlZMMxJKssnJ8SZGcnnOUUcPDozs+NnvB5JTwoT
 bd6yCo89hUSn5E1nDIQgwmxcGmiz4OxkLVgPW/wNhTnWoZGVs16Yf4tLNT/W9cdKqcAm
 A82W5mpZfZMTfYDZlDFgM9TgYQJAfAHHnlz8gV3BndxXZG7WWx7O99Q4Dxaq3UuK1C7+
 lPX/+T82ELNFJSe+/w3tmjOg1QIhcYETAbLj2IdUlrPuN+AmsXK5k3TvDmaIwYlEEofZ
 o3NvnRoagu9Rp4SI09KrUv4j6GQaKAia52S1Y3StMEmDXByFmr5wyFJo/Z79fyRrtklO
 2hqg==
X-Gm-Message-State: ANhLgQ0cK7U8NeDsH9aq42WEQ+Qzghx+WXw8WA/kWfOr2W9JB+gUxkLE
 rFQwWoJQhz9gq/51YoquKTMxxw==
X-Google-Smtp-Source: ADFU+vtBFwaIl+FI+VAEuRXijAws3tpfe03tLc97TnjYUs5zM/v+9Px2Wwtc5QAcXeiSuo4fqRFnmg==
X-Received: by 2002:a1c:e442:: with SMTP id b63mr4476500wmh.174.1585300352260; 
 Fri, 27 Mar 2020 02:12:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e5sm7136666wru.92.2020.03.27.02.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 02:12:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 90FF11FF7E;
 Fri, 27 Mar 2020 09:12:30 +0000 (GMT)
References: <20200325092137.24020-1-kuhn.chenqun@huawei.com>
 <20200325092137.24020-2-kuhn.chenqun@huawei.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Chen Qun <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH 1/3] gdbstub: prevent uninitialized warning
In-reply-to: <20200325092137.24020-2-kuhn.chenqun@huawei.com>
Date: Fri, 27 Mar 2020 09:12:30 +0000
Message-ID: <874kuanou9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org, laurent@vivier.eu,
 qemu-devel@nongnu.org, Euler Robot <euler.robot@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Chen Qun <kuhn.chenqun@huawei.com> writes:

> According to the glib function requirements, we need initialise
>      the variable. Otherwise there will be compilation warnings:
>
> qemu/gdbstub.c: In function =E2=80=98handle_query_thread_extra=E2=80=99:
> /usr/include/glib-2.0/glib/glib-autocleanups.h:28:3: warning:
>  =E2=80=98cpu_name=E2=80=99 may be used uninitialized in this function [-=
Wmaybe-uninitialized]
>    g_free (*pp);
>    ^~~~~~~~~~~~
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>

Thanks,

I've pulled in a duplicate fix from:

  Message-Id: <20200326151407.25046-1-dplotnikov@virtuozzo.com>

and added your Reported-by's

> ---
> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
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

