Received: from eggs.gnu.org ([2001:4830:134:3::10]:51264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g9gKP-0006nv-Az
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 20:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g9gKL-0003aS-82
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 20:56:49 -0400
Received: from ozlabs.org ([203.11.71.1]:58827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1g9gKK-0003Yr-6l
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 20:56:45 -0400
Date: Tue, 9 Oct 2018 09:25:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181008222520.GY7004@umbus.fritz.box>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yYeq/WQYi/kuVVbm"
Content-Disposition: inline
In-Reply-To: <20181008173125.19678-2-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/31] Use error_fatal to simplify obvious
 fatal errors (again)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--yYeq/WQYi/kuVVbm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 07:30:55PM +0200, Markus Armbruster wrote:
> Add a slight improvement of the Coccinelle semantic patch from commit
> 07d04a0219b, and use it to clean up.  It leaves dead Error * variables
> behind, cleaned up manually.
>=20
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

ppc part

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/intc/xics_kvm.c                       |  7 +------
>  qemu-nbd.c                               |  6 +-----
>  scripts/coccinelle/use-error_fatal.cocci | 20 ++++++++++++++++++++
>  vl.c                                     |  7 +------
>  4 files changed, 23 insertions(+), 17 deletions(-)
>  create mode 100644 scripts/coccinelle/use-error_fatal.cocci
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 30c3769a20..e8fa9a53ae 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -198,17 +198,12 @@ static void ics_get_kvm_state(ICSState *ics)
>  {
>      uint64_t state;
>      int i;
> -    Error *local_err =3D NULL;
> =20
>      for (i =3D 0; i < ics->nr_irqs; i++) {
>          ICSIRQState *irq =3D &ics->irqs[i];
> =20
>          kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
> -                          i + ics->offset, &state, false, &local_err);
> -        if (local_err) {
> -            error_report_err(local_err);
> -            exit(1);
> -        }
> +                          i + ics->offset, &state, false, &error_fatal);
> =20
>          irq->server =3D state & KVM_XICS_DESTINATION_MASK;
>          irq->saved_priority =3D (state >> KVM_XICS_PRIORITY_SHIFT)
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index e76fe3082a..7874bc973c 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -1002,11 +1002,7 @@ int main(int argc, char **argv)
>      }
> =20
>      exp =3D nbd_export_new(bs, dev_offset, fd_size, nbdflags, nbd_export=
_closed,
> -                         writethrough, NULL, &local_err);
> -    if (!exp) {
> -        error_report_err(local_err);
> -        exit(EXIT_FAILURE);
> -    }
> +                         writethrough, NULL, &error_fatal);
>      nbd_export_set_name(exp, export_name);
>      nbd_export_set_description(exp, export_description);
> =20
> diff --git a/scripts/coccinelle/use-error_fatal.cocci b/scripts/coccinell=
e/use-error_fatal.cocci
> new file mode 100644
> index 0000000000..10fff0aec4
> --- /dev/null
> +++ b/scripts/coccinelle/use-error_fatal.cocci
> @@ -0,0 +1,20 @@
> +@@
> +type T;
> +identifier FUN, RET;
> +expression list ARGS;
> +expression ERR, EC, FAIL;
> +@@
> +(
> +-    T RET =3D FUN(ARGS, &ERR);
> ++    T RET =3D FUN(ARGS, &error_fatal);
> +|
> +-    RET =3D FUN(ARGS, &ERR);
> ++    RET =3D FUN(ARGS, &error_fatal);
> +|
> +-    FUN(ARGS, &ERR);
> ++    FUN(ARGS, &error_fatal);
> +)
> +-    if (FAIL) {
> +-        error_report_err(ERR);
> +-        exit(EC);
> +-    }
> diff --git a/vl.c b/vl.c
> index a867c9c4d9..9d2b38a31f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2002,15 +2002,10 @@ static void select_vgahw(const char *p)
> =20
>  static void parse_display_qapi(const char *optarg)
>  {
> -    Error *err =3D NULL;
>      DisplayOptions *opts;
>      Visitor *v;
> =20
> -    v =3D qobject_input_visitor_new_str(optarg, "type", &err);
> -    if (!v) {
> -        error_report_err(err);
> -        exit(1);
> -    }
> +    v =3D qobject_input_visitor_new_str(optarg, "type", &error_fatal);
> =20
>      visit_type_DisplayOptions(v, NULL, &opts, &error_fatal);
>      QAPI_CLONE_MEMBERS(DisplayOptions, &dpy, opts);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yYeq/WQYi/kuVVbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu72U4ACgkQbDjKyiDZ
s5IkbA/9Gg77/3a+2xuU04dTaJU8ukbj16gQBmirB2Sxxt6Nm8vkXMkHEPLWuz4U
6SFQxdHjGxqc4kQ5+2qW19TzJzT/g1h7GuDRY9LVCigfH2Ejx+5DoQTeBSdTyvwR
A7+VvlkOTQ8H2nBWHVEvqTDJHL2nJjvNm6EyfSnoyAAwCstyksd4HiRtrwOEoP+u
HTIxaxbHPDSMyhUJ5kebuGy2upHg6oCfKesGOxCzo0Ldqhh0F1UIrVIwjLsVs+VD
L34jCjooqsqEqLLcDJWbPzzVfJym4vkSekmV6/nt/EREfcCpgTBYftDvY9WWJ6SQ
/5zw3Si+W02Dwhh8zK6GJQKp5Uqsczc871VUhSUHFQexX3d5mXmkkBRBffKVeNl2
n0o8DhC/lZwZZJnYjPilo1O1ec572KjU5eE+2ZAptyE4ZGc6hXiRq8mmJn4YFGbg
kUmICOMmX200jdCUm59KEySkIq0ObfGMc8GKeUt3/HihNz8/UxdHv0Q7/qivriDa
IMNIHRA6Hj5wQv9Z6rJ1+dMhPsEbb8sPrrXv1HEq5N+1QnqH8KOK4/4F/cIxRAkj
fpw9BnsKzepCJgwFHYzAi23kE5a73iakRSdkjIjwXX5E6m/HhSjuNqpsYgDoIqWP
E0BxVd3EWrfFeKmYeS3JpxE0PLWykTEzEim6gc1wKZ5RK5g1F84=
=6Ru6
-----END PGP SIGNATURE-----

--yYeq/WQYi/kuVVbm--
