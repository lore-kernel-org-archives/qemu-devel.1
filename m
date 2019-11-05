Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC625C010B4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 10:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7A82190F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 10:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRiSBYA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7A82190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRwV3-0002xG-Qa
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 05:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iRwUM-0002RY-Ma
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 05:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iRwUJ-0002E6-Sv
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 05:55:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23311
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iRwUJ-0002DM-Ha
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 05:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572951302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sIQ1jZwoR2tUq12TbfN95oJSdxSRsIhx/PvNCM2nGQQ=;
 b=DRiSBYA3lXoj5RPHYc15/Be7Av5BHbKx8j1334nqsL+15uFn8MzhD2Z8BdZ9+FYDVd3PlP
 Omfuevo+xxZgI5JnXfi82iSOwc7cNcYqx8+7xKjIQYkROfGNJeTadJ67gXquP7dZGJ6ftb
 Ju547oOhIyrkkLzFsAmHex/Xz81xtyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-q3y6bil_Nw-sp9D_30H07Q-1; Tue, 05 Nov 2019 05:55:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45A818017DD;
 Tue,  5 Nov 2019 10:54:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9130F46;
 Tue,  5 Nov 2019 10:54:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AB9F317535; Tue,  5 Nov 2019 11:54:56 +0100 (CET)
Date: Tue, 5 Nov 2019 11:54:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Keiichi Watanabe <keiichiw@chromium.org>
Subject: guest / host buffer sharing ...
Message-ID: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: q3y6bil_Nw-sp9D_30H07Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: geoff@hostfission.com, virtio-dev@lists.oasis-open.org,
 Alex Lau <alexlau@chromium.org>, Alexandre Courbot <acourbot@chromium.org>,
 qemu-devel@nongnu.org, Tomasz Figa <tfiga@chromium.org>,
 Hans Verkuil <hverkuil@xs4all.nl>, David Stevens <stevensd@chromium.org>,
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

  Hi folks,

The issue of sharing buffers between guests and hosts keeps poping
up again and again in different contexts.  Most recently here:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg656685.html

So, I'm grabbing the recipient list of the virtio-vdec thread and some
more people I know might be interested in this, hoping to have everyone
included.

Reason is:  Meanwhile I'm wondering whenever "just use virtio-gpu
resources" is really a good answer for all the different use cases
we have collected over time.  Maybe it is better to have a dedicated
buffer sharing virtio device?  Here is the rough idea:


(1) The virtio device
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Has a single virtio queue, so the guest can send commands to register
and unregister buffers.  Buffers are allocated in guest ram.  Each buffer
has a list of memory ranges for the data.  Each buffer also has some
properties to carry metadata, some fixed (id, size, application), but
also allow free form (name =3D value, framebuffers would have
width/height/stride/format for example).


(2) The linux guest implementation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

I guess I'd try to make it a drm driver, so we can re-use drm
infrastructure (shmem helpers for example).  Buffers are dumb drm
buffers.  dma-buf import and export is supported (shmem helpers
get us that for free).  Some device-specific ioctls to get/set
properties and to register/unregister the buffers on the host.


(3) The qemu host implementation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

qemu (likewise other vmms) can use the udmabuf driver to create
host-side dma-bufs for the buffers.  The dma-bufs can be passed to
anyone interested, inside and outside qemu.  We'll need some protocol
for communication between qemu and external users interested in those
buffers, to receive dma-bufs (via unix file descriptor passing) and
update notifications.  Dispatching updates could be done based on the
application property, which could be "virtio-vdec" or "wayland-proxy"
for example.


commments?

cheers,
  Gerd


