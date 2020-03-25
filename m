Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E184C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DAD206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmqO6rYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DAD206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3gJ-0002dD-5K
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jH3f5-0001jy-PV
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jH3f2-0004Uu-Qk
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:53:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jH3f2-0004SU-JX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:53:24 -0400
Received: by mail-wr1-x442.google.com with SMTP id j17so2313139wru.13
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 03:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5XaAHoZuXLEs4wLzVSQtN4XQW32FLxIC6ssK3SuyAJk=;
 b=UmqO6rYInVC/tI/Jk3T52ziJRzmvuz27NaWExR7+YFUZUKacgrQvSFy+LX01oe6Dyo
 2uPZDZf7IDu1ZGUNzi+Fn5uRbeVNdNBzK7NHk2/UWAlkL8HnViJG4Wm+Yex4EVUdMFJC
 GLNUP19iiczulptZ78o3xKCC4Wyh7hMwaeCAa4Y82OstpZIEjrr3YMJZTGK4/kxVWmlG
 jvuN+bloREP8VUxZ9bxQKc+U+qqu0V9ve/KnT7Lg7e6iKdWjBbQfnNR63tZ8DkeQF2WG
 0VdZvBetOIJWn2/n6LsrOCUiDRZR6aVpF8iDvMK587pZsAgJmeJsQqjNJ890On/4/QN6
 fMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5XaAHoZuXLEs4wLzVSQtN4XQW32FLxIC6ssK3SuyAJk=;
 b=EG/1zdhvxLxna0vd7VKDzIPgcQQ86dvfAUzsLlKXuIjUqJKKelHc82txwAmqGiXG+i
 C6vTm6AQ4ArcRU4b64mdjvMkTzKWDA0w//PHhN4i5ec7qTuDyRhqYQFkL/39CdLJKspt
 jRa8TAhLb6YpS14AVYZzxCJ3XllurQLWNYO0/+om0FQCh+8nhzPj3FD2uKk1EI9iOH8N
 HBbfPDdlFy5SPHla6WpgpTa1B53ZMBJkhzmJ8PjmGCNZ4pG5lD1gssDTINKraWEyPi9W
 URe9ksLIt0tTBLUhTgnj4rNV/8bkl2/qNASF85/vCLwBZy55XaHt7Jt0Ss96nit5F5xO
 xQ7w==
X-Gm-Message-State: ANhLgQ3L6TmPnngR1jebM+gVjGi35GuD00OCbk4pl4BFapSHd+ie7LLB
 xcb/5gnPij465vNqIIhrLUk/Q+uVYLL1ryuT3Do=
X-Google-Smtp-Source: ADFU+vubbIfu09fsa58YSPwQ7+GkJqT1Bzaa1WoVdM9G9TP+yzf7WNsR0hmMeFZrqwI6n8KUZUquVmAFo4V1I9e41ww=
X-Received: by 2002:adf:efc2:: with SMTP id i2mr2743697wrp.420.1585133603213; 
 Wed, 25 Mar 2020 03:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200323161514.23952-1-alex.bennee@linaro.org>
 <20200323161514.23952-7-alex.bennee@linaro.org>
 <20e5e10b-a2ac-06ed-edb4-5d4250c1775a@linaro.org>
In-Reply-To: <20e5e10b-a2ac-06ed-edb4-5d4250c1775a@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 25 Mar 2020 12:53:04 +0200
Message-ID: <CAHiYmc6G-RhqRxK7Dn2KAv3oN4yYy8HbiJbyHfTF-TKXgDbJmw@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] configure: disable MTTCG for MIPS guests
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000057579d05a1abad98"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000057579d05a1abad98
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

20:17 Pon, 23.03.2020. Richard Henderson <richard.henderson@linaro.org> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 3/23/20 9:15 AM, Alex Benn=C3=A9e wrote:
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
> > architecture anyway. In lieu of someone tracking down the failure lets
> > disable it for now.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Aleksandar Markovic <aleksandar.qem u.devel@gmail.com>

But, Alex, I expect this patch will go through your queue, not MIPS queue
(unless you told me otherwise).

Thanks,
Aleksandar

>
> r~

--00000000000057579d05a1abad98
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">20:17 Pon, 23.03.2020. Richard Henderson &lt;<a href=3D"mail=
to:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; =D1=
=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On 3/23/20 9:15 AM, Alex Benn=C3=A9e wrote:<br>
&gt; &gt; While debugging check-acceptance failures I found an instability =
in<br>
&gt; &gt; the mips64el test case. Briefly the test case:<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0retry.py -n 100 -c -- ./mips64el-softmmu/qemu-system-=
mips64el \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-display none -vga none -serial mon:stdio \<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-machine malta -kernel ./vmlinux-4.7.0-rc1.I64=
00 \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-cpu I6400 -smp 8 -vga std \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-append &quot;printk.time=3D0 clocksource=3DGI=
C console=3Dtty0 console=3DttyS0 panic=3D-1&quot; \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0--no-reboot<br>
&gt; &gt; <br>
&gt; &gt; Reports about a 9% failure rate:<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0Results summary:<br>
&gt; &gt;=C2=A0 =C2=A00: 91 times (91.00%), avg time 5.547 (0.45 varience/0=
.67 deviation)<br>
&gt; &gt;=C2=A0 =C2=A0-6: 9 times (9.00%), avg time 3.394 (0.02 varience/0.=
13 deviation)<br>
&gt; &gt;=C2=A0 =C2=A0Ran command 100 times, 91 passes<br>
&gt; &gt; <br>
&gt; &gt; When re-run with &quot;--accel tcg,thread=3Dsingle&quot; the inst=
ability goes<br>
&gt; &gt; away.<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0Results summary:<br>
&gt; &gt;=C2=A0 =C2=A00: 100 times (100.00%), avg time 17.318 (249.76 varie=
nce/15.80 deviation)<br>
&gt; &gt;=C2=A0 =C2=A0Ran command 100 times, 100 passes<br>
&gt; &gt; <br>
&gt; &gt; Which seems to indicate there is some aspect of the MIPS MTTCG fi=
xes<br>
&gt; &gt; that has been missed. Ideally we would fix that but I&#39;m afrai=
d I don&#39;t<br>
&gt; &gt; have time to investigate and am not super familiar with the<br>
&gt; &gt; architecture anyway. In lieu of someone tracking down the failure=
 lets<br>
&gt; &gt; disable it for now.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee=
@linaro.org">alex.bennee@linaro.org</a>&gt;<br>
&gt; &gt; Acked-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org">f4bug@amsat.org</a>&gt;<br>
&gt; &gt; Cc: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.dev=
el@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt;<br>
&gt; &gt; Cc: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net">au=
relien@aurel32.net</a>&gt;<br>
&gt; &gt; Cc: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@rt-=
rk.com">aleksandar.rikalo@rt-rk.com</a>&gt;<br>
&gt;<br>
&gt; Acked-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org">richard.henderson@linaro.org</a>&gt;<br>
&gt;</p>
<p dir=3D"ltr">Reviewed-by: Aleksandar Markovic &lt;aleksandar.qem <a href=
=3D"mailto:u.devel@gmail.com">u.devel@gmail.com</a>&gt;</p>
<p dir=3D"ltr">But, Alex, I expect this patch will go through your queue, n=
ot MIPS queue (unless you told me otherwise).</p>
<p dir=3D"ltr">Thanks,<br>
Aleksandar<br></p>
<p dir=3D"ltr">&gt;<br>
&gt; r~<br>
</p>

--00000000000057579d05a1abad98--

