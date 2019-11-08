Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3354AC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 06:46:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13822178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 06:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghksLWxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13822178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSy2q-00036C-3n
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 01:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iSy20-0002dx-It
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 01:46:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iSy1z-0003pZ-1W
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 01:46:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iSy1y-0003oy-TG
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 01:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573195561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m/bqLadfwOeTsU/ItI+7qu4upomyLm0ZZcfICGf4qy4=;
 b=ghksLWxLte7NmrUz9Jai9oToHD5T4in+zJK5iHo2N72uyOtyxVpDnF2pMTRXIQEcmgQ0xc
 A8NoHCTxjkEDhz3NNZddbGOi1wdqv8L9JGL7f2/JbkVPg2BW5c53lAtR216IKXqAPodH1l
 k1dI9CLZ8WdcTeQqC3kuzMKHv0z9UJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-vLLi-eBjPey_43z9I0lf6Q-1; Fri, 08 Nov 2019 01:45:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00B388017DD;
 Fri,  8 Nov 2019 06:45:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 265E660BE2;
 Fri,  8 Nov 2019 06:45:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 56AAC11AAA; Fri,  8 Nov 2019 07:45:52 +0100 (CET)
Date: Fri, 8 Nov 2019 07:45:52 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
Message-ID: <20191108064552.hel54p6vvdpir2dp@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
 <20191106101057.GC2802@work-vm>
 <20191107111119.qgr2qxgdf64jurin@sirius.home.kraxel.org>
 <20191107111618.GE2816@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191107111618.GE2816@work-vm>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: vLLi-eBjPey_43z9I0lf6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: geoff@hostfission.com, virtio-dev@lists.oasis-open.org,
 Alex Lau <alexlau@chromium.org>, Alexandre Courbot <acourbot@chromium.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 David Stevens <stevensd@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 11:16:18AM +0000, Dr. David Alan Gilbert wrote:
> * Gerd Hoffmann (kraxel@redhat.com) wrote:
> >   Hi,
> >=20
> > > > This is not about host memory, buffers are in guest ram, everything=
 else
> > > > would make sharing those buffers between drivers inside the guest (=
as
> > > > dma-buf) quite difficult.
> > >=20
> > > Given it's just guest memory, can the guest just have a virt queue on
> > > which it places pointers to the memory it wants to share as elements =
in
> > > the queue?
> >=20
> > Well, good question.  I'm actually wondering what the best approach is
> > to handle long-living, large buffers in virtio ...
> >=20
> > virtio-blk (and others) are using the approach you describe.  They put =
a
> > pointer to the io request header, followed by pointer(s) to the io
> > buffers directly into the virtqueue.  That works great with storage for
> > example.  The queue entries are tagged being "in" or "out" (driver to
> > device or visa-versa), so the virtio transport can set up dma mappings
> > accordingly or even transparently copy data if needed.
> >=20
> > For long-living buffers where data can potentially flow both ways this
> > model doesn't fit very well though.  So what virtio-gpu does instead is
> > transferring the scatter list as virtio payload.  Does feel a bit
> > unclean as it doesn't really fit the virtio architecture.  It assumes
> > the host can directly access guest memory for example (which is usually
> > the case but explicitly not required by virtio).  It also requires
> > quirks in virtio-gpu to handle VIRTIO_F_IOMMU_PLATFORM properly, which
> > in theory should be handled fully transparently by the virtio-pci
> > transport.
> >=20
> > We could instead have a "create-buffer" command which adds the buffer
> > pointers as elements to the virtqueue as you describe.  Then simply
> > continue using the buffer even after completing the "create-buffer"
> > command.  Which isn't exactly clean either.  It would likewise assume
> > direct access to guest memory, and it would likewise need quirks for
> > VIRTIO_F_IOMMU_PLATFORM as the virtio-pci transport tears down the dma
> > mappings for the virtqueue entries after command completion.
> >=20
> > Comments, suggestions, ideas?
>=20
> What about not completing the command while the device is using the
> memory?

Thought about that too, but I don't think this is a good idea for
buffers which exist for a long time.

Example #1:  A video decoder would setup a bunch of buffers and use
them robin-round, so they would exist until the video playback is
finished.

Example #2:  virtio-gpu creates a framebuffer for fbcon which exists
forever.  And virtio-gpu potentially needs lots of buffers.  With 3d
active there can be tons of objects.  Although they typically don't
stay around that long we would still need a pretty big virtqueue to
store them all I guess.

And it also doesn't fully match the virtio spirit, it still assumes
direct guest memory access.  Without direct guest memory access
updates to the fbcon object would never reach the host for example.
In case a iommu is present we might need additional dma map flushes
for updates happening after submitting the lingering "create-buffer"
command.

cheers,
  Gerd


