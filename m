Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69DCC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D3C217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMI7Wzzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D3C217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izJ0i-0005gz-Pz
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1izIzK-0004eI-GI
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1izIzJ-0003ym-8M
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:36:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52215
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1izIzJ-0003tU-3U
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580902616;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xr3GblePDmODr8yq6oYCprdHP70nLz5eWnTydksD7xg=;
 b=JMI7WzzuRq+wuup4oluT99gcxfqFft1+7hE8JRnVFhKO05m/tbSdM40QUBCFgOSDasvzzL
 MIncNphr6TbImz7/g3L87qSMabJsQ4OKL0cVPSDEEIapHDmIsqfzeV9/z1B/6kVqgIlIPe
 1XJs9XeDfOokyLaRDmVQefmP9RSmitw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-kpd5PVJ2O-eDzlJpCEp2WQ-1; Wed, 05 Feb 2020 06:36:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E55EA1137841
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 11:36:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B85D10027B3;
 Wed,  5 Feb 2020 11:36:39 +0000 (UTC)
Date: Wed, 5 Feb 2020 11:36:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Disabling PCI "hot-unplug" for a guest (and/or a single PCI
 device)
Message-ID: <20200205113637.GE2221087@redhat.com>
References: <16db1dcd-d1a3-5bd9-2daa-d16a0f2d168e@redhat.com>
 <20200204013947-mutt-send-email-mst@kernel.org>
 <CAMDeoFVkoTZSQ=PV=mc_AGoZ445Wug4F+RV5utaYb+jhPEtkJg@mail.gmail.com>
 <20200204113457-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200204113457-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: kpd5PVJ2O-eDzlJpCEp2WQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: libvir-list@redhat.com, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 04, 2020 at 11:35:37AM -0500, Michael S. Tsirkin wrote:
> On Tue, Feb 04, 2020 at 05:13:54PM +0100, Julia Suvorova wrote:
> > On Tue, Feb 4, 2020 at 11:26 AM Michael S. Tsirkin <mst@redhat.com> wro=
te:
> > >
> > > On Mon, Feb 03, 2020 at 05:19:51PM -0500, Laine Stump wrote:
> > > > 3) qemu could add a "hotpluggable=3Dno" commandline option to all P=
CI devices
> > > > (including vfio-pci) and then do whatever is necessary to make sure=
 this is
> > > > honored in the emulated hardware (is it possible to set this on a p=
er-slot
> > > > basis in a PCI controller? Or must it be done for an entire control=
ler?
> > >
> > > I think it's possible on a per-slot basis, yes.
> >=20
> > There's a "Hot-Plug Capable" option in Slot Capability register, so we
> > can switch it off. But it's only for pcie devices, can't say anything
> > about conventional pci.
> >=20
> > Best regards, Julia Suvorova.
>=20
> For conventional PCI, we can drop SHPC capability and remove
> the eject method from ACPI.

Before considering this, is there any compelling reason to care about
this for PCI ?  Currently with i440fx there's no direct representation
of the 32 slots as objects in either QEMU or libvirt. So extending this
to allow disabling hotplug for i440fx PCI slots is going to need much
more config work for QEMU, libvirt and mgmt apps.  Personally I'd only
do this for PCIe until there's a clear requirement given for legacy PCI
support too.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


