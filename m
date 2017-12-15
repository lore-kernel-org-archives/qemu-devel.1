Received: from eggs.gnu.org ([2001:4830:134:3::10]:53812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePpOR-0006mG-Ik
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePpOQ-0004pk-GD
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:47:11 -0500
Date: Fri, 15 Dec 2017 23:46:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171215124657.GH7753@umbus.fritz.box>
References: <20171102103559.7382-1-luc.michel@git.antfield.fr>
	<20171102103559.7382-2-luc.michel@git.antfield.fr>
	<20171106061639.GA7813@umbus.fritz.box>
	<2f6bae4a-3489-5cb9-766c-5b8c6c447ac8@antfield.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="smOfPzt+Qjm5bNGJ"
Content-Disposition: inline
In-Reply-To: <2f6bae4a-3489-5cb9-766c-5b8c6c447ac8@antfield.fr>
Subject: Re: [Qemu-devel] [PATCH 1/1] target-ppc: Fix booke206 tlbwe TLB
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@antfield.fr>
Cc: Luc MICHEL <luc.michel@git.antfield.fr>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--smOfPzt+Qjm5bNGJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2017 at 05:28:48PM +0100, Luc Michel wrote:
> On 11/06/2017 07:16 AM, David Gibson wrote:
> > On Thu, Nov 02, 2017 at 11:35:59AM +0100, Luc MICHEL wrote:
> >> When overwritting a valid TLB entry with a new one, the previous page
> >> were not flushed in QEMU TLB, leading to incoherent mapping. This comm=
it
> >> fixes this.
> >=20
> > I don't think this is right.  As a rule, overwriting a TLB entry
> > doesn't necessarily invalidate the previous entry, even on real
> > hardware.  I don't know exactly what the situation is on the various
> > FSL BookE chips, but I know various other models have other caches
> > ahead of the main TLB which can cache mappings that have been removed
> > from it (e.g. the ERAT on server chips and the shadow TLBs on 4xx).
> Indeed, e500 cores have a two-level TLB. tlbwe writes in L2, and L1 is
> handled by the hardware and not visible to the user.
>=20
> >=20
> > To invalidate those other caches requires something other than simply
> > a tlbwe (tlbie for the ERAT and an isync for the shadow TLBs).
> Yes you are right. From "EREF 2.0: A Programmer=E2=80=99s Reference Manua=
l for
> Freescale Power Architecture Processors, Rev. 0":
>=20
> "A context synchronizing instruction is required after a tlbwe
> instruction to ensure any subsequent instructions that will use the
> updated TLB values execute in the new context."
>=20
> Linux executes a msync followed by a isync after a tlbwe for BookE MMU
> machines.
>=20
> >=20
> > The current behaviour won't exactly match what hardware does (and it's
> > probably not practical to do so), but it should be within what's
> > permitted by the architecture - and therefore good enough for correct
> > guests.
> >=20
> > It's possible that we do need this for the BookE chips, but it'll need
> > a more detailed rationale.
> The one sentence from the "PowerPC e500 Core Family Reference Manual,
> Rev. 1" document that makes my fix kind of correct is this one:
>=20
> In 12.4.2 TLB Write Entry (tlbwe) Instruction:
>=20
> "Note that when an L2 TLB entry is written, it may be displacing an
> already valid entry in the same L2 TLB location (a victim). If a valid
> L1 TLB entry corresponds to the L2 MMU victim entry, that L1 TLB entry
> is automatically invalidated."

That does seem fairly clear.  If you resend the patch with that
paragraph cited in a comment, I'll apply it.  A link to the reference
manual would also be appreciated.

> At least, it is as correct as the current tlb_flush in
> "helper_booke206_tlbwe" function, since it does not wait for isync to
> effectively invalidate the page.



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--smOfPzt+Qjm5bNGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlozxD8ACgkQbDjKyiDZ
s5KJ2w//R/R+aGDhCH3elktG3K1X0FIFFPGtHNtKgNMyzQH/1Z3G1/2kAp9jS3Z4
Hc6eyKJ1gY0xGLUPQgHrcIq7iCvWk4G1xGvtI/XkAFE5wF1mrgINL/HS73CevAvh
N5L+2f+ddn/eXxY29v+S0GcLG5SxNog/Lj7v2VbjDdq2TqE+a9XqOqPMEIX+iv1T
fSEN8WHnUhEKpo8FYbzhxr5LPadP4CEpkUDDgfLa1HecYSRFqdxtxNdhb8hSO1Ax
ziGFY9TddcbMqclaWPwPBzfdkiRURG+IiNG7wMbuMqXsnSAc3zKkDunEShrPYI1Z
liuN1QfoFR/P+HMTHeh5evt72lxhvpRhNvmzRJof+epK9NTCpPhrPE2oC+A38QMA
dzpmIptdGNELVmpOi44HU9L6W7PPMFQ4NFU5yOGnSfDIgat0LKvLDa4dFgjjsY9u
yDY8nwP6fOOfDCqW4jXQC4T2qjXUVkjAW6qQE+2KryriObNwexagWUzgXrTerYXF
MotB0pYMhPATEa/TRUgV+824wL49u4I5UQT8KoHWxrmjOQoVAIi/+lUsmG6COoAm
nYLSTVUA7E+B2mffPOY9UXhH/gbRfbkBia+trpvkK5cEam1UxV1mSm8AcO4V7iX+
WYuICWGGzRzBtrDZSz2KaZm9j127UbIbSYqxY0Ut687s8EvzHJU=
=YGLV
-----END PGP SIGNATURE-----

--smOfPzt+Qjm5bNGJ--
