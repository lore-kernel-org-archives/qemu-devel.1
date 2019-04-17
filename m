Received: from eggs.gnu.org ([209.51.188.92]:57931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGdnR-0007vc-MD
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGdnQ-0002Vy-D8
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:11:49 -0400
Date: Wed, 17 Apr 2019 15:22:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190417052250.GN32705@umbus.fritz.box>
References: <20190417025944.16154-1-ehabkost@redhat.com>
	<20190417025944.16154-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v541l457l4DThMFo"
Content-Disposition: inline
In-Reply-To: <20190417025944.16154-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] cpu: Extract CPU class lookup from
 parse_cpu_option()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Like Xu <like.xu@linux.intel.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


--v541l457l4DThMFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 11:59:41PM -0300, Eduardo Habkost wrote:
> The new function will be useful in user mode, when we already
> have a CPU model and don't need to parse any extra options.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/qom/cpu.h |  9 +++++++++
>  exec.c            | 22 ++++++++++++----------
>  2 files changed, 21 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index d28c690b27..e11b14d9ac 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -699,6 +699,15 @@ CPUState *cpu_create(const char *typename);
>   */
>  const char *parse_cpu_option(const char *cpu_option);
> =20
> +/**
> + * lookup_cpu_class:
> + * @cpu_model: CPU model name
> + *
> + * Look up CPU class corresponding to a given CPU model name.
> + */
> +CPUClass *lookup_cpu_class(const char *cpu_model, Error **errp);
> +
> +
>  /**
>   * cpu_has_work:
>   * @cpu: The vCPU to check.
> diff --git a/exec.c b/exec.c
> index 840677f15f..d359e709a6 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -982,24 +982,26 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
>  #endif
>  }
> =20
> +CPUClass *lookup_cpu_class(const char *cpu_model, Error **errp)
> +{
> +    ObjectClass *oc =3D cpu_class_by_name(CPU_RESOLVING_TYPE, cpu_model);
> +    if (oc =3D=3D NULL) {
> +        error_setg(errp, "unable to find CPU model '%s'", cpu_model);
> +        return NULL;
> +    }
> +    return CPU_CLASS(oc);
> +}
> +
>  const char *parse_cpu_option(const char *cpu_option)
>  {
> -    ObjectClass *oc;
>      CPUClass *cc;
>      gchar **model_pieces;
>      const char *cpu_type;
> =20
>      model_pieces =3D g_strsplit(cpu_option, ",", 2);
> =20
> -    oc =3D cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
> -    if (oc =3D=3D NULL) {
> -        error_report("unable to find CPU model '%s'", model_pieces[0]);
> -        g_strfreev(model_pieces);
> -        exit(EXIT_FAILURE);
> -    }
> -
> -    cpu_type =3D object_class_get_name(oc);
> -    cc =3D CPU_CLASS(oc);
> +    cc =3D lookup_cpu_class(model_pieces[0], &error_fatal);
> +    cpu_type =3D object_class_get_name(OBJECT_CLASS(cc));
>      cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
>      g_strfreev(model_pieces);
>      return cpu_type;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--v541l457l4DThMFo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly2uCoACgkQbDjKyiDZ
s5Kn2g//cFErjgodEb6GhvCYJcy0XF7exD59jrf3Np9GECzPgz3dmmPG4rW88AiJ
GBVUbgKU4Fm3WeBba3BTSxidNeV/HQ2j/mRjcsjQnlRnIY3KUolLGSAxl1uCWm40
hgWpjiexW25WJ7p2z13T2HR2LU9VNrWTlkDHEb4pnHFB/ianY9VtU++pxQlbffcM
h2GHwke1ar2/d83iVYM80BvQ+Sl4vrpYTBbSBGzFv/D61CVspoeQbnt7/ciQjz3w
XKWkNyZAXd6HDhAC4YpTawA7fBxeCUuFqwo6G1f7WobXBgGzVkf/Cm7UV54jmeoD
tgEDyOlT5lnBi+k5hJsWKXtN7s4or2uLUDLK0UyotV1hu8UALeHfPvSavRxm83he
QJvsYPv4leg+rbwG7V7Pxu70AomePZpWhVExjBQTIix1AHJMk8HH8DbcwAR5DDIZ
LBbLIERjSmZFDPy19g90YZG4sU1RexBYfjNYtWBk/ybNa3kA0U2Dyey3qSRShWjc
hvex4wq7EBwnJuEiA5nAQZ7XXOaOIpu/TeFUvsUctSU1uWTXONZQk/Wt5hsABObk
S+nSoVeOGeRPQj2W2sdiuGOC5KlnMQwmn5XT03HgCQNTptaKziilJCeOMZl6ef5I
hhLUDo1v88GT83ozhBg0JX1zmDTQGKvHYqKxBqfLGn4hjqonT2o=
=xJM1
-----END PGP SIGNATURE-----

--v541l457l4DThMFo--
