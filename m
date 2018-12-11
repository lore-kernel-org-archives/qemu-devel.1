Received: from eggs.gnu.org ([2001:4830:134:3::10]:42422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWWuY-0008Tm-Qk
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWWuQ-00054q-Ri
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:32:32 -0500
Received: from ozlabs.org ([203.11.71.1]:35123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gWWuP-00053h-PZ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:32:26 -0500
Date: Tue, 11 Dec 2018 12:20:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181211012045.GB4261@umbus.fritz.box>
References: <20181121181347.24035-1-farosas@linux.ibm.com>
	<20181121181347.24035-4-farosas@linux.ibm.com>
	<20181126074100.GJ2251@umbus.fritz.box>
	<87h8fymgyq.fsf@linux.ibm.com>
	<20181202091317.GM30479@umbus.fritz.box>
	<87d0q9mtml.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DkeqYIVsoi/Xkk+N"
Content-Disposition: inline
In-Reply-To: <87d0q9mtml.fsf@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/3] target/ppc: support single
 stepping with KVM HV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, James Hogan <jhogan@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>


--DkeqYIVsoi/Xkk+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 10:52:18AM -0200, Fabiano Rosas wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> >> >> +    if (arch_info->address =3D=3D trace_handler_addr) {
> >> >> +        cpu_synchronize_state(cs);
> >> >> +        kvm_remove_breakpoint(cs, trace_handler_addr, 4, GDB_BREAK=
POINT_SW);
> >> >> +
> >> >> +        cpu_memory_rw_debug(cs, env->spr[SPR_SRR0] - 4, (uint8_t *=
)&insn,
> >> >> +                            sizeof(insn), 0);
> >> >> +
> >> >> +        /* If the last instruction was a mfmsr, make sure that the
> >> >> +         * MSR_SE bit is not set to avoid the guest kernel knowing
> >> >> +         * that it is being single-stepped */
> >> >> +        if (extract32(insn, 26, 6) =3D=3D 31 && extract32(insn, 1,=
 10) =3D=3D 83) {
> >> >> +            reg =3D extract32(insn, 21, 5);
> >> >> +            env->gpr[reg] &=3D ~(1ULL << MSR_SE);
> >> >> +        }
> >> >
> >> > Hm.  What happens if both qemu and the guest itself attempt to single
> >> > step at the same time?  How do you distinguish between the cases?
> >>=20
> >> There is currently no distinction being made.
> >
> > This seems incorrect to me.  Basically you're restoring !MSR_SE
> > unconditionaly when you finish the hypervisor side step, which might
> > not be correct if the guest is also attempting to single step itself.
> > AFAICT it should be possible to track what the guest thinks is the
> > value of MSR_SE and restore that.
>=20
> I was skeptical of being able to do both single steps at the same time
> but I found a way to reproduce it by stepping over an rfid when
> SRR1_SE is already 1.
>=20
> >  If both hypervisor and guest
> > attempt to single step, I'd expect to have the hypervisor trap first,
> > then return to the guest's single step vector.
>=20
> With the fix you suggest above, QEMU will be able to single step the
> interrupt handler during the guest's single step. That means I'll have
> to restore the SRRs as well so that the handler returns to the correct
> place.
>=20
> >> I could do the latter, if you prefer.
> >
> > I think that's better - I don't think it's safe to assume that you're
> > *not* synchronized with KVM.
>=20
> Ok, that's better indeed.
>=20
> Thanks for the comments, I'll prepare another version with the
> appropriate corrections.

Ok, great.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DkeqYIVsoi/Xkk+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwPEO0ACgkQbDjKyiDZ
s5KOXw//SVGgssKFVnUMFf0SfpuvlRhkIb9MNCGMkdU1+FPs07SoXp7Bd6mJNbLO
lnlNX45DORzSXo3qpoukKa53Mox3p0zpe66VNn3IiTnmdn5tQ6TMxIlXqYEEELXT
L3KwrmZZmQTl6b8C4znDVj3lv1oU67pQlg8G8uTcxXPUl+RdP9neJfAtCUAgxtD8
U7VwKUl0DX58c4kdbFrmiMB67aGb6E4Q5iKpBKJq5Hw3f2bGqSL+GGJJJXJjB6Ou
LxNbkDt0mjy2wdTSK/OjASdyz/ni50Cw0SsKGAPzbPpZoCoePExrxsSchAvlqoVs
s4VuXQ5ecsbuIiBKTOmQTW+nrpdDb948Hlh36jTwf4SK5UeO70ZIh9ZiBAGtgjW1
F7PsmPxcs1Qe093sdCyyJzleLYsjeW9P5DTRfg/cjW0qN23UWPWw4iPpne7vL8dg
+Jf5mxSyYCRRc4Jxbmkh4/+1iaeDHdta8VlsIOXXJ+gOL8BEpzTW9fh6pSpf2ski
arq5JEpLy6mQyAmbDFykWA1FRSOLS1qC7PGIxaVZrMMbP0Lrv1NccMNz8jDup/k/
BeY/GJa4yRkjy2kGHZvnpzcCFxOurgZO7eeMuOgdelMI+aB7wg/PTaRA8Qa9mGGt
LMB1iKFs5KV3OX2BQASP+gzjNuH7gkzuxfzQjmUhd7Qd3JcTy+o=
=ljHp
-----END PGP SIGNATURE-----

--DkeqYIVsoi/Xkk+N--
