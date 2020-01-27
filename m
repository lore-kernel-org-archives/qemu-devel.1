Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71785C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E84520716
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CU28lkds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E84520716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw5m7-0006ry-Dt
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 09:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1iw5lV-0006TM-Fg
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsuvorov@redhat.com>) id 1iw5lT-0000ts-4Z
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:53:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49753
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsuvorov@redhat.com>) id 1iw5lS-0000rc-Qw
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580136801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i91CWCvQDMTFP3uoLEPAtbm1xWurj5tEPQZ49TMYIu0=;
 b=CU28lkds9AaA+gGxrP7DuJJbCJuP3slJKx3sdBZDi1GwDsKMEmYfvEEn8/TzSTQbBa0xCx
 j1neiYrlKyQ8e02wqzi4shtyDuyLIyYzerUd1Mi5yRdWUxmKsZ6+1o8UJpkONg3lHUGP2g
 9GtX/sLMJDsU19G0jWdNcLLj94bpycI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-jN_AHSO-NeiIMDnQk9cSCQ-1; Mon, 27 Jan 2020 09:53:18 -0500
Received: by mail-lj1-f198.google.com with SMTP id h26so1688770ljj.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 06:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DePmUoYQK5L9Lv26WCIECNTrdDEKejTXy6H8P40XQOM=;
 b=LLK0A4mUhPHYiqUp+j8Olxob0Kdm1ooJ0iGan9xg6IcHQDGOLC9B2d8k0XWPXuANVg
 EP6nrHg8hZsGI61dp8RH4pa+qD3lPLfeWoJhi69+YNf7Zai7U1nrZWV5vMp5HJW2YYR7
 MNQnS/2+Oows9/Vh9+OxktuAePPzPDX3HwUOguttCnVVp7rzfiXOB/Y9jDKpwWwUZDIB
 U6a5Yjd5eJs92O873u5i0gVizARXTlAA7CvWoXJw92CGgcpJFe/EixieNcBOFqB95W+U
 uwfFiNvaamvnDl+VWx6EsIr0fVTk2zQhls8qt2rvzwPiOHDQGc95LQJh2Z90Vd5y6P+1
 eHpA==
X-Gm-Message-State: APjAAAUfx2OwTdC8YW4F6yvzkLyIqBzoleiFvUEhcHWS94or1iegZAU7
 mRUSmvM6CtPQ2LzAUg0CvRAJ+8KIEKxTq21F1pf7sJX8lykRSlBvQdAo13X/vqu7975Ew00t4Dh
 wi/CIuY+5bBqBZw8SXxJUciOPRdrTXD0=
X-Received: by 2002:a2e:8053:: with SMTP id p19mr10097404ljg.263.1580136797224; 
 Mon, 27 Jan 2020 06:53:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxOI1UJfX55IvhKm2dUMLs3LVPw+Vb04Te3UEtAWz1cXwyltabQ/IHvcFf8skGTO0eJ//eGvdE5xtl2fRxHFws=
X-Received: by 2002:a2e:8053:: with SMTP id p19mr10097386ljg.263.1580136796919; 
 Mon, 27 Jan 2020 06:53:16 -0800 (PST)
MIME-Version: 1.0
References: <20200115224025.538368-1-jusual@redhat.com>
 <20200115224025.538368-3-jusual@redhat.com>
 <38fdd88d-1399-effb-b74b-e02b7343f044@redhat.com>
 <CAMDeoFX1eFToYOWmBaVOYHTnNka8Fwruq6PtX7GsAGTuS++u8w@mail.gmail.com>
 <095236a0-ba8c-55c6-f9fc-e2a4a809b274@redhat.com>
 <CAMDeoFWJJbLs_Dtkb2rqXYW-PMA=9Qwy83SnkqS2_-EOaNtiSg@mail.gmail.com>
 <20200127055127-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200127055127-mutt-send-email-mst@kernel.org>
From: Julia Suvorova <jusual@redhat.com>
Date: Mon, 27 Jan 2020 15:53:06 +0100
Message-ID: <CAMDeoFVaFOxdLKT1g3q0KzyBFnSV63msVKMdDzvT-bKiWP_t6w@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-balloon: Reject qmp_balloon during hot-unplug
To: "Michael S. Tsirkin" <mst@redhat.com>
X-MC-Unique: jN_AHSO-NeiIMDnQk9cSCQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 27, 2020 at 11:54 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jan 23, 2020 at 04:46:18PM +0100, Julia Suvorova wrote:
> > On Thu, Jan 23, 2020 at 3:17 PM David Hildenbrand <david@redhat.com> wr=
ote:
> > >
> > > On 23.01.20 15:08, Julia Suvorova wrote:
> > > > On Thu, Jan 16, 2020 at 1:36 PM David Hildenbrand <david@redhat.com=
> wrote:
> > > >>
> > > >> On 15.01.20 23:40, Julia Suvorova wrote:
> > > >>> Hot-unplug takes some time due to communication with the guest.
> > > >>> Do not change the device while freeing up resources.
> > > >>>
> > > >>> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > > >>> ---
> > > >>>  balloon.c                  | 2 +-
> > > >>>  hw/virtio/virtio-balloon.c | 9 ++++++++-
> > > >>>  include/sysemu/balloon.h   | 2 +-
> > > >>>  3 files changed, 10 insertions(+), 3 deletions(-)
> > > >>>
> > > >>> diff --git a/balloon.c b/balloon.c
> > > >>> index f104b42961..998ec53a0f 100644
> > > >>> --- a/balloon.c
> > > >>> +++ b/balloon.c
> > > >>> @@ -119,5 +119,5 @@ void qmp_balloon(int64_t target, Error **errp=
)
> > > >>>      }
> > > >>>
> > > >>>      trace_balloon_event(balloon_opaque, target);
> > > >>> -    balloon_event_fn(balloon_opaque, target);
> > > >>> +    balloon_event_fn(balloon_opaque, target, errp);
> > > >>>  }
> > > >>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloo=
n.c
> > > >>> index 57f3b9f22d..0fa4e4454b 100644
> > > >>> --- a/hw/virtio/virtio-balloon.c
> > > >>> +++ b/hw/virtio/virtio-balloon.c
> > > >>> @@ -717,12 +717,19 @@ static void virtio_balloon_stat(void *opaqu=
e, BalloonInfo *info)
> > > >>>                                               VIRTIO_BALLOON_PFN_=
SHIFT);
> > > >>>  }
> > > >>>
> > > >>> -static void virtio_balloon_to_target(void *opaque, ram_addr_t ta=
rget)
> > > >>> +static void virtio_balloon_to_target(void *opaque, ram_addr_t ta=
rget,
> > > >>> +                                     Error **errp)
> > > >>>  {
> > > >>> +    DeviceState *bus_dev =3D qdev_get_bus_device(DEVICE(opaque))=
;
> > > >>>      VirtIOBalloon *dev =3D VIRTIO_BALLOON(opaque);
> > > >>>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > > >>>      ram_addr_t vm_ram_size =3D get_current_ram_size();
> > > >>>
> > > >>> +    if (bus_dev && bus_dev->pending_deleted_event) {
> > > >>> +        error_setg(errp, "Hot-unplug of %s is in progress", vdev=
->name);
> > > >>> +        return;
> > > >>> +    }
> > > >>> +
> > > >>
> > > >> How exactly does this help? The guest is free to inflate/deflate
> > > >> whenever it wants.
> > > >
> > > > Guest is aware of hot-unplug start, and virtio driver should not
> > > > initiate any operations. This patch just restricts issuing commands
> > > > from qmp monitor.
> > >
> > > Why shouldn't the guest driver inflate/deflate while memory hotplug i=
s
> > > going on?
> > >
> > > Simple balloon compaction in a Linux guest -> deflate/inflate trigger=
ed
> > > in the hypervisor.
> >
> > QEMU crashes if inflate happens after powering-off PCI slot. Guest is
> > unable to interact with virtio-balloon device then, driver is
> > unloaded. But inflate can still happen if initiated from qmp.
> >
> > Best regards, Julia Suvorova.
>
> Hot-unplug in progress is probably a hack - we should
> prevent access when device is powered off.
> Also, it would appear that have_balloon is the correct place for this
> kind of check.

You're right, it is a hack. I can add another handler to check if
device is powered on, and check it in have_balloon(),
In assumption that have_balloon means than we can use balloon when
it's presented, it is fine. But it will get more complicated once
hidden devices are here.

Best regards, Julia Suvorova.


