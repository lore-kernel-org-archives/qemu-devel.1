Received: from eggs.gnu.org ([2001:4830:134:3::10]:58218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE8c0-0006F6-TW
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE8bx-0008Bc-I4
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:25:08 -0400
Received: from 20.mo1.mail-out.ovh.net ([188.165.45.168]:52089)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fE8bx-0008Ao-8P
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:25:05 -0400
Received: from player714.ha.ovh.net (unknown [10.109.105.60])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 8680FF2D17
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 09:25:03 +0200 (CEST)
References: <20180503062145.17899-1-david@gibson.dropbear.id.au>
	<20180503062145.17899-6-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f7a2a7fc-240c-fd80-0a2e-a5f772c8817a@kaod.org>
Date: Thu, 3 May 2018 09:24:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180503062145.17899-6-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/8] spapr: Clean up LPCR updates from
 hypercalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com

On 05/03/2018 08:21 AM, David Gibson wrote:
> There are several places in spapr_hcall.c where we need to update the L=
PCR
> value on all CPUs.  We do this with the set_spr() helper.  That's not
> really correct because this directly sets the SPR value, without going
> through the ppc_store_lpcr() helper which may need to update state base=
d
> on the LPCR change.
>=20
> In fact, set_spr() is only ever used for the LPCR, so replace it with a=
n
> explicit LPCR updated which uses the right low-level helper.  While we'=
re
> there, move the CPU_FOREACH() which was in every one of the callers int=
o
> the new helper: set_all_lpcrs().
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr_hcall.c | 50 ++++++++++++++++++--------------------------
>  1 file changed, 20 insertions(+), 30 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 16bccdd5c0..ca9702e667 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -15,32 +15,35 @@
>  #include "hw/ppc/spapr_ovec.h"
>  #include "mmu-book3s-v3.h"
> =20
> -struct SPRSyncState {
> -    int spr;
> +struct LPCRSyncState {
>      target_ulong value;
>      target_ulong mask;
>  };
> =20
> -static void do_spr_sync(CPUState *cs, run_on_cpu_data arg)
> +static void do_lpcr_sync(CPUState *cs, run_on_cpu_data arg)
>  {
> -    struct SPRSyncState *s =3D arg.host_ptr;
> +    struct LPCRSyncState *s =3D arg.host_ptr;
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
> +    target_ulong lpcr;
> =20
>      cpu_synchronize_state(cs);
> -    env->spr[s->spr] &=3D ~s->mask;
> -    env->spr[s->spr] |=3D s->value;
> +    lpcr =3D env->spr[SPR_LPCR];
> +    lpcr &=3D ~s->mask;
> +    lpcr |=3D s->value;
> +    ppc_store_lpcr(cpu, lpcr);
>  }
> =20
> -static void set_spr(CPUState *cs, int spr, target_ulong value,
> -                    target_ulong mask)
> +static void set_all_lpcrs(target_ulong value, target_ulong mask)
>  {
> -    struct SPRSyncState s =3D {
> -        .spr =3D spr,
> +    CPUState *cs;
> +    struct LPCRSyncState s =3D {
>          .value =3D value,
>          .mask =3D mask
>      };
> -    run_on_cpu(cs, do_spr_sync, RUN_ON_CPU_HOST_PTR(&s));
> +    CPU_FOREACH(cs) {
> +        run_on_cpu(cs, do_lpcr_sync, RUN_ON_CPU_HOST_PTR(&s));
> +    }
>  }
> =20
>  static bool has_spr(PowerPCCPU *cpu, int spr)
> @@ -1235,8 +1238,6 @@ static target_ulong h_set_mode_resource_le(PowerP=
CCPU *cpu,
>                                             target_ulong value1,
>                                             target_ulong value2)
>  {
> -    CPUState *cs;
> -
>      if (value1) {
>          return H_P3;
>      }
> @@ -1246,16 +1247,12 @@ static target_ulong h_set_mode_resource_le(Powe=
rPCCPU *cpu,
> =20
>      switch (mflags) {
>      case H_SET_MODE_ENDIAN_BIG:
> -        CPU_FOREACH(cs) {
> -            set_spr(cs, SPR_LPCR, 0, LPCR_ILE);
> -        }
> +        set_all_lpcrs(0, LPCR_ILE);
>          spapr_pci_switch_vga(true);
>          return H_SUCCESS;
> =20
>      case H_SET_MODE_ENDIAN_LITTLE:
> -        CPU_FOREACH(cs) {
> -            set_spr(cs, SPR_LPCR, LPCR_ILE, LPCR_ILE);
> -        }
> +        set_all_lpcrs(LPCR_ILE, LPCR_ILE);
>          spapr_pci_switch_vga(false);
>          return H_SUCCESS;
>      }
> @@ -1268,7 +1265,6 @@ static target_ulong h_set_mode_resource_addr_tran=
s_mode(PowerPCCPU *cpu,
>                                                          target_ulong v=
alue1,
>                                                          target_ulong v=
alue2)
>  {
> -    CPUState *cs;
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> =20
>      if (!(pcc->insns_flags2 & PPC2_ISA207S)) {
> @@ -1285,9 +1281,7 @@ static target_ulong h_set_mode_resource_addr_tran=
s_mode(PowerPCCPU *cpu,
>          return H_UNSUPPORTED_FLAG;
>      }
> =20
> -    CPU_FOREACH(cs) {
> -        set_spr(cs, SPR_LPCR, mflags << LPCR_AIL_SHIFT, LPCR_AIL);
> -    }
> +    set_all_lpcrs(mflags << LPCR_AIL_SHIFT, LPCR_AIL);
> =20
>      return H_SUCCESS;
>  }
> @@ -1364,7 +1358,6 @@ static target_ulong h_register_process_table(Powe=
rPCCPU *cpu,
>                                               target_ulong opcode,
>                                               target_ulong *args)
>  {
> -    CPUState *cs;
>      target_ulong flags =3D args[0];
>      target_ulong proc_tbl =3D args[1];
>      target_ulong page_size =3D args[2];
> @@ -1422,12 +1415,9 @@ static target_ulong h_register_process_table(Pow=
erPCCPU *cpu,
>      spapr->patb_entry =3D cproc; /* Save new process table */
> =20
>      /* Update the UPRT and GTSE bits in the LPCR for all cpus */
> -    CPU_FOREACH(cs) {
> -        set_spr(cs, SPR_LPCR,
> -                ((flags & (FLAG_RADIX | FLAG_HASH_PROC_TBL)) ? LPCR_UP=
RT : 0) |
> -                ((flags & FLAG_GTSE) ? LPCR_GTSE : 0),
> -                LPCR_UPRT | LPCR_GTSE);
> -    }
> +    set_all_lpcrs(((flags & (FLAG_RADIX | FLAG_HASH_PROC_TBL)) ? LPCR_=
UPRT : 0) |
> +                  ((flags & FLAG_GTSE) ? LPCR_GTSE : 0),
> +                  LPCR_UPRT | LPCR_GTSE);
> =20
>      if (kvm_enabled()) {
>          return kvmppc_configure_v3_mmu(cpu, flags & FLAG_RADIX,
>=20
