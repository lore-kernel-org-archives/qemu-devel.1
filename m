Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9F1C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D03B214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7iwBPVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D03B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPCK-000084-Ev
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:12:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ifOYY-0000pd-IP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 08:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ifOYU-0006aB-KZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 08:31:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52875
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ifOYU-0006XA-93
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 08:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576157457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RzZIpRRe+E7GSX3vBKD3/vOsPzUov2OSOdMVEJzYEhQ=;
 b=E7iwBPVXA4k0GGDyv7gNhalopAMqMHbIoVtlaEAfXiU71XpCFxucNXFHRYVQKjuVyARuKa
 ZTvSn9lqZikOYJQEn1BTJAwypWhBSdpzWRD3EVqUYpfg4fijNLyKAaT7yrLaSDMQKcjCbb
 kETVREvIktuv6nHMtmsRWFCmo44AA1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-y4I0-nPNMs6f0eiAd_yjOg-1; Thu, 12 Dec 2019 08:30:53 -0500
X-MC-Unique: y4I0-nPNMs6f0eiAd_yjOg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64082800D41;
 Thu, 12 Dec 2019 13:30:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.36.118.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96EE260BF3;
 Thu, 12 Dec 2019 13:30:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CB51B9DA4; Thu, 12 Dec 2019 14:30:48 +0100 (CET)
Date: Thu, 12 Dec 2019 14:30:48 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: David Stevens <stevensd@chromium.org>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
Message-ID: <20191212133048.4nbmuwhbq5z2ai6o@sirius.home.kraxel.org>
References: <72712fe048af1489368f7416faa92c45@hostfission.com>
 <CAAFQd5Cpb=3HRL3NbgxP+S259nkNEuA=u75ew1JQTzvVUU5NeQ@mail.gmail.com>
 <d65bec5074eda5f389668e28922c1609@hostfission.com>
 <CAAFQd5AWqYaNWfYQ2hepjg7OD8y8ehHn0guusAR8JYefc+BNaw@mail.gmail.com>
 <CAEUnVG77y2DrV5kLTHDy1xio+yzMGv9j=M0c4388vH_LUaiXLg@mail.gmail.com>
 <CAD=HUj40Jb2cy8EP=24coO-CPUvq6ib+01bvXHn1G9GD8KuenA@mail.gmail.com>
 <20191211092625.jzqx2ukphhggwavo@sirius.home.kraxel.org>
 <CAD=HUj7d3SWqCH=57ymy-BVd6xdJWc=WSqHAFyQXt-3MjchEAA@mail.gmail.com>
 <20191212094121.by7w7fywlzdfoktn@sirius.home.kraxel.org>
 <CAD=HUj6YYupjdxxz2mgMmE2DcKhXP-qdhRORvUNTmzcORRrLzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=HUj6YYupjdxxz2mgMmE2DcKhXP-qdhRORvUNTmzcORRrLzg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Geoffrey McRae <geoff@hostfission.com>, Hans Verkuil <hverkuil@xs4all.nl>,
 Zach Reizner <zachr@chromium.org>, Alexandre Courbot <acourbot@chromium.org>,
 virtio-dev@lists.oasis-open.org, qemu-devel <qemu-devel@nongnu.org>,
 Alex Lau <alexlau@chromium.org>, Tomasz Figa <tfiga@chromium.org>,
 Keiichi Watanabe <keiichiw@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 09:26:32PM +0900, David Stevens wrote:
> > > > Second I think it is a bad idea
> > > > from the security point of view.  When explicitly exporting buffers it
> > > > is easy to restrict access to the actual exports.
> > >
> > > Restricting access to actual exports could perhaps help catch bugs.
> > > However, I don't think it provides any security guarantees, since the
> > > guest can always just export every buffer before using it.
> >
> > Probably not on the guest/host boundary.
> >
> > It's important for security inside the guest though.  You don't want
> > process A being able to access process B private resources via buffer
> > sharing support, by guessing implicit buffer identifiers.
> 
> At least for the linux guest implementation, I wouldn't think the
> uuids would be exposed from the kernel. To me, it seems like something
> that should be handled internally by the virtio drivers.

That would be one possible use case, yes.  The exporting driver attaches
a uuid to the dma-buf.  The importing driver can see the attached uuid
and use it (if supported, otherwise run with the scatter list).  That
will be transparent to userspace, apps will just export/import dma-bufs
as usual and not even notice the uuid.

I can see other valid use cases though:  A wayland proxy could use
virtio-gpu buffer exports for shared memory and send the buffer uuid
to the host over some stream protocol (vsock, tcp, ...).  For that to
work we have to export the uuid to userspace, for example using a ioctl
on the dma-buf file handle.

> If you use some other guest with untrusted
> userspace drivers, or if you're pulling the uuids out of the kernel to
> give to some non-virtio transport, then I can see it being a concern.

I strongly prefer a design where we don't have to worry about that
concern in the first place instead of discussing whenever we should be
worried or not.

> > Without buffer sharing support the driver importing a virtio-gpu dma-buf
> > can send the buffer scatter list to the host.  So both virtio-gpu and
> > the other device would actually access the same guest pages, but they
> > are not aware that the buffer is shared between devices.
> 
> With the uuid approach, how should this case be handled? Should it be
> equivalent to exporting and importing the buffer which was created
> first? Should the spec say it's undefined behavior that might work as
> expected but might not, depending on the device implementation? Does
> the spec even need to say anything about it?

Using the uuid is an optional optimization.  I'd expect the workflow be
roughly this:

  (1) exporting driver exports a dma-buf as usual, additionally attaches
      a uuid to it and notifies the host (using device-specific commands).
  (2) importing driver will ask the host to use the buffer referenced by
      the given uuid.
  (3) if (2) fails for some reason use the dma-buf scatter list instead.

Of course only virtio drivers would try step (2), other drivers (when
sharing buffers between intel gvt device and virtio-gpu for example)
would go straight to (3).

> > With buffer sharing virtio-gpu would attach a uuid to the dma-buf, and
> > the importing driver can send the uuid (instead of the scatter list) to
> > the host.  So the device can simply lookup the buffer on the host side
> > and use it directly.  Another advantage is that this enables some more
> > use cases like sharing buffers between devices which are not backed by
> > guest ram.
> 
> Not just buffers not backed by guest ram, but things like fences. I
> would suggest the uuids represent 'exported resources' rather than
> 'exported buffers'.

Hmm, I can't see how this is useful.  Care to outline how you envision
this to work in a typical use case?

cheers,
  Gerd


