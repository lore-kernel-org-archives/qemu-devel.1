Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D73C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 22:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9E420870
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 22:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfxOg+bv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9E420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia5nC-0008Vx-MV
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 17:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ia5m5-0007e4-7k
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:27:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ia5m2-0005GY-1j
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:27:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40021
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ia5m1-0005GG-QR
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 17:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574893621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cdqRmzUt0DkMu+cSMsPYiIDyhonTAbD5Xit+QDV0RdQ=;
 b=MfxOg+bvBfYChHi3vmDxyGXkdnplSr1MrH3PHeOkmOOZNW1euuJJDoynZItL0Gcl6rd8v4
 o2iJPFgIWwoumYRpcRowtYrNIFmg9r4bl1hESRk6WeVprDAeiEqwd+U5WnoW7OOO9MMlfI
 0qzsrz2/cbNh4laP8Om0wv90cAATVas=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-Xqi8OqOwNYanM3nKr4Fx1g-1; Wed, 27 Nov 2019 17:26:59 -0500
Received: by mail-wr1-f69.google.com with SMTP id l20so3005011wrc.13
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 14:26:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HV98Js/edGSsPEGRbdB38Av1Or+ExKuHwpTio3ivEVY=;
 b=IILPrPMLqX7tEbvPP4ZxUSQkBrS5iTISwV8/QWxNqDcvvWr/oIGyFmnjzwk8dC6LNL
 vFzfBdFyd3r0gCy9u6Gqups1OhENBtWBS3nfahKfT7yJc79kHBLFcfACmiErmu7v/KVa
 Er58+ReWSvaGPLsGE1LWh7zO4Kkby8BpDqruK0fOUjg9LS1XRnAQHy3GeM+StqoqCTpz
 cycyeEOmIrJIl/W4eXckazTZxnteEEMeDFTtcOrIvLU8i/lhJ1Niqi5s07cI7eQ6J633
 ae+WaKYJDL/WDwhNm7W8h2Y/OF42f0//NH1ecBdQKWEUfROfHq1uRSPtGfKPcypWLB+L
 4TqA==
X-Gm-Message-State: APjAAAXD2leX41bih8qFfWE1Ef7i9bXTrq+L9WxqaSYS2IjN4ZMAXKAd
 QWKiN0/HD9qxnRNnrQOolX83o0CZMs/e3L/MWjPRWdwaEu/2aTPpNQ3HKtL0tn4i8D7hvc7eWeC
 sylUinV6aEI20iHg=
X-Received: by 2002:a7b:c408:: with SMTP id k8mr6770911wmi.67.1574893618505;
 Wed, 27 Nov 2019 14:26:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqxd1Oj78xmDyIRAR3FMPjIJtKoOtNGv1fCFviIFk7LZRXW/ipd6Wipvz2OFzRYPVUP+LTMy3A==
X-Received: by 2002:a7b:c408:: with SMTP id k8mr6770895wmi.67.1574893618256;
 Wed, 27 Nov 2019 14:26:58 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id d67sm8115121wmd.13.2019.11.27.14.26.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2019 14:26:57 -0800 (PST)
Subject: Re: [PATCH v37 02/17] target/avr: Add instruction helpers
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-3-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5cd26af6-abb0-435e-e4b0-13152ba1c3db@redhat.com>
Date: Wed, 27 Nov 2019 23:26:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191127175257.23480-3-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: Xqi8OqOwNYanM3nKr4Fx1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 dovgaluk@ispras.ru, imammedo@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/27/19 6:52 PM, Michael Rolnik wrote:
> Stubs for unimplemented instructions and helpers for instructions that ne=
ed to interact with QEMU.
> SPM and WDR are unimplemented because they require emulation of complex p=
eripherals.
> The implementation of SLEEP is very limited due to the lack of peripheral=
s to generate wake interrupts.
> Memory access instructions are implemented here because some address rang=
es actually refer to CPU registers.
>=20
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   target/avr/helper.h |  29 ++++
>   target/avr/helper.c | 354 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 383 insertions(+)
>   create mode 100644 target/avr/helper.h
>   create mode 100644 target/avr/helper.c
>=20
> diff --git a/target/avr/helper.h b/target/avr/helper.h
> new file mode 100644
> index 0000000000..bf087504a8
> --- /dev/null
> +++ b/target/avr/helper.h
> @@ -0,0 +1,29 @@
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
> +DEF_HELPER_1(wdr, void, env)
> +DEF_HELPER_1(debug, void, env)
> +DEF_HELPER_1(break, void, env)
> +DEF_HELPER_1(sleep, void, env)
> +DEF_HELPER_1(unsupported, void, env)
> +DEF_HELPER_3(outb, void, env, i32, i32)
> +DEF_HELPER_2(inb, tl, env, i32)
> +DEF_HELPER_3(fullwr, void, env, i32, i32)
> +DEF_HELPER_2(fullrd, tl, env, i32)
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> new file mode 100644
> index 0000000000..f1939bd5a7
> --- /dev/null
> +++ b/target/avr/helper.c
> @@ -0,0 +1,354 @@
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
> +
> +#include "cpu.h"
> +#include "hw/irq.h"

Nitpicking again, the previous include doesn't seem used.

> +#include "hw/sysbus.h"
> +#include "sysemu/sysemu.h"
> +#include "exec/exec-all.h"
> +#include "exec/cpu_ldst.h"
> +#include "exec/helper-proto.h"
> +#include "exec/ioport.h"
> +#include "qemu/host-utils.h"
> +#include "qemu/error-report.h"
> +
> +bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> +{
> +    bool ret =3D false;
> +    CPUClass *cc =3D CPU_GET_CLASS(cs);
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    if (interrupt_request & CPU_INTERRUPT_RESET) {
> +        if (cpu_interrupts_enabled(env)) {
> +            cs->exception_index =3D EXCP_RESET;
> +            cc->do_interrupt(cs);
> +
> +            cs->interrupt_request &=3D ~CPU_INTERRUPT_RESET;
> +
> +            ret =3D true;
> +        }
> +    }
> +    if (interrupt_request & CPU_INTERRUPT_HARD) {
> +        if (cpu_interrupts_enabled(env) && env->intsrc !=3D 0) {
> +            int index =3D ctz32(env->intsrc);
> +            cs->exception_index =3D EXCP_INT(index);
> +            cc->do_interrupt(cs);
> +
> +            env->intsrc &=3D env->intsrc - 1; /* clear the interrupt */
> +            cs->interrupt_request &=3D ~CPU_INTERRUPT_HARD;
> +
> +            ret =3D true;
> +        }
> +    }
> +    return ret;
> +}
> +
> +void avr_cpu_do_interrupt(CPUState *cs)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(cs);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    uint32_t ret =3D env->pc_w;
> +    int vector =3D 0;
> +    int size =3D avr_feature(env, AVR_FEATURE_JMP_CALL) ? 2 : 1;
> +    int base =3D 0;
> +
> +    if (cs->exception_index =3D=3D EXCP_RESET) {
> +        vector =3D 0;
> +    } else if (env->intsrc !=3D 0) {
> +        vector =3D ctz32(env->intsrc) + 1;
> +    }
> +
> +    if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
> +        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
> +        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
> +        cpu_stb_data(env, env->sp--, (ret & 0xff0000) >> 16);
> +    } else if (avr_feature(env, AVR_FEATURE_2_BYTE_PC)) {
> +        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
> +        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
> +    } else {
> +        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
> +    }
> +
> +    env->pc_w =3D base + vector * size;
> +    env->sregI =3D 0; /* clear Global Interrupt Flag */
> +
> +    cs->exception_index =3D -1;
> +}
[...]


