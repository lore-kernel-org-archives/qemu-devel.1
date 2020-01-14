Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014A2C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 23:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B4F24673
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 23:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCWerMbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B4F24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irVWy-0005uw-P2
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 18:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1irVWL-0005Ug-LE
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 18:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1irVWK-00088k-BE
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 18:22:49 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1irVWK-00087M-5U
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 18:22:48 -0500
Received: by mail-ot1-x342.google.com with SMTP id a15so14422511otf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 15:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=guRnfy5AC7Fcl5eyOpeFmBc6Bi5zmCutTNds+yGHRHs=;
 b=NCWerMbmbFafcy/ACF5ItHAHZc8utFcpSauQjwWvLpwN4OFgJPHmPP5/wYd9fZyOXd
 QeVSjg3JZa6r+UvPcxQhkqFTaql8J8p8f46RW/TcbJGHdd5JOT/Ccf+kL+p96SxEwmoU
 eLrOHaMm0DBBHFcduroyHGO7eIUz4N45O1xcu5ppp3eLMuqKSt4QYmbp+0afi3VPuROI
 a/eAfRaL5TeIOTT1pPTjxo6540LBoaklHmdDtWs0npBoe4OKhSIAIBoABwwdtkq+twj8
 dcKFW3UApzTzoQqm6K1OPbKJDex5mLjZ/euUoYPGAxQ3+fJRBNGpIg5/NYuALGcc8oz1
 CIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=guRnfy5AC7Fcl5eyOpeFmBc6Bi5zmCutTNds+yGHRHs=;
 b=I4elK3oV0Ppe75mFzmj2WXpgMRmAD7B35ME0Z3QT3k61tdbq98jb4B/QAoWA9Ch8Nc
 Bdl6KNbyi12KT//6trAOpQrJ5t+PN3V30yox2NYMC4fTf3UyUnQbLiIKZXGu4w2PFe0i
 VZqLyPMguQXMoQRPkxU2qLkrJSMdoEv6TIiNL/81Ec1tB9Q2UwsS0TaPfZXTM8i1x8hY
 dEz7Sll2YhSILfbrhM9QC7y7aO69Jj8LgEIUZNP+AZ6/2P7cJZGqQLsga59N6ZGvwBY4
 2thZypoDqM5jzz+huimqe+neYGSGZ9yLl8KlBHh9Cl88BS4Hyvgjr1LSD4P36ijCAKC8
 c11A==
X-Gm-Message-State: APjAAAUQ45DDph+Rzm5VTxmfn8XQmpAoV3XURxxvGyDNSbLEDqIryO8n
 ++eKqKC1uU9wyNsJo43ZNGO/2m1Zaj3BNnLZ1Mzvvg==
X-Google-Smtp-Source: APXvYqwJbtmVkbpJkJ6uxh035ilSZ1MAQONqqGfJITqY5BDCIvSdbrDtwUX6xjYYq6PTbhF3X9rHjUEMVLtI3YXEgew=
X-Received: by 2002:a9d:198b:: with SMTP id k11mr634085otk.295.1579044167049; 
 Tue, 14 Jan 2020 15:22:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 14 Jan 2020 15:22:46 -0800 (PST)
In-Reply-To: <20200112124913.94959-23-ysato@users.sourceforge.jp>
References: <20200112124913.94959-1-ysato@users.sourceforge.jp>
 <20200112124913.94959-23-ysato@users.sourceforge.jp>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 15 Jan 2020 00:22:46 +0100
Message-ID: <CAL1e-=itxY0Ju=NNokU+qkpatiB-ZosWLAT_2RsmOLan7-fZpw@mail.gmail.com>
Subject: Re: [PATCH v28 22/22] qemu-doc.texi: Add RX section.
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: multipart/alternative; boundary="000000000000a99182059c21de05"
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
Cc: "philmd@redhat.com" <philmd@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a99182059c21de05
Content-Type: text/plain; charset="UTF-8"

On Sunday, January 12, 2020, Yoshinori Sato <ysato@users.sourceforge.jp>
wrote:

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  qemu-doc.texi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
>
It would be nice if you provided an example of qemu command line invocation
that btings RX machine up (see nanomips section as example).

Also, you are missing the commit message. At least add a sentence
elaborating what you added in a more verbose fashion.

Yours,
Aleksandar



> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 39f950471f..81f76074c4 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -1741,6 +1741,7 @@ differences are mentioned in the following sections.
>  * Microblaze System emulator::
>  * SH4 System emulator::
>  * Xtensa System emulator::
> +* RX System emulator::
>  @end menu
>
>  @node PowerPC System emulator
> @@ -2514,6 +2515,30 @@ so should only be used with trusted guest OS.
>
>  @c man end
>
> +@node RX System emulator
> +@section RX System emulator
> +@cindex system emulation (RX)
> +
> +Use the executable @file{qemu-system-rx} to simulate a Virtual RX target.
> +This target emulated following devices.
> +
> +@itemize @minus
> +@item
> +R5F562N8 MCU
> +@item
> +On-chip memory (ROM 512KB, RAM 96KB)
> +@item
> +Interrupt Control Unit (ICUa)
> +@item
> +8Bit Timer x 1CH (TMR0,1)
> +@item
> +Compare Match Timer x 2CH (CMT0,1)
> +@item
> +Serial Communication Interface x 1CH (SCI0)
> +@item
> +External memory 16MByte
> +@end itemize
> +
>  @node QEMU User space emulator
>  @chapter QEMU User space emulator
>
> --
> 2.20.1
>
>
>

--000000000000a99182059c21de05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, January 12, 2020, Yoshinori Sato &lt;<a href=3D"mailto:y=
sato@users.sourceforge.jp">ysato@users.sourceforge.jp</a>&gt; wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">Signed-off-by: Yoshinori Sato &lt;<a href=3D"ma=
ilto:ysato@users.sourceforge.jp">ysato@users.sourceforge.jp</a>&gt;<br>
---<br>
=C2=A0qemu-doc.texi | 25 +++++++++++++++++++++++++<br>
=C2=A01 file changed, 25 insertions(+)<br>
<br></blockquote><div><br></div><div>It would be nice if you provided an ex=
ample of qemu command line invocation that btings RX machine up (see nanomi=
ps section as example).</div><div><br></div><div>Also, you are missing the =
commit message. At least add a sentence elaborating what you added in a mor=
e verbose fashion.</div><div><br></div><div>Yours,</div><div>Aleksandar</di=
v><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/qemu-doc.texi b/qemu-doc.texi<br>
index 39f950471f..81f76074c4 100644<br>
--- a/qemu-doc.texi<br>
+++ b/qemu-doc.texi<br>
@@ -1741,6 +1741,7 @@ differences are mentioned in the following sections.<=
br>
=C2=A0* Microblaze System emulator::<br>
=C2=A0* SH4 System emulator::<br>
=C2=A0* Xtensa System emulator::<br>
+* RX System emulator::<br>
=C2=A0@end menu<br>
<br>
=C2=A0@node PowerPC System emulator<br>
@@ -2514,6 +2515,30 @@ so should only be used with trusted guest OS.<br>
<br>
=C2=A0@c man end<br>
<br>
+@node RX System emulator<br>
+@section RX System emulator<br>
+@cindex system emulation (RX)<br>
+<br>
+Use the executable @file{qemu-system-rx} to simulate a Virtual RX target.<=
br>
+This target emulated following devices.<br>
+<br>
+@itemize @minus<br>
+@item<br>
+R5F562N8 MCU<br>
+@item<br>
+On-chip memory (ROM 512KB, RAM 96KB)<br>
+@item<br>
+Interrupt Control Unit (ICUa)<br>
+@item<br>
+8Bit Timer x 1CH (TMR0,1)<br>
+@item<br>
+Compare Match Timer x 2CH (CMT0,1)<br>
+@item<br>
+Serial Communication Interface x 1CH (SCI0)<br>
+@item<br>
+External memory 16MByte<br>
+@end itemize<br>
+<br>
=C2=A0@node QEMU User space emulator<br>
=C2=A0@chapter QEMU User space emulator<br>
=C2=A0<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote>

--000000000000a99182059c21de05--

