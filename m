Received: from eggs.gnu.org ([2001:4830:134:3::10]:32961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTnrt-0005IP-Gz
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTnrp-0005k4-TP
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:30:17 -0400
Date: Fri, 15 Jun 2018 22:30:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615123001.GA2363@umbus.fritz.box>
References: <20180615021628.20594-1-david@gibson.dropbear.id.au>
	<20180615103336.4bcda3dc@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20180615103336.4bcda3dc@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] target/ppc,
 spapr: Move VPA information to machine_data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 10:33:36AM +0200, Greg Kurz wrote:
> On Fri, 15 Jun 2018 12:16:28 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > CPUPPCState currently contains a number of fields containing the state =
of
> > the VPA.  The VPA is a PAPR specific concept covering several guest/host
> > shared memory areas used to communicate some information with the
> > hypervisor.
> >=20
> > As a PAPR concept this is really machine specific information, although=
 it
> > is per-cpu, so it doesn't really belong in the core CPU state structure.
> >=20
> > There's also other information that's per-cpu, but platform/machine
> > specific.  So create a (void *)machine_data in PowerPCCPU which can be
> > used by the machine to locate per-cpu data.  Intialization, lifetime and
> > cleanup of machine_data is entirely up to the machine type.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_cpu_core.c         | 13 ++++++
> >  hw/ppc/spapr_hcall.c            | 77 ++++++++++++++++++---------------
> >  include/hw/ppc/spapr_cpu_core.h | 11 +++++
> >  target/ppc/cpu.h                |  7 +--
> >  target/ppc/kvm.c                | 39 +++++++++--------
> >  target/ppc/translate_init.inc.c |  8 ----
> >  6 files changed, 88 insertions(+), 67 deletions(-)
> >=20
> > I pulled out the earlier pathces adding machine_data, since putting
> > intc there broke C=E9dric's XIVE work.  Here's a version of just the VPA
> > part revised to be standalone.
> >=20
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 4f0c168784..c4db975d70 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -28,6 +28,7 @@ static void spapr_cpu_reset(void *opaque)
> >      CPUState *cs =3D CPU(cpu);
> >      CPUPPCState *env =3D &cpu->env;
> >      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> >      target_ulong lpcr;
> > =20
> >      cpu_reset(cs);
> > @@ -69,6 +70,12 @@ static void spapr_cpu_reset(void *opaque)
> > =20
> >      /* Set a full AMOR so guest can use the AMR as it sees fit */
> >      env->spr[SPR_AMOR] =3D 0xffffffffffffffffull;
> > +
> > +    spapr_cpu->vpa_addr =3D 0;
> > +    spapr_cpu->slb_shadow_addr =3D 0;
> > +    spapr_cpu->slb_shadow_size =3D 0;
> > +    spapr_cpu->dtl_addr =3D 0;
> > +    spapr_cpu->dtl_size =3D 0;
> >  }
> > =20
> >  void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, targ=
et_ulong r3)
> > @@ -104,8 +111,12 @@ const char *spapr_get_cpu_core_type(const char *cp=
u_type)
> > =20
> >  static void spapr_unrealize_vcpu(PowerPCCPU *cpu)
> >  {
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> > +
> >      qemu_unregister_reset(spapr_cpu_reset, cpu);
> >      object_unparent(cpu->intc);
> > +    cpu->machine_data =3D NULL;
> > +    g_free(spapr_cpu);
> >      cpu_remove_sync(CPU(cpu));
> >      object_unparent(OBJECT(cpu));
> >  }
> > @@ -128,6 +139,8 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
> >      CPUPPCState *env =3D &cpu->env;
> >      Error *local_err =3D NULL;
> > =20
> > +    cpu->machine_data =3D g_new0(sPAPRCPUState, 1);
> > +
> >      object_property_set_bool(OBJECT(cpu), true, "realized", &local_err=
);
> >      if (local_err) {
> >          goto error;
>=20
> This function should g_free(cpu->machine_data) in case of error to
> avoid a leak, ie, the g_free() you had to drop in my other patch.
>=20
> With that fixed,
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> Alternatively, I'm now thinking machine_data could be handled by
> spapr_create_vcpu()/spapr_destroy_cpu(). It would stick more
> to the CPU object life cycle, which makes sense since it holds
> former CPU bits.

That is a better idea, I'm just not used to your new improved paths
here.  I'll post a respin.

>=20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 8b9a4b577f..ae913d070f 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -8,6 +8,7 @@
> >  #include "exec/exec-all.h"
> >  #include "helper_regs.h"
> >  #include "hw/ppc/spapr.h"
> > +#include "hw/ppc/spapr_cpu_core.h"
> >  #include "mmu-hash64.h"
> >  #include "cpu-models.h"
> >  #include "trace.h"
> > @@ -908,9 +909,11 @@ unmap_out:
> >  #define VPA_SHARED_PROC_OFFSET 0x9
> >  #define VPA_SHARED_PROC_VAL    0x2
> > =20
> > -static target_ulong register_vpa(CPUPPCState *env, target_ulong vpa)
> > +static target_ulong register_vpa(PowerPCCPU *cpu, target_ulong vpa)
> >  {
> > -    CPUState *cs =3D CPU(ppc_env_get_cpu(env));
> > +    CPUState *cs =3D CPU(cpu);
> > +    CPUPPCState *env =3D &cpu->env;
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> >      uint16_t size;
> >      uint8_t tmp;
> > =20
> > @@ -935,32 +938,34 @@ static target_ulong register_vpa(CPUPPCState *env=
, target_ulong vpa)
> >          return H_PARAMETER;
> >      }
> > =20
> > -    env->vpa_addr =3D vpa;
> > +    spapr_cpu->vpa_addr =3D vpa;
> > =20
> > -    tmp =3D ldub_phys(cs->as, env->vpa_addr + VPA_SHARED_PROC_OFFSET);
> > +    tmp =3D ldub_phys(cs->as, spapr_cpu->vpa_addr + VPA_SHARED_PROC_OF=
FSET);
> >      tmp |=3D VPA_SHARED_PROC_VAL;
> > -    stb_phys(cs->as, env->vpa_addr + VPA_SHARED_PROC_OFFSET, tmp);
> > +    stb_phys(cs->as, spapr_cpu->vpa_addr + VPA_SHARED_PROC_OFFSET, tmp=
);
> > =20
> >      return H_SUCCESS;
> >  }
> > =20
> > -static target_ulong deregister_vpa(CPUPPCState *env, target_ulong vpa)
> > +static target_ulong deregister_vpa(PowerPCCPU *cpu, target_ulong vpa)
> >  {
> > -    if (env->slb_shadow_addr) {
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> > +
> > +    if (spapr_cpu->slb_shadow_addr) {
> >          return H_RESOURCE;
> >      }
> > =20
> > -    if (env->dtl_addr) {
> > +    if (spapr_cpu->dtl_addr) {
> >          return H_RESOURCE;
> >      }
> > =20
> > -    env->vpa_addr =3D 0;
> > +    spapr_cpu->vpa_addr =3D 0;
> >      return H_SUCCESS;
> >  }
> > =20
> > -static target_ulong register_slb_shadow(CPUPPCState *env, target_ulong=
 addr)
> > +static target_ulong register_slb_shadow(PowerPCCPU *cpu, target_ulong =
addr)
> >  {
> > -    CPUState *cs =3D CPU(ppc_env_get_cpu(env));
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> >      uint32_t size;
> > =20
> >      if (addr =3D=3D 0) {
> > @@ -968,7 +973,7 @@ static target_ulong register_slb_shadow(CPUPPCState=
 *env, target_ulong addr)
> >          return H_HARDWARE;
> >      }
> > =20
> > -    size =3D ldl_be_phys(cs->as, addr + 0x4);
> > +    size =3D ldl_be_phys(CPU(cpu)->as, addr + 0x4);
> >      if (size < 0x8) {
> >          return H_PARAMETER;
> >      }
> > @@ -977,26 +982,28 @@ static target_ulong register_slb_shadow(CPUPPCSta=
te *env, target_ulong addr)
> >          return H_PARAMETER;
> >      }
> > =20
> > -    if (!env->vpa_addr) {
> > +    if (!spapr_cpu->vpa_addr) {
> >          return H_RESOURCE;
> >      }
> > =20
> > -    env->slb_shadow_addr =3D addr;
> > -    env->slb_shadow_size =3D size;
> > +    spapr_cpu->slb_shadow_addr =3D addr;
> > +    spapr_cpu->slb_shadow_size =3D size;
> > =20
> >      return H_SUCCESS;
> >  }
> > =20
> > -static target_ulong deregister_slb_shadow(CPUPPCState *env, target_ulo=
ng addr)
> > +static target_ulong deregister_slb_shadow(PowerPCCPU *cpu, target_ulon=
g addr)
> >  {
> > -    env->slb_shadow_addr =3D 0;
> > -    env->slb_shadow_size =3D 0;
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> > +
> > +    spapr_cpu->slb_shadow_addr =3D 0;
> > +    spapr_cpu->slb_shadow_size =3D 0;
> >      return H_SUCCESS;
> >  }
> > =20
> > -static target_ulong register_dtl(CPUPPCState *env, target_ulong addr)
> > +static target_ulong register_dtl(PowerPCCPU *cpu, target_ulong addr)
> >  {
> > -    CPUState *cs =3D CPU(ppc_env_get_cpu(env));
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> >      uint32_t size;
> > =20
> >      if (addr =3D=3D 0) {
> > @@ -1004,26 +1011,28 @@ static target_ulong register_dtl(CPUPPCState *e=
nv, target_ulong addr)
> >          return H_HARDWARE;
> >      }
> > =20
> > -    size =3D ldl_be_phys(cs->as, addr + 0x4);
> > +    size =3D ldl_be_phys(CPU(cpu)->as, addr + 0x4);
> > =20
> >      if (size < 48) {
> >          return H_PARAMETER;
> >      }
> > =20
> > -    if (!env->vpa_addr) {
> > +    if (!spapr_cpu->vpa_addr) {
> >          return H_RESOURCE;
> >      }
> > =20
> > -    env->dtl_addr =3D addr;
> > -    env->dtl_size =3D size;
> > +    spapr_cpu->dtl_addr =3D addr;
> > +    spapr_cpu->dtl_size =3D size;
> > =20
> >      return H_SUCCESS;
> >  }
> > =20
> > -static target_ulong deregister_dtl(CPUPPCState *env, target_ulong addr)
> > +static target_ulong deregister_dtl(PowerPCCPU *cpu, target_ulong addr)
> >  {
> > -    env->dtl_addr =3D 0;
> > -    env->dtl_size =3D 0;
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> > +
> > +    spapr_cpu->dtl_addr =3D 0;
> > +    spapr_cpu->dtl_size =3D 0;
> > =20
> >      return H_SUCCESS;
> >  }
> > @@ -1035,38 +1044,36 @@ static target_ulong h_register_vpa(PowerPCCPU *=
cpu, sPAPRMachineState *spapr,
> >      target_ulong procno =3D args[1];
> >      target_ulong vpa =3D args[2];
> >      target_ulong ret =3D H_PARAMETER;
> > -    CPUPPCState *tenv;
> >      PowerPCCPU *tcpu;
> > =20
> >      tcpu =3D spapr_find_cpu(procno);
> >      if (!tcpu) {
> >          return H_PARAMETER;
> >      }
> > -    tenv =3D &tcpu->env;
> > =20
> >      switch (flags) {
> >      case FLAGS_REGISTER_VPA:
> > -        ret =3D register_vpa(tenv, vpa);
> > +        ret =3D register_vpa(tcpu, vpa);
> >          break;
> > =20
> >      case FLAGS_DEREGISTER_VPA:
> > -        ret =3D deregister_vpa(tenv, vpa);
> > +        ret =3D deregister_vpa(tcpu, vpa);
> >          break;
> > =20
> >      case FLAGS_REGISTER_SLBSHADOW:
> > -        ret =3D register_slb_shadow(tenv, vpa);
> > +        ret =3D register_slb_shadow(tcpu, vpa);
> >          break;
> > =20
> >      case FLAGS_DEREGISTER_SLBSHADOW:
> > -        ret =3D deregister_slb_shadow(tenv, vpa);
> > +        ret =3D deregister_slb_shadow(tcpu, vpa);
> >          break;
> > =20
> >      case FLAGS_REGISTER_DTL:
> > -        ret =3D register_dtl(tenv, vpa);
> > +        ret =3D register_dtl(tcpu, vpa);
> >          break;
> > =20
> >      case FLAGS_DEREGISTER_DTL:
> > -        ret =3D deregister_dtl(tenv, vpa);
> > +        ret =3D deregister_dtl(tcpu, vpa);
> >          break;
> >      }
> > =20
> > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu=
_core.h
> > index 47dcfda12b..8ceea2973a 100644
> > --- a/include/hw/ppc/spapr_cpu_core.h
> > +++ b/include/hw/ppc/spapr_cpu_core.h
> > @@ -41,4 +41,15 @@ typedef struct sPAPRCPUCoreClass {
> >  const char *spapr_get_cpu_core_type(const char *cpu_type);
> >  void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, targ=
et_ulong r3);
> > =20
> > +typedef struct sPAPRCPUState {
> > +    uint64_t vpa_addr;
> > +    uint64_t slb_shadow_addr, slb_shadow_size;
> > +    uint64_t dtl_addr, dtl_size;
> > +} sPAPRCPUState;
> > +
> > +static inline sPAPRCPUState *spapr_cpu_state(PowerPCCPU *cpu)
> > +{
> > +    return (sPAPRCPUState *)cpu->machine_data;
> > +}
> > +
> >  #endif
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index a91f1a8777..874da6efbc 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1091,12 +1091,6 @@ struct CPUPPCState {
> >      target_ulong rmls;
> >  #endif
> > =20
> > -#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
> > -    uint64_t vpa_addr;
> > -    uint64_t slb_shadow_addr, slb_shadow_size;
> > -    uint64_t dtl_addr, dtl_size;
> > -#endif /* TARGET_PPC64 */
> > -
> >      int error_code;
> >      uint32_t pending_interrupts;
> >  #if !defined(CONFIG_USER_ONLY)
> > @@ -1205,6 +1199,7 @@ struct PowerPCCPU {
> >      uint32_t compat_pvr;
> >      PPCVirtualHypervisor *vhyp;
> >      Object *intc;
> > +    void *machine_data;
> >      int32_t node_id; /* NUMA node this CPU belongs to */
> >      PPCHash64Options *hash64_opts;
> > =20
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 7fe9d0126b..5c0e313ca6 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -829,22 +829,22 @@ static int kvm_get_fp(CPUState *cs)
> >  static int kvm_get_vpa(CPUState *cs)
> >  {
> >      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > -    CPUPPCState *env =3D &cpu->env;
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> >      struct kvm_one_reg reg;
> >      int ret;
> > =20
> >      reg.id =3D KVM_REG_PPC_VPA_ADDR;
> > -    reg.addr =3D (uintptr_t)&env->vpa_addr;
> > +    reg.addr =3D (uintptr_t)&spapr_cpu->vpa_addr;
> >      ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> >      if (ret < 0) {
> >          DPRINTF("Unable to get VPA address from KVM: %s\n", strerror(e=
rrno));
> >          return ret;
> >      }
> > =20
> > -    assert((uintptr_t)&env->slb_shadow_size
> > -           =3D=3D ((uintptr_t)&env->slb_shadow_addr + 8));
> > +    assert((uintptr_t)&spapr_cpu->slb_shadow_size
> > +           =3D=3D ((uintptr_t)&spapr_cpu->slb_shadow_addr + 8));
> >      reg.id =3D KVM_REG_PPC_VPA_SLB;
> > -    reg.addr =3D (uintptr_t)&env->slb_shadow_addr;
> > +    reg.addr =3D (uintptr_t)&spapr_cpu->slb_shadow_addr;
> >      ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> >      if (ret < 0) {
> >          DPRINTF("Unable to get SLB shadow state from KVM: %s\n",
> > @@ -852,9 +852,10 @@ static int kvm_get_vpa(CPUState *cs)
> >          return ret;
> >      }
> > =20
> > -    assert((uintptr_t)&env->dtl_size =3D=3D ((uintptr_t)&env->dtl_addr=
 + 8));
> > +    assert((uintptr_t)&spapr_cpu->dtl_size
> > +           =3D=3D ((uintptr_t)&spapr_cpu->dtl_addr + 8));
> >      reg.id =3D KVM_REG_PPC_VPA_DTL;
> > -    reg.addr =3D (uintptr_t)&env->dtl_addr;
> > +    reg.addr =3D (uintptr_t)&spapr_cpu->dtl_addr;
> >      ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> >      if (ret < 0) {
> >          DPRINTF("Unable to get dispatch trace log state from KVM: %s\n=
",
> > @@ -868,7 +869,7 @@ static int kvm_get_vpa(CPUState *cs)
> >  static int kvm_put_vpa(CPUState *cs)
> >  {
> >      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > -    CPUPPCState *env =3D &cpu->env;
> > +    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> >      struct kvm_one_reg reg;
> >      int ret;
> > =20
> > @@ -876,11 +877,12 @@ static int kvm_put_vpa(CPUState *cs)
> >       * registered.  That means when restoring state, if a VPA *is*
> >       * registered, we need to set that up first.  If not, we need to
> >       * deregister the others before deregistering the master VPA */
> > -    assert(env->vpa_addr || !(env->slb_shadow_addr || env->dtl_addr));
> > +    assert(spapr_cpu->vpa_addr
> > +           || !(spapr_cpu->slb_shadow_addr || spapr_cpu->dtl_addr));
> > =20
> > -    if (env->vpa_addr) {
> > +    if (spapr_cpu->vpa_addr) {
> >          reg.id =3D KVM_REG_PPC_VPA_ADDR;
> > -        reg.addr =3D (uintptr_t)&env->vpa_addr;
> > +        reg.addr =3D (uintptr_t)&spapr_cpu->vpa_addr;
> >          ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> >          if (ret < 0) {
> >              DPRINTF("Unable to set VPA address to KVM: %s\n", strerror=
(errno));
> > @@ -888,19 +890,20 @@ static int kvm_put_vpa(CPUState *cs)
> >          }
> >      }
> > =20
> > -    assert((uintptr_t)&env->slb_shadow_size
> > -           =3D=3D ((uintptr_t)&env->slb_shadow_addr + 8));
> > +    assert((uintptr_t)&spapr_cpu->slb_shadow_size
> > +           =3D=3D ((uintptr_t)&spapr_cpu->slb_shadow_addr + 8));
> >      reg.id =3D KVM_REG_PPC_VPA_SLB;
> > -    reg.addr =3D (uintptr_t)&env->slb_shadow_addr;
> > +    reg.addr =3D (uintptr_t)&spapr_cpu->slb_shadow_addr;
> >      ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> >      if (ret < 0) {
> >          DPRINTF("Unable to set SLB shadow state to KVM: %s\n", strerro=
r(errno));
> >          return ret;
> >      }
> > =20
> > -    assert((uintptr_t)&env->dtl_size =3D=3D ((uintptr_t)&env->dtl_addr=
 + 8));
> > +    assert((uintptr_t)&spapr_cpu->dtl_size
> > +           =3D=3D ((uintptr_t)&spapr_cpu->dtl_addr + 8));
> >      reg.id =3D KVM_REG_PPC_VPA_DTL;
> > -    reg.addr =3D (uintptr_t)&env->dtl_addr;
> > +    reg.addr =3D (uintptr_t)&spapr_cpu->dtl_addr;
> >      ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> >      if (ret < 0) {
> >          DPRINTF("Unable to set dispatch trace log state to KVM: %s\n",
> > @@ -908,9 +911,9 @@ static int kvm_put_vpa(CPUState *cs)
> >          return ret;
> >      }
> > =20
> > -    if (!env->vpa_addr) {
> > +    if (!spapr_cpu->vpa_addr) {
> >          reg.id =3D KVM_REG_PPC_VPA_ADDR;
> > -        reg.addr =3D (uintptr_t)&env->vpa_addr;
> > +        reg.addr =3D (uintptr_t)&spapr_cpu->vpa_addr;
> >          ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> >          if (ret < 0) {
> >              DPRINTF("Unable to set VPA address to KVM: %s\n", strerror=
(errno));
> > diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_ini=
t.inc.c
> > index bb9296f5a3..76d6f3fd5e 100644
> > --- a/target/ppc/translate_init.inc.c
> > +++ b/target/ppc/translate_init.inc.c
> > @@ -10316,14 +10316,6 @@ static void ppc_cpu_reset(CPUState *s)
> >      s->exception_index =3D POWERPC_EXCP_NONE;
> >      env->error_code =3D 0;
> > =20
> > -#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
> > -    env->vpa_addr =3D 0;
> > -    env->slb_shadow_addr =3D 0;
> > -    env->slb_shadow_size =3D 0;
> > -    env->dtl_addr =3D 0;
> > -    env->dtl_size =3D 0;
> > -#endif /* TARGET_PPC64 */
> > -
> >      for (i =3D 0; i < ARRAY_SIZE(env->spr_cb); i++) {
> >          ppc_spr_t *spr =3D &env->spr_cb[i];
> > =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjsUYACgkQbDjKyiDZ
s5KQsRAAknCgjtniTd/9dxec43iHKMFZMiGOxPcm6r7RGBEc44vqDC4rhXBswjtW
0QLISrekfbXVRf4cNscofSZdFq30BNa9varKKJ+4rhZYMRVVk0hfS11oFjEYa/dm
UyJ9GbPepyaXXK9JomYUgZLOMoj0MHdScfGhoDJJJUgkjJxgltlpcDDHaBc0UEif
Y5vHlB/U9gFGPTDmvXCHsZR5AcdphClLB+1uRfKAsi7uP/MwhMcI08rTwFFTC7n+
+dZN+RSK2ixYjNeZY9y24IILglj8V8Q7LLbv0eCav1VvTsz8Vqlm7h75WrzPBQ4b
cVUtRMpDbsWV/Hj882HLJoKdGmtf7zRcqUtu8e+MRAHpZdjZer86X3HmOJ7w9SVx
0YvsQfG1rWXhnbcl18UIMZXbTVymg1YioNNle1gbfEBJnz76dxWuAW57MnYlFajl
UQlG4gEasTf7WzkrtKY+0esQbo1BA6gfKwZm4rQzZE6buitOStn8jNTFIv6l2+Yl
+K+EafYd6mbKwceoA8zM8Y2Y9FXREiVLNglOARaOuNebd6A3ztyx94hamYWjDD38
h3o4Yd35RdDJ9BfANmSDBDyJHOjOi6LqtCNd2p9eezCZXjYGmb3u4DAZwfPkFEBW
+6aXQXkh7/jtCAoJkMyC8nhh3+StMUX5YFwdbXcCPuSrxIndIiQ=
=U09H
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
