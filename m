Received: from eggs.gnu.org ([2001:4830:134:3::10]:48120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDYcF-0001ql-8Y
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDYcA-0008Cg-9A
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:54:27 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:51685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dDYc9-0008Bh-VQ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:54:22 -0400
Received: from player718.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id BB3528D3D5
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 17:54:19 +0200 (CEST)
Date: Wed, 24 May 2017 17:54:10 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170524175410.088f3285@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170524121402.50e62a75@nial.brq.redhat.com>
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-4-lvivier@redhat.com>
	<20170524050754.GW30246@umbus.fritz.box>
	<20170524112857.31c3d8f9@bahia.ttt.fr.ibm.com>
	<20170524121402.50e62a75@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/WoJniVZW_ae_LHjH+y=/jRS";
	protocol="application/pgp-signature"
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

--Sig_/WoJniVZW_ae_LHjH+y=/jRS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 24 May 2017 12:14:02 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Wed, 24 May 2017 11:28:57 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Wed, 24 May 2017 15:07:54 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Tue, May 23, 2017 at 01:18:11PM +0200, Laurent Vivier wrote:   =20
> > > > If the OS is not started, QEMU sends an event to the OS
> > > > that is lost and cannot be recovered. An unplug is not
> > > > able to restore QEMU in a coherent state.
> > > > So, while the OS is not started, disable CPU and memory hotplug.
> > > > We use option vector 6 to know if the OS is started
> > > >=20
> > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>     =20
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
> > > but the OS would definitely not be in a state to accept events. =20
> wouldn't guest on reboot pick up updated fdt and online hotplugged
> before crash cpu along with initial cpus?
>=20

Yes and that's what actually happens with cpus.

But catching up with the background for this series, I have the
impression that the issue isn't the fact we loose an event if the OS
isn't started (which is not true), but more something wrong happening
when hotplugging+unplugging memory as described in this commit:

commit fe6824d12642b005c69123ecf8631f9b13553f8b
Author: Laurent Vivier <lvivier@redhat.com>
Date:   Tue Mar 28 14:09:34 2017 +0200

    spapr: fix memory hot-unplugging

> > We never have any guarantee that the OS will process an event that
> > we've sent actually (think of a kernel crash just after a successful
> > CAS negotiation for example, or any failure with the various guest
> > components involved in the process of hotplug).
> >  =20
> > > Mike, I really think we need some input from someone familiar with how
> > > these hotplug events are supposed to work.  What do we need to do to
> > > handle lost or stale events, such as those delivered when an OS is not
> > > booted.
> > >    =20
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
> > looking for :) =20
> From x86/ACPI world:
>  - if hotplug happens early at boot before guest OS is running
>    hotplug notification (SCI interrupt) stays pending and once guest
>    is up it will/should handle it and online CPU
>  - if guest crashed and is rebooted it will pickup updated apci tables (f=
dt equivalent)
>    with all present cpus (including hotplugged one before crash) and onli=
ne
>    hotplugged cpu along with coldplugged ones
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
>=20
>=20


--Sig_/WoJniVZW_ae_LHjH+y=/jRS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlklrKIACgkQAvw66wEB28KpCwCdEbyJ0N+4l9TTJzozRaFLLaEc
wJYAnAm5fiLWbIWHldyVRu3MFG1C1AbG
=+HmW
-----END PGP SIGNATURE-----

--Sig_/WoJniVZW_ae_LHjH+y=/jRS--
