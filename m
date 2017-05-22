Received: from eggs.gnu.org ([2001:4830:134:3::10]:59906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCnqa-0007OX-1l
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCnqU-0005vT-LP
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:58:08 -0400
Date: Mon, 22 May 2017 19:15:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170522091536.GO30246@umbus.fritz.box>
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
	<149518994738.24289.215239362416048889.stgit@bahia.lan>
	<20170522023039.GH30246@umbus.fritz.box>
	<dad9039d-1b4c-be7f-bc49-c485b25632fa@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JWJEtCrVvH5hpatL"
Content-Disposition: inline
In-Reply-To: <dad9039d-1b4c-be7f-bc49-c485b25632fa@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] spapr: fix migration of ICP objects
 from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>


--JWJEtCrVvH5hpatL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 09:20:42AM +0200, C=E9dric Le Goater wrote:
> On 05/22/2017 04:30 AM, David Gibson wrote:
> > On Fri, May 19, 2017 at 12:32:27PM +0200, Greg Kurz wrote:
> >> Commit 5bc8d26de20c ("spapr: allocate the ICPState object from under
> >> sPAPRCPUCore") moved ICP objects from the machine to CPU cores. This
> >> is an improvement since we no longer allocate ICP objects that will
> >> never be used. But it has the side-effect of breaking migration of
> >> older machine types from older QEMU versions.
> >>
> >> This patch introduces a compat flag in the sPAPR machine class so
> >> that all pseries machine up to 2.9 go on with the previous behavior
> >> of pre-allocating ICP objects.
> >>
> >> Signed-off-by: Greg Kurz <groug@kaod.org>
> >> ---
> >> v2: - s/void* /void * in xics_system_init()
> >>     - don't use "[*]" in the ICP object name
> >>     - use pre_2_10_ prefix in field names
> >>     - added xics_nr_servers() helper
> >> ---
> >>  hw/ppc/spapr.c          |   40 ++++++++++++++++++++++++++++++++++++++=
+-
> >>  hw/ppc/spapr_cpu_core.c |   29 ++++++++++++++++++++---------
> >>  include/hw/ppc/spapr.h  |    2 ++
> >>  3 files changed, 61 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 1bb05a9a6b07..182262257c60 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -123,9 +123,15 @@ error:
> >>      return NULL;
> >>  }
> >> =20
> >> +static inline int xics_nr_servers(void)
> >> +{
> >> +    return ppc_cpu_dt_id_from_index(max_cpus);
> >> +}
> >> +
> >>  static void xics_system_init(MachineState *machine, int nr_irqs, Erro=
r **errp)
> >>  {
> >>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> >> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> >> =20
> >>      if (kvm_enabled()) {
> >>          if (machine_kernel_irqchip_allowed(machine) &&
> >> @@ -147,6 +153,35 @@ static void xics_system_init(MachineState *machin=
e, int nr_irqs, Error **errp)
> >>              return;
> >>          }
> >>      }
> >> +
> >> +    if (smc->pre_2_10_icp_allocation) {
> >> +        int nr_servers =3D xics_nr_servers();
> >> +        Error *local_err =3D NULL;
> >> +        int i;
> >> +
> >> +        spapr->pre_2_10_icps =3D g_malloc0(nr_servers * sizeof(ICPSta=
te));
> >> +
> >> +        for (i =3D 0; i < nr_servers; i++) {
> >> +            void *obj =3D &spapr->pre_2_10_icps[i];
> >> +            char *name =3D g_strdup_printf("icp[%d]", i);
> >> +
> >> +            object_initialize(obj, sizeof(ICPState), spapr->icp_type);
> >> +            object_property_add_child(OBJECT(spapr), name, obj, &erro=
r_abort);
> >> +            g_free(name);
> >> +            object_unref(obj);
> >> +            object_property_add_const_link(obj, "xics", OBJECT(spapr),
> >> +                                           &error_abort);
> >> +            object_property_set_bool(obj, true, "realized", &local_er=
r);
> >> +            if (local_err) {
> >> +                while (i--) {
> >> +                    object_unparent(obj);
> >> +                }
> >> +                g_free(spapr->pre_2_10_icps);
> >> +                error_propagate(errp, local_err);
> >> +                break;
> >> +            }
> >> +        }
> >> +    }
> >>  }
> >> =20
> >>  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *=
cpu,
> >> @@ -1020,7 +1055,7 @@ static void *spapr_build_fdt(sPAPRMachineState *=
spapr,
> >>      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
> >> =20
> >>      /* /interrupt controller */
> >> -    spapr_dt_xics(ppc_cpu_dt_id_from_index(max_cpus), fdt, PHANDLE_XI=
CP);
> >> +    spapr_dt_xics(xics_nr_servers(), fdt, PHANDLE_XICP);
> >> =20
> >>      ret =3D spapr_populate_memory(spapr, fdt);
> >>      if (ret < 0) {
> >> @@ -3286,9 +3321,12 @@ static void spapr_machine_2_9_instance_options(=
MachineState *machine)
> >> =20
> >>  static void spapr_machine_2_9_class_options(MachineClass *mc)
> >>  {
> >> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> >> +
> >>      spapr_machine_2_10_class_options(mc);
> >>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
> >>      mc->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
> >> +    smc->pre_2_10_icp_allocation =3D true;
> >>  }
> >> =20
> >>  DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
> >> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> >> index ff7058ecc00e..13c4916aa5e6 100644
> >> --- a/hw/ppc/spapr_cpu_core.c
> >> +++ b/hw/ppc/spapr_cpu_core.c
> >> @@ -119,6 +119,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState=
 *dev, Error **errp)
> >>      size_t size =3D object_type_get_instance_size(typename);
> >>      CPUCore *cc =3D CPU_CORE(dev);
> >>      int i;
> >> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> >> =20
> >>      for (i =3D 0; i < cc->nr_threads; i++) {
> >>          void *obj =3D sc->threads + i * size;
> >> @@ -127,7 +128,9 @@ static void spapr_cpu_core_unrealizefn(DeviceState=
 *dev, Error **errp)
> >>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >> =20
> >>          spapr_cpu_destroy(cpu);
> >> -        object_unparent(cpu->intc);
> >> +        if (!spapr->pre_2_10_icps) {
> >=20
> > Hrm.  I dislike code for the core object directly reaching into the
> > machine to check the compat flag here (and a bunch of other places
> > below).  I can think of a few possible ways of avoiding this:
> >=20
> > 1) The most direct is to make another compat flag in the cpu core
> > object, set by the machine.  Straightforward, but ugly.
> >=20
> > 2) Use a property to optionally pass a reference to the ICP array into
> > the core object.  If set it will give the cpu objects ICPs from that
> > array (compat mode), if not it will allocate them (new style mode).
>=20
> for 2) we can just use a object_property_add_const_link() like
> we do to pass the 'xics' object which is needed by the ICSes.

Yes.  Though you'll need to pass one for each thread down to the core
object, which will be fiddly.

> > 3) (Preferred, if it works)  Always have the core allocate ICPs for
> > each CPU.  For compat mode instead of directly allocating ICPs, the
> > machine sets up an array of pointers to the existing ICPs for each
> > CPU.  The "extra" slots that don't have ICPs in new-style allocation
> > get references to dummy ICP objects (maybe even all the same one).
> > Only the dummy ICP(s) are allocated by the machine, the rest remain
> > owned by the cpu.
>=20
> I like this solution too as it should isolate the compat handling under
> the machine, maybe even in a single routine.

Right, that's the hope.  Plus it means we reduce the difference in
runtime QOM structure between the two modes, which is best when
possible.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JWJEtCrVvH5hpatL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZIqwyAAoJEGw4ysog2bOSEBYQALp9MXvnFiSv2/A9pX/IYKWX
RAul6/MYN2d5Xe2U8VukDZMgrj3tRYBkvNdQBbfSDHIzbaleZFQXAjOeXhFSiItW
YJZ1scGV8xlnhDapIiHMQjQNAo99Oy1yxXvlMxRL9WwZHJKMYFzERO/ZBfRgzrAj
6ec3JFPpWTunDW50jFMiUBrrWUzgEQ+rLJq0q/vcpPy4/TWA/lN7BK+5leGpqPah
4VekoEafODAO/qxnAkmyuyU+iMcGH2mwf9pW3w4vVMweQsW6qbZr6tbKY0QSOMLd
jfUecJNKtgpdBYY6sDXxWQlN/4o1RYsPMT3m0NM+HCc7q5Ik56sB67Uzo59osEk8
zn68ekDYKFADTH+k76P+YVzgrV4EBjYFNEIQM2zT+LknD8/mcek6XNou3nPV/r9q
C0dO8gQGOFB1WktfD25FIW8BtoFNj0pxVOpdhFLfW4ai+/1PZGbEUrvHWlTjbzL6
NzxGb9AyynTBN9n9EPk2aTJF2YCEGgjITd9ydn0IrEnh+oA+2cFa/5ToDOXssXx8
yVAGc4pSCLLJpR7yZ8u7fAcm2nyK4beVlUlCVDhbp5R/4NGFIYXiPBI8Nvs31rmy
/zeo4i/ZFpDdH0Jq2cMqnruRTrC54sxmKXy7zoSqmrOsuE/bSmGp/oTTtVZSLorM
RcEmrpJdcoK+Rwdpe10S
=0zWr
-----END PGP SIGNATURE-----

--JWJEtCrVvH5hpatL--
