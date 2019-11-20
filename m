Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24ACC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27D921D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0bXUotg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27D921D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMk6-00024f-Pz
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 04:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iXMgW-0000fL-Gl
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iXMgT-0002Hn-TH
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:54:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59598
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iXMgT-0002HB-Ck
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574243640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSNLpSLgx5w3Dbhz4nM58lFypQMHwE8ihrCJxNop32Q=;
 b=G0bXUotgAOO3cqshudTUgYPvJT6jwmXzh9MT5beRdROnuqIcZbGvxtNAAeG+81zkclIRod
 iYgj0Ry0z4rU6qjho9nFSUn4vK+FIuJSafr4KHqDMclKGmJkCsV3AlNLivR0IIHecZdy/y
 ybcjmvN2WWVW1L6RnHS/DgQBNSl7eJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-qWi47eunMXOdSOcEtNu-ag-1; Wed, 20 Nov 2019 04:53:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 731B3107ACC4;
 Wed, 20 Nov 2019 09:53:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBA5328DCB;
 Wed, 20 Nov 2019 09:53:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8157316E05; Wed, 20 Nov 2019 10:53:49 +0100 (CET)
Date: Wed, 20 Nov 2019 10:53:49 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
Message-ID: <20191120095349.oobeosin3lujgcja@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <CAD=HUj41r8wHZ2-By8tLftkoqC5r_Bw=pr=zX2aZ7GTs1ESWhg@mail.gmail.com>
 <c8a6b6f35664ce036c2a48ec41eab97b0f40704d.camel@linux.intel.com>
 <CAAfnVBkMWurTpseQFjcna5kk3__40n6M68=RTHLbQsu__2AFxg@mail.gmail.com>
 <4a5dd822e86757f004d04af62fb7dd35ba75392d.camel@linux.intel.com>
 <CAAfnVB=F+HeQrrn23c=rZeOa5BfHo=9ArcG--gLf87gqBXfZ9A@mail.gmail.com>
 <bee3aae13f6cf69ee909aa9884926853d6123b25.camel@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <bee3aae13f6cf69ee909aa9884926853d6123b25.camel@linux.intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: qWi47eunMXOdSOcEtNu-ag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: geoff@hostfission.com, virtio-dev@lists.oasis-open.org,
 Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alexandre Courbot <acourbot@chromium.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Keiichi Watanabe <keiichiw@chromium.org>,
 David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > > DSP FW has no access to userspace so we would need some additional
> > > API
> > > on top of DMA_BUF_SET_NAME etc to get physical hardware pages ?
> >=20
> > The dma-buf api currently can share guest memory sg-lists.
>=20
> Ok, IIUC buffers can either be shared using the GPU proposed APIs
> (above) or using the dma-buf API to share via userspace ? My preference
> would be to use teh more direct GPU APIs sending physical page
> addresses from Guest to device driver. I guess this is your use case
> too ?

I'm not convinced this is useful for audio ...

I basically see two modes of operation which are useful:

  (1) send audio data via virtqueue.
  (2) map host audio buffers into the guest address space.

The audio driver api (i.e. alsa) typically allows to mmap() the audio
data buffers, so it is the host audio driver which handles the
allocation.  Let the audio hardware dma from/to userspace-allocated
buffers is not possible[1], but we would need that to allow qemu (or
other vmms) use guest-allocated buffers.

cheers,
  Gerd

[1] Disclaimer: It's been a while I looked at alsa more closely, so
    there is a chance this might have changed without /me noticing.


