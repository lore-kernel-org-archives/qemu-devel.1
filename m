Received: from eggs.gnu.org ([2001:4830:134:3::10]:59205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9PjP-0005ti-PK
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9PjL-0007re-NT
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:41:15 -0400
Date: Fri, 20 Apr 2018 16:40:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180420064057.GN2434@umbus.fritz.box>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-3-david@gibson.dropbear.id.au>
	<20180419192105.7eb51b26@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fz0LNKsoEivY4NpG"
Content-Disposition: inline
In-Reply-To: <20180419192105.7eb51b26@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for-2.13 02/10] spapr: Remove support for
 PowerPC 970 with pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: benh@kernel.crashing.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--fz0LNKsoEivY4NpG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 07:21:05PM +0200, Greg Kurz wrote:
> On Tue, 17 Apr 2018 17:17:14 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Current POWER cpus allow for a VRMA, a special mapping which describes a
> > guest's view of memory when in real mode (MMU off, from the guest's poi=
nt
> > of view).  Older cpus didn't have that which meant that to support a gu=
est
> > a special host-contiguous region of memory was needed to give the guest=
 its
> > Real Mode Area (RMA).
> >=20
> > This was useful in the early days of KVM on Power to allow it to be tes=
ted
> > on PowerPC 970 chips as used in Macintosh G5 machines.  Now, however, t=
hose
> > machines are so old as to be irrelevant, and the host kernel has long s=
ince
> > dropped support for this mode.  It hasn't been tested in ages either.
> >=20
> > So, to simplify the code, drop the support from qemu as well.
> >=20
>=20
> So this could possibly break TCG guests with 970, which happens to be
> bootable with the current code ?

Hm.. so that's actually a good question.  In theory the HIOR change
could break TCG.. except that AFAICT we don't do anything with the
HIOR register except pass it to KVM.

The allocated RMA changes are only relevant with 970 *and* KVM HV.
And allocate RMA mode was always kind of broken because there was no
real way to ensure a consistent guest environment between HV and TCG.

The KVM side support for this has been gone for some time.

> $ cat /etc/redhat-release
> Red Hat Enterprise Linux Server release 6.9 (Santiago)
> $ cat /proc/cpuinfo=20
> processor       : 0
> cpu             : PPC970, altivec supported
> clock           : 1000.000000MHz
> revision        : 2.2 (pvr 0039 0202)
>=20
> timebase        : 512000000
> platform        : pSeries
> model           : IBM pSeries (emulated by qemu)
> machine         : CHRP IBM pSeries (emulated by qemu)
>=20
> I guess nobody uses this setup, but my understanding is that some
> rules must be followed when it comes to removing something that
> works.
>=20
> https://wiki.qemu.org/Features/LegacyRemoval#Rules_for_removing_an_interf=
ace

Well, that's for "interfaces" and I'm not really sure if this qualifies.

> Maybe add a warning if 970 is used, and turn it into an error in two rele=
ases
> along with this patch ?

I really don't want to wait on that for the rma allocation stuff.
It's a hideous wart that makes it really, really hard to make other
changes to the init path (because testing if we broke it means finding
a real 970 host).

>=20
> > As well as the code for handling contiguous RMAs, we can remove some
> > code to set the HIOR register, which existed on 970 but not on the
> > current and supported CPUs.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c          | 61 +++++++++++++++--------------------------=
--------
> >  hw/ppc/spapr_cpu_core.c |  2 --
> >  target/ppc/kvm.c        | 36 -----------------------------
> >  target/ppc/kvm_ppc.h    |  6 -----
> >  4 files changed, 19 insertions(+), 86 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 81b50af3b5..fbb2c6752c 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2376,9 +2376,6 @@ static void spapr_machine_init(MachineState *mach=
ine)
> >      int i;
> >      MemoryRegion *sysmem =3D get_system_memory();
> >      MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> > -    MemoryRegion *rma_region;
> > -    void *rma =3D NULL;
> > -    hwaddr rma_alloc_size;
> >      hwaddr node0_size =3D spapr_node0_size(machine);
> >      long load_limit, fw_size;
> >      char *filename;
> > @@ -2417,40 +2414,28 @@ static void spapr_machine_init(MachineState *ma=
chine)
> >          exit(1);
> >      }
> > =20
> > -    /* Allocate RMA if necessary */
> > -    rma_alloc_size =3D kvmppc_alloc_rma(&rma);
> > +    spapr->rma_size =3D node0_size;
> > =20
> > -    if (rma_alloc_size =3D=3D -1) {
> > -        error_report("Unable to create RMA");
> > -        exit(1);
> > +    /* With KVM, we don't actually know whether KVM supports an
> > +     * unbounded RMA (PR KVM) or is limited by the hash table size (HV
> > +     * KVM using VRMA), so we always assume the latter
> > +     *
> > +     * In that case, we also limit the initial allocations for RTAS
> > +     * etc... to 256M since we have no way to know what the VRMA size
> > +     * is going to be as it depends on the size of the hash table
> > +     * isn't determined yet.
> > +     */
> > +    if (kvm_enabled()) {
> > +        spapr->vrma_adjust =3D 1;
> > +        spapr->rma_size =3D MIN(spapr->rma_size, 0x10000000);
> >      }
> > =20
> > -    if (rma_alloc_size && (rma_alloc_size < node0_size)) {
> > -        spapr->rma_size =3D rma_alloc_size;
> > -    } else {
> > -        spapr->rma_size =3D node0_size;
> > -
> > -        /* With KVM, we don't actually know whether KVM supports an
> > -         * unbounded RMA (PR KVM) or is limited by the hash table size
> > -         * (HV KVM using VRMA), so we always assume the latter
> > -         *
> > -         * In that case, we also limit the initial allocations for RTAS
> > -         * etc... to 256M since we have no way to know what the VRMA s=
ize
> > -         * is going to be as it depends on the size of the hash table
> > -         * isn't determined yet.
> > -         */
> > -        if (kvm_enabled()) {
> > -            spapr->vrma_adjust =3D 1;
> > -            spapr->rma_size =3D MIN(spapr->rma_size, 0x10000000);
> > -        }
> > -
> > -        /* Actually we don't support unbounded RMA anymore since we
> > -         * added proper emulation of HV mode. The max we can get is
> > -         * 16G which also happens to be what we configure for PAPR
> > -         * mode so make sure we don't do anything bigger than that
> > -         */
> > -        spapr->rma_size =3D MIN(spapr->rma_size, 0x400000000ull);
> > -    }
> > +    /* Actually we don't support unbounded RMA anymore since we
> > +     * added proper emulation of HV mode. The max we can get is
> > +     * 16G which also happens to be what we configure for PAPR
> > +     * mode so make sure we don't do anything bigger than that
> > +     */
> > +    spapr->rma_size =3D MIN(spapr->rma_size, 0x400000000ull);
> > =20
> >      if (spapr->rma_size > node0_size) {
> >          error_report("Numa node 0 has to span the RMA (%#08"HWADDR_PRI=
x")",
> > @@ -2508,14 +2493,6 @@ static void spapr_machine_init(MachineState *mac=
hine)
> >                                           machine->ram_size);
> >      memory_region_add_subregion(sysmem, 0, ram);
> > =20
> > -    if (rma_alloc_size && rma) {
> > -        rma_region =3D g_new(MemoryRegion, 1);
> > -        memory_region_init_ram_ptr(rma_region, NULL, "ppc_spapr.rma",
> > -                                   rma_alloc_size, rma);
> > -        vmstate_register_ram_global(rma_region);
> > -        memory_region_add_subregion(sysmem, 0, rma_region);
> > -    }
> > -
> >      /* initialize hotplug memory address space */
> >      if (machine->ram_size < machine->maxram_size) {
> >          ram_addr_t hotplug_mem_size =3D machine->maxram_size - machine=
->ram_size;
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index aa17626cda..f39d99a8da 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -36,8 +36,6 @@ static void spapr_cpu_reset(void *opaque)
> >       * using an RTAS call */
> >      cs->halted =3D 1;
> > =20
> > -    env->spr[SPR_HIOR] =3D 0;
> > -
> >      /* Disable Power-saving mode Exit Cause exceptions for the CPU.
> >       * This can cause issues when rebooting the guest if a secondary
> >       * is awaken */
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 6de59c5b21..51177a8e00 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2159,42 +2159,6 @@ void kvmppc_hint_smt_possible(Error **errp)
> > =20
> > =20
> >  #ifdef TARGET_PPC64
> > -off_t kvmppc_alloc_rma(void **rma)
> > -{
> > -    off_t size;
> > -    int fd;
> > -    struct kvm_allocate_rma ret;
> > -
> > -    /* If cap_ppc_rma =3D=3D 0, contiguous RMA allocation is not suppo=
rted
> > -     * if cap_ppc_rma =3D=3D 1, contiguous RMA allocation is supported=
, but
> > -     *                      not necessary on this hardware
> > -     * if cap_ppc_rma =3D=3D 2, contiguous RMA allocation is needed on=
 this hardware
> > -     *
> > -     * FIXME: We should allow the user to force contiguous RMA
> > -     * allocation in the cap_ppc_rma=3D=3D1 case.
> > -     */
> > -    if (cap_ppc_rma < 2) {
> > -        return 0;
> > -    }
> > -
> > -    fd =3D kvm_vm_ioctl(kvm_state, KVM_ALLOCATE_RMA, &ret);
> > -    if (fd < 0) {
> > -        fprintf(stderr, "KVM: Error on KVM_ALLOCATE_RMA: %s\n",
> > -                strerror(errno));
> > -        return -1;
> > -    }
> > -
> > -    size =3D MIN(ret.rma_size, 256ul << 20);
> > -
> > -    *rma =3D mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> > -    if (*rma =3D=3D MAP_FAILED) {
> > -        fprintf(stderr, "KVM: Error mapping RMA: %s\n", strerror(errno=
));
> > -        return -1;
> > -    };
> > -
> > -    return size;
> > -}
> > -
> >  uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shif=
t)
> >  {
> >      struct kvm_ppc_smmu_info info;
> > diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> > index 4d2789eef6..e2840e1d33 100644
> > --- a/target/ppc/kvm_ppc.h
> > +++ b/target/ppc/kvm_ppc.h
> > @@ -37,7 +37,6 @@ target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
> >                                       bool radix, bool gtse,
> >                                       uint64_t proc_tbl);
> >  #ifndef CONFIG_USER_ONLY
> > -off_t kvmppc_alloc_rma(void **rma);
> >  bool kvmppc_spapr_use_multitce(void);
> >  int kvmppc_spapr_enable_inkernel_multitce(void);
> >  void *kvmppc_create_spapr_tce(uint32_t liobn, uint32_t page_shift,
> > @@ -188,11 +187,6 @@ static inline target_ulong kvmppc_configure_v3_mmu=
(PowerPCCPU *cpu,
> >  }
> > =20
> >  #ifndef CONFIG_USER_ONLY
> > -static inline off_t kvmppc_alloc_rma(void **rma)
> > -{
> > -    return 0;
> > -}
> > -
> >  static inline bool kvmppc_spapr_use_multitce(void)
> >  {
> >      return false;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fz0LNKsoEivY4NpG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrZi3kACgkQbDjKyiDZ
s5Lz7w//bUHZyXH+NI78+Gtneh3L5U8K3pqFw+eW5wjqPcO8AG72EU2fEWyul0aT
mGyOlI4qZerqx2RPh/I9mbctiWZ+ADfifg0TGPmM/wkOLz4fzDqqmDefw+tmHFo1
wOaPfp78sCg7634FPASD8A9K9TBKg/VxEBWMFjHQ3JWKbd2pmxYI9vrw/NYvOZpF
Zec8oLWggkQ6CwqWrTO1nh38b9P/apBUdnmQ1lXMXMxsr6g3IoKG5XetSKXXnSyQ
SNwWWZ4I6xExRl0t+4JMeaZ+g4VIOKdz9iO3m61P2DD7A3zaQvwpm0a5X+c9GMq0
TquwAmi1dvxo5GmIBGO8chBG7zGWvmhlKczUk9PKDWGn/SLgejfNeun/xa9doWEm
qekWCq90PPtEMoDT8kFg9EqBWWH7/rI5x6/Lrjvaftg3iDh3byOSgyQQjCi4wD0h
wHVj2XDHZ9AgvSxiLbjmQPfAiv9/tsT1KU0Ix0pAtq6pwD8+mc7ns5gQwkKZFVZI
Ng2fyM2l5jsEOPDYQkaeMBXKAibf58wtyd1YPBvxZV27XjCdWQ5G2c2Dt6BSahjr
UUNZLkSPevID2lo3SMs4wyM/+DKtyKCfKvwjxvZlp3idJruULHqQJAvs+fiBieqz
HDtmWOyQrBf96/SerE0557kpVR6i0LU0A3d/4WEXhzh7W5sycFY=
=v2cn
-----END PGP SIGNATURE-----

--fz0LNKsoEivY4NpG--
