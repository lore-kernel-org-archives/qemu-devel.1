Received: from eggs.gnu.org ([2001:4830:134:3::10]:34159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dJDgO-00050o-5J
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dJDgL-0002hy-1d
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:46:08 -0400
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:53056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dJDgK-0002fs-Qz
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 02:46:04 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 453C53E9AA
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 08:45:55 +0200 (CEST)
Date: Fri, 9 Jun 2017 08:45:50 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170609084550.53aece8d@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170609022452.GE26521@umbus.fritz.box>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685582923.12025.13700165807436904935.stgit@bahia.lan>
	<20170608020112.GT13397@umbus.fritz.box>
	<20170608104530.65b7d53e@bahia.ttt.fr.ibm.com>
	<20170609022452.GE26521@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/GvRssp/9JWSitk/c4G7.N=l";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 3/5] xics: setup cpu at realize time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>

--Sig_/GvRssp/9JWSitk/c4G7.N=l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Jun 2017 12:24:52 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jun 08, 2017 at 10:45:30AM +0200, Greg Kurz wrote:
> > On Thu, 8 Jun 2017 12:01:12 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Wed, Jun 07, 2017 at 07:17:09PM +0200, Greg Kurz wrote: =20
> > > > Until recently, spapr used to allocate ICPState objects for the lif=
etime
> > > > of the machine. They would only be associated to vCPUs in xics_cpu_=
setup()
> > > > when plugging a CPU core.
> > > >=20
> > > > Now that ICPState objects have the same lifecycle as vCPUs, it is
> > > > possible to associate them during realization.
> > > >=20
> > > > This patch hence open-codes xics_cpu_setup() in icp_realize(). The =
vCPU
> > > > is passed as a property. Note that vCPU now needs to be realized fi=
rst
> > > > for the IRQs to be allocated. It also needs to resetted before ICPS=
tate
> > > > realization in order to synchronize with KVM.   =20
> > >=20
> > > Ok, what enforces those ordering constraints?
> > >  =20
> >=20
> > I'm not sure about what you're asking... I had to re-order because
> > xics_cpu_setup() used to be called after the vCPU is realized and
> > put in PAPR mode. =20
>=20
> Duh, sorry, I wasn't thinking to ask about realize order, since that's
> manual and you've re-ordered it to be correct.
>=20
> You also mention that reset order matters, and I'm less clear on what
> guarantees that the reset handlers for the components get called in
> the right order.
>=20

Oops... my bad, this is a mistake in the changelog. The KVM error I was
seing isn't related to CPU reset as I was thinking first but to
cpu_ppc_set_papr()... :-\

The last sentence should rather be something like:

"We also need to call spapr_cpu_init() before ICPState realization in
 order to enable PAPR mode in KVM."

Can you fix this in your tree or should I send an updated version ?

Cheers,

--
Greg

--Sig_/GvRssp/9JWSitk/c4G7.N=l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk6RB4ACgkQAvw66wEB28IN0wCgi0jOC6kNAu618acUD8Xm52/7
lSMAoJuqIjcza3wiodvKf47i/zfzNITL
=2fMR
-----END PGP SIGNATURE-----

--Sig_/GvRssp/9JWSitk/c4G7.N=l--
