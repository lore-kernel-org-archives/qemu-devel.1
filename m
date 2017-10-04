Received: from eggs.gnu.org ([2001:4830:134:3::10]:36724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzckQ-0002Qw-Va
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 02:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzckN-0003qo-SE
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 02:01:35 -0400
Date: Wed, 4 Oct 2017 16:55:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171004055525.GT3260@umbus.fritz.box>
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
	<150659505839.25889.2018054058894535368.stgit@aravinda>
	<20170929061735.GD7712@umbus.fritz.box>
	<87y3oxen7t.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<95142cc0-518a-b7b7-4e56-cfc2adca36ba@ozlabs.ru>
	<20171003060757.GF3260@umbus.fritz.box>
	<4d649456-1242-febe-06bd-35bb01e3982b@ozlabs.ru>
	<8fa746ca-302f-b2bf-ee05-a4b0b4f2fcbb@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tRcR9GoWqjXrt11v"
Content-Disposition: inline
In-Reply-To: <8fa746ca-302f-b2bf-ee05-a4b0b4f2fcbb@ozlabs.ru>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 1/6] ppc: spapr: Register and
 handle HCALL to receive updated RTAS region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>, benh@au1.ibm.com, mahesh@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, paulus@samba.org, sam.bobroff@au1.ibm.com


--tRcR9GoWqjXrt11v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2017 at 02:32:11PM +1100, Alexey Kardashevskiy wrote:
> On 03/10/17 20:12, Alexey Kardashevskiy wrote:
> > On 03/10/17 17:07, David Gibson wrote:
> >> On Mon, Oct 02, 2017 at 02:02:19PM +1100, Alexey Kardashevskiy wrote:
> >>> On 29/09/17 21:52, Nikunj A Dadhania wrote:
> >>>> David Gibson <david@gibson.dropbear.id.au> writes:
> >>>>
> >>>>> On Thu, Sep 28, 2017 at 04:07:38PM +0530, Aravinda Prasad wrote:
> >>>>>> Receive updates from SLOF about the updated rtas-base.
> >>>>>> A separate patch for SLOF [1] (commit f9a60de3) adds
> >>>>>> functionality to invoke a private HCALL whenever OS
> >>>>>> issues instantiate-rtas with a new rtas-base.
> >>>>>>
> >>>>>> This is required as QEMU needs to know the updated rtas-base
> >>>>>> as it allocates error reporting structure in RTAS space upon
> >>>>>> a machine check exception.
> >>>>>>
> >>>>>> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/12=
0386.html
> >>>>>>
> >>>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >>>>>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >>>>>
> >>>>> Ao I acked this earlier, but I've now realized there might be some
> >>>>> connection between this and discussions taking place elsewhere about
> >>>>> qemu not knowing what SLOF does with the device tree.
> >>>>>
> >>>>> At what point will SLOF call the UPDATE_RTAS hcall?  I'm guessing at
> >>>>> the time of instantiate-rtas, is that right?
> >>>>
> >>>> The call happens from
> >>>> arch/powerpc/kernel/prom_init.c:prom_instantiate_rtas() and after th=
at
> >>>> linux kernel makes two entries in the DT
> >>>>
> >>>> ....
> >>>>        if (call_prom_ret("call-method", 3, 2, &entry,
> >>>>                           ADDR("instantiate-rtas"),
> >>>>                           rtas_inst, base) !=3D 0
> >>>>             || entry =3D=3D 0) {
> >>>>                 prom_printf(" failed\n");
> >>>>                 return;
> >>>>         }
> >>>>         prom_printf(" done\n");
> >>>>
> >>>>         reserve_mem(base, size);
> >>>>
> >>>>         val =3D cpu_to_be32(base);
> >>>>         prom_setprop(rtas_node, "/rtas", "linux,rtas-base",
> >>>>                      &val, sizeof(val));
> >>>>         val =3D cpu_to_be32(entry);
> >>>>         prom_setprop(rtas_node, "/rtas", "linux,rtas-entry",
> >>>>                      &val, sizeof(val));
> >>>> ....
> >>>>
> >>>> Quiesce is called after this.=20
> >>>>
> >>>>> Does SLOF put the RTAS blob address in its internal device tree, or
> >>>>> does it only pass it to the guest via the return parameters from
> >>>>> instantiate-rtas?
> >>>>
> >>>> Entry was made to the DT by linux kernel prom_init code, will this be
> >>>> visible to QEMU?
> >>>
> >>> With my recent SLOF FDT patch - yes:
> >>>
> >>> aik@fstn1-p1:~$ grep rtas dbg.dts
> >>> 	rtas {
> >>> 		linux,rtas-entry =3D <0x2fff0000>;
> >>> 		linux,rtas-base =3D <0x2fff0000>;
> >>> [...]
> >>
> >> Ah.. except.. isn't that relying on the kernel putting the RTAS
> >> address into the device tree before it calls quiesce and kills SLOF?
> >>
> >> The SLOF image is bundled in with qemu, so it's ok for us to rely on
> >> its behaviour up to a point.  It's not really ok for us to rely on the
> >> kernel's behaviour here, unless that behaviour is mandated by PAPR,
> >> which this isn't.
> >=20
> > Fair point.
> >=20
> >> So, I think we either need to have *SLOF* update the device tree with
> >> that address at instantiate-rtas time,
> >=20
> > I can do that, in a separate patch.
>=20
>=20
> One comment though - if I create the properties in SLOF, I have to name
> them different, like rtas-entry/rtas-base or slof,rtas-entry/slof,rtas-ba=
se
> to avoid colliding with the ones create by the guest kernel.

That's fine.  I don't know if the kernel will error if the properties
are already there or just overwrite them, but using new names might be
safer.

> So what do I name them? And do we need 2 copies of the same thing,

Need, no, but if having 2 copies is the simpler approach that's fine.

> do we
> ever expect rtas-entry!=3Drtas-base? The guest can potentially get them
> different (under powervm) but not with SLOF.

More to the point, qemu doesn't actually need to know the entry point
for the fwnmi stuff, only the base address.

>=20
>=20
> >=20
> >> or we'll need to resurrect
> >> Aravinda's original UPDATE_RTAS hcall.
>=20
>=20
>=20




--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tRcR9GoWqjXrt11v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnUd8sACgkQbDjKyiDZ
s5JJEQ/+MoKAnNPh6D45OCXafA22YoIfRJBoyEeaRcnbBE4SBqo82c5U0Dze1V6d
aheeMPxXCWBgp9VKv/A/UckxsaDPkJHhdgng+RrOlqnzKE66WYcFxrLYTLDNpRs0
kuHRB/nFl/L9jkwlyBxVm9AKXbUqMygdw1qdj0P9GrsZstn4Mlr6522VrFeYShoH
tYxpUCAp5I408RrfLhB45+nnh1zyEkCruv5bWS9zd1eWUrWzYgnqCtKFkT0FqjJh
baIrX6/lm+Etma3UoQUa+b6POJ1BSCBE26jaLbeH2YkT4IQaFdAzi6MyqOFcHpG8
p4Wahd5wTH7PHzTNW7rMGVod0p5YDyaraD0G6RVWS9VWXQ+LCXM2ROqiHBQJOQ24
fQZ8c/3keM260HqSMES1An2y6hAkaMwQMjn12POmeRLcxvvahkC/JS2MU1c7BN1/
ds8jAhI/JDwEQBZrsBWaehs5hnvfKC5Iki68a/STUKPaxDsErrGqhmcbberj37VO
ObUTb14bSM3NkD0dq60uXqF7HcNCW3TsC4EtDxb90W+uzJr92ZLdmQXdhzRXVIy/
xAx7xX1tPzX7MeEfmVONucFWmtLsPXfy42QQANSu7i5LdL0DoXUA7NVpNtiVbIny
U58YNU5VPb25HKO+HfVDOoyk6AiLuH1UIYAGJBZx8tMFg05A9RE=
=Mnxn
-----END PGP SIGNATURE-----

--tRcR9GoWqjXrt11v--
