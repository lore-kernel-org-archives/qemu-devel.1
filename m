Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4493CA9ECF
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 01:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD80C21855
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 01:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF5xUSWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD80C21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQi39-0001Cz-T2
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 21:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hiroyuki.obinata@gmail.com>) id 1iQi2E-0000Yq-Dg
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 21:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hiroyuki.obinata@gmail.com>) id 1iQi2D-0008OB-1L
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 21:16:58 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:44607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hiroyuki.obinata@gmail.com>)
 id 1iQi2C-0008LW-PC; Fri, 01 Nov 2019 21:16:56 -0400
Received: by mail-lf1-x142.google.com with SMTP id v4so8425747lfd.11;
 Fri, 01 Nov 2019 18:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eruML1/25dKlqgZ7K3BVzp2Qya68T9UzemSWytJpWk4=;
 b=NF5xUSWXboyFD1NmgUkdleJnB7dxo4VrMHDY9Ovm4MqUeb+dyNb1ea2jWFppiuLcUg
 s/juhSfme5M/NRdy1XcEVCljYCTdRLt9kipXTUycTD4w1cmLjLqYWS42NpSaZUF9iQ2P
 IUQcEmsrFjSudm4VRIY7v4g2EFlXeNxNE2b6LahB8a61IuIMphRxzmY5WTuCFcejTMRV
 /pcGq1t0u/SdkTiW56pbtPSm99msafzcGDbu2RzgcMiHZqS/9x1COPt5TZ/fVoae10uF
 YqZlA1v68xH/SdwHINBEZepsSWD486CM8OpyN4KCBWsxJVWTSK2mL2fI0CFXGBbJ4KTS
 HhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eruML1/25dKlqgZ7K3BVzp2Qya68T9UzemSWytJpWk4=;
 b=OY7a6lkNCqPOIKNuR5bs/Y5m/HE5eZSlN+pxl7H30A8RC4YySL9/tZyZ5Jpo6TpNsK
 GA+9O8ji5Cm1/KlK7loUJpdqfdDO0U4mcg+zLpQPZ+TQMmrJte8DQadE+oLxdAugkiGY
 bxg8BVyERCGjh2l6R3zjyKLUN7sR9zJ28YcLXqxWlkTfflZx3d+wo6FL80iihvFFZ5bo
 9IEai6K7sM5ikMcZwnrISkTAQqY4NzKGhiVosgORaI4Ndpk5HmFp03BqioFW4JG4gau0
 C91TZIyuBGN5zG99np1JMsLJJUqms3sstLcCuNHKXG4UVrQO/D6QnE96GmQzpmdVa1A3
 X8gg==
X-Gm-Message-State: APjAAAWSJfdMzptkH2+gpzekOlO7woRLrg6SrsW/qBddI8meIpDbPw+5
 RXvpmCVSIBDR1Zb4AwhgCB6z30Scm159AdnKhVA=
X-Google-Smtp-Source: APXvYqwqkQXpC4IBuXHSmmWS3Eb7zTS3ZjOwUltGPVleMI/LbVh1j5Rq40hD7mg2U5nt5mCUHrXhbuP53EDivEBVbSQ=
X-Received: by 2002:a19:655b:: with SMTP id c27mr8889812lfj.122.1572657414534; 
 Fri, 01 Nov 2019 18:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191030002318.399-1-hiroyuki.obinata@gmail.com>
 <mhng-7b7098a1-1195-4532-80ab-2d7c51ebd2ed@palmer-si-x1c4>
In-Reply-To: <mhng-7b7098a1-1195-4532-80ab-2d7c51ebd2ed@palmer-si-x1c4>
From: Obinata Hiroyuki <hiroyuki.obinata@gmail.com>
Date: Sat, 2 Nov 2019 10:16:45 +0900
Message-ID: <CA+0n8CN3YC56nMpZqCQD_kCzFaZN+uign5NGj=SgAW5E+tKQLA@mail.gmail.com>
Subject: Re: [PATCH] remove unnecessary ifdef TARGET_RISCV64
To: Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: multipart/alternative; boundary="0000000000008bfc7b059652d6f6"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, qemu-devel@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008bfc7b059652d6f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks!

2019=E5=B9=B411=E6=9C=882=E6=97=A5(=E5=9C=9F) 1:58 Palmer Dabbelt <palmer@d=
abbelt.com>:

> On Tue, 29 Oct 2019 17:23:18 PDT (-0700), hiroyuki.obinata@gmail.com
> wrote:
> > From: "hiroyuki.obinata" <hiroyuki.obinata@gmail.com>
> >
> > Signed-off-by: Hiroyuki Obinata <hiroyuki.obinata@gmail.com>
> > ---
> >  target/riscv/translate.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> > index adeddb85f6..5c4dd21a98 100644
> > --- a/target/riscv/translate.c
> > +++ b/target/riscv/translate.c
> > @@ -64,12 +64,10 @@ static const int tcg_memop_lookup[8] =3D {
> >      [0] =3D MO_SB,
> >      [1] =3D MO_TESW,
> >      [2] =3D MO_TESL,
> > +    [3] =3D MO_TEQ,
> >      [4] =3D MO_UB,
> >      [5] =3D MO_TEUW,
> > -#ifdef TARGET_RISCV64
> > -    [3] =3D MO_TEQ,
> >      [6] =3D MO_TEUL,
> > -#endif
> >  };
> >  #endif
>
> Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
>
> This is a non-functional change (the code in question was already wrapped
> in an
> "#ifdef TARGET_RISCV64", so this internal one was redundant), so I'm happ=
y
> to
> include it during the soft freeze.
>
> I've added this to the queue for my next PR.
>

--0000000000008bfc7b059652d6f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks!</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">2019=E5=B9=B411=E6=9C=882=E6=97=A5(=E5=9C=9F) 1:58 =
Palmer Dabbelt &lt;<a href=3D"mailto:palmer@dabbelt.com">palmer@dabbelt.com=
</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue=
, 29 Oct 2019 17:23:18 PDT (-0700), <a href=3D"mailto:hiroyuki.obinata@gmai=
l.com" target=3D"_blank">hiroyuki.obinata@gmail.com</a> wrote:<br>
&gt; From: &quot;hiroyuki.obinata&quot; &lt;<a href=3D"mailto:hiroyuki.obin=
ata@gmail.com" target=3D"_blank">hiroyuki.obinata@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Signed-off-by: Hiroyuki Obinata &lt;<a href=3D"mailto:hiroyuki.obinata=
@gmail.com" target=3D"_blank">hiroyuki.obinata@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/riscv/translate.c | 4 +---<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/riscv/translate.c b/target/riscv/translate.c<br>
&gt; index adeddb85f6..5c4dd21a98 100644<br>
&gt; --- a/target/riscv/translate.c<br>
&gt; +++ b/target/riscv/translate.c<br>
&gt; @@ -64,12 +64,10 @@ static const int tcg_memop_lookup[8] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [0] =3D MO_SB,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [1] =3D MO_TESW,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [2] =3D MO_TESL,<br>
&gt; +=C2=A0 =C2=A0 [3] =3D MO_TEQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [4] =3D MO_UB,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [5] =3D MO_TEUW,<br>
&gt; -#ifdef TARGET_RISCV64<br>
&gt; -=C2=A0 =C2=A0 [3] =3D MO_TEQ,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [6] =3D MO_TEUL,<br>
&gt; -#endif<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 #endif<br>
<br>
Reviewed-by: Palmer Dabbelt &lt;<a href=3D"mailto:palmer@dabbelt.com" targe=
t=3D"_blank">palmer@dabbelt.com</a>&gt;<br>
<br>
This is a non-functional change (the code in question was already wrapped i=
n an <br>
&quot;#ifdef TARGET_RISCV64&quot;, so this internal one was redundant), so =
I&#39;m happy to <br>
include it during the soft freeze.<br>
<br>
I&#39;ve added this to the queue for my next PR.<br>
</blockquote></div>

--0000000000008bfc7b059652d6f6--

