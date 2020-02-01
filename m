Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048E3C33C9E
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 13:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A708F206F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 13:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sc78DA1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A708F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixshP-0007gM-Qe
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 08:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixsgV-0007Dv-Uy
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 08:19:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixsgU-0005Tr-DX
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 08:19:39 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ixsgU-0005QO-7h
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 08:19:38 -0500
Received: by mail-oi1-x244.google.com with SMTP id a142so10199068oii.7
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 05:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=1SdmdbUD1kykmWAWQIR1QZFF7r75Z07c+NoLesdt+ls=;
 b=sc78DA1LImtOyRmkhJamm0nJ8VDT3YV2AfmGpxSwLI7cEGoCSzCYeoct6ia0QPkzPt
 iZufDyZffOY/1UMDtuv5Ojaqr+ddT22c0f5V8oN8LtUb5SjlOzI1Mo2bawKWITEKgESO
 X4zSBLvzCRyJ4Ft1+wcPUuTRz5DWSompH9OZ7+JlBaI2ncdnXSz37zdVez+hGkcX970I
 N9GOzpIn86vpFt/k93nx3cAbpieh6a278DwvWeEnneA7vqMEisViyDg4c6EY8iUNdVs4
 KO4IycJLfI14j5nNaXnt8wQulOBg/jvwdCF2TrTANrfZwPEm1QENR8/fUfuarAfwcYyL
 TFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=1SdmdbUD1kykmWAWQIR1QZFF7r75Z07c+NoLesdt+ls=;
 b=DCQejaUxu6B/6vHayXBzjJYiEYn2rqyk0c81kQOp6WZWMeAX2ojKKYVO5/3LM6XoiR
 Ymhm/+wfsVYjkShVSbIJmy7frzjGpBhpFK+QFt9mVpKuxrzTBCJjy5fW6yzdA0DNp5er
 9UOu2a/gqjk8Mo/Pkgl3nWO/QX84eO3VitP+wOTJ1+CVbJx92u8AfNnkyQgpwpF/0onG
 suwb0Vq8ktMBlsG1YzP6ZIB7/yK75fFkl7sQgFqtLSsKhttG+rZ1gKCbzIMWy/6n91BA
 nNmH0M4nNJ3AtioJaJrpdz1dZ3Vk1UANX3I9AvV6iZ2vE7WOCRYSbwg+ZEzE/x7XtqMH
 2hsg==
X-Gm-Message-State: APjAAAU1IfDCMBogRdpHJL2XXX069dazkurj5IAE4Ai2ZnJHXe43cyne
 kk3hU9OKuYkp98huLVvOAoUDhMWKxMbvvVQ7nzM=
X-Google-Smtp-Source: APXvYqw6dXcV6IBR76KkydCBrydhw/WjgwOEXqFGwd9WsC6kJEeaculLH0N3zodMM9kjr453tlSahT1jQEXbuQWlY1I=
X-Received: by 2002:aca:5248:: with SMTP id g69mr3958576oib.106.1580563177340; 
 Sat, 01 Feb 2020 05:19:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sat, 1 Feb 2020 05:19:36 -0800 (PST)
In-Reply-To: <1580428993-4767-20-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-20-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 1 Feb 2020 14:19:36 +0100
Message-ID: <CAL1e-=ikjR8XvfX0ZtOvy8frBncQ4y2OpMj6XuVEGeGxmtzQ+w@mail.gmail.com>
Subject: Re: [PATCH rc4 19/29] target/avr: Add section about AVR into QEMU
 documentation
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: multipart/alternative; boundary="000000000000bb012c059d838a0b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bb012c059d838a0b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, January 31, 2020, Aleksandar Markovic <
aleksandar.markovic@rt-rk.com> wrote:

> From: Michael Rolnik <mrolnik@gmail.com>
>
> Explains basic ways of using AVR target in QEMU.
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Message-Id: <20200118191416.19934-16-mrolnik@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> [PMD: Fixed typos]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> ---
>  qemu-doc.texi | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
>
Reviewed-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>


> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 2328e7e..aaf4e54 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -1723,6 +1723,7 @@ differences are mentioned in the following sections=
.
>  * Microblaze System emulator::
>  * SH4 System emulator::
>  * Xtensa System emulator::
> +* AVR System emulator::
>  @end menu
>
>  @node PowerPC System emulator
> @@ -2496,6 +2497,56 @@ so should only be used with trusted guest OS.
>
>  @c man end
>
> +@node AVR System emulator
> +@section AVR System emulator
> +@cindex system emulation (AVR)
> +
> +Use the executable @file{qemu-system-avr} to emulates a AVR 8 bit based
> machine
> +having one for the following cores: avr1, avr2, avr25, avr3, avr31,
> avr35, avr4,
> +avr5, avr51, avr6, avrtiny, xmega2, xmega3, xmega4, xmega5, xmega6 and
> xmega7.
> +
> +As for now it supports few Arduino boards for educational and testing
> purposes.
> +These boards use a ATmega controller, which model is limited to USART &
> 16 bit
> +timer devices, enought to run FreeRTOS based applications (like this @ur=
l{
> https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo/AVR=
_
> ATMega2560_GCC/demo.elf,,demo})
> +
> +Following are examples of possible usages, assuming demo.elf is compiled
> for
> +AVR cpu
> +@itemize
> +
> +@item Continuous non interrupted execution
> +@example
> +qemu-system-avr -machine mega2560 -bios demo.elf
> +@end example
> +
> +@item Continuous non interrupted execution with serial output into telne=
t
> window
> +@example
> +qemu-system-avr -machine mega2560 -bios demo.elf -serial
> tcp::5678,server,nowait -nographic
> +@end example
> +and then in another shell
> +@example
> +telnet localhost 5678
> +@end example
> +
> +@item Debugging wit GDB debugger
> +@example
> +qemu-system-avr -machine mega2560 -bios demo.elf -s -S
> +@end example
> +and then in another shell
> +@example
> +avr-gdb demo.elf
> +@end example
> +and then within GDB shell
> +@example
> +target remote :1234
> +@end example
> +
> +@item Print out executed instructions
> +@example
> +qemu-system-avr -machine mega2560 -bios demo.elf -d in_asm
> +@end example
> +
> +@end itemize
> +
>  @node QEMU User space emulator
>  @chapter QEMU User space emulator
>
> --
> 2.7.4
>
>

--000000000000bb012c059d838a0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, January 31, 2020, Aleksandar Markovic &lt;<a href=3D"mai=
lto:aleksandar.markovic@rt-rk.com">aleksandar.markovic@rt-rk.com</a>&gt; wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">From: Michael Rolnik &lt;<a href=3D"=
mailto:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt;<br>
<br>
Explains basic ways of using AVR target in QEMU.<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrol=
nik@gmail.com</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20200118191416.19934-16-mrolnik@gmail.com=
">20200118191416.19934-16-<wbr>mrolnik@gmail.com</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org">richard.henderson@linaro.org</a>&gt;<br>
[PMD: Fixed typos]<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org">f4bug@amsat.org</a>&gt;<br>
Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@=
gmail.com">aleksandar.m.mail@gmail.com</a>&gt;<br>
---<br>
=C2=A0qemu-doc.texi | 51 ++++++++++++++++++++++++++++++<wbr>+++++++++++++++=
++++++<br>
=C2=A01 file changed, 51 insertions(+)<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_blan=
k" style=3D"font-size:14px;line-height:22.1200008392334px">aleksandar.m.mai=
l@gmail.com</a><span style=3D"color:rgb(34,34,34);font-size:14px;line-heigh=
t:22.1200008392334px">&gt;</span><br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
diff --git a/qemu-doc.texi b/qemu-doc.texi<br>
index 2328e7e..aaf4e54 100644<br>
--- a/qemu-doc.texi<br>
+++ b/qemu-doc.texi<br>
@@ -1723,6 +1723,7 @@ differences are mentioned in the following sections.<=
br>
=C2=A0* Microblaze System emulator::<br>
=C2=A0* SH4 System emulator::<br>
=C2=A0* Xtensa System emulator::<br>
+* AVR System emulator::<br>
=C2=A0@end menu<br>
<br>
=C2=A0@node PowerPC System emulator<br>
@@ -2496,6 +2497,56 @@ so should only be used with trusted guest OS.<br>
<br>
=C2=A0@c man end<br>
<br>
+@node AVR System emulator<br>
+@section AVR System emulator<br>
+@cindex system emulation (AVR)<br>
+<br>
+Use the executable @file{qemu-system-avr} to emulates a AVR 8 bit based ma=
chine<br>
+having one for the following cores: avr1, avr2, avr25, avr3, avr31, avr35,=
 avr4,<br>
+avr5, avr51, avr6, avrtiny, xmega2, xmega3, xmega4, xmega5, xmega6 and xme=
ga7.<br>
+<br>
+As for now it supports few Arduino boards for educational and testing purp=
oses.<br>
+These boards use a ATmega controller, which model is limited to USART &amp=
; 16 bit<br>
+timer devices, enought to run FreeRTOS based applications (like this @url{=
<a href=3D"https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos=
/Demo/AVR_ATMega2560_GCC/demo.elf,,demo" target=3D"_blank">https://github.c=
om/<wbr>seharris/qemu-avr-tests/blob/<wbr>master/free-rtos/Demo/AVR_<wbr>AT=
Mega2560_GCC/demo.elf,,demo</a>}<wbr>)<br>
+<br>
+Following are examples of possible usages, assuming demo.elf is compiled f=
or<br>
+AVR cpu<br>
+@itemize<br>
+<br>
+@item Continuous non interrupted execution<br>
+@example<br>
+qemu-system-avr -machine mega2560 -bios demo.elf<br>
+@end example<br>
+<br>
+@item Continuous non interrupted execution with serial output into telnet =
window<br>
+@example<br>
+qemu-system-avr -machine mega2560 -bios demo.elf -serial tcp::5678,server,=
nowait -nographic<br>
+@end example<br>
+and then in another shell<br>
+@example<br>
+telnet localhost 5678<br>
+@end example<br>
+<br>
+@item Debugging wit GDB debugger<br>
+@example<br>
+qemu-system-avr -machine mega2560 -bios demo.elf -s -S<br>
+@end example<br>
+and then in another shell<br>
+@example<br>
+avr-gdb demo.elf<br>
+@end example<br>
+and then within GDB shell<br>
+@example<br>
+target remote :1234<br>
+@end example<br>
+<br>
+@item Print out executed instructions<br>
+@example<br>
+qemu-system-avr -machine mega2560 -bios demo.elf -d in_asm<br>
+@end example<br>
+<br>
+@end itemize<br>
+<br>
=C2=A0@node QEMU User space emulator<br>
=C2=A0@chapter QEMU User space emulator<br>
=C2=A0<br>
-- <br>
2.7.4<br>
<br>
</blockquote>

--000000000000bb012c059d838a0b--

