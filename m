Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9540EC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 03:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C627239D4
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 03:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtNEbalz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C627239D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKYa9-0005MP-4t
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 23:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kKYYq-0004LG-NM
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 23:01:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32539
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kKYYo-0005e1-1n
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 23:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600743698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hhD43Hh+Bg1ZpFOROJt1cA6yuABHUBMZhBeRP2eCN60=;
 b=WtNEbalz+HfWed/o01/sMAllHCrNKKh+yd8Emgp1WqpNLFoIArDsY/S60dpW39DWc0JoM9
 Yww+N4uxhGOGiIxsmSOop0mx1zPSV2kQ9eIiHzbyMaXiuo4AgPu6jL3uYbyFnpYXki3FPC
 JnL+CXf6IzRUXNbkHTxII5wojpPfiWM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-V0ylz17rP9Cf3BpC459Zeg-1; Mon, 21 Sep 2020 23:01:37 -0400
X-MC-Unique: V0ylz17rP9Cf3BpC459Zeg-1
Received: by mail-pj1-f72.google.com with SMTP id q95so1282921pja.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 20:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hhD43Hh+Bg1ZpFOROJt1cA6yuABHUBMZhBeRP2eCN60=;
 b=VdZFu6znGdvcK7m/IxXRTKxow4H2VYBQ/GARR+e6IVl0rojZ+tGX+o+V3izayKI6qj
 cbqXtjjyqbaB7zLohmrD2lA9OYFXmq8HONQbh5xaFEEQqHLt37Vb7yeJV9PxHSDU7k7L
 ezg3X248VdLGACukXEziTuKhFur/82ufnhnDHbR0bqJfXBvMcPFeA5vsIw7QupLtlESi
 E3kEDztN436+leYqAVT/k8IPFjG6OGiagvtXaUPxIbV+iRElU7YmpeuFzI4gqc9nYpgk
 alb3A3GsX2RAcpcMFqDRigTvSRSFvZiTKyuAueHSIEnAFkADDdAQll+0D7KyGDQu1N9f
 xNKw==
X-Gm-Message-State: AOAM531dWPSMQuU5qkCLRJtzT6Eb2OhgOlGTQVfWhL9UbNrGMgWz25Xf
 4egdRU8hgB5TMJHWGs1NLCV9QVN72P0vpwtxpIKDC5P22ZyYJrIXSGNYzJyS5xyKQSH2XqU+zQN
 PUByNJT/CFuVk6Gz3zC6Mmonizin9dng=
X-Received: by 2002:a17:902:d714:b029:d0:cbe1:e7a2 with SMTP id
 w20-20020a170902d714b02900d0cbe1e7a2mr2603031ply.19.1600743695834; 
 Mon, 21 Sep 2020 20:01:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz38N04dPxpOKoGSqZX+deBhqw9qYh0On1arhTS46qeJQEbRS8Z+bkhGFb/icIuuBrpM75UQ7thKVOZMhBlg+4=
X-Received: by 2002:a17:902:d714:b029:d0:cbe1:e7a2 with SMTP id
 w20-20020a170902d714b02900d0cbe1e7a2mr2602997ply.19.1600743695198; Mon, 21
 Sep 2020 20:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200917155851.20636-1-lulu@redhat.com>
 <b5ac3a30-6d81-117c-37af-e16b9a21ddad@redhat.com>
In-Reply-To: <b5ac3a30-6d81-117c-37af-e16b9a21ddad@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 22 Sep 2020 11:01:24 +0800
Message-ID: <CACLfguUNqfKYb-4Yo6-7Zn4NwYq94WHSKn+2KPX1+W0JH7Re2A@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtio-net: Set mac address to hardware if the peer
 is vdpa
To: Jason Wang <jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 23:01:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-stable@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>,
 Michael Tsirkin <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 9:55 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/9/17 =E4=B8=8B=E5=8D=8811:58, Cindy Lu wrote:
> > If the peer's type is vdpa,set the mac address to NIC in virtio_net_dev=
ice_realize,
> > Also sometime vdpa get an all 0 macaddress from the hardware, this will=
 cause the traffic down
> > So we add the check for this part.
> > if we get an 0 mac address we will use the default mac address instead
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   hw/net/virtio-net.c | 12 +++++++++++-
> >   1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index cb0d27084c..7db9da1482 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -126,6 +126,7 @@ static void virtio_net_get_config(VirtIODevice *vde=
v, uint8_t *config)
> >       VirtIONet *n =3D VIRTIO_NET(vdev);
> >       struct virtio_net_config netcfg;
> >       NetClientState *nc =3D qemu_get_queue(n->nic);
> > +    static const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } };
> >
> >       int ret =3D 0;
> >       memset(&netcfg, 0 , sizeof(struct virtio_net_config));
> > @@ -151,7 +152,11 @@ static void virtio_net_get_config(VirtIODevice *vd=
ev, uint8_t *config)
> >           ret =3D vhost_net_get_config(get_vhost_net(nc->peer), (uint8_=
t *)&netcfg,
> >                                      n->config_size);
> >           if (ret !=3D -1) {
> > -            memcpy(config, &netcfg, n->config_size);
> > +            if (memcmp(&netcfg.mac, &zero, sizeof(zero)) !=3D 0) {
> > +                memcpy(config, &netcfg, n->config_size);
> > +        } else {
> > +                error_report("Get an all zero mac address from hardwar=
e");
>
>
> This is probably a hint that MAC is not properly provisioned.
>
> So I guess we can leave this as is, or simply warn until the management
> interface is finalized.
>
Hi Jason, For sure this is NIC card's problem, They cannot provide an
correct MAC address,
But if we continue use this 0 mac address will cause this traffic
down, maybe will cost a lot of effort in debugging
So I think maybe Just an warn is not enough, We can use the default
mac address  and let the traffic working
>
> > +            }
> >           }
> >       }
> >   }
> > @@ -3399,6 +3404,11 @@ static void virtio_net_device_realize(DeviceStat=
e *dev, Error **errp)
> >       nc =3D qemu_get_queue(n->nic);
> >       nc->rxfilter_notify_enabled =3D 1;
> >
> > +   if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST=
_VDPA) {
> > +        struct virtio_net_config netcfg =3D {};
> > +        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> > +        virtio_net_set_config(vdev, (uint8_t *)&netcfg);
>
>
> Won't this overwrite all other fields in the netcfg? I think we should
> only touch mac part.
>
> Thanks
>
>
Sure, will fix this
> > +    }
> >       QTAILQ_INIT(&n->rsc_chains);
> >       n->qdev =3D dev;
> >
>


