Received: from eggs.gnu.org ([2001:4830:134:3::10]:59214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYPlS-0005or-6j
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 01:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYPlP-0008QD-2J
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 01:18:58 -0500
Date: Sat, 15 Dec 2018 20:07:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181215090722.GP29278@umbus.fritz.box>
References: <20181213050453.9677-1-cota@braap.org>
	<20181213050453.9677-64-cota@braap.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mejza3ZMMA5Za1mX"
Content-Disposition: inline
In-Reply-To: <20181213050453.9677-64-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH v5 63/73] ppc: convert to
 cpu_has_work_with_iothread_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--mejza3ZMMA5Za1mX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 12:04:43AM -0500, Emilio G. Cota wrote:
> Soon we will call cpu_has_work without the BQL.
>=20
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/translate_init.inc.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 757eb6df16..cf453cb099 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8462,6 +8462,8 @@ static bool cpu_has_work_POWER7(CPUState *cs)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
> =20
> +    g_assert(qemu_mutex_iothread_locked());
> +
>      if (cpu_halted(cs)) {
>          if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
>              return false;
> @@ -8505,7 +8507,7 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
>      pcc->pcr_supported =3D PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
>      pcc->init_proc =3D init_proc_POWER7;
>      pcc->check_pow =3D check_pow_nocheck;
> -    cc->has_work =3D cpu_has_work_POWER7;
> +    cc->has_work_with_iothread_lock =3D cpu_has_work_POWER7;
>      pcc->insns_flags =3D PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MF=
TB |
>                         PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
>                         PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
> @@ -8616,6 +8618,8 @@ static bool cpu_has_work_POWER8(CPUState *cs)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
> =20
> +    g_assert(qemu_mutex_iothread_locked());
> +
>      if (cpu_halted(cs)) {
>          if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
>              return false;
> @@ -8667,7 +8671,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
>      pcc->pcr_supported =3D PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | PCR_COMPA=
T_2_05;
>      pcc->init_proc =3D init_proc_POWER8;
>      pcc->check_pow =3D check_pow_nocheck;
> -    cc->has_work =3D cpu_has_work_POWER8;
> +    cc->has_work_with_iothread_lock =3D cpu_has_work_POWER8;
>      pcc->insns_flags =3D PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MF=
TB |
>                         PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
>                         PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
> @@ -8808,6 +8812,8 @@ static bool cpu_has_work_POWER9(CPUState *cs)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
> =20
> +    g_assert(qemu_mutex_iothread_locked());
> +
>      if (cpu_halted(cs)) {
>          if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
>              return false;
> @@ -8861,7 +8867,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>                           PCR_COMPAT_2_05;
>      pcc->init_proc =3D init_proc_POWER9;
>      pcc->check_pow =3D check_pow_nocheck;
> -    cc->has_work =3D cpu_has_work_POWER9;
> +    cc->has_work_with_iothread_lock =3D cpu_has_work_POWER9;
>      pcc->insns_flags =3D PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MF=
TB |
>                         PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES |
>                         PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
> @@ -10253,6 +10259,8 @@ static bool ppc_cpu_has_work(CPUState *cs)
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      CPUPPCState *env =3D &cpu->env;
> =20
> +    g_assert(qemu_mutex_iothread_locked());
> +
>      return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
>  }
> =20
> @@ -10452,7 +10460,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, v=
oid *data)
>      cc->class_by_name =3D ppc_cpu_class_by_name;
>      pcc->parent_parse_features =3D cc->parse_features;
>      cc->parse_features =3D ppc_cpu_parse_featurestr;
> -    cc->has_work =3D ppc_cpu_has_work;
> +    cc->has_work_with_iothread_lock =3D ppc_cpu_has_work;
>      cc->do_interrupt =3D ppc_cpu_do_interrupt;
>      cc->cpu_exec_interrupt =3D ppc_cpu_exec_interrupt;
>      cc->dump_state =3D ppc_cpu_dump_state;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mejza3ZMMA5Za1mX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwUxEoACgkQbDjKyiDZ
s5LsHA/8CUZrKDM0abUckvktBpTw2y5nSwynoJglbkHq+BfBd7e3qNjWIZBP5bxd
e7v/IBIIttCbcaLAFchsYRegdADK2OEnWLKY2MFWpxk69RyHNRSjVDT3uDyHp+k/
F6IPkutxZeZSbwferJInoBqcBp/EJ9yKkv4aYN2J89+Xj1h6DAd4VTQ8+T0jPtjc
N7ajSSaC3JV5nSVC6AH/+s4InBsSUhLNpRfwgPyzt5QoXEbctHFZAV28MyXV0QGB
RT8iPioSYbWu5z71qGWkLHAv+5K0gh8/3iWr1xSuFt0jIW33k5b/Re66sarxqwbt
qqrCLE5dcRTvN4IaCAWJmkHhoyp+k5Z6FmNkvaYnwKTlQek0NSxulBu5Ka9wwyUc
GuJPAFlQI6EJec+t/YrGS19zzGuHALVamik+A7VU9Rytj4690dHj+EvwcY8znvZI
mwB/yaqmq5TG0K3l7CDEke0RYuj20IGj1IjhekZDMFxVglJjlE92519SQOClerMT
zxINZl136gPrb44IUmzdiifRb/HPgnjUJbywirTRfvpu/wsNaQtiODsgZuHRWSEy
KE/gffS/mFsmmMKJw9ZFEQyAv2D8b7ibZqlyfQAuQ+iR3DBLquZo0qpUS3f8Nsag
/eJC1oLWny6e92Q+M8vUxH+IQ4+emL/jhvbnvvQ9WAZnNlB1slE=
=2XXp
-----END PGP SIGNATURE-----

--mejza3ZMMA5Za1mX--
