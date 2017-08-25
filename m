Received: from eggs.gnu.org ([2001:4830:134:3::10]:43605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl68O-0000dy-JO
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 00:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl68N-0005Ov-8J
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 00:22:16 -0400
Date: Fri, 25 Aug 2017 14:22:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170825042203.GC2772@umbus.fritz.box>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
	<1503562911-2776-7-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <1503562911-2776-7-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 6/6] ppc: drop caching ObjectClass
 from PowerPCCPUAlias
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 10:21:51AM +0200, Igor Mammedov wrote:
> Caching there practically doesn't give any benefits
> and that at slow path druring querying supported CPU list.
> But it introduces non conventional path of where from
> comes used CPU type name (kvm_ppc_register_host_cpu_type).
>=20
> Taking in account that kvm_ppc_register_host_cpu_type()
> fixes up models the aliases point to, it's sufficient to
> make ppc_cpu_class_by_name() translate cpu alias to
> correct cpu type name.
> So drop PowerPCCPUAlias::oc field + ppc_cpu_class_by_alias()
> and let ppc_cpu_class_by_name() do conversion to cpu type name,
> which simplifies code a little bit saving ~20LOC and trouble
> wondering why ppc_cpu_class_by_alias() is necessary.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Unfortunately, this will break things.  This isn't purely a cache, in
the case handled by kvm_ppc_register_host_cpu_type(), 'oc' is *not*
redundant with the name.  The name is based on the specific CPU
description, but the oc points to the information for the "host" cpu.

There may well be a better way to do this, but this isn't it.

The problem we're trying to solve here is that KVM HV basically only
works with -cpu host.  But for the benefit of libvirt (and others), we
want, say, -cpu POWER8 to also work if the host *is* a POWER8.  But we
*don't* want to require that the host be exactly the same model of
POWER8 as "POWER8" would be aliased to with TCG.

So basically we take the "family" name of the host CPU and make it an
alias to the host cpu definition.

It's certainly mucky, but there is a reason for it.

> ---
>  target/ppc/cpu-models.h     |  1 -
>  target/ppc/kvm.c            |  1 -
>  target/ppc/translate_init.c | 26 ++------------------------
>  3 files changed, 2 insertions(+), 26 deletions(-)
>=20
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index d748c68..e9c6015 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -31,7 +31,6 @@
>  typedef struct PowerPCCPUAlias {
>      const char *alias;
>      const char *model;
> -    ObjectClass *oc;
>  } PowerPCCPUAlias;
> =20
>  extern PowerPCCPUAlias ppc_cpu_aliases[];
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 3f21190..995c2da 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2488,7 +2488,6 @@ static int kvm_ppc_register_host_cpu_type(void)
>              if (suffix) {
>                  *suffix =3D 0;
>              }
> -            ppc_cpu_aliases[i].oc =3D oc;
>              break;
>          }
>      }
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index ca9f1e3..c06f34b 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -10177,28 +10177,6 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint3=
2_t pvr)
>      return pcc;
>  }
> =20
> -static ObjectClass *ppc_cpu_class_by_name(const char *name);
> -
> -static ObjectClass *ppc_cpu_class_by_alias(PowerPCCPUAlias *alias)
> -{
> -    ObjectClass *invalid_class =3D (void*)ppc_cpu_class_by_alias;
> -
> -    /* Cache target class lookups in the alias table */
> -    if (!alias->oc) {
> -        alias->oc =3D ppc_cpu_class_by_name(alias->model);
> -        if (!alias->oc) {
> -            /* Fast check for non-existing aliases */
> -            alias->oc =3D invalid_class;
> -        }
> -    }
> -
> -    if (alias->oc =3D=3D invalid_class) {
> -        return NULL;
> -    } else {
> -        return alias->oc;
> -    }
> -}
> -
>  static ObjectClass *ppc_cpu_class_by_name(const char *name)
>  {
>      char *cpu_model, *typename;
> @@ -10310,7 +10288,7 @@ static void ppc_cpu_list_entry(gpointer data, gpo=
inter user_data)
>                        name, pcc->pvr);
>      for (i =3D 0; ppc_cpu_aliases[i].alias !=3D NULL; i++) {
>          PowerPCCPUAlias *alias =3D &ppc_cpu_aliases[i];
> -        ObjectClass *alias_oc =3D ppc_cpu_class_by_alias(alias);
> +        ObjectClass *alias_oc =3D ppc_cpu_class_by_name(alias->model);
> =20
>          if (alias_oc !=3D oc) {
>              continue;
> @@ -10390,7 +10368,7 @@ CpuDefinitionInfoList *arch_query_cpu_definitions=
(Error **errp)
>          CpuDefinitionInfoList *entry;
>          CpuDefinitionInfo *info;
> =20
> -        oc =3D ppc_cpu_class_by_alias(alias);
> +        oc =3D ppc_cpu_class_by_name(alias->model);
>          if (oc =3D=3D NULL) {
>              continue;
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmfpesACgkQbDjKyiDZ
s5LJHw//TvTeUPOm529jzFvNYOhmwXjQ45dyZaLV/RmtLjwN6+xmB3oiUkHvMtK2
i6x36S+n+86b358ZMZgtZtZ/2hpKc7904M4F04kwxphhdZrwvFDeWxC5JAa6veA6
RbrLeiQFfo77FNuxWcX37e+qGkK40ihcmIfnxLeKNuc+NNBq0RqXNC2SYtQnN//L
ua4YuJEi1fNHmBe2r8sPf9t+Kw1/DBml1Y2AJ/jK/EpUedmXv/YNeJIL5DZ0tduv
Y9Z8QIDZBs5mdVJqDeQGfe4cD4ieQEWtPhH572jIXBckZelLVkeLB0S95kd1iW2Q
/kTr48v9+k7bfFh44TL82w2/BPgiYw/byteFLRoP8LhS6vnZpCaXxxkd1zBBcTLq
JvsCk1wDw+7XIIwW9Dk4Dy7FMeKfgBLwkWuVmEh/N1KXC333Eu0LkYDd2pXvqdxm
tQfTOLutt31pHn+dfyBWkwoalUnQmEOHXuJ/C9SYLo+33s2Ch+zX68CjitwGj0Kq
TlTyATU7Jggzu619xT+B2DDOzcXnDFkfyc8t5xjS/FAnFlUxhz8PSLzJMv9qWYYl
FGiLHcnf7HviLDrWxeCjDaHRd6Ak7a3SIV7H0i6vU+DAHxYBtIhZ5NUGlm3oS4+X
ovGCz5pV53va6+LMgp1+nLhFiWgsTwt4Q9myF91V+zhpel+X4nU=
=RT4m
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
