Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED459C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA4720658
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZt19BLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA4720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbXe-0000oV-Qf
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jHbWc-00006t-RU
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jHbWb-0003NP-66
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:02:58 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jHbWa-0003Ls-VA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:02:57 -0400
Received: by mail-wm1-x341.google.com with SMTP id d1so10168834wmb.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oQLFXCMJ4w3X7wjuOz5gddlquTn/81xe2ZpNp/dZYm0=;
 b=LZt19BLVsvAFU9Q6K7PyUw0AUKqLbZo9aBa+wbzbH5017RDwtSm2THcm0mtDFz0TNH
 v8xCAZOaIIeF/zHbm2aTqufYiSSn6XT1mSDB5on5M+52yR84VRoBaHNp5tjiKpj/jf6+
 let1d44KUuYX7s8g8E4WGMKe1tG4npc9IVTtWLgCUvOWP+O927oulnDnpwJfu3TUchYo
 DVycHLNp0XTiBBg6/f6Vx/Y+aoNIEfOYfMS+idzf6+gZkvV5u2j8W9CKwKRmiZFQN9CI
 pZZfGOOD8OGx1j1JufuWfaWFHKXOFVVTpYBOujLVzm1/4tOiMOk7PesWCD06Q4f4j+ue
 6lLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oQLFXCMJ4w3X7wjuOz5gddlquTn/81xe2ZpNp/dZYm0=;
 b=Mj9RHIanfb0Pua5qiEPz7c4v4TocaunS9ZeHhcrEKk6RLxr9Lg8LzQTOFCneO1GcvS
 VYQoVR3ZfRNn6IZMgSAHQSR5YSQlSm0GySKo+lVE+3AHKpM4mEeBf7vm9iOnqkokjmXg
 hHOXffCPkPnO+cGIhbQ81SU3JstpqW9wrIMNBdDtXTUuu8PoKu+2yIOaKpzr6QNbt/Cm
 WJYdqW16l2Wvu7+PRMMTHwPUD15bj+OjQCtG2trYMPkbQnGBw6mvLZD1tuv8jR6Gq8w8
 nghD/0OTbbBHf1XZBDOrzvJOougBqwVqRZ97IjcE0zapNhM6hAk3C4+DCIIy5pTUODV0
 8aeg==
X-Gm-Message-State: ANhLgQ0V5nInK3GjEVABDNxPNwwLlvn1uzB0lgO74Ju28mNOievnz4E+
 uveDnFbdpnKoXkr1MbnsnD7rDMhRnF+T1TMV0RiF/Q==
X-Google-Smtp-Source: ADFU+vs7QhOZ0Xknfo4Ie38ew1KHmubO6yWAtz9PRBNO26R3DHsNnclnX5xpIULq3WnZf5Zp00HXStbN07RuQHso6c8=
X-Received: by 2002:adf:ba48:: with SMTP id t8mr11643823wrg.329.1585263775531; 
 Thu, 26 Mar 2020 16:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200325100520.206210-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20200325100520.206210-1-jiaxun.yang@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 27 Mar 2020 01:02:41 +0200
Message-ID: <CAHiYmc4+mjtFxvTvrKohG2YBAMVqEAVVDT1e-XfJLC9D_+fnyA@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/mips: Add loongson gs464 core
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: multipart/alternative; boundary="0000000000003747e505a1c9fc41"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: chenhc@lemote.com, aleksandar.rikalo@rt-rk.com,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003747e505a1c9fc41
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

12:05 Sre, 25.03.2020. Jiaxun Yang <jiaxun.yang@flygoat.com> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Loongson gs464 core can be found in Loongson-3A1000 processor.
> This patchset add minimal support for that core.
> There are still some instructions missing, I'm going to work on
> them later.
>
> The corresponding hw board is also missing. I'm using modified kernel
> for malta for testing purpose and planing to take the design of Lemote's
> KVM virtual machine.
>
> Official manual of this core can be found here [1] (In Chinese).
> My collection of instruction documents mainly based on Chinese
> version of manual, binutils gas code and experiments on real machine
> can be found here [2] (In English).
>
> [1]:
http://loongson.cn/uploadfile/cpu/3A1000/Loongson_3A1000_cpu_user_2.pdf
> [2]: https://github.com/FlyGoat/loongson-insn/blob/master/loongson-ext.md
>

Thanks, Jiaxun!

Just to mention whay you probably know, since this is a new feature, this
is too late for 5.0, so we are shooting for integrsying it in 5.1.

Speak to you later of course in more details.

Yours,
Aleksandar

> Jiaxun Yang (3):
>   target/mips: Introduce loongson ext & mmi ASE flags
>   target/mips: Add loongson ext lsdc2 instrustions
>   target/mips: Add loongson gs464 core
>
>  target/mips/mips-defs.h          |   2 +
>  target/mips/translate.c          | 166 ++++++++++++++++++++++++++++++-
>  target/mips/translate_init.inc.c |  25 ++++-
>  3 files changed, 188 insertions(+), 5 deletions(-)
>
> --
> 2.26.0.rc2
>
>

--0000000000003747e505a1c9fc41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">12:05 Sre, 25.03.2020. Jiaxun Yang &lt;<a href=3D"mailto:jia=
xun.yang@flygoat.com">jiaxun.yang@flygoat.com</a>&gt; =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Loongson gs464 core can be found in Loongson-3A1000 processor.<br>
&gt; This patchset add minimal support for that core.<br>
&gt; There are still some instructions missing, I&#39;m going to work on<br=
>
&gt; them later.<br>
&gt;<br>
&gt; The corresponding hw board is also missing. I&#39;m using modified ker=
nel<br>
&gt; for malta for testing purpose and planing to take the design of Lemote=
&#39;s<br>
&gt; KVM virtual machine.<br>
&gt;<br>
&gt; Official manual of this core can be found here [1] (In Chinese).<br>
&gt; My collection of instruction documents mainly based on Chinese<br>
&gt; version of manual, binutils gas code and experiments on real machine<b=
r>
&gt; can be found here [2] (In English).<br>
&gt;<br>
&gt; [1]: <a href=3D"http://loongson.cn/uploadfile/cpu/3A1000/Loongson_3A10=
00_cpu_user_2.pdf">http://loongson.cn/uploadfile/cpu/3A1000/Loongson_3A1000=
_cpu_user_2.pdf</a><br>
&gt; [2]: <a href=3D"https://github.com/FlyGoat/loongson-insn/blob/master/l=
oongson-ext.md">https://github.com/FlyGoat/loongson-insn/blob/master/loongs=
on-ext.md</a><br>
&gt;</p>
<p dir=3D"ltr">Thanks, Jiaxun!</p>
<p dir=3D"ltr">Just to mention whay you probably know, since this is a new =
feature, this is too late for 5.0, so we are shooting for integrsying it in=
 5.1.</p>
<p dir=3D"ltr">Speak to you later of course in more details.</p>
<p dir=3D"ltr">Yours,<br>
Aleksandar</p>
<p dir=3D"ltr">&gt; Jiaxun Yang (3):<br>
&gt; =C2=A0 target/mips: Introduce loongson ext &amp; mmi ASE flags<br>
&gt; =C2=A0 target/mips: Add loongson ext lsdc2 instrustions<br>
&gt; =C2=A0 target/mips: Add loongson gs464 core<br>
&gt;<br>
&gt; =C2=A0target/mips/mips-defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A02 +<br>
&gt; =C2=A0target/mips/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 166 =
++++++++++++++++++++++++++++++-<br>
&gt; =C2=A0target/mips/translate_init.inc.c |=C2=A0 25 ++++-<br>
&gt; =C2=A03 files changed, 188 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; -- <br>
&gt; 2.26.0.rc2<br>
&gt;<br>
&gt;<br>
</p>

--0000000000003747e505a1c9fc41--

