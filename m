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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433E0CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068BA21925
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVjBtID/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068BA21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLr0M-0001cs-7H
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLqzf-0000zK-5D
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLqzd-0003Oi-UL
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:50:15 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33752)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLqzd-0003OV-Oa
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:50:13 -0400
Received: by mail-ot1-x341.google.com with SMTP id 60so7544953otu.0
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=okewcac+k/FGiLvBKZxmTxQbtcxDc4pRTVpebATnKKs=;
 b=GVjBtID/kDzN6+uTpPzEPdnrSVmKOqj6EqqmyI+odo4wY5qu7SOZRFQIdxhl3rJLfD
 0cYrghVzU6nMMUUbJHqvz3XGUiacaY3DCwNkwu7hKh1xC0+cvro/guIeAc0pIF1Kzmwk
 Z84Ha1HCWG0RtCEQcpzIU1vjs3icQR6pEjBS/hv19jXaXmHSo5b300fsGH/P2E6QT49z
 YxOcWqAzftq1d1HWuu5jTx8CzUu/XIwK00ioy0QO/O7WvYAJFXGe8SOaDb1r5PAGn4SC
 LPb4BKARXml/tJS2xJG03a7YLcvpoasq0akkD4md9DNUu+WN1/TO1npql+Zf3snKy1dw
 FE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=okewcac+k/FGiLvBKZxmTxQbtcxDc4pRTVpebATnKKs=;
 b=elX3gcxzEw1ok1EXE/KoTPxD7brpadzET8yASfjn66ek2M9nZkd4woyHmV6wfUIE/W
 CnWNE6m54VQiDJ6lyXnsvMgZxwBfBixDUNSf9TSFJG3ginlqAOXdVpLYrcNNvk3VSOJm
 MBT1GKUBsEAo5nEDxtkRJem/iEknaqHetu7IAmVb34no6FwgXqFlbPH3iZ30EISMkNhx
 Ftv4R/+TizkYvz00VsMAala++QWPK4kRChUbBuZYReljfvrmU/ClSp+z59YmjavwmqIK
 EqR9L4FN2q3u5StNMZNGs9ENy9Gaib0LW6bZ+fowV+l3SXBSyFfYq4rkUw6qruy0fE+k
 ldNA==
X-Gm-Message-State: APjAAAWFDd+dT3Jpl2BYT+ywnz7fNR/8EpqQVLHlUpHZKgqjdjaE3sUO
 Ap54zNOeE42As71Z4gC/gXG68wUfj9OZAYehViw=
X-Google-Smtp-Source: APXvYqw6LrSzQX+7lb9hbKBmD4dIpqaOAlfijzBfEgd0titShGoomk4x8G/5XgRBgIjYYCuX1x2JsJhkSx+LrDoZifA=
X-Received: by 2002:a05:6830:452:: with SMTP id
 d18mr12336368otc.295.1571500212935; 
 Sat, 19 Oct 2019 08:50:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 19 Oct 2019 08:50:12
 -0700 (PDT)
In-Reply-To: <20191019153437.9820-10-f4bug@amsat.org>
References: <20191019153437.9820-1-f4bug@amsat.org>
 <20191019153437.9820-10-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 19 Oct 2019 17:50:12 +0200
Message-ID: <CAL1e-=jbCDmME8aBdOyKB6r=d3jiLGSZsYCy-Ck8h7_zhpRn6g@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] tests/ssh_linux_malta: Match stricter console
 output
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000f4e10d0595456730"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

--000000000000f4e10d0595456730
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, October 19, 2019, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> Match on stricter console output.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/linux_ssh_mips_malta.py | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/tests/acceptance/linux_ssh_mips_malta.py
> b/tests/acceptance/linux_ssh_mips_malta.py
> index 5523ae2144..822b0553ff 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -127,19 +127,19 @@ class LinuxSSH(Test):
>              '3.2.0-4-4kc-malta')
>          self.ssh_command_output_contains(
>              'cat /proc/interrupts',
> -            'timer')
> +            'XT-PIC  timer')
>          self.ssh_command_output_contains(
>              'cat /proc/interrupts',
> -            'i8042')
> +            'XT-PIC  i8042')
>          self.ssh_command_output_contains(
>              'cat /proc/interrupts',
> -            'serial')
> +            'XT-PIC  serial')
>          self.ssh_command_output_contains(
>              'cat /proc/interrupts',
> -            'ata_piix')
> +            'XT-PIC  ata_piix')
>          self.ssh_command_output_contains(
>              'cat /proc/interrupts',
> -            'eth0')
> +            'XT-PIC  eth0')
>          self.ssh_command_output_contains(
>              'cat /proc/devices',
>              'input')
> @@ -151,13 +151,13 @@ class LinuxSSH(Test):
>              'fb')
>          self.ssh_command_output_contains(
>              'cat /proc/ioports',
> -            'serial')
> +            ' : serial')
>          self.ssh_command_output_contains(
>              'cat /proc/ioports',
> -            'ata_piix')
> +            ' : ata_piix')
>          self.ssh_command_output_contains(
>              'cat /proc/ioports',
> -            'piix4_smbus')
> +            ' : piix4_smbus')
>          self.ssh_command_output_contains(
>              'lspci -d 11ab:4620',
>              'GT-64120')
> @@ -167,7 +167,7 @@ class LinuxSSH(Test):
>          self.ssh_command_output_contains(
>              'cat /proc/mtd',
>              'YAMON')
> -        # Empty 'Board Config'
> +        # Empty 'Board Config' (64KB)
>          self.ssh_command_output_contains(
>              'md5sum /dev/mtd2ro',
>              '0dfbe8aa4c20b52e1b8bf3cb6cbdf193')
> --
> 2.21.0
>
>
>

--000000000000f4e10d0595456730
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, October 19, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">Match on stricter console output.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0tests/acceptance/linux_ssh_<wbr>mips_malta.py | 18 +++++++++---------=
<br>
=C2=A01 file changed, 9 insertions(+), 9 deletions(-)<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:amarkovic@wavecomp.com" style=3D"font-size:1=
4px;line-height:22.1200008392334px">amarkovic@wavecomp.com</a><span style=
=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">&gt;=
</span></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/tests/acceptance/linux_ssh_<wbr>mips_malta.py b/tests/acceptan=
ce/linux_ssh_<wbr>mips_malta.py<br>
index 5523ae2144..822b0553ff 100644<br>
--- a/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
+++ b/tests/acceptance/linux_ssh_<wbr>mips_malta.py<br>
@@ -127,19 +127,19 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;3.2.0-4-4kc-malta&#39;=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cat /proc/interrupts&#=
39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;timer&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;XT-PIC=C2=A0 timer&#39;)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cat /proc/interrupts&#=
39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;i8042&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;XT-PIC=C2=A0 i8042&#39;)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cat /proc/interrupts&#=
39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;serial&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;XT-PIC=C2=A0 serial&#39;)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cat /proc/interrupts&#=
39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;ata_piix&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;XT-PIC=C2=A0 ata_piix&#39;)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cat /proc/interrupts&#=
39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;eth0&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;XT-PIC=C2=A0 eth0&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cat /proc/devices&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;input&#39;)<br>
@@ -151,13 +151,13 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;fb&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cat /proc/ioports&#39;=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;serial&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39; : serial&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cat /proc/ioports&#39;=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;ata_piix&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39; : ata_piix&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cat /proc/ioports&#39;=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;piix4_smbus&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39; : piix4_smbus&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;lspci -d 11ab:4620&#39=
;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;GT-64120&#39;)<br>
@@ -167,7 +167,7 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;cat /proc/mtd&#39;,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;YAMON&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Empty &#39;Board Config&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Empty &#39;Board Config&#39; (64KB)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command_output_<wbr>contains(<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;md5sum /dev/mtd2ro&#39=
;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;<wbr>0dfbe8aa4c20b52e1=
b8bf3cb6cbdf1<wbr>93&#39;)<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000f4e10d0595456730--

