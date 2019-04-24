Received: from eggs.gnu.org ([209.51.188.92]:43880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJ70K-00083B-4J
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJ6yv-0007U9-Gg
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:45:55 -0400
Date: Wed, 24 Apr 2019 11:37:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190424013722.GA6983@umbus.fritz.box>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20190423212246.3542-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] machine: Use SupportStatusInfo for
 deprecation info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, mprivozn@redhat.com, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-ppc@nongnu.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 06:22:45PM -0300, Eduardo Habkost wrote:
> Use SupportStatusInfo to represent deprecation information of
> machine types.
>=20
> Instead of using a generic "use XXX instead" message for humans,
> encode the suggested alternative in a machine-friendly way at the
> 'suggested_alternatives' field.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

ppc parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/boards.h |  7 ++++---
>  hw/i386/pc_piix.c   |  4 +++-
>  hw/ppc/prep.c       |  4 +++-
>  vl.c                | 13 +++++++++----
>  4 files changed, 19 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index e231860666..243bf3c7ce 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -8,6 +8,8 @@
>  #include "hw/qdev.h"
>  #include "qom/object.h"
>  #include "qom/cpu.h"
> +#include "qapi/qapi-types-common.h"
> +
> =20
>  /**
>   * memory_region_allocate_system_memory - Allocate a board's main memory
> @@ -105,8 +107,7 @@ typedef struct {
> =20
>  /**
>   * MachineClass:
> - * @deprecation_reason: If set, the machine is marked as deprecated. The
> - *    string should provide some clear information about what to use ins=
tead.
> + * @support_status: Support and deprecation status of machine type.
>   * @max_cpus: maximum number of CPUs supported. Default: 1
>   * @min_cpus: minimum number of CPUs supported. Default: 1
>   * @default_cpus: number of CPUs instantiated if none are specified. Def=
ault: 1
> @@ -169,7 +170,7 @@ struct MachineClass {
>      char *name;
>      const char *alias;
>      const char *desc;
> -    const char *deprecation_reason;
> +    SupportStatusInfo support_status;
> =20
>      void (*init)(MachineState *state);
>      void (*reset)(void);
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 8ad8e885c6..97bd401618 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -781,7 +781,9 @@ static void pc_i440fx_0_15_machine_options(MachineCla=
ss *m)
> =20
>      pc_i440fx_1_0_machine_options(m);
>      m->hw_version =3D "0.15";
> -    m->deprecation_reason =3D "use a newer machine type instead";
> +    m->support_status.deprecated =3D true;
> +    m->support_status.has_suggested_alternative =3D true;
> +    m->support_status.suggested_alternative =3D g_strdup("pc");
>      compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
>  }
> =20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 847d320465..9a02b0eec4 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -587,7 +587,9 @@ static void ppc_prep_init(MachineState *machine)
> =20
>  static void prep_machine_init(MachineClass *mc)
>  {
> -    mc->deprecation_reason =3D "use 40p machine type instead";
> +    mc->support_status.deprecated =3D true;
> +    mc->support_status.has_suggested_alternative =3D true;
> +    mc->support_status.suggested_alternative =3D g_strdup("40p");
>      mc->desc =3D "PowerPC PREP platform";
>      mc->init =3D ppc_prep_init;
>      mc->block_default_type =3D IF_IDE;
> diff --git a/vl.c b/vl.c
> index c696ad2a13..99b857ed2a 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2610,7 +2610,7 @@ static gint machine_class_cmp(gconstpointer a, gcon=
stpointer b)
>              }
>              printf("%-20s %s%s%s\n", mc->name, mc->desc,
>                     mc->is_default ? " (default)" : "",
> -                   mc->deprecation_reason ? " (deprecated)" : "");
> +                   mc->support_status.deprecated ? " (deprecated)" : "");
>          }
>      }
> =20
> @@ -4308,9 +4308,14 @@ int main(int argc, char **argv, char **envp)
>       * called from configure_accelerator().
>       */
> =20
> -    if (!qtest_enabled() && machine_class->deprecation_reason) {
> -        error_report("Machine type '%s' is deprecated: %s",
> -                     machine_class->name, machine_class->deprecation_rea=
son);
> +    if (!qtest_enabled() && machine_class->support_status.deprecated) {
> +        error_report("Machine type '%s' is deprecated%s%s", machine_clas=
s->name,
> +                     machine_class->support_status.status_message ? ": "=
 : "",
> +                     machine_class->support_status.status_message ?: "");
> +        if (machine_class->support_status.suggested_alternative) {
> +            error_report("Suggested solution: use '%s' machine type inst=
ead",
> +                         machine_class->support_status.suggested_alterna=
tive);
> +        }
>      }
> =20
>      /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly/vcwACgkQbDjKyiDZ
s5JSgw//d1OSw6alz9LWz9nLzuaqQujRofl+oge6gzQ5ZvEwwLkpRvbviCjN+cUk
wPc4p2ar19QxHMUMscXyJhOZJjBFnGq40tzX723ikHU441wAtMFFCfaIAXLOdQY0
czJeqXIwLHNYIPzlGSWmLKFpRGPUsdVsucnnwptdN9NcZgp0dqvH1cJuKaMtYnYP
Isb06arbF65rjpIUUhKRibn4y5VjTfmF9wVfrlInCjdAEvj05Ac/F3sIJE0JRWZV
te4YC8cfG+Lfvt3U/o6+KCjjHWLOorlxdsbwKJi8L6SIk0Ns4kDno4WDBc8c2m1m
1SnBLbFUrXQh1HjLgHvrDmFodqOgPLMX8a0ioFNbzg34AhnviobGY24TMXD5bfKd
E9zg2JfiHU2VEyljYnt8dpf6NLRycaloT33CLtaBxJeJsEcYcJn9POaqYDzj7BKS
6PoNx8C64/Rb8wWnxO1I2fIJRMwqMrCWdrT1MsfE+/JN9cNZPyINMrqmUKk7wwL7
s5KsdaX/rQQtihIfiwIt+oZkAcOsLI+Tkm5euQws83lI06bTc0EbzLERYHlt+IPp
unkGfK7LhPpjApAZDGhAI8EAo9vgn9wqKxdORKUbUwsr4uBPld+zk4tQz7h02Ric
xpK+GvQFlmHB6CnPZ4xb4bzf3BdALdCiF+U23htRagQbaqxMuL4=
=m6xh
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
