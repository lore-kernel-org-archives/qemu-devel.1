Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFACC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E6B20869
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4xazEn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E6B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSKdk-0007Z1-16
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iSKcZ-0006d3-2J
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iSKcX-0008NI-Dr
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:41:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33568
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iSKcX-0008NA-AG
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573044068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YeZ3omQisP6oIpWqk/fhXQ/wM3qN3OMPusz9yyInI1M=;
 b=V4xazEn1xZW+n4qRYm46G3mJu3fWdWy0qBdKBHTd3Dx7LH20/75B0LLhq3rc+3jVL9q43y
 IFCmxxHlPJbzb0WOVpX/mPe+fmdV0RJMiBQQ/CAeoS+rWrCVB1h1TmsEIf0to5uzc8N1K6
 ydw1AoLRFtM3TzTOMt6jDkJ0b+XtsQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-OGswn-lfP0CJnLCdUHihtw-1; Wed, 06 Nov 2019 07:41:05 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C38D477;
 Wed,  6 Nov 2019 12:41:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05A69600C4;
 Wed,  6 Nov 2019 12:41:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3089A9D23; Wed,  6 Nov 2019 13:41:01 +0100 (CET)
Date: Wed, 6 Nov 2019 13:41:01 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: David Stevens <stevensd@chromium.org>
Subject: Re: guest / host buffer sharing ...
Message-ID: <20191106124101.fsfxibdkypo4rswv@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: OGswn-lfP0CJnLCdUHihtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: geoff@hostfission.com, Hans Verkuil <hverkuil@xs4all.nl>,
 Alex Lau <alexlau@chromium.org>, Alexandre Courbot <acourbot@chromium.org>,
 virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 Daniel Vetter <daniel@ffwll.ch>,
 =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 06, 2019 at 05:36:22PM +0900, David Stevens wrote:
> > (1) The virtio device
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Has a single virtio queue, so the guest can send commands to register
> > and unregister buffers.  Buffers are allocated in guest ram.  Each buff=
er
> > has a list of memory ranges for the data. Each buffer also has some
>=20
> Allocating from guest ram would work most of the time, but I think
> it's insufficient for many use cases. It doesn't really support things
> such as contiguous allocations, allocations from carveouts or <4GB,
> protected buffers, etc.

If there are additional constrains (due to gpu hardware I guess)
I think it is better to leave the buffer allocation to virtio-gpu.

virtio-gpu can't do that right now, but we have to improve virtio-gpu
memory management for vulkan support anyway.

> > properties to carry metadata, some fixed (id, size, application), but
>=20
> What exactly do you mean by application?

Basically some way to group buffers.  A wayland proxy for example would
add a "application=3Dwayland-proxy" tag to the buffers it creates in the
guest, and the host side part of the proxy could ask qemu (or another
vmm) to notify about all buffers with that tag.  So in case multiple
applications are using the device in parallel they don't interfere with
each other.

> > also allow free form (name =3D value, framebuffers would have
> > width/height/stride/format for example).
>=20
> Is this approach expected to handle allocating buffers with
> hardware-specific constraints such as stride/height alignment or
> tiling? Or would there need to be some alternative channel for
> determining those values and then calculating the appropriate buffer
> size?

No parameter negotiation.

cheers,
  Gerd


