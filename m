Received: from eggs.gnu.org ([2001:4830:134:3::10]:43613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl68Q-0000e4-Dv
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 00:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl68N-0005Ox-8E
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 00:22:18 -0400
Date: Fri, 25 Aug 2017 14:12:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170825041208.GA2772@umbus.fritz.box>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
	<1503562911-2776-5-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <1503562911-2776-5-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 4/6] ppc: replace inter-function
 cyclic dependency/recurssion with 2 simple lookups
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


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 10:21:49AM +0200, Igor Mammedov wrote:
> previous patches cleaned up cpu model/alias naming which
> allows to simplify cpu model/alias to cpu type lookup a bit
> byt removing recurssion and dependency of ppc_cpu_class_by_name() /
> ppc_cpu_class_by_alias() on each other.
> Besides of simplifying code it reduces it by ~15LOC.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Urm.. I think this is probably good.  But I'm having a little trouble
convincing myself this really has the same effect as before.

> ---
>  target/ppc/translate_init.c | 43 +++++++++++++--------------------------=
----
>  1 file changed, 13 insertions(+), 30 deletions(-)
>=20
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 0325226..f1a559d 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -10176,22 +10176,6 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint3=
2_t pvr)
>      return pcc;
>  }
> =20
> -static gint ppc_cpu_compare_class_name(gconstpointer a, gconstpointer b)
> -{
> -    ObjectClass *oc =3D (ObjectClass *)a;
> -    const char *name =3D b;
> -    PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(oc);
> -
> -    if (strncasecmp(name, object_class_get_name(oc), strlen(name)) =3D=
=3D 0 &&
> -        ppc_cpu_is_valid(pcc) &&
> -        strcmp(object_class_get_name(oc) + strlen(name),
> -               POWERPC_CPU_TYPE_SUFFIX) =3D=3D 0) {
> -        return 0;
> -    }
> -    return -1;
> -}
> -
> -
>  static ObjectClass *ppc_cpu_class_by_name(const char *name);
> =20
>  static ObjectClass *ppc_cpu_class_by_alias(PowerPCCPUAlias *alias)
> @@ -10216,8 +10200,8 @@ static ObjectClass *ppc_cpu_class_by_alias(PowerP=
CCPUAlias *alias)
> =20
>  static ObjectClass *ppc_cpu_class_by_name(const char *name)
>  {
> -    GSList *list, *item;
> -    ObjectClass *ret =3D NULL;
> +    char *cpu_model, *typename;
> +    ObjectClass *oc;
>      const char *p;
>      int i, len;
> =20
> @@ -10238,21 +10222,20 @@ static ObjectClass *ppc_cpu_class_by_name(const=
 char *name)
>          }
>      }
> =20
> -    list =3D object_class_get_list(TYPE_POWERPC_CPU, false);
> -    item =3D g_slist_find_custom(list, name, ppc_cpu_compare_class_name);
> -    if (item !=3D NULL) {
> -        ret =3D OBJECT_CLASS(item->data);
> +    cpu_model =3D g_ascii_strup(name, -1);
> +    p =3D ppc_cpu_lookup_alias(cpu_model);
> +    if (p) {
> +        g_free(cpu_model);
> +        cpu_model =3D g_strdup(p);
>      }
> -    g_slist_free(list);
> =20
> -    if (ret) {
> -        return ret;
> -    }
> +    typename =3D g_strdup_printf("%s" POWERPC_CPU_TYPE_SUFFIX, cpu_model=
);
> +    oc =3D object_class_by_name(typename);
> +    g_free(typename);
> +    g_free(cpu_model);
> =20
> -    for (i =3D 0; ppc_cpu_aliases[i].alias !=3D NULL; i++) {
> -        if (strcasecmp(ppc_cpu_aliases[i].alias, name) =3D=3D 0) {
> -            return ppc_cpu_class_by_alias(&ppc_cpu_aliases[i]);
> -        }
> +    if (oc && ppc_cpu_is_valid(POWERPC_CPU_CLASS(oc))) {
> +        return oc;
>      }
> =20
>      return NULL;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmfo5YACgkQbDjKyiDZ
s5Kneg//V3CBWv56M2pCggJFI51lEpD38NQ8eh5vVGO5mNgmNYL0FQAkOhziP3W+
cH3q425wO7buu+6Dvd/rLR1oiAx3X0k11HHJTJThGYjlJb1mrZ9ItLcIqVunY5b4
7jlMy0J54mJ2O8jlKGeP/2ZdI+LLViJQ1+5aappaj4iRhwlgSpoGwOZJ1t3M5/cP
o2ZGFR/Vb7TYtBiMErqeL0WOSJ9Z0ZMff6WvMudJnrVsYoQ6mkXxJhLqODfHtsDR
VqDR6cfUsdS2ZY5BFHv1W7tvnk0a0FKdhT7ALOOR1mJBijcwG3NEG9t+GECUQAz8
MINiii5cBmKwM2F2cT3rdoPsxhQJrNYoafCqFBiMF/wGoxkd8ktW4s9s93HbMyYR
RL5lr3MqmAKQnje5/x8tzhb9NuKCYdLHJ5k9BBG6XrrSQ2YwfHNAtb56JMKC4cOP
UUEG2kPou/3Iz0KycjcORvKKWrPgQXY6PvcZNZNn0l8lugoZupUxjMIbl6ctEoF8
oeoUj5AHSTg7LjkN2O5EVWhlmRictBKUKNN0czs2+5lHfW1wuXVSD/+vFhQbkyD4
QufIoR7kPxT1dTbpwP/d3hZkWQUsNydy29ngVNoSQaCK7a7J3cYc+61/Jb5l/vYj
+F3b89xAvhSIDPwL8Xqufumbv96gTS2y7bSqr+/E6Hg5KvdEECY=
=gzN6
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
