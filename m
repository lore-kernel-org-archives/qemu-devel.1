Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBB7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 378F721569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cc7b+koi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378F721569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugGb-0001en-AL
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1iuegq-0003jC-5u
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsuvorov@redhat.com>) id 1iuego-0006N6-D4
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:46:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33375
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsuvorov@redhat.com>) id 1iuego-0006Lh-5O
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579794397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kmriD2mM+e6KKghvVi1/3WUOd5aOJYaN9QqpTvLOSNQ=;
 b=cc7b+koib52ZOPzpSPrG2AFveriPXT6SvclB80dodvIr3aBNkWmtv5zXHLY2u63pHkc8Ci
 QAYv+R3ZGcFBOhcfJ8Fp3kK5TbbG3fPz3U8guyrXqbVpBl6sf1ZmDUVt5zIlHXkrolP63q
 a4LQtjZrLj4hFe/KRFr7P9iNSfEBbi0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-gtmRDd-FPgmwxao0mpUV8A-1; Thu, 23 Jan 2020 10:46:30 -0500
Received: by mail-lf1-f71.google.com with SMTP id y73so535931lff.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:46:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b6ei9jQV2lpe+I5Ke04IpporlTiD4ohdw7YEXDw5Wes=;
 b=QiSw72AGQxApTq4uaoCVSKfbXcPUpySJ7zpIFu/K155GCBECM98LqNyPW6Qe5UOKyk
 x1P+I0NmF74O8W449ldMUMHlZvlxdxvICqvH5ytTq+Sk+KrXQsMMld0y0mc4Tnefj2Bn
 XqvnCSGd22FbxVYui6M8fHN3c2be9v7eaxNmfftO01bgSU1iUL5p6WyyDju68RQQwiip
 +zjtZNL8lfXkKHlCMIBSC/opTCgAK0ru8OfBYGSJOiGw3XavVEc5bCsb86V6ureOGhAI
 aVv7JdCf5vMNe5faU4ErzJxWLNcn5AuPZksbayslpcTnDI7ZIhvn1dHq8khUYuJupKTw
 nzoA==
X-Gm-Message-State: APjAAAV2/k95JkfgefJCD0WFXupyWA4hnbGkRJ6ugoAW19lArK0u2N3M
 aEXp08ATmotsf27vI1r0Z9FdpMN2GPyDyndHJEpyyt6c7Q+7z+2y/eaPWgfS3ePKHLRNaLSpIBc
 T8E9030emUYtu8vf8J/bTxRNwPSfrKYE=
X-Received: by 2002:a2e:8316:: with SMTP id a22mr22991100ljh.141.1579794389117; 
 Thu, 23 Jan 2020 07:46:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwpDZ56sIxNz3macYW7AlsOpO5MWuTd70xsrOqdq53F/W+D22P34TBWAGcXHDFzO9VCnb0ZMykS0Q4PO4Df5oE=
X-Received: by 2002:a2e:8316:: with SMTP id a22mr22991084ljh.141.1579794388837; 
 Thu, 23 Jan 2020 07:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20200115224025.538368-1-jusual@redhat.com>
 <20200115224025.538368-3-jusual@redhat.com>
 <38fdd88d-1399-effb-b74b-e02b7343f044@redhat.com>
 <CAMDeoFX1eFToYOWmBaVOYHTnNka8Fwruq6PtX7GsAGTuS++u8w@mail.gmail.com>
 <095236a0-ba8c-55c6-f9fc-e2a4a809b274@redhat.com>
In-Reply-To: <095236a0-ba8c-55c6-f9fc-e2a4a809b274@redhat.com>
From: Julia Suvorova <jusual@redhat.com>
Date: Thu, 23 Jan 2020 16:46:18 +0100
Message-ID: <CAMDeoFWJJbLs_Dtkb2rqXYW-PMA=9Qwy83SnkqS2_-EOaNtiSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-balloon: Reject qmp_balloon during hot-unplug
To: David Hildenbrand <david@redhat.com>
X-MC-Unique: gtmRDd-FPgmwxao0mpUV8A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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

On Thu, Jan 23, 2020 at 3:17 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 23.01.20 15:08, Julia Suvorova wrote:
> > On Thu, Jan 16, 2020 at 1:36 PM David Hildenbrand <david@redhat.com> wr=
ote:
> >>
> >> On 15.01.20 23:40, Julia Suvorova wrote:
> >>> Hot-unplug takes some time due to communication with the guest.
> >>> Do not change the device while freeing up resources.
> >>>
> >>> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> >>> ---
> >>>  balloon.c                  | 2 +-
> >>>  hw/virtio/virtio-balloon.c | 9 ++++++++-
> >>>  include/sysemu/balloon.h   | 2 +-
> >>>  3 files changed, 10 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/balloon.c b/balloon.c
> >>> index f104b42961..998ec53a0f 100644
> >>> --- a/balloon.c
> >>> +++ b/balloon.c
> >>> @@ -119,5 +119,5 @@ void qmp_balloon(int64_t target, Error **errp)
> >>>      }
> >>>
> >>>      trace_balloon_event(balloon_opaque, target);
> >>> -    balloon_event_fn(balloon_opaque, target);
> >>> +    balloon_event_fn(balloon_opaque, target, errp);
> >>>  }
> >>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> >>> index 57f3b9f22d..0fa4e4454b 100644
> >>> --- a/hw/virtio/virtio-balloon.c
> >>> +++ b/hw/virtio/virtio-balloon.c
> >>> @@ -717,12 +717,19 @@ static void virtio_balloon_stat(void *opaque, B=
alloonInfo *info)
> >>>                                               VIRTIO_BALLOON_PFN_SHIF=
T);
> >>>  }
> >>>
> >>> -static void virtio_balloon_to_target(void *opaque, ram_addr_t target=
)
> >>> +static void virtio_balloon_to_target(void *opaque, ram_addr_t target=
,
> >>> +                                     Error **errp)
> >>>  {
> >>> +    DeviceState *bus_dev =3D qdev_get_bus_device(DEVICE(opaque));
> >>>      VirtIOBalloon *dev =3D VIRTIO_BALLOON(opaque);
> >>>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >>>      ram_addr_t vm_ram_size =3D get_current_ram_size();
> >>>
> >>> +    if (bus_dev && bus_dev->pending_deleted_event) {
> >>> +        error_setg(errp, "Hot-unplug of %s is in progress", vdev->na=
me);
> >>> +        return;
> >>> +    }
> >>> +
> >>
> >> How exactly does this help? The guest is free to inflate/deflate
> >> whenever it wants.
> >
> > Guest is aware of hot-unplug start, and virtio driver should not
> > initiate any operations. This patch just restricts issuing commands
> > from qmp monitor.
>
> Why shouldn't the guest driver inflate/deflate while memory hotplug is
> going on?
>
> Simple balloon compaction in a Linux guest -> deflate/inflate triggered
> in the hypervisor.

QEMU crashes if inflate happens after powering-off PCI slot. Guest is
unable to interact with virtio-balloon device then, driver is
unloaded. But inflate can still happen if initiated from qmp.

Best regards, Julia Suvorova.


