Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C5AC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0EDD20578
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JipiE4mC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EDD20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmgQ-00037P-UN
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 06:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jHmfW-0002JZ-65
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jHmfV-0002in-11
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:56:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34877)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jHmfU-0002ha-TC
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585306612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A6amK/Sa2qp1xeSx97bUS8GAL9a43ynVBrBIMtp6598=;
 b=JipiE4mCsJ1iGfcHcyNhC+ecDxXp5EUKvvW1DBnth7VYqH+N/E/V6AG4TOc+6jJBqD/gv/
 JqpkEG1HW00J4hHs+gSBNbQEL4oluv/GAS8gwddxrmMWyITrc/fkQ7VURKwN3Y8oqphpdH
 DhBIwILYiYrsSkRuJZubxRTY6xgInh4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-RmIyyl7VME-hx3Fccd8K3g-1; Fri, 27 Mar 2020 06:56:50 -0400
X-MC-Unique: RmIyyl7VME-hx3Fccd8K3g-1
Received: by mail-ed1-f72.google.com with SMTP id n15so3686825edq.6
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 03:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o/ZrKlvJX0teutEm3jx6bETFz0QXQjIF4KqVkdYfUbU=;
 b=uJn2WfqniWRQ/9OP0jlXb+NwXeZwSCcEnIDVHpam/4U0F8crrXdBoOINNzs6Xzmewf
 i6omvqT5bqT8R68Xp83WrMk8UAzejuh3xlDuyfJ+Z+s0cW3e7AvLe2n+prGjw7ySxoJY
 NidKeDrcpWNNl6lnUPv7lPVOAzQSSqUl6kVN15HwqZgfMlvDKJj33imHvihAB6tGUx8Q
 Z9JsmuQ6zob9OgyL/1VFUo1NbHDPgC3/oLpI32eBdp9NdrInqmdtNJEsFo6zT4v/9GwR
 fhyu4oh0iOx9tBqF+lSq9ffMAlKmEIbkDDNus+FbNwUobW3ZV8/RIywxmKhWyVyCWP7P
 2usA==
X-Gm-Message-State: ANhLgQ335447v212L/YLyXrnMqU1QIp+DWqqabCDtx9/rTSUAUuL+LEe
 AefWcY81yxqwA7DIvRyNAXjT1lEqnu5Qz9iMdyLumFAYXaa45XT1sk5qZ+Reek+LO5qEXdVO8jr
 6vDBDV5DD+dRTSJI=
X-Received: by 2002:a17:906:d8b0:: with SMTP id
 qc16mr12198136ejb.64.1585306609593; 
 Fri, 27 Mar 2020 03:56:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vthgXJaqTdex4hGZorLMyJV5Ihjw3XQPP3Y3LNIOJ15iQKtJ4Mp4dQhft8OO4uUamgSXQvZdw==
X-Received: by 2002:a17:906:d8b0:: with SMTP id
 qc16mr12198121ejb.64.1585306609343; 
 Fri, 27 Mar 2020 03:56:49 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id w4sm697058ejz.44.2020.03.27.03.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 03:56:48 -0700 (PDT)
Subject: Re: [PATCH v1 7/7] gdbstub: fix compiler complaining
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200327094945.23768-1-alex.bennee@linaro.org>
 <20200327094945.23768-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <25bba445-f6a0-d73e-e06b-142af14c51a1@redhat.com>
Date: Fri, 27 Mar 2020 11:56:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200327094945.23768-8-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Chen Qun <kuhn.chenqun@huawei.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/27/20 10:49 AM, Alex Benn=C3=A9e wrote:
> From: Denis Plotnikov <dplotnikov@virtuozzo.com>
>=20
>      ./gdbstub.c: In function =E2=80=98handle_query_thread_extra=E2=80=99=
:
>          /usr/include/glib-2.0/glib/glib-autocleanups.h:28:10:
>      error: =E2=80=98cpu_name=E2=80=99 may be used uninitialized in this =
function
>      [-Werror=3Dmaybe-uninitialized]
>          g_free (*pp);
>                 ^
>      ./gdbstub.c:2063:26: note: =E2=80=98cpu_name=E2=80=99 was declared h=
ere
>          g_autofree char *cpu_name;
>                           ^
>      cc1: all warnings being treated as errors
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Message-Id: <20200326151407.25046-1-dplotnikov@virtuozzo.com>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Reported-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   gdbstub.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index 013fb1ac0f1..171e1509509 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2060,8 +2060,8 @@ static void handle_query_thread_extra(GdbCmdContext=
 *gdb_ctx, void *user_ctx)
>           /* Print the CPU model and name in multiprocess mode */
>           ObjectClass *oc =3D object_get_class(OBJECT(cpu));
>           const char *cpu_model =3D object_class_get_name(oc);
> -        g_autofree char *cpu_name;
> -        cpu_name  =3D object_get_canonical_path_component(OBJECT(cpu));
> +        g_autofree char *cpu_name =3D
> +            object_get_canonical_path_component(OBJECT(cpu));
>           g_string_printf(rs, "%s %s [%s]", cpu_model, cpu_name,
>                           cpu->halted ? "halted " : "running");
>       } else {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


