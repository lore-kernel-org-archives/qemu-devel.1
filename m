Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55392C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 07:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561E4206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 07:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjRjyHy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561E4206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLiS0-0005na-4i
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 03:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kLiRD-0005FA-EZ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 03:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kLiRB-0005sg-88
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 03:46:39 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601019995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EByptOlHkwFzRD6bZx7xMapKKh1Bp3tsYvg6j0VtNjY=;
 b=GjRjyHy3du3BSfT4xpgc9BLPE4GF0PFEg8TCZNKlGq1cTXEyP/Fo2l7p3/Jy08YDVVPk7O
 MqJZMaUVcuAsl5FAKQmlSSIJXDPYXbC0k23iWLGbVLZBdumP9bwucVNU2lGROxdJUGzb2i
 P8vB6+5OudPIj+o9UhJyNE5tRQEXV5s=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-X7CyjfZsMOGwVnQK_2IeRg-1; Fri, 25 Sep 2020 03:46:34 -0400
X-MC-Unique: X7CyjfZsMOGwVnQK_2IeRg-1
Received: by mail-pg1-f197.google.com with SMTP id r4so1577057pgl.20
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 00:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EByptOlHkwFzRD6bZx7xMapKKh1Bp3tsYvg6j0VtNjY=;
 b=N7CqYXEspxPw+uHIiADkV9Lzh3yKQPcY7A9HEj8VCjjL71Bsrr2qRKo73J6e6/fum7
 og2ICe9UC6YsnAjDakDKLiKMNdd78zOtXpmf6vXN6f4/dCa93O9yDT/FMsCpw7kcg6HM
 qXmRPhjEENrfARHD/q+LnI9YB1UhzhC2Lpnuyi9OzW8nupx2xSpcSM1pNzbFFeaEb6PM
 SbOaf/CMZCo6u+OYRhp1Fi+FNW8gBOOXGrTbBmQvK0AzYV9lWZ865DOmMp81t65MDBjO
 X4ZicSloCcyQXi7a776UPsSkl/LcBvj6OQZ1ZJEmEASdNaM4gtBLBj5WX/OsYXj1Im+d
 OFSQ==
X-Gm-Message-State: AOAM531IrjXqj5I1XAjNacDfWBUteUJ3YlCsB5SM/3vcikOptL8MerBk
 2tDyCEi2khyeOEvuQuoVUrFi4Ws6emwRxYh6dRPEKWm8svhwqQ27svFartgP8BOvY83O97O8I7D
 qusnm/MAjCk8vYtXrbbzNAgjspR9wGVc=
X-Received: by 2002:a17:90a:e391:: with SMTP id
 b17mr1518459pjz.127.1601019992984; 
 Fri, 25 Sep 2020 00:46:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4enRNZQOX7PdX9xNX2wFdGcU0w7n0ty8LJp4bBi9ZzIQ6p0Y+HnWEyd50qDZpHjquJ8xofsPBF+D8Y4LeQD4=
X-Received: by 2002:a17:90a:e391:: with SMTP id
 b17mr1518441pjz.127.1601019992666; 
 Fri, 25 Sep 2020 00:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200917155851.20636-1-lulu@redhat.com>
 <b5ac3a30-6d81-117c-37af-e16b9a21ddad@redhat.com>
 <CACLfguUNqfKYb-4Yo6-7Zn4NwYq94WHSKn+2KPX1+W0JH7Re2A@mail.gmail.com>
 <584a955b-ab7f-75ee-fbcf-fac8a76c368a@redhat.com>
In-Reply-To: <584a955b-ab7f-75ee-fbcf-fac8a76c368a@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 25 Sep 2020 15:46:21 +0800
Message-ID: <CACLfguUBa+zRS85sdeEE5PkEL6vcM9iEBfdiMkKf-nmEUx8SGw@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtio-net: Set mac address to hardware if the peer
 is vdpa
To: Jason Wang <jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Michael Tsirkin <mst@redhat.com>, qemu-stable@nongnu.org,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 3:18 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/9/22 =E4=B8=8A=E5=8D=8811:01, Cindy Lu wrote:
> > On Tue, Sep 22, 2020 at 9:55 AM Jason Wang <jasowang@redhat.com> wrote:
> >>
> >> On 2020/9/17 =E4=B8=8B=E5=8D=8811:58, Cindy Lu wrote:
> >>> If the peer's type is vdpa,set the mac address to NIC in virtio_net_d=
evice_realize,
> >>> Also sometime vdpa get an all 0 macaddress from the hardware, this wi=
ll cause the traffic down
> >>> So we add the check for this part.
> >>> if we get an 0 mac address we will use the default mac address instea=
d
> >>>
> >>> Signed-off-by: Cindy Lu <lulu@redhat.com>
> >>> ---
> >>>    hw/net/virtio-net.c | 12 +++++++++++-
> >>>    1 file changed, 11 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >>> index cb0d27084c..7db9da1482 100644
> >>> --- a/hw/net/virtio-net.c
> >>> +++ b/hw/net/virtio-net.c
> >>> @@ -126,6 +126,7 @@ static void virtio_net_get_config(VirtIODevice *v=
dev, uint8_t *config)
> >>>        VirtIONet *n =3D VIRTIO_NET(vdev);
> >>>        struct virtio_net_config netcfg;
> >>>        NetClientState *nc =3D qemu_get_queue(n->nic);
> >>> +    static const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } };
> >>>
> >>>        int ret =3D 0;
> >>>        memset(&netcfg, 0 , sizeof(struct virtio_net_config));
> >>> @@ -151,7 +152,11 @@ static void virtio_net_get_config(VirtIODevice *=
vdev, uint8_t *config)
> >>>            ret =3D vhost_net_get_config(get_vhost_net(nc->peer), (uin=
t8_t *)&netcfg,
> >>>                                       n->config_size);
> >>>            if (ret !=3D -1) {
> >>> -            memcpy(config, &netcfg, n->config_size);
> >>> +            if (memcmp(&netcfg.mac, &zero, sizeof(zero)) !=3D 0) {
> >>> +                memcpy(config, &netcfg, n->config_size);
> >>> +        } else {
> >>> +                error_report("Get an all zero mac address from hardw=
are");
> >>
> >> This is probably a hint that MAC is not properly provisioned.
> >>
> >> So I guess we can leave this as is, or simply warn until the managemen=
t
> >> interface is finalized.
> >>
> > Hi Jason, For sure this is NIC card's problem, They cannot provide an
> > correct MAC address,
> > But if we continue use this 0 mac address will cause this traffic
> > down, maybe will cost a lot of effort in debugging
> > So I think maybe Just an warn is not enough, We can use the default
> > mac address  and let the traffic working
>
>
> Yes, and it's done by the following code.
>
> But the question is there's no much value for the error here consider
> you've already had a solution.
>
> Thanks
>
Sure, Thanks Jason I will remove this
>
> >>> +            }
> >>>            }
> >>>        }
> >>>    }
> >>> @@ -3399,6 +3404,11 @@ static void virtio_net_device_realize(DeviceSt=
ate *dev, Error **errp)
> >>>        nc =3D qemu_get_queue(n->nic);
> >>>        nc->rxfilter_notify_enabled =3D 1;
> >>>
> >>> +   if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHO=
ST_VDPA) {
> >>> +        struct virtio_net_config netcfg =3D {};
> >>> +        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> >>> +        virtio_net_set_config(vdev, (uint8_t *)&netcfg);
> >>
> >> Won't this overwrite all other fields in the netcfg? I think we should
> >> only touch mac part.
> >>
> >> Thanks
> >>
> >>
> > Sure, will fix this
> >>> +    }
> >>>        QTAILQ_INIT(&n->rsc_chains);
> >>>        n->qdev =3D dev;
> >>>
> >
>


