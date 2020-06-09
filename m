Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281B9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 23:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02DA20760
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 23:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CK6kD2Z3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02DA20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jinL1-0004X5-2e
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 19:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jinKC-00045q-1l
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 19:06:32 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f]:44417)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jinK9-0003wJ-UY
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 19:06:31 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id n188so108481vkc.11
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 16:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=quIfGHj6+rrnejQPLToxXOYuuY6BzlM7ctqLUZdKxc8=;
 b=CK6kD2Z3VRy87lkAzATQllVmKBr77B/pA23ySRvSWzhQPtFaRf1/+WnC+RFc5RdOte
 WpD8zZY1b98/y1PGawQ3zFUCS/P8mqvYWrFLeX32KEi1tUnbvwFtT6uwgHj+/d05cK+b
 BTf0T2REVzBc5DoklaaX45T0hExWVNcaqaVuNl3O7IseIlKjfP10dIYmsBQn5MFoXe9z
 I1EVqd9hMN76vG4wi1QOGtTw7ElyeJVDWQca0ijUCHgpf38ban23ANoZ6blvPNfOChIu
 ggtyHcxqgJ9qH1/aaUJ8CBAEQQVhb/G2GL7WQSvEviIpNnYTjwOBAnjq6fKXRZ4wC3lP
 ddJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=quIfGHj6+rrnejQPLToxXOYuuY6BzlM7ctqLUZdKxc8=;
 b=jQzDSXWbq74ns3BSkT0hR2SagGoKWcsK2QEtiI3gVGjLWl4b6k8X1B4lMzzbjbWsut
 vpQgCVobEmTjsSFxSO+WRuG0xPezEFHHddIEx1uA2iO2sOuJjQsQPBcLr8KgYyTy1zni
 HT01BR+m/SM+u9y7QUpBd1Xh7/+g7xU+JHQwgRzYi/BaxZkSsZPazUpjcVZokocVLzu4
 FKKUrMbxj5GZPuTcEGkniGnKg4Y3NmvVwBIvHjdAJSS6p/pVKd0TGZDg/l5BIbijXpvL
 8sUAVnxekJVG3t90pS68cxNOqUkjgYcyQCfwY/+5ZMwHnEA2irzQxGYHZedVctv+8Pri
 +ptg==
X-Gm-Message-State: AOAM5322Lx0B/sCPzl1Hbi7gJvC4baAU7GgIFmvtyHHvACsxH5e4X+ri
 qVjRU1prXPhS1tQ/tF/P9r5Irxm0FpM9tQ1aCiqx8w==
X-Google-Smtp-Source: ABdhPJy04x3xeNnVhyrEusqppc1o7XX0iOVJnVbQBb6CIqpbAGf1vF1/bomgfN6YxSQYuYqyEeG0pemsXzSfD8q32Ig=
X-Received: by 2002:a1f:9444:: with SMTP id w65mr411556vkd.50.1591743982986;
 Tue, 09 Jun 2020 16:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200521192133.127559-1-hskinnemoen@google.com>
 <20200521192133.127559-6-hskinnemoen@google.com>
 <18fa4025-0a2a-4427-b74f-2b1b678e0661@kaod.org>
In-Reply-To: <18fa4025-0a2a-4427-b74f-2b1b678e0661@kaod.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Tue, 9 Jun 2020 16:06:11 -0700
Message-ID: <CAFQmdRY9f6tV7VoDOFpRJ0x0hr_0EAaGqZwmXnkJpbvmbF4FVQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] hw/arm: Add NPCM730 and NPCM750 SoC models
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, CS20 KFTing <kfting@nuvoton.com>
Content-Type: multipart/alternative; boundary="000000000000ae6ab505a7aec6a0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=hskinnemoen@google.com; helo=mail-vk1-xa2f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ae6ab505a7aec6a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2020 at 12:24 AM C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 5/21/20 9:21 PM, Havard Skinnemoen wrote:
> > +void npcm7xx_write_secondary_boot(ARMCPU *cpu, const struct
> arm_boot_info *info)
> > +{
> > +    /*
> > +     * The default smpboot stub halts the secondary CPU with a 'wfi'
> > +     * instruction, but the arch/arm/mach-npcm/platsmp.c in the Linux
> kernel
> > +     * does not send an IPI to wake it up, so the second CPU fails to
> boot. So
> > +     * we need to provide our own smpboot stub that can not use 'wfi',
> it has
> > +     * to spin the secondary CPU until the first CPU writes to the
> SCRPAD reg.
> > +     */
> > +    uint32_t smpboot[] =3D {
>
> static const uint32 ?
>

I think that would be unsafe due to the byte swapping, but I'll do it if we
can get rid of that somehow.


>
> > +        0xe59f2018,     /* ldr r2, bootreg_addr */
> > +        0xe3a00000,     /* mov r0, #0 */
> > +        0xe5820000,     /* str r0, [r2] */
> > +        0xe320f002,     /* wfe */
> > +        0xe5921000,     /* ldr r1, [r2] */
> > +        0xe1110001,     /* tst r1, r1 */
> > +        0x0afffffb,     /* beq <wfe> */
> > +        0xe12fff11,     /* bx r1 */
> > +        NPCM7XX_SMP_BOOTREG_ADDR,
> > +    };
> > +    int i;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(smpboot); i++) {
> > +        smpboot[i] =3D tswap32(smpboot[i]);
>
> ah ! why do we need to swap the instructions ?
>

I probably stole this from
https://elixir.bootlin.com/qemu/latest/source/hw/arm/exynos4210.c#L134
although there are several other examples of this pattern.

IIUC, it's necessary for the target to see the instruction words specified
above when its endianness is different from the host. But perhaps I can
specify it as a byte array instead. Would that work?

If that works, I should be able to drop the byte swapping and make the
smpboot array constant. I don't think I'll be able to test it thoroughly
though, as I don't have access to a big endian host.

> +static void npcm7xx_init(Object *obj)
> > +{
> > +    NPCM7xxState *s =3D NPCM7XX(obj);
> > +    int i;
> > +
> > +    for (i =3D 0; i < NPCM7XX_MAX_NUM_CPUS; i++) {
> > +        s->cpu[i] =3D ARM_CPU(
> > +            object_new_with_props(ARM_CPU_TYPE_NAME("cortex-a9"),
> > +                                  obj, "cpu[*]", &error_abort, NULL));
>
> why allocate  ? Can't you use :
>
>               ARMCPU cpu[NPCM7XX_MAX_NUM_CPUS];
>
> and call object_initialize_child() ?
>

OK, I will try that.

> +    for (i =3D 0; i < s->num_cpus; i++) {
> > +        object_property_set_int(OBJECT(s->cpu[i]),
> > +                                arm_cpu_mp_affinity(i,
> NPCM7XX_MAX_NUM_CPUS),
> > +                                "mp-affinity", &error_abort);
> > +        object_property_set_int(OBJECT(s->cpu[i]),
> NPCM7XX_GIC_CPU_IF_ADDR,
> > +                                "reset-cbar", &error_abort);
> > +        object_property_set_bool(OBJECT(s->cpu[i]), true,
> > +                                 "reset-hivecs", &error_abort);
> > +
> > +        /* TODO: Not sure why this is needed. */
>
> It's disabling the security extensions.
>

Thanks, I'll update the comment.


>
> > +        if (object_property_find(OBJECT(s->cpu[i]), "has_el3", NULL)) =
{
> > +            object_property_set_bool(OBJECT(s->cpu[i]), false,
> "has_el3",
> > +                                     &error_abort);
> > +        }
> > +
> > +        object_property_set_bool(OBJECT(s->cpu[i]), true, "realized",
> &err);
> > +        if (err) {
> > +            error_propagate(errp, err);
> > +            return;
> > +        }
> > +    }
>
> With this pattern, which initializes all possible CPU objects and only
> realizes the requested ones, some CPU objects are left unrealized in
> the QOM tree. It's is better to unparent them.
>
> If the board has a fixed number of CPUs and you don't plan to activate
> only a few of them for debug/test, I would make the "num_cpus" a class
> property. See the Aspeed boards.
>

Will do, thanks.


> > +
> > +    /* A9MPCORE peripherals */
> > +    object_property_set_int(OBJECT(&s->a9mpcore), s->num_cpus,
> "num-cpu",
> > +                            &error_abort);
> > +    object_property_set_int(OBJECT(&s->a9mpcore), 160, "num-irq",
> &error_abort);
>
> 160 needs a define.
>

Will do, thanks.

--000000000000ae6ab505a7aec6a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Jun 9, 2020 at 12:24 AM C=C3=A9dr=
ic Le Goater &lt;<a href=3D"mailto:clg@kaod.org">clg@kaod.org</a>&gt; wrote=
:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On 5/21/20 9:21 PM, Havard Skinnemoen wrote:<br>
&gt; +void npcm7xx_write_secondary_boot(ARMCPU *cpu, const struct arm_boot_=
info *info)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* The default smpboot stub halts the secondary CP=
U with a &#39;wfi&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* instruction, but the arch/arm/mach-npcm/platsmp=
.c in the Linux kernel<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* does not send an IPI to wake it up, so the seco=
nd CPU fails to boot. So<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* we need to provide our own smpboot stub that ca=
n not use &#39;wfi&#39;, it has<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* to spin the secondary CPU until the first CPU w=
rites to the SCRPAD reg.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 uint32_t smpboot[] =3D {<br>
<br>
static const uint32 ?<br></blockquote><div><br></div><div>I think that woul=
d be unsafe due to the byte swapping, but I&#39;ll do it if we can get rid =
of that somehow.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xe59f2018,=C2=A0 =C2=A0 =C2=A0/* ldr r2,=
 bootreg_addr */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xe3a00000,=C2=A0 =C2=A0 =C2=A0/* mov r0,=
 #0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xe5820000,=C2=A0 =C2=A0 =C2=A0/* str r0,=
 [r2] */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xe320f002,=C2=A0 =C2=A0 =C2=A0/* wfe */<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xe5921000,=C2=A0 =C2=A0 =C2=A0/* ldr r1,=
 [r2] */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xe1110001,=C2=A0 =C2=A0 =C2=A0/* tst r1,=
 r1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0afffffb,=C2=A0 =C2=A0 =C2=A0/* beq &lt=
;wfe&gt; */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xe12fff11,=C2=A0 =C2=A0 =C2=A0/* bx r1 *=
/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM7XX_SMP_BOOTREG_ADDR,<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(smpboot); i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 smpboot[i] =3D tswap32(smpboot[i]);<br>
<br>
ah ! why do we need to swap the instructions ?<br></blockquote><div><br></d=
iv><div>I probably stole this from=C2=A0<a href=3D"https://elixir.bootlin.c=
om/qemu/latest/source/hw/arm/exynos4210.c#L134">https://elixir.bootlin.com/=
qemu/latest/source/hw/arm/exynos4210.c#L134</a> although there are several =
other examples of this pattern.</div><div><br></div><div>IIUC, it&#39;s nec=
essary for the target to see the instruction words specified above when its=
 endianness is different from the host. But perhaps I can specify it as a b=
yte array instead. Would that work?</div><div><br></div><div>If that works,=
 I should be able to drop the byte swapping and make the smpboot array cons=
tant. I don&#39;t think I&#39;ll be able to test it thoroughly though, as I=
 don&#39;t have access to a big endian host.</div><div><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
&gt; +static void npcm7xx_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 NPCM7xxState *s =3D NPCM7XX(obj);<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; NPCM7XX_MAX_NUM_CPUS; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cpu[i] =3D ARM_CPU(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_new_with_props(ARM_C=
PU_TYPE_NAME(&quot;cortex-a9&quot;),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 obj, &quot;cpu[*]&quot;, =
&amp;error_abort, NULL));<br>
<br>
why allocate=C2=A0 ? Can&#39;t you use : <br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ARMCPU cpu[NPCM7XX_MAX_NUM=
_CPUS];<br>
<br>
and call object_initialize_child() ? <br></blockquote><div><br></div><div>O=
K, I will try that.</div><div><br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; s-&gt;num_cpus; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_int(OBJECT(s-&gt;cpu[=
i]),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arm_cpu_mp_affinity(i, NPCM7XX_M=
AX_NUM_CPUS),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;mp-affinity&quot;, &amp;er=
ror_abort);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_int(OBJECT(s-&gt;cpu[=
i]), NPCM7XX_GIC_CPU_IF_ADDR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;reset-cbar&quot;, &amp;err=
or_abort);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(OBJECT(s-&gt;cpu=
[i]), true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;reset-hivecs&quot;, =
&amp;error_abort);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: Not sure why this is needed. */<=
br>
<br>
It&#39;s disabling the security extensions.<br></blockquote><div><br></div>=
<div>Thanks, I&#39;ll update the comment.</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (object_property_find(OBJECT(s-&gt;cpu=
[i]), &quot;has_el3&quot;, NULL)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(OB=
JECT(s-&gt;cpu[i]), false, &quot;has_el3&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_a=
bort);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_bool(OBJECT(s-&gt;cpu=
[i]), true, &quot;realized&quot;, &amp;err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
With this pattern, which initializes all possible CPU objects and only <br>
realizes the requested ones, some CPU objects are left unrealized in <br>
the QOM tree. It&#39;s is better to unparent them.<br>
<br>
If the board has a fixed number of CPUs and you don&#39;t plan to activate =
<br>
only a few of them for debug/test, I would make the &quot;num_cpus&quot; a =
class<br>
property. See the Aspeed boards.<br></blockquote><div><br></div><div>Will d=
o, thanks.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* A9MPCORE peripherals */<br>
&gt; +=C2=A0 =C2=A0 object_property_set_int(OBJECT(&amp;s-&gt;a9mpcore), s-=
&gt;num_cpus, &quot;num-cpu&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_abort);<br>
&gt; +=C2=A0 =C2=A0 object_property_set_int(OBJECT(&amp;s-&gt;a9mpcore), 16=
0, &quot;num-irq&quot;, &amp;error_abort);<br>
<br>
160 needs a define.<br></blockquote><div><br></div><div>Will do, thanks.</d=
iv></div></div>

--000000000000ae6ab505a7aec6a0--

