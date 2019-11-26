Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB69C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 20:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD81E20684
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 20:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvD9luSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD81E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZhgz-00087o-KV
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 15:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iZhfX-0007BL-GX
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:42:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iZhfV-0008Rr-JK
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:42:43 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:35056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iZhfT-0008Ql-OE
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:42:39 -0500
Received: by mail-qk1-x744.google.com with SMTP id v23so9591241qkg.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 12:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nr3DpFRunGKaTPLHOFurQMw1hlckcmpl09CG6Iluacw=;
 b=EvD9luSkph93FSNDfugqUhWv6ScD0t/lUah8daGM0KeifMbWiLwefGhNTviq5+nu/Y
 x6iMcxNBoH4WGYQLNhAyHRQapZZrHLHu86O2qUDdRqkdWDqZ7QqiGJO/me1Arhgk/2O7
 QXt1+KbW2Kcv1guVzPM/glUSp+RVV7324L10qu9vR7/WiNcoyvOdK5lxBgEtD5yz5cBJ
 810iVDcfiSnpAyTGFSEK1dUsFgYwz5Vgzrw77KtrvPdkzC+7NSHz9iPeEF98mk1bjX5x
 /fF4pdbTq1Sslecl4fLMxH1jYbX2S/UsTqQIDlmLEd+8AfAQb1txWjJYF+dG5J/EmTWV
 PQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nr3DpFRunGKaTPLHOFurQMw1hlckcmpl09CG6Iluacw=;
 b=I1pXvAQgMSxx0rMQzhMSbxW3HPfuqkTz3w/+jEKwvthmGOplbOAiOQhQeRJb5D39Pi
 ses8LLtSpXKqIaWL5UScPRr7ouzisMf44DQHKkszVR7vnlRprjmrogBPBOfB+yRzSBT4
 BH4I8FzISvAsnR7kbjB7iEXW+wxBZvyMHB1MLME7zZRJG2RFvbr44ESlhK2MsLyk37su
 RlVjBsQKkpuKhLI4ozyEHAl8nEZ3LD/FXX6bOtMOE89dFh/K74a2GgFYfq3cez2t5Zd3
 NE/xOIILaxKoTm49xVuRHHCejpHSzFEJxDOjWXBzSzUIDJP4rb50DD0BZzLOp8Lgeu+L
 0D6w==
X-Gm-Message-State: APjAAAUfmV/AAhReJ2SyP4y7bQy8wVyV8M6Dl88xmBrbJ0+OzQ2g4Wnf
 OpeN9gafW0RyUEBjPHFVgxLjO11pBCXS8lEGuXA=
X-Google-Smtp-Source: APXvYqxdbHsdhIzFmc7NJaPKHZgJK6vUBkiS0BH2BQv7FwoW+TTAjB+xKByIu1qJkJhHobONHM+KkFwq5jhPSOhJ9lk=
X-Received: by 2002:a37:8a05:: with SMTP id m5mr332168qkd.181.1574800958754;
 Tue, 26 Nov 2019 12:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-18-mrolnik@gmail.com>
 <CAL1e-=gBBFRxAsDnRyQqiZSLWhMmfyp2YXge4E12VaEmEG=a9g@mail.gmail.com>
 <CAK4993jvnA+rkBQzyp7jCY5Vo6TLzL8A7uN+ah8hmJa3-d4YFg@mail.gmail.com>
 <CAL1e-=hzDtugeN37fPsck9ZsOBS1EbWW4YExz8TeMm+S305nAQ@mail.gmail.com>
In-Reply-To: <CAL1e-=hzDtugeN37fPsck9ZsOBS1EbWW4YExz8TeMm+S305nAQ@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Tue, 26 Nov 2019 22:41:32 +0200
Message-ID: <CAK4993hFYyw43JZaWBBX4r--jxyNBYWkfURoj+nZRSEn7E5rvw@mail.gmail.com>
Subject: Re: [PATCH v36 17/17] target/avr: Update MAINTAINERS file
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000bd12b2059845eb3c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bd12b2059845eb3c
Content-Type: text/plain; charset="UTF-8"

Ah. I think Sarah was ok with reviewer role.

On Tue, Nov 26, 2019 at 9:39 PM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

> On Tue, Nov 26, 2019 at 8:06 PM Michael Rolnik <mrolnik@gmail.com> wrote:
> >
> > Aleksandar,
> >
> > there was an email from Sarah, stating that she does not want to be a
> maintainer.
> >
>
> But this is for "reviewer" role, not "maintainer".
>
> Sarah?
>
> > On Tue, Nov 26, 2019 at 5:17 AM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
> >>
> >>
> >>
> >> On Sunday, November 24, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
> >>>
> >>> Include AVR maintaners in MAINTAINERS file
> >>>
> >>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> >>> ---
> >>>  MAINTAINERS | 9 +++++++++
> >>>  1 file changed, 9 insertions(+)
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 5e5e3e52d6..ad2d9dd04a 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -163,6 +163,15 @@ S: Maintained
> >>>  F: hw/arm/smmu*
> >>>  F: include/hw/arm/smmu*
> >>>
> >>> +AVR TCG CPUs
> >>> +M: Michael Rolnik <mrolnik@gmail.com>
> >>> +S: Maintained
> >>> +F: target/avr/
> >>> +F: hw/misc/avr_mask.c
> >>> +F: hw/char/avr_usart.c
> >>> +F: hw/timer/avr_timer16.c
> >>> +F: hw/avr/
> >>> +
> >>
> >>
> >> I had a strange feeling that something is missing here, and I finally
> realized what that was:
> >>
> >> R: Sarah Harris <S.E.Harris@kent.ac.uk>
> >>
> >> https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04225.html
> >>
> >>
> >>
> >>>  CRIS TCG CPUs
> >>>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> >>>  S: Maintained
> >>> --
> >>> 2.17.2 (Apple Git-113)
> >>>
> >
> >
> > --
> > Best Regards,
> > Michael Rolnik
>


-- 
Best Regards,
Michael Rolnik

--000000000000bd12b2059845eb3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ah. I think Sarah was ok with reviewer=C2=A0role.</div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, N=
ov 26, 2019 at 9:39 PM Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar=
.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Nov 26, 2019 at 8:06 =
PM Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank=
">mrolnik@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Aleksandar,<br>
&gt;<br>
&gt; there was an email from Sarah, stating that she does not want to be a =
maintainer.<br>
&gt;<br>
<br>
But this is for &quot;reviewer&quot; role, not &quot;maintainer&quot;.<br>
<br>
Sarah?<br>
<br>
&gt; On Tue, Nov 26, 2019 at 5:17 AM Aleksandar Markovic &lt;<a href=3D"mai=
lto:aleksandar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.=
com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Sunday, November 24, 2019, Michael Rolnik &lt;<a href=3D"mailto=
:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Include AVR maintaners in MAINTAINERS file<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gm=
ail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;=C2=A0 MAINTAINERS | 9 +++++++++<br>
&gt;&gt;&gt;=C2=A0 1 file changed, 9 insertions(+)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt;&gt;&gt; index 5e5e3e52d6..ad2d9dd04a 100644<br>
&gt;&gt;&gt; --- a/MAINTAINERS<br>
&gt;&gt;&gt; +++ b/MAINTAINERS<br>
&gt;&gt;&gt; @@ -163,6 +163,15 @@ S: Maintained<br>
&gt;&gt;&gt;=C2=A0 F: hw/arm/smmu*<br>
&gt;&gt;&gt;=C2=A0 F: include/hw/arm/smmu*<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; +AVR TCG CPUs<br>
&gt;&gt;&gt; +M: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" ta=
rget=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt;&gt;&gt; +S: Maintained<br>
&gt;&gt;&gt; +F: target/avr/<br>
&gt;&gt;&gt; +F: hw/misc/avr_mask.c<br>
&gt;&gt;&gt; +F: hw/char/avr_usart.c<br>
&gt;&gt;&gt; +F: hw/timer/avr_timer16.c<br>
&gt;&gt;&gt; +F: hw/avr/<br>
&gt;&gt;&gt; +<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I had a strange feeling that something is missing here, and I fina=
lly realized what that was:<br>
&gt;&gt;<br>
&gt;&gt; R: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk" targe=
t=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-10/m=
sg04225.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/ar=
chive/html/qemu-devel/2019-10/msg04225.html</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 CRIS TCG CPUs<br>
&gt;&gt;&gt;=C2=A0 M: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesia=
s@gmail.com" target=3D"_blank">edgar.iglesias@gmail.com</a>&gt;<br>
&gt;&gt;&gt;=C2=A0 S: Maintained<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; 2.17.2 (Apple Git-113)<br>
&gt;&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Best Regards,<br>
&gt; Michael Rolnik<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000bd12b2059845eb3c--

