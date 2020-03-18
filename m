Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5386FC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:24:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE8220768
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCmZF1sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE8220768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEUwb-00038o-9d
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 05:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jEUw3-0002i3-7V
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jEUvz-0004Y8-FG
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:24:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58337)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jEUvz-0004Uv-9d
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584523458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QpNZHI3ciXbSBYyCW7fMUXX0SBd9Ijwis/0eWUrFbo=;
 b=CCmZF1smujle7esrjPwiEyl1Tia3mqriei516k+bxU6dm9c8ZavtXhFHeLUkKFTdVJAooL
 YNa3Nv1MBJK+rF058k+OAuP/QckTW8btK8P4a5I3hcdI6K/uINfcw6BeNsiXo8jFEZzo9j
 szB+KJml9Eyg/Xi7XQsiONYciD/VNDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-sLkT8OtMPPi_dB7PNv434Q-1; Wed, 18 Mar 2020 05:24:15 -0400
X-MC-Unique: sLkT8OtMPPi_dB7PNv434Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00600100726A;
 Wed, 18 Mar 2020 09:24:14 +0000 (UTC)
Received: from work-vm (ovpn-115-3.ams2.redhat.com [10.36.115.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7ECBE94967;
 Wed, 18 Mar 2020 09:23:59 +0000 (UTC)
Date: Wed, 18 Mar 2020 09:23:57 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] pci: Display PCI IRQ pin in "info pci"
Message-ID: <20200318092357.GB2850@work-vm>
References: <20200317195908.283800-1-peterx@redhat.com>
 <20200317202117.GI3369@work-vm> <20200317203659.GC233068@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200317203659.GC233068@xz-x1>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> On Tue, Mar 17, 2020 at 08:21:17PM +0000, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > Sometimes it would be good to be able to read the pin number along
> > > with the IRQ number allocated.  Since we'll dump the IRQ number, no
> > > reason to not dump the pin information.  For example, the vfio-pci
> > > device will overwrite the pin with the hardware pin number.  It would
> > > be nice to know the pin number of one assigned device from QMP/HMP.
> > >=20
> > > CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > CC: Alex Williamson <alex.williamson@redhat.com>
> > > CC: Michael S. Tsirkin <mst@redhat.com>
> > > CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > CC: Julia Suvorova <jusual@redhat.com>
> > > CC: Markus Armbruster <armbru@redhat.com>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >=20
> > > This helped me to debug an IRQ sharing issue, so may good to have it
> > > in master too.
> > > ---
> > >  hw/pci/pci.c       | 1 +
> > >  monitor/hmp-cmds.c | 3 ++-
> > >  qapi/misc.json     | 6 ++++--
> > >  3 files changed, 7 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index e1ed6677e1..7ebf532ac9 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -1769,6 +1769,7 @@ static PciDeviceInfo *qmp_query_pci_device(PCID=
evice *dev, PCIBus *bus,
> > >      info->regions =3D qmp_query_pci_regions(dev);
> > >      info->qdev_id =3D g_strdup(dev->qdev.id ? dev->qdev.id : "");
> > > =20
> > > +    info->irq_pin =3D dev->config[PCI_INTERRUPT_PIN];
> > >      if (dev->config[PCI_INTERRUPT_PIN] !=3D 0) {
> > >          info->has_irq =3D true;
> > >          info->irq =3D dev->config[PCI_INTERRUPT_LINE];
> > > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > > index 58724031ea..04c86bbb03 100644
> > > --- a/monitor/hmp-cmds.c
> > > +++ b/monitor/hmp-cmds.c
> > > @@ -680,7 +680,8 @@ static void hmp_info_pci_device(Monitor *mon, con=
st PciDeviceInfo *dev)
> > >      }
> > > =20
> > >      if (dev->has_irq) {
> > > -        monitor_printf(mon, "      IRQ %" PRId64 ".\n", dev->irq);
> > > +        monitor_printf(mon, "      IRQ %" PRId64 ", pin %c\n",
> > > +                       dev->irq, (char)('A' + dev->irq_pin - 1));
> >=20
> > Can we trust dev->irq_pin not to be something silly and generate a
> > non-printable?
>=20
> It should be strictly a value between 1-4 corresponds to irq pin A-D
> (note the has_irq check masked out the zero value, or it could be
> 0-4), so I think it should always make sense. Otherwise I see it a
> qemu bug somewhere...

OK, then=20

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

for HMP.

Dave


> Thanks,
>=20
> --=20
> Peter Xu
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


