Received: from eggs.gnu.org ([2001:4830:134:3::10]:45889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIuEF-00040R-V3
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIuEC-0007vk-RH
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:59:48 -0400
Received: from 2.mo178.mail-out.ovh.net ([46.105.39.61]:52460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIuEC-0007vG-LB
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:59:44 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id C3A623E69D
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 11:59:42 +0200 (CEST)
Date: Thu, 8 Jun 2017 11:59:37 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170608115937.144197ca@bahia.ttt.fr.ibm.com>
In-Reply-To: <40dea77b-93e1-a6e6-e95a-60fe5ff5e335@kaod.org>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685582923.12025.13700165807436904935.stgit@bahia.lan>
	<c632e0a3-c6bb-2637-40c3-5098937476a5@kaod.org>
	<20170607225507.5d2c6c33@bahia.ttt.fr.ibm.com>
	<20170608015329.GS13397@umbus.fritz.box>
	<20170608111450.05c37c89@bahia.ttt.fr.ibm.com>
	<40dea77b-93e1-a6e6-e95a-60fe5ff5e335@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/oKLvbD=44wI60_r9QsswvOo";
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
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/oKLvbD=44wI60_r9QsswvOo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Jun 2017 11:25:52 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 06/08/2017 11:14 AM, Greg Kurz wrote:
> > On Thu, 8 Jun 2017 11:53:29 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> >> On Wed, Jun 07, 2017 at 10:55:07PM +0200, Greg Kurz wrote: =20
> >>> On Wed, 7 Jun 2017 20:11:38 +0200
> >>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >>>    =20
> >>>> On 06/07/2017 07:17 PM, Greg Kurz wrote:   =20
> >>>>> Until recently, spapr used to allocate ICPState objects for the lif=
etime
> >>>>> of the machine. They would only be associated to vCPUs in xics_cpu_=
setup()
> >>>>> when plugging a CPU core.
> >>>>>
> >>>>> Now that ICPState objects have the same lifecycle as vCPUs, it is
> >>>>> possible to associate them during realization.
> >>>>>
> >>>>> This patch hence open-codes xics_cpu_setup() in icp_realize(). The =
vCPU
> >>>>> is passed as a property. Note that vCPU now needs to be realized fi=
rst
> >>>>> for the IRQs to be allocated. It also needs to resetted before ICPS=
tate
> >>>>> realization in order to synchronize with KVM.
> >>>>>
> >>>>> Since ICPState objects are freed when unrealized, xics_cpu_destroy(=
) isn't
> >>>>> needed anymore and can be safely dropped.     =20
> >>>>
> >>>> I like the idea but I think the assignment of ->cs attribute should =
be=20
> >>>> moved under icp_kvm_cpu_setup(), as it is only used under xics_kvm b=
y=20
> >>>> the kvm_vcpu_ioctl() calls.=20
> >>>>    =20
> >>>
> >>> Well, cs->cpu_index is also used for traces and to implement the 'inf=
o pic'
> >>> monitor command.   =20
> >>
> >> Right.  I think it makes sense for the ICP to have a handle on it's
> >> associated CPU, even if we don't actually use it in all cases right
> >> now.  So I have no problem with the property being in all ICPs; I
> >> think that will be cleaner than special casing xics_kvm.  Especially
> >> if we have to un-special-case it sometime in future because we need
> >> to access the CPU object for some reason we haven't thought of yet.
> >> =20
> >=20
> > We had discussed with Cedric about that actually but when I started
> > to write code, I had the impression that I would have to do convoluted
> > things to get rid of the CPU handle in ICP. =20
>=20
> There is nothing complex and it would surely simplify cpu_setup().=20
>=20
> But, the main argument is that it might be useful to other platforms.  =20
> So there is not much value in removing it. I am OK with that. I am less
> OK with using the index, even if it is useful for the migration state=20
> of ICP objects today.=20
>=20
> We could be tempted to use more of cpu_index, like we have done in=20
> the past, and that was really complex to untangle. Let's be cautious.
>=20

I agree. Maybe this could be hidden in a icpc->get_index() handler ?

> C.

--Sig_/oKLvbD=44wI60_r9QsswvOo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk5IAkACgkQAvw66wEB28JRiQCcCsnQBkkWfsodxfUbONIkeMsj
BmkAnR55j1JaQutarisCCDZcdZbxuXL+
=qLww
-----END PGP SIGNATURE-----

--Sig_/oKLvbD=44wI60_r9QsswvOo--
