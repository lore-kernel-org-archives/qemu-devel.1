Received: from eggs.gnu.org ([2001:4830:134:3::10]:48980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0N59-0006Om-86
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0N58-0002gY-25
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:30:03 -0400
Date: Fri, 6 Oct 2017 16:04:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006050439.GV3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-18-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m5R8f+g8StfRwQ/I"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-18-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 17/23] ppc: spapr: use generic cpu_model
 parsing
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


--m5R8f+g8StfRwQ/I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:44PM +0200, Igor Mammedov wrote:
> use generic cpu_model parsing introduced by
>  (6063d4c0f vl.c: convert cpu_model to cpu type and set of global propert=
ies before machine_init())
>=20
> it allows to:
>   * replace sPAPRMachineClass::tcg_default_cpu with
>     MachineClass::default_cpu_type
>   * drop cpu_parse_cpu_model() from hw/ppc/spapr.c and reuse
>     one in vl.c
>   * simplify spapr_get_cpu_core_type() by removing
>     not needed anymore recurrsion since alias look up
>     happens earlier at vl.c and spapr_get_cpu_core_type()
>     works only with resulted from that cpu type.
>   * spapr no more needs to parse/depend on being phased out
>     MachineState::cpu_model, all tha parsing done by generic
>     code and target specific callback.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> PS:
>   patch is a little bit big but it's hard to split it due
>   to dependencies, so pls bear with it.

[snip]
> -static int kvm_ppc_register_host_cpu_type(void)
> +static int kvm_ppc_register_host_cpu_type(MachineState *ms)
>  {
>      TypeInfo type_info =3D {
>          .name =3D TYPE_HOST_POWERPC_CPU,
>          .class_init =3D kvmppc_host_cpu_class_init,
>      };
> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>      PowerPCCPUClass *pvr_pcc;
>      ObjectClass *oc;
>      DeviceClass *dc;
> @@ -2504,6 +2505,8 @@ static int kvm_ppc_register_host_cpu_type(void)
>      }
>      type_info.parent =3D object_class_get_name(OBJECT_CLASS(pvr_pcc));
>      type_register(&type_info);
> +    /* override TCG default cpu type with 'host' cpu model */
> +    mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;

Ugh.  I dislike this, it changes the default cpu type to 'host' for
*all* machine types, whereas previously it was just true for pseries.
That wasn't by accident.

In general, I think we want there to be a single default CPU type for
a machine, regardless of TCG vs. KVM.  This is particularly true for
many of the ppc machine types - they will only work with a CPU in the
right "family" (e500 / 440 / POWERx, wahtever); in many of these cases
KVM PR is usable, but using -cpu host could easily break the machine
type.

'pseries' is different, it (and only it) can be used with KVM HV - and
usually is.  And KVM HV *only* works with -cpu host, due to hardware
limitations.

>      oc =3D object_class_by_name(type_info.name);
>      g_assert(oc);
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 5ee91e8..a968e86 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -10277,6 +10277,19 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint3=
2_t pvr)
>      return pcc;
>  }
> =20
> +static const char *ppc_cpu_lookup_alias(const char *alias)
> +{
> +    int ai;
> +
> +    for (ai =3D 0; ppc_cpu_aliases[ai].alias !=3D NULL; ai++) {
> +        if (strcmp(ppc_cpu_aliases[ai].alias, alias) =3D=3D 0) {
> +            return ppc_cpu_aliases[ai].model;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
>  static ObjectClass *ppc_cpu_class_by_name(const char *name)
>  {
>      char *cpu_model, *typename;
> @@ -10370,19 +10383,6 @@ static void ppc_cpu_parse_featurestr(const char =
*typename, char *features,
>      pcc->parent_parse_features(typename, features, errp);
>  }
> =20
> -const char *ppc_cpu_lookup_alias(const char *alias)
> -{
> -    int ai;
> -
> -    for (ai =3D 0; ppc_cpu_aliases[ai].alias !=3D NULL; ai++) {
> -        if (strcmp(ppc_cpu_aliases[ai].alias, alias) =3D=3D 0) {
> -            return ppc_cpu_aliases[ai].model;
> -        }
> -    }
> -
> -    return NULL;
> -}
> -

This code motion of ppc_cpu_lookup_alias appears to be unrelated to
the rest of the patch.

>  PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
>  {
>      ObjectClass *oc =3D OBJECT_CLASS(pcc);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--m5R8f+g8StfRwQ/I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXDuQACgkQbDjKyiDZ
s5JxHBAAnuxfny21ilbuVd67y3kChYY+WQXq7L172Ai8M73Try4FnZarVCqASXKA
e3LpovezGLsQF2hAKQ4PqkMdAS2av8/v8jthXTexQFxVXAUWJ4QRMV+Lwdh8c5Ot
R6gsnvm0OchAJT8RC7asIDhRFR/I0mzlBXLxTYDdKPcV+A9Y1blPwlk7vPXUAqu0
6buj6DX+4LiiYmx4AlmtcPHARGeJivOVDBiLdhSyLRYtg6PMKWtEwtKLzP+ViVyg
EdyhRw6okrsNs1OCOw9VpSbWLdjJ+On2NfO5OIfImwQeDLqYuM8+k/0mfNaElKGR
HotJKbk5YJQktZAB8+RMfuMupIh2zhnGVHJ4izxCMR1Xv4GvmL8RSVyynZleqxiE
Y5Akta24XyE1lBqWgpWLl9KKdpvyv82EX4l713lYaAMw9ACvQKBXm9tX4tABurat
/yohNimw3Bb1symD8y/AQLzzgc3g411+cPMB78hUJcyWJaJZXxkH3Pp7nkDV9UWh
aqJ44RqG1g6FFuIKTwVXSNKUJbOPqBji7Vkdg1OhiRJVT0U19MxNfV2kLwHeOwmh
uTY7bAitbu57LV38Exqg2DLKdm1vWxQz1gT8evH9WroDRJW5xXNLp8OAcAX2NhUk
5iZ0aIxbebAagp2O9afAkXt2xgM56HFv4n1tZ+YHaQQiPn+vZB8=
=0Z1Q
-----END PGP SIGNATURE-----

--m5R8f+g8StfRwQ/I--
