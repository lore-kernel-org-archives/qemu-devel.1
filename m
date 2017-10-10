Received: from eggs.gnu.org ([2001:4830:134:3::10]:38847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kTy-0004Kh-FR
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kTx-0004UK-94
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:22 -0400
Date: Tue, 10 Oct 2017 13:04:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171010020450.GH2668@umbus.fritz.box>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
	<1507578671-158758-14-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dMyqICaxQaaUjrCL"
Content-Disposition: inline
In-Reply-To: <1507578671-158758-14-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 13/24] ppc: spapr: define core types
 statically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--dMyqICaxQaaUjrCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2017 at 09:51:00PM +0200, Igor Mammedov wrote:
> spapr core type definition doesn't have any fields that
> require it to be defined at runtime. So replace code
> that fills in TypeInfo at runtime with static TypeInfo
> array that does the same at complie time.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v2:
>   - fix rebase conflict: add newly added power9_v2 core
> ---
>  include/hw/ppc/spapr_cpu_core.h |  2 +
>  hw/ppc/spapr_cpu_core.c         | 87 +++++++++++++----------------------=
------
>  2 files changed, 30 insertions(+), 59 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
> index 93051e9..66dcf52 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -21,6 +21,8 @@
>  #define SPAPR_CPU_CORE_GET_CLASS(obj) \
>       OBJECT_GET_CLASS(sPAPRCPUCoreClass, (obj), TYPE_SPAPR_CPU_CORE)
> =20
> +#define SPAPR_CPU_CORE_TYPE_NAME(model) model "-" TYPE_SPAPR_CPU_CORE
> +
>  typedef struct sPAPRCPUCore {
>      /*< private >*/
>      CPUCore parent_obj;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index b6610dd..550d320 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -217,37 +217,6 @@ err:
>      error_propagate(errp, local_err);
>  }
> =20
> -static const char *spapr_core_models[] =3D {
> -    /* 970 */
> -    "970_v2.2",
> -
> -    /* 970MP variants */
> -    "970mp_v1.0",
> -    "970mp_v1.1",
> -
> -    /* POWER5+ */
> -    "power5+_v2.1",
> -
> -    /* POWER7 */
> -    "power7_v2.3",
> -
> -    /* POWER7+ */
> -    "power7+_v2.1",
> -
> -    /* POWER8 */
> -    "power8_v2.0",
> -
> -    /* POWER8E */
> -    "power8e_v2.1",
> -
> -    /* POWER8NVL */
> -    "power8nvl_v1.0",
> -
> -    /* POWER9 */
> -    "power9_v1.0",
> -    "power9_v2.0",
> -};
> -
>  static Property spapr_cpu_core_properties[] =3D {
>      DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA_N=
ODE_ID),
>      DEFINE_PROP_END_OF_LIST()
> @@ -265,33 +234,33 @@ void spapr_cpu_core_class_init(ObjectClass *oc, voi=
d *data)
>      g_assert(scc->cpu_class);
>  }
> =20
> -static const TypeInfo spapr_cpu_core_type_info =3D {
> -    .name =3D TYPE_SPAPR_CPU_CORE,
> -    .parent =3D TYPE_CPU_CORE,
> -    .abstract =3D true,
> -    .instance_size =3D sizeof(sPAPRCPUCore),
> -    .class_size =3D sizeof(sPAPRCPUCoreClass),
> -};
> -
> -static void spapr_cpu_core_register_types(void)
> -{
> -    int i;
> -
> -    type_register_static(&spapr_cpu_core_type_info);
> -
> -    for (i =3D 0; i < ARRAY_SIZE(spapr_core_models); i++) {
> -        TypeInfo type_info =3D {
> -            .parent =3D TYPE_SPAPR_CPU_CORE,
> -            .instance_size =3D sizeof(sPAPRCPUCore),
> -            .class_init =3D spapr_cpu_core_class_init,
> -            .class_data =3D (void *) spapr_core_models[i],
> -        };
> -
> -        type_info.name =3D g_strdup_printf("%s-" TYPE_SPAPR_CPU_CORE,
> -                                         spapr_core_models[i]);
> -        type_register(&type_info);
> -        g_free((void *)type_info.name);
> +#define DEFINE_SPAPR_CPU_CORE_TYPE(cpu_model) \
> +    {                                                   \
> +        .parent =3D TYPE_SPAPR_CPU_CORE,                  \
> +        .class_data =3D (void *) cpu_model,               \
> +        .class_init =3D spapr_cpu_core_class_init,        \
> +        .name =3D SPAPR_CPU_CORE_TYPE_NAME(cpu_model),    \
>      }
> -}
> =20
> -type_init(spapr_cpu_core_register_types)
> +static const TypeInfo spapr_cpu_core_type_infos[] =3D {
> +    {
> +        .name =3D TYPE_SPAPR_CPU_CORE,
> +        .parent =3D TYPE_CPU_CORE,
> +        .abstract =3D true,
> +        .instance_size =3D sizeof(sPAPRCPUCore),
> +        .class_size =3D sizeof(sPAPRCPUCoreClass),
> +    },
> +    DEFINE_SPAPR_CPU_CORE_TYPE("970_v2.2"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.0"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.1"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power5+_v2.1"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power7_v2.3"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power7+_v2.1"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power8_v2.0"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
> +    DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
> +};
> +
> +DEFINE_TYPES(spapr_cpu_core_type_infos)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dMyqICaxQaaUjrCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlncKsIACgkQbDjKyiDZ
s5Kb6Q/7Blb2AWvQOiaiREB12uvL+MuUT3AVxQZ1PXZcZ9FhuTde9LXT594tP0vP
vWKKzGkjZGsrg5Qaw27x05Yk7BKyna3sraFqKCa7Lspw0tPJeJflvbspTq/n0ZVY
PfZzhLHaYSaHtG6o7kMfswD6qOvXfnfIZ9mXQYvvUVdSSk17PC7+DTdMIEoKcOSa
qrDr9Zj4io2cJKBpf6KdiUmPaAChBdUcUVAwLLexOudkzXQodwATIDb8uX+hoKun
oWk7A+7TpsoyrbLkDM5ntBgBQmz2ilJDIPiOFFknlBqMtATBqDAPK4jXRaah51gS
paXh4h7QJvlpjmt3kHNRwNUG2zgtnM98xjdMo4dYvM6RW2jIwVd5MnLsmjCmFXDD
TJVnM7PvcQR0Tyz/iL9a+AGJtGfELyADOORZBd0XlnXaHmaIXMN5i8HXj0z9IZPD
ibDpnO276OA+4CcJMJI2UM6k1ATM0rKzmInTq2D1pOL75fTjlgwAXOTnrKRCDid/
1rwNpriQqeUzpujNTQisrTy6JQzZ/lEITATwU7Usl3q1gY1w0DbL1PtFdZSvz8NZ
vLvd5rtLB85b9IVSJM5x14isfc00uOMquWqrr+UFDvPXEgORK9+fyn83D9nBGUzS
XJ7QOvFkxwRiB3ubhLupbhSsuNz/jqurERKuld0iZCwtxJ56XZg=
=Vl0E
-----END PGP SIGNATURE-----

--dMyqICaxQaaUjrCL--
