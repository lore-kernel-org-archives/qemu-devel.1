Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AC9C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 22:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504E0214D8
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 22:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="EgCcCnwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504E0214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSToV-0003lM-UN
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 17:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1iSTmm-0002ON-UT
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 17:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geoff@hostfission.com>) id 1iSTml-0007aj-JP
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 17:28:20 -0500
Received: from mail1.hostfission.com ([139.99.139.48]:33342)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <geoff@hostfission.com>) id 1iSTmh-0007Um-64
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 17:28:18 -0500
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id 445DB4BD2F;
 Thu,  7 Nov 2019 09:28:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1573079290;
 bh=dXmtmkneSGouiL7jenHTBXFMoa7wB625pUnN8SmvAHk=;
 h=To:Subject:Date:From:Cc:In-Reply-To:References:From;
 b=EgCcCnwLhHs5+Alq3DwwseY7Vd7MpbIhKv1XIPZcV2EXSaiiMHOyeInLtZwtSw0Wz
 Ol1eDBAGJELWxlhNG+/AhHS2vQ426qFd2WwsiIXiYsP2pVOYEBSVrnXQCVJCnicz3M
 eZLVSczqVA5NVqNaBEgBH66wPj+dR9YjPYZxB1B0=
Received: by www1.hostfission.com (Postfix, from userid 1000)
 id 2B9FB804F5; Thu,  7 Nov 2019 09:28:10 +1100 (AEDT)
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: guest / host buffer sharing ...
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Nov 2019 09:28:10 +1100
From: Geoffrey McRae <geoff@hostfission.com>
Cc: David Stevens <stevensd@chromium.org>, Keiichi Watanabe
 <keiichiw@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Dmitry Morozov
 <dmitry.morozov@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>,
 Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak
 <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter
 <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>, Linux
 Media Mailing List <linux-media@vger.kernel.org>,
 virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
In-Reply-To: <20191106124101.fsfxibdkypo4rswv@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
 <20191106124101.fsfxibdkypo4rswv@sirius.home.kraxel.org>
Message-ID: <72712fe048af1489368f7416faa92c45@hostfission.com>
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



On 2019-11-06 23:41, Gerd Hoffmann wrote:
> On Wed, Nov 06, 2019 at 05:36:22PM +0900, David Stevens wrote:
>> > (1) The virtio device
>> > =====================
>> >
>> > Has a single virtio queue, so the guest can send commands to register
>> > and unregister buffers.  Buffers are allocated in guest ram.  Each buffer
>> > has a list of memory ranges for the data. Each buffer also has some
>> 
>> Allocating from guest ram would work most of the time, but I think
>> it's insufficient for many use cases. It doesn't really support things
>> such as contiguous allocations, allocations from carveouts or <4GB,
>> protected buffers, etc.
> 
> If there are additional constrains (due to gpu hardware I guess)
> I think it is better to leave the buffer allocation to virtio-gpu.

The entire point of this for our purposes is due to the fact that we can
not allocate the buffer, it's either provided by the GPU driver or
DirectX. If virtio-gpu were to allocate the buffer we might as well 
forget
all this and continue using the ivshmem device.

Our use case is niche, and the state of things may change if vendors 
like
AMD follow through with their promises and give us SR-IOV on consumer
GPUs, but even then we would still need their support to achieve the 
same
results as the same issue would still be present.

Also don't forget that QEMU already has a non virtio generic device
(IVSHMEM). The only difference is, this device doesn't allow us to 
attain
zero-copy transfers.

Currently IVSHMEM is used by two projects that I am aware of, Looking
Glass and SCREAM. While Looking Glass is solving a problem that is out 
of
scope for QEMU, SCREAM is working around the audio problems in QEMU that
have been present for years now.

While I don't agree with SCREAM being used this way (we really need a
virtio-sound device, and/or intel-hda needs to be fixed), it again is an
example of working around bugs/faults/limitations in QEMU by those of us
that are unable to fix them ourselves and seem to have low priority to 
the
QEMU project.

What we are trying to attain is freedom from dual boot Linux/Windows
systems, not migrate-able enterprise VPS configurations. The Looking
Glass project has brought attention to several other bugs/problems in
QEMU, some of which were fixed as a direct result of this project (i8042
race, AMD NPT).

Unless there is another solution to getting the guest GPUs frame-buffer
back to the host, a device like this will always be required. Since the
landscape could change at any moment, this device should not be a LG
specific device, but rather a generic device to allow for other
workarounds like LG to be developed in the future should they be 
required.

Is it optimal? no
Is there a better solution? not that I am aware of

> 
> virtio-gpu can't do that right now, but we have to improve virtio-gpu
> memory management for vulkan support anyway.
> 
>> > properties to carry metadata, some fixed (id, size, application), but
>> 
>> What exactly do you mean by application?
> 
> Basically some way to group buffers.  A wayland proxy for example would
> add a "application=wayland-proxy" tag to the buffers it creates in the
> guest, and the host side part of the proxy could ask qemu (or another
> vmm) to notify about all buffers with that tag.  So in case multiple
> applications are using the device in parallel they don't interfere with
> each other.
> 
>> > also allow free form (name = value, framebuffers would have
>> > width/height/stride/format for example).
>> 
>> Is this approach expected to handle allocating buffers with
>> hardware-specific constraints such as stride/height alignment or
>> tiling? Or would there need to be some alternative channel for
>> determining those values and then calculating the appropriate buffer
>> size?
> 
> No parameter negotiation.
> 
> cheers,
>   Gerd

