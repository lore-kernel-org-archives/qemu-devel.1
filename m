Received: from eggs.gnu.org ([2001:4830:134:3::10]:37100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ehECh-0000Yh-5o
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:43:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ehECe-0007P6-0T
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:42:59 -0500
References: <20180131181742.2037-1-cohuck@redhat.com>
	<20180131181742.2037-2-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <de34c0e5-002e-f461-bc4d-498548424177@redhat.com>
Date: Thu, 1 Feb 2018 13:42:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180131181742.2037-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] s390x/tcg: wire up pci instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de

On 31.01.2018 19:17, Cornelia Huck wrote:
> On s390x, pci support is implemented via a set of instructions
> (no mmio). Unfortunately, none of them are documented in the
> PoP; the code is based upon the existing implementation for KVM
> and the Linux zpci driver.
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/helper.h      |   9 ++++
>  target/s390x/insn-data.def |  15 +++++++
>  target/s390x/misc_helper.c | 109 +++++++++++++++++++++++++++++++++++++=
++++++++
>  target/s390x/translate.c   | 101 +++++++++++++++++++++++++++++++++++++=
++++
>  4 files changed, 234 insertions(+)
>=20
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 59a1d9869b..9887efbb3a 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -172,4 +172,13 @@ DEF_HELPER_2(stcrw, void, env, i64)
>  DEF_HELPER_3(stsch, void, env, i64, i64)
>  DEF_HELPER_3(tsch, void, env, i64, i64)
>  DEF_HELPER_2(chsc, void, env, i64)
> +
> +DEF_HELPER_2(clp, void, env, i32)
> +DEF_HELPER_3(pcilg, void, env, i32, i32)
> +DEF_HELPER_3(pcistg, void, env, i32, i32)
> +DEF_HELPER_4(stpcifc, void, env, i32, i64, i32)
> +DEF_HELPER_3(sic, void, env, i64, i64)
> +DEF_HELPER_3(rpcit, void, env, i32, i32)
> +DEF_HELPER_5(pcistb, void, env, i32, i32, i64, i32)
> +DEF_HELPER_4(mpcifc, void, env, i32, i64, i32)
>  #endif
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 11ee43dcbc..b9841631a8 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -1067,4 +1067,19 @@
>      /* ??? Not listed in PoO ninth edition, but there's a linux driver=
 that
>         uses it: "A CHSC subchannel is usually present on LPAR only."  =
*/
>      C(0xb25f, CHSC,  RRE,     Z,   0, insn, 0, 0, chsc, 0)
> +
> +/* zPCI Instructions */
> +    /* None of these instructions are documented in the PoP, so this i=
s all
> +       based upon target/s390x/kvm.c and Linux code and likely incompl=
ete */

I'd drop this comment and rather move it to the patch description.

> +    C(0xebd0, PCISTB, RSY_a, PCI, la2, 0, 0, 0, pcistb, 0)
> +    /* SIC does not really depend on pci, but it is unclear from the c=
ode
> +       with which facility it becomes available */> +    C(0xebd1, SIC=
, RSY_a, Z, r1, r3, 0, 0, sic, 0)
> +    C(0xb9a0, CLP, RRF_c, PCI, 0, 0, 0, 0, clp, 0)
> +    C(0xb9d0, PCISTG, RRE, PCI, 0, 0, 0, 0, pcistg, 0)
> +    C(0xb9d2, PCILG, RRE, PCI, 0, 0, 0, 0, pcilg, 0)
> +    C(0xb9d3, RPCIT, RRE, PCI, 0, 0, 0, 0, rpcit, 0)
> +    C(0xe3d0, MPCIFC, RXY_a, PCI, la2, 0, 0, 0, mpcifc, 0)
> +    C(0xe3d4, STPCIFC, RXY_a, PCI, la2, 0, 0, 0, stpcifc, 0)
> +
>  #endif /* CONFIG_USER_ONLY */
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 86da6aab7e..6f5103f3b5 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -36,6 +36,7 @@
>  #include "hw/s390x/ebcdic.h"
>  #include "hw/s390x/s390-virtio-hcall.h"
>  #include "hw/s390x/sclp.h"
> +#include "hw/s390x/s390-pci-inst.h"
>  #endif
> =20
>  /* #define DEBUG_HELPER */
> @@ -560,3 +561,111 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64=
_t addr)
>      env->regs[0] =3D deposit64(env->regs[0], 0, 8, (max_bytes / 8) - 1=
);
>      return count_bytes >=3D max_bytes ? 0 : 3;
>  }
> +
> +#ifndef CONFIG_USER_ONLY
> +void HELPER(clp)(CPUS390XState *env, uint32_t r2)
> +{
> +    S390CPU *cpu =3D s390_env_get_cpu(env);
> +    int r;
> +
> +    qemu_mutex_lock_iothread();
> +    r =3D clp_service_call(cpu, r2, GETPC());
> +    qemu_mutex_unlock_iothread();
> +    if (r) {
> +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> +    }

We don't need the if (r) ... so I suggest dropping all these. (as I
said, will be handled later via the generic flag checking in translation
code). We can ignore any error from these functions.

A sane guest will newer trigger this. (if we have no CONFIG_PCI, the
also the ZPCI feature will not be available)

Makes the code even shorter :)

--=20

Thanks,

David / dhildenb
