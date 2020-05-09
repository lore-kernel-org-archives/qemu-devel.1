Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A741BC28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 06:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA4524957
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 06:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfvGj0n7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA4524957
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXJLN-0007T2-KC
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 02:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jXJK4-0006IH-6L
 for qemu-devel@nongnu.org; Sat, 09 May 2020 02:50:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55686
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jXJK3-0006DD-7C
 for qemu-devel@nongnu.org; Sat, 09 May 2020 02:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589007054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vpsy5q3uxd7K1lavmMwJ7HlIzJb/XYMi5K1FN6SosY0=;
 b=SfvGj0n7xwvzczI9DwnJfwBkdHQ4kpxOdn8DYfzz6uIfHUXwWbJVPplvVdU80EcCy9xDMl
 EZRUv8DxStDlJXEtZsazIX89dks5SBtmNtVk4GLlLNjjLdSeXKDfE4T/FvKbqgGvtrqQNb
 x7je24g6+Txa2YaDX7FrB/5WA8wavk0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-0hdNibocOpqlF87jai09Wg-1; Sat, 09 May 2020 02:50:46 -0400
X-MC-Unique: 0hdNibocOpqlF87jai09Wg-1
Received: by mail-pl1-f200.google.com with SMTP id a7so3374122pll.23
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 23:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Vpsy5q3uxd7K1lavmMwJ7HlIzJb/XYMi5K1FN6SosY0=;
 b=lCs49jjDccHX8GO1eM7ylAM8ok1RhpZQWpRIWjuOUimfInyXBpkq8w55tEsmUMuf7J
 CWQEI0c1dR6vlS/MrGt552eVroJfYFcet6k9g8Whg1yOeM9b7UnysB7uRaiWpPIBXwO1
 WK3QIkSzgi0/SLjhyqlfndhwAwOdep37q2dWzAKfoaoYmeORdl/fXPWbFooM1hInAQTp
 7Nvjrgwrj/FPeMg3iFN8+/fcCb6Nb2NvPpnw7qKNv55dcNAyG5VW6rgCLVZCwUo4t+9I
 ghs1uIx3AIFAUL23miKE7O9aIDQhk822nRyYaR60Ho0yNQ67hnP3srTxRBlYHiEF3CyE
 nmRw==
X-Gm-Message-State: AGi0PuYeRYA+mD31Ed4gy9cKAzEZ32SAARg0wrgUEuoIDivu9ZmHcfO2
 56FklIDKOeCqBWLhl/+IemIpsAVB3vCPKFsiY2YvMXD3arS1E9TKVgk99SzsVuQ70lNhkD+81rr
 HjbH05XPoGGig865z51fARRQvMUo3hbA=
X-Received: by 2002:a17:902:bb86:: with SMTP id
 m6mr5750017pls.341.1589007045428; 
 Fri, 08 May 2020 23:50:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ3S78WoPMOzCqxooXWW6UsxkDLpl9JWvUyKkc1VKnjFOYaD/XFxrI7sFdm49j85NyRxVgcsrwHy+wk6N91N/Y=
X-Received: by 2002:a17:902:bb86:: with SMTP id
 m6mr5749979pls.341.1589007045148; 
 Fri, 08 May 2020 23:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200508163218.22592-1-lulu@redhat.com>
 <20200508163218.22592-7-lulu@redhat.com>
 <b7fcf4c3-8659-af81-e915-43140cd68d5a@redhat.com>
In-Reply-To: <b7fcf4c3-8659-af81-e915-43140cd68d5a@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Sat, 9 May 2020 14:50:34 +0800
Message-ID: <CACLfguUj5bsmzD7K2wu5pXJwMyworq9uJ1TfyY9At24c0UD0Jg@mail.gmail.com>
Subject: Re: [RFC v2 6/9] virtio-bus: introduce queue_enabled method
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 02:50:54
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

On Sat, May 9, 2020 at 11:02 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/5/9 =E4=B8=8A=E5=8D=8812:32, Cindy Lu wrote:
> > From: Jason Wang <jasowang@redhat.com>
> >
> > This patch introduces queue_enabled() method which allows the
> > transport to implement its own way to report whether or not a queue is
> > enabled.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> This patch should come before any of the vhost-vpda patch.
>
> Thanks
>
Sure, Will fix this
>
> > ---
> >   hw/virtio/virtio.c             | 6 ++++++
> >   include/hw/virtio/virtio-bus.h | 4 ++++
> >   2 files changed, 10 insertions(+)
> >
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 04716b5f6c..09732a8836 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3169,6 +3169,12 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice *=
vdev, int n)
> >
> >   bool virtio_queue_enabled(VirtIODevice *vdev, int n)
> >   {
> > +    BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
> > +    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> > +
> > +    if (k->queue_enabled)
> > +        return k->queue_enabled(qbus->parent, n);
> > +
> >       return virtio_queue_get_desc_addr(vdev, n) !=3D 0;
> >   }
> >
> > diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-=
bus.h
> > index 38c9399cd4..0f6f215925 100644
> > --- a/include/hw/virtio/virtio-bus.h
> > +++ b/include/hw/virtio/virtio-bus.h
> > @@ -83,6 +83,10 @@ typedef struct VirtioBusClass {
> >        */
> >       int (*ioeventfd_assign)(DeviceState *d, EventNotifier *notifier,
> >                               int n, bool assign);
> > +    /*
> > +     * Whether queue number n is enabled.
> > +     */
> > +    bool (*queue_enabled)(DeviceState *d, int n);
> >       /*
> >        * Does the transport have variable vring alignment?
> >        * (ie can it ever call virtio_queue_set_align()?)
>


