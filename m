Received: from eggs.gnu.org ([2001:4830:134:3::10]:41330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1LSp-00059B-1F
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 19:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1LSl-0000Y0-W2
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 19:58:31 -0400
Date: Mon, 9 Oct 2017 10:43:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171008234353.GO10050@umbus.fritz.box>
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
	<150659510129.25889.17733386928036958909.stgit@aravinda>
	<20171004013456.GR3260@umbus.fritz.box>
	<9b20d8a7-c542-2b57-0b80-1787d7b044b6@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D3I0HgOdJ5+6n+7I"
Content-Disposition: inline
In-Reply-To: <9b20d8a7-c542-2b57-0b80-1787d7b044b6@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 5/6] ppc: spapr: Enable FWNMI capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com


--D3I0HgOdJ5+6n+7I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 08, 2017 at 01:56:06PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Wednesday 04 October 2017 07:04 AM, David Gibson wrote:
> > On Thu, Sep 28, 2017 at 04:08:21PM +0530, Aravinda Prasad wrote:
> >> Enable the KVM capability KVM_CAP_PPC_FWNMI so that
> >> the KVM causes guest exit with NMI as exit reason
> >> when it encounters a machine check exception on the
> >> address belonging to a guest. Without this capability
> >> enabled, KVM redirects machine check exceptions to
> >> guest's 0x200 vector.
> >>
> >> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >> ---
> >>  hw/ppc/spapr_rtas.c  |   15 +++++++++++++++
> >>  target/ppc/kvm.c     |   13 +++++++++++++
> >>  target/ppc/kvm_ppc.h |    6 ++++++
> >>  3 files changed, 34 insertions(+)
> >>
> >> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> >> index 08e9a5e..d017a67 100644
> >> --- a/hw/ppc/spapr_rtas.c
> >> +++ b/hw/ppc/spapr_rtas.c
> >> @@ -46,6 +46,7 @@
> >>  #include "qemu/cutils.h"
> >>  #include "trace.h"
> >>  #include "hw/ppc/fdt.h"
> >> +#include "kvm_ppc.h"
> >> =20
> >>  static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState=
 *spapr,
> >>                                     uint32_t token, uint32_t nargs,
> >> @@ -354,6 +355,20 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> >>                                    target_ulong args,
> >>                                    uint32_t nret, target_ulong rets)
> >>  {
> >> +    int ret;
> >> +
> >> +    ret =3D kvmppc_fwnmi_enable(cpu);
> >=20
> > If you're enabling it here, doesn't that mean you need to disable it
> > on reset?
>=20
> We don't have a way in KVM to disable it once enabled.

Hm, ok.  Is it possible to simulate "old style" handling in qemu, even
if KVM is in the new mode?  I guess you can catch the NMI exit from
KVM, but redirect it back to the 0x200 vector in the guest, yes?

If that's so, you might as well try to enable this in the kernel at
machine init time, rather than waiting until nmi-register is called.
That way the user gets an error early if the kernel can't handle it
on a VM that's supposed to support it.

>=20
> >=20
> >> +    if (ret =3D=3D 1) {
> >> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> >> +        return;
> >> +    }
> >> +
> >> +    if (ret < 0) {
> >> +        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> >> +        return;
> >> +    }
> >> +
> >>      spapr->guest_machine_check_addr =3D rtas_ld(args, 1);
> >>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> >>  }
> >> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> >> index 7e4ce02..59b3322 100644
> >> --- a/target/ppc/kvm.c
> >> +++ b/target/ppc/kvm.c
> >> @@ -92,6 +92,7 @@ static int cap_mmu_radix;
> >>  static int cap_mmu_hash_v3;
> >>  static int cap_resize_hpt;
> >>  static int cap_ppc_pvr_compat;
> >> +static int cap_fwnmi;
> >> =20
> >>  static uint32_t debug_inst_opcode;
> >> =20
> >> @@ -150,6 +151,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >>      cap_mmu_radix =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX=
);
> >>      cap_mmu_hash_v3 =3D kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HAS=
H_V3);
> >>      cap_resize_hpt =3D kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE=
_HPT);
> >> +    cap_fwnmi =3D kvm_check_extension(s, KVM_CAP_PPC_FWNMI);
> >>      /*
> >>       * Note: setting it to false because there is not such capability
> >>       * in KVM at this moment.
> >> @@ -2142,6 +2144,17 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int=
 mpic_proxy)
> >>      }
> >>  }
> >> =20
> >> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
> >> +{
> >> +    CPUState *cs =3D CPU(cpu);
> >> +
> >> +    if (!cap_fwnmi) {
> >> +        return 1;
> >> +    }
> >> +
> >> +    return kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
> >=20
> > Yeah, this is no good.  It means migration from a host that's fwnmi
> > capable to one that isn't will be subtly broken.  Instead you need to
> > make fwnmi capability a machine property.  If the property is
> > requested and the host kernel doesn't support it, you need to outright
> > fail, rather than try to fall back.
>=20
> Sure.
>=20
> >=20
> >> +}
> >> +
> >>  int kvmppc_smt_threads(void)
> >>  {
> >>      return cap_ppc_smt ? cap_ppc_smt : 1;
> >> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> >> index 0139dae..55b6df2 100644
> >> --- a/target/ppc/kvm_ppc.h
> >> +++ b/target/ppc/kvm_ppc.h
> >> @@ -28,6 +28,7 @@ void kvmppc_enable_clear_ref_mod_hcalls(void);
> >>  void kvmppc_set_papr(PowerPCCPU *cpu);
> >>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
> >>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
> >> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu);
> >>  int kvmppc_smt_threads(void);
> >>  void kvmppc_hint_smt_possible(Error **errp);
> >>  int kvmppc_set_smt_threads(int smt);
> >> @@ -157,6 +158,11 @@ static inline void kvmppc_set_mpic_proxy(PowerPCC=
PU *cpu, int mpic_proxy)
> >>  {
> >>  }
> >> =20
> >> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
> >> +{
> >> +    return 1;
> >=20
> > Likewise, this should be available, not banned, on TCG.  I think there
> > are existing problems with TCG<->KVM migration, but there's no
> > inherent reason they shouldn't work, so we don't want to introduce
> > extra reasons they don't.
> >=20
> > Even if TCG will never generate fwnmis (for now), it should allow the
> > guest to register for them.
>=20
> Should this be then changed later only when TCG generates fwnmis?
> Because we don't want to set spapr->guest_machine_check_addr for TCG in
> rtas_ibm_nmi_register(). If set then all machine checks are redirected
> to this address which is not desirable for TCG as we still want machine
> checks to be passed via 0x200.

Um.. why?  The guest has asked for (synchronous) machine checks to go
to its specified address.  That's what it should get, regardless of
the accelerator it's running on.

>=20
> Regards,
> Aravinda
>=20
> >=20
> >> +}
> >> +
> >>  static inline int kvmppc_smt_threads(void)
> >>  {
> >>      return 1;
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--D3I0HgOdJ5+6n+7I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnauDcACgkQbDjKyiDZ
s5JpwQ//XkAT8N5CIm+qYDXTtZrtkKyvEYJr3g/5mz4Vz7aGRt1Es74QiXvezxQP
alF0Ugxu5gT3qc4mnEPOuIiiLiRwXTbIK53RN88lukGpXdiXjehz5KJKbHTZ2llN
VDYPRdOtPda34sMt+aIf/GHqCE6ZIxpx805l/frvVs8j8mlRIh9xAd/fVZVA1+/j
XzvUYgSDtM/s1qtiof6+IB1rBFBX7jSwHu+WdbMfl+FhuwYsfTlHFAvWOUh7Q5UR
DS9iD8zXtiuHMkaWM14rU8fzJuhWmho6Y/8nAZ2yMPpskrHkbW1rcVQlSCN5lcZj
nJlaOAOQp0l+AQqCuqJ88asF8F9w7DoM7nmndFl71bIgqXXwwVktmEdPVZUcDDXI
xW0W6f27cwm54jEN/mrur6VoOn7ORxfd+wPo6XtJKabaZE41xdhRHwmevlDyyR3i
ZwMOSw12p0woUJpEAY6UHUjgUvm5sg1XYf5lGdL2LCY8SLnH7rea9yK/ehEARVeT
Hgj3a2Hl+gqmJ8JLlD837ZxDZ3Xntn0kyMlfDnSTN1ythuGv+dTWT3BbfCCW5vK2
ClSGZOIT5JHy3WE2fk3sLudjFLavSARf8LXLwKl/3aYN+qRaRf8nhBSWNFgdQ7Bi
Q3JxCOlTzVKvMDRVfddcXh7Y701AHSUmdKK1BO1BhLYtwTSiiYw=
=0rNy
-----END PGP SIGNATURE-----

--D3I0HgOdJ5+6n+7I--
