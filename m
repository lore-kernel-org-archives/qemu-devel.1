Received: from eggs.gnu.org ([2001:4830:134:3::10]:49271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1df0Zj-0002r0-Gs
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1df0Zf-000174-DN
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:13:19 -0400
Received: from 6.mo3.mail-out.ovh.net ([188.165.43.173]:60015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1df0Zf-00015X-6j
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:13:15 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 1427D12AF00
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 11:13:11 +0200 (CEST)
References: <20170808060817.2832-1-david@gibson.dropbear.id.au>
	<20170808060817.2832-2-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5ee43f17-9797-689e-7c00-99e1375e54f9@kaod.org>
Date: Tue, 8 Aug 2017 11:13:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170808060817.2832-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/2] target/ppc: Implement TIDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org
Cc: mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, agraf@suse.de

On 08/08/2017 08:08 AM, David Gibson wrote:
> This adds a trivial implementation of the TIDR register added in
> POWER9.  This isn't particularly important to qemu directly - it's
> used by accelerator modules that we don't emulate.
>=20
> However, since qemu isn't aware of it, its state is not synchronized
> with KVM and therefore not migrated, which can be a problem.

The Thread ID Register is defined in Power ISA 3.0B.

Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

C.=20


>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/cpu.h            | 1 +
>  target/ppc/translate_init.c | 5 +++++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 6ee2a26a96..f6e5413fad 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1451,6 +1451,7 @@ void ppc_compat_add_property(Object *obj, const c=
har *name,
>  #define SPR_TEXASR            (0x082)
>  #define SPR_TEXASRU           (0x083)
>  #define SPR_UCTRL             (0x088)
> +#define SPR_TIDR              (0x090)
>  #define SPR_MPC_CMPA          (0x090)
>  #define SPR_MPC_CMPB          (0x091)
>  #define SPR_MPC_CMPC          (0x092)
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 01723bdfec..94800cd29d 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8841,6 +8841,11 @@ static void init_proc_POWER9(CPUPPCState *env)
>      gen_spr_power8_book4(env);
>      gen_spr_power8_rpr(env);
> =20
> +    /* POWER9 Specific registers */
> +    spr_register_kvm(env, SPR_TIDR, "TIDR", NULL, NULL,
> +                     spr_read_generic, spr_write_generic,
> +                     KVM_REG_PPC_TIDR, 0);
> +
>      /* env variables */
>  #if !defined(CONFIG_USER_ONLY)
>      env->slb_nr =3D 32;
>=20
