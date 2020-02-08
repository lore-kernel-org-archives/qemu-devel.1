Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878E0C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 07:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68B221741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 07:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRihGYeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68B221741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0KHO-0002Cd-Tk
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 02:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j0KGa-0001h6-GH
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 02:11:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j0KGY-0003sS-9B
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 02:11:00 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:37459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j0KGY-0003rw-30
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 02:10:58 -0500
Received: by mail-oi1-x230.google.com with SMTP id q84so4382166oic.4
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 23:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=LdLVbQrJkjlIQ5aslmy74btYxGkQrcZS1swLArxBh/Q=;
 b=dRihGYeArDsJYwObgcZuWV38EyYgZaqd2Q8CfYfQo6b/LwVyg4s73wwdMVpUBNkvsX
 zuqWdOLqIIC1wksNPi726yZcrmCrHtiN0krYMZmIaYMNtsoAm+yvR6gsu2nVe7VR7LYj
 ny1Pd+7MbkRNZip361pV+jj+WemK+0ydECrUKPJHwUH2U9oc6Apb4k2Qwuqm+5ot7OQU
 pEBbyWaSl4Vb8QnpkXohVnX2oIFZ4J4tQ6ABG1GC296TTEtpaA0RHEylDogK6zjr8+D6
 jLMvHFnx3/RRrmrRddPU1TWExW+WWPPhEyAImTLvlaJhDO/xQNkLq/3ifRMyeMENqrfw
 +RXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=LdLVbQrJkjlIQ5aslmy74btYxGkQrcZS1swLArxBh/Q=;
 b=gswiIkBTHrEPnXnNijrG68w4SEagtOZ5441uYs6cJD1t6MwTqn8B8egBxxSqEh0DGk
 l+Fb4iyRDtdVmjs8cLymyysUoJaXKPR9Xbs0IpfpHDHODsJkRbEEKcfvjsWJf8K1p9Il
 E7qY4M3S+lKcV6/mJGcOfqP2Vhf429Zg33v1expwhS9dxf0XV/zDYDWgqLaf4ahaWeG2
 oPLSoWkDKxqNL33Ofswe4+FBdQ+JIqtJDWtXAwh5zORohX/KIQJNjerPr6bo5aUgfLtk
 IIU2A6FlaVGl0Rvcfssiw6V7ZxjxWOALkGmWHIcJ9dUCdk+XplwvnT4E+IT9n/zYNl80
 8BlQ==
X-Gm-Message-State: APjAAAXD3GDrupOk4U7R4+vEWaHtkeiVbff+ECzMh6rlKPWIY0YJ3QGG
 VxTDnrIgR9p8PX+56UI5R2JNkv2bS5Ra0ot9cjE=
X-Google-Smtp-Source: APXvYqxKfcXXOQUs62AcMHw0V9FmSk088xQkZ2E8q9NaAzxOoXDf/esiWqMsmgu9czStAKObn2MZqqDAD0/zLgegW04=
X-Received: by 2002:aca:5248:: with SMTP id g69mr4512714oib.106.1581145856702; 
 Fri, 07 Feb 2020 23:10:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Fri, 7 Feb 2020 23:10:56 -0800 (PST)
In-Reply-To: <20200207112338.27754-1-philmd@redhat.com>
References: <1581040680-308-9-git-send-email-aleksandar.markovic@rt-rk.com>
 <20200207112338.27754-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 8 Feb 2020 08:10:56 +0100
Message-ID: <CAL1e-=jqCgakxTn1zQaNu7WqLjEien_Nd+nxQRe7NdmXKiivfw@mail.gmail.com>
Subject: Re: [PATCH] !fixup "target/avr: Add defintions of AVR core types"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000207ff0059e0b35e0"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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
Cc: Joaquin de Andres <me@xcancerberox.com.ar>,
 Michael Rolnik <mrolnik@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000207ff0059e0b35e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, February 7, 2020, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
wrote:

> These cores have unresolved review comment:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg674105.html
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg674259.html
> and:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg676046.html
>
> As we don't want a bad start with this architecture, remove them.
>
>
I agree with underlying motivation of your fixup.

Still, the division of AVR cores into avr1, avr2, ... , xmega7 is here to
stay. The reason is that because such coding is a part of ELF header, and
this means they will stay forever (as they are approved by some kind of ELF
comitee, and are meant not to be ever changed in future).

Rather than deleting definitions and references of core types we know we
don't support (or, at least, don't fully support), let's think of some less
intrusive way - for example, checking core type of executable given via
CLI, and refusing to emulate, if we know we still have some issues with the
core type in question.

For example, "avrtiny" type is missing handling the fact that it has 16
register instead of 32 registers, like otger AVR core types. But, other
AVRFeatures of "avrtiny" are correctly identified, and it would be a shame
to delete them now and force someone in future to reinvent the wheel. Just
refusing to emulate "avrtiny" seems a better approach to me.

Aleksandar



> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Based-on: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
>
> Side note: typo in the subject "definitions"
> ---
>  target/avr/cpu.c | 96 ------------------------------------------------
>  1 file changed, 96 deletions(-)
>
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index 8a084c750f..b3d661142d 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -216,77 +216,6 @@ static void avr_cpu_class_init(ObjectClass *oc, void
> *data)
>      cc->gdb_core_xml_file =3D "avr-cpu.xml";
>  }
>
> -/*
> - * Setting features of AVR core type avr1
> - * --------------------------------------
> - *
> - * This type of AVR core is present in the following AVR MCUs:
> - *
> - * at90s1200, attiny11, attiny12, attiny15, attiny28
> - */
> -static void avr_avr1_initfn(Object *obj)
> -{
> -    AVRCPU *cpu =3D AVR_CPU(obj);
> -    CPUAVRState *env =3D &cpu->env;
> -
> -    set_avr_feature(env, AVR_FEATURE_LPM);
> -    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> -    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> -}
> -
> -/*
> - * Setting features of AVR core type avr2
> - * --------------------------------------
> - *
> - * This type of AVR core is present in the following AVR MCUs:
> - *
> - * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26,
> at90s4414,
> - * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535
> - */
> -static void avr_avr2_initfn(Object *obj)
> -{
> -    AVRCPU *cpu =3D AVR_CPU(obj);
> -    CPUAVRState *env =3D &cpu->env;
> -
> -    set_avr_feature(env, AVR_FEATURE_LPM);
> -    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> -    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> -    set_avr_feature(env, AVR_FEATURE_SRAM);
> -    set_avr_feature(env, AVR_FEATURE_BREAK);
> -
> -    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> -    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> -}
> -
> -/*
> - * Setting features of AVR core type avr25
> - * --------------------------------------
> - *
> - * This type of AVR core is present in the following AVR MCUs:
> - *
> - * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a,
> attiny24,
> - * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84,
> attiny84a,
> - * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461,
> attiny461a,
> - * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88,
> attiny828,
> - * attiny841, at86rf401
> - */
> -static void avr_avr25_initfn(Object *obj)
> -{
> -    AVRCPU *cpu =3D AVR_CPU(obj);
> -    CPUAVRState *env =3D &cpu->env;
> -
> -    set_avr_feature(env, AVR_FEATURE_LPM);
> -    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> -    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> -    set_avr_feature(env, AVR_FEATURE_SRAM);
> -    set_avr_feature(env, AVR_FEATURE_BREAK);
> -
> -    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> -    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> -    set_avr_feature(env, AVR_FEATURE_LPMX);
> -    set_avr_feature(env, AVR_FEATURE_MOVW);
> -}
> -
>  /*
>   * Setting features of AVR core type avr3
>   * --------------------------------------
> @@ -499,27 +428,6 @@ static void avr_avr6_initfn(Object *obj)
>      set_avr_feature(env, AVR_FEATURE_MUL);
>  }
>
> -/*
> - * Setting features of AVR core type avrtiny
> - * --------------------------------------
> - *
> - * This type of AVR core is present in the following AVR MCUs:
> - *
> - * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40
> - */
> -static void avr_avrtiny_initfn(Object *obj)
> -{
> -    AVRCPU *cpu =3D AVR_CPU(obj);
> -    CPUAVRState *env =3D &cpu->env;
> -
> -    set_avr_feature(env, AVR_FEATURE_LPM);
> -    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> -    set_avr_feature(env, AVR_FEATURE_BREAK);
> -
> -    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> -    set_avr_feature(env, AVR_FEATURE_1_BYTE_SP);
> -}
> -
>  /*
>   * Setting features of AVR core type xmega2
>   * --------------------------------------
> @@ -754,10 +662,6 @@ static const TypeInfo avr_cpu_type_info[] =3D {
>          .class_init =3D avr_cpu_class_init,
>          .abstract =3D true,
>      },
> -    DEFINE_AVR_CPU_TYPE("avrtiny", avr_avrtiny_initfn),
> -    DEFINE_AVR_CPU_TYPE("avr1", avr_avr1_initfn),
> -    DEFINE_AVR_CPU_TYPE("avr2", avr_avr2_initfn),
> -    DEFINE_AVR_CPU_TYPE("avr25", avr_avr25_initfn),
>      DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
>      DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
>      DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
> --
> 2.21.1
>
>

--000000000000207ff0059e0b35e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, February 7, 2020, Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">These cores have unresolved review comment:<br>
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg674105.htm=
l" target=3D"_blank">https://www.mail-archive.com/<wbr>qemu-devel@nongnu.or=
g/<wbr>msg674105.html</a><br>
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg674259.htm=
l" target=3D"_blank">https://www.mail-archive.com/<wbr>qemu-devel@nongnu.or=
g/<wbr>msg674259.html</a><br>
and:<br>
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg676046.htm=
l" target=3D"_blank">https://www.mail-archive.com/<wbr>qemu-devel@nongnu.or=
g/<wbr>msg676046.html</a><br>
<br>
As we don&#39;t want a bad start with this architecture, remove them.<br>
<br></blockquote><div><br></div><div>I agree with underlying motivation of =
your fixup.</div><div><br></div><div>Still, the division of AVR cores into =
avr1, avr2, ... , xmega7 is here to stay. The reason is that because such c=
oding is a part of ELF header, and this means they will stay forever (as th=
ey are approved by some kind of ELF comitee, and are meant not to be ever c=
hanged in future).</div><div><br></div><div>Rather than deleting definition=
s and references of core types we know we don&#39;t support (or, at least, =
don&#39;t fully support), let&#39;s think of some less intrusive way - for =
example, checking core type of executable given via CLI, and refusing to em=
ulate, if we know we still have some issues with the core type in question.=
</div><div><br></div><div>For example, &quot;avrtiny&quot; type is missing =
handling the fact that it has 16 register instead of 32 registers, like otg=
er AVR core types. But, other AVRFeatures of &quot;avrtiny&quot; are correc=
tly identified, and it would be a shame to delete them now and force someon=
e in future to reinvent the wheel. Just refusing to emulate &quot;avrtiny&q=
uot; seems a better approach to me.</div><div><br></div><div>Aleksandar</di=
v><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
Based-on: &lt;<a href=3D"mailto:1581040680-308-1-git-send-email-aleksandar.=
markovic@rt-rk.com">1581040680-308-1-git-send-<wbr>email-aleksandar.markovi=
c@rt-<wbr>rk.com</a>&gt;<br>
<br>
Side note: typo in the subject &quot;definitions&quot;<br>
---<br>
=C2=A0target/avr/cpu.c | 96 ------------------------------<wbr>------------=
------<br>
=C2=A01 file changed, 96 deletions(-)<br>
<br>
diff --git a/target/avr/cpu.c b/target/avr/cpu.c<br>
index 8a084c750f..b3d661142d 100644<br>
--- a/target/avr/cpu.c<br>
+++ b/target/avr/cpu.c<br>
@@ -216,77 +216,6 @@ static void avr_cpu_class_init(ObjectClass *oc, void *=
data)<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;gdb_core_xml_file =3D &quot;avr-cpu.xml&quot;;<b=
r>
=C2=A0}<br>
<br>
-/*<br>
- * Setting features of AVR core type avr1<br>
- * ------------------------------<wbr>--------<br>
- *<br>
- * This type of AVR core is present in the following AVR MCUs:<br>
- *<br>
- * at90s1200, attiny11, attiny12, attiny15, attiny28<br>
- */<br>
-static void avr_avr1_initfn(Object *obj)<br>
-{<br>
-=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
-=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
-<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
-}<br>
-<br>
-/*<br>
- * Setting features of AVR core type avr2<br>
- * ------------------------------<wbr>--------<br>
- *<br>
- * This type of AVR core is present in the following AVR MCUs:<br>
- *<br>
- * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26, at90s44=
14,<br>
- * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535<br>
- */<br>
-static void avr_avr2_initfn(Object *obj)<br>
-{<br>
-=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
-=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
-<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
-<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
-}<br>
-<br>
-/*<br>
- * Setting features of AVR core type avr25<br>
- * ------------------------------<wbr>--------<br>
- *<br>
- * This type of AVR core is present in the following AVR MCUs:<br>
- *<br>
- * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a, attiny=
24,<br>
- * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84, attiny=
84a,<br>
- * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461, attiny4=
61a,<br>
- * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88, attiny8=
28,<br>
- * attiny841, at86rf401<br>
- */<br>
-static void avr_avr25_initfn(Object *obj)<br>
-{<br>
-=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
-=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
-<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
-<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);<br>
-}<br>
-<br>
=C2=A0/*<br>
=C2=A0 * Setting features of AVR core type avr3<br>
=C2=A0 * ------------------------------<wbr>--------<br>
@@ -499,27 +428,6 @@ static void avr_avr6_initfn(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0set_avr_feature(env, AVR_FEATURE_MUL);<br>
=C2=A0}<br>
<br>
-/*<br>
- * Setting features of AVR core type avrtiny<br>
- * ------------------------------<wbr>--------<br>
- *<br>
- * This type of AVR core is present in the following AVR MCUs:<br>
- *<br>
- * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40<br>
- */<br>
-static void avr_avrtiny_initfn(Object *obj)<br>
-{<br>
-=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
-=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
-<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
-<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
-=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_1_BYTE_SP);<br>
-}<br>
-<br>
=C2=A0/*<br>
=C2=A0 * Setting features of AVR core type xmega2<br>
=C2=A0 * ------------------------------<wbr>--------<br>
@@ -754,10 +662,6 @@ static const TypeInfo avr_cpu_type_info[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.class_init =3D avr_cpu_class_init,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.abstract =3D true,<br>
=C2=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avrtiny&quot;, avr_avrtiny_initfn)=
,<br>
-=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr1&quot;, avr_avr1_initfn),<br>
-=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr2&quot;, avr_avr2_initfn),<br>
-=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr25&quot;, avr_avr25_initfn),<br=
>
=C2=A0 =C2=A0 =C2=A0DEFINE_AVR_CPU_TYPE(&quot;avr3&quot;, avr_avr3_initfn),=
<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_AVR_CPU_TYPE(&quot;avr31&quot;, avr_avr31_initfn=
),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_AVR_CPU_TYPE(&quot;avr35&quot;, avr_avr35_initfn=
),<br>
-- <br>
2.21.1<br>
<br>
</blockquote>

--000000000000207ff0059e0b35e0--

