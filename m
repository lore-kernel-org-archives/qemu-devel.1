Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEB9C010A2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 11:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A1A217F5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 11:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="aobnrcRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A1A217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRx97-0007ZY-7f
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 06:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1iRx7t-0006i2-C7
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geoff@hostfission.com>) id 1iRx7r-0004t0-Ur
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:35:57 -0500
Received: from mail1.hostfission.com ([139.99.139.48]:40740)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <geoff@hostfission.com>) id 1iRx7r-0004rj-Cw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:35:55 -0500
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id 69CC54BB2F;
 Tue,  5 Nov 2019 22:35:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1572953751;
 bh=Zw56D+Lu/znhm5oRa5VDkM2uIIC+CjFGlW6S6Nwj2xU=;
 h=To:Subject:Date:From:Cc:In-Reply-To:References:From;
 b=aobnrcRsS6jkl3xwZG4yR7bumrBzyFPRJoL665omQGm7cmFj+DA3fvkDb6bnNfWLl
 jvdoo3jvXEQpOAh4l0GrjFFmX2uLzYbbClHQdjrHE1ceIXrQq5Atj1Y7RlPkEa/5jJ
 pBd6whBh3TdfkSDYRHauteDATsAGzQW7Rhxj1/PU=
Received: by www1.hostfission.com (Postfix, from userid 1000)
 id 60AC9804E7; Tue,  5 Nov 2019 22:35:51 +1100 (AEDT)
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: guest / host buffer sharing ...
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 05 Nov 2019 22:35:51 +1100
From: Geoffrey McRae <geoff@hostfission.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, David Stevens
 <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Dmitry Morozov
 <dmitry.morozov@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>,
 Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak
 <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter
 <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>, Linux
 Media Mailing List <linux-media@vger.kernel.org>,
 virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
In-Reply-To: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
Message-ID: <7255d3ca5f10bbf14b1a3fcb6ac34a19@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.2.3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 139.99.139.48
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd.

On 2019-11-05 21:54, Gerd Hoffmann wrote:
> Hi folks,
> 
> The issue of sharing buffers between guests and hosts keeps poping
> up again and again in different contexts.  Most recently here:
> 
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg656685.html
> 
> So, I'm grabbing the recipient list of the virtio-vdec thread and some
> more people I know might be interested in this, hoping to have everyone
> included.
> 
> Reason is:  Meanwhile I'm wondering whenever "just use virtio-gpu
> resources" is really a good answer for all the different use cases
> we have collected over time.  Maybe it is better to have a dedicated
> buffer sharing virtio device?  Here is the rough idea:
> 

This would be the ultimate solution to this, it would also make it the 
defacto device, possibly even leading to the deprecation of the IVSHMEM 
device.

> 
> (1) The virtio device
> =====================
> 
> Has a single virtio queue, so the guest can send commands to register
> and unregister buffers.  Buffers are allocated in guest ram.  Each 
> buffer
> has a list of memory ranges for the data.  Each buffer also has some
> properties to carry metadata, some fixed (id, size, application), but
> also allow free form (name = value, framebuffers would have
> width/height/stride/format for example).
> 

Perfect, however since it's to be a generic device there also needs to 
be a
method in the guest to identify which device is the one the application 
is
interested in without opening the device. Since windows makes the
subsystem vendor ID and device ID available to the userspace 
application,
I suggest these be used for this purpose.

To avoid clashes a simple text file to track reservations of subsystem 
IDs
for applications/protocols would be recommended.

The device should also support a reset feature allowing the guest to
notify the host application that all buffers have become invalid such as
on abnormal termination of the guest application that is using the 
device.

Conversely, qemu on unix socket disconnect should notify the guest of 
this
event also, allowing each end to properly syncronize.

> 
> (2) The linux guest implementation
> ==================================
> 
> I guess I'd try to make it a drm driver, so we can re-use drm
> infrastructure (shmem helpers for example).  Buffers are dumb drm
> buffers.  dma-buf import and export is supported (shmem helpers
> get us that for free).  Some device-specific ioctls to get/set
> properties and to register/unregister the buffers on the host.
> 

I would be happy to do what I can to implement the windows driver for 
this
if nobody else is interested in doing so, however, my abilities in this
field is rather limited and the results may not be that great :)

> 
> (3) The qemu host implementation
> ================================
> 
> qemu (likewise other vmms) can use the udmabuf driver to create
> host-side dma-bufs for the buffers.  The dma-bufs can be passed to
> anyone interested, inside and outside qemu.  We'll need some protocol
> for communication between qemu and external users interested in those
> buffers, to receive dma-bufs (via unix file descriptor passing) and
> update notifications.  Dispatching updates could be done based on the
> application property, which could be "virtio-vdec" or "wayland-proxy"
> for example.

I don't know enough about udmabuf to really comment on this except to 
ask
a question. Would this make guest to guest transfers without an
intermediate buffer possible?

-Geoff

> 
> 
> commments?
> 
> cheers,
>   Gerd

