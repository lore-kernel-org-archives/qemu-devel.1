Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE44C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 479AB2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 19:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9ViOK57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479AB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idJaA-0006bM-6X
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 14:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1idJXP-0004sT-UA
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1idJXM-000486-Pa
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:45:15 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1idJXM-00043F-EV
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 14:45:12 -0500
Received: by mail-oi1-x244.google.com with SMTP id x14so815086oic.10
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 11:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=QSaNj2Lhi/Pf6b/lhRBaRaqnfm0JhCGnT3WsksvDWUM=;
 b=A9ViOK57oK1faRr4Qku07tWDGoLSytgv/84N7n7qNJ6ZPnkp7OmIdnjmYeTAMkKc+7
 7hT9PFTIuWKyYz+yu69RpzONgOM4VaEYXUiX4lgG3ABGl8ME11aFpHLTeKXX2Sh2vsTP
 mV5DJ8/jbLnesgXODOV9v+uoT/WK36u+rrvudNUn9WubtfzLof5HHNam8x5m8F3dDqtP
 3DmIcqrIbtgGJrrzCTWbFgZ0OTaYFosXixAwEGd6nr7QQCRtpCUdZkm8LhpLk5U3g6HW
 aqsO5H8RPLml7HJ1PlbRT+9tm7eSV6slxfeWCxAQHo0Bo/ZH2jDZUEBlrT3dbhQxKGys
 zZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=QSaNj2Lhi/Pf6b/lhRBaRaqnfm0JhCGnT3WsksvDWUM=;
 b=uZWLG8qVsXmYYR50j1shuiz291VJtKat7fimwewwDl0q1tzQPAYILcyHjeid7YtgJn
 e8KtUj/Vx1oSP+t0ycwzuGdu+dqfAvsAvSwZjb8gIGwDsj9lvLZ++hF9v+NDaYUhwVWG
 n1H7ChVx6T7Weo25cE4+4QmSOWs5yX6m057PFDgLRGSWQEhRkjYWt2MPZzh7asDjT4DM
 2NJcprAVGOYbPJWXHfLWGWpgiZvM3MeoDw2tgEEY9bjbkK/RKeJp/A0KiXW6oajcKDGa
 tbJg1RS1wlaK0vwLxbXeUnfji8ZjGqsWp3n166xnv/kGxXN8CdRqa6qEzRezUZWFufpd
 J1KQ==
X-Gm-Message-State: APjAAAWqRgzX2ahTBn9me+Ouzq703asmW8Hr9eQ2MsQsUrKyh0YOD4xq
 f1o9tzjWiB4ReJkTauplzuVC5QGJHvbvoywKwL8=
X-Google-Smtp-Source: APXvYqwp5UbX43ZCC8BJC9SmnG4htplYJmnZv3d7cgAw7PIOs8pMtYH8li7jUx6N90c2PwMD67SbxQ+ElBh9UOF76JU=
X-Received: by 2002:a05:6808:64e:: with SMTP id
 z14mr12934230oih.79.1575661511356; 
 Fri, 06 Dec 2019 11:45:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Fri, 6 Dec 2019 11:45:10 -0800 (PST)
In-Reply-To: <64460769-1e63-ab16-c58f-79f5f848f3ff@redhat.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1566216496-17375-16-git-send-email-aleksandar.markovic@rt-rk.com>
 <DM5PR22MB1658090DD9EF830F43F7957DD2A80@DM5PR22MB1658.namprd22.prod.outlook.com>
 <64460769-1e63-ab16-c58f-79f5f848f3ff@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 6 Dec 2019 20:45:10 +0100
Message-ID: <CAL1e-=jeE3AgxuqC+uTLzac8Ze4mqup7aH0GM0r-RE7cB_L60g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v8 15/37] target/mips: Style improvements in
 mips_malta.c
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000abb3e605990e4858"
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000abb3e605990e4858
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, December 6, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
wrote:

> Hi Aleksandar,
>
> On 8/19/19 4:47 PM, Aleksandar Rikalo wrote:
>
>> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
>>  > Sent: Monday, August 19, 2019 2:07 PM
>>  > To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
>>  > Cc: philmd@redhat.com <philmd@redhat.com>; Aleksandar Markovic <
>> amarkovic@wavecomp.com>; Aleksandar Rikalo <arikalo@wavecomp.com>
>>  > Subject: [EXTERNAL][PATCH v8 15/37] target/mips: Style improvements i=
n
>> mips_malta.c
>>  >
>>  > From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>  >
>>  > Fixes mostly errors and warnings reported by 'checkpatch.pl -f'.
>>  >
>>  > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>  > ---
>>  >  hw/mips/mips_malta.c | 216 ++++++++++++++++++++++++++++++
>> ---------------------
>>  >  1 file changed, 128 insertions(+), 88 deletions(-)
>>  >
>>  > diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>>
> [...]>  > @@ -347,7 +362,8 @@ static uint64_t malta_fpga_read(void *opaqu=
e,
>
>> hwaddr addr,
>>  >
>>  >      /* SWITCH Register */
>>  >      case 0x00200:
>>  > -        val =3D 0x00000000;              /* All switches closed */
>>  > +        /* ori a3, a3, low(ram_low_size) */
>>
>
> I'm not sure what happened here, this change is incorrect.
>
>
You are right, a strange case of a stray comment.

Do you want to send a patch-correction? So that I can select it for the
first mips queue...

Thanks for spotting it!
Aleksandar

 > +        val =3D 0x00000000;
>>  >          break;
>>  >
>>  >      /* STATUS Register */
>>  > @@ -386,10 +402,11 @@ static uint64_t malta_fpga_read(void *opaque,
>> hwaddr addr,
>>  >      /* GPINP Register */
>>  >      case 0x00a08:
>>  >          /* IN =3D OUT until a real I2C control is implemented */
>>  > -        if (s->i2csel)
>>  > +        if (s->i2csel) {
>>  >              val =3D s->i2cout;
>>  > -        else
>>  > +        } else {
>>  >              val =3D 0x00;
>>  > +        }
>>  >          break;
>>  >
>>
> [...]
>
>>
>> Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
>>
>>
>
>

--000000000000abb3e605990e4858
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, December 6, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">Hi Aleksandar,<br>
<br>
On 8/19/19 4:47 PM, Aleksandar Rikalo wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.markovic@rt-rk.c=
om" target=3D"_blank">aleksandar.markovic@rt-rk.com</a><wbr>&gt;<br>
=C2=A0&gt; Sent: Monday, August 19, 2019 2:07 PM<br>
=C2=A0&gt; To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">q=
emu-devel@nongnu.org</a> &lt;<a href=3D"mailto:qemu-devel@nongnu.org" targe=
t=3D"_blank">qemu-devel@nongnu.org</a>&gt;<br>
=C2=A0&gt; Cc: <a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philm=
d@redhat.com</a> &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank"=
>philmd@redhat.com</a>&gt;; Aleksandar Markovic &lt;<a href=3D"mailto:amark=
ovic@wavecomp.com" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;; Aleksa=
ndar Rikalo &lt;<a href=3D"mailto:arikalo@wavecomp.com" target=3D"_blank">a=
rikalo@wavecomp.com</a>&gt;<br>
=C2=A0&gt; Subject: [EXTERNAL][PATCH v8 15/37] target/mips: Style improveme=
nts in mips_malta.c<br>
=C2=A0&gt;<br>
=C2=A0&gt; From: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@waveco=
mp.com" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
=C2=A0&gt;<br>
=C2=A0&gt; Fixes mostly errors and warnings reported by &#39;<a href=3D"htt=
p://checkpatch.pl" target=3D"_blank">checkpatch.pl</a> -f&#39;.<br>
=C2=A0&gt;<br>
=C2=A0&gt; Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkov=
ic@wavecomp.com" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
=C2=A0&gt; ---<br>
=C2=A0&gt;=C2=A0 hw/mips/mips_malta.c | 216 ++++++++++++++++++++++++++++++<=
wbr>---------------------<br>
=C2=A0&gt;=C2=A0 1 file changed, 128 insertions(+), 88 deletions(-)<br>
=C2=A0&gt;<br>
=C2=A0&gt; diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c<br>
</blockquote>
[...]&gt;=C2=A0 &gt; @@ -347,7 +362,8 @@ static uint64_t malta_fpga_read(vo=
id *opaque,<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
hwaddr addr,<br>
=C2=A0&gt;<br>
=C2=A0&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SWITCH Register */<br>
=C2=A0&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0x00200:<br>
=C2=A0&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D 0x00000000;=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* All switches closed */<br>
=C2=A0&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* ori a3, a3, low(r=
am_low_size) */<br>
</blockquote>
<br>
I&#39;m not sure what happened here, this change is incorrect.<br>
<br></blockquote><div><br></div><div>You are right, a strange case of a str=
ay comment.</div><div><br></div><div>Do you want to send a patch-correction=
? So that I can select it for the first mips queue...</div><div><br></div><=
div>Thanks for spotting it!</div><div>Aleksandar</div><div><br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
=C2=A0&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D 0x00000000;<=
br>
=C2=A0&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
=C2=A0&gt;<br>
=C2=A0&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* STATUS Register */<br>
=C2=A0&gt; @@ -386,10 +402,11 @@ static uint64_t malta_fpga_read(void *opaq=
ue, hwaddr addr,<br>
=C2=A0&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* GPINP Register */<br>
=C2=A0&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0x00a08:<br>
=C2=A0&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* IN =3D =
OUT until a real I2C control is implemented */<br>
=C2=A0&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s-&gt;i2csel)<br=
>
=C2=A0&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s-&gt;i2csel) {<=
br>
=C2=A0&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 val =3D s-&gt;i2cout;<br>
=C2=A0&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else<br>
=C2=A0&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {<br>
=C2=A0&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 val =3D 0x00;<br>
=C2=A0&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
=C2=A0&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
=C2=A0&gt;<br>
</blockquote>
[...]<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
Reviewed-by: Aleksandar Rikalo &lt;<a href=3D"mailto:arikalo@wavecomp.com" =
target=3D"_blank">arikalo@wavecomp.com</a>&gt;<br>
<br>
</blockquote>
<br>
<br>
</blockquote>

--000000000000abb3e605990e4858--

