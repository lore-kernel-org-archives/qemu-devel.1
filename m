Received: from eggs.gnu.org ([2001:4830:134:3::10]:53379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfHh6-0001KL-8m
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 23:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfHh2-00052X-8C
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 23:30:04 -0400
Date: Wed, 9 Aug 2017 13:21:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170809032126.GA13670@umbus.fritz.box>
References: <cover.1502087564.git.sam.bobroff@au1.ibm.com>
	<2b5e13652c749b9ad2a519190396fe4160ac0dea.1502087564.git.sam.bobroff@au1.ibm.com>
	<20170808062420.82867C6037@b03ledav006.gho.boulder.ibm.com>
	<20170809000244.3eptjvatsxsdbx2d@tungsten.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20170809000244.3eptjvatsxsdbx2d@tungsten.ozlabs.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] ppc: spapr: Make VCPU ID handling
 private to SPAPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 10:02:44AM +1000, Sam Bobroff wrote:
> On Tue, Aug 08, 2017 at 04:24:01PM +1000, David Gibson wrote:
> > On Mon, Aug 07, 2017 at 04:33:29PM +1000, Sam Bobroff wrote:
> > > The concept of a VCPU ID that differs from the CPU's index
> > > (cpu->cpu_index) exists only within SPAPR machines so, move the
> > > functions ppc_get_vcpu_id() and ppc_get_cpu_by_vcpu_id() into spapr.c
> > > and rename them appropriately.
> > >=20
> > > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> > > ---
> > > Changes in v2:
> > >=20
> > > * Re-arranged so that spapr_vcpu_id() calls kvm_arch_vcpu_id() rather=
 than the
> > > other way around.
> >=20
> > Ah.. so close..
> >=20
> > [snip]
> > > +int spapr_vcpu_id(PowerPCCPU *cpu)
> > > +{
> > > +    CPUState *cs =3D CPU(cpu);
> > > +
> > > +    if (kvm_enabled()) {
> > > +        return kvm_arch_vcpu_id(cs);
> > > +    } else {
> > > +        return cs->cpu_index;
> > > +    }
> > > +}
> > > +
> > > +PowerPCCPU *spapr_find_cpu(int vcpu_id)
> > > +{
> > > +    CPUState *cs;
> > > +
> > > +    CPU_FOREACH(cs) {
> > > +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > > +
> > > +        if (cpu->vcpu_id =3D=3D vcpu_id) {
> >=20
> > This is still reaching into vcpu_id which should really be cpu
> > private, not in spapr.  You can use spapr_vcpu_id() which you already
> > defined to avoid this.
>=20
> OK I'll post another version.
>=20
> > With that done, I believe it should be possible to put cpu->vcpu_id in
> > an ifdef CONFIG_KVM and have things work.
>=20
> That is indeed possible! ifdefs are needed around the initialization
> block in ppc_cpu_realizefn(), although here in spapr_vcpu_id() it doesn't=
 seem
> necessary. (Presumably because kvm_enabled() becomes a constant 0 without
> CONFIG_KVM so the compiler can treat it like an ifdef.)
>=20
> We don't want to actually patch it to use CONFIG_KVM though, do we?

Possibly not, not.

> I
> was intending (as part of the VSMT work) to make the vcpu_id a SPAPR
> concept, rather than a KVM one, so that machines could (in theory
> anyway) be migrated between KVM and non-KVM systems.

Uh.. the goal is good, I'm not sure that's the right way of going
about it, but I may just be misunderstanding your brief description.
I'll look at the actual patches once they're ready.

>=20
> > > +            return cpu;
> > > +        }
> > > +    }
> > > +
> > > +    return NULL;
> > > +}
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmKf7QACgkQbDjKyiDZ
s5L1pxAAhaNrtG69r+iAFvX1HEZtBwephj/RCWo+aCZx9IavAjlkChx+AIXVPGxB
p+FfbBrf+jOKWgWpPlWhnszc+JkmVXCboonuNKSAcSYAAxgDFwQaUbU5EExeS7vx
frbnYpquUb8CdBJygz8X6heuygoJMh6zCXIcvxEf+MGLqZCb627wqSO+nIsVPCfZ
JtF+klvI77HLRBjIpCc1Bc5jNW8D6Dym3GWCI8fSU3K4TBJs6dLBdaXWQREZlhip
WxeYl14pdH0P8IKJ44KZ8H86r49BF49uNynMS41gPm+zM2WKiWj8mEtCxLx2rpSR
R7j0uFrOgcueNAGLGWL/RGw1h4Snwg5MsfASS7D8F0i60irOQVdj2C1uu5HkkkVK
qveBuZBr4XHwOfGZ5h6TeLDaryCKYDRn8nIoe/r6nVT9G+r6dkiuLaN1FXER3Zd7
Eh7+ByfCTEDFL6F2gc+J8VMJVEpcCrlzELIV7f/TOSOVlIMU2BZoEmFjXW4sZ0eE
Ny6znpYnqBDB89kS9HH9elQ7VuStPhd1wjPE31In17fGdOWVSe/bE3o28T7bWXB0
0c4MDc6GsYhhINiIbrIOhoV7QAEKj/7ypZ9AtbCqnU+2X3URNL+KxSwLWQICklmL
7HzQbgoluoCRfwsAkhDRU6xdPr8dWJmDQlN0ZMbbO7dJ4Gx+SzI=
=dZ4c
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
