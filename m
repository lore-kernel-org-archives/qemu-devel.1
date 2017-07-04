Received: from eggs.gnu.org ([2001:4830:134:3::10]:36654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSLnb-0000li-K2
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSLnW-0003Dt-Ju
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:15:19 -0400
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:54846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dSLnW-0003D8-A0
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:15:14 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id E194181B1D
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 13:15:12 +0200 (CEST)
Date: Tue, 4 Jul 2017 13:15:00 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170704131500.3ef448c8@bahia.lan>
In-Reply-To: <20170704110126.26806-3-lvivier@redhat.com>
References: <20170704110126.26806-1-lvivier@redhat.com>
	<20170704110126.26806-3-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/5gu5MsGWjT4_ClCE6kovLE5";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4 2/2] target/ppc: move POWER9 DD1
 workaround to init_proc_POWER9()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Suraj Singh <sursingh@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>

--Sig_/5gu5MsGWjT4_ClCE6kovLE5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  4 Jul 2017 13:01:26 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> Commit 5f3066d ("target/ppc: Allow workarounds for POWER9 DD1")
> disables compatibility mode for POWER9 DD1 to allow to
> boot on POWER9 DD1 host with KVM.
>=20
> As the workaround has been added in kvmppc_host_cpu_class_init(),
> it applies only on CPU created with "-cpu host".
> As we want to be able to use also "-cpu POWER9" on a POWER9 DD1
> host, this patch moves the workaround from kvmppc_host_cpu_class_init()
> to init_proc_POWER9().
>=20

As with ppc_cpu_initfn() in your previous version, init_proc_POWER9() is
called for every CPU instance.. ie, all CPU will adjust the @pcr_supported
class attribute...

What about moving the workaround to ppc_POWER9_cpu_family_class_init()
instead ? This would just require to expose mfpvr() in some header.

--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8913,8 +8913,10 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     dc->props =3D powerpc_servercpu_properties;
     pcc->pvr_match =3D ppc_pvr_match_power9;
     pcc->pcr_mask =3D PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_07;
-    pcc->pcr_supported =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_=
2_06 |
-                         PCR_COMPAT_2_05;
+    if (!kvm_enabled() || (mfpvr() & 0xffffff00) !=3D CPU_POWERPC_POWER9_D=
D1) {
+        pcc->pcr_supported =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 |
+                             PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
+    }
     pcc->init_proc =3D init_proc_POWER9;
     pcc->check_pow =3D check_pow_nocheck;
     cc->has_work =3D cpu_has_work_POWER9;

> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  target/ppc/kvm.c            | 11 -----------
>  target/ppc/translate_init.c | 15 ++++++++++++++-
>  2 files changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index f2f7c53..9d76817 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2381,17 +2381,6 @@ static void kvmppc_host_cpu_class_init(ObjectClass=
 *oc, void *data)
> =20
>  #if defined(TARGET_PPC64)
>      pcc->radix_page_info =3D kvm_get_radix_page_info();
> -
> -    if ((pcc->pvr & 0xffffff00) =3D=3D CPU_POWERPC_POWER9_DD1) {
> -        /*
> -         * POWER9 DD1 has some bugs which make it not really ISA 3.00
> -         * compliant.  More importantly, advertising ISA 3.00
> -         * architected mode may prevent guests from activating
> -         * necessary DD1 workarounds.
> -         */
> -        pcc->pcr_supported &=3D ~(PCR_COMPAT_3_00 | PCR_COMPAT_2_07
> -                                | PCR_COMPAT_2_06 | PCR_COMPAT_2_05);
> -    }
>  #endif /* defined(TARGET_PPC64) */
>  }
> =20
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 783bf98..a41fe66 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8811,6 +8811,8 @@ static struct ppc_radix_page_info POWER9_radix_page=
_info =3D {
> =20
>  static void init_proc_POWER9(CPUPPCState *env)
>  {
> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>      /* Common Registers */
>      init_proc_book3s_common(env);
>      gen_spr_book3s_207_dbg(env);
> @@ -8848,7 +8850,18 @@ static void init_proc_POWER9(CPUPPCState *env)
> =20
>      /* Allocate hardware IRQ controller */
>      init_excp_POWER8(env);
> -    ppcPOWER7_irq_init(ppc_env_get_cpu(env));
> +    ppcPOWER7_irq_init(cpu);
> +
> +    if ((pcc->pvr & 0xffffff00) =3D=3D CPU_POWERPC_POWER9_DD1) {
> +        /*
> +         * POWER9 DD1 has some bugs which make it not really ISA 3.00
> +         * compliant.  More importantly, advertising ISA 3.00
> +         * architected mode may prevent guests from activating
> +         * necessary DD1 workarounds.
> +         */
> +        pcc->pcr_supported &=3D ~(PCR_COMPAT_3_00 | PCR_COMPAT_2_07
> +                                | PCR_COMPAT_2_06 | PCR_COMPAT_2_05);
> +    }
>  }
> =20
>  static bool ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr)


--Sig_/5gu5MsGWjT4_ClCE6kovLE5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllbeLQACgkQAvw66wEB28IuPQCeKyWX2GW9bZCtpEEkUiRp3oxQ
m1wAnRAb8mDSTIFimy0TCOsYNMyBB0OZ
=6mS7
-----END PGP SIGNATURE-----

--Sig_/5gu5MsGWjT4_ClCE6kovLE5--
