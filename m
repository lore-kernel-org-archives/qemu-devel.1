Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D5BC4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 22:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487CC2081B
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 22:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4P3S6Kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487CC2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEL3p-0000b5-DT
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 18:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iEL1o-0007Go-0F
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 18:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iEL1m-0006WZ-8Q
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 18:17:23 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:37332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iEL1i-0006QC-77; Sat, 28 Sep 2019 18:17:18 -0400
Received: by mail-oi1-x231.google.com with SMTP id i16so8105788oie.4;
 Sat, 28 Sep 2019 15:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=PnkgMaLNeBkLur23q8hxdDYhFHavGcUUQeJANgTOqKc=;
 b=o4P3S6Kxj6zvFVt1oYY9TvUMhceIMOaK+2XGNw5acpNh2Tl2vjHOWcylA8ArfoqRin
 iZEpxVQm0QpGuXlH8gASw/Fxjkf0b7VBtirogTsvjUFkO6ZXJ3iF/Ld4r17CJ+HPI3to
 e7+lfgp+/5MIoP9lJuLQnwNXKpwU8dvjBKBsHu6/tddSPwPeHbJZ9Dnc8iRiKJBa+85R
 2gGpExsNtJHU6UhUHoWG79Hm2NihU1m4+YnREJGU4y5FkvQwffs4t72y4zHIiXC6Jy2C
 pMIA7V1f5Tgu2VtR1OTLQq+hW1ZX7xhIrnJ/EBvmbeTK1m+0X2xOUGpD2Ct0nF8Dnt7z
 mvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=PnkgMaLNeBkLur23q8hxdDYhFHavGcUUQeJANgTOqKc=;
 b=rPhLPrK1QDp2McBTLktEg2W0PhXc84Fdi8Nyw3LYi8OW4NTRxaOT2bn7xYzwpC/b8A
 RyIl5QhIh0xbt32COlzFMz61ofhAa2aNnx18NwSuly4ntiPpZraVe/4gX1E3shyFDeDT
 M0/wqNtcMgva2nxes13nmESAXGRgpZka4rJ5/BWaq+7W5orS5jYpncTa2Y1m+0kS2Pub
 61NsQDJLKX9oYhcrmmk6rFgl/sP3/aRDRS5XwvVgPn/OG0Y9mCGhuF/XSjFrHYSlFkMO
 Xbi7iQA4Gcx0bHDGQDCdMVbv8e4t63MdXiXeT6/+mFSvTtpY2mC8MxNjEegGhY5J93+e
 u/0w==
X-Gm-Message-State: APjAAAULCDXE9WUOjm3NQHfmrDA7d3oUxjHAUXRAVwBOB/kir6zuPll7
 99hrT5clplqHWM8S3DZDPaLzmo6i7AIMeEoGu40=
X-Google-Smtp-Source: APXvYqyrCo3wPZLsCz6EiF9CS9CY8Vrxn54vyKAMpeTWT/CnRd+B1IUKRFDUcb8xMPGqFbyYTBBWliOOKrZ3+XopclU=
X-Received: by 2002:aca:f002:: with SMTP id o2mr12491918oih.62.1569709036953; 
 Sat, 28 Sep 2019 15:17:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 28 Sep 2019 15:17:16
 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sat, 28 Sep 2019 15:17:16
 -0700 (PDT)
In-Reply-To: <CAL1e-=gcK2mdtrt9vibHGpbm4_FZgQWTA91+p=9ouuMYmZwPqQ@mail.gmail.com>
References: <bf30baf5-4d75-dc6f-c30a-57b80714999b@ilande.co.uk>
 <CAL1e-=gcK2mdtrt9vibHGpbm4_FZgQWTA91+p=9ouuMYmZwPqQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 29 Sep 2019 00:17:16 +0200
Message-ID: <CAL1e-=gXZxKUuNgasSb9d2t=LhDAHJb8ovLjKfQ1Zu9HHg2D3w@mail.gmail.com>
Subject: Re: target/ppc: bug in optimised vsl/vsr implementation?
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/alternative; boundary="0000000000008c660c0593a45d2c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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
Cc: stefan.brankovic@rt-rk.com, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Paul Clarke <pc@us.ibm.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008c660c0593a45d2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

28.09.2019. 19.45, "Aleksandar Markovic" <aleksandar.m.mail@gmail.com> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
> 26.09.2019. 20.14, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > As part of the investigation into the DFP number issue reported at
> > https://bugs.launchpad.net/qemu/+bug/1841990 it appears that there may
also be a bug
> > introduced by the new optimised vsl/vsr implementation:
> >
> > commit 4e6d0920e7547e6af4bbac5ffe9adfe6ea621822
> > Author: Stefan Brankovic <stefan.brankovic@rt-rk.com>
> > Date: Mon Jul 15 16:22:48 2019 +0200
> >
> >     target/ppc: Optimize emulation of vsl and vsr instructions
> >
> >
>
> (sorry in advance if the format of this message looks odd, I have some
problems with mail settings related to recent qemu-devel mailer settings
changes; I will adjust my mail settings in next few days)
>
> Mark and Paul (and Stefan),
>
> Thanks for spotting this and pinpointing the culprit commit. I guess
Stefan is going to respond soon, but, in the meantime, I took a look at the
commit in question:
>
>
https://github.com/qemu/qemu/commit/4e6d0920e7547e6af4bbac5ffe9adfe6ea62182=
2
>
> I don't have at the moment any dev/test environment handy, but I did
manual inspection of the code, and here is what I found (in order of
importance, perceived by me):
>
> 1. The code will not work correctly if the shift ammount (variable 'sh')
is 0. This is because, in that case, one of succeeding invocations of TCG
shift functions will be required to shift a 64-bit TCG variable by 64 bits,
and the result of such TCG operation is undefined (shift amount must be 63
or less) - see https://github.com/qemu/qemu/blob/master/tcg/README.
>
> 2. Variable naming is better in the old helper than in the new
translator. In that light, I would advise Stefan to change 'sh' to 'shift',
and 'shifted' to 'carry'.
>
> 3. Lines
>
> tcg_gen_andi_i64(shifted, shifted, 0x7fULL);
>
> and
>
> tcg_gen_andi_i64(shifted, shifted, 0xfe00000000000000ULL);
>
> appear to be spurious (albait in a harmless way). Therefore, they should
be deleted, or, alternatevely, a justification for them should be provided.
>
> 4. In the commit message, variable names were used without quotation
mark, resulting in puzzling and unclear wording.
>
> 5. (a question for Mark) After all recent changes, does get_avr64(...,
..., true) always (for any endian configuration) return the "high" half of
an Altivec register, and get_avr64(..., ..., false) the "low" one?
>

One more hint: variables 'avrA' and 'avrB' can be a single variable, since
there is no moment during execution where both are needed; the same for
'tmp' and 'shifted'.

Also, check on the hardware the behavior listed as 'undefined' for vsl/vsr
in the docs - even though it is tehnically irrelevant, I am courious
whether the old or the new (or none of them) solution match the hardware.

> Given all these circumstances, perhaps the most reasonable solution would
be to revert the commit in question, and allow Stefan enough dev and test
time to hopefully submit a new, better, version later on.
>
> Sincerely,
> Aleksandar
>

--0000000000008c660c0593a45d2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
28.09.2019. 19.45, &quot;Aleksandar Markovic&quot; &lt;<a href=3D"mailto:al=
eksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; =D1=98=D0=B5=
 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt;<br>
&gt; 26.09.2019. 20.14, &quot;Mark Cave-Ayland&quot; &lt;<a href=3D"mailto:=
mark.cave-ayland@ilande.co.uk">mark.cave-ayland@ilande.co.uk</a>&gt; =D1=98=
=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt; &gt;<br>
&gt; &gt; As part of the investigation into the DFP number issue reported a=
t<br>
&gt; &gt; <a href=3D"https://bugs.launchpad.net/qemu/+bug/1841990">https://=
bugs.launchpad.net/qemu/+bug/1841990</a> it appears that there may also be =
a bug<br>
&gt; &gt; introduced by the new optimised vsl/vsr implementation:<br>
&gt; &gt;<br>
&gt; &gt; commit 4e6d0920e7547e6af4bbac5ffe9adfe6ea621822<br>
&gt; &gt; Author: Stefan Brankovic &lt;<a href=3D"mailto:stefan.brankovic@r=
t-rk.com">stefan.brankovic@rt-rk.com</a>&gt;<br>
&gt; &gt; Date: Mon Jul 15 16:22:48 2019 +0200<br>
&gt; &gt;<br>
&gt; &gt; =C2=A0 =C2=A0 target/ppc: Optimize emulation of vsl and vsr instr=
uctions<br>
&gt; &gt;<br>
&gt; &gt; =C2=A0 =C2=A0<br>
&gt;<br>
&gt; (sorry in advance if the format of this message looks odd, I have some=
 problems with mail settings related to recent qemu-devel mailer settings c=
hanges; I will adjust my mail settings in next few days)<br>
&gt;<br>
&gt; Mark and Paul (and Stefan),<br>
&gt;<br>
&gt; Thanks for spotting this and pinpointing the culprit commit. I guess S=
tefan is going to respond soon, but, in the meantime, I took a look at the =
commit in question:<br>
&gt;<br>
&gt; <a href=3D"https://github.com/qemu/qemu/commit/4e6d0920e7547e6af4bbac5=
ffe9adfe6ea621822">https://github.com/qemu/qemu/commit/4e6d0920e7547e6af4bb=
ac5ffe9adfe6ea621822</a><br>
&gt;<br>
&gt; I don&#39;t have at the moment any dev/test environment handy, but I d=
id manual inspection of the code, and here is what I found (in order of imp=
ortance, perceived by me):<br>
&gt;<br>
&gt; 1. The code will not work correctly if the shift ammount (variable &#3=
9;sh&#39;) is 0. This is because, in that case, one of succeeding invocatio=
ns of TCG shift functions will be required to shift a 64-bit TCG variable b=
y 64 bits, and the result of such TCG operation is undefined (shift amount =
must be 63 or less) - see <a href=3D"https://github.com/qemu/qemu/blob/mast=
er/tcg/README">https://github.com/qemu/qemu/blob/master/tcg/README</a>.<br>
&gt;<br>
&gt; 2. Variable naming is better in the old helper than in the new transla=
tor. In that light, I would advise Stefan to change &#39;sh&#39; to &#39;sh=
ift&#39;, and &#39;shifted&#39; to &#39;carry&#39;.<br>
&gt;<br>
&gt; 3. Lines<br>
&gt;<br>
&gt; tcg_gen_andi_i64(shifted, shifted, 0x7fULL);<br>
&gt;<br>
&gt; and<br>
&gt;<br>
&gt; tcg_gen_andi_i64(shifted, shifted, 0xfe00000000000000ULL);<br>
&gt;<br>
&gt; appear to be spurious (albait in a harmless way). Therefore, they shou=
ld be deleted, or, alternatevely, a justification for them should be provid=
ed.<br>
&gt;<br>
&gt; 4. In the commit message, variable names were used without quotation m=
ark, resulting in puzzling and unclear wording.<br>
&gt;<br>
&gt; 5. (a question for Mark) After all recent changes, does get_avr64(...,=
 ..., true) always (for any endian configuration) return the &quot;high&quo=
t; half of an Altivec register, and get_avr64(..., ..., false) the &quot;lo=
w&quot; one?<br>
&gt;</p>
<p dir=3D"ltr">One more hint: variables &#39;avrA&#39; and &#39;avrB&#39; c=
an be a single variable, since there is no moment during execution where bo=
th are needed; the same for &#39;tmp&#39; and &#39;shifted&#39;.</p>
<p dir=3D"ltr">Also, check on the hardware the behavior listed as &#39;unde=
fined&#39; for vsl/vsr in the docs - even though it is tehnically irrelevan=
t, I am courious whether the old or the new (or none of them) solution matc=
h the hardware.</p>
<p dir=3D"ltr">&gt; Given all these circumstances, perhaps the most reasona=
ble solution would be to revert the commit in question, and allow Stefan en=
ough dev and test time to hopefully submit a new, better, version later on.=
<br>
&gt;<br>
&gt; Sincerely,<br>
&gt; Aleksandar<br>
&gt;<br>
</p>

--0000000000008c660c0593a45d2c--

