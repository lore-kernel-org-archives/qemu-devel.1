Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16233C33C9E
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 12:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DC820661
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 12:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAFv0W0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DC820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixrt8-0001Jv-RI
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 07:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixrsC-0000sj-9h
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixrs9-0000Dk-3S
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:27:40 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:46434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ixrs8-00009w-P7
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:27:37 -0500
Received: by mail-ot1-x32b.google.com with SMTP id g64so9188919otb.13
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 04:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=3G8sx6Aovki6sj5e2FSivffVEakMXmu9pc2VfG2UROk=;
 b=oAFv0W0Nyw42MAQjUYKcP+i+NPgfsNkSDz732aqFg9V2oqnV+uHBHj8PjRCFkyzeqx
 IrdEgkGFFD9JWOi2n8pt8oGZ0kc6fzOWpC0vEHKygtC/FYgTPGwyKSsv4OB5pduFM/Hc
 1KQVCOBHLkUfVE04oY4qM1aFZfIBO27+jPjb6FEHK/L12s66qQrbgAPPM/K3vMFB544y
 jy5nvbRse7A0s2WVcRJCLaM5ajiRnCQ4RiTGw3JSeRSD+GNEvdXOZa57Tmd4a+E9Jc4f
 7zCR8HSMiHOCN5NkE1+og+ELV0cgi+Nnx5/HsxHl2m2Gs2O8/iwzltQi70ObybfLJnzj
 d5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=3G8sx6Aovki6sj5e2FSivffVEakMXmu9pc2VfG2UROk=;
 b=m9TDinUhKTmO+jIzSpFlbuXkrkYkZK93toez6KuCaPUjZy4lHBe0vJD+8cHjFOGM7X
 P+JtZDG3QVREAWqlcJnkR3ZQSdJRu43dEEuRTByOOjxKKj2nO+E587dEGA1M4bD23oem
 lOQQAcAgfaoS9kscSiS9Fw0j16xONcKKFkBV+DLnCdY6QHcOowfyfqOQz6f6EHoB+SNr
 SpLpjl1cgQwf/xHfy3835FNv2ezzQYkKlHnpbU9DVWGgixaEkHG2ZkO2a8glvcSsRPAD
 SIbpZDnCQP3vd4G3cyp14J0/pH7z++/9PRKVeHLUK4KlJFj/frBYm6veBTvCe/cVOK0h
 zRzw==
X-Gm-Message-State: APjAAAVSSdNvwti9RF+0qgb+NaIWzo7rqG0hx1vI+qrgOsY4yj7o+Emf
 eD9g0XC+2M/nZC+vPCCYWPhdbx9PKEJ+1j6nd2Q=
X-Google-Smtp-Source: APXvYqylFqVC9pHQWaT4ziS9JAUbeR4CVdeUC38+muMq9KRm6x17uMBZkGmtHIsu5TwPHj1wJloT24PDY+NbwaATE1Y=
X-Received: by 2002:a05:6830:12c3:: with SMTP id
 a3mr11585966otq.341.1580560055338; 
 Sat, 01 Feb 2020 04:27:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sat, 1 Feb 2020 04:27:34 -0800 (PST)
In-Reply-To: <1580428993-4767-8-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-8-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 1 Feb 2020 13:27:34 +0100
Message-ID: <CAL1e-=hoOVaN=amBosiCkwOa-TH6pSdg_GZrPpmuWEiVSRXOfw@mail.gmail.com>
Subject: Re: [PATCH rc4 07/29] target/avr: Add instruction helpers
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: multipart/alternative; boundary="000000000000a50910059d82d0f8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a50910059d82d0f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, January 31, 2020, Aleksandar Markovic <
aleksandar.markovic@rt-rk.com> wrote:

> From: Michael Rolnik <mrolnik@gmail.com>
>
> Add helpers for instructions that need to interact with QEMU. Also,
> add stubs for unimplemented instructions. Instructions SPM and WDR
> are left unimplemented because they require emulation of complex
> peripherals. The implementation of instruction SLEEP is very limited
> due to the lack of peripherals to generate wake interrupts. Memory
> access instructions are implemented here because some address ranges
> actually refer to CPU registers.
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> ---


Hello, Michael.

Regarding this and patches 8-14, I did not find any functional
inaccuracies. "avrtiny" issues (lack of support for cores with fewer
registers) are agreed to be addressed later on, some time after the merge,
as not critical for the rest of series.

I had, and still have some concerns about missing comments and code
readibility in general (details can be seen in my previuos reviews). I have
some concerns about lack of usage of enum AVRFeature in some functions
(instead of int). I have some concerns abuot functions organization too.

But, all of these concerns are not related to the final functionality. In
my view, it is even too risky to address them at this stage of the series.
They can be easily addressed after the series merge.

Therefore:

For patches 7-14:

Reviewed-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>


>  target/avr/helper.c | 203 ++++++++++++++++++++++++++++++
> ++++++++++++++++++++++
>  target/avr/helper.h |  29 ++++++++
>  2 files changed, 232 insertions(+)
>  create mode 100644 target/avr/helper.h
>
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> index 354def2..c582312 100644
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -137,3 +137,206 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address,
> int size,
>
>      return true;
>  }
> +
> +/*
> + *  helpers
> + */
> +
> +void helper_sleep(CPUAVRState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +
> +    cs->exception_index =3D EXCP_HLT;
> +    cpu_loop_exit(cs);
> +}
> +
> +void helper_unsupported(CPUAVRState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +
> +    /*
> +     *  I count not find what happens on the real platform, so
> +     *  it's EXCP_DEBUG for meanwhile
> +     */
> +    cs->exception_index =3D EXCP_DEBUG;
> +    if (qemu_loglevel_mask(LOG_UNIMP)) {
> +        qemu_log("UNSUPPORTED\n");
> +        cpu_dump_state(cs, stderr, 0);
> +    }
> +    cpu_loop_exit(cs);
> +}
> +
> +void helper_debug(CPUAVRState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +
> +    cs->exception_index =3D EXCP_DEBUG;
> +    cpu_loop_exit(cs);
> +}
> +
> +void helper_break(CPUAVRState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +
> +    cs->exception_index =3D EXCP_DEBUG;
> +    cpu_loop_exit(cs);
> +}
> +
> +void helper_wdr(CPUAVRState *env)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +
> +    /* WD is not implemented yet, placeholder */
> +    cs->exception_index =3D EXCP_DEBUG;
> +    cpu_loop_exit(cs);
> +}
> +
> +/*
> + * This function implements IN instruction
> + *
> + * It does the following
> + * a.  if an IO register belongs to CPU, its value is read and returned
> + * b.  otherwise io address is translated to mem address and physical
> memory
> + *     is read.
> + * c.  it caches the value for sake of SBI, SBIC, SBIS & CBI
> implementation
> + *
> + */
> +target_ulong helper_inb(CPUAVRState *env, uint32_t port)
> +{
> +    target_ulong data =3D 0;
> +
> +    switch (port) {
> +    case 0x38: /* RAMPD */
> +        data =3D 0xff & (env->rampD >> 16);
> +        break;
> +    case 0x39: /* RAMPX */
> +        data =3D 0xff & (env->rampX >> 16);
> +        break;
> +    case 0x3a: /* RAMPY */
> +        data =3D 0xff & (env->rampY >> 16);
> +        break;
> +    case 0x3b: /* RAMPZ */
> +        data =3D 0xff & (env->rampZ >> 16);
> +        break;
> +    case 0x3c: /* EIND */
> +        data =3D 0xff & (env->eind >> 16);
> +        break;
> +    case 0x3d: /* SPL */
> +        data =3D env->sp & 0x00ff;
> +        break;
> +    case 0x3e: /* SPH */
> +        data =3D env->sp >> 8;
> +        break;
> +    case 0x3f: /* SREG */
> +        data =3D cpu_get_sreg(env);
> +        break;
> +    default:
> +        /* not a special register, pass to normal memory access */
> +        cpu_physical_memory_read(OFFSET_IO_REGISTERS + port, &data, 1);
> +    }
> +
> +    return data;
> +}
> +
> +/*
> + *  This function implements OUT instruction
> + *
> + *  It does the following
> + *  a.  if an IO register belongs to CPU, its value is written into the
> register
> + *  b.  otherwise io address is translated to mem address and physical
> memory
> + *      is written.
> + *  c.  it caches the value for sake of SBI, SBIC, SBIS & CBI
> implementation
> + *
> + */
> +void helper_outb(CPUAVRState *env, uint32_t port, uint32_t data)
> +{
> +    data &=3D 0x000000ff;
> +
> +    switch (port) {
> +    case 0x38: /* RAMPD */
> +        if (avr_feature(env, AVR_FEATURE_RAMPD)) {
> +            env->rampD =3D (data & 0xff) << 16;
> +        }
> +        break;
> +    case 0x39: /* RAMPX */
> +        if (avr_feature(env, AVR_FEATURE_RAMPX)) {
> +            env->rampX =3D (data & 0xff) << 16;
> +        }
> +        break;
> +    case 0x3a: /* RAMPY */
> +        if (avr_feature(env, AVR_FEATURE_RAMPY)) {
> +            env->rampY =3D (data & 0xff) << 16;
> +        }
> +        break;
> +    case 0x3b: /* RAMPZ */
> +        if (avr_feature(env, AVR_FEATURE_RAMPZ)) {
> +            env->rampZ =3D (data & 0xff) << 16;
> +        }
> +        break;
> +    case 0x3c: /* EIDN */
> +        env->eind =3D (data & 0xff) << 16;
> +        break;
> +    case 0x3d: /* SPL */
> +        env->sp =3D (env->sp & 0xff00) | (data);
> +        break;
> +    case 0x3e: /* SPH */
> +        if (avr_feature(env, AVR_FEATURE_2_BYTE_SP)) {
> +            env->sp =3D (env->sp & 0x00ff) | (data << 8);
> +        }
> +        break;
> +    case 0x3f: /* SREG */
> +        cpu_set_sreg(env, data);
> +        break;
> +    default:
> +        /* not a special register, pass to normal memory access */
> +        cpu_physical_memory_write(OFFSET_IO_REGISTERS + port, &data, 1);
> +    }
> +}
> +
> +/*
> + *  this function implements LD instruction when there is a posibility t=
o
> read
> + *  from a CPU register
> + */
> +target_ulong helper_fullrd(CPUAVRState *env, uint32_t addr)
> +{
> +    uint8_t data;
> +
> +    env->fullacc =3D false;
> +
> +    if (addr < NUMBER_OF_CPU_REGISTERS) {
> +        /* CPU registers */
> +        data =3D env->r[addr];
> +    } else if (addr < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTERS) =
{
> +        /* IO registers */
> +        data =3D helper_inb(env, addr - NUMBER_OF_CPU_REGISTERS);
> +    } else {
> +        /* memory */
> +        cpu_physical_memory_read(OFFSET_DATA + addr, &data, 1);
> +    }
> +    return data;
> +}
> +
> +/*
> + *  this function implements ST instruction when there is a posibility t=
o
> write
> + *  into a CPU register
> + */
> +void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
> +{
> +    env->fullacc =3D false;
> +
> +    /* Following logic assumes this: */
> +    assert(OFFSET_CPU_REGISTERS =3D=3D OFFSET_DATA);
> +    assert(OFFSET_IO_REGISTERS =3D=3D OFFSET_CPU_REGISTERS +
> +            NUMBER_OF_CPU_REGISTERS);
> +
> +    if (addr < NUMBER_OF_CPU_REGISTERS) {
> +        /* CPU registers */
> +        env->r[addr] =3D data;
> +    } else if (addr < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTERS) =
{
> +        /* IO registers */
> +        helper_outb(env, addr - NUMBER_OF_CPU_REGISTERS, data);
> +    } else {
> +        /* memory */
> +        cpu_physical_memory_write(OFFSET_DATA + addr, &data, 1);
> +    }
> +}
> diff --git a/target/avr/helper.h b/target/avr/helper.h
> new file mode 100644
> index 0000000..bf08750
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
> --
> 2.7.4
>
>

--000000000000a50910059d82d0f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, January 31, 2020, Aleksandar Markovic &lt;<a href=3D"mai=
lto:aleksandar.markovic@rt-rk.com">aleksandar.markovic@rt-rk.com</a>&gt; wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">From: Michael Rolnik &lt;<a href=3D"=
mailto:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt;<br>
<br>
Add helpers for instructions that need to interact with QEMU. Also,<br>
add stubs for unimplemented instructions. Instructions SPM and WDR<br>
are left unimplemented because they require emulation of complex<br>
peripherals. The implementation of instruction SLEEP is very limited<br>
due to the lack of peripherals to generate wake interrupts. Memory<br>
access instructions are implemented here because some address ranges<br>
actually refer to CPU registers.<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrol=
nik@gmail.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com">philmd@redhat.com</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org">richard.henderson@linaro.org</a>&gt;<br>
Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@=
gmail.com">aleksandar.m.mail@gmail.com</a>&gt;<br>
---</blockquote><div><br></div><div>Hello, Michael.</div><div><br></div><di=
v>Regarding this and patches 8-14, I did not find any functional inaccuraci=
es. &quot;avrtiny&quot; issues (lack of support for cores with fewer regist=
ers) are agreed to be addressed later on, some time after the merge, as not=
 critical for the rest of series.</div><div><br></div><div>I had, and still=
 have some concerns about missing comments and code readibility in general =
(details can be seen in my previuos reviews). I have some concerns about la=
ck of usage of enum AVRFeature in some functions (instead of int). I have s=
ome concerns abuot functions organization too.</div><div><br></div><div>But=
, all of these concerns are not related to the final functionality. In my v=
iew, it is even too risky to address them at this stage of the series. They=
 can be easily addressed after the series merge.</div><div><br></div><div>T=
herefore:</div><div><br></div><div>For patches 7-14:</div><div><br></div><d=
iv>Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail=
@gmail.com">aleksandar.m.mail@gmail.com</a>&gt;</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
=C2=A0target/avr/helper.c | 203 ++++++++++++++++++++++++++++++<wbr>++++++++=
++++++++++++++<br>
=C2=A0target/avr/helper.h |=C2=A0 29 ++++++++<br>
=C2=A02 files changed, 232 insertions(+)<br>
=C2=A0create mode 100644 target/avr/helper.h<br>
<br>
diff --git a/target/avr/helper.c b/target/avr/helper.c<br>
index 354def2..c582312 100644<br>
--- a/target/avr/helper.c<br>
+++ b/target/avr/helper.c<br>
@@ -137,3 +137,206 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, in=
t size,<br>
<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
+<br>
+/*<br>
+ *=C2=A0 helpers<br>
+ */<br>
+<br>
+void helper_sleep(CPUAVRState *env)<br>
+{<br>
+=C2=A0 =C2=A0 CPUState *cs =3D env_cpu(env);<br>
+<br>
+=C2=A0 =C2=A0 cs-&gt;exception_index =3D EXCP_HLT;<br>
+=C2=A0 =C2=A0 cpu_loop_exit(cs);<br>
+}<br>
+<br>
+void helper_unsupported(CPUAVRState *env)<br>
+{<br>
+=C2=A0 =C2=A0 CPUState *cs =3D env_cpu(env);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 I count not find what happens on the real plat=
form, so<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 it&#39;s EXCP_DEBUG for meanwhile<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 cs-&gt;exception_index =3D EXCP_DEBUG;<br>
+=C2=A0 =C2=A0 if (qemu_loglevel_mask(LOG_UNIMP)<wbr>) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;UNSUPPORTED\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_dump_state(cs, stderr, 0);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 cpu_loop_exit(cs);<br>
+}<br>
+<br>
+void helper_debug(CPUAVRState *env)<br>
+{<br>
+=C2=A0 =C2=A0 CPUState *cs =3D env_cpu(env);<br>
+<br>
+=C2=A0 =C2=A0 cs-&gt;exception_index =3D EXCP_DEBUG;<br>
+=C2=A0 =C2=A0 cpu_loop_exit(cs);<br>
+}<br>
+<br>
+void helper_break(CPUAVRState *env)<br>
+{<br>
+=C2=A0 =C2=A0 CPUState *cs =3D env_cpu(env);<br>
+<br>
+=C2=A0 =C2=A0 cs-&gt;exception_index =3D EXCP_DEBUG;<br>
+=C2=A0 =C2=A0 cpu_loop_exit(cs);<br>
+}<br>
+<br>
+void helper_wdr(CPUAVRState *env)<br>
+{<br>
+=C2=A0 =C2=A0 CPUState *cs =3D env_cpu(env);<br>
+<br>
+=C2=A0 =C2=A0 /* WD is not implemented yet, placeholder */<br>
+=C2=A0 =C2=A0 cs-&gt;exception_index =3D EXCP_DEBUG;<br>
+=C2=A0 =C2=A0 cpu_loop_exit(cs);<br>
+}<br>
+<br>
+/*<br>
+ * This function implements IN instruction<br>
+ *<br>
+ * It does the following<br>
+ * a.=C2=A0 if an IO register belongs to CPU, its value is read and return=
ed<br>
+ * b.=C2=A0 otherwise io address is translated to mem address and physical=
 memory<br>
+ *=C2=A0 =C2=A0 =C2=A0is read.<br>
+ * c.=C2=A0 it caches the value for sake of SBI, SBIC, SBIS &amp; CBI impl=
ementation<br>
+ *<br>
+ */<br>
+target_ulong helper_inb(CPUAVRState *env, uint32_t port)<br>
+{<br>
+=C2=A0 =C2=A0 target_ulong data =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 switch (port) {<br>
+=C2=A0 =C2=A0 case 0x38: /* RAMPD */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D 0xff &amp; (env-&gt;rampD &gt;&gt; 16=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x39: /* RAMPX */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D 0xff &amp; (env-&gt;rampX &gt;&gt; 16=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x3a: /* RAMPY */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D 0xff &amp; (env-&gt;rampY &gt;&gt; 16=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x3b: /* RAMPZ */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D 0xff &amp; (env-&gt;rampZ &gt;&gt; 16=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x3c: /* EIND */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D 0xff &amp; (env-&gt;eind &gt;&gt; 16)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x3d: /* SPL */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D env-&gt;sp &amp; 0x00ff;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x3e: /* SPH */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D env-&gt;sp &gt;&gt; 8;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x3f: /* SREG */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D cpu_get_sreg(env);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* not a special register, pass to normal memo=
ry access */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_read(<wbr>OFFSET_IO_REGIST=
ERS + port, &amp;data, 1);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return data;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 This function implements OUT instruction<br>
+ *<br>
+ *=C2=A0 It does the following<br>
+ *=C2=A0 a.=C2=A0 if an IO register belongs to CPU, its value is written i=
nto the register<br>
+ *=C2=A0 b.=C2=A0 otherwise io address is translated to mem address and ph=
ysical memory<br>
+ *=C2=A0 =C2=A0 =C2=A0 is written.<br>
+ *=C2=A0 c.=C2=A0 it caches the value for sake of SBI, SBIC, SBIS &amp; CB=
I implementation<br>
+ *<br>
+ */<br>
+void helper_outb(CPUAVRState *env, uint32_t port, uint32_t data)<br>
+{<br>
+=C2=A0 =C2=A0 data &amp;=3D 0x000000ff;<br>
+<br>
+=C2=A0 =C2=A0 switch (port) {<br>
+=C2=A0 =C2=A0 case 0x38: /* RAMPD */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (avr_feature(env, AVR_FEATURE_RAMPD)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;rampD =3D (data &amp; 0x=
ff) &lt;&lt; 16;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x39: /* RAMPX */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (avr_feature(env, AVR_FEATURE_RAMPX)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;rampX =3D (data &amp; 0x=
ff) &lt;&lt; 16;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x3a: /* RAMPY */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (avr_feature(env, AVR_FEATURE_RAMPY)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;rampY =3D (data &amp; 0x=
ff) &lt;&lt; 16;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x3b: /* RAMPZ */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (avr_feature(env, AVR_FEATURE_RAMPZ)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;rampZ =3D (data &amp; 0x=
ff) &lt;&lt; 16;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x3c: /* EIDN */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;eind =3D (data &amp; 0xff) &lt;&lt; 16=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x3d: /* SPL */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sp =3D (env-&gt;sp &amp; 0xff00) | (da=
ta);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x3e: /* SPH */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (avr_feature(env, AVR_FEATURE_2_BYTE_SP)) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;sp =3D (env-&gt;sp &amp;=
 0x00ff) | (data &lt;&lt; 8);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x3f: /* SREG */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_set_sreg(env, data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* not a special register, pass to normal memo=
ry access */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_write(<wbr>OFFSET_IO_REGIS=
TERS + port, &amp;data, 1);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 this function implements LD instruction when there is a posibilit=
y to read<br>
+ *=C2=A0 from a CPU register<br>
+ */<br>
+target_ulong helper_fullrd(CPUAVRState *env, uint32_t addr)<br>
+{<br>
+=C2=A0 =C2=A0 uint8_t data;<br>
+<br>
+=C2=A0 =C2=A0 env-&gt;fullacc =3D false;<br>
+<br>
+=C2=A0 =C2=A0 if (addr &lt; NUMBER_OF_CPU_REGISTERS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* CPU registers */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D env-&gt;r[addr];<br>
+=C2=A0 =C2=A0 } else if (addr &lt; NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_=
REGISTERS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* IO registers */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D helper_inb(env, addr - NUMBER_OF_CPU_=
REGISTERS);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* memory */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_read(<wbr>OFFSET_DATA + ad=
dr, &amp;data, 1);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return data;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 this function implements ST instruction when there is a posibilit=
y to write<br>
+ *=C2=A0 into a CPU register<br>
+ */<br>
+void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)<br>
+{<br>
+=C2=A0 =C2=A0 env-&gt;fullacc =3D false;<br>
+<br>
+=C2=A0 =C2=A0 /* Following logic assumes this: */<br>
+=C2=A0 =C2=A0 assert(OFFSET_CPU_REGISTERS =3D=3D OFFSET_DATA);<br>
+=C2=A0 =C2=A0 assert(OFFSET_IO_REGISTERS =3D=3D OFFSET_CPU_REGISTERS +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NUMBER_OF_CPU_REGISTERS);<br>
+<br>
+=C2=A0 =C2=A0 if (addr &lt; NUMBER_OF_CPU_REGISTERS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* CPU registers */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;r[addr] =3D data;<br>
+=C2=A0 =C2=A0 } else if (addr &lt; NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_=
REGISTERS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* IO registers */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 helper_outb(env, addr - NUMBER_OF_CPU_REGISTER=
S, data);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* memory */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_write(<wbr>OFFSET_DATA + a=
ddr, &amp;data, 1);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
diff --git a/target/avr/helper.h b/target/avr/helper.h<br>
new file mode 100644<br>
index 0000000..bf08750<br>
--- /dev/null<br>
+++ b/target/avr/helper.h<br>
@@ -0,0 +1,29 @@<br>
+/*<br>
+ * QEMU AVR CPU<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see<br>
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" target=3D"_bl=
ank">http://www.gnu.org/licenses/<wbr>lgpl-2.1.html</a>&gt;<br>
+ */<br>
+<br>
+DEF_HELPER_1(wdr, void, env)<br>
+DEF_HELPER_1(debug, void, env)<br>
+DEF_HELPER_1(break, void, env)<br>
+DEF_HELPER_1(sleep, void, env)<br>
+DEF_HELPER_1(unsupported, void, env)<br>
+DEF_HELPER_3(outb, void, env, i32, i32)<br>
+DEF_HELPER_2(inb, tl, env, i32)<br>
+DEF_HELPER_3(fullwr, void, env, i32, i32)<br>
+DEF_HELPER_2(fullrd, tl, env, i32)<br>
-- <br>
2.7.4<br>
<br>
</blockquote>

--000000000000a50910059d82d0f8--

