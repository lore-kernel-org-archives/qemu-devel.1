Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3FBC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B79720722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MB2CTn2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B79720722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPR7-0006jy-Mq
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 11:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGPQX-0006EO-0F
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGPQV-0003BV-0w
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:55:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44223)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGPQU-0003AF-Q4
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584978941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H/Y0evudWYrHa3KtaSn/ya9VSReCg6vvubaw4Jr/GoQ=;
 b=MB2CTn2UMLZ+Q98sac1hfh9xxMWg5bgiOAyVdR64FoOCXnA1DxOyqB4mCGerzqATcodOJA
 i3SGYbxGfnSHcWmvnMQqBQicKF5+Y9F+vERNNl7H5YX2eDERwIQzfGuugz7x1Tu5C3iV2E
 lkf5KfGZigSJYs9flshDtyWE018hVTI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-DhjTdMuMNlWGQjHFYWjG0Q-1; Mon, 23 Mar 2020 11:55:38 -0400
X-MC-Unique: DhjTdMuMNlWGQjHFYWjG0Q-1
Received: by mail-wr1-f72.google.com with SMTP id e10so4808140wrm.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 08:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8Lszoxw25lP2CnL45qZpGSMh6SN2SwIybyVXjEvDtpY=;
 b=l2X80mi5Kh30GMiN7Y18WBBPRj8c/wVplKtanOU9H9wnldjny0Zq4rH1Bu7zfMoD06
 0t0G662Ve8gUaDsXehT8yC3cVeZLqsNh8e1Ox9E3nLkEWAkcJ7mCLfZcY2kECRH14TPa
 HIwW9ftnulBo0zVd6lqqRWTgU+zw2vK3qt1KCRsuR7K1s5aAsDvHPgo7ybgBJxP8Td+F
 U1A1spX7yWETfeszXv2jpMngklpHjwvdqFHVOA6O3cI0LYw+eiC0GdCQR6t40V0ALTyt
 EhZ6Xp2+UpvnvA7nLHKccBK99yoCe149gRMBiTboXW/oGrIJ9MW2vOajhvxtD4gXd4p8
 nd6g==
X-Gm-Message-State: ANhLgQ0nO+EqYX1NRrK0lElWeqjvVa7ttuzaoqKUG0I2ee0hHTh9dJH6
 8OZ5DKPckRecY/DP3jtUKnBZvdlXI3LabNvSjC1roQ83knDLYtKurUytwLdafS8RHo50rdrJKUZ
 SSC40YDzMVs4nSfA=
X-Received: by 2002:a5d:4b09:: with SMTP id v9mr29696179wrq.85.1584978937174; 
 Mon, 23 Mar 2020 08:55:37 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu8zbCuhMkaBK8yqmUnj8Wus46w4qa9LkWGkHYgSHS8L+eu2GlSWgrNERH0I2mcEuVYG6bETw==
X-Received: by 2002:a5d:4b09:: with SMTP id v9mr29696150wrq.85.1584978936885; 
 Mon, 23 Mar 2020 08:55:36 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id k3sm3399405wro.39.2020.03.23.08.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 08:55:36 -0700 (PDT)
Subject: Re: [PATCH v41 01/21] target/avr: Add outward facing interfaces and
 core CPU logic
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20200118191416.19934-1-mrolnik@gmail.com>
 <20200118191416.19934-2-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <80141c57-7fb7-6e95-4070-54f7cc23e166@redhat.com>
Date: Mon, 23 Mar 2020 16:55:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200118191416.19934-2-mrolnik@gmail.com>
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, richard.henderson@linaro.org,
 Sarah Harris <S.E.Harris@kent.ac.uk>, dovgaluk@ispras.ru, imammedo@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 1/18/20 8:13 PM, Michael Rolnik wrote:
> This includes:
> - CPU data structures
> - object model classes and functions
> - migration functions
> - GDB hooks
>=20
> Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
> Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   target/avr/cpu-param.h |  37 ++
>   target/avr/cpu-qom.h   |  54 +++
>   target/avr/cpu.h       | 258 +++++++++++++
>   target/avr/cpu.c       | 826 +++++++++++++++++++++++++++++++++++++++++
>   target/avr/gdbstub.c   |  84 +++++
>   target/avr/machine.c   | 121 ++++++
>   gdb-xml/avr-cpu.xml    |  49 +++
>   7 files changed, 1429 insertions(+)
>   create mode 100644 target/avr/cpu-param.h
>   create mode 100644 target/avr/cpu-qom.h
>   create mode 100644 target/avr/cpu.h
>   create mode 100644 target/avr/cpu.c
>   create mode 100644 target/avr/gdbstub.c
>   create mode 100644 target/avr/machine.c
>   create mode 100644 gdb-xml/avr-cpu.xml
>=20
[...]> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> new file mode 100644
> index 0000000000..c74c5106fe
> --- /dev/null
> +++ b/target/avr/cpu.c
> @@ -0,0 +1,826 @@
> +/*
> + * QEMU AVR CPU
> + *
> + * Copyright (c) 2019 Michael Rolnik
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/qemu-print.h"
> +#include "exec/exec-all.h"
> +#include "cpu.h"
> +#include "disas/dis-asm.h"
> +
> +static void avr_cpu_set_pc(CPUState *cs, vaddr value)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +
> +    cpu->env.pc_w =3D value / 2; /* internally PC points to words */
> +}
> +
> +static bool avr_cpu_has_work(CPUState *cs)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    return (cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_=
RESET))
> +            && cpu_interrupts_enabled(env);
> +}
> +
> +static void avr_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *=
tb)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    env->pc_w =3D tb->pc / 2; /* internally PC points to words */
> +}
> +
> +static void avr_cpu_reset(CPUState *cs)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +    AVRCPUClass *mcc =3D AVR_CPU_GET_CLASS(cpu);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    mcc->parent_reset(cs);
> +
> +    env->pc_w =3D 0;
> +    env->sregI =3D 1;
> +    env->sregC =3D 0;
> +    env->sregZ =3D 0;
> +    env->sregN =3D 0;
> +    env->sregV =3D 0;
> +    env->sregS =3D 0;
> +    env->sregH =3D 0;
> +    env->sregT =3D 0;
> +
> +    env->rampD =3D 0;
> +    env->rampX =3D 0;
> +    env->rampY =3D 0;
> +    env->rampZ =3D 0;
> +    env->eind =3D 0;
> +    env->sp =3D 0;
> +
> +    env->skip =3D 0;
> +
> +    memset(env->r, 0, sizeof(env->r));
> +
> +    tlb_flush(cs);

Why are you calling tlb_flush() here?

> +}


