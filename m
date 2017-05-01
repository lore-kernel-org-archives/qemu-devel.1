Received: from eggs.gnu.org ([2001:4830:134:3::10]:33062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d52Rs-0006tQ-Of
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 23:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d52Rp-0000UG-Kg
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 23:56:32 -0400
Received: from ozlabs.org ([103.22.144.67]:40335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d52Ro-0000QH-VY
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 23:56:29 -0400
Date: Mon, 1 May 2017 13:56:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170501035618.GB13773@umbus.fritz.box>
References: <20170427101259.13798-1-lvivier@redhat.com>
	<20170427101259.13798-3-lvivier@redhat.com>
	<20170427203148.GN3482@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <20170427203148.GN3482@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] numa,
 spapr: equally distribute memory on nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 05:31:48PM -0300, Eduardo Habkost wrote:
> On Thu, Apr 27, 2017 at 12:12:59PM +0200, Laurent Vivier wrote:
> > When there are more nodes than memory available to put the minimum
> > allowed memory by node, all the memory is put on the last node.
> >=20
> > This is because we put (ram_size / nb_numa_nodes) &
> > ~((1 << mc->numa_mem_align_shift) - 1); on each node, and in this
> > case the value is 0. This is particularly true with pseries,
> > as the memory must be aligned to 256MB.
> >=20
> > To avoid this problem, this patch uses an error diffusion algorithm [1]
> > to distribute equally the memory on nodes.
> >=20
> > Example:
> >=20
> > qemu-system-ppc64 -S -nographic  -nodefaults -monitor stdio -m 1G -smp =
8 \
> >                   -numa node -numa node -numa node \
> >                   -numa node -numa node -numa node
> >=20
> > Before:
> >=20
> > (qemu) info numa
> > 6 nodes
> > node 0 cpus: 0 6
> > node 0 size: 0 MB
> > node 1 cpus: 1 7
> > node 1 size: 0 MB
> > node 2 cpus: 2
> > node 2 size: 0 MB
> > node 3 cpus: 3
> > node 3 size: 0 MB
> > node 4 cpus: 4
> > node 4 size: 0 MB
> > node 5 cpus: 5
> > node 5 size: 1024 MB
> >=20
> > After:
> > (qemu) info numa
> > 6 nodes
> > node 0 cpus: 0 6
> > node 0 size: 0 MB
> > node 1 cpus: 1 7
> > node 1 size: 256 MB
> > node 2 cpus: 2
> > node 2 size: 0 MB
> > node 3 cpus: 3
> > node 3 size: 256 MB
> > node 4 cpus: 4
> > node 4 size: 256 MB
> > node 5 cpus: 5
> > node 5 size: 256 MB
> >=20
> > [1] https://en.wikipedia.org/wiki/Error_diffusion
> >=20
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > ---
> >  hw/ppc/spapr.c         | 21 ++++++++++++++++++++-
> >  include/hw/ppc/spapr.h |  3 ++-
> >  2 files changed, 22 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 80d12d0..be498e2 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3106,6 +3106,23 @@ static void spapr_pic_print_info(InterruptStatsP=
rovider *obj,
> >      ics_pic_print_info(spapr->ics, mon);
> >  }
> > =20
> > +static void spapr_numa_auto_assign_ram(uint64_t *nodes, int nb_nodes,
> > +                                       ram_addr_t size)
> > +{
> > +    int i;
> > +    uint64_t usedmem =3D 0, node_mem;
> > +    uint64_t granularity =3D size / nb_nodes;
> > +    uint64_t propagate =3D 0;
> > +
> > +    for (i =3D 0; i < nb_nodes - 1; i++) {
> > +        node_mem =3D (granularity + propagate) & ~(SPAPR_MEMORY_BLOCK_=
SIZE - 1);
> > +        propagate =3D granularity + propagate - node_mem;
> > +        nodes[i] =3D node_mem;
> > +        usedmem +=3D node_mem;
> > +    }
> > +    nodes[i] =3D ram_size - usedmem;
> > +}
>=20
> This new algorithm is a much better default, I would like to
> enable it for all machines by default. We could move it to
> core/machine.c:machine_class_init(), and set numa_auto_assign_ram
> to NULL on pc-*-2.9 and spapr-2.9.

Right.  So, the convention that the default is the new behaviour and
we override to set the older behaviour on previous machine types is
strong enough that I think we should keep it here, even though it adds
some complications.

Note that it might be simpler not to have a "NULL" behaviour.  Instead
the core code can provide both old style and error diffusion versions
of the assign hook.  Set it to the error difusion one in the base
MachineClass, then override it to the old one in previous versioned
machine types (basically just the previous pc and spapr models,
AFAIK).

>=20
> > +
> >  static void spapr_machine_class_init(ObjectClass *oc, void *data)
> >  {
> >      MachineClass *mc =3D MACHINE_CLASS(oc);
> > @@ -3162,7 +3179,8 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >       * SPAPR_MEMORY_BLOCK_SIZE (256M) since that's the granularity
> >       * in which LMBs are represented and hot-added
> >       */
> > -    mc->numa_mem_align_shift =3D 28;
> > +    mc->numa_mem_align_shift =3D SPAPR_MEMORY_BLOCK_SIZE_SHIFT;
> > +    mc->numa_auto_assign_ram =3D spapr_numa_auto_assign_ram;
> >  }
> > =20
> >  static const TypeInfo spapr_machine_info =3D {
> > @@ -3242,6 +3260,7 @@ static void spapr_machine_2_9_class_options(Machi=
neClass *mc)
> >  {
> >      spapr_machine_2_10_class_options(mc);
> >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
> > +    mc->numa_auto_assign_ram =3D NULL;
> >  }
> > =20
> >  DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 5802f88..8f4a588 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -653,7 +653,8 @@ int spapr_rtc_import_offset(sPAPRRTCState *rtc, int=
64_t legacy_offset);
> > =20
> >  int spapr_rng_populate_dt(void *fdt);
> > =20
> > -#define SPAPR_MEMORY_BLOCK_SIZE (1 << 28) /* 256MB */
> > +#define SPAPR_MEMORY_BLOCK_SIZE_SHIFT 28 /* 256MB */
> > +#define SPAPR_MEMORY_BLOCK_SIZE (1 << SPAPR_MEMORY_BLOCK_SIZE_SHIFT)
> > =20
> >  /*
> >   * This defines the maximum number of DIMM slots we can have for sPAPR
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZBrHgAAoJEGw4ysog2bOSgNAP+wakh7JCFH7MNiCAaBlR+ODZ
kv0D2vl/trga2E6mFjjlIzFp1QaVtfx5SBKrmIVU4ByOJq11KLtGinlPFBjnz087
1FgD8sa2npdqzSl8PTiRG5pRg4gQeHucIY/DhW20lgP+KdiO1mfVu43AI1DcX5zq
tAX6SHpQFO69h6yR7c1+cJfD/3JsNJ7tkD3LntRRNwXYze22OUUHL6bLKlXBWDnM
bcR85OfjXX//8xLJXgNAxlYUwwfo2mmi/gSaNQ5vI7wNevyQidui7824NLi9DJmP
+MoVDAKoCDxybkyl5ln8yUWmz21vA6lHC508N8CJewNF/MruSYbMqgZrn9HmpEQ0
OSWFd8yX1Fh0aruSBfIGUb6Nac+9kxutwK4rybJrv+gzkd1E8kyTzEt/VMcbkXQR
L/uqMYUCu9XSUfAGFPq/aVxd8afsXIC45Z20jZng8IL88HKOw9/NaJjPfcSfs/Yw
jLtDL/amXLQ6f6CAAc+Sy+ndifNGXb+JuoXLxI/nxVTTKLQrEWjDa0WvPjlUjwu/
GqHg51M0fchKIBBoLc/E2vrN1TrHb62paGpq9/FlwZCMHh1912EjCAziqWZj7gHb
EYvDL0TYdoyq105vIeXHOqcQQ14TKLt8ZnmOfsR3KiTMW68f8828t9n+nIZi/wEF
G0OpMDhoqkZ3W9TO0CT7
=o05K
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
