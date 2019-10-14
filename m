Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A3AC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 08:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D14120663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 08:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thGBklkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D14120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJvdV-0002Go-LR
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 04:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iJvcR-0001lf-D2
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iJvcQ-0006mV-0w
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:22:19 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45545)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iJvcP-0006lt-Pg
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:22:17 -0400
Received: by mail-ot1-x342.google.com with SMTP id 41so13066286oti.12
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 01:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=fXhSjdi2X2+Z/yOHtTsMRlX2f4iyRoKjXpkKpX1YgYQ=;
 b=thGBklkdXmqAgcyPnOVsk21+Vk70AArD3zRjjtE7I5x/fqQMwM04BElms9oQlSAE2V
 VcxV3hAztdfGOqDu2R2Z4OqLKjqfB9ZogPxf1ZOFn0+5h63LYJwZCCCrajeWD1Aa5tt6
 zDJzghE2Y6nlSXiPfpYVCbi2MunmgFKhTStvVXduLp1yaiKBcff0GOp1N/18OaML8l2D
 IMfsgYPRbTNEJfIBSUJsSDg2YPx40YZsS+EFIBecCGToGQSQBJqeKGEuxEzIu4I9h7Pq
 Hh6Iw2/sNA15LAWto8sE/C+xIHanH7BgUi0vq4S/tsce+qlx0OWWjtHTgXlHLV5qPiy8
 CKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=fXhSjdi2X2+Z/yOHtTsMRlX2f4iyRoKjXpkKpX1YgYQ=;
 b=VwMPgFkjocRjyOSUYsFE5UKee0C2nJtpjl7ajSrVfkzmaJT0P7ZSSTNDWwRZGx9dKN
 T1aQ2ahyUNgMLwVHUF80YjlU84N8WsPrtnBuDkekLOe2QV5/0TOok+tFjdDCh4ofoVDU
 7S6BsWv4ekbK3NDemalk8SXLNWBhaqiUsODUH5FrccVJ2Fcr6WJ1yNOpYJrXRYX1CXXY
 HZibVezUoiX/5hW78u99itddp2q/Inr9vaG6Pr8/RAg+QpRJ2mQcAdOGlAt3jyFshpPr
 lvF0B9Gea5i1cZuWfjd6ZVI4rtsWvL1UJIKwLybtERM0LuJ2h7e2QbdJweJko/eZvSMm
 NAxQ==
X-Gm-Message-State: APjAAAWM7206R97aK29WjkMArw4lAOSvRa4/nGCrMwyzBvCXhrLH21xo
 sAUqt1eCxxc6wJsxHcCGC/GXauY782YMM3asRrs=
X-Google-Smtp-Source: APXvYqzNZf6cklLKAo9xhNrspDTC2UgOmNhBfRLyepM8tWFC4lOvvpMs9df8hBMgYKTc9Vzaik0zlhhy6TC20dsTcLs=
X-Received: by 2002:a9d:684c:: with SMTP id c12mr24017637oto.341.1571041336757; 
 Mon, 14 Oct 2019 01:22:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Mon, 14 Oct 2019 01:22:16
 -0700 (PDT)
In-Reply-To: <87eezf6b5r.fsf@dusky.pond.sub.org>
References: <1570901866-9548-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1570901866-9548-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <87eezf6b5r.fsf@dusky.pond.sub.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 14 Oct 2019 10:22:16 +0200
Message-ID: <CAL1e-=hZt6zEpP2Hm1eZ0yZLOTc4TBCZXc2q_MuaytYsZN28LA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] target/mips: Clean up helper.c
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ce11680594da90af"
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ce11680594da90af
Content-Type: text/plain; charset="UTF-8"

On Monday, October 14, 2019, Markus Armbruster <armbru@redhat.com> wrote:

> Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:
>
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Mostly fix errors and warnings reported by 'checkpatch.pl -f'.
> >
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > ---
> >  target/mips/helper.c | 128 ++++++++++++++++++++++++++++++
> +--------------------
> >  1 file changed, 78 insertions(+), 50 deletions(-)
> >
> > diff --git a/target/mips/helper.c b/target/mips/helper.c
> > index a2b6459..2411a2c 100644
> > --- a/target/mips/helper.c
> > +++ b/target/mips/helper.c
> [...]
> > @@ -130,8 +133,11 @@ static int is_seg_am_mapped(unsigned int am, bool
> eu, int mmu_idx)
> >      int32_t adetlb_mask;
> >
> >      switch (mmu_idx) {
> > -    case 3 /* ERL */:
> > -        /* If EU is set, always unmapped */
> > +    case 3:
> > +        /*
> > +         * ERL
> > +         * If EU is set, always unmapped
> > +         */
> >          if (eu) {
> >              return 0;
> >          }
>
> Did you miss my review comment?


I just thought you soon realized that that your comment misinterpreted the
content of the patch. Anyway, I responded to your comment to v4.

Aleksandar



>
> Message-ID: <874l0ydk00.fsf@dusky.pond.sub.org>
> https://lists.nongnu.org/archive/html/qemu-devel/2019-09/msg06719.html
>
> [...]
>
>

--000000000000ce11680594da90af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, October 14, 2019, Markus Armbruster &lt;<a href=3D"mailt=
o:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.markovic=
@rt-rk.com">aleksandar.markovic@rt-rk.com</a>&gt; writes:<br>
<br>
&gt; From: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com=
">amarkovic@wavecomp.com</a>&gt;<br>
&gt;<br>
&gt; Mostly fix errors and warnings reported by &#39;<a href=3D"http://chec=
kpatch.pl" target=3D"_blank">checkpatch.pl</a> -f&#39;.<br>
&gt;<br>
&gt; Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wav=
ecomp.com">amarkovic@wavecomp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/mips/helper.c | 128 ++++++++++++++++++++++++++++++<wbr>+-=
-------------------<br>
&gt;=C2=A0 1 file changed, 78 insertions(+), 50 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/mips/helper.c b/target/mips/helper.c<br>
&gt; index a2b6459..2411a2c 100644<br>
&gt; --- a/target/mips/helper.c<br>
&gt; +++ b/target/mips/helper.c<br>
[...]<br>
&gt; @@ -130,8 +133,11 @@ static int is_seg_am_mapped(unsigned int am, bool=
 eu, int mmu_idx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int32_t adetlb_mask;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 switch (mmu_idx) {<br>
&gt; -=C2=A0 =C2=A0 case 3 /* ERL */:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If EU is set, always unmapped */<br>
&gt; +=C2=A0 =C2=A0 case 3:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ERL<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If EU is set, always unmapped<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (eu) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Did you miss my review comment?</blockquote><div><br></div><div>I just thou=
ght you soon realized that that your comment misinterpreted the content of =
the patch. Anyway, I responded to your comment to v4.</div><div><br></div><=
div>Aleksandar</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
<br>
Message-ID: &lt;<a href=3D"mailto:874l0ydk00.fsf@dusky.pond.sub.org">874l0y=
dk00.fsf@dusky.pond.sub.org</a>&gt;<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2019-09/msg0671=
9.html" target=3D"_blank">https://lists.nongnu.org/<wbr>archive/html/qemu-d=
evel/2019-<wbr>09/msg06719.html</a><br>
<br>
[...]<br>
<br>
</blockquote>

--000000000000ce11680594da90af--

