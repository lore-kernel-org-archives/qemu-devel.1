Received: from eggs.gnu.org ([2001:4830:134:3::10]:54127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKQTu-0003g0-I2
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKQTt-00041D-5L
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:38:14 -0400
Date: Mon, 12 Jun 2017 22:37:51 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170612143751.GL18542@umbus>
References: <20170608172743.10132-1-lvivier@redhat.com>
	<b297a96d-171c-334d-9232-5172fac386d4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7l042bGvurpep9Wg"
Content-Disposition: inline
In-Reply-To: <b297a96d-171c-334d-9232-5172fac386d4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/2] spapr: disable
 hotplugging without OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org


--7l042bGvurpep9Wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 03:35:58PM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 06/08/2017 02:27 PM, Laurent Vivier wrote:
> > If the OS is not started, QEMU sends an event to the OS
> > that is lost and cannot be recovered. An unplug is not
> > able to restore QEMU in a coherent state.
> > So, while the OS is not started, disable CPU and memory hotplug.
> > We guess the OS is started if the CAS has been negotiated.
> >=20
> > This series also revert previous fix which was not really fixing
> > the hotplug problem when the OS is not running.
> >=20
> > v2:
> > - fix indent
> > - remove useless local_err
> > - allow hotplug if the VM is not started (pre-launch or incoming state)
> > - remove vector 6, instead just mark the end of CAS negotiation
> >=20
> > Laurent Vivier (2):
> >    spapr: disable hotplugging without OS
> >    Revert "spapr: fix memory hot-unplugging"
> >=20
> >   hw/ppc/spapr.c             | 51 +++++++++++++++++++++++++++++++++++++=
++++++---
> >   hw/ppc/spapr_drc.c         | 20 +++---------------
> >   hw/ppc/spapr_hcall.c       |  1 +
> >   include/hw/ppc/spapr.h     |  2 ++
> >   include/hw/ppc/spapr_drc.h |  1 -
> >   5 files changed, 54 insertions(+), 21 deletions(-)
> >=20
> Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
>=20
> This is curious. I was having a little look into hotplug/unplug and DRC
> states yesterday
> while taking a look at the latest David's cleanup. I was trying to find o=
ut
> a way to tune
> spapr_drc_needed() in a way that we don't accidentally migrate more DRCs
> than necessary
> and at the same time handle that scenario of libvirt migration after hotp=
lug
> (libvirt hotplugs
> the device on target instead of adding it in the command line).
>=20
> I would like to migrate the DRCs if and only if:
>=20
> 1 - a device was hotplugged
> 2 - a device is undergoing hotplug/unplug
>=20
> (2) is easy and is already taken care of. But (1) is tricky because, befo=
re
> this patch, if a migration
> occurs *before* CAS we don't need to migrate the DRC - the object will go
> through the state
> changes after the migration. With this series this scenario is not going =
to
> happen, then
> we can happily add a
>=20
> if (dev->hotplugged) return true;
>=20
> in spapr_drc_needed and fix the libvirt migration scenario again.

As mentioned in another thread, I'm looking at explicitly resetting
all DRC states during the CAS process.  I think that will simplify
these cases.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7l042bGvurpep9Wg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZPqc+AAoJEGw4ysog2bOSxbwP/23xnsto92k+Oar+wcChQFd4
Fbc+6amXFdGNlFEkhsetNosVGxwP7TKbYsN2MvaR7cbs4UYnTAgN4HnHyfZZjeiQ
RmJuNfC8QKjQYPAVVQLc7tHmO9oXah34npp7cHrRE3htZAFoCh+DL+1X0SuhRyT8
rSVqDCLdmBPthLm3S8Aldk70/juX+u2ilYkWee72CVjYdl6m8rLbZTPGpkROHeqV
gzboTkPp/yhYEAX0yC1V8imhPSEENlzj5QNZSiP/QQ4R5JHdmxH9eEHWK899EltE
JrfK2ZRSo0VaAmX55yrb/qcj5i/gODMKW46HYkbmU12IE5CZhXnrdx1NXkqL2p4P
+FjMWf/QSScR6+YOjz+UXnsw/zJ+Ujy5iGpejFuILTHU9d4mXiGp+xBeCSMKaJXF
hY/uVbGZprlzYcrM+7eOzDq9fnLCeH9L4qD4E/99wlR89b7YrMmNiF7d2UQospNp
7+1jvvs+oDxhhwMoGKqARo9u1hjH4Wqv+uemwYJhbLiutdRzGUPy/Qpm6RZsaFjX
KwTROf8GqXJjEH4ZpMvJhvYG4m4YmooRt1Mnd6AsjckCgWG08p5OxxmKUULV/UXt
Sm9sTYNm1YFg7GL1O08NVJfvy7sHkG1Aq3xbChTTklyYeAaVEviDWql+o+OyXQbx
XevU5CsW1d4WC/6za1kn
=AwVp
-----END PGP SIGNATURE-----

--7l042bGvurpep9Wg--
