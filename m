Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86132C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBB62072D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9H+TJT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBB62072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQo0F-00037u-8l
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 04:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jQnzb-0002gs-9B
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jQnzZ-00010C-WE
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:10:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28525
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jQnzZ-0000x0-Fs
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587456651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3WoxBgNnHThdsyXCAwuM6AX+ZCfqjRMnE64vmF3PyAc=;
 b=A9H+TJT1xhJIF/n2pX5hmYopw7lav1WZd4vpKMGuyRZzJRXjkAWxq2QgAmJnwTPBuV8wDB
 WX+UUucjEjrQPeFaQO7yriBP9ztx9WNjYbUcO7XXi/iQs2ExKUgneUhkmdJnbOF7JyvHnP
 pk3XqmmA8BgdcKfz/FM+75N3u9nE+PA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-GsumtLs9OH6Z8A_sO0TrMw-1; Tue, 21 Apr 2020 04:10:49 -0400
X-MC-Unique: GsumtLs9OH6Z8A_sO0TrMw-1
Received: by mail-pl1-f200.google.com with SMTP id n18so7287144plp.17
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 01:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3WoxBgNnHThdsyXCAwuM6AX+ZCfqjRMnE64vmF3PyAc=;
 b=L9kFaASpV9ev8uYJGghaZxOSWJpbJxgsKuKpXixIkFVifJbguxiDglk0xprTZiL5OU
 y5U5y4nlAgkjRrkcvpwICEi8XlRau6GgvNZnFtC0a3XOMPMK98rjKTIN9iA+dIwQIGxd
 uvxzQMOVVC3ZjfLq6VEHmsx/UAYfHMjEXMjkHmrO5L+TIBTM7Wyo0ZM+trk+yf+LVy2G
 178BJY3e31p9AIaXP93J7bVi3cO3+8pRd+wV3RBREWoB2aXvw2E5HWyXHZrLaTnZyCRa
 dd/EwP6i3ll+HmiTTZShUGFOlQCgYjM1jBqyRV0l6lRofFoQVewRapDbZwrYemj1/ivI
 rjxg==
X-Gm-Message-State: AGi0PuaX/DyxoitQNv0AND5YGVgr+pF1C8Xc6FqBodifSmtBU/aAkByW
 yGhj4aEFTuxcRjWfLa+6NNKzWP3LynP/eDtMMP+rzPmC4+GEGAaAUxN6rNbOxOcJHEb0msUtNr2
 u+QsBDV6PXX5NTBJS+Xxt9FPmMt+0Cxk=
X-Received: by 2002:a05:6a00:2a6:: with SMTP id
 q6mr19932915pfs.23.1587456648004; 
 Tue, 21 Apr 2020 01:10:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypIeaUF7JN/EZRvSggX3ru7HH3fWKJiNHiTKhVsMAuEGIagHVK10bFdwpNxHFtPA5XpMRzAyBzOJj+/WLhp6nog=
X-Received: by 2002:a05:6a00:2a6:: with SMTP id
 q6mr19932889pfs.23.1587456647717; 
 Tue, 21 Apr 2020 01:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200420093241.4238-1-lulu@redhat.com>
 <20200420093241.4238-2-lulu@redhat.com>
 <33ec31c6-d0e6-0da1-407c-9efe2aa45470@redhat.com>
In-Reply-To: <33ec31c6-d0e6-0da1-407c-9efe2aa45470@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 21 Apr 2020 16:10:36 +0800
Message-ID: <CACLfguXRaFqteZ0vM3FEv6Zf+wrN6ybvzyTLY+SqrM+Q02_xgA@mail.gmail.com>
Subject: Re: [RFC v1 1/4] net: Introduce qemu_get_peer
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000957dcb05a3c88dae"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, armbru@redhat.com, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 shahafs@mellanox.com, kevin.tian@intel.com, parav@mellanox.com,
 vmireyno@marvell.com, "Liang, Cunming" <cunming.liang@intel.com>,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, "Wang, Zhihong" <zhihong.wang@intel.com>,
 maxime.coquelin@redhat.com, Ariel Adam <aadam@redhat.com>, cohuck@redhat.com,
 hanand@xilinx.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000957dcb05a3c88dae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2020 at 11:23 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/4/20 =E4=B8=8B=E5=8D=885:32, Cindy Lu wrote:
> > This is a small function  that can get the peer from given
> NetClientState and queue_index
>
>
> Unnecessary space  between 'function' and 'that'.
>
>
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
>
> Please split this patch into two parts:
>
> 1) introduce the function
> 2) the actual user for this fucntion
>
>
> sure, I will fix this problem.

> > ---
> >   hw/net/vhost_net.c | 16 ++++++++++------
> >   include/net/net.h  |  1 +
> >   net/net.c          |  6 ++++++
> >   3 files changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index 6b82803fa7..4096d64aaf 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -306,7 +306,9 @@ int vhost_net_start(VirtIODevice *dev,
> NetClientState *ncs,
> >       BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(dev)));
> >       VirtioBusState *vbus =3D VIRTIO_BUS(qbus);
> >       VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(vbus);
> > +    struct vhost_net *net;
> >       int r, e, i;
> > +    NetClientState *peer;
> >
> >       if (!k->set_guest_notifiers) {
> >           error_report("binding does not support guest notifiers");
> > @@ -314,9 +316,9 @@ int vhost_net_start(VirtIODevice *dev,
> NetClientState *ncs,
> >       }
> >
> >       for (i =3D 0; i < total_queues; i++) {
> > -        struct vhost_net *net;
> >
> > -        net =3D get_vhost_net(ncs[i].peer);
> > +        peer =3D qemu_get_peer(ncs, i);
> > +        net =3D get_vhost_net(peer);
> >           vhost_net_set_vq_index(net, i * 2);
> >
> >           /* Suppress the masking guest notifiers on vhost user
> > @@ -335,15 +337,16 @@ int vhost_net_start(VirtIODevice *dev,
> NetClientState *ncs,
> >       }
> >
> >       for (i =3D 0; i < total_queues; i++) {
> > -        r =3D vhost_net_start_one(get_vhost_net(ncs[i].peer), dev);
> > +        peer =3D qemu_get_peer(ncs, i);
> > +        r =3D vhost_net_start_one(get_vhost_net(peer), dev);
> >
> >           if (r < 0) {
> >               goto err_start;
> >           }
> >
> > -        if (ncs[i].peer->vring_enable) {
> > +        if (peer->vring_enable) {
> >               /* restore vring enable state */
> > -            r =3D vhost_set_vring_enable(ncs[i].peer,
> ncs[i].peer->vring_enable);
> > +            r =3D vhost_set_vring_enable(peer, peer->vring_enable);
> >
> >               if (r < 0) {
> >                   goto err_start;
> > @@ -355,7 +358,8 @@ int vhost_net_start(VirtIODevice *dev,
> NetClientState *ncs,
> >
> >   err_start:
> >       while (--i >=3D 0) {
> > -        vhost_net_stop_one(get_vhost_net(ncs[i].peer), dev);
> > +        peer =3D qemu_get_peer(ncs , i);
> > +        vhost_net_stop_one(get_vhost_net(peer), dev);
> >       }
> >       e =3D k->set_guest_notifiers(qbus->parent, total_queues * 2, fals=
e);
> >       if (e < 0) {
> > diff --git a/include/net/net.h b/include/net/net.h
> > index e175ba9677..0a74324ccd 100644
> > --- a/include/net/net.h
> > +++ b/include/net/net.h
> > @@ -175,6 +175,7 @@ void hmp_info_network(Monitor *mon, const QDict
> *qdict);
> >   void net_socket_rs_init(SocketReadState *rs,
> >                           SocketReadStateFinalize *finalize,
> >                           bool vnet_hdr);
> > +NetClientState *qemu_get_peer(NetClientState *nc, int queue_index);
> >
> >   /* NIC info */
> >
> > diff --git a/net/net.c b/net/net.c
> > index 84aa6d8d00..ac5080dda1 100644
> > --- a/net/net.c
> > +++ b/net/net.c
> > @@ -324,6 +324,12 @@ void *qemu_get_nic_opaque(NetClientState *nc)
> >
> >       return nic->opaque;
> >   }
> > +NetClientState *qemu_get_peer(NetClientState *nc, int queue_index)
> > +{
> > +    NetClientState *ncs  =3D  nc + queue_index;
>
>
> Unnecessary space around '=3D'.
>
> Thanks
>
>
> Will correct this

> +    assert(ncs !=3D NULL);
> > +    return ncs->peer;
> > +}
> >
> >   static void qemu_cleanup_net_client(NetClientState *nc)
> >   {
>
>

--000000000000957dcb05a3c88dae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Apr 21, 2020 at 11:23 AM Jason Wa=
ng &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@re=
dhat.com</a>&gt; wrote:<br></div><div dir=3D"ltr"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/4/20 =E4=B8=8B=E5=8D=885:32, Cindy Lu wrote:<br>
&gt; This is a small function=C2=A0 that can get the peer from given NetCli=
entState and queue_index<br>
<br>
<br>
Unnecessary space=C2=A0 between &#39;function&#39; and &#39;that&#39;.<br>
<br>
<br>
&gt;<br>
&gt; Signed-off-by: Cindy Lu &lt;<a href=3D"mailto:lulu@redhat.com" target=
=3D"_blank">lulu@redhat.com</a>&gt;<br>
<br>
<br>
Please split this patch into two parts:<br>
<br>
1) introduce the function<br>
2) the actual user for this fucntion<br>
<br>
<br></blockquote><div>sure, I will fix this problem.=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/net/vhost_net.c | 16 ++++++++++------<br>
&gt;=C2=A0 =C2=A0include/net/net.h=C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0net/net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 ++++=
++<br>
&gt;=C2=A0 =C2=A03 files changed, 17 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c<br>
&gt; index 6b82803fa7..4096d64aaf 100644<br>
&gt; --- a/hw/net/vhost_net.c<br>
&gt; +++ b/hw/net/vhost_net.c<br>
&gt; @@ -306,7 +306,9 @@ int vhost_net_start(VirtIODevice *dev, NetClientSt=
ate *ncs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0BusState *qbus =3D BUS(qdev_get_parent_bus(D=
EVICE(dev)));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VirtioBusState *vbus =3D VIRTIO_BUS(qbus);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(v=
bus);<br>
&gt; +=C2=A0 =C2=A0 struct vhost_net *net;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int r, e, i;<br>
&gt; +=C2=A0 =C2=A0 NetClientState *peer;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!k-&gt;set_guest_notifiers) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;binding doe=
s not support guest notifiers&quot;);<br>
&gt; @@ -314,9 +316,9 @@ int vhost_net_start(VirtIODevice *dev, NetClientSt=
ate *ncs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; total_queues; i++) {<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_net *net;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 net =3D get_vhost_net(ncs[i].peer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 peer =3D qemu_get_peer(ncs, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 net =3D get_vhost_net(peer);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_net_set_vq_index(net, i =
* 2);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Suppress the masking guest =
notifiers on vhost user<br>
&gt; @@ -335,15 +337,16 @@ int vhost_net_start(VirtIODevice *dev, NetClient=
State *ncs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; total_queues; i++) {<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D vhost_net_start_one(get_vhost_net(n=
cs[i].peer), dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 peer =3D qemu_get_peer(ncs, i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D vhost_net_start_one(get_vhost_net(p=
eer), dev);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_start;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ncs[i].peer-&gt;vring_enable) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (peer-&gt;vring_enable) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* restore vring=
 enable state */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D vhost_set_vring_enabl=
e(ncs[i].peer, ncs[i].peer-&gt;vring_enable);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D vhost_set_vring_enabl=
e(peer, peer-&gt;vring_enable);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r &lt; 0) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0go=
to err_start;<br>
&gt; @@ -355,7 +358,8 @@ int vhost_net_start(VirtIODevice *dev, NetClientSt=
ate *ncs,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0err_start:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0while (--i &gt;=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_net_stop_one(get_vhost_net(ncs[i].p=
eer), dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 peer =3D qemu_get_peer(ncs , i);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_net_stop_one(get_vhost_net(peer), d=
ev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0e =3D k-&gt;set_guest_notifiers(qbus-&gt;par=
ent, total_queues * 2, false);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (e &lt; 0) {<br>
&gt; diff --git a/include/net/net.h b/include/net/net.h<br>
&gt; index e175ba9677..0a74324ccd 100644<br>
&gt; --- a/include/net/net.h<br>
&gt; +++ b/include/net/net.h<br>
&gt; @@ -175,6 +175,7 @@ void hmp_info_network(Monitor *mon, const QDict *q=
dict);<br>
&gt;=C2=A0 =C2=A0void net_socket_rs_init(SocketReadState *rs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0SocketReadStateFinalize *finalize,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0bool vnet_hdr);<br>
&gt; +NetClientState *qemu_get_peer(NetClientState *nc, int queue_index);<b=
r>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/* NIC info */<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/net/net.c b/net/net.c<br>
&gt; index 84aa6d8d00..ac5080dda1 100644<br>
&gt; --- a/net/net.c<br>
&gt; +++ b/net/net.c<br>
&gt; @@ -324,6 +324,12 @@ void *qemu_get_nic_opaque(NetClientState *nc)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return nic-&gt;opaque;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +NetClientState *qemu_get_peer(NetClientState *nc, int queue_index)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 NetClientState *ncs=C2=A0 =3D=C2=A0 nc + queue_index;<b=
r>
<br>
<br>
Unnecessary space around &#39;=3D&#39;.<br>
<br>
Thanks<br>
<br>
<br></blockquote><div>Will correct=C2=A0this=C2=A0=C2=A0</div><div><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 assert(ncs !=3D NULL);<br>
&gt; +=C2=A0 =C2=A0 return ncs-&gt;peer;<br>
&gt; +}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void qemu_cleanup_net_client(NetClientState *nc)<br=
>
&gt;=C2=A0 =C2=A0{<br>
<br>
</blockquote></div></div>
</div>

--000000000000957dcb05a3c88dae--


