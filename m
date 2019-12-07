Return-Path: <SRS0=SuvF=Z5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F4BC43603
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 06:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E58421835
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 06:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix0o3WkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E58421835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idTSu-0005Ir-FO
	for qemu-devel@archiver.kernel.org; Sat, 07 Dec 2019 01:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1idTRv-0004n4-SH
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 01:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1idTRu-0003SU-5i
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 01:20:15 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1idTRt-0003MI-QK
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 01:20:14 -0500
Received: by mail-ot1-x344.google.com with SMTP id x3so7758183oto.11
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 22:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=WZ1NA1SJUUDKomIW79LFbdbm+NU6HRF31enMrXEFfJA=;
 b=Ix0o3WkCw+IxAr1EMo2ssxGa2DspM1EUZHtURFoGxwGAo/oummKyVy5SkI6MxPX782
 uibUhMP5Va36liT0Ja7LysDth5rDq1oGVzkgrfXe8wwZe+SD4AjwakDJvJUaV3AGQB4s
 xin6jTbyHp0Qx7eAB57Rz9tywo83e6AAI2XjM2PrCght7V8byk8V3+YYumeLtzIqMVQy
 SJCL4N92E22hCZyLne1RZzbl0psrMaer0e9Ur/mkzOVRZ3e1JSiH73QXi5AzXT5tQqNM
 xWGoimN0pCsy0wKGr8JkHc5izd4ysA6DM5YmeamKhRZPE/2DCjpMpvOUeGe55Tg77Xlr
 mNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=WZ1NA1SJUUDKomIW79LFbdbm+NU6HRF31enMrXEFfJA=;
 b=EG9i8a0JEl3mYE3aVg7YOXI6wIuty/LeePD1GaxxW3StLYeuSLwhqOpmDuhJgnAiAr
 Qt/91z/HUwHZj19lQIAk16SRpurrBSITkiAnInuVKBlZNaVerQrp82NsenR4JY5zf6/E
 NQrH52uWhlurhg55u7zm/0GREbo3CX2Lke11JzMGIe73MwhOhtWc7YigYP8CENnW6ShB
 JRErnhqYowuM88wLt7KqXXVUxsWLgGWh8ZMZ21Zq7q5Lt5Rlz9VP7reQFhRmNC2dalik
 D2PqBATVF0M9qfzN7cnss2FDqkS31sSQX6VvBkVV2LJ0NxTaQszhUBAnuOfZ+2WwQnkW
 hJUg==
X-Gm-Message-State: APjAAAXMDvV3O/FHEQjzaC4dCx4SfQ4AhGzXztsP6ggKDLvtVlLGa4Ed
 TD+0oS0cK1NSqXoUhKwu9wlaI3L3VGP9zUtggj0=
X-Google-Smtp-Source: APXvYqx3twOPFeSVSuRQKyJw8tV5I4nv5qp2DD9ICabm8J8ecGvqQSH951EntEWELPCOkcHwvPJb7h0gS22M8pihUEE=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr14605492otc.295.1575699612853; 
 Fri, 06 Dec 2019 22:20:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Fri, 6 Dec 2019 22:20:12 -0800 (PST)
In-Reply-To: <CAL1e-=jeE3AgxuqC+uTLzac8Ze4mqup7aH0GM0r-RE7cB_L60g@mail.gmail.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1566216496-17375-16-git-send-email-aleksandar.markovic@rt-rk.com>
 <DM5PR22MB1658090DD9EF830F43F7957DD2A80@DM5PR22MB1658.namprd22.prod.outlook.com>
 <64460769-1e63-ab16-c58f-79f5f848f3ff@redhat.com>
 <CAL1e-=jeE3AgxuqC+uTLzac8Ze4mqup7aH0GM0r-RE7cB_L60g@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 7 Dec 2019 07:20:12 +0100
Message-ID: <CAL1e-=jfRVmVnmRDA+1q6ywXTeBnXh8v7nYKi1pUqev7yqkaKg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v8 15/37] target/mips: Style improvements in
 mips_malta.c
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b2699a0599172758"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

--000000000000b2699a0599172758
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, December 6, 2019, Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Friday, December 6, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
> wrote:
>
>> Hi Aleksandar,
>>
>> On 8/19/19 4:47 PM, Aleksandar Rikalo wrote:
>>
>>> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
>>>  > Sent: Monday, August 19, 2019 2:07 PM
>>>  > To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
>>>  > Cc: philmd@redhat.com <philmd@redhat.com>; Aleksandar Markovic <
>>> amarkovic@wavecomp.com>; Aleksandar Rikalo <arikalo@wavecomp.com>
>>>  > Subject: [EXTERNAL][PATCH v8 15/37] target/mips: Style improvements
>>> in mips_malta.c
>>>  >
>>>  > From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>  >
>>>  > Fixes mostly errors and warnings reported by 'checkpatch.pl -f'.
>>>  >
>>>  > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>  > ---
>>>  >  hw/mips/mips_malta.c | 216 ++++++++++++++++++++++++++++++
>>> ---------------------
>>>  >  1 file changed, 128 insertions(+), 88 deletions(-)
>>>  >
>>>  > diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>>>
>> [...]>  > @@ -347,7 +362,8 @@ static uint64_t malta_fpga_read(void
>> *opaque,
>>
>>> hwaddr addr,
>>>  >
>>>  >      /* SWITCH Register */
>>>  >      case 0x00200:
>>>  > -        val =3D 0x00000000;              /* All switches closed */
>>>  > +        /* ori a3, a3, low(ram_low_size) */
>>>
>>
>> I'm not sure what happened here, this change is incorrect.
>>
>>
> You are right, a strange case of a stray comment.
>
> Do you want to send a patch-correction? So that I can select it for the
> first mips queue...
>
>
Philippe,

I can merge, while applying, this one-line correction into Filip's patch on
the same file, no need for a separate patch.

Thanks again,
Aleksandar



> Thanks for spotting it!
> Aleksandar
>
>  > +        val =3D 0x00000000;
>>>  >          break;
>>>  >
>>>  >      /* STATUS Register */
>>>  > @@ -386,10 +402,11 @@ static uint64_t malta_fpga_read(void *opaque,
>>> hwaddr addr,
>>>  >      /* GPINP Register */
>>>  >      case 0x00a08:
>>>  >          /* IN =3D OUT until a real I2C control is implemented */
>>>  > -        if (s->i2csel)
>>>  > +        if (s->i2csel) {
>>>  >              val =3D s->i2cout;
>>>  > -        else
>>>  > +        } else {
>>>  >              val =3D 0x00;
>>>  > +        }
>>>  >          break;
>>>  >
>>>
>> [...]
>>
>>>
>>> Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
>>>
>>>
>>
>>

--000000000000b2699a0599172758
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, December 6, 2019, Aleksandar Markovic &lt;<a href=3D"mai=
lto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><br><br>On Friday, December 6, 2019, Phi=
lippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" target=3D=
"_blank">philmd@redhat.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>Hi Aleksandar,<br>
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
/blockquote><div><br></div><div>Philippe,=C2=A0</div><div><br></div><div>I =
can merge, while applying, this one-line correction into Filip&#39;s patch =
on the same file, no need for a separate patch.</div><div><br></div><div>Th=
anks again,</div><div>Aleksandar</div><div><br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><div>Thanks for spotting it!</div><div>Aleksandar=
</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
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
</blockquote>

--000000000000b2699a0599172758--

