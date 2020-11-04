Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DB3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276FE221F8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="XOfB0FGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276FE221F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaFD9-0000SY-2S
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 04:36:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kaFBd-0007KH-G3
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:34:37 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1kaFBb-0003fC-56
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:34:37 -0500
Received: by mail-ot1-x342.google.com with SMTP id n15so18731351otl.8
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 01:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZNBOiCFoSdu3mxKBqeVvqSQRduKjZ4kEqw+JehGcnAo=;
 b=XOfB0FGbj7IjWJPx6iVo7Fpna2gkenBZLDqBEMFQmy0ddqKSfUdFgAC6puNv5b0qx4
 4bKgMjG/o4kuorGL0+vK4SnZJ73MACVLNLh9cKtdRj20XT3gGVm6URgawanRnSWoE+HH
 IMw2oj7wCHvIZpli/ugBHgfDeIOGsO1kj9U6HFSAM7h+TkS59qi3/dVaMOoR3lUF46Le
 rDTfjYtawj4rXV/aN4ctuFLhIO4f6qkjBx4fIKjtLCxEJZvM/lwlEbtfkXIhnlRbJ4mD
 NuUTCvmGlAf679A0v1tainvgVZuHvAeKK7pwpgUH4nYSnTulW6gwAzyZjCqe7p582UYn
 o23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZNBOiCFoSdu3mxKBqeVvqSQRduKjZ4kEqw+JehGcnAo=;
 b=KgKAyWSWkumOoeEBIscDtmjCJLObBeroojbQbYOkWVuy9yO3gS9QaN9JaJVddru2xA
 Ui6azJiIybvsRCUZxoGbTLc8qShbchHN/C/AoU4EqeWn2//eWGrJjOBuS6S0BoHLHJYk
 8H3X9OOrFhEa75UWPSFzVWUVHLzg8GuT4QaAlLm2hb+0moMDRVTlPjn1ozLHr8DYf0hV
 mViQ1iPSxdemeKaOS2jkF6RV4ct6/nPzE2/Z8tvfBDPpQKVyFI/EbGZ/k4HWWY4V7lbD
 R9a5EsfNc2F1UXIAKLJlw/0Oe+CxjnZMj+lT2J+K+gTgCOpib2vQYJ7qpSWTpONxogZE
 55hg==
X-Gm-Message-State: AOAM532QxTU9+olu1+VnJt93Zzu3rgCHtsr+jHKpYNJz73Dm+x5U4rMm
 cM5JA0j6+t5+SBWWidWg0Jx+Lzpsjw0z6IKooQrbWw==
X-Google-Smtp-Source: ABdhPJxxECLD93iumWq04zFb3492dDs60/yr0Gw3Sl6j8e+tdgxG9xt/cOoRCYFYCodTORnKpi5UD2uWE9J6u3kmMwk=
X-Received: by 2002:a9d:61:: with SMTP id 88mr17253420ota.109.1604482474102;
 Wed, 04 Nov 2020 01:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20201102185115.7425-1-andrew@daynix.com>
 <20201102185115.7425-2-andrew@daynix.com>
 <b94d69ef-8067-9bc9-aaae-2bca88e5d9ba@redhat.com>
In-Reply-To: <b94d69ef-8067-9bc9-aaae-2bca88e5d9ba@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 4 Nov 2020 11:34:23 +0200
Message-ID: <CAOEp5OeV9wgfjV3MxvXu-LYrE9NxL0O+QTVZLJShyfAQMoJX6A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] net: Added SetSteeringEBPF method for
 NetClientState.
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000eae23205b344af60"
Received-SPF: none client-ip=2607:f8b0:4864:20::342;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Yan Vugenfirer <yan@daynix.com>, Andrew Melnychenko <andrew@daynix.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000eae23205b344af60
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2020 at 4:49 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/11/3 =E4=B8=8A=E5=8D=882:51, Andrew Melnychenko wrote:
> > From: Andrew <andrew@daynix.com>
> >
> > For now, that method supported only by Linux TAP.
> > Linux TAP uses TUNSETSTEERINGEBPF ioctl.
> > TUNSETSTEERINGBPF was added 3 years ago.
> > Qemu checks if it was defined before using.
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >   include/net/net.h |  2 ++
> >   net/tap-bsd.c     |  5 +++++
> >   net/tap-linux.c   | 19 +++++++++++++++++++
> >   net/tap-solaris.c |  5 +++++
> >   net/tap-stub.c    |  5 +++++
> >   net/tap.c         |  9 +++++++++
> >   net/tap_int.h     |  1 +
> >   7 files changed, 46 insertions(+)
> >
> > diff --git a/include/net/net.h b/include/net/net.h
> > index 897b2d7595..d8a41fb010 100644
> > --- a/include/net/net.h
> > +++ b/include/net/net.h
> > @@ -60,6 +60,7 @@ typedef int (SetVnetBE)(NetClientState *, bool);
> >   typedef struct SocketReadState SocketReadState;
> >   typedef void (SocketReadStateFinalize)(SocketReadState *rs);
> >   typedef void (NetAnnounce)(NetClientState *);
> > +typedef bool (SetSteeringEBPF)(NetClientState *, int);
> >
> >   typedef struct NetClientInfo {
> >       NetClientDriver type;
> > @@ -81,6 +82,7 @@ typedef struct NetClientInfo {
> >       SetVnetLE *set_vnet_le;
> >       SetVnetBE *set_vnet_be;
> >       NetAnnounce *announce;
> > +    SetSteeringEBPF *set_steering_ebpf;
> >   } NetClientInfo;
> >
> >   struct NetClientState {
> > diff --git a/net/tap-bsd.c b/net/tap-bsd.c
> > index 77aaf674b1..4f64f31e98 100644
> > --- a/net/tap-bsd.c
> > +++ b/net/tap-bsd.c
> > @@ -259,3 +259,8 @@ int tap_fd_get_ifname(int fd, char *ifname)
> >   {
> >       return -1;
> >   }
> > +
> > +int tap_fd_set_steering_ebpf(int fd, int prog_fd)
> > +{
> > +    return -1;
> > +}
> > diff --git a/net/tap-linux.c b/net/tap-linux.c
> > index b0635e9e32..196373019f 100644
> > --- a/net/tap-linux.c
> > +++ b/net/tap-linux.c
> > @@ -31,6 +31,7 @@
> >
> >   #include <net/if.h>
> >   #include <sys/ioctl.h>
> > +#include <linux/if_tun.h> /* TUNSETSTEERINGEBPF */
> >
> >   #include "qapi/error.h"
> >   #include "qemu/error-report.h"
> > @@ -316,3 +317,21 @@ int tap_fd_get_ifname(int fd, char *ifname)
> >       pstrcpy(ifname, sizeof(ifr.ifr_name), ifr.ifr_name);
> >       return 0;
> >   }
> > +
> > +int tap_fd_set_steering_ebpf(int fd, int prog_fd)
> > +{
> > +#ifdef TUNSETSTEERINGEBPF
>
>
> I'm not sure how much this can help.
>
> But looking at tap-linux.h, I wonder do we need to pull TUN/TAP uapi
> headers.
>
> Thanks
>

Agree, we just need to add this define to tap-linux.h


>
>
> > +    if (ioctl(fd, TUNSETSTEERINGEBPF, (void *) &prog_fd) !=3D 0) {
> > +        error_report("Issue while setting TUNSETSTEERINGEBPF:"
> > +                    " %s with fd: %d, prog_fd: %d",
> > +                    strerror(errno), fd, prog_fd);
> > +
> > +       return -1;
> > +    }
> > +
> > +    return 0;
> > +#else
> > +    error_report("TUNSETSTEERINGEBPF is not supported");
> > +    return -1;
> > +#endif
> > +}
> > diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> > index 0475a58207..d85224242b 100644
> > --- a/net/tap-solaris.c
> > +++ b/net/tap-solaris.c
> > @@ -255,3 +255,8 @@ int tap_fd_get_ifname(int fd, char *ifname)
> >   {
> >       return -1;
> >   }
> > +
> > +int tap_fd_set_steering_ebpf(int fd, int prog_fd)
> > +{
> > +    return -1;
> > +}
> > diff --git a/net/tap-stub.c b/net/tap-stub.c
> > index de525a2e69..a0fa25804b 100644
> > --- a/net/tap-stub.c
> > +++ b/net/tap-stub.c
> > @@ -85,3 +85,8 @@ int tap_fd_get_ifname(int fd, char *ifname)
> >   {
> >       return -1;
> >   }
> > +
> > +int tap_fd_set_steering_ebpf(int fd, int prog_fd)
> > +{
> > +    return -1;
> > +}
> > diff --git a/net/tap.c b/net/tap.c
> > index c46ff66184..81f50017bd 100644
> > --- a/net/tap.c
> > +++ b/net/tap.c
> > @@ -337,6 +337,14 @@ static void tap_poll(NetClientState *nc, bool
> enable)
> >       tap_write_poll(s, enable);
> >   }
> >
> > +static bool tap_set_steering_ebpf(NetClientState *nc, int prog_fd)
> > +{
> > +    TAPState *s =3D DO_UPCAST(TAPState, nc, nc);
> > +    assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_TAP);
> > +
> > +    return tap_fd_set_steering_ebpf(s->fd, prog_fd) =3D=3D 0;
> > +}
> > +
> >   int tap_get_fd(NetClientState *nc)
> >   {
> >       TAPState *s =3D DO_UPCAST(TAPState, nc, nc);
> > @@ -362,6 +370,7 @@ static NetClientInfo net_tap_info =3D {
> >       .set_vnet_hdr_len =3D tap_set_vnet_hdr_len,
> >       .set_vnet_le =3D tap_set_vnet_le,
> >       .set_vnet_be =3D tap_set_vnet_be,
> > +    .set_steering_ebpf =3D tap_set_steering_ebpf,
> >   };
> >
> >   static TAPState *net_tap_fd_init(NetClientState *peer,
> > diff --git a/net/tap_int.h b/net/tap_int.h
> > index 225a49ea48..547f8a5a28 100644
> > --- a/net/tap_int.h
> > +++ b/net/tap_int.h
> > @@ -44,5 +44,6 @@ int tap_fd_set_vnet_be(int fd, int vnet_is_be);
> >   int tap_fd_enable(int fd);
> >   int tap_fd_disable(int fd);
> >   int tap_fd_get_ifname(int fd, char *ifname);
> > +int tap_fd_set_steering_ebpf(int fd, int prog_fd);
> >
> >   #endif /* NET_TAP_INT_H */
>
>

--000000000000eae23205b344af60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 4, 2020 at 4:49 AM Jason =
Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/11/3 =E4=B8=8A=E5=8D=882:51, Andrew Melnychenko wrote:<br>
&gt; From: Andrew &lt;<a href=3D"mailto:andrew@daynix.com" target=3D"_blank=
">andrew@daynix.com</a>&gt;<br>
&gt;<br>
&gt; For now, that method supported only by Linux TAP.<br>
&gt; Linux TAP uses TUNSETSTEERINGEBPF ioctl.<br>
&gt; TUNSETSTEERINGBPF was added 3 years ago.<br>
&gt; Qemu checks if it was defined before using.<br>
&gt;<br>
&gt; Signed-off-by: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.=
com" target=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0include/net/net.h |=C2=A0 2 ++<br>
&gt;=C2=A0 =C2=A0net/tap-bsd.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +++++<br>
&gt;=C2=A0 =C2=A0net/tap-linux.c=C2=A0 =C2=A0| 19 +++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0net/tap-solaris.c |=C2=A0 5 +++++<br>
&gt;=C2=A0 =C2=A0net/tap-stub.c=C2=A0 =C2=A0 |=C2=A0 5 +++++<br>
&gt;=C2=A0 =C2=A0net/tap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 9 +++++=
++++<br>
&gt;=C2=A0 =C2=A0net/tap_int.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A07 files changed, 46 insertions(+)<br>
&gt;<br>
&gt; diff --git a/include/net/net.h b/include/net/net.h<br>
&gt; index 897b2d7595..d8a41fb010 100644<br>
&gt; --- a/include/net/net.h<br>
&gt; +++ b/include/net/net.h<br>
&gt; @@ -60,6 +60,7 @@ typedef int (SetVnetBE)(NetClientState *, bool);<br>
&gt;=C2=A0 =C2=A0typedef struct SocketReadState SocketReadState;<br>
&gt;=C2=A0 =C2=A0typedef void (SocketReadStateFinalize)(SocketReadState *rs=
);<br>
&gt;=C2=A0 =C2=A0typedef void (NetAnnounce)(NetClientState *);<br>
&gt; +typedef bool (SetSteeringEBPF)(NetClientState *, int);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0typedef struct NetClientInfo {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NetClientDriver type;<br>
&gt; @@ -81,6 +82,7 @@ typedef struct NetClientInfo {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0SetVnetLE *set_vnet_le;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0SetVnetBE *set_vnet_be;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NetAnnounce *announce;<br>
&gt; +=C2=A0 =C2=A0 SetSteeringEBPF *set_steering_ebpf;<br>
&gt;=C2=A0 =C2=A0} NetClientInfo;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0struct NetClientState {<br>
&gt; diff --git a/net/tap-bsd.c b/net/tap-bsd.c<br>
&gt; index 77aaf674b1..4f64f31e98 100644<br>
&gt; --- a/net/tap-bsd.c<br>
&gt; +++ b/net/tap-bsd.c<br>
&gt; @@ -259,3 +259,8 @@ int tap_fd_get_ifname(int fd, char *ifname)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +int tap_fd_set_steering_ebpf(int fd, int prog_fd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; +}<br>
&gt; diff --git a/net/tap-linux.c b/net/tap-linux.c<br>
&gt; index b0635e9e32..196373019f 100644<br>
&gt; --- a/net/tap-linux.c<br>
&gt; +++ b/net/tap-linux.c<br>
&gt; @@ -31,6 +31,7 @@<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &lt;net/if.h&gt;<br>
&gt;=C2=A0 =C2=A0#include &lt;sys/ioctl.h&gt;<br>
&gt; +#include &lt;linux/if_tun.h&gt; /* TUNSETSTEERINGEBPF */<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/error-report.h&quot;<br>
&gt; @@ -316,3 +317,21 @@ int tap_fd_get_ifname(int fd, char *ifname)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pstrcpy(ifname, sizeof(ifr.ifr_name), ifr.if=
r_name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +int tap_fd_set_steering_ebpf(int fd, int prog_fd)<br>
&gt; +{<br>
&gt; +#ifdef TUNSETSTEERINGEBPF<br>
<br>
<br>
I&#39;m not sure how much this can help.<br>
<br>
But looking at tap-linux.h, I wonder do we need to pull TUN/TAP uapi <br>
headers.<br>
<br>
Thanks<br></blockquote><div><br></div><div>Agree, we just need to add this =
define to tap-linux.h</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
<br>
&gt; +=C2=A0 =C2=A0 if (ioctl(fd, TUNSETSTEERINGEBPF, (void *) &amp;prog_fd=
) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Issue while setting TU=
NSETSTEERINGEBPF:&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot; %s with fd: %d, prog_fd: %d&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 strerror(errno), fd, prog_fd);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +#else<br>
&gt; +=C2=A0 =C2=A0 error_report(&quot;TUNSETSTEERINGEBPF is not supported&=
quot;);<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; +#endif<br>
&gt; +}<br>
&gt; diff --git a/net/tap-solaris.c b/net/tap-solaris.c<br>
&gt; index 0475a58207..d85224242b 100644<br>
&gt; --- a/net/tap-solaris.c<br>
&gt; +++ b/net/tap-solaris.c<br>
&gt; @@ -255,3 +255,8 @@ int tap_fd_get_ifname(int fd, char *ifname)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +int tap_fd_set_steering_ebpf(int fd, int prog_fd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; +}<br>
&gt; diff --git a/net/tap-stub.c b/net/tap-stub.c<br>
&gt; index de525a2e69..a0fa25804b 100644<br>
&gt; --- a/net/tap-stub.c<br>
&gt; +++ b/net/tap-stub.c<br>
&gt; @@ -85,3 +85,8 @@ int tap_fd_get_ifname(int fd, char *ifname)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +int tap_fd_set_steering_ebpf(int fd, int prog_fd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; +}<br>
&gt; diff --git a/net/tap.c b/net/tap.c<br>
&gt; index c46ff66184..81f50017bd 100644<br>
&gt; --- a/net/tap.c<br>
&gt; +++ b/net/tap.c<br>
&gt; @@ -337,6 +337,14 @@ static void tap_poll(NetClientState *nc, bool ena=
ble)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tap_write_poll(s, enable);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static bool tap_set_steering_ebpf(NetClientState *nc, int prog_fd)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 TAPState *s =3D DO_UPCAST(TAPState, nc, nc);<br>
&gt; +=C2=A0 =C2=A0 assert(nc-&gt;info-&gt;type =3D=3D NET_CLIENT_DRIVER_TA=
P);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return tap_fd_set_steering_ebpf(s-&gt;fd, prog_fd) =3D=
=3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0int tap_get_fd(NetClientState *nc)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0TAPState *s =3D DO_UPCAST(TAPState, nc, nc);=
<br>
&gt; @@ -362,6 +370,7 @@ static NetClientInfo net_tap_info =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.set_vnet_hdr_len =3D tap_set_vnet_hdr_len,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.set_vnet_le =3D tap_set_vnet_le,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.set_vnet_be =3D tap_set_vnet_be,<br>
&gt; +=C2=A0 =C2=A0 .set_steering_ebpf =3D tap_set_steering_ebpf,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static TAPState *net_tap_fd_init(NetClientState *peer,<br>
&gt; diff --git a/net/tap_int.h b/net/tap_int.h<br>
&gt; index 225a49ea48..547f8a5a28 100644<br>
&gt; --- a/net/tap_int.h<br>
&gt; +++ b/net/tap_int.h<br>
&gt; @@ -44,5 +44,6 @@ int tap_fd_set_vnet_be(int fd, int vnet_is_be);<br>
&gt;=C2=A0 =C2=A0int tap_fd_enable(int fd);<br>
&gt;=C2=A0 =C2=A0int tap_fd_disable(int fd);<br>
&gt;=C2=A0 =C2=A0int tap_fd_get_ifname(int fd, char *ifname);<br>
&gt; +int tap_fd_set_steering_ebpf(int fd, int prog_fd);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#endif /* NET_TAP_INT_H */<br>
<br>
</blockquote></div></div>

--000000000000eae23205b344af60--

