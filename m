Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC17C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 16:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29E3206CD
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 16:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+b8/mIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29E3206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUvOD-0008A2-S3
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 12:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <johnnymarler@gmail.com>)
 id 1jUuls-0007Dl-VU
 for qemu-devel@nongnu.org; Sat, 02 May 2020 12:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <johnnymarler@gmail.com>) id 1jUuls-0000QZ-Dc
 for qemu-devel@nongnu.org; Sat, 02 May 2020 12:13:44 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:39780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <johnnymarler@gmail.com>)
 id 1jUulp-0000PS-JK; Sat, 02 May 2020 12:13:41 -0400
Received: by mail-lf1-x141.google.com with SMTP id h26so3168975lfg.6;
 Sat, 02 May 2020 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QI6dDMD60TcAVgWF0v5LoxJFHaYci7038PFh0Hlgf7c=;
 b=s+b8/mIcq7wiNrvxItcAt/G/55wRld9lz4OvJhEy2GbCrx4uARf25Wz6qZZZNiT4QQ
 i1MvYZ5aUN5Vx1AkIUbBgZpV8RlnpqiZrNpbKG4CZv+5auVnGgvtn2U+jOj8DK0oMyZC
 7SXIUtNaHkCRBRKLpWabr3ajDNEVsGcDPIWh2PAg67cr+Z36hSiGxsAwQBbW5XUw2dHm
 bLwXjyQ4DxwKk3Oq/idkiu2uRSc9iZh3w7AP6VkP1XrUZdTcj88sLnvXmXDZmM0AIMiy
 8A4Pynxpum2zdMeRm/Y4uSfpo0gx9EIA0to5gz2F6Kct0leznSZ+XZl8WeVmu6BxRalB
 ZOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QI6dDMD60TcAVgWF0v5LoxJFHaYci7038PFh0Hlgf7c=;
 b=AjF6qBua9mBUF0RDMUf6OuewA9CEwBDCpaz6+U5fHV0GpJeOEnFeVd17HaBHFXQIXr
 e1w03QBBep7Ay6ARO0t03kwEb4xU5eaiSzLIizLC7vpRv1eoIjC2QeIkCFskgJDzucEb
 tz2iA5gDVkUm1BHq6/pHGXoE2p5dax+rtZWbqRrJ1/fqwfmctSNACDap3aJhd96MJHYG
 dtleO2VxJtOOe4FxhwVjCrq4UcY/MXf61Gsf0pbbqvA032p23CQIKcnoVALQtchgPhzr
 9U5NH3DvwIn7oS0TUBRuaVAQXVJbTZ8ZE8jtoG/WtIZrQswiUhQ3L7PkMlGrl0pGksc/
 /wVA==
X-Gm-Message-State: AGi0Puag3M+pdsiMq0IKIM1Z7XGzgXVu7j5/w9cLu04j2vyYtIFStgQF
 cUKWCoLLVVyhyJFGvPtN5yTMVPDifD94cyx0fxeZONkOXJwwtw==
X-Google-Smtp-Source: APiQypIXPPkQ8+ECle3XDMN0VzxBnbMuBgByH4tCg7SN5ZwZIbSeGrD68tqnw1g2xyx9qHIYFu9XWXTlESEQRH+lGJk=
X-Received: by 2002:ac2:5395:: with SMTP id g21mr5983408lfh.61.1588436019543; 
 Sat, 02 May 2020 09:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200502074901.30784-1-johnnymarler@gmail.com>
 <fb7daa98-f403-6388-0958-c0d821efe835@vivier.eu>
In-Reply-To: <fb7daa98-f403-6388-0958-c0d821efe835@vivier.eu>
From: Jonathan Marler <johnnymarler@gmail.com>
Date: Sat, 2 May 2020 10:13:29 -0600
Message-ID: <CACKT+Ao=5ZqmEz8evVJFzgUoRHYo+wqyetVVaX7Qv6EJzrFMrw@mail.gmail.com>
Subject: Re: [PATCH] linux-user/mmap.c: fix integer underflow in target_mremap
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="000000000000b19d7305a4ac9400"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=johnnymarler@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::141
X-Mailman-Approved-At: Sat, 02 May 2020 12:52:16 -0400
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
Cc: qemu-trivial@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b19d7305a4ac9400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes the first patch was incorrect.  The second patch should be the correct
one.

Thanks for the guidance.  I have created a new patch with a "Fixes: ..."
and a description of the fix, and have sent that patch to
qemu-devel@nongnu.org

On Sat, May 2, 2020 at 2:38 AM Laurent Vivier <laurent@vivier.eu> wrote:

> Hi,
>
> does this patch replace your previous one?
>
> Please add more details in the description, as you did in the launchpad
> bug.
>
> You can also add:
> Fixes: https://bugs.launchpad.net/bugs/1876373
>
> You must also send the patch to qemu-devel@nongnu.org
>
> Thanks,
> Laurent
>
> Le 02/05/2020 =C3=A0 09:49, Jonathan Marler a =C3=A9crit :
> > Signed-off-by: Jonathan Marler <johnnymarler@gmail.com>
> > ---
> >  linux-user/mmap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> > index e378033797..caab62909e 100644
> > --- a/linux-user/mmap.c
> > +++ b/linux-user/mmap.c
> > @@ -708,7 +708,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulon=
g
> old_size,
> >          if (prot =3D=3D 0) {
> >              host_addr =3D mremap(g2h(old_addr), old_size, new_size,
> flags);
> >              if (host_addr !=3D MAP_FAILED && reserved_va && old_size >
> new_size) {
> > -                mmap_reserve(old_addr + old_size, new_size - old_size)=
;
> > +                mmap_reserve(old_addr + old_size, old_size - new_size)=
;
> >              }
> >          } else {
> >              errno =3D ENOMEM;
> >
>
>

--000000000000b19d7305a4ac9400
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes the first patch was incorrect.=C2=A0 The second patch =
should be the correct one.<div><br></div><div>Thanks for the guidance.=C2=
=A0 I have created a new patch with a &quot;Fixes: ...&quot; and a descript=
ion of the fix, and have sent that patch to <a href=3D"mailto:qemu-devel@no=
ngnu.org">qemu-devel@nongnu.org</a></div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 2, 2020 at 2:38 AM Lau=
rent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu">laurent@vivier.eu</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<b=
r>
<br>
does this patch replace your previous one?<br>
<br>
Please add more details in the description, as you did in the launchpad bug=
.<br>
<br>
You can also add:<br>
Fixes: <a href=3D"https://bugs.launchpad.net/bugs/1876373" rel=3D"noreferre=
r" target=3D"_blank">https://bugs.launchpad.net/bugs/1876373</a><br>
<br>
You must also send the patch to <a href=3D"mailto:qemu-devel@nongnu.org" ta=
rget=3D"_blank">qemu-devel@nongnu.org</a><br>
<br>
Thanks,<br>
Laurent<br>
<br>
Le 02/05/2020 =C3=A0 09:49, Jonathan Marler a =C3=A9crit=C2=A0:<br>
&gt; Signed-off-by: Jonathan Marler &lt;<a href=3D"mailto:johnnymarler@gmai=
l.com" target=3D"_blank">johnnymarler@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 linux-user/mmap.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/linux-user/mmap.c b/linux-user/mmap.c<br>
&gt; index e378033797..caab62909e 100644<br>
&gt; --- a/linux-user/mmap.c<br>
&gt; +++ b/linux-user/mmap.c<br>
&gt; @@ -708,7 +708,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulo=
ng old_size,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prot =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host_addr =3D mremap(g=
2h(old_addr), old_size, new_size, flags);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host_addr !=3D MAP=
_FAILED &amp;&amp; reserved_va &amp;&amp; old_size &gt; new_size) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_reserve(=
old_addr + old_size, new_size - old_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_reserve(=
old_addr + old_size, old_size - new_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D ENOMEM;<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000b19d7305a4ac9400--

