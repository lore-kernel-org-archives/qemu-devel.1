Received: from eggs.gnu.org ([2001:4830:134:3::10]:33333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dItWt-0003io-Kk
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dItWq-0007Bp-Hr
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:14:59 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:52779)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dItWq-0007BU-BO
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:14:56 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 173DF3E8F1
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 11:14:55 +0200 (CEST)
Date: Thu, 8 Jun 2017 11:14:50 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170608111450.05c37c89@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170608015329.GS13397@umbus.fritz.box>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685582923.12025.13700165807436904935.stgit@bahia.lan>
	<c632e0a3-c6bb-2637-40c3-5098937476a5@kaod.org>
	<20170607225507.5d2c6c33@bahia.ttt.fr.ibm.com>
	<20170608015329.GS13397@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/gQAcXARVzwrPa8Sdgo/cs7x";
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
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/gQAcXARVzwrPa8Sdgo/cs7x
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Jun 2017 11:53:29 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jun 07, 2017 at 10:55:07PM +0200, Greg Kurz wrote:
> > On Wed, 7 Jun 2017 20:11:38 +0200
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >  =20
> > > On 06/07/2017 07:17 PM, Greg Kurz wrote: =20
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
> > > > realization in order to synchronize with KVM.
> > > >=20
> > > > Since ICPState objects are freed when unrealized, xics_cpu_destroy(=
) isn't
> > > > needed anymore and can be safely dropped.   =20
> > >=20
> > > I like the idea but I think the assignment of ->cs attribute should b=
e=20
> > > moved under icp_kvm_cpu_setup(), as it is only used under xics_kvm by=
=20
> > > the kvm_vcpu_ioctl() calls.=20
> > >  =20
> >=20
> > Well, cs->cpu_index is also used for traces and to implement the 'info =
pic'
> > monitor command. =20
>=20
> Right.  I think it makes sense for the ICP to have a handle on it's
> associated CPU, even if we don't actually use it in all cases right
> now.  So I have no problem with the property being in all ICPs; I
> think that will be cleaner than special casing xics_kvm.  Especially
> if we have to un-special-case it sometime in future because we need
> to access the CPU object for some reason we haven't thought of yet.
>=20

We had discussed with Cedric about that actually but when I started
to write code, I had the impression that I would have to do convoluted
things to get rid of the CPU handle in ICP.

Thanks for confirming this.

--Sig_/gQAcXARVzwrPa8Sdgo/cs7x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk5FYoACgkQAvw66wEB28J6MgCeJVANr0uYKGPT5QMO9+w+mWdq
f9UAniwMBldoGrCdQILeCDJxBSt+qtIv
=vl9Z
-----END PGP SIGNATURE-----

--Sig_/gQAcXARVzwrPa8Sdgo/cs7x--
