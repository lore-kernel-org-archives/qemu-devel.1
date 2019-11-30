Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3750DC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 13:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D97482075A
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 13:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+PH8VrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97482075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib33M-0000b4-Vx
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 08:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ib32b-0000B5-7R
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 08:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ib32Z-0007NF-71
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 08:44:05 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ib32X-0007MB-7s
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 08:44:01 -0500
Received: by mail-oi1-x241.google.com with SMTP id o12so28355248oic.9
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 05:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=uiG9CDRzcemhMKgZ9K7eiXKSUoQAMnljBxjbRGz7wlg=;
 b=s+PH8VrU7/1PX8O8yyaxXIVfg4KD9toJXRuEIiX7+A3A6yh+uP5FN4n3W3/NK6g705
 avI1LgCGUFCYS4m7ZkwxEIr4Ngpb3117iHFuKJPuxM1kAqjWMYmtmbK+JfNOK3eKQcZt
 3t+lr+seDr1k2kIs2WdoQUO64omGVNSopxv9laRhxeYv1wFwAH1DkfLyOBOjgfIHRrlS
 bft8sRJ4OflFADCmfJfA+q/dlD1x/mgZfHbGJB3hrUhWMbEYe/a10EBTx/GTHpiEKcWT
 lPyN8Vqgl8nzpl0xEGzvelzQAMjV1K6SIjIczp4O634BwiO6a44iLBiM/Df4fcu7qlHU
 vR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=uiG9CDRzcemhMKgZ9K7eiXKSUoQAMnljBxjbRGz7wlg=;
 b=cLONWk250WVMV4X/F63FGlVrS4P6CwkyTCk/Laspxwtl8uy/Y2l+G3I5P/bBO4fpum
 noEiFIa2McqljbenBHZzacd5zCSWj03fA8r8Wwo8NicRs6e4EVqCjEzdXAAY1j9bCfJH
 VUL255PaLj8rurYT20+3SR96KFcFZrvd7HbCDzLOkd9FLi2ZmsfbL4/Wcg/t/huoZo8k
 H95MGaXSo+Kbl8FsZjm31de3l0q5q6lJLkUsrxIJQUzIEN/StwGLiVhMHfWirIE0oT41
 kV9LSLQZIy6kcai9KuahsIwfYjw50dnlaFytksgyq4yTqL9PP4vXzgJUw+SanJamtAKF
 86Gw==
X-Gm-Message-State: APjAAAVq2akJQAARs+ITadyI1E+UlBrlT7Hp2ousrG80yoBUPf/npyOU
 QL7EK//cq+K2URSGpoiGbk77ZniUa+MRxZv49Sc=
X-Google-Smtp-Source: APXvYqyDIv3XzCD1683siCblIBVAfug0JzfXjZm8JwI3TGsVLcP2q6BTZvSY6UMWqfKqawHP92fwYI3RuBDlHpvb0Og=
X-Received: by 2002:aca:6287:: with SMTP id w129mr4356839oib.106.1575121439325; 
 Sat, 30 Nov 2019 05:43:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sat, 30 Nov 2019 05:43:58
 -0800 (PST)
In-Reply-To: <20191127175257.23480-18-mrolnik@gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-18-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 30 Nov 2019 14:43:58 +0100
Message-ID: <CAL1e-=hP2g1JUoMM0Td5DXawa+MJy-JW0TWckPgfgO_NN3kiDg@mail.gmail.com>
Subject: Re: [PATCH v37 17/17] target/avr: Update MAINTAINERS file
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000de814c0598908958"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000de814c0598908958
Content-Type: text/plain; charset="UTF-8"

On Wednesday, November 27, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> Include AVR maintaners in MAINTAINERS file
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e5e3e52d6..d7bfb62791 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -163,6 +163,17 @@ S: Maintained
>  F: hw/arm/smmu*
>  F: include/hw/arm/smmu*
>
> +AVR TCG CPUs
> +M: Michael Rolnik <mrolnik@gmail.com>
> +R: Sarah Harris <S.E.Harris@kent.ac.uk>
> +S: Maintained
> +F: target/avr/
> +F: hw/misc/avr_mask.c
> +F: hw/char/avr_usart.c
> +F: hw/timer/avr_timer16.c
> +F: hw/avr/
> +F: tests/acceptance/machine_avr6.py
> +



This is from summary from the cover letter:

create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 include/hw/char/avr_usart.h
 create mode 100644 include/hw/misc/avr_mask.h
 create mode 100644 include/hw/timer/avr_timer16.h
 create mode 100644 target/avr/cpu-param.h
 create mode 100644 target/avr/cpu-qom.h
 create mode 100644 target/avr/cpu.h
 create mode 100644 target/avr/helper.h
 create mode 100644 hw/avr/sample.c
 create mode 100644 hw/char/avr_usart.c
 create mode 100644 hw/misc/avr_mask.c
 create mode 100644 hw/timer/avr_timer16.c
 create mode 100644 target/avr/cpu.c
 create mode 100644 target/avr/disas.c
 create mode 100644 target/avr/gdbstub.c
 create mode 100644 target/avr/helper.c
 create mode 100644 target/avr/machine.c
 create mode 100644 target/avr/translate.c
 create mode 100644 gdb-xml/avr-cpu.xml
 create mode 100644 hw/avr/Kconfig
 create mode 100644 hw/avr/Makefile.objs
 create mode 100644 target/avr/Makefile.objs
 create mode 100644 target/avr/insn.decode
 create mode 100644 tests/acceptance/machine_avr6.py


All such new files must be covered by this change in MAINTAINERS. Please
doublecheck.

For example,

include/hw/timer/avr_timer16.h

seems to be not covered.

Thanks,
Aleksandar



>  CRIS TCG CPUs
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  S: Maintained
> --
> 2.17.2 (Apple Git-113)
>
>

--000000000000de814c0598908958
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, November 27, 2019, Michael Rolnik &lt;<a href=3D"mail=
to:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Include AVR maintaners in MAINTAINERS file<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrol=
nik@gmail.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 11 +++++++++++<br>
=C2=A01 file changed, 11 insertions(+)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 5e5e3e52d6..d7bfb62791 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -163,6 +163,17 @@ S: Maintained<br>
=C2=A0F: hw/arm/smmu*<br>
=C2=A0F: include/hw/arm/smmu*<br>
<br>
+AVR TCG CPUs<br>
+M: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrolnik@gmail.c=
om</a>&gt;<br>
+R: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk">S.E.Harris@ke=
nt.ac.uk</a>&gt;<br>
+S: Maintained<br>
+F: target/avr/<br>
+F: hw/misc/avr_mask.c<br>
+F: hw/char/avr_usart.c<br>
+F: hw/timer/avr_timer16.c<br>
+F: hw/avr/<br>
+F: tests/acceptance/machine_avr6.<wbr>py<br>
+</blockquote><div><br></div><div><br></div><div>This is from summary from =
the cover letter:</div><div><br></div><div><span style=3D"font-family:&#39;=
Times New Roman&#39;;font-size:medium">create mode 100644 default-configs/a=
vr-softmmu.</span><wbr style=3D"font-family:&#39;Times New Roman&#39;;font-=
size:medium"><span style=3D"font-family:&#39;Times New Roman&#39;;font-size=
:medium">mak</span><br style=3D"font-family:&#39;Times New Roman&#39;;font-=
size:medium"><span style=3D"font-family:&#39;Times New Roman&#39;;font-size=
:medium">=C2=A0create mode 100644 include/hw/char/avr_usart.h</span><br sty=
le=3D"font-family:&#39;Times New Roman&#39;;font-size:medium"><span style=
=3D"font-family:&#39;Times New Roman&#39;;font-size:medium">=C2=A0create mo=
de 100644 include/hw/misc/avr_mask.h</span><br style=3D"font-family:&#39;Ti=
mes New Roman&#39;;font-size:medium"><span style=3D"font-family:&#39;Times =
New Roman&#39;;font-size:medium">=C2=A0create mode 100644 include/hw/timer/=
avr_timer16.h</span><br style=3D"font-family:&#39;Times New Roman&#39;;font=
-size:medium"><span style=3D"font-family:&#39;Times New Roman&#39;;font-siz=
e:medium">=C2=A0create mode 100644 target/avr/cpu-param.h</span><br style=
=3D"font-family:&#39;Times New Roman&#39;;font-size:medium"><span style=3D"=
font-family:&#39;Times New Roman&#39;;font-size:medium">=C2=A0create mode 1=
00644 target/avr/cpu-qom.h</span><br style=3D"font-family:&#39;Times New Ro=
man&#39;;font-size:medium"><span style=3D"font-family:&#39;Times New Roman&=
#39;;font-size:medium">=C2=A0create mode 100644 target/avr/cpu.h</span><br =
style=3D"font-family:&#39;Times New Roman&#39;;font-size:medium"><span styl=
e=3D"font-family:&#39;Times New Roman&#39;;font-size:medium">=C2=A0create m=
ode 100644 target/avr/helper.h</span><br style=3D"font-family:&#39;Times Ne=
w Roman&#39;;font-size:medium"><span style=3D"font-family:&#39;Times New Ro=
man&#39;;font-size:medium">=C2=A0create mode 100644 hw/avr/sample.c</span><=
br style=3D"font-family:&#39;Times New Roman&#39;;font-size:medium"><span s=
tyle=3D"font-family:&#39;Times New Roman&#39;;font-size:medium">=C2=A0creat=
e mode 100644 hw/char/avr_usart.c</span><br style=3D"font-family:&#39;Times=
 New Roman&#39;;font-size:medium"><span style=3D"font-family:&#39;Times New=
 Roman&#39;;font-size:medium">=C2=A0create mode 100644 hw/misc/avr_mask.c</=
span><br style=3D"font-family:&#39;Times New Roman&#39;;font-size:medium"><=
span style=3D"font-family:&#39;Times New Roman&#39;;font-size:medium">=C2=
=A0create mode 100644 hw/timer/avr_timer16.c</span><br style=3D"font-family=
:&#39;Times New Roman&#39;;font-size:medium"><span style=3D"font-family:&#3=
9;Times New Roman&#39;;font-size:medium">=C2=A0create mode 100644 target/av=
r/cpu.c</span><br style=3D"font-family:&#39;Times New Roman&#39;;font-size:=
medium"><span style=3D"font-family:&#39;Times New Roman&#39;;font-size:medi=
um">=C2=A0create mode 100644 target/avr/disas.c</span><br style=3D"font-fam=
ily:&#39;Times New Roman&#39;;font-size:medium"><span style=3D"font-family:=
&#39;Times New Roman&#39;;font-size:medium">=C2=A0create mode 100644 target=
/avr/gdbstub.c</span><br style=3D"font-family:&#39;Times New Roman&#39;;fon=
t-size:medium"><span style=3D"font-family:&#39;Times New Roman&#39;;font-si=
ze:medium">=C2=A0create mode 100644 target/avr/helper.c</span><br style=3D"=
font-family:&#39;Times New Roman&#39;;font-size:medium"><span style=3D"font=
-family:&#39;Times New Roman&#39;;font-size:medium">=C2=A0create mode 10064=
4 target/avr/machine.c</span><br style=3D"font-family:&#39;Times New Roman&=
#39;;font-size:medium"><span style=3D"font-family:&#39;Times New Roman&#39;=
;font-size:medium">=C2=A0create mode 100644 target/avr/translate.c</span><b=
r style=3D"font-family:&#39;Times New Roman&#39;;font-size:medium"><span st=
yle=3D"font-family:&#39;Times New Roman&#39;;font-size:medium">=C2=A0create=
 mode 100644 gdb-xml/avr-cpu.xml</span><br style=3D"font-family:&#39;Times =
New Roman&#39;;font-size:medium"><span style=3D"font-family:&#39;Times New =
Roman&#39;;font-size:medium">=C2=A0create mode 100644 hw/avr/Kconfig</span>=
<br style=3D"font-family:&#39;Times New Roman&#39;;font-size:medium"><span =
style=3D"font-family:&#39;Times New Roman&#39;;font-size:medium">=C2=A0crea=
te mode 100644 hw/avr/Makefile.objs</span><br style=3D"font-family:&#39;Tim=
es New Roman&#39;;font-size:medium"><span style=3D"font-family:&#39;Times N=
ew Roman&#39;;font-size:medium">=C2=A0create mode 100644 target/avr/Makefil=
e.objs</span><br style=3D"font-family:&#39;Times New Roman&#39;;font-size:m=
edium"><span style=3D"font-family:&#39;Times New Roman&#39;;font-size:mediu=
m">=C2=A0create mode 100644 target/avr/insn.decode</span><br style=3D"font-=
family:&#39;Times New Roman&#39;;font-size:medium"><span style=3D"font-fami=
ly:&#39;Times New Roman&#39;;font-size:medium">=C2=A0create mode 100644 tes=
ts/acceptance/machine_avr6.</span><wbr style=3D"font-family:&#39;Times New =
Roman&#39;;font-size:medium"><span style=3D"font-family:&#39;Times New Roma=
n&#39;;font-size:medium">py</span><br style=3D"font-family:&#39;Times New R=
oman&#39;;font-size:medium"></div><div><span style=3D"font-family:&#39;Time=
s New Roman&#39;;font-size:medium"><br></span></div><div><span style=3D"fon=
t-family:&#39;Times New Roman&#39;;font-size:medium"><br></span></div><div>=
<span style=3D"font-family:&#39;Times New Roman&#39;;font-size:medium">All =
such new files must be covered by this change in MAINTAINERS. Please double=
check.</span></div><div><span style=3D"font-family:&#39;Times New Roman&#39=
;;font-size:medium"><br></span></div><div><span style=3D"font-family:&#39;T=
imes New Roman&#39;;font-size:medium">For example,</span></div><div><span s=
tyle=3D"font-family:&#39;Times New Roman&#39;;font-size:medium"><br></span>=
</div><div><span style=3D"font-family:&#39;Times New Roman&#39;;font-size:m=
edium">include/hw/timer/avr_timer16.h</span><br></div><div><span style=3D"f=
ont-family:&#39;Times New Roman&#39;;font-size:medium"><br></span></div><di=
v><span style=3D"font-family:&#39;Times New Roman&#39;;font-size:medium">se=
ems to be not covered.</span></div><div><br></div><div><span style=3D"font-=
family:&#39;Times New Roman&#39;;font-size:medium">Thanks,</span></div><div=
><span style=3D"font-family:&#39;Times New Roman&#39;;font-size:medium">Ale=
ksandar</span></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
=C2=A0CRIS TCG CPUs<br>
=C2=A0M: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com">=
edgar.iglesias@gmail.com</a>&gt;<br>
=C2=A0S: Maintained<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--000000000000de814c0598908958--

