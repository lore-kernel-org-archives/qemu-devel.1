Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2E3C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25828206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="x1F2cIVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25828206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTNv7-00077Y-7A
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 06:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jTNuL-0006Az-OX
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jTNuL-0003ap-4f
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:56:09 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:45551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jTNuK-0003ab-J5
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:56:08 -0400
Received: by mail-yb1-xb44.google.com with SMTP id p7so9024076ybo.12
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 03:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CaOcP7p1a+xI1BBpOHxIXH9Xc4VV47t0hEDc9rL9zvc=;
 b=x1F2cIVPuH+iofsoqekVb6NnIwSGOifH7qPMX0BTYsMlQYg9A8TDEnmZU7wmz5gsYj
 DO3VbVGy4XkHEU2zGlPP0tIkOAtHagv3zFcYj2uCNClCs3yF1q3jZonBtWFRJxps8ssK
 PrE+4anKqO5ZzuOjx1hGOZqDA0hQ+qaugSCzLvijVADC/4KmaOzwiv3DFwnk1rFxqQIl
 VeL/9IXDt4dlUrZnZUwIfw+CXD6/CWR+4FnKhIZPH2rpzrFem3pYdyn1La4Pr7bbLk+C
 QnULsTfVaRQ+cFA5fzH/KxktbhU3csLmYZHhgNPgKjgaKzipHmSS84t6oYbg6jZVuGPm
 npzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CaOcP7p1a+xI1BBpOHxIXH9Xc4VV47t0hEDc9rL9zvc=;
 b=hvTKo/9kspXEQzN7qQsx8Modxe17rsvZPQTwSf2gHduMftLCwKGMESmxxKbiJpjtxJ
 ruebnjH/vY33revvSy3xiIBJ7wLSL6ZOmNxpjxmdvI/ET3rX4LzhyAts6C1pelOJSnCn
 6TAZFMDfeWkCMa8oQCetnGqQgRgpZsmv4Q5PV1D39UpBoLPRFA1jst7ParPOjFHVTyu5
 7gbtI+zpoUGQQwoKoZ/0Bmgbex9OLNMtWeOLXKWKRBjOk/MZJFRLT3hb3i1W4p32t4BX
 Mlysx89e+Pcs8dHMIuK7b3V0smVSn+jdlVAOloJPRVGmZNbFukVSutRNBqHOfYxAdZaG
 xlgA==
X-Gm-Message-State: AGi0Pubix76QTjimtYfWa3sCjLpRUpS4BiWQ/wzlCusGAerVastcZF+x
 EUno9GB3n6JkooBFTWsetdg1XK73rjnAxkVhq7hiWQ==
X-Google-Smtp-Source: APiQypJ1rwUwtJf+JId+pciz05Fn8Box1ddHZU39Z/RFiZXycWuUj03/cktC0P/NeW6rgQYqWLK6/2L9pv6g+mcVzow=
X-Received: by 2002:a25:bacd:: with SMTP id a13mr45614802ybk.461.1588071367136; 
 Tue, 28 Apr 2020 03:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200427102415.10915-1-cohuck@redhat.com>
 <20200427102415.10915-4-cohuck@redhat.com>
 <7f703bea-2cae-dcdc-71bd-9623c7db33ac@redhat.com>
 <20200428103407.12612838.cohuck@redhat.com>
 <85367d20-e4f5-6869-319e-2f60d2510130@redhat.com>
 <20200428111801.7422d95a.cohuck@redhat.com>
In-Reply-To: <20200428111801.7422d95a.cohuck@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 28 Apr 2020 13:55:55 +0300
Message-ID: <CAOEp5OcgjWQzU=pRwc+2ftwGnX97wVR+vO-7HkV4=yNnsjcdhg@mail.gmail.com>
Subject: Re: [PATCH 3/3] virtio-net: remove VIRTIO_NET_HDR_F_RSC_INFO compat
 handling
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b771a605a457addb"
Received-SPF: none client-ip=2607:f8b0:4864:20::b44;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-yb1-xb44.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::b44
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b771a605a457addb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 12:18 PM Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 28 Apr 2020 16:58:44 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> > On 2020/4/28 =E4=B8=8B=E5=8D=884:34, Cornelia Huck wrote:
> > > On Tue, 28 Apr 2020 16:19:15 +0800
> > > Jason Wang <jasowang@redhat.com> wrote:
> > >
> > >> On 2020/4/27 =E4=B8=8B=E5=8D=886:24, Cornelia Huck wrote:
> > >>> VIRTIO_NET_HDR_F_RSC_INFO is available in the headers now.
> > >>>
> > >>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > >>> ---
> > >>>    hw/net/virtio-net.c | 8 --------
> > >>>    1 file changed, 8 deletions(-)
> > >>>
> > >>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > >>> index e85d902588b3..7449570c7123 100644
> > >>> --- a/hw/net/virtio-net.c
> > >>> +++ b/hw/net/virtio-net.c
> > >>> @@ -77,14 +77,6 @@
> > >>>       tso/gso/gro 'off'. */
> > >>>    #define VIRTIO_NET_RSC_DEFAULT_INTERVAL 300000
> > >>>
> > >>> -/* temporary until standard header include it */
> > >>> -#if !defined(VIRTIO_NET_HDR_F_RSC_INFO)
> > >>> -
> > >>> -#define VIRTIO_NET_HDR_F_RSC_INFO  4 /* rsc_ext data in csum_
> fields */
> > >>> -#define VIRTIO_NET_F_RSC_EXT       61
> > >>> -
> > >>> -#endif
> > >>> -
> > >>>    static inline __virtio16 *virtio_net_rsc_ext_num_packets(
> > >>>        struct virtio_net_hdr *hdr)
> > >>>    {
> > >>
> > >> I think we should not keep the those tricky num_packets/dup_acks.
> > > No real opinion here, patch 3 is only a cleanup.
> > >
> > > The important one is patch 1, because without it I cannot do a header=
s
> > > update.
> >
> >
> > Yes, at least we should dereference segments/dup_acks instead of
> > csum_start/csum_offsets since the header has been synced.
>
> So what about:
>
> - I merge patch 1 and the header sync now (because I have a bunch of
>   patches that depend on it...)
> - We change virtio-net to handle that properly on top (probably best
>   done by someone familiar with the code base ;)
>
>
Jason,
This series just solves the conflict caused by the update of Linux headers.
After this series is applied I can submit further patch to use actual RSC
definitions from linux headers.

Thanks,
Yuri

--000000000000b771a605a457addb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 28, 2020 at 12:18 PM Cornelia=
 Huck &lt;<a href=3D"mailto:cohuck@redhat.com">cohuck@redhat.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 28 =
Apr 2020 16:58:44 +0800<br>
Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jas=
owang@redhat.com</a>&gt; wrote:<br>
<br>
&gt; On 2020/4/28 =E4=B8=8B=E5=8D=884:34, Cornelia Huck wrote:<br>
&gt; &gt; On Tue, 28 Apr 2020 16:19:15 +0800<br>
&gt; &gt; Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_=
blank">jasowang@redhat.com</a>&gt; wrote:<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;&gt; On 2020/4/27 =E4=B8=8B=E5=8D=886:24, Cornelia Huck wrote:=C2=
=A0 <br>
&gt; &gt;&gt;&gt; VIRTIO_NET_HDR_F_RSC_INFO is available in the headers now=
.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Signed-off-by: Cornelia Huck &lt;<a href=3D"mailto:cohuck=
@redhat.com" target=3D"_blank">cohuck@redhat.com</a>&gt;<br>
&gt; &gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 hw/net/virtio-net.c | 8 --------<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 1 file changed, 8 deletions(-)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br=
>
&gt; &gt;&gt;&gt; index e85d902588b3..7449570c7123 100644<br>
&gt; &gt;&gt;&gt; --- a/hw/net/virtio-net.c<br>
&gt; &gt;&gt;&gt; +++ b/hw/net/virtio-net.c<br>
&gt; &gt;&gt;&gt; @@ -77,14 +77,6 @@<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tso/gso/gro &#39;off&#39;. */<b=
r>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 #define VIRTIO_NET_RSC_DEFAULT_INTERVAL 3000=
00<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 <br>
&gt; &gt;&gt;&gt; -/* temporary until standard header include it */<br>
&gt; &gt;&gt;&gt; -#if !defined(VIRTIO_NET_HDR_F_RSC_INFO)<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -#define VIRTIO_NET_HDR_F_RSC_INFO=C2=A0 4 /* rsc_ext dat=
a in csum_ fields */<br>
&gt; &gt;&gt;&gt; -#define VIRTIO_NET_F_RSC_EXT=C2=A0 =C2=A0 =C2=A0 =C2=A06=
1<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -#endif<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 static inline __virtio16 *virtio_net_rsc_ext=
_num_packets(<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_net_hdr *hdr)<br=
>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 {=C2=A0 <br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I think we should not keep the those tricky num_packets/dup_a=
cks.=C2=A0 <br>
&gt; &gt; No real opinion here, patch 3 is only a cleanup.<br>
&gt; &gt;<br>
&gt; &gt; The important one is patch 1, because without it I cannot do a he=
aders<br>
&gt; &gt; update.=C2=A0 <br>
&gt; <br>
&gt; <br>
&gt; Yes, at least we should dereference segments/dup_acks instead of <br>
&gt; csum_start/csum_offsets since the header has been synced.<br>
<br>
So what about:<br>
<br>
- I merge patch 1 and the header sync now (because I have a bunch of<br>
=C2=A0 patches that depend on it...)<br>
- We change virtio-net to handle that properly on top (probably best<br>
=C2=A0 done by someone familiar with the code base ;)<br>
<br></blockquote><div><br></div><div>Jason,</div><div>This series just solv=
es the conflict caused by the update of Linux headers.=C2=A0</div><div>

After this series is applied I can submit further patch to use actual RSC d=
efinitions from linux headers.=C2=A0</div><div><br></div><div>Thanks,</div>=
<div>Yuri</div></div></div>

--000000000000b771a605a457addb--

