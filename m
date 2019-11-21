Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B77FC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CD8206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z212VZc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CD8206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXpna-0006u7-9Y
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 11:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iXpmF-0005nx-2j
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:57:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iXpmD-0005fy-VD
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:57:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20157
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iXpmD-0005fh-Rz
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574355472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wPj1m6+drg+oILMh2H+/BPr6fP5ZP3kQTJLdsJy7moo=;
 b=Z212VZc9mmNjCYYHWoko3aGzFMCaQWBdFMelmZfF+XiS6CG2SslQdqMlCwbOCjvMqPV3KE
 x6nOg6zwKdldHPGOIs5ELDUS/Rpb+ZVhSg9cN9HlZjBJhqpEs7dg8yjXOlncSODGLCubwd
 d/xKyDN5dBokYl2Bt3740EaVr62gYFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-C8vod6QUMlWe2SJwRlZISg-1; Thu, 21 Nov 2019 11:57:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAD1BDBF5;
 Thu, 21 Nov 2019 16:57:48 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D62860556;
 Thu, 21 Nov 2019 16:57:39 +0000 (UTC)
Date: Thu, 21 Nov 2019 09:57:38 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/5] vfio/spapr: Handle changes of master irq chip for
 VFIO devices
Message-ID: <20191121095738.71f90700@x1.home>
In-Reply-To: <20191121005607.274347-1-david@gibson.dropbear.id.au>
References: <20191121005607.274347-1-david@gibson.dropbear.id.au>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: C8vod6QUMlWe2SJwRlZISg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 Nov 2019 11:56:02 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Due to the way feature negotiation works in PAPR (which is a
> paravirtualized platform), we can end up changing the global irq chip
> at runtime, including it's KVM accelerate model.  That causes
> complications for VFIO devices with INTx, which wire themselves up
> directly to the KVM irqchip for performance.
>=20
> This series introduces a new notifier to let VFIO devices (and
> anything else that needs to in the future) know about changes to the
> master irqchip.  It modifies VFIO to respond to the notifier,
> reconnecting itself to the new KVM irqchip as necessary.
>=20
> In particular this removes a misleading (though not wholly inaccurate)
> warning that occurs when using VFIO devices on a pseries machine type
> guest.
>=20
> Open question: should this go into qemu-4.2 or wait until 5.0?  It's
> has medium complexity / intrusiveness, but it *is* a bugfix that I
> can't see a simpler way to fix.  It's effectively a regression from
> qemu-4.0 to qemu-4.1 (because that introduced XIVE support by
> default), although not from 4.1 to 4.2.

Looks reasonable to me for 4.2, the vfio changes are not as big as they
appear.  If Paolo approves this week, I can send a pull request,
otherwise I can leave my ack for someone else as I'll be on PTO/holiday
next week.  Thanks,

Alex
=20
> Changes since RFC:
>  * Fixed some incorrect error paths pointed by aw in 3/5
>  * 5/5 had some problems previously, but they have been obsoleted by
>    other changes merged in the meantime
>=20
> David Gibson (5):
>   kvm: Introduce KVM irqchip change notifier
>   vfio/pci: Split vfio_intx_update()
>   vfio/pci: Respond to KVM irqchip change notifier
>   spapr: Handle irq backend changes with VFIO PCI devices
>   spapr: Work around spurious warnings from vfio INTx initialization
>=20
>  accel/kvm/kvm-all.c    | 18 ++++++++++++
>  accel/stubs/kvm-stub.c | 12 ++++++++
>  hw/ppc/spapr_irq.c     | 17 +++++++++++-
>  hw/vfio/pci.c          | 62 +++++++++++++++++++++++++++---------------
>  hw/vfio/pci.h          |  1 +
>  include/sysemu/kvm.h   |  5 ++++
>  6 files changed, 92 insertions(+), 23 deletions(-)
>=20


