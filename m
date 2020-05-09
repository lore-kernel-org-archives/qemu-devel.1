Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CD6C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 06:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715EF217BA
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 06:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzIo1TEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715EF217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXJK7-0006C6-I9
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 02:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jXJJK-0005FT-NY
 for qemu-devel@nongnu.org; Sat, 09 May 2020 02:50:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30665
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jXJJI-0004vB-Jb
 for qemu-devel@nongnu.org; Sat, 09 May 2020 02:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589007006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fa7WCp7lLyzQcozFLqJc+N6WXxlLVlLcKm4u04bygnA=;
 b=bzIo1TECKqHMocfYSY0pAeVkFLjLDcEiM+YZAtRvGwv5rn54gm9KRrlou7/Gni6clcvULf
 Xi7FLnoY9THHIp2QyM3myNhhDrHg3X0jgQlif5SRkuJCG3fwQ3Z69Nky3B1V6x68tOu0or
 CFSnqvgeafijzJ7kV3GJThdXm42cA3w=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-iCr65flxOzCdYE3icxtJfg-1; Sat, 09 May 2020 02:50:04 -0400
X-MC-Unique: iCr65flxOzCdYE3icxtJfg-1
Received: by mail-pg1-f197.google.com with SMTP id g11so3055460pgd.20
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 23:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Fa7WCp7lLyzQcozFLqJc+N6WXxlLVlLcKm4u04bygnA=;
 b=k/U3+nYg5hnEmGEQ+iyVnJj21C8OFRUIBbiYiDOgMB3ooZfKTrqV1g5HTVvPfdhUWK
 HtEL4C3HhJhCPrE1D9blkoRWvcKvGBG9aMtGKGHE3Ak4lFiErwqrU562UlgmgnTzat5b
 zJcZuVGQfVxsVG7LP/pnJxlZe9cPDiwjFmek8YHeJ69FPH9Qz9DmmtZ0ZLOEtMPT/pAX
 0MiKvxA09oVZykuegfbkfbfRsp1wKMFKVNGB3KHb6CGdBUab36zgIqEz9QR/ROTT64JD
 x0hygIIsYUV2Tm/R8NWNYWAXrNulVWObG1zWzIL87VufbYiTTzTwZYC0CbogPd2ynjwr
 +BXw==
X-Gm-Message-State: AGi0PuZSOp8mlhvWp2Vhb5xgInQGzxmplmanUUN2VP72v7Q20mf3WmWB
 cH+eeoRMvVJ7hR+++Emc7cUtIYpbtnFXX2hBdESiI1qB2o2l7U8akEl+Zjrb8j76SNarZHJpXuF
 3wIpCz7iUCC+f3U1CxIWn5N3lkBKIhSA=
X-Received: by 2002:a63:c306:: with SMTP id c6mr5388860pgd.311.1589007003622; 
 Fri, 08 May 2020 23:50:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypLMhOL9CWqAcnO0TppHsbMTxkt0l/Uv1oXcUbIyLC6B+C7IrrwjfI7ryY4ZoTtEvdb0nDjBthI2/wUxk4SmSQI=
X-Received: by 2002:a63:c306:: with SMTP id c6mr5388827pgd.311.1589007003311; 
 Fri, 08 May 2020 23:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200508163218.22592-1-lulu@redhat.com>
 <20200508163218.22592-3-lulu@redhat.com>
 <ef489ec2-1af9-3987-8f36-2993104e48d7@redhat.com>
In-Reply-To: <ef489ec2-1af9-3987-8f36-2993104e48d7@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Sat, 9 May 2020 14:49:52 +0800
Message-ID: <CACLfguUbYCL8hYATfSoRZ4nO3vTjaDGw8tRH3GzerZpGyx1Znw@mail.gmail.com>
Subject: Re: [RFC v2 2/9] net: use the function qemu_get_peer
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 02:50:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Cornelia Huck <cohuck@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org, hanand@xilinx.com,
 rob.miller@broadcom.com, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 shahafs@mellanox.com, kevin.tian@intel.com, parav@mellanox.com,
 vmireyno@marvell.com, "Liang, Cunming" <cunming.liang@intel.com>,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Ariel Adam <aadam@redhat.com>,
 rdunlap@infradead.org, Maxime Coquelin <maxime.coquelin@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 9, 2020 at 10:20 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/5/9 =E4=B8=8A=E5=8D=8812:32, Cindy Lu wrote:
> > user the qemu_get_peer to replace the old process
>
>
> The title should be "vhost_net: use the function qemu_get_peer".
>
> Thanks
>
Sure, I will fix this
>
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   hw/net/vhost_net.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index 6b82803fa7..d1d421e3d9 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -306,7 +306,9 @@ int vhost_net_start(VirtIODevice *dev, NetClientSta=
te *ncs,
> >       BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(dev)));
> >       VirtioBusState *vbus =3D VIRTIO_BUS(qbus);
> >       VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(vbus);
> > +    struct vhost_net *net;
> >       int r, e, i;
> > +    NetClientState *peer;
> >
> >       if (!k->set_guest_notifiers) {
> >           error_report("binding does not support guest notifiers");
> > @@ -314,9 +316,9 @@ int vhost_net_start(VirtIODevice *dev, NetClientSta=
te *ncs,
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
> > @@ -335,7 +337,8 @@ int vhost_net_start(VirtIODevice *dev, NetClientSta=
te *ncs,
> >       }
> >
> >       for (i =3D 0; i < total_queues; i++) {
> > -        r =3D vhost_net_start_one(get_vhost_net(ncs[i].peer), dev);
> > +        peer =3D qemu_get_peer(ncs, i);
> > +        r =3D vhost_net_start_one(get_vhost_net(peer), dev);
> >
> >           if (r < 0) {
> >               goto err_start;
> > @@ -343,7 +346,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientSta=
te *ncs,
> >
> >           if (ncs[i].peer->vring_enable) {
> >               /* restore vring enable state */
> > -            r =3D vhost_set_vring_enable(ncs[i].peer, ncs[i].peer->vri=
ng_enable);
> > +            r =3D vhost_set_vring_enable(peer, peer->vring_enable);
> >
> >               if (r < 0) {
> >                   goto err_start;
> > @@ -355,7 +358,8 @@ int vhost_net_start(VirtIODevice *dev, NetClientSta=
te *ncs,
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
>


