Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011F6C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 08:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9116123976
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 08:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/sLSZn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9116123976
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMRyy-0000Ej-KW
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 04:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kMRxd-0007ar-Ps
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 04:23:09 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:45144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kMRxZ-0005lC-VW
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 04:23:09 -0400
Received: by mail-ed1-x544.google.com with SMTP id l17so6753943edq.12
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 01:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xyYwZdhMbQrgk+cXiOV8uw04eF6SbYOOG6V6Lqnf7bc=;
 b=a/sLSZn23EowADGflKbC6yXyPUHM+Ry2qYNVdVk3x9WpTQEo+tm0nODiSy6P91FoKL
 UY7n0fW7ZXM/d/I33UCu4R040JeQQ0lnmNClSrmprVl+a+hRaQoNeSUn0SFQA6ELowuz
 5fg/pjqgNWYLlSADuRw6pCwQiKjD1Wu1PHMmCFWBFE9DUPv0N7LLAu/5RsQIFT6mVyH+
 swbC4rhOmdVsuT8PxAy1BIglzJunRft8kjg/eOdRPstOp3PuiEtwQ+iHCo3va3NOYpl/
 WWtOSVer4A/KaZ3Ej0Omy/eHo00rlkBs+nD3rgVbmDxFB4PNHA+wURc6OiZB2lJ8bmSP
 l/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xyYwZdhMbQrgk+cXiOV8uw04eF6SbYOOG6V6Lqnf7bc=;
 b=iRcNTDivin09EHKWTn4Lbq3+XipOt3kvIOKRzO7XcR0/Z8NTylTw7gL9iILOqRdpDq
 0l8bUKIPmqFVzA+ASG9bzaYlI1/566+ZIufvWakQeKG0IlEHwe+hm9DWJiFFxh4KMucA
 sR+7lNmwGoncg1+MzBOstiw3xbVLXIoXF6CSLF8tK30UK/7oxBrhBxcx9jPVKegFIIAU
 ycmTlNbh1769su6uAjbS43Uku7m4fqpkC6b4EpRTSJhbfVbdBDLpmkX0kxsdLLiZAZzv
 R5D8SY1JyjH8vHXsUgKLApq5LpcNd70NXjSv8NO0U5VAcLpfUr6SWF5GCgKtOjXfFfHm
 gywQ==
X-Gm-Message-State: AOAM5334GkTVW5kSI+8qXR/rC+VOkIu9xlZL4pA7Kxi+oZThYQSI+cbe
 ZDLOhEDaRCabUlYcMaqLGLYwpOaVovkvi3+MGBY=
X-Google-Smtp-Source: ABdhPJyCkPiIK+wyKAZu0a4MAcAu4PA5gR2jzKNA/9D+mRudjcCjzXTG9A33fyX/giooXIc4huG8vGAbcD8WBXUSnug=
X-Received: by 2002:aa7:d501:: with SMTP id y1mr10107503edq.29.1601194984146; 
 Sun, 27 Sep 2020 01:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200925083307.13761-1-kele.hwang@gmail.com>
 <1c29d238-b7a0-4ab4-cc38-69a193f328a3@linaro.org>
In-Reply-To: <1c29d238-b7a0-4ab4-cc38-69a193f328a3@linaro.org>
From: Kele Huang <kele.hwang@gmail.com>
Date: Sun, 27 Sep 2020 16:22:52 +0800
Message-ID: <CA+FBGNcRR_cAKVnZ5=2-19xXkN=UYvC9K22VL+GngHhZbWcU=g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] accel/tcg: Fix computing of is_write for MIPS
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003f0be905b047420e"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=kele.hwang@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Xu Zou <iwatchnima@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003f0be905b047420e
Content-Type: text/plain; charset="UTF-8"

Fixed! I have resent a v4 patch which contains SUXC1.
Thank you!

On Fri, 25 Sep 2020 at 22:58, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 9/25/20 1:33 AM, Kele Huang wrote:
> > Detect all MIPS store instructions in cpu_signal_handler for all
> available
> > MIPS versions, and set is_write if encountering such store instructions.
> >
> > This fixed the error while dealing with self-modified code for MIPS.
> >
> > Signed-off-by: Kele Huang <kele.hwang@gmail.com>
> > Signed-off-by: Xu Zou <iwatchnima@gmail.com>
> > ---
> >  accel/tcg/user-exec.c | 38 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> > index bb039eb32d..c4494c93e7 100644
> > --- a/accel/tcg/user-exec.c
> > +++ b/accel/tcg/user-exec.c
> > @@ -702,6 +702,10 @@ int cpu_signal_handler(int host_signum, void *pinfo,
> >
> >  #elif defined(__mips__)
> >
> > +#if defined(__misp16) || defined(__mips_micromips)
> > +#error "Unsupported encoding"
> > +#endif
> > +
> >  int cpu_signal_handler(int host_signum, void *pinfo,
> >                         void *puc)
> >  {
> > @@ -709,9 +713,41 @@ int cpu_signal_handler(int host_signum, void *pinfo,
> >      ucontext_t *uc = puc;
> >      greg_t pc = uc->uc_mcontext.pc;
> >      int is_write;
> > +    uint32_t insn;
> >
> > -    /* XXX: compute is_write */
> > +    /* Detect all store instructions at program counter. */
> >      is_write = 0;
> > +    insn = *(uint32_t *)pc;
> > +    switch((insn >> 26) & 077) {
> > +    case 050: /* SB */
> > +    case 051: /* SH */
> > +    case 052: /* SWL */
> > +    case 053: /* SW */
> > +    case 054: /* SDL */
> > +    case 055: /* SDR */
> > +    case 056: /* SWR */
> > +    case 070: /* SC */
> > +    case 071: /* SWC1 */
> > +    case 074: /* SCD */
> > +    case 075: /* SDC1 */
> > +    case 077: /* SD */
> > +#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
> > +    case 072: /* SWC2 */
> > +    case 076: /* SDC2 */
> > +#endif
> > +        is_write = 1;
> > +        break;
> > +    case 023: /* COP1X */
> > +        /* Required in all versions of MIPS64 since
> > +           MIPS64r1 and subsequent versions of MIPS32. */
> > +        switch (insn & 077) {
> > +        case 010: /* SWXC1 */
> > +        case 011: /* SDXC1 */
> > +            is_write = 1;
>
> Much better.  I just noticed you're missing SUXC1 (COP1X minor 015).  With
> that
> fixed,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> r~
>

--0000000000003f0be905b047420e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Fixed! I have resent a v4 patch which contains SUXC1.<div>=
Thank you!</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, 25 Sep 2020 at 22:58, Richard Henderson &lt;<a href=
=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 9/2=
5/20 1:33 AM, Kele Huang wrote:<br>
&gt; Detect all MIPS store instructions in cpu_signal_handler for all avail=
able<br>
&gt; MIPS versions, and set is_write if encountering such store instruction=
s.<br>
&gt; <br>
&gt; This fixed the error while dealing with self-modified code for MIPS.<b=
r>
&gt; <br>
&gt; Signed-off-by: Kele Huang &lt;<a href=3D"mailto:kele.hwang@gmail.com" =
target=3D"_blank">kele.hwang@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Xu Zou &lt;<a href=3D"mailto:iwatchnima@gmail.com" targ=
et=3D"_blank">iwatchnima@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 accel/tcg/user-exec.c | 38 +++++++++++++++++++++++++++++++++++++=
-<br>
&gt;=C2=A0 1 file changed, 37 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c<br>
&gt; index bb039eb32d..c4494c93e7 100644<br>
&gt; --- a/accel/tcg/user-exec.c<br>
&gt; +++ b/accel/tcg/user-exec.c<br>
&gt; @@ -702,6 +702,10 @@ int cpu_signal_handler(int host_signum, void *pin=
fo,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #elif defined(__mips__)<br>
&gt;=C2=A0 <br>
&gt; +#if defined(__misp16) || defined(__mips_micromips)<br>
&gt; +#error &quot;Unsupported encoding&quot;<br>
&gt; +#endif<br>
&gt; +<br>
&gt;=C2=A0 int cpu_signal_handler(int host_signum, void *pinfo,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0void *puc)<br>
&gt;=C2=A0 {<br>
&gt; @@ -709,9 +713,41 @@ int cpu_signal_handler(int host_signum, void *pin=
fo,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ucontext_t *uc =3D puc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 greg_t pc =3D uc-&gt;uc_mcontext.pc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int is_write;<br>
&gt; +=C2=A0 =C2=A0 uint32_t insn;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 /* XXX: compute is_write */<br>
&gt; +=C2=A0 =C2=A0 /* Detect all store instructions at program counter. */=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 is_write =3D 0;<br>
&gt; +=C2=A0 =C2=A0 insn =3D *(uint32_t *)pc;<br>
&gt; +=C2=A0 =C2=A0 switch((insn &gt;&gt; 26) &amp; 077) {<br>
&gt; +=C2=A0 =C2=A0 case 050: /* SB */<br>
&gt; +=C2=A0 =C2=A0 case 051: /* SH */<br>
&gt; +=C2=A0 =C2=A0 case 052: /* SWL */<br>
&gt; +=C2=A0 =C2=A0 case 053: /* SW */<br>
&gt; +=C2=A0 =C2=A0 case 054: /* SDL */<br>
&gt; +=C2=A0 =C2=A0 case 055: /* SDR */<br>
&gt; +=C2=A0 =C2=A0 case 056: /* SWR */<br>
&gt; +=C2=A0 =C2=A0 case 070: /* SC */<br>
&gt; +=C2=A0 =C2=A0 case 071: /* SWC1 */<br>
&gt; +=C2=A0 =C2=A0 case 074: /* SCD */<br>
&gt; +=C2=A0 =C2=A0 case 075: /* SDC1 */<br>
&gt; +=C2=A0 =C2=A0 case 077: /* SD */<br>
&gt; +#if !defined(__mips_isa_rev) || __mips_isa_rev &lt; 6<br>
&gt; +=C2=A0 =C2=A0 case 072: /* SWC2 */<br>
&gt; +=C2=A0 =C2=A0 case 076: /* SDC2 */<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_write =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 023: /* COP1X */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Required in all versions of MIPS64 sin=
ce <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MIPS64r1 and subsequent vers=
ions of MIPS32. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (insn &amp; 077) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 010: /* SWXC1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 011: /* SDXC1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_write =3D 1;<br>
<br>
Much better.=C2=A0 I just noticed you&#39;re missing SUXC1 (COP1X minor 015=
).=C2=A0 With that<br>
fixed,<br>
<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
r~<br>
</blockquote></div>

--0000000000003f0be905b047420e--

