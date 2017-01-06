Received: from eggs.gnu.org ([2001:4830:134:3::10]:53260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cPTCx-0000qX-96
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:01:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cPTCu-0002wr-7b
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:01:19 -0500
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:49025)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cPTCt-0002vn-Vo
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:01:16 -0500
Received: from player696.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 50936FAC6
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 13:01:14 +0100 (CET)
Date: Fri, 6 Jan 2017 13:01:01 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170106130101.5b88cfec@bahia.lan>
In-Reply-To: <20170105054618.GA12106@umbus.fritz.box>
References: <20170105054618.GA12106@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/uvC8+YzkrhTxlw.Etboll1C";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] Proposal PCI/PCIe device placement on PAPR guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: abologna@redhat.com, thuth@redhat.com, lvivier@redhat.com, benh@kernel.crashing.org, marcel@redhat.com, aik@ozlabs.ru, ehabkost@redhat.com, mdroth@linux.vnet.ibm.com, libvir-list@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/uvC8+YzkrhTxlw.Etboll1C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Resending because of bad qemu-devel address...

On Thu, 5 Jan 2017 16:46:18 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> There was a discussion back in November on the qemu list which spilled
> onto the libvirt list about how to add support for PCIe devices to
> POWER VMs, specifically 'pseries' machine type PAPR guests.
>=20
> Here's a more concrete proposal for how to handle part of this in
> future from the libvirt side.  Strictly speaking what I'm suggesting
> here isn't intrinsically linked to PCIe: it will make adding PCIe
> support sanely easier, as well as having a number of advantages for
> both PCIe and plain-PCI devices on PAPR guests.
>=20
> Background:
>=20
>  * Currently the pseries machine type only supports vanilla PCI
>    buses.
>     * This is a qemu limitation, not something inherent - PAPR guests
>       running under PowerVM (the IBM hypervisor) can use passthrough
>       PCIe devices (PowerVM doesn't emulate devices though).
>     * In fact the way PCI access is para-virtalized in PAPR makes the
>       usual distinctions between PCI and PCIe largely disappear
>  * Presentation of PCIe devices to PAPR guests is unusual
>     * Unlike x86 - and other "bare metal" platforms, root ports are
>       not made visible to the guest. i.e. all devices (typically)
>       appear as though they were integrated devices on x86
>     * In terms of topology all devices will appear in a way similar to
>       a vanilla PCI bus, even PCIe devices
>        * However PCIe extended config space is accessible
>     * This means libvirt's usual placement of PCIe devices is not
>       suitable for PAPR guests
>  * PAPR has its own hotplug mechanism
>     * This is used instead of standard PCIe hotplug
>     * This mechanism works for both PCIe and vanilla-PCI devices
>     * This can hotplug/unplug devices even without a root port P2P
>       bridge between it and the root "bus
>  * Multiple independent host bridges are routine on PAPR
>     * Unlike PC (where all host bridges have multiplexed access to
>       configuration space) PCI host bridges (PHBs) are truly
>       independent for PAPR guests (disjoint MMIO regions in system
>       address space)
>     * PowerVM typically presents a separate PHB to the guest for each
>       host slot passed through
>=20
> The Proposal:
>=20
> I suggest that libvirt implement a new default algorithm for placing
> (i.e. assigning addresses to) both PCI and PCIe devices for (only)
> PAPR guests.
>=20
> The short summary is that by default it should assign each device to a
> separate vPHB, creating vPHBs as necessary.
>=20
>   * For passthrough sometimes a group of host devices can't be safely
>     isolated from each other - this is known as a (host) Partitionable
>     Endpoint (PE).  In this case, if any device in the PE is passed
>     through to a guest, the whole PE must be passed through to the
>     same vPHB in the guest.  From the guest POV, each vPHB has exactly
>     one (guest) PE.
>   * To allow for hotplugged devices, libvirt should also add a number
>     of additional, empty vPHBs (the PAPR spec allows for hotplug of
>     PHBs, but this is not yet implemented in qemu).  When hotplugging
>     a new device (or PE) libvirt should locate a vPHB which doesn't
>     currently contain anything.
>   * libvirt should only (automatically) add PHBs - never root ports or
>     other PCI to PCI bridges
>=20
> In order to handle migration, the vPHBs will need to be represented in
> the domain XML, which will also allow the user to override this
> topology if they want.
>=20
> Advantages:
>=20
> There are still some details I need to figure out w.r.t. handling PCIe
> devices (on both the qemu and libvirt sides).  However the fact that

One such detail may be that PCIe devices should have the
"ibm,pci-config-space-type" property set to 1 in the DT,
for the driver to be able to access the extended config
space.

> PAPR guests don't typically see PCIe root ports means that the normal
> libvirt PCIe allocation scheme won't work.  This scheme has several
> advantages with or without support for PCIe devices:
>=20
>  * Better performance for 32-bit devices
>=20
> With multiple devices on a single vPHB they all must share a (fairly
> small) 32-bit DMA/IOMMU window.  With separate PHBs they each have a
> separate window.  PAPR guests have an always-on guest visible IOMMU.
>=20
>  * Better EEH handling for passthrough devices
>=20
> EEH is an IBM hardware-assisted mechanism for isolating and safely
> resetting devices experiencing hardware faults so they don't bring
> down other devices or the system at large.  It's roughly similar to
> PCIe AER in concept, but has a different IBM specific interface, and
> works on both PCI and PCIe devices.
>=20
> Currently the kernel interfaces for handling EEH events on passthrough
> devices will only work if there is a single (host) iommu group in the
> vfio container.  While lifting that restriction would be nice, it's
> quite difficult to do so (it requires keeping state synchronized
> between multiple host groups).  That also means that an EEH error on
> one device could stop another device where that isn't required by the
> actual hardware.
>=20
> The unit of EEH isolation is a PE (Partitionable Endpoint) and
> currently there is only one guest PE per vPHB.  Changing this might
> also be possible, but is again quite complex and may result in
> confusing and/or broken distinctions between groups for EEH isolation
> and IOMMU isolation purposes.
>=20
> Placing separate host groups in separate vPHBs sidesteps these
> problems.
>=20
>  * Guest NUMA node assignment of devices
>=20
> PAPR does not (and can't reasonably) use the pxb device.  Instead to
> allocate devices to different guest NUMA nodes they should be placed
> on different vPHBs.  Placing them on different PHBs by default allows
> NUMA node to be assigned to those PHBs in a straightforward manner.
>=20


--Sig_/uvC8+YzkrhTxlw.Etboll1C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlhvhv0ACgkQAvw66wEB28JwIwCfeP0M+EdNbJnkVwe4n9PZhPTu
UDwAn27cpqdGUteeoxrHRfDOva9RrHVq
=fOUA
-----END PGP SIGNATURE-----

--Sig_/uvC8+YzkrhTxlw.Etboll1C--
