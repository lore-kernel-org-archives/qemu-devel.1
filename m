Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ECDC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E16C20709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N78WDKkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E16C20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLGf-0004RK-86
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jFLFY-0003Qz-6A
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jFLFW-00029w-D9
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:16:00 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jFLFW-00028E-5b
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:15:58 -0400
Received: by mail-wr1-x443.google.com with SMTP id h9so8432176wrc.8
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YdWr2z2d5hGPRmCBX3Lg6f4pIOW/5rrz9zQawyJdXuE=;
 b=N78WDKkc/STHdeKy0wrsBzTWr0VcMv1rYkg0pgZEFYR7+nX3Mn9dtgNnTxhYEUyuEl
 v90FWHt8nVccSPQlt3ux7LaJo4tlZaAYaEGRS8ODnUvtMcWlDVZSFUs3hyXY1uUiz0pv
 byea79tlNsKivrQk0q3b14en6RGSr/c9GDeL0K0NzV/2OjO5WiD9DNQuw1/seUj4nOyY
 Vtq1Zr68YAhEZKuC7z+TZnHYKb8AvdbasKidufzJtjyB7GC7VgLt8S25gx3goDJhjtaN
 uXSRfPfR0wylXTr0V+kl2+u0yu1V2N8ghHAxoiq9IPog9gqH2H0iEC9HYtqTaq1wTgrs
 Xkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YdWr2z2d5hGPRmCBX3Lg6f4pIOW/5rrz9zQawyJdXuE=;
 b=rFk5bLEovMgHv8Y10NB8oNOvAJ3QoTdAohPX16PE40ZepzBGjwfdwHtyxkphU6qQ3J
 zQGWCvSe1FVLVWuqk5CrDuT23DQckpLZx38FqmHkOXddazUP+fXTckilD1EBGNfpA/O3
 OKoY6PWtwaKSbnqa7Y9LUx7UAkJlxOr8RgdcHNc/xAb3LyUX1e2zuJzpNme4DKXCmMbs
 TpHcweYxksFcGly6qpTWX2EYshN3+0+U+6AHF/m9MBKw6sz5wQkL93jQR/SRXQMWZV9F
 PUFsOAW1tlLwpoNNN6gikq+gdYbh7xfIOktbPOSrmux2VSNl7tVltRms0PGN3SpQyocH
 KxlQ==
X-Gm-Message-State: ANhLgQ1XZY5JWrs5pWrma+TiwNpnKbhN5bHFR61TFM3IvMGbppd3YqJa
 KCvzAa9bffMG6ZNUqwy8M194MCryktmHqBlF9+k=
X-Google-Smtp-Source: ADFU+vuUsL6yWD4b9suaqAc18Smmxwl0EhOpCCrLJPqRuIDrpInmVdHTxrg/wppkY8Njxj91tFk9DYow27Agweali6U=
X-Received: by 2002:adf:f24c:: with SMTP id b12mr150963wrp.162.1584724553761; 
 Fri, 20 Mar 2020 10:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200320114522.16273-1-alex.bennee@linaro.org>
 <CAHiYmc7vOK=DD0Cb623x3PDJW_NS2H+Y79jcWT1Kujxij5Jsrg@mail.gmail.com>
In-Reply-To: <CAHiYmc7vOK=DD0Cb623x3PDJW_NS2H+Y79jcWT1Kujxij5Jsrg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 20 Mar 2020 18:15:42 +0100
Message-ID: <CAHiYmc4ZMArN=HU8ZWqBJvt5GgeuN3XJbgMcQf65CVdbgyAQJw@mail.gmail.com>
Subject: Re: [RFC PATCH for 5.0] configure: disable MTTCG for MIPS guests
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000018099505a14c7070"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000018099505a14c7070
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=B5=D1=82, 20. =D0=BC=D0=B0=D1=80 2020. =D1=83 18:08 Aleksandar Ma=
rkovic <
aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> =D0=BF=D0=B5=D1=82, 20. =D0=BC=D0=B0=D1=80 2020. =D1=83 12:45 Alex Benn=
=C3=A9e <alex.bennee@linaro.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > While debugging check-acceptance failures I found an instability in
> > the mips64el test case. Briefly the test case:
> >
> >   retry.py -n 100 -c -- ./mips64el-softmmu/qemu-system-mips64el \
> >     -display none -vga none -serial mon:stdio \
> >     -machine malta -kernel ./vmlinux-4.7.0-rc1.I6400 \
> >     -cpu I6400 -smp 8 -vga std \
> >     -append "printk.time=3D0 clocksource=3DGIC console=3Dtty0 console=
=3DttyS0
panic=3D-1" \
> >     --no-reboot
> >
>
> Thank for the findings!
>
> Could you perhaps attach or link to "retry.py"?
>

Is this the script you used:

https://github.com/stsquad/retry/blob/master/retry.py

> Did you run this particular test for the first time now, or it used to
> pass before?
>
> Thanks,
> Aleksandar
>
> > Reports about a 9% failure rate:
> >
> >   Results summary:
> >   0: 91 times (91.00%), avg time 5.547 (0.45 varience/0.67 deviation)
> >   -6: 9 times (9.00%), avg time 3.394 (0.02 varience/0.13 deviation)
> >   Ran command 100 times, 91 passes
> >
> > When re-run with "--accel tcg,thread=3Dsingle" the instability goes
> > away.
> >
> >   Results summary:
> >   0: 100 times (100.00%), avg time 17.318 (249.76 varience/15.80
deviation)
> >   Ran command 100 times, 100 passes
> >
> > Which seems to indicate there is some aspect of the MIPS MTTCG fixes
> > that has been missed. Ideally we would fix that but I'm afraid I don't
> > have time to investigate and am not super familiar with the
> > architecture anyway.
> >
> > I've disabled all the mips guests as I assume it's a fundamental
> > synchronisation primitive that is broken but I haven't tested them all
> > (there are a lot!).
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> > Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  configure | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/configure b/configure
> > index 206d22c5153..002792d21dc 100755
> > --- a/configure
> > +++ b/configure
> > @@ -7832,19 +7832,19 @@ case "$target_name" in
> >      echo "TARGET_ABI32=3Dy" >> $config_target_mak
> >    ;;
> >    mips|mipsel)
> > -    mttcg=3D"yes"
> > +    mttcg=3D"no"
> >      TARGET_ARCH=3Dmips
> >      echo "TARGET_ABI_MIPSO32=3Dy" >> $config_target_mak
> >    ;;
> >    mipsn32|mipsn32el)
> > -    mttcg=3D"yes"
> > +    mttcg=3D"no"
> >      TARGET_ARCH=3Dmips64
> >      TARGET_BASE_ARCH=3Dmips
> >      echo "TARGET_ABI_MIPSN32=3Dy" >> $config_target_mak
> >      echo "TARGET_ABI32=3Dy" >> $config_target_mak
> >    ;;
> >    mips64|mips64el)
> > -    mttcg=3D"yes"
> > +    mttcg=3D"no"
> >      TARGET_ARCH=3Dmips64
> >      TARGET_BASE_ARCH=3Dmips
> >      echo "TARGET_ABI_MIPSN64=3Dy" >> $config_target_mak
> > --
> > 2.20.1
> >

--00000000000018099505a14c7070
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>=D0=BF=D0=B5=D1=82, 20. =D0=BC=D0=B0=D1=80 2020. =
=D1=83 18:08 Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.deve=
l@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>&gt;<br>&gt; =D0=BF=D0=
=B5=D1=82, 20. =D0=BC=D0=B0=D1=80 2020. =D1=83 12:45 Alex Benn=C3=A9e &lt;<=
a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; =D1=
=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>&gt; =
&gt;<br>&gt; &gt; While debugging check-acceptance failures I found an inst=
ability in<br>&gt; &gt; the mips64el test case. Briefly the test case:<br>&=
gt; &gt;<br>&gt; &gt; =C2=A0 retry.py -n 100 -c -- ./mips64el-softmmu/qemu-=
system-mips64el \<br>&gt; &gt; =C2=A0 =C2=A0 -display none -vga none -seria=
l mon:stdio \<br>&gt; &gt; =C2=A0 =C2=A0 -machine malta -kernel ./vmlinux-4=
.7.0-rc1.I6400 \<br>&gt; &gt; =C2=A0 =C2=A0 -cpu I6400 -smp 8 -vga std \<br=
>&gt; &gt; =C2=A0 =C2=A0 -append &quot;printk.time=3D0 clocksource=3DGIC co=
nsole=3Dtty0 console=3DttyS0 panic=3D-1&quot; \<br>&gt; &gt; =C2=A0 =C2=A0 =
--no-reboot<br>&gt; &gt;<br>&gt;<br>&gt; Thank for the findings!<br>&gt;<br=
>&gt; Could you perhaps attach or link to &quot;retry.py&quot;?<br>&gt;<br>=
<br>Is this the script you used:<br><br><a href=3D"https://github.com/stsqu=
ad/retry/blob/master/retry.py">https://github.com/stsquad/retry/blob/master=
/retry.py</a><br><br>&gt; Did you run this particular test for the first ti=
me now, or it used to<br>&gt; pass before?<br>&gt;<br>&gt; Thanks,<br>&gt; =
Aleksandar<br>&gt;<br>&gt; &gt; Reports about a 9% failure rate:<br>&gt; &g=
t;<br>&gt; &gt; =C2=A0 Results summary:<br>&gt; &gt; =C2=A0 0: 91 times (91=
.00%), avg time 5.547 (0.45 varience/0.67 deviation)<br>&gt; &gt; =C2=A0 -6=
: 9 times (9.00%), avg time 3.394 (0.02 varience/0.13 deviation)<br>&gt; &g=
t; =C2=A0 Ran command 100 times, 91 passes<br>&gt; &gt;<br>&gt; &gt; When r=
e-run with &quot;--accel tcg,thread=3Dsingle&quot; the instability goes<br>=
&gt; &gt; away.<br>&gt; &gt;<br>&gt; &gt; =C2=A0 Results summary:<br>&gt; &=
gt; =C2=A0 0: 100 times (100.00%), avg time 17.318 (249.76 varience/15.80 d=
eviation)<br>&gt; &gt; =C2=A0 Ran command 100 times, 100 passes<br>&gt; &gt=
;<br>&gt; &gt; Which seems to indicate there is some aspect of the MIPS MTT=
CG fixes<br>&gt; &gt; that has been missed. Ideally we would fix that but I=
&#39;m afraid I don&#39;t<br>&gt; &gt; have time to investigate and am not =
super familiar with the<br>&gt; &gt; architecture anyway.<br>&gt; &gt;<br>&=
gt; &gt; I&#39;ve disabled all the mips guests as I assume it&#39;s a funda=
mental<br>&gt; &gt; synchronisation primitive that is broken but I haven&#3=
9;t tested them all<br>&gt; &gt; (there are a lot!).<br>&gt; &gt;<br>&gt; &=
gt; Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linar=
o.org">alex.bennee@linaro.org</a>&gt;<br>&gt; &gt; Cc: Aleksandar Markovic =
&lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.deve=
l@gmail.com</a>&gt;<br>&gt; &gt; Cc: Aurelien Jarno &lt;<a href=3D"mailto:a=
urelien@aurel32.net">aurelien@aurel32.net</a>&gt;<br>&gt; &gt; Cc: Aleksand=
ar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@rt-rk.com">aleksandar.rik=
alo@rt-rk.com</a>&gt;<br>&gt; &gt; Cc: Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt;<br>&gt; &gt; ---<br>=
&gt; &gt; =C2=A0configure | 6 +++---<br>&gt; &gt; =C2=A01 file changed, 3 i=
nsertions(+), 3 deletions(-)<br>&gt; &gt;<br>&gt; &gt; diff --git a/configu=
re b/configure<br>&gt; &gt; index 206d22c5153..002792d21dc 100755<br>&gt; &=
gt; --- a/configure<br>&gt; &gt; +++ b/configure<br>&gt; &gt; @@ -7832,19 +=
7832,19 @@ case &quot;$target_name&quot; in<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0echo &quot;TARGET_ABI32=3Dy&quot; &gt;&gt; $config_target_mak<br>&gt; &g=
t; =C2=A0 =C2=A0;;<br>&gt; &gt; =C2=A0 =C2=A0mips|mipsel)<br>&gt; &gt; - =
=C2=A0 =C2=A0mttcg=3D&quot;yes&quot;<br>&gt; &gt; + =C2=A0 =C2=A0mttcg=3D&q=
uot;no&quot;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0TARGET_ARCH=3Dmips<br>&gt; &g=
t; =C2=A0 =C2=A0 =C2=A0echo &quot;TARGET_ABI_MIPSO32=3Dy&quot; &gt;&gt; $co=
nfig_target_mak<br>&gt; &gt; =C2=A0 =C2=A0;;<br>&gt; &gt; =C2=A0 =C2=A0mips=
n32|mipsn32el)<br>&gt; &gt; - =C2=A0 =C2=A0mttcg=3D&quot;yes&quot;<br>&gt; =
&gt; + =C2=A0 =C2=A0mttcg=3D&quot;no&quot;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0TARGET_ARCH=3Dmips64<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0TARGET_BASE_ARCH=
=3Dmips<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0echo &quot;TARGET_ABI_MIPSN32=3Dy&=
quot; &gt;&gt; $config_target_mak<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0echo &qu=
ot;TARGET_ABI32=3Dy&quot; &gt;&gt; $config_target_mak<br>&gt; &gt; =C2=A0 =
=C2=A0;;<br>&gt; &gt; =C2=A0 =C2=A0mips64|mips64el)<br>&gt; &gt; - =C2=A0 =
=C2=A0mttcg=3D&quot;yes&quot;<br>&gt; &gt; + =C2=A0 =C2=A0mttcg=3D&quot;no&=
quot;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0TARGET_ARCH=3Dmips64<br>&gt; &gt; =
=C2=A0 =C2=A0 =C2=A0TARGET_BASE_ARCH=3Dmips<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0echo &quot;TARGET_ABI_MIPSN64=3Dy&quot; &gt;&gt; $config_target_mak<br>&=
gt; &gt; --<br>&gt; &gt; 2.20.1<br>&gt; &gt;</div>

--00000000000018099505a14c7070--

