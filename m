Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A909C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 07:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6470B20716
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 07:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="tjn2cZxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6470B20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCIUt-0000FS-Hb
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 03:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jCIUB-0007wb-QO
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jCIUA-0008Uy-Mq
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:42:31 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:37403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jCIUA-0008RV-I2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:42:30 -0400
Received: by mail-yw1-xc42.google.com with SMTP id i1so4707942ywf.4
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 00:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xJnSfY/Ir2KK2Np9GG5EGcsUBXZf0ZKPs3Z2TzvJPdI=;
 b=tjn2cZxatlNzlLGhqSqErhk54cj/1HoYtTGe8cO5hO7OqtGJmZEOGjHqwMVqjPMbmY
 Mp7L64fkbCqEUyHvRwOLIwZfVwDuQ6N6Ro5Nl/8TM9fX4Kj5Zc5SlkDb26H+1bRO0rBP
 +0JfiRRcY7M9BU9o9RTSy5QnFBNzfejmQ0rB9OFC2lmJLMD/5yA76dE0v7cuJGABXJQb
 5o/I4ztjI3AU2wYD8vTWatuWt96zTH9axpgQwPMSjiY/wIigZixwEPeoUw38YavvqulN
 xNBd5hyL+18n3cvCKeqBGJJwS0UDBMO2a2sxER3WA0HyX5A1ChuX+FELIxdBcczGzA8a
 wIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xJnSfY/Ir2KK2Np9GG5EGcsUBXZf0ZKPs3Z2TzvJPdI=;
 b=U45QeDSFl7lZ3QnMJAh6cVCWm3Vf7cmpfA0NqDZX4jGoQcMNKIsjfZXbrc4uXgZlFg
 1qzjdFB96YauYEl+jnS4QPt2KazRU0oFsRdRgcUChe71T3r2ULThjs0aaTaTPp8EUvAw
 FSVVUlvSUCEQXI2/VVuQM/tG3g51fbok6/5MX4pOcNPicl6Rfn+b59Xr07oZEasFIeFZ
 DI4qqUtihYhGojNwM18udJ824gaNvMSZU/Fi47Sxstn2PL5O2agQsncUCZnYZrVAjSEP
 peSKpMmC0K3sFV25mwNqHG2TZI1mTWUO2jKdwm4s9wbH8fMhiWUftR9kFLyk/8UQLxr6
 4rIQ==
X-Gm-Message-State: ANhLgQ24DEsTgKqloXh7r/bRpAxm/Bk5pIMdLWr5rG/fTvykFqunVxNj
 5KqtCRzzpMxGKeehgK92/BD9YBlpEYeIRVWzTz7Neg==
X-Google-Smtp-Source: ADFU+vsHY4GNt4XbnkXcJFjaugbMlMxKI5GlDACrLSyTUDPHkMuHdvuqvUK3WhesjSXsp4s46PM/7RRtJslIqDTFyVM=
X-Received: by 2002:a5b:50d:: with SMTP id o13mr6561727ybp.366.1583998949573; 
 Thu, 12 Mar 2020 00:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
 <20200311123518.4025-2-yuri.benditovich@daynix.com>
 <20200311094553-mutt-send-email-mst@kernel.org>
 <CAOEp5OdgDB5u-SeZO3y4iCTjFy6hpNfPA-ADaBbnvx=MHD_dTw@mail.gmail.com>
 <20200311161819-mutt-send-email-mst@kernel.org>
 <CAOEp5OcrWewBYNT8TT6r1oFc=diq-HoGfe-zXwXPNSP0RguFkQ@mail.gmail.com>
 <20200312031427-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200312031427-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 12 Mar 2020 09:42:20 +0200
Message-ID: <CAOEp5Od=GW1onOqchw3H8nYSUByuekYCvi6jsWO8v9SYiFF27Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] virtio-net: introduce RSS and hash report features
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b6d16305a0a37eda"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b6d16305a0a37eda
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 12, 2020 at 9:21 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Thu, Mar 12, 2020 at 09:02:38AM +0200, Yuri Benditovich wrote:
> >     >     > +#define virtio_net_config virtio_net_config_with_rss
> >     >
> >     >     Do we have to? Let's just tweak code to do the right thing...
> >     >
> >     >
> >     > Are we going to update the virtio_net some time?
> >     > If yes, IMO makes sense to do less tweaking in the middle of the
> code.
> >     > Then, upon update of virtio_net.h - easily remove all these
> defines that
> >     were
> >     > added in virtio-net.c
> >
> >     We'll update it in a month or two. But I'd be reluctant to merge
> hacks
> >     since people tend to copy-paste code ...
> >
> >
> > I agree that merging hacks is very bad practice.
> > Which change is more looks like a hack: redefine the struct to its _real_
> > layout or change the type of the struct in 5 places?
>
> Anything that would be unacceptable as a permanent solution is a hack.
> In this case how about
>         virtio_net_config_rss {
>                 struct virtio_net_config config;
>                 /* RSS things */
>         }
>

No problem.

'#define virtio_net_config virtio_net_config_with_rss ' is OK?



>
>
> --
> MST
>
>

--000000000000b6d16305a0a37eda
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 12, 2020 at 9:21 AM Micha=
el S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, M=
ar 12, 2020 at 09:02:38AM +0200, Yuri Benditovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +#define virtio_net_co=
nfig virtio_net_config_with_rss<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Do we have to? Let&#39;s ju=
st tweak code to do the right thing...<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Are we going to update the virtio_net some tim=
e?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; If yes, IMO makes sense to do less tweaking in=
 the middle of the code.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Then, upon update of virtio_net.h - easily rem=
ove all these defines that<br>
&gt;=C2=A0 =C2=A0 =C2=A0were<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; added in virtio-net.c=C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0We&#39;ll update it in a month or two. But I&#39;d =
be reluctant to merge hacks<br>
&gt;=C2=A0 =C2=A0 =C2=A0since people tend to copy-paste code ...<br>
&gt; <br>
&gt; <br>
&gt; I agree that merging hacks is very bad practice.<br>
&gt; Which change is more looks like a hack: redefine the struct to its _re=
al_<br>
&gt; layout or change the type of the struct in 5 places?<br>
<br>
Anything that would be unacceptable as a permanent solution is a hack.<br>
In this case how about<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_net_config_rss {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_net_c=
onfig config;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* RSS things */<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>No proble=
m.</div><div><br></div><div>&#39;#define virtio_net_config virtio_net_confi=
g_with_rss &#39; is OK?<br></div><div><br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
<br>
-- <br>
MST<br>
<br>
</blockquote></div></div>

--000000000000b6d16305a0a37eda--

