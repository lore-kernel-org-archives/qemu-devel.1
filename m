Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D857EC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 01:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DE32068D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 01:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZPvNrTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DE32068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXxky-0000Uq-Nz
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 20:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iXxkD-0008Nq-Qq
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 20:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iXxkB-0007hz-Fx
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 20:28:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56269
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iXxkB-0007gd-6n
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 20:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574386097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eOoIQ6ZM5aP+5cCkAfgVCL5YB6EKKUGoid+ERdnvkAA=;
 b=CZPvNrTzVCfpHKfh99dGCi7cqJ2Abb4Q6ko+0sSQgZm4Y/pI6+kfx0SrHVDMPP+Mngzak7
 gsrPvlqKJ0LxJryRWMapMvZvPQBx0UgVWE2xFmBtwKAXBhy9u2hoWtic1g2UMKficggcpd
 gmZRtrR600VnIrY7MCIRMNFD4wfn0OY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-VcubhflpOPWSA7PCIVpJFQ-1; Thu, 21 Nov 2019 20:28:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44B92DBA3;
 Fri, 22 Nov 2019 01:28:15 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E91F66844;
 Fri, 22 Nov 2019 01:28:08 +0000 (UTC)
Date: Thu, 21 Nov 2019 18:28:07 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/5] vfio/spapr: Handle changes of master irq chip for
 VFIO devices
Message-ID: <20191121182807.51caac33@x1.home>
In-Reply-To: <20191122011824.GX5582@umbus.fritz.box>
References: <20191121005607.274347-1-david@gibson.dropbear.id.au>
 <20191121095738.71f90700@x1.home>
 <20191122011824.GX5582@umbus.fritz.box>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: VcubhflpOPWSA7PCIVpJFQ-1
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

On Fri, 22 Nov 2019 12:18:24 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Nov 21, 2019 at 09:57:38AM -0700, Alex Williamson wrote:
> > On Thu, 21 Nov 2019 11:56:02 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > Due to the way feature negotiation works in PAPR (which is a
> > > paravirtualized platform), we can end up changing the global irq chip
> > > at runtime, including it's KVM accelerate model.  That causes
> > > complications for VFIO devices with INTx, which wire themselves up
> > > directly to the KVM irqchip for performance.
> > >=20
> > > This series introduces a new notifier to let VFIO devices (and
> > > anything else that needs to in the future) know about changes to the
> > > master irqchip.  It modifies VFIO to respond to the notifier,
> > > reconnecting itself to the new KVM irqchip as necessary.
> > >=20
> > > In particular this removes a misleading (though not wholly inaccurate=
)
> > > warning that occurs when using VFIO devices on a pseries machine type
> > > guest.
> > >=20
> > > Open question: should this go into qemu-4.2 or wait until 5.0?  It's
> > > has medium complexity / intrusiveness, but it *is* a bugfix that I
> > > can't see a simpler way to fix.  It's effectively a regression from
> > > qemu-4.0 to qemu-4.1 (because that introduced XIVE support by
> > > default), although not from 4.1 to 4.2. =20
> >=20
> > Looks reasonable to me for 4.2, the vfio changes are not as big as they
> > appear.  If Paolo approves this week, I can send a pull request,
> > otherwise I can leave my ack for someone else as I'll be on PTO/holiday
> > next week.  Thanks, =20
>=20
> I'm happy to take it through my tree, and expect to be sending a PR in
> that timescale, so an ack sounds good.
>=20
> I've pulled the series into my ppc-for-4.2 branch tentatively.
>=20

Tested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>


