Received: from eggs.gnu.org ([2001:4830:134:3::10]:47948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cRiM8-0007Np-EM
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:36:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cRiM4-0005nk-HY
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:36:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cRiM4-0005nG-8w
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:36:00 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0CGV1tv030072
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 11:35:58 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27xa63hc34-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 11:35:57 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 11:35:56 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <bdc8e732-f2e9-ff08-9a0b-30ac16cbd9c2@redhat.com>
References: <20170105054618.GA12106@umbus.fritz.box>
	<1483724069.4199.80.camel@redhat.com>
	<20170108234621.GB12515@umbus.fritz.box>
	<1484217095.7948.1.camel@redhat.com>
	<bdc8e732-f2e9-ff08-9a0b-30ac16cbd9c2@redhat.com>
Date: Thu, 12 Jan 2017 10:35:37 -0600
Message-Id: <148423893781.24341.140388976706291486@loki>
Subject: Re: [Qemu-devel] Proposal PCI/PCIe device placement on PAPR guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laine Stump <laine@redhat.com>, Andrea Bolognani <abologna@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, libvir-list@redhat.com
Cc: thuth@redhat.com, lvivier@redhat.com, benh@kernel.crashing.org, marcel@redhat.com, aik@ozlabs.ru, groug@kaod.org, ehabkost@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

Quoting Laine Stump (2017-01-12 08:52:10)
> On 01/12/2017 05:31 AM, Andrea Bolognani wrote:
> > On Mon, 2017-01-09 at 10:46 +1100, David Gibson wrote:
> >>>>     * To allow for hotplugged devices, libvirt should also add a num=
ber
> >>>>       of additional, empty vPHBs (the PAPR spec allows for hotplug of
> >>>>       PHBs, but this is not yet implemented in qemu).
> >>>
> >>> "A number" here will have to mean "one", same number of
> >>> empty PCIe Root Ports libvirt will add to a newly-defined
> >>> q35 guest.
> >>
> >> Umm.. why?
> >
> > Because some applications using libvirt would inevitably
> > start relying on the fact that such spare PHBs are
> > available, locking us into providing at least the same
> > number forever. In other words, increasing the amount at
> > a later time is always possible, but decreasing it isn't.
> > We did the same when we started automatically adding PCIe
> > Root Ports to q35 machines.
> >
> > The rationale is that having a single spare hotpluggable
> > slot is extremely convenient for basic usage, eg. a simple
> > guest created by someone who's not necessarily very
> > familiar with virtualization; on the other hand, if you
> > are actually deploying in production you ought to conduct
> > proper capacity planning and figure out in advance how
> > many devices you're likely to need to hotplug throughout
> > the guest's life.
> =

> And of course the reason we don't want to add "too many" extra =

> controllers by default is so that we don't end up with *all* guests =

> burdened with extra hardware they don't need or want. The libguestfs =

> appliance is one example of a libvirt consumer that definitely doesn't =

> want extra baggage in its guests - guest startup time is very important =

> to libguestfs, so any addition to the hardware list is looked upon with =

> disappointment.
> =

> >
> > Of course this all will be moot once we can hotplug PHBs :)
> =

> Will the guest OSes handle that properly? I remember being told that =


I believe on pseries we *do* scan for devices on the PHB as part of
bringing the PHB online in the hotplug path. But I'm not sure that
matters (see below).

> Linux, for example, doesn't scan the new bus for devices when a new =

> controller is added, making it pointless to hotplug a PCI controller (as =

> usual, it could be that I'm remembering incorrectly...)
> =


Wouldn't that only be an issue if we hotplugged a PHB that already had
PCI devices on the bus? That only seems possible if we had a way to
signal phb hotplug *after* we've hotplugged some PCI devices on the bus,
which means we'd need some interface to trigger hotplug  beyond the
standard 'device_add' calls, e.g.:

  device_add spapr-pci-host-bridge,hotplug-deferred=3Dtrue,id=3Dphb2,index=
=3D2
  device_add virtio-net-pci,bus=3Dphb2.0,...,hotplug-deferred=3Dtrue
  device_signal_hotplug phb2

That's actually akin to how it's normally done on pHyp (not only for PHB
hotplug, but for PCI hotplug in general, which is why this could be
reasonably expected to work on pseries guests), but it seems quite a bit
different from how we'd normally handle this on kvm, which I think would
be something more like:

  device_add spapr-pci-host-bridge,id=3Dphb2,index=3D2
  <wait for hotplug completion event>
  device_add virtio-net-pci,bus=3Dphb2.0,...

In which case it doesn't really matter if the guest scans the bus at
hotplug time or not. Is there some other scenario where this might
arise?
