Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E6EC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B9720836
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBmw1iTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B9720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUYXQ-0005c9-8P
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 12:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jUYW4-0004Fj-WB
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jUYTs-0007q1-BI
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:27:56 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135]:44407)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jUYTr-0007nd-Pw; Fri, 01 May 2020 12:25:39 -0400
Received: by mail-lf1-x135.google.com with SMTP id d25so4244670lfi.11;
 Fri, 01 May 2020 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=14M/n5kIEVWNhXVbjGOKSuVpWjlgm+LV55VGErAok9Q=;
 b=bBmw1iTMR2LGOQOBsoOg4tPd5EdFEeTRBl057JFuC8wUFZ2J5CtyWfTPunmTPDyvJg
 ht4yeAh2/scUVZb8b2U82/tNjOCqHMF6BWH4t8yYoFryzS+/cmoDZzGeGSBn2buTUIUv
 AFoH5rgDqbsSbh81MgQ7QEukZq952ELQHysm+cw/iAg05vZRoXank7mrJwbU6DjXWMDj
 qkaYyRMb8GbhR5MhBGIOXUjEYNUQNxmn79rMYs80XhmrPkJeVJuNmVBa8XDB/Z85s2vw
 dn8aTUWwvK5XGLTTpj6zRqaIHZxtyrjwWJ+SO2DIvE9lLdMUKbC5wjY0oTXx2W4Z0euO
 0Wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=14M/n5kIEVWNhXVbjGOKSuVpWjlgm+LV55VGErAok9Q=;
 b=L/uZthL6LzougTsPXj2ALB0hNvfqxx2ndpw3w22sjeJTG/KwC6SXxtphBjB+6KYubg
 5MQpvAUuzQlFd86uzM32AyljBHYlwsz5BJ7NoZMQ4qBoAP6LES/NxeXVfvTb+VBM9+sP
 OCmZYQ/W0ITGfbtZWXyWLqXwc/G2EDYidcrMwzJ+Z4TenyxPfBZgPmxSzcL0JbTbIiP0
 0MQtsHBhxdlqvTEWrclApfAMg7fNWqHLDkX70mjzop18hvOzNsxvS0lxKm/6Iuif0zkn
 oc9v8dC0HbGG7zI11VY+TLDvaUTdUfcSDRzjS4bMJPv6V1lh6d/Infrn/dA7B3T/ZWuC
 3YKg==
X-Gm-Message-State: AGi0PuYjitY5S+zTGKuJ0Wfpg3p63ZLcbN1bRJI/Alk7heNlmkXWLg1n
 mFQSj2XBy3COGTlRhUmi4M0UKzzGe0o7Koywsbg=
X-Google-Smtp-Source: APiQypJ5wG3FBml+8cD9aNjY2xMqiKXsB7DyI9mbc1uiAoWBaBS0IB5IgSD4AdSWedsq6dizHUm5Q0SFIaZTiBrnxk4=
X-Received: by 2002:a05:6512:3049:: with SMTP id
 b9mr3149625lfb.176.1588350337247; 
 Fri, 01 May 2020 09:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <AM4PR07MB350653D5961DFCE441646131CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <871ro6ld2f.fsf@linaro.org>
 <AM4PR07MB350673696C7DE2CA16C9C685CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87sggmjgit.fsf@linaro.org>
 <CAE2XoE8wFK1nOq3YXhB=iqTvqSDQk7Zzd35Tjzdd==v8ouMijA@mail.gmail.com>
 <43ac337c-752a-7151-1e88-de01949571de@linaro.org>
 <CAE2XoE-f_rkcnpQO1cHPUgdaWNAOvBRyUX1aj27UePd0Hkr=KQ@mail.gmail.com>
 <alpine.BSF.2.22.395.2004301721420.29315@zero.eik.bme.hu>
 <AM4PR07MB3506C091776962655FCE11E9CAAA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <FEA0FBA9-F5B7-4995-A2F3-5D8053637379@gmail.com>
 <CAE2XoE_N_oWJwwGVfh+9mOh3dYR6JXk5XJKzv8fr2A4iE9h1OA@mail.gmail.com>
 <alpine.BSF.2.22.395.2005011347390.29385@zero.eik.bme.hu>
 <CAE2XoE-0=SgjeXddZXDOYPeUC1xsD5V=A5xBoa1yHS8gL2=MQg@mail.gmail.com>
 <874kszkdhm.fsf@linaro.org> <d84e50f5-493e-7c8a-bf39-c94c18875171@linaro.org>
In-Reply-To: <d84e50f5-493e-7c8a-bf39-c94c18875171@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 2 May 2020 00:25:24 +0800
Message-ID: <CAE2XoE9Q-0S_SDA-vV7desU8or_D8wPAkz30xQ_4TGfpXO=D3w@mail.gmail.com>
Subject: Re: About hardfloat in ppc
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000a16ea705a498a130"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x135.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::135
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
Reply-To: luoyonggang@gmail.com
Cc: Dino Papararo <skizzato73@msn.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a16ea705a498a130
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2020 at 10:18 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 5/1/20 6:10 AM, Alex Benn=C3=A9e wrote:
> >
> > =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> write=
s:
> >
> >> On Fri, May 1, 2020 at 7:58 PM BALATON Zoltan <balaton@eik.bme.hu>
> wrote:
> >>
> >>> On Fri, 1 May 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >>>> That's what I suggested,
> >>>> We preserve a  float computing cache
> >>>> typedef struct FpRecord {
> >>>>  uint8_t op;
> >>>>  float32 A;
> >>>>  float32 B;
> >>>> }  FpRecord;
> >>>> FpRecord fp_cache[1024];
> >>>> int fp_cache_length;
> >>>> uint32_t fp_exceptions;
> >>>>
> >>>> 1. For each new fp operation we push it to the  fp_cache,
> >>>> 2. Once we read the fp_exceptions , then we re-compute
> >>>> the fp_exceptions by re-running the fp FpRecord sequence.
> >>>> and clear  fp_cache_length.
> >>>
> >>> Why do you need to store more than the last fp op? The cumulative bit=
s
> can
> >>> be tracked like it's done for other targets by not clearing fp_status
> then
> >>> you can read it from there. Only the non-sticky FI bit needs to be
> >>> computed but that's only determined by the last op so it's enough to
> >>> remember that and run that with softfloat (or even hardfloat after
> >>> clearing status but softfloat may be faster for this) to get the bits
> for
> >>> last op when status is read.
> >>>
> >> Yeap, store only the last fp op is also an option. Do you means that
> store
> >> the last fp op,
> >> and calculate it when necessary?  I am thinking about a general fp
> >> optmize method that suite
> >> for all target.
> >
> > I think that's getting a little ahead of yourself. Let's prove the
> > technique is valuable for PPC (given it has the most to gain). We can
> > always generalise later if it's worthwhile.
>
> Indeed.
>
> > Rather than creating a new structure I would suggest creating 3 new tcg
> > globals (op, inA, inB) and re-factor the front-end code so each FP op
> > loaded the TCG globals. The TCG optimizer should pick up aliased loads
> > and automatically eliminate the dead ones. We might need some new
> > machinery for the TCG to avoid spilling the values over potentially
> > faulting loads/stores but that is likely a phase 2 problem.
>
> There's no point in new tcg globals.
>
> Every fp operation can raise an exception, and therefore every fp operati=
on
> will flush tcg globals to memory.  Therefore there is no optimization to =
be
> done at the tcg opcode level.
>
> However, every fp operation calls a helper function, and the quickest
> thing to
> do is store the inputs to env->(op, inA, inB, inC) in the helper before
> performing the operation.
>
I thinks there is a possibility to add the tcg ops to optimize the floating
point; For example
WebAssembly doesn't support for float point exception and fp round mode at
all, I suppose most fp execution are no need care about
 round mode  and fp expcetion, and for this path we can use tcg-op to
abstract it,
and for all other condition we can downgrading to soft-float. As a final
path to optmize to fp accel of
QEMU, we can split the tcg-op into two path. one is hard-float with result
cache for lazy fp flags calculating
And one is pure soft-float path.
For lazy fp flags calculating, cause we have stick flags
```
    float_flag_invalid   =3D  1,
    float_flag_divbyzero =3D  4,
    float_flag_overflow  =3D  8,
    float_flag_underflow =3D 16,
    float_flag_inexact   =3D 32,
```
We can skip the calculation of these flags when these flags are already
marked to 1.
For these five flags, we can split to 5 calculating function, One function
only check one of the flags.
And once the flags are set to 1, then we won't call the functon any more,
unless the flag are cleared.
We will reduce a lot of branch prediction. And the function would only be
called when the
fp flags are requested.
This is my final goal to optimize fp in QEMU, before that, we can do
simpler things to optimize fp in QEMU

And besides these type of optimization, we can also offloading the fp
exception calculating to other CPU core, so
we can making single threading performance be better, cause single core
performance are hard to improve, but multiple core
system are more and more used in these days, for Ryzen 2/ Threadripper we
even have 64-core /128 threads.



>
> > Next you will want to find places that care about the per-op bits of
> > cpu_fpscr and call a helper with the new globals to re-run the
> > computation and feed the values in.
>
> Before we even get to this deferred fp operation thing, there are several
> giant
> improvements to ppc emulation that can be made:
>
> Step 1 is to rearrange the fp helpers to eliminate helper_reset_fpstatus(=
).
> I've mentioned this before, that it's possible to leave the steady-state =
of
> env->fp_status.exception_flags =3D=3D 0, so there's no need for a separat=
e
> function
> call.  I suspect this is worth a decent speedup by itself.
>
I would like to start the fp optimize from here.


>
> Step 2 is to notice when all fp exceptions are masked, so that no
> exception can
> be raised, and set a tb_flags bit.  This is the default fp environment th=
at
> libc enables and therefore extremely common.
>
> Currently, ppc has 3 helpers called per fp operation.  If step 1 is handl=
ed
> correctly, then we're down to 2 fp helpers per fp operation.  If no
> exceptions
> need raising, then we can perform the entire operation with a single
> function call.
>
> We would require a parallel set of fp helpers that (1) performs the
> operation
> and (2) does any post-processing of the exception bits straight away, but
> (3)
> without raising any exceptions.  Sort of like helper_fadd +
> do_float_check_status, but less.  IIRC the only real extra work is
> categorizing
> invalid exceptions.  We could even plausibly extend softfloat to do that
> while
> it is recording the invalid exception.
>
> Step 3 is to improve softfloat.c with Yonggang Luo's idea to compute
> inexact
> from the inverse hardfloat operation.  This would let us relax the
> restriction
> of only using hardfloat when we have already have an accrued inexact
> exception.
>
> Only after all of these are done is it worth experimenting with caching t=
he
> last fp operation.
>
>
> r~
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000a16ea705a498a130
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 1, 2020 at 10:18 PM Richa=
rd Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.he=
nderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On 5/1/20 6:10 AM, Alex Benn=C3=A9e wrote:<br>
&gt; <br>
&gt; =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) &lt;<a href=3D"mailto:luoyon=
ggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt; writes:<br=
>
&gt; <br>
&gt;&gt; On Fri, May 1, 2020 at 7:58 PM BALATON Zoltan &lt;<a href=3D"mailt=
o:balaton@eik.bme.hu" target=3D"_blank">balaton@eik.bme.hu</a>&gt; wrote:<b=
r>
&gt;&gt;<br>
&gt;&gt;&gt; On Fri, 1 May 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) =
wrote:<br>
&gt;&gt;&gt;&gt; That&#39;s what I suggested,<br>
&gt;&gt;&gt;&gt; We preserve a=C2=A0 float computing cache<br>
&gt;&gt;&gt;&gt; typedef struct FpRecord {<br>
&gt;&gt;&gt;&gt;=C2=A0 uint8_t op;<br>
&gt;&gt;&gt;&gt;=C2=A0 float32 A;<br>
&gt;&gt;&gt;&gt;=C2=A0 float32 B;<br>
&gt;&gt;&gt;&gt; }=C2=A0 FpRecord;<br>
&gt;&gt;&gt;&gt; FpRecord fp_cache[1024];<br>
&gt;&gt;&gt;&gt; int fp_cache_length;<br>
&gt;&gt;&gt;&gt; uint32_t fp_exceptions;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; 1. For each new fp operation we push it to the=C2=A0 fp_ca=
che,<br>
&gt;&gt;&gt;&gt; 2. Once we read the fp_exceptions , then we re-compute<br>
&gt;&gt;&gt;&gt; the fp_exceptions by re-running the fp FpRecord sequence.<=
br>
&gt;&gt;&gt;&gt; and clear=C2=A0 fp_cache_length.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Why do you need to store more than the last fp op? The cumulat=
ive bits can<br>
&gt;&gt;&gt; be tracked like it&#39;s done for other targets by not clearin=
g fp_status then<br>
&gt;&gt;&gt; you can read it from there. Only the non-sticky FI bit needs t=
o be<br>
&gt;&gt;&gt; computed but that&#39;s only determined by the last op so it&#=
39;s enough to<br>
&gt;&gt;&gt; remember that and run that with softfloat (or even hardfloat a=
fter<br>
&gt;&gt;&gt; clearing status but softfloat may be faster for this) to get t=
he bits for<br>
&gt;&gt;&gt; last op when status is read.<br>
&gt;&gt;&gt;<br>
&gt;&gt; Yeap, store only the last fp op is also an option. Do you means th=
at store<br>
&gt;&gt; the last fp op,<br>
&gt;&gt; and calculate it when necessary?=C2=A0 I am thinking about a gener=
al fp<br>
&gt;&gt; optmize method that suite<br>
&gt;&gt; for all target.<br>
&gt; <br>
&gt; I think that&#39;s getting a little ahead of yourself. Let&#39;s prove=
 the<br>
&gt; technique is valuable for PPC (given it has the most to gain). We can<=
br>
&gt; always generalise later if it&#39;s worthwhile.<br>
<br>
Indeed.<br>
<br>
&gt; Rather than creating a new structure I would suggest creating 3 new tc=
g<br>
&gt; globals (op, inA, inB) and re-factor the front-end code so each FP op<=
br>
&gt; loaded the TCG globals. The TCG optimizer should pick up aliased loads=
<br>
&gt; and automatically eliminate the dead ones. We might need some new<br>
&gt; machinery for the TCG to avoid spilling the values over potentially<br=
>
&gt; faulting loads/stores but that is likely a phase 2 problem. <br>
<br>
There&#39;s no point in new tcg globals.<br>
<br>
Every fp operation can raise an exception, and therefore every fp operation=
<br>
will flush tcg globals to memory.=C2=A0 Therefore there is no optimization =
to be<br>
done at the tcg opcode level.<br>
<br>
However, every fp operation calls a helper function, and the quickest thing=
 to<br>
do is store the inputs to env-&gt;(op, inA, inB, inC) in the helper before<=
br>
performing the operation.<br></blockquote><div>I thinks there is a possibil=
ity to add the tcg ops to optimize the floating point; For example</div><di=
v>WebAssembly doesn&#39;t support for float point exception and fp round mo=
de at all, I suppose most fp execution are no need care about</div><div>=C2=
=A0round mode=C2=A0 and=C2=A0fp expcetion, and for this path we can use tcg=
-op to abstract it,</div><div>and for all other condition we can downgradin=
g to soft-float. As a final path to optmize=C2=A0to fp accel of</div><div>Q=
EMU, we can split the tcg-op into two path. one is hard-float with result c=
ache for lazy fp flags calculating</div><div>And one is pure soft-float pat=
h.</div><div>For lazy fp flags calculating, cause we have stick flags</div>=
<div>```</div>=C2=A0 =C2=A0 float_flag_invalid =C2=A0 =3D =C2=A01,<br>=C2=
=A0 =C2=A0 float_flag_divbyzero =3D =C2=A04,<br>=C2=A0 =C2=A0 float_flag_ov=
erflow =C2=A0=3D =C2=A08,<br>=C2=A0 =C2=A0 float_flag_underflow =3D 16,<br>=
=C2=A0 =C2=A0 float_flag_inexact =C2=A0 =3D 32,<div>```=C2=A0=C2=A0</div><d=
iv>We can skip the calculation of these flags when these flags are already =
marked to 1.=C2=A0</div><div>For these five flags, we can split to 5 calcul=
ating function, One function only check one of the flags.</div><div>And onc=
e the flags are set to 1, then we won&#39;t call the functon any more, unle=
ss the flag are cleared.</div><div>We will reduce a lot of branch predictio=
n. And the function would only be called when the=C2=A0</div><div>fp flags =
are requested.</div><div>This is my final goal to optimize fp in QEMU, befo=
re that, we can do simpler things to optimize fp in QEMU</div><div><br></di=
v><div>And besides these type of optimization, we can also offloading the f=
p exception calculating to other CPU core, so=C2=A0</div><div>we can making=
 single threading performance be better, cause single core performance are =
hard to improve, but multiple core</div><div>system are more and more used =
in these days, for Ryzen 2/ Threadripper we even have 64-core /128 threads.=
</div><div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
<br>
&gt; Next you will want to find places that care about the per-op bits of<b=
r>
&gt; cpu_fpscr and call a helper with the new globals to re-run the<br>
&gt; computation and feed the values in.<br>
<br>
Before we even get to this deferred fp operation thing, there are several g=
iant<br>
improvements to ppc emulation that can be made:<br>
<br>
Step 1 is to rearrange the fp helpers to eliminate helper_reset_fpstatus().=
<br>
I&#39;ve mentioned this before, that it&#39;s possible to leave the steady-=
state of<br>
env-&gt;fp_status.exception_flags =3D=3D 0, so there&#39;s no need for a se=
parate function<br>
call.=C2=A0 I suspect this is worth a decent speedup by itself.<br></blockq=
uote><div>I would like to start the fp optimize from here.</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Step 2 is to notice when all fp exceptions are masked, so that no exception=
 can<br>
be raised, and set a tb_flags bit.=C2=A0 This is the default fp environment=
 that<br>
libc enables and therefore extremely common.<br>
<br>
Currently, ppc has 3 helpers called per fp operation.=C2=A0 If step 1 is ha=
ndled<br>
correctly, then we&#39;re down to 2 fp helpers per fp operation.=C2=A0 If n=
o exceptions<br>
need raising, then we can perform the entire operation with a single functi=
on call.<br>
<br>
We would require a parallel set of fp helpers that (1) performs the operati=
on<br>
and (2) does any post-processing of the exception bits straight away, but (=
3)<br>
without raising any exceptions.=C2=A0 Sort of like helper_fadd +<br>
do_float_check_status, but less.=C2=A0 IIRC the only real extra work is cat=
egorizing<br>
invalid exceptions.=C2=A0 We could even plausibly extend softfloat to do th=
at while<br>
it is recording the invalid exception.<br>
<br>
Step 3 is to improve softfloat.c with Yonggang Luo&#39;s idea to compute in=
exact<br>
from the inverse hardfloat operation.=C2=A0 This would let us relax the res=
triction<br>
of only using hardfloat when we have already have an accrued inexact except=
ion.<br>
<br>
Only after all of these are done is it worth experimenting with caching the=
<br>
last fp operation.<br>
<br>
<br>
r~<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000a16ea705a498a130--

