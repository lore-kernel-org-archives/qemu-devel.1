Received: from eggs.gnu.org ([2001:4830:134:3::10]:38955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kU2-0004Og-JH
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kU0-0004XS-NL
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:26 -0400
Date: Tue, 10 Oct 2017 13:02:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171010020236.GG2668@umbus.fritz.box>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
	<1507578671-158758-13-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7uYPyRQQ5N0D02nI"
Content-Disposition: inline
In-Reply-To: <1507578671-158758-13-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 12/24] ppc: move '-cpu foo,
 compat=xxx' parsing into ppc_cpu_parse_featurestr()
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


--7uYPyRQQ5N0D02nI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2017 at 09:50:59PM +0200, Igor Mammedov wrote:
> there is a dedicated callback CPUClass::parse_features
> which purpose is to convert -cpu features into a set of
> global properties AND deal with compat/legacy features
> that couldn't be directly translated into CPU's properties.
>=20
> Create ppc variant of it (ppc_cpu_parse_featurestr) and
> move 'compat=3Dval' handling from spapr_cpu_core.c into it.
> That removes a dependency of board/core code on cpu_model
> parsing and would let to reuse common -cpu parsing
> introduced by 6063d4c0
>=20
> Set "max-cpu-compat" property only if it exists, in practice
> it should limit 'compat' hack to spapr machine and allow
> to avoid including machine/spapr headers in target/ppc/cpu.c
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v2:
>   - set "max-cpu-compat" property only if it exists,
>     in practice it should limit 'compat' hack to spapr
>     and allow to avoid including machine/spapr headers
>     in target/ppc/cpu.c
>   - do compat=3D parsing only if machine."max-cpu-compat" exists
>     that would match what current code does.
>   - add newline before ppc_cpu_parse_featurestr() definition
> ---
>  include/hw/ppc/spapr.h      |  1 -
>  target/ppc/cpu-qom.h        |  1 +
>  hw/ppc/spapr.c              |  2 +-
>  hw/ppc/spapr_cpu_core.c     | 50 ---------------------------------------
>  target/ppc/translate_init.c | 57 +++++++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 59 insertions(+), 52 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index c1b365f..8ca4f94 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -659,7 +659,6 @@ void spapr_hotplug_req_add_by_count_indexed(sPAPRDRCo=
nnectorType drc_type,
>                                              uint32_t count, uint32_t ind=
ex);
>  void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_=
type,
>                                                 uint32_t count, uint32_t =
index);
> -void spapr_cpu_parse_features(sPAPRMachineState *spapr);
>  int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
>  void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
>                            Error **errp);
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index d0cf6ca..429b47f 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -181,6 +181,7 @@ typedef struct PowerPCCPUClass {
>      DeviceRealize parent_realize;
>      DeviceUnrealize parent_unrealize;
>      void (*parent_reset)(CPUState *cpu);
> +    void (*parent_parse_features)(const char *type, char *str, Error **e=
rrp);
> =20
>      uint32_t pvr;
>      bool (*pvr_match)(struct PowerPCCPUClass *pcc, uint32_t pvr);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1a2ca8a..c7a0310 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2373,7 +2373,7 @@ static void ppc_spapr_init(MachineState *machine)
>          machine->cpu_model =3D kvm_enabled() ? "host" : smc->tcg_default=
_cpu;
>      }
> =20
> -    spapr_cpu_parse_features(spapr);
> +    cpu_parse_cpu_model(TYPE_POWERPC_CPU, machine->cpu_model);
> =20
>      spapr_set_vsmt_mode(spapr, &error_fatal);
> =20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 79a9615..b6610dd 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -21,56 +21,6 @@
>  #include "sysemu/hw_accel.h"
>  #include "qemu/error-report.h"
> =20
> -void spapr_cpu_parse_features(sPAPRMachineState *spapr)
> -{
> -    /*
> -     * Backwards compatibility hack:
> -     *
> -     *   CPUs had a "compat=3D" property which didn't make sense for
> -     *   anything except pseries.  It was replaced by "max-cpu-compat"
> -     *   machine option.  This supports old command lines like
> -     *       -cpu POWER8,compat=3Dpower7
> -     *   By stripping the compat option and applying it to the machine
> -     *   before passing it on to the cpu level parser.
> -     */
> -    gchar **inpieces;
> -    gchar *newprops;
> -    int i, j;
> -    gchar *compat_str =3D NULL;
> -
> -    inpieces =3D g_strsplit(MACHINE(spapr)->cpu_model, ",", 0);
> -
> -    /* inpieces[0] is the actual model string */
> -    i =3D 1;
> -    j =3D 1;
> -    while (inpieces[i]) {
> -        if (g_str_has_prefix(inpieces[i], "compat=3D")) {
> -            /* in case of multiple compat=3D options */
> -            g_free(compat_str);
> -            compat_str =3D inpieces[i];
> -        } else {
> -            j++;
> -        }
> -
> -        i++;
> -        /* Excise compat options from list */
> -        inpieces[j] =3D inpieces[i];
> -    }
> -
> -    if (compat_str) {
> -        char *val =3D compat_str + strlen("compat=3D");
> -
> -        object_property_set_str(OBJECT(spapr), val, "max-cpu-compat",
> -                                &error_fatal);
> -
> -    }
> -
> -    newprops =3D g_strjoinv(",", inpieces);
> -    cpu_parse_cpu_model(TYPE_POWERPC_CPU, newprops);
> -    g_free(newprops);
> -    g_strfreev(inpieces);
> -}
> -
>  static void spapr_cpu_reset(void *opaque)
>  {
>      PowerPCCPU *cpu =3D opaque;
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 0d6379f..3d16481 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -10097,6 +10097,61 @@ static ObjectClass *ppc_cpu_class_by_name(const =
char *name)
>      return NULL;
>  }
> =20
> +static void ppc_cpu_parse_featurestr(const char *type, char *features,
> +                                     Error **errp)
> +{
> +    Object *machine =3D qdev_get_machine();
> +    const PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(object_class_by_nam=
e(type));
> +
> +    if (!features) {
> +        return;
> +    }
> +
> +    if (object_property_find(machine, "max-cpu-compat", NULL)) {
> +        int i;
> +        char **inpieces;
> +        char *s =3D features;
> +        Error *local_err =3D NULL;
> +        char *compat_str =3D NULL;
> +
> +        /*
> +         * Backwards compatibility hack:
> +         *
> +         *   CPUs had a "compat=3D" property which didn't make sense for
> +         *   anything except pseries.  It was replaced by "max-cpu-compa=
t"
> +         *   machine option.  This supports old command lines like
> +         *       -cpu POWER8,compat=3Dpower7
> +         *   By stripping the compat option and applying it to the machi=
ne
> +         *   before passing it on to the cpu level parser.
> +         */
> +        inpieces =3D g_strsplit(features, ",", 0);
> +        *s =3D '\0';
> +        for (i =3D 0; inpieces[i]; i++) {
> +            if (g_str_has_prefix(inpieces[i], "compat=3D")) {
> +                compat_str =3D inpieces[i];
> +                continue;
> +            }
> +            if ((i !=3D 0) && (s !=3D features)) {
> +                s =3D g_stpcpy(s, ",");
> +            }
> +            s =3D g_stpcpy(s, inpieces[i]);
> +        }
> +
> +        if (compat_str) {
> +            char *v =3D compat_str + strlen("compat=3D");
> +            object_property_set_str(machine, v, "max-cpu-compat", &local=
_err);
> +        }
> +        g_strfreev(inpieces);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +
> +    /* do property processing with generic handler */
> +    pcc->parent_parse_features(type, features, errp);
> +}
> +
>  const char *ppc_cpu_lookup_alias(const char *alias)
>  {
>      int ai;
> @@ -10489,6 +10544,8 @@ static void ppc_cpu_class_init(ObjectClass *oc, v=
oid *data)
>      cc->reset =3D ppc_cpu_reset;
> =20
>      cc->class_by_name =3D ppc_cpu_class_by_name;
> +    pcc->parent_parse_features =3D cc->parse_features;
> +    cc->parse_features =3D ppc_cpu_parse_featurestr;
>      cc->has_work =3D ppc_cpu_has_work;
>      cc->do_interrupt =3D ppc_cpu_do_interrupt;
>      cc->cpu_exec_interrupt =3D ppc_cpu_exec_interrupt;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7uYPyRQQ5N0D02nI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlncKjwACgkQbDjKyiDZ
s5L+cw/9FuLYmLU3dqXRMcpcZp2ysTCmur8hxn35w9limzmqeZRpsAhYpHwQ1vjH
U6k54WTF0Uhy3IBVp5MEj6I7M4eHjyg8hKe4gOU32z8r95TVh/5QKDmhIsYG5dlm
wE3Ixc/6GWiMcB4w34wjdqbDaIjAjHiIJzNf9M0cT/7KySLLrzg2uxjMEvjYYX4s
d3VNIQvzse5MGRFJPvawdvODjpYVWJ1dAvbgvvNplG/ACjGlk13XgJTI9ZRLpDhz
NrRtDyEqwn6oQKKg2FMvQTTFD9D0A5TPAxnDnKErAaZo0i92koaEVh5ij5LQZGQJ
ouhnaRPboa6IEnPybfwSk4RZ0mxCWuS4YAHVMI65Hd/anj9wv4u23VkPmx8NrA13
HpPcUFEsQR0HcTaBhzypXShxKTBLVHt+cnOUSEcsFtSr1aPP8GKKkmiOFbjI3aNr
tdaXpCCs8OJUD91IYbvhSbv38E9hIH74Fl0M6vxdmAMl6GGwlhcmnM3W0OKinE7+
JHo4xlaI3OGLThu0ayS1+ojUCZai2Nc8ZrR44eaUCtOJiVtnI6eD9H2vZa4OvGot
hNYqfvh89L/y8lECyOlMH+X8wLeHw/t6y7EQwvdhIx7AUJgBv9cV37/9xGblrSvy
8CPySb1XCCFOcdJXzVo9ZTIJrv3zv7yPFFG/du45Lj4YPzdO39w=
=jzdP
-----END PGP SIGNATURE-----

--7uYPyRQQ5N0D02nI--
