Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C50CC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 17:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5221C20731
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 17:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2i51gxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5221C20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUZrK-0007Js-FC
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 13:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jUZqC-0006Bj-Cw
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jUZms-0004mp-Kp
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:52:48 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129]:36040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jUZms-0004eC-7s; Fri, 01 May 2020 13:49:22 -0400
Received: by mail-lf1-x129.google.com with SMTP id w14so4451499lfk.3;
 Fri, 01 May 2020 10:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=SYXVzDB/1p5C/DuqT2J1srWTtkeuHEZuIP4PlwFMSYg=;
 b=A2i51gxklZjejG8nzrqN+Km9yKpgRyH0vFY15MY/ruovofi9FqL/d0FH5jQuR7nefp
 uMsamEcw/PMVxkVmwAmw+qp9jEVNaKHY+3Erg6YZVp1ZJjBr22S7CjkHfrfyvWybuSP8
 S6LUDZ35JYns+cA9iUNQr3FoYFaM0F7Q5vWLl3ROHXm7xotTwdXVcraX1WZ1wvNOxS8K
 yVuM3Yh2VKzPaGzaQZl44urUdN0n8vBKQW46m8nG8xmIvxuXEC44BsWRFNB1NgpQJUE/
 VSj2gSAVYhawJwG9HoXnbTPKi7AxCQn3a0ZZcN5lNygMIQZ1IkUAfRiBDh/VwzTU6Trw
 neyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=SYXVzDB/1p5C/DuqT2J1srWTtkeuHEZuIP4PlwFMSYg=;
 b=Y0D08Q0P05k1HVxqBw+grgcMuFcJG4F0BoDcYqRkRk+SUqZ9blXnCKnSJ8BNsmAJcS
 sFzVAPJhZ7ZHbgi65zJEkmTk4hS7w1TBRE1GlGpppBCmr/LS8kcQgqRrdj5ojrIcKg1W
 MpZkv4tQUJpOy3Zr76l+uCQCkp9HQCdZZS6/Pl/cWBx7GF+mE2E3pJ2sCGJdPxEWhk5Z
 t8PsLnsDsZcVhedPDG6s5yfjbE9VKJ4C3qntfKM1tlkk9WA6Zcm5i5lPkri2hjbaQu9g
 oxXihV5z7nMXtPTDxKShVEckk0zej19927a9ucXa6ATnYwFpBvrwabnbNsaXmaasCJVb
 U9FQ==
X-Gm-Message-State: AGi0PubM6L38Sfz3OH3Ocyt6i5AT6V34oKwoETyJO7kONS9o0uJwblvr
 WcZn4mN/CUDowODc4FkTDBeV+3rMmz/G2Kut/T0=
X-Google-Smtp-Source: APiQypKyHU1RIg6cuLyfSvm/pAX8Zz6MQhM2DaYOZf/avWoXhoss6WFNFG0IJjhNfyxZSp33JJX/Zq5sIAunoWUZ4z4=
X-Received: by 2002:a19:760a:: with SMTP id c10mr3251527lff.126.1588355359407; 
 Fri, 01 May 2020 10:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
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
 <CAE2XoE-W=v5ifho_ze3Xg2Fx1v+VtQ_KvWSf7AuXns5ZYoRoTg@mail.gmail.com>
 <851c309c-37f2-ea4a-b471-52bddde527c7@linaro.org>
In-Reply-To: <851c309c-37f2-ea4a-b471-52bddde527c7@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 2 May 2020 01:49:07 +0800
Message-ID: <CAE2XoE-sSkTf4c0-C3KeMG+B_8MNXJ=+im3E1tuW-z9ffTNshQ@mail.gmail.com>
Subject: Re: About hardfloat in ppc
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f9827a05a499cc30"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x129.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::129
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

--000000000000f9827a05a499cc30
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 2, 2020 at 12:51 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 5/1/20 9:29 AM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > On Fri, May 1, 2020 at 10:18 PM Richard Henderson <
> richard.henderson@linaro.org
> >     Step 1 is to rearrange the fp helpers to eliminate
> helper_reset_fpstatus().
> >     I've mentioned this before, that it's possible to leave the
> steady-state of
> >     env->fp_status.exception_flags =3D=3D 0, so there's no need for a
> separate function
> >     call.  I suspect this is worth a decent speedup by itself.
> >
> > Hi Richard, what kinds of rearrange the fp need to be done? Can you giv=
e
> me a
> > more detailed example? I am still not get the idea.
>
> See target/openrisc, helper_update_fpcsr.
>
> This is like target/ppc helper_float_check_status, in that it is called
> after
> the primary fpu helper, after the fpu result is written back to the
> architectural register, to process fpu exceptions.
>
> Note that if get_float_exception_flags returns non-zero, we immediately
> reset
> them to zero.  Thus the exception flags are only ever non-zero in between
> the
> primary fpu operation and the update of the fpscr.
>
According to
```
void HELPER(update_fpcsr)(CPUOpenRISCState *env)
{
    int tmp =3D get_float_exception_flags(&env->fp_status);

    if (tmp) {
        set_float_exception_flags(0, &env->fp_status);
        tmp =3D ieee_ex_to_openrisc(tmp);
        if (tmp) {
            env->fpcsr |=3D tmp;
            if (env->fpcsr & FPCSR_FPEE) {
                helper_exception(env, EXCP_FPE);
            }
        }
    }
}
```
The openrisc also clearing the flags before each fp operation?

>
> Thus, no need for a separate helper_reset_fpstatus.
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

--000000000000f9827a05a499cc30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 2, 2020 at 12:51 AM Richa=
rd Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.he=
nderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On 5/1/20 9:29 AM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang L=
uo) wrote:<br>
&gt; On Fri, May 1, 2020 at 10:18 PM Richard Henderson &lt;<a href=3D"mailt=
o:richard.henderson@linaro.org" target=3D"_blank">richard.henderson@linaro.=
org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0Step 1 is to rearrange the fp helpers to eliminate =
helper_reset_fpstatus().<br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;ve mentioned this before, that it&#39;s possi=
ble to leave the steady-state of<br>
&gt;=C2=A0 =C2=A0 =C2=A0env-&gt;fp_status.exception_flags =3D=3D 0, so ther=
e&#39;s no need for a separate function<br>
&gt;=C2=A0 =C2=A0 =C2=A0call.=C2=A0 I suspect this is worth a decent speedu=
p by itself.<br>
&gt; <br>
&gt; Hi Richard, what kinds of rearrange the fp need to be done? Can you gi=
ve me a<br>
&gt; more detailed example? I am still not get the idea.<br>
<br>
See target/openrisc, helper_update_fpcsr.<br>
<br>
This is like target/ppc helper_float_check_status, in that it is called aft=
er<br>
the primary fpu helper, after the fpu result is written back to the<br>
architectural register, to process fpu exceptions.<br>
<br>
Note that if get_float_exception_flags returns non-zero, we immediately res=
et<br>
them to zero.=C2=A0 Thus the exception flags are only ever non-zero in betw=
een the<br>
primary fpu operation and the update of the fpscr.<br></blockquote><div>Acc=
ording to=C2=A0</div><div>```</div>void HELPER(update_fpcsr)(CPUOpenRISCSta=
te *env)<br>{<br>=C2=A0 =C2=A0 int tmp =3D get_float_exception_flags(&amp;e=
nv-&gt;fp_status);<br><br>=C2=A0 =C2=A0 if (tmp) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 set_float_exception_flags(0, &amp;env-&gt;fp_status);<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tmp =3D ieee_ex_to_openrisc(tmp);<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (tmp) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;fpc=
sr |=3D tmp;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;fpcsr=
 &amp; FPCSR_FPEE) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 helper_exception(env, EXCP_FPE);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 }<br>} <div>=
```</div><div>The openrisc also clearing the flags before each fp operation=
?</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thus, no need for a separate helper_reset_fpstatus.<br>
<br>
<br>
r~<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000f9827a05a499cc30--

