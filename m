Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1E0CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485FB21925
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaA5KH52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485FB21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLr25-00034o-5h
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLr0V-0001wl-3K
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLr0U-0003my-1d
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:51:07 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34218)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLr0T-0003m9-P8
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:51:05 -0400
Received: by mail-ot1-x342.google.com with SMTP id m19so7561709otp.1
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=4ItKQVWZu6nJ0t/d3+CFdPWYbQyOtjqoxx1KzN3wEt8=;
 b=jaA5KH52tsIN5zguws+MYw9Z4rQvvKV4dbxwo49Ni2v3bzjZiQsaviX+3FH5TXErA5
 +ZMoTORM4iVcMgtKF6LP7Q4g5Q37v27Jtx3uQfdV3Ptbqq7c1V5hRbqANaop92ExJkSZ
 UAUXN3Qznn4a73c7gU1PyrW2Xe9bxXctkNo90lfUo/aWNRzYJuyZd3KtEgkWEmOlUVQJ
 EY+4ebw7nVaOJBWPSRr4xKF6GlNBNO9j0CRbQ+ZDcyfvzJoQqZaBtD4x1reo7D2XgKDG
 ja87S5qHcCFYxnShYsgTCscQgReLquL2CeGp+PlypH+7Li6Q8vyI4wRMYCefbxDCfxsu
 OO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=4ItKQVWZu6nJ0t/d3+CFdPWYbQyOtjqoxx1KzN3wEt8=;
 b=DIbewkiubSMAq8GeWLpQhI7jALKNCQFb2dqJQb1Sa+ZNm85aLBRCwxk7n3rJTGdZi5
 iRkNVK1mQ1T+VKthAgZaQmFcFRHu9LHevZsoFKdai/+l4wht23fYD58eOjPsyTePvvPF
 QkrqPwoSE+sCKlDdnd5CtVCfIL9VRohmvBMG2Nmv0MQ+N0uIC2q87wxcLpEw1L5XNGwf
 OIFDSDbVSvPJHaRzJ8OHei3SwVtm4oUc9tDWYlfPeC0XW6zeHDpHImUkLsQH0BhTSkIW
 JfSRAXTs/VhsPKEWRls4kksIUSWv0oeYTUcTJB+TyQoOqfn7w2BkMz7gF3JKFsGDWaK4
 O+Tg==
X-Gm-Message-State: APjAAAWMOdEc8wD5BLT3cIQtjOzUTx0V8xPozW8826awaMaJu9KJlUR+
 RmqC//71XyWTwAUoneYB4qOVFGxz1KoAAXSw3pQ=
X-Google-Smtp-Source: APXvYqyucmEaAX/URE1AYVhO0YhAmPWLK6bgd52bsGx/FGZQB6qrjL1EADhDwQuPTUPf/oL6oi4YQBHhttNxUKBX4WE=
X-Received: by 2002:a9d:5914:: with SMTP id t20mr11954525oth.306.1571500263353; 
 Sat, 19 Oct 2019 08:51:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 19 Oct 2019 08:51:03
 -0700 (PDT)
In-Reply-To: <20191019153437.9820-9-f4bug@amsat.org>
References: <20191019153437.9820-1-f4bug@amsat.org>
 <20191019153437.9820-9-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 19 Oct 2019 17:51:03 +0200
Message-ID: <CAL1e-=hWwmSBTZW5SRs7TzxEtyUFu-gep9-zfptZOn1c0vXZ0g@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] tests/ssh_linux_malta: Remove duplicated test
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000f632650595456a67"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f632650595456a67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, October 19, 2019, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> Remove duplicated test (probably copy/paste error in
> commit 9090d3332cdcc).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/linux_ssh_mips_malta.py | 3 ---
>  1 file changed, 3 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/tests/acceptance/linux_ssh_mips_malta.py
> b/tests/acceptance/linux_ssh_mips_malta.py
> index 27907e8fbd..5523ae2144 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -140,9 +140,6 @@ class LinuxSSH(Test):
>          self.ssh_command_output_contains(
>              'cat /proc/interrupts',
>              'eth0')
> -        self.ssh_command_output_contains(
> -            'cat /proc/interrupts',
> -            'eth0')
>          self.ssh_command_output_contains(
>              'cat /proc/devices',
>              'input')
> --
> 2.21.0
>
>
>

--000000000000f632650595456a67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, October 19, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">Remove duplicated test (probably copy/paste error in<b=
r>
commit 9090d3332cdcc).<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0tests/acceptance/linux_ssh_<wbr>mips_malta.py | 3 ---<br>
=C2=A01 file changed, 3 deletions(-)<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" style=3D"font-size:1=
4px;line-height:22.1200008392334px">amarkovic@wavecomp.com</a><span style=
=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">&gt;=
</span><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/tests/acceptance/linux_ssh_<wbr>mips_malta.py b/tests/acceptan=
ce/linux_ssh_<wbr>mips_malta.py<br>
index 27907e8fbd..5523ae2144 100644<br>
--- a/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
+++ b/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
@@ -140,9 +140,6 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cat /proc/interrupts&#=
39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;eth0&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ssh_command_output_<wbr>contains(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;cat /proc/interrupts&#39;,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;eth0&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cat /proc/devices&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;input&#39;)<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000f632650595456a67--

