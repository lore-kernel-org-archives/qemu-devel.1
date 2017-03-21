Received: from eggs.gnu.org ([2001:4830:134:3::10]:54195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cq8qb-00041q-OV
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cq8qa-0006Tp-BJ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:44:29 -0400
Date: Tue, 21 Mar 2017 12:03:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170321010321.GA13932@umbus.fritz.box>
References: <20170320141244.20737-1-lvivier@redhat.com>
	<20170320191114.GE2811@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20170320191114.GE2811@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH v2] numa,
 spapr: align default numa node memory size to 256MB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 04:11:14PM -0300, Eduardo Habkost wrote:
> On Mon, Mar 20, 2017 at 03:12:44PM +0100, Laurent Vivier wrote:
> > Since commit 224245b ("spapr: Add LMB DR connectors"), NUMA node
> > memory size must be aligned to 256MB (SPAPR_MEMORY_BLOCK_SIZE).
> >=20
> > But when "-numa" option is provided without "mem" parameter,
> > the memory is equally divided between nodes, but 8MB aligned.
> > This can be not valid for pseries.
> >=20
> > In that case we can have:
> > $ ./ppc64-softmmu/qemu-system-ppc64 -m 4G -numa node -numa node -numa n=
ode
> > qemu-system-ppc64: Node 0 memory size 0x55000000 is not aligned to 256 =
MiB
> >=20
> > With this patch, we have:
> > (qemu) info numa
> > 3 nodes
> > node 0 cpus: 0
> > node 0 size: 1280 MB
> > node 1 cpus:
> > node 1 size: 1280 MB
> > node 2 cpus:
> > node 2 size: 1536 MB
> >=20
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>

In agree with Eduardo's suggested comment changes.  Apart from that,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Eduardo, do you want to take the final spin through your tree, or
should I take it through mine?

>=20
> The code looks good, but a few comments explaining the reason for
> the numa_mem_align_shift values would be interesting. Additional
> comments below:
>=20
> > ---
> > v2:
> > - remove dtc
> > - Add a field in MachineClass to only modify the
> >   numa node memory alignment value for pseries-2.9
> >   and upper.
> >=20
> >  hw/core/machine.c   | 3 +++
> >  hw/ppc/spapr.c      | 2 ++
> >  include/hw/boards.h | 1 +
> >  numa.c              | 4 ++--
> >  4 files changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 0d92672..2ad5ab5 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -396,6 +396,9 @@ static void machine_class_init(ObjectClass *oc, voi=
d *data)
> >      mc->default_ram_size =3D 128 * M_BYTE;
> >      mc->rom_file_has_mr =3D true;
> > =20
> > +    /* numa node memory size aligned on 8MB by default */
> > +    mc->numa_mem_align_shift =3D 23;
> > +
>=20
> This could include the original "On Linux, each node's border has
> to be 8MB aligned" comment from parse_numa_opts(), to explain the
> reason for the 8MB default.
>=20
> >      object_class_property_add_str(oc, "accel",
> >          machine_get_accel, machine_set_accel, &error_abort);
> >      object_class_property_set_description(oc, "accel",
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 6ee566d..1e72fe8 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3096,6 +3096,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >      xic->ics_resend =3D spapr_ics_resend;
> >      xic->icp_get =3D spapr_icp_get;
> >      ispc->print_info =3D spapr_pic_print_info;
> > +    mc->numa_mem_align_shift =3D 28;
>=20
> A comment explaining why spapr requires 256MB alignment would be
> nice.
>=20
> >  }
> > =20
> >  static const TypeInfo spapr_machine_info =3D {
> > @@ -3180,6 +3181,7 @@ static void spapr_machine_2_8_class_options(Machi=
neClass *mc)
> >  {
> >      spapr_machine_2_9_class_options(mc);
> >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_8);
> > +    mc->numa_mem_align_shift =3D 23;
> >  }
> > =20
> >  DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index 269d0ba..31d9c72 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -135,6 +135,7 @@ struct MachineClass {
> >      bool rom_file_has_mr;
> >      int minimum_page_bits;
> >      bool has_hotpluggable_cpus;
> > +    int numa_mem_align_shift;
> > =20
> >      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
> >                                             DeviceState *dev);
> > diff --git a/numa.c b/numa.c
> > index e01cb54..98e4d02 100644
> > --- a/numa.c
> > +++ b/numa.c
> > @@ -338,12 +338,12 @@ void parse_numa_opts(MachineClass *mc)
> >          if (i =3D=3D nb_numa_nodes) {
> >              uint64_t usedmem =3D 0;
> > =20
> > -            /* On Linux, each node's border has to be 8MB aligned,
> > +            /* On Linux, each node's border has to be aligned,
> >               * the final node gets the rest.
> >               */
>=20
> I assume that the 256MB alignment in spapr is not just because of
> Linux (is it?). This makes the comment misleading.
>=20
> I would rewrite it to something like: "Align each node according
> to the alignment requirements of the machine class".
>=20
>=20
> >              for (i =3D 0; i < nb_numa_nodes - 1; i++) {
> >                  numa_info[i].node_mem =3D (ram_size / nb_numa_nodes) &
> > -                                        ~((1 << 23UL) - 1);
> > +                                        ~((1 << mc->numa_mem_align_shi=
ft) - 1);
> >                  usedmem +=3D numa_info[i].node_mem;
> >              }
> >              numa_info[i].node_mem =3D ram_size - usedmem;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY0HvUAAoJEGw4ysog2bOSi6AP/jf0ETjetYXqg09ZC7FmWzfh
I8vL8QPLYou3mdhHvcOudQN83E4Kh+vhxRxhb/BEI8YRbU7tmApaxb1zrQOJqYNa
NlFHFi7b2QxXAYaqAB5B7PwtcrhMLOFrgTc5x1HgWbNPJr89D2GoxhKKvVjI5Y3+
A7NMuB8YG470+00u/icvzAzpXOVWZSvN3q3HUsNBovg3FFR2hx/YITGvPZGdtzTs
wT9O/0A4OmLBh3bpDVBU8xT1qL2tu4cdYspVGHVv1mpMoDfmvLXxTnXVqg/0Qqhd
lhcv7np/FmrMB1J9lPUckndBloNmRvBWg/5lhACOUKaeepKQV2lsCtVyzd/+9s7w
Ph0XMXJjy/GLECXIV5bn7IrW4ozei9Mp2eUgX9bxpovyw/CSKuyQshAVdPKk/tDR
Ucs66Y13bdFeUXMscd4m2gKDNyvH7U6alxGwEwCcvI8BfPpptrKFWPSvTHq12hxG
mFl/KrjK/gIOmfsRucMo9wgHyblmOJpe8YsEh658TRZ+IpG+Fb3CUojkrZB3b/yx
uq++LeA9pd/DaPdhICvC7BW5e3hdp9zJqDeR6ZlMbd3p8hrJkVgrBI2iC5VGgUfn
mwWoAKuSyX/bJ3WQU4RGT7oY6L2bDEbIK7jqJtDMDFMjo/XDwf+T7yOoIa3CnscR
Q1dGTbB58mDIeFf0huc0
=DXGU
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
