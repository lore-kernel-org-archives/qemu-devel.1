Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6AFC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2782020661
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxWL4t0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2782020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw235-000530-Av
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 05:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iw22T-0004bN-Bd
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iw22R-0004xl-Jp
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:54:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50952
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iw22R-0004wL-E3
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:54:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580122478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VIC+ZA/oj2rj27unHv+n+ufgr4sUCZTT4FjufsLBt3Q=;
 b=TxWL4t0yyFlBdsTbPPs08ihTCXrwyw6fGrl/hQ0GD3a9w46IArye8LPmTZjPLhB8+u71Q6
 OqGeg/EFg5m4n0lmFVqo4SOQFQQWo0Q8lQg/jCPXLWvpDxgZ5iTPXilu/MTM22n26XAAI6
 I/bxjBAUl29Wg8y/MVVJAYQOcG5c+D8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-GtG-VjtNMTG-NmaqtAVZ_g-1; Mon, 27 Jan 2020 05:54:35 -0500
Received: by mail-qk1-f199.google.com with SMTP id s9so5897216qkg.21
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 02:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=REEIu007H68U0dPiq3v8cDdKJCUumdSbr9zqfgAje8k=;
 b=kMxA+ea4WDbJbSKblRfYwx9SIqpNMiLaD41ZXA25S36OnRKJWOapYzl6w7rZPjyUU+
 g/LjheWL0XJrsDDk01o//goUDid1AiveYiVR5fdCeaJ3rDXSgejimSAHeXYhcqONJ5hD
 iOzn++WYtPaxMcVf3ehnCcbTfP1uCX0j1IMub5QTUP9vqANUZ6R5AonDf0FfwkXI+lKf
 DDGEUsDTWDGpgh0rem4u5TpXCqBmqYbXea6jXm+McvR2+3u+LI2MXHni0QUrosgUiLqc
 ATDASBMzo7N2jmusZpDllpFDC/4J/RPylskvy2bKDQuKZLsujsi+ffWmdls7O30s7vQX
 sBlw==
X-Gm-Message-State: APjAAAULreV9eniQ4QHQu8G+SSW1/G0xZIAFM/tKYeebpEi6QGbExu1+
 P2FOO704QTaaTQqr92mgITB7iJ+vEIbTNiE/Tj+LaH55HF2r+Z/ZyQN20HDg5632rrnXWWmWr4d
 Bs/ujIBK0TM1MhxU=
X-Received: by 2002:a0c:f412:: with SMTP id h18mr16258375qvl.124.1580122475493; 
 Mon, 27 Jan 2020 02:54:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCxVpOniLnjedsWGFbBWR/V+FYVbKATexRsla8ppGSL+f1LPIb7iZ1NdZiqylKoeUrQ/St8A==
X-Received: by 2002:a0c:f412:: with SMTP id h18mr16258350qvl.124.1580122475163; 
 Mon, 27 Jan 2020 02:54:35 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id m27sm9983556qta.21.2020.01.27.02.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 02:54:34 -0800 (PST)
Date: Mon, 27 Jan 2020 05:54:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH 2/2] virtio-balloon: Reject qmp_balloon during hot-unplug
Message-ID: <20200127055127-mutt-send-email-mst@kernel.org>
References: <20200115224025.538368-1-jusual@redhat.com>
 <20200115224025.538368-3-jusual@redhat.com>
 <38fdd88d-1399-effb-b74b-e02b7343f044@redhat.com>
 <CAMDeoFX1eFToYOWmBaVOYHTnNka8Fwruq6PtX7GsAGTuS++u8w@mail.gmail.com>
 <095236a0-ba8c-55c6-f9fc-e2a4a809b274@redhat.com>
 <CAMDeoFWJJbLs_Dtkb2rqXYW-PMA=9Qwy83SnkqS2_-EOaNtiSg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMDeoFWJJbLs_Dtkb2rqXYW-PMA=9Qwy83SnkqS2_-EOaNtiSg@mail.gmail.com>
X-MC-Unique: GtG-VjtNMTG-NmaqtAVZ_g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 04:46:18PM +0100, Julia Suvorova wrote:
> On Thu, Jan 23, 2020 at 3:17 PM David Hildenbrand <david@redhat.com> wrot=
e:
> >
> > On 23.01.20 15:08, Julia Suvorova wrote:
> > > On Thu, Jan 16, 2020 at 1:36 PM David Hildenbrand <david@redhat.com> =
wrote:
> > >>
> > >> On 15.01.20 23:40, Julia Suvorova wrote:
> > >>> Hot-unplug takes some time due to communication with the guest.
> > >>> Do not change the device while freeing up resources.
> > >>>
> > >>> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > >>> ---
> > >>>  balloon.c                  | 2 +-
> > >>>  hw/virtio/virtio-balloon.c | 9 ++++++++-
> > >>>  include/sysemu/balloon.h   | 2 +-
> > >>>  3 files changed, 10 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/balloon.c b/balloon.c
> > >>> index f104b42961..998ec53a0f 100644
> > >>> --- a/balloon.c
> > >>> +++ b/balloon.c
> > >>> @@ -119,5 +119,5 @@ void qmp_balloon(int64_t target, Error **errp)
> > >>>      }
> > >>>
> > >>>      trace_balloon_event(balloon_opaque, target);
> > >>> -    balloon_event_fn(balloon_opaque, target);
> > >>> +    balloon_event_fn(balloon_opaque, target, errp);
> > >>>  }
> > >>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.=
c
> > >>> index 57f3b9f22d..0fa4e4454b 100644
> > >>> --- a/hw/virtio/virtio-balloon.c
> > >>> +++ b/hw/virtio/virtio-balloon.c
> > >>> @@ -717,12 +717,19 @@ static void virtio_balloon_stat(void *opaque,=
 BalloonInfo *info)
> > >>>                                               VIRTIO_BALLOON_PFN_SH=
IFT);
> > >>>  }
> > >>>
> > >>> -static void virtio_balloon_to_target(void *opaque, ram_addr_t targ=
et)
> > >>> +static void virtio_balloon_to_target(void *opaque, ram_addr_t targ=
et,
> > >>> +                                     Error **errp)
> > >>>  {
> > >>> +    DeviceState *bus_dev =3D qdev_get_bus_device(DEVICE(opaque));
> > >>>      VirtIOBalloon *dev =3D VIRTIO_BALLOON(opaque);
> > >>>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > >>>      ram_addr_t vm_ram_size =3D get_current_ram_size();
> > >>>
> > >>> +    if (bus_dev && bus_dev->pending_deleted_event) {
> > >>> +        error_setg(errp, "Hot-unplug of %s is in progress", vdev->=
name);
> > >>> +        return;
> > >>> +    }
> > >>> +
> > >>
> > >> How exactly does this help? The guest is free to inflate/deflate
> > >> whenever it wants.
> > >
> > > Guest is aware of hot-unplug start, and virtio driver should not
> > > initiate any operations. This patch just restricts issuing commands
> > > from qmp monitor.
> >
> > Why shouldn't the guest driver inflate/deflate while memory hotplug is
> > going on?
> >
> > Simple balloon compaction in a Linux guest -> deflate/inflate triggered
> > in the hypervisor.
>=20
> QEMU crashes if inflate happens after powering-off PCI slot. Guest is
> unable to interact with virtio-balloon device then, driver is
> unloaded. But inflate can still happen if initiated from qmp.
>=20
> Best regards, Julia Suvorova.

Hot-unplug in progress is probably a hack - we should
prevent access when device is powered off.
Also, it would appear that have_balloon is the correct place for this
kind of check.

--=20
MST


