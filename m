Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43385C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A09C20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ioLgHRGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A09C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxlx-0001Wz-3J
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuanzi@google.com>) id 1jDxd2-0002Op-OF
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuanzi@google.com>) id 1jDxcz-0008Cg-Hg
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:50:32 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuanzi@google.com>) id 1jDxcz-0007xk-7B
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:50:29 -0400
Received: by mail-oi1-x242.google.com with SMTP id k21so19559629oij.5
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 14:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AJGNcwsir8cByLs/9IaiRx8zhp5pkAD/FqdCGWzBqic=;
 b=ioLgHRGEAH7mIPy+4QlG1QIX6ZQok4XMeRohz+NvXJEGnoUY3O+N/gMWLNBc9sSrf7
 GRk7KsQ/zapQ3TvbA1cI0yltRYv4COu1gqEgrK4Xa97/UljHJ1vfDiSw+RkuqvBtEBGd
 N6bb7VVbkCvlWrzUT8RF9auWcFlFurJ5J0oEY/67fikbIHXpJ9Me8x3MXOZDvYERAtFV
 C037+auKTSxjNipoFhq9ODcFPIGajJZpASZWI+GmZrdiydWMDQM84QLN4mVeF+XL/S2B
 FDfXqqvkuVy6HMBLM9yr705UGUVCFNZNMvNefPxM9f7ntF2U3H+R5GW+UxTU0qF8RrjC
 cltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AJGNcwsir8cByLs/9IaiRx8zhp5pkAD/FqdCGWzBqic=;
 b=Ef0pS3gjzi3gliyaaVYYJ5cCUH8dyv9ajN0QtysjFHiUd3Z3bLemdZT9Ot+5d+scev
 xL1xXtnZKT552VTyLbqbpe5YE/rt7PlZrn5BHGFjiSloHAZN1U7X5ciWuHjnuyiDkFRj
 ZgBYbHwLPFrinoXsVekkweil7P7ZzR28ouYUJgN8N2/Sja+VVdctaOyltg30Zhoj8zo9
 qtb0f4RE82XFIWc7YfrJDEU8do2blEDEUJOnOK9C983K6M1g5dpYY9D7x/iMYYbrqUP9
 P6w8LdsNZoq9PFh/HvXAm+2aJ2z+DE8nDkmXhksxy4RxaHumyGe0aRepD6U6J8GJT4hh
 Txeg==
X-Gm-Message-State: ANhLgQ3xSDV0nFWM6J6imvSZXu0bYL2Z3gVc9IeaC3YocjuHxITB5u6J
 FjevbvYlq0DlHTogvAJEyYCezaFuuxNZjwXfPK8gEw==
X-Google-Smtp-Source: ADFU+vuEN2KJIRJuxs3WVPM/kWnRvcYR51oYDkjCF1wlEaT3OzdDHS+ysBoTLCaz9VDaA92m/OhlP7gnpqJ9czfj6vQ=
X-Received: by 2002:aca:f585:: with SMTP id t127mr1264743oih.38.1584395427381; 
 Mon, 16 Mar 2020 14:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200313002813.3857-1-yuanzi@google.com>
 <CAL1e-=ghc+6GRMd3NToF6+DeAz1VSR6bxuKd7dBtSJwrj50ovQ@mail.gmail.com>
 <e7ce2848-fb44-3837-65bc-6b449c0e518e@vivier.eu>
 <CAL1e-=hwWP4ztFuLeXsywzz_JvE-j7_1U2CNsU=p7pFS9eva2w@mail.gmail.com>
 <1a654687-0809-b142-7116-5958c51d8cd1@vivier.eu>
In-Reply-To: <1a654687-0809-b142-7116-5958c51d8cd1@vivier.eu>
From: Lirong Yuan <yuanzi@google.com>
Date: Mon, 16 Mar 2020 14:50:16 -0700
Message-ID: <CADjx4CJFpLYkiofuF-RpysD_7_-9C+mwgHa-J3HZ07-m1m6oeQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Update TASK_UNMAPPED_BASE for aarch64
To: Laurent Vivier <laurent@vivier.eu>
Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, 
 Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Josh Kunz <jkz@google.com>, Shu-Chun Weng <scw@google.com>
Content-Type: multipart/alternative; boundary="000000000000a26e8905a0ffceed"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a26e8905a0ffceed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Laurent for the prompt responses! Yes that is exactly where the
value is taken from.

For anyone interested in detailed information of the change, here is the
previous discussion thread:
http://patchwork.ozlabs.org/patch/1242370/

Regards,
Lirong


On Sat, Mar 14, 2020 at 10:34 AM Laurent Vivier <laurent@vivier.eu> wrote:

> Le 14/03/2020 =C3=A0 18:01, Aleksandar Markovic a =C3=A9crit :
> > On Sat, Mar 14, 2020 at 11:45 AM Laurent Vivier <laurent@vivier.eu>
> wrote:
> >>
> >> Le 14/03/2020 =C3=A0 04:06, Aleksandar Markovic a =C3=A9crit :
> >>> On Fri, Mar 13, 2020 at 1:28 AM Lirong Yuan <yuanzi@google.com> wrote=
:
> >>>>
> >>>> This change updates TASK_UNMAPPED_BASE (the base address for guest
> programs) for aarch64. It is needed to allow qemu to work with Thread
> Sanitizer (TSan), which has specific boundary definitions for memory
> mappings on different platforms:
> >>>>
> https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl=
/tsan_platform.h
> >>>>
> >>>> Signed-off-by: Lirong Yuan <yuanzi@google.com>
> >>>> ---
> >>>>  linux-user/mmap.c | 4 ++++
> >>>>  1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> >>>> index 8685f02e7e..e378033797 100644
> >>>> --- a/linux-user/mmap.c
> >>>> +++ b/linux-user/mmap.c
> >>>> @@ -184,7 +184,11 @@ static int mmap_frag(abi_ulong real_start,
> >>>>  }
> >>>>
> >>>>  #if HOST_LONG_BITS =3D=3D 64 && TARGET_ABI_BITS =3D=3D 64
> >>>> +#ifdef TARGET_AARCH64
> >>>> +# define TASK_UNMAPPED_BASE  0x5500000000
> >>>
> >>> Hi, Lirong,
> >>>
> >>> Can you point from which line of the file you linked to did you
> >>> arrive to the value 0x5500000000?
> >>>
> >>> Second question: What about other targets?
> >>
> >> Personally, I prefer to not change the value for other targets if it i=
s
> >> not required by someone that had some problems with the current value.
> >>
> >> It needs to be changed carefully and to be well tested after change.
> >>
> >
> > Sure, but again, from where " 0x5500000000" comes from?
>
> The URL is in the comment, but more precisely I guess:
>
>
> https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl=
/tsan_platform.h#L164
>
> Thanks,
> Laurent
>
>

--000000000000a26e8905a0ffceed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Laurent for the prompt responses! Yes that is exact=
ly where the value is taken from.<div><br></div><div>For anyone interested =
in detailed information of the change, here is the previous discussion thre=
ad:<br clear=3D"all"><div><div dir=3D"ltr" data-smartmail=3D"gmail_signatur=
e"><div dir=3D"ltr"><div><a href=3D"http://patchwork.ozlabs.org/patch/12423=
70/">http://patchwork.ozlabs.org/patch/1242370/</a><br></div><div><br></div=
><div>Regards,<br></div><div>Lirong</div></div></div></div><br></div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat=
, Mar 14, 2020 at 10:34 AM Laurent Vivier &lt;<a href=3D"mailto:laurent@viv=
ier.eu" target=3D"_blank">laurent@vivier.eu</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Le 14/03/2020 =C3=A0 18:01, Alek=
sandar Markovic a =C3=A9crit=C2=A0:<br>
&gt; On Sat, Mar 14, 2020 at 11:45 AM Laurent Vivier &lt;<a href=3D"mailto:=
laurent@vivier.eu" target=3D"_blank">laurent@vivier.eu</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Le 14/03/2020 =C3=A0 04:06, Aleksandar Markovic a =C3=A9crit :<br>
&gt;&gt;&gt; On Fri, Mar 13, 2020 at 1:28 AM Lirong Yuan &lt;<a href=3D"mai=
lto:yuanzi@google.com" target=3D"_blank">yuanzi@google.com</a>&gt; wrote:<b=
r>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; This change updates TASK_UNMAPPED_BASE (the base address f=
or guest programs) for aarch64. It is needed to allow qemu to work with Thr=
ead Sanitizer (TSan), which has specific boundary definitions for memory ma=
ppings on different platforms:<br>
&gt;&gt;&gt;&gt; <a href=3D"https://github.com/llvm/llvm-project/blob/maste=
r/compiler-rt/lib/tsan/rtl/tsan_platform.h" rel=3D"noreferrer" target=3D"_b=
lank">https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan=
/rtl/tsan_platform.h</a><br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Lirong Yuan &lt;<a href=3D"mailto:yuanzi@go=
ogle.com" target=3D"_blank">yuanzi@google.com</a>&gt;<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;=C2=A0 linux-user/mmap.c | 4 ++++<br>
&gt;&gt;&gt;&gt;=C2=A0 1 file changed, 4 insertions(+)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/linux-user/mmap.c b/linux-user/mmap.c<br>
&gt;&gt;&gt;&gt; index 8685f02e7e..e378033797 100644<br>
&gt;&gt;&gt;&gt; --- a/linux-user/mmap.c<br>
&gt;&gt;&gt;&gt; +++ b/linux-user/mmap.c<br>
&gt;&gt;&gt;&gt; @@ -184,7 +184,11 @@ static int mmap_frag(abi_ulong real_s=
tart,<br>
&gt;&gt;&gt;&gt;=C2=A0 }<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 #if HOST_LONG_BITS =3D=3D 64 &amp;&amp; TARGET_ABI_B=
ITS =3D=3D 64<br>
&gt;&gt;&gt;&gt; +#ifdef TARGET_AARCH64<br>
&gt;&gt;&gt;&gt; +# define TASK_UNMAPPED_BASE=C2=A0 0x5500000000<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hi, Lirong,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Can you point from which line of the file you linked to did yo=
u<br>
&gt;&gt;&gt; arrive to the value 0x5500000000?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Second question: What about other targets?<br>
&gt;&gt;<br>
&gt;&gt; Personally, I prefer to not change the value for other targets if =
it is<br>
&gt;&gt; not required by someone that had some problems with the current va=
lue.<br>
&gt;&gt;<br>
&gt;&gt; It needs to be changed carefully and to be well tested after chang=
e.<br>
&gt;&gt;<br>
&gt; <br>
&gt; Sure, but again, from where &quot; 0x5500000000&quot; comes from?<br>
<br>
The URL is in the comment, but more precisely I guess:<br>
<br>
=C2=A0<a href=3D"https://github.com/llvm/llvm-project/blob/master/compiler-=
rt/lib/tsan/rtl/tsan_platform.h#L164" rel=3D"noreferrer" target=3D"_blank">=
https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl/t=
san_platform.h#L164</a><br>
<br>
Thanks,<br>
Laurent<br>
<br>
</blockquote></div>

--000000000000a26e8905a0ffceed--

