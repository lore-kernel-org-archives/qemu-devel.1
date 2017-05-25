Received: from eggs.gnu.org ([2001:4830:134:3::10]:51875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjGR-0002zg-9j
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjGP-0002T0-Se
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:16:39 -0400
Date: Thu, 25 May 2017 12:49:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170525024935.GE12929@umbus.fritz.box>
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-4-lvivier@redhat.com>
	<20170524050754.GW30246@umbus.fritz.box>
	<20170524112857.31c3d8f9@bahia.ttt.fr.ibm.com>
	<20170524121402.50e62a75@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline
In-Reply-To: <20170524121402.50e62a75@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/4] spapr: disable hotplugging
 without OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 12:14:02PM +0200, Igor Mammedov wrote:
> On Wed, 24 May 2017 11:28:57 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Wed, 24 May 2017 15:07:54 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Tue, May 23, 2017 at 01:18:11PM +0200, Laurent Vivier wrote: =20
> > > > If the OS is not started, QEMU sends an event to the OS
> > > > that is lost and cannot be recovered. An unplug is not
> > > > able to restore QEMU in a coherent state.
> > > > So, while the OS is not started, disable CPU and memory hotplug.
> > > > We use option vector 6 to know if the OS is started
> > > >=20
> > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>   =20
> > >=20
> > > Urgh.. I'm not terribly confident that this is really correct.  As
> > > discussed on the previous patch, you're essentially using OV6 as a
> > > flag that CAS is complete.
> > >=20
> > > But while it undoubtedly makes the race window much smaller, I don't
> > > see that there's any guarantee the guest OS will really be able to
> > > handle hotplug events immediately after CAS.
> > >=20
> > > In particular if the CAS process completes partially but then needs to
> > > trigger a reboot, I think that would end up setting the ov6 variable,
> > > but the OS would definitely not be in a state to accept events.
> wouldn't guest on reboot pick up updated fdt and online hotplugged
> before crash cpu along with initial cpus?

Ah.. yes, I guess so.  Are we already resetting DRC and pending event
state at reset?

>=20
> > We never have any guarantee that the OS will process an event that
> > we've sent actually (think of a kernel crash just after a successful
> > CAS negotiation for example, or any failure with the various guest
> > components involved in the process of hotplug).
> >=20
> > > Mike, I really think we need some input from someone familiar with how
> > > these hotplug events are supposed to work.  What do we need to do to
> > > handle lost or stale events, such as those delivered when an OS is not
> > > booted.
> > >  =20
> >=20
> > AFAIK, in the PowerVM world, the HMC exposes a user configurable timeou=
t.
> >=20
> > https://www.ibm.com/support/knowledgecenter/POWER8/p8hat/p8hat_dlparpro=
cpoweraddp6.htm
> >=20
> > I'm not sure we can do anything better than being able to "cancel" a pr=
evious
> > hotplug attempt if it takes too long, but I'm not necessarily the exper=
t you're
> > looking for :)
> From x86/ACPI world:
>  - if hotplug happens early at boot before guest OS is running
>    hotplug notification (SCI interrupt) stays pending and once guest
>    is up it will/should handle it and online CPU

Yeah.. I'm not sure how this will play out on pseries, I suspect the
problem is here.

>  - if guest crashed and is rebooted it will pickup updated apci tables (f=
dt equivalent)
>    with all present cpus (including hotplugged one before crash) and onli=
ne
>    hotplugged cpu along with coldplugged ones

I think that should work ok for us, as long as we're properly
resetting in-flight hotplug state at a reset.

>  - if guest looses SCI somehow, it's considered guest issue and such cpu
>    stays unpluggable until guest picks it somehow (reboot, manually runni=
ng cpus scan
>    method from ACPI or another cpu hotplug event) and explicitly ejects i=
t.
>=20
> Taking in account that CPUs don't support surprise removal and requires
> guest cooperation it's fine to leave CPU plugged in until guest ejects it.
> That's what I'd expect to happen on baremetal,=20
> you hotplug CPU, hardware notifies OS about it and that's all,
> cpu won't suddenly pop out if OS isn't able to online it.
>=20
> More over that hotplugged cpu might be executing some code or one of
> already present cpus might be executing initialization routines to online
> it (think of host overcommit and arbitrary delays) so it is not really sa=
fe
> to remove hotplugged but not onlined cpu without OS consent
> (i.e. explicit eject by OS/firmware). I think the lost event handling sho=
uld be
> fixed on guest side and not in QEMU.

I agree in principle, but it's not yet clear what needs to be done.
I'm guessing the problem is amounting to lost events, but I'm not
certain.  The question is does the mechanism we're using to present
the events have a means to safely not lose them.  Are they being
presented and lost during SLOF; is there some way we can prevent that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJkY/AAoJEGw4ysog2bOSm4IQAORhWu1b8PcSctcpGTpC4PR0
HUwKsuNcYCDBiLjmwexV6j607m0nyB5fZnVgphcaSc7xuGUzwuS3aT16FH5QwgQf
TWccAQR436DnxurssTtvMO6LWkmUX4mqFZmzLMV+IG2n0QLUqvxmArlsDdgawRHo
cwmf2b67xXbldwOsGtj8W3e88UFFs2nJXPhBliYB991x/GdAxeKEDfWtSVBYnKhC
kUVuIFQlU6GwVUiaviCRZqQjc5iyXAb8xl374kYzbpzxTaq7wx3/NLWX3Fj6O9Yu
tRu3znZXCclUXqZjLw7gXhGoRBCg/BaiBdyFhPVfo4d8eRQgYCcO8jI1Fti+1w+g
6BO2JQHQrxCIZVB3RaB+XVrF9NvEWZ6mzSC9yJ8g9aH6oifpO4K1HRwuDM2dtcxZ
jQxE3jOqoIVKRCVVJfVzInWj24p8opWu1cwEjSutzrj8+m/JhKbJCRiDWSTUeYGZ
kvOu3MtQZ1P1P/vz0mI2ptHz4E34cEa30TQXTgfJooNYEFnv4uJ30EqMKsiULi1+
rbsFxiXVvAXcYoYnjLP9QRk0DvvdFIUpESh9FEDdOi1OtvUJsBtaGhCitMlNjhLI
Su+q3dwl8b7y9X6zK8qwj7WRMkbOBkjr1Qpof0SuWkYHSEuUndbycjQHyw9l8xsh
uwgzbWfRue7C823Hio7u
=9Bi/
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
