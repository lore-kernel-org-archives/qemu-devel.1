Received: from eggs.gnu.org ([2001:4830:134:3::10]:47656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQMhg-0004Uu-K8
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 20:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQMhd-00083Y-Hv
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 20:53:32 -0400
Received: from ozlabs.org ([203.11.71.1]:38417)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fQMhc-00081F-Pc
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 20:53:29 -0400
Date: Wed, 6 Jun 2018 10:11:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180606001118.GB17757@umbus.fritz.box>
References: <20180605131944.14649-1-peterx@redhat.com>
	<20180605131944.14649-2-peterx@redhat.com>
	<CAFEAcA9-O7B5h0ozAqLEUXR=YRS+s-X7A_m=xce-aLgR59EG1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9-O7B5h0ozAqLEUXR=YRS+s-X7A_m=xce-aLgR59EG1w@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC 1/3] memory: add MemTxAttrs to translate
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, Richard Henderson <rth@twiddle.net>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Alex Williamson <alex.williamson@redhat.com>


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 02:38:31PM +0100, Peter Maydell wrote:
> On 5 June 2018 at 14:19, Peter Xu <peterx@redhat.com> wrote:
> > Add a new MemTxAttrs parameter to the IOMMUMemoryRegionClass.translate()
> > function, which takes some extra context of the translation request.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/exec/memory.h    | 5 ++++-
> >  exec.c                   | 2 +-
> >  hw/alpha/typhoon.c       | 3 ++-
> >  hw/arm/smmuv3.c          | 2 +-
> >  hw/dma/rc4030.c          | 6 ++++--
> >  hw/i386/amd_iommu.c      | 2 +-
> >  hw/i386/intel_iommu.c    | 6 ++++--
> >  hw/ppc/spapr_iommu.c     | 3 ++-
> >  hw/s390x/s390-pci-bus.c  | 6 ++++--
> >  hw/sparc/sun4m_iommu.c   | 3 ++-
> >  hw/sparc64/sun4u_iommu.c | 3 ++-
> >  memory.c                 | 3 ++-
> >  12 files changed, 29 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index eb2ba06519..6b0ced554d 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -234,9 +234,12 @@ typedef struct IOMMUMemoryRegionClass {
> >       * @iommu: the IOMMUMemoryRegion
> >       * @hwaddr: address to be translated within the memory region
> >       * @flag: requested access permissions
> > +     * @attrs: MemTxAttrs that was bound to the translation
> > +     *         operation. If flag=3D=3DIOMMU_NONE, this field is
> > +     *         meaningless
> >       */
>=20
> This won't work, because the "allow TCG transactions to pass
> through an IOMMU" code needs to pass IOMMU_NONE. IOMMU_NONE
> means "give me all the permissions info, and don't shortcut it".
> For TCG we get the info, and then cache it and use it for
> subsequent transactions, both read and write, regardless of
> whether the first one was a read or a write.

Likewise the "replay" operations needed for hotplug use IOMMU_NONE.

It also seems like it's kind of abusing the meaning of "AddressSpace",
if other factors are influencing how the translation is done.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsXJqQACgkQbDjKyiDZ
s5IfmA//U2DANRRtYfKfcM+Zb0nq0JD7Lw8UealrUjEp0qWj3hKzDsV4JJK8VASj
HEsRi6MuE6kHkKhy9do9hFuXMRq//HMrcgVKd4DHt4i6oLt8gqVmj23YFtFh6I11
VlSKtYNL9CKKsgxBZ6nucDBqsq2M11x5OzNb11r8DS4ZGiGNsZL0xcO73fqWPupz
YZsFXZQjyqJDHuirI0g5HLQlBDDG530EoFIaOlTnnlED3HK1gmoQmmDZYgcW1H1H
aS3ZuSID2H5rqmvs+1Ech0vMmP3H/Dt0pAF3U7u6ZpiTUnZUInujxQjrTVE95LoA
AFmU4i2pDcUTT5QfqZtUjyl62mbrLgg+fMR86q5blSQCrEfID/nSUnXTEO+bLZ2m
PBaNGlqSbzYShPR3KbXD+mVmv353k81D/i52C4nm/H25uPTpVP7FWh1Aim2nyyje
cMIxPiNlHGo+ct/dN91TX0DzrALPzCfmREVTPhZwbjyZfoICUQhRmyAV6n4H5GA4
f0xAgXwOMxZpZILZykqPO/bbHr8jfbw0HLllgC8rcKc1HDbNn155K5fBFf+OipSe
9cpGxVdl756h/CuVhqDxSUNTFg3u+U8NNupRDvFWCDlxxY+mI+a6q7KxgaM3hkS4
lA64aV2f9Dq+Nt7hMBWI2XkFbYoDAwO8ftYzHB5Dfe+NrqjKf2s=
=uxEp
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
