Received: from eggs.gnu.org ([209.51.188.92]:57946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGdnS-0007vh-BO
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGdnQ-0002XY-NR
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:11:50 -0400
Date: Wed, 17 Apr 2019 15:25:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190417052517.GQ32705@umbus.fritz.box>
References: <20190417025944.16154-1-ehabkost@redhat.com>
	<20190417025944.16154-6-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RCJLo13VlymhPcEi"
Content-Disposition: inline
In-Reply-To: <20190417025944.16154-6-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] cpu: Add MachineState parameter to
 parse_features()
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


--RCJLo13VlymhPcEi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 11:59:44PM -0300, Eduardo Habkost wrote:
> The ppc implementation of parse_features() requires the machine
> object to be created before it gets called.  This is far from
> obvious when reading the code at main().
>=20
> Instead of making it call qdev_get_machine(), require the caller
> of parse_cpu_option() to provide the machine object.
>=20
> This makes the initialization dependency explicit at main(), and
> will let us move qdev_get_machine() to CONFIG_SOFTMMU in the
> future.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

and ppc parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/qom/cpu.h               | 5 +++--
>  target/ppc/cpu-qom.h            | 3 ++-
>  exec.c                          | 4 ++--
>  qom/cpu.c                       | 3 ++-
>  target/i386/cpu.c               | 3 ++-
>  target/ppc/translate_init.inc.c | 7 ++++---
>  target/sparc/cpu.c              | 3 ++-
>  vl.c                            | 3 ++-
>  8 files changed, 19 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index e11b14d9ac..cbc8e103bb 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -164,7 +164,8 @@ typedef struct CPUClass {
>      /*< public >*/
> =20
>      ObjectClass *(*class_by_name)(const char *cpu_model);
> -    void (*parse_features)(const char *typename, char *str, Error **errp=
);
> +    void (*parse_features)(MachineState *machine, const char *typename,
> +                           char *str, Error **errp);
> =20
>      void (*reset)(CPUState *cpu);
>      int reset_dump_flags;
> @@ -697,7 +698,7 @@ CPUState *cpu_create(const char *typename);
>   * Returns: type of CPU to create or prints error and terminates process
>   *          if an error occurred.
>   */
> -const char *parse_cpu_option(const char *cpu_option);
> +const char *parse_cpu_option(MachineState *machine, const char *cpu_opti=
on);
> =20
>  /**
>   * lookup_cpu_class:
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index be9b4c30c3..7891465554 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -167,7 +167,8 @@ typedef struct PowerPCCPUClass {
>      DeviceRealize parent_realize;
>      DeviceUnrealize parent_unrealize;
>      void (*parent_reset)(CPUState *cpu);
> -    void (*parent_parse_features)(const char *type, char *str, Error **e=
rrp);
> +    void (*parent_parse_features)(MachineState *machine, const char *typ=
e,
> +                                  char *str, Error **errp);
> =20
>      uint32_t pvr;
>      bool (*pvr_match)(struct PowerPCCPUClass *pcc, uint32_t pvr);
> diff --git a/exec.c b/exec.c
> index d359e709a6..1ca95df9d8 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -992,7 +992,7 @@ CPUClass *lookup_cpu_class(const char *cpu_model, Err=
or **errp)
>      return CPU_CLASS(oc);
>  }
> =20
> -const char *parse_cpu_option(const char *cpu_option)
> +const char *parse_cpu_option(MachineState *machine, const char *cpu_opti=
on)
>  {
>      CPUClass *cc;
>      gchar **model_pieces;
> @@ -1002,7 +1002,7 @@ const char *parse_cpu_option(const char *cpu_option)
> =20
>      cc =3D lookup_cpu_class(model_pieces[0], &error_fatal);
>      cpu_type =3D object_class_get_name(OBJECT_CLASS(cc));
> -    cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
> +    cc->parse_features(machine, cpu_type, model_pieces[1], &error_fatal);
>      g_strfreev(model_pieces);
>      return cpu_type;
>  }
> diff --git a/qom/cpu.c b/qom/cpu.c
> index a8d2958956..c8a7b56148 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -291,7 +291,8 @@ ObjectClass *cpu_class_by_name(const char *typename, =
const char *cpu_model)
>      return cc->class_by_name(cpu_model);
>  }
> =20
> -static void cpu_common_parse_features(const char *typename, char *featur=
es,
> +static void cpu_common_parse_features(MachineState *machine,
> +                                      const char *typename, char *featur=
es,
>                                        Error **errp)
>  {
>      char *val;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d6bb57d210..f5e15ac5da 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3528,7 +3528,8 @@ static gint compare_string(gconstpointer a, gconstp=
ointer b)
> =20
>  /* Parse "+feature,-feature,feature=3Dfoo" CPU feature string
>   */
> -static void x86_cpu_parse_featurestr(const char *typename, char *feature=
s,
> +static void x86_cpu_parse_featurestr(MachineState *machine,
> +                                     const char *typename, char *feature=
s,
>                                       Error **errp)
>  {
>      char *featurestr; /* Single 'key=3Dvalue" string being parsed */
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 0bd555eb19..2ad223fcca 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10119,10 +10119,11 @@ static ObjectClass *ppc_cpu_class_by_name(const=
 char *name)
>      return oc;
>  }
> =20
> -static void ppc_cpu_parse_featurestr(const char *type, char *features,
> +static void ppc_cpu_parse_featurestr(MachineState *ms,
> +                                     const char *type, char *features,
>                                       Error **errp)
>  {
> -    Object *machine =3D qdev_get_machine();
> +    Object *machine =3D OBJECT(ms);
>      const PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(object_class_by_nam=
e(type));
> =20
>      if (!features) {
> @@ -10171,7 +10172,7 @@ static void ppc_cpu_parse_featurestr(const char *=
type, char *features,
>      }
> =20
>      /* do property processing with generic handler */
> -    pcc->parent_parse_features(type, features, errp);
> +    pcc->parent_parse_features(ms, type, features, errp);
>  }
> =20
>  PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 4a4445bdf5..7e360de5ee 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -115,7 +115,8 @@ cpu_add_feat_as_prop(const char *typename, const char=
 *name, const char *val)
>  }
> =20
>  /* Parse "+feature,-feature,feature=3Dfoo" CPU feature string */
> -static void sparc_cpu_parse_features(const char *typename, char *feature=
s,
> +static void sparc_cpu_parse_features(MachineState *machine,
> +                                     const char *typename, char *feature=
s,
>                                       Error **errp)
>  {
>      GList *l, *plus_features =3D NULL, *minus_features =3D NULL;
> diff --git a/vl.c b/vl.c
> index c57e28d1da..e78c4d5a53 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4466,7 +4466,8 @@ int main(int argc, char **argv, char **envp)
>      /* parse features once if machine provides default cpu_type */
>      current_machine->cpu_type =3D machine_class->default_cpu_type;
>      if (cpu_option) {
> -        current_machine->cpu_type =3D parse_cpu_option(cpu_option);
> +        current_machine->cpu_type =3D
> +            parse_cpu_option(current_machine, cpu_option);
>      }
>      parse_numa_opts(current_machine);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RCJLo13VlymhPcEi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly2uLwACgkQbDjKyiDZ
s5LB7Q//e+xxbGrZsNHbErDou873mg/TB6JPPvWI81f2gzXiAKMDezm2mS/mJSbg
4JbNzEtb6Ar2bufTa9NRlKHyWogSghfn9OK4dtnQ+GKReNpJ/FB0lW1gJ/59j7w2
XCSmUehpsbOQ7ZwHg2zsErxCA4fWCZEGa7X6198iPS9TPKrfcmKNhuSV/VOhWnNk
PBVaG86ajEsEfQLVhIE+UWYIxxJ8dkJhdfkiiRYb1Rf9iAchT0aFJMGs4TTPAU+C
XR863d5YveyxyKSht+EgNLXSuKSsH8Ih5QJ/ZW7BahVaCK34aPn73ZlAU1csfQY7
cPiAJ8s7l5g7q9LTT8wgxs+915dE1db/NZjvQawC7ClsQU6nXd7NAf/OsZrEw7Op
ek6FEDIBfvBW3SXRifCS2dpqjLnAOiCEIOtqPihpv4O3f+zhDwrds1japBuDaDef
W2ORKVgDV1rWLzxbRgs1Y9QWA3t+vWLy++6BbVyK+90hnyhbqeS2abXZP7XCOFYy
AZfzRkZBGhusOOe5l8lla7ZOJXbZj18DMmkun50AHy8IYR2lajyZewWTesHOPRii
N5IIBJ3Z0jN5l7gyFlL2szO+Pxdei6h3bvAFc5yqOIJ64I9OdSj2GRZUvgBQrq0x
MUB70QDtXkJn9d7j6yervnVpScpB1luYlyYPhxJKkErue7UtHnI=
=sJBV
-----END PGP SIGNATURE-----

--RCJLo13VlymhPcEi--
