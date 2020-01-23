Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFF2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E7921734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOPjZqfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E7921734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufFR-0005C5-9Q
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1iud9y-0004ja-It
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsuvorov@redhat.com>) id 1iud9w-0007Ed-7D
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:08:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25685
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsuvorov@redhat.com>) id 1iud9w-0007Dy-4E
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579788515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0kXpGdqk/TMNu+RKePppuxu8JpP1SAe8vtq99kaRng=;
 b=hOPjZqfFWWVpcXkN/5yW/dz4YrwkmDTLe63xiEHHvidWntEYKU7D+NiE4J1oCV5bDZskY1
 1RkMnEwtkPi+dxy35B8XeLTpnUI6C28ac6xTAlF8oeGDvWKk/1xi3C+2XDbUC1vMPh6/5a
 v7Voyj8iL917EQuvm0BSvpqfk2m4bns=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-2BU8dSM_Oqe6edHt4R8OCQ-1; Thu, 23 Jan 2020 09:08:33 -0500
Received: by mail-lj1-f197.google.com with SMTP id y24so1118334ljc.19
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 06:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ETwFl7POxpscyrGVslJ5c+vJJvTTyE4q567xM5BwSdc=;
 b=MRznIbXaApeMReEt33uRaQtNdVI186Uort2ROh9+dUys1yEul8ivPUE0DwEhHFKAeM
 IQlNwD1EmY1Rh3xoZQDfJJ7ie2x3OMXVIqM989V+rZSscvFRP6ZNyJNrahFTxwk6s9BN
 J4kpklNHBKiB5d3ecDCt5oYpcnVTZNIqpRk/q1HMLKZa+T/IOkfv5Z+4Bf3sUQV47Srt
 NA0aMbUY1rq3y8qMAZWasvEf6KXESc+U3Mi+C67ygSLGk3O+c5C9MbYUTOzwTeyaVcKV
 xOreDozJMAcrv74dHZG4Cw5J7EUHH23weDzu399g097qqfh2HMBcudeii5rQxQThFTmz
 mdpw==
X-Gm-Message-State: APjAAAU4GggGjjgYdOCgTEnmkQdoCcP5gNVxZCpnUUktBF478Up21ZSe
 qdJluoR6friuW3Cw6e0bSBJfUdq7/Ut4DXVfEw5qLKRIJadlGsZwf/JYU7uA+iB7+/MNYLT4Dpr
 SOktNPpdmnzGotC+o3m4QHXFe5HFLCCY=
X-Received: by 2002:a2e:8316:: with SMTP id a22mr22731682ljh.141.1579788511774; 
 Thu, 23 Jan 2020 06:08:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4oNkHMsbHN3XTbM/TjOJWyjuL7TbSPLaAJGeraHpOLq+yRp4xkR5wTbva5lHmdoFB6/tmjCQETjGGiO92sWI=
X-Received: by 2002:a2e:8316:: with SMTP id a22mr22731670ljh.141.1579788511567; 
 Thu, 23 Jan 2020 06:08:31 -0800 (PST)
MIME-Version: 1.0
References: <20200115224025.538368-1-jusual@redhat.com>
 <20200115224025.538368-3-jusual@redhat.com>
 <38fdd88d-1399-effb-b74b-e02b7343f044@redhat.com>
In-Reply-To: <38fdd88d-1399-effb-b74b-e02b7343f044@redhat.com>
From: Julia Suvorova <jusual@redhat.com>
Date: Thu, 23 Jan 2020 15:08:20 +0100
Message-ID: <CAMDeoFX1eFToYOWmBaVOYHTnNka8Fwruq6PtX7GsAGTuS++u8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-balloon: Reject qmp_balloon during hot-unplug
To: David Hildenbrand <david@redhat.com>
X-MC-Unique: 2BU8dSM_Oqe6edHt4R8OCQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 16, 2020 at 1:36 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 15.01.20 23:40, Julia Suvorova wrote:
> > Hot-unplug takes some time due to communication with the guest.
> > Do not change the device while freeing up resources.
> >
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> >  balloon.c                  | 2 +-
> >  hw/virtio/virtio-balloon.c | 9 ++++++++-
> >  include/sysemu/balloon.h   | 2 +-
> >  3 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/balloon.c b/balloon.c
> > index f104b42961..998ec53a0f 100644
> > --- a/balloon.c
> > +++ b/balloon.c
> > @@ -119,5 +119,5 @@ void qmp_balloon(int64_t target, Error **errp)
> >      }
> >
> >      trace_balloon_event(balloon_opaque, target);
> > -    balloon_event_fn(balloon_opaque, target);
> > +    balloon_event_fn(balloon_opaque, target, errp);
> >  }
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index 57f3b9f22d..0fa4e4454b 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -717,12 +717,19 @@ static void virtio_balloon_stat(void *opaque, Bal=
loonInfo *info)
> >                                               VIRTIO_BALLOON_PFN_SHIFT)=
;
> >  }
> >
> > -static void virtio_balloon_to_target(void *opaque, ram_addr_t target)
> > +static void virtio_balloon_to_target(void *opaque, ram_addr_t target,
> > +                                     Error **errp)
> >  {
> > +    DeviceState *bus_dev =3D qdev_get_bus_device(DEVICE(opaque));
> >      VirtIOBalloon *dev =3D VIRTIO_BALLOON(opaque);
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >      ram_addr_t vm_ram_size =3D get_current_ram_size();
> >
> > +    if (bus_dev && bus_dev->pending_deleted_event) {
> > +        error_setg(errp, "Hot-unplug of %s is in progress", vdev->name=
);
> > +        return;
> > +    }
> > +
>
> How exactly does this help? The guest is free to inflate/deflate
> whenever it wants.

Guest is aware of hot-unplug start, and virtio driver should not
initiate any operations. This patch just restricts issuing commands
from qmp monitor.

Best regards, Julia Suvorova.


