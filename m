Received: from eggs.gnu.org ([2001:4830:134:3::10]:55285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fDJnc-0001XJ-Qe
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 21:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fDJnY-0005jo-Qq
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 21:09:44 -0400
Received: from ozlabs.org ([203.11.71.1]:33841)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fDJnY-0005XI-2L
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 21:09:40 -0400
Date: Tue, 1 May 2018 11:01:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180501010102.GA2520@umbus.fritz.box>
References: <20180430122404.10741-1-peter.maydell@linaro.org>
	<c1c3c88f-75c6-44f2-684c-d9d179bb128c@redhat.com>
	<CAFEAcA-frhSPZePsQJy8DJTpFX0iFw52ND_VK8Z=hGz-v1A_jA@mail.gmail.com>
	<6c90618c-ec1b-7a73-5a76-b98fe5df589a@redhat.com>
	<CAFEAcA9R5Ycq0aT3pCe1mdrmqAM2dVUjJ=MSJuN5+a+crvxzMw@mail.gmail.com>
	<20180430082835.32835889@w520.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20180430082835.32835889@w520.home>
Subject: Re: [Qemu-devel] [PATCH] memory.h: Improve IOMMU related
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 08:28:35AM -0600, Alex Williamson wrote:
> On Mon, 30 Apr 2018 14:35:20 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>=20
> > On 30 April 2018 at 14:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > On 30/04/2018 14:57, Peter Maydell wrote: =20
> > >> On 30 April 2018 at 13:54, Paolo Bonzini <pbonzini@redhat.com> wrote=
: =20
> > >>> On 30/04/2018 14:24, Peter Maydell wrote: =20
> > >>>> -    /* Set this up to provide customized IOMMU replay function */
> > >>>> +    /* Set this up to provide customized IOMMU replay function.
> > >>>> +     * Optional method.
> > >>>> +     */
> > >>>>      void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notif=
ier); =20
> > >>>
> > >>> replay is needed if you want to support IOMMU notifiers.  After
> > >>> memory_region_register_iommu_notifier you're only notified about fu=
ture
> > >>> changes to the mappings; memory_region_iommu_replay calls the replay
> > >>> method so that the IOMMUNotifier is called for each existing mappin=
g. =20
> > >>
> > >> Is it then unrelated to record-and-replay ? That's what I guessed
> > >> it was for... Also, some IOMMUs (eg spapr_iommu.c) seem to support
> > >> notifiers but don't implement it. =20
> > >
> > > Yes, it's completely unrelated.  I have no idea why spapr_iommu.c
> > > doesn't need it, so I am CCing the sPAPR and VFIO experts... =20
> >=20
> > There does seem to be a default implementation in
> > memory_region_iommu_replay(), maybe that is sufficient for spapr?
>=20
> AIUI, the default implementation is used by spapr, it was added here:
>=20
> commit a788f227ef7bd2912fcaacdfe13d13ece2998149
> Author: David Gibson <david@gibson.dropbear.id.au>
> Date:   Wed Sep 30 12:13:55 2015 +1000
>=20
>     memory: Allow replay of IOMMU mapping notifications
>    =20
>     When we have guest visible IOMMUs, we allow notifiers to be registered
>     which will be informed of all changes to IOMMU mappings.  This is use=
d by
>     vfio to keep the host IOMMU mappings in sync with guest IOMMU mapping=
s.
>    =20
>     However, unlike with a memory region listener, an iommu notifier won'=
t be
>     told about any mappings which already exist in the (guest) IOMMU at t=
he
>     time it is registered.  This can cause problems if hotplugging a VFIO
>     device onto a guest bus which had existing guest IOMMU mappings, but =
didn't
>     previously have an VFIO devices (and hence no host IOMMU mappings).
>    =20
>     This adds a memory_region_iommu_replay() function to handle this case=
=2E  It
>     replays any existing mappings in an IOMMU memory region to a specified
>     notifier.  Because the IOMMU memory region doesn't internally remembe=
r the
>     granularity of the guest IOMMU it has a small hack where the caller m=
ust
>     specify a granularity at which to replay mappings.
>    =20
>     If there are finer mappings in the guest IOMMU these will be reported=
 in
>     the iotlb structures passed to the notifier which it must handle (pro=
bably
>     causing it to flag an error).  This isn't new - the VFIO iommu notifi=
er
>     must already handle notifications about guest IOMMU mappings too short
>     for it to represent in the host IOMMU.
>    =20
>     Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>     Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>     Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>     Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>=20
> VT-d emulation then needed its own replay and that hook was later added
> here:

Yes, that's right.  We actually introduced the replay for spapr's
benefit, initially with just the default implementation not a hook.
When x86 needed it, the default implementation although correct, was
grossly inefficient so the hook was added.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrnvEsACgkQbDjKyiDZ
s5LAqg/9FGxL4ugz3bXOxQnSYohR5dVsE5v01waV0A1X66CB7fvtHTq+NzDJWHkt
tNuaX3n4HZBjFfPbn+B1O6OYStxcRdDwu53RFbzEBJQ0LDs+IS/MrB41tsR8mi9E
MHDgwDpjkpad6HbWdWPcnUmT6qKuTc5JqaHqWyLCj+jj1yT+eyrTI2qgFlOfz2xT
G4kLKufKuNuTxzaTIZkk4oxqDs71CwAXQn2sklsLSIS4D0cqeJw19VW/4XMxQbr9
7wk1oO8LPA1wjswLlTl+pCQiSdM+54e5Y7EIkh5/CLItEKajcGjna0OImM0em+tE
b8PPVRlNJI3JxOpuilGDuclQTGTzgveqfBHH2h/CYyQSZ+TG76o7CNiKo+fdZOPX
NelU9w7JSPephswG60Z5iZq7qR8ShO/mKePbp4NL+rRdExH9JHy4LMECErVabmed
M4xH0xKNZ9loJ68VlMhrhORJmkA9O2S3mk2+BlezTMtuHo9ttQ4RcTEG4GJmBQR/
gefYd+JRbKIOlk0CBVjTwCSlqT5MuqqAn3qQZzj3ANqfd/CEANhj/ajkQAZFGan1
n5fepuUcQTbyEyqDXbtgcQMoNeX8MPdVdoUuwR5tzGul9+npFYPygUu2e54ija+L
LIns+9ZLjdJO2gCnr9WCfa7pOdqQEsugKpOMncNKiLDQf5vqSHI=
=m8Jk
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
