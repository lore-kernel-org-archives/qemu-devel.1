Received: from eggs.gnu.org ([2001:4830:134:3::10]:60085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR7hT-000255-2a
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 23:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR7hR-0006py-SF
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 23:04:27 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:57075)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fR7hR-0006kt-4y
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 23:04:25 -0400
Date: Fri, 8 Jun 2018 13:04:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608030405.GF3344@umbus.fritz.box>
References: <20180607144645.10187-1-f4bug@amsat.org>
	<20180607144645.10187-5-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
Content-Disposition: inline
In-Reply-To: <20180607144645.10187-5-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] device_tree: Replace
 error_setg(&error_fatal) by error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 11:46:45AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Use error_report() + exit() instead of error_setg(&error_fatal),
> as suggested by the "qapi/error.h" documentation:
>=20
>    Please don't error_setg(&error_fatal, ...), use error_report() and
>    exit(), because that's more obvious.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  device_tree.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/device_tree.c b/device_tree.c
> index 52c3358a55..3553819257 100644
> --- a/device_tree.c
> +++ b/device_tree.c
> @@ -140,15 +140,16 @@ static void read_fstree(void *fdt, const char *dirn=
ame)
>      const char *parent_node;
> =20
>      if (strstr(dirname, root_dir) !=3D dirname) {
> -        error_setg(&error_fatal, "%s: %s must be searched within %s",
> -                   __func__, dirname, root_dir);
> +        error_report("%s: %s must be searched within %s",
> +                     __func__, dirname, root_dir);
> +        exit(1);
>      }
>      parent_node =3D &dirname[strlen(SYSFS_DT_BASEDIR)];
> =20
>      d =3D opendir(dirname);
>      if (!d) {
> -        error_setg(&error_fatal, "%s cannot open %s", __func__, dirname);
> -        return;
> +        error_report("%s cannot open %s", __func__, dirname);
> +        exit(1);
>      }
> =20
>      while ((de =3D readdir(d)) !=3D NULL) {
> @@ -162,7 +163,8 @@ static void read_fstree(void *fdt, const char *dirnam=
e)
>          tmpnam =3D g_strdup_printf("%s/%s", dirname, de->d_name);
> =20
>          if (lstat(tmpnam, &st) < 0) {
> -            error_setg(&error_fatal, "%s cannot lstat %s", __func__, tmp=
nam);
> +            error_report("%s cannot lstat %s", __func__, tmpnam);
> +            exit(1);
>          }
> =20
>          if (S_ISREG(st.st_mode)) {
> @@ -170,8 +172,9 @@ static void read_fstree(void *fdt, const char *dirnam=
e)
>              gsize len;
> =20
>              if (!g_file_get_contents(tmpnam, &val, &len, NULL)) {
> -                error_setg(&error_fatal, "%s not able to extract info fr=
om %s",
> -                           __func__, tmpnam);
> +                error_report("%s not able to extract info from %s",
> +                             __func__, tmpnam);
> +                exit(1);
>              }
> =20
>              if (strlen(parent_node) > 0) {
> @@ -206,9 +209,9 @@ void *load_device_tree_from_sysfs(void)
>      host_fdt =3D create_device_tree(&host_fdt_size);
>      read_fstree(host_fdt, SYSFS_DT_BASEDIR);
>      if (fdt_check_header(host_fdt)) {
> -        error_setg(&error_fatal,
> -                   "%s host device tree extracted into memory is invalid=
",
> -                   __func__);
> +        error_report("%s host device tree extracted into memory is inval=
id",
> +                     __func__);
> +        exit(1);
>      }
>      return host_fdt;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsZ8iUACgkQbDjKyiDZ
s5LFXg//WYWG0OLEZ2Rtq/UWcXwi0X83jXTGjteW1tf3UwqiWIzD9heleVKVwMSz
+maAuH0O1jjsVOTZqzuG9mlAurkAG44FWswTpW8euf1sr0Qo6DeyaC3RDgGo3yLZ
IXmvxrv7KrE1nazZsFLEI2UHuFGLV+CpWEN0353Ce6CojAZI/ljAO2MD5VlPkqX1
Buhdn9qQINMva0aE4CmCVTP+Ki9nqYhUtyysjVrygPct4hCUbdYavBzFHZiZ21Ti
IVmJY4lNX3vej1YNPqfT/5f93MdnBo6OBcuPSgbZYAwd7tJVf7GQORYkebPV4wtL
BcZmMdNdlIgkh5Z3wwMfBYsycM5hhZuKSHAuAGs/AIvTmpzvYrFa//mvU/hAhsTV
+usu+5YwoWrKYdHrayJAU75CsYHzkGJiUPXoPQ6e6lIrJg5N63ydALSfZN1IeaYn
WiCUlclppIJ3yhKZ8gKlBL10Wtffn9CjfvNn4/j97ly6MVSN3+2HzE4Y8hsE2jsN
UCznR8tpsrLGsNyCbhd1tYatIKq1yeWkBPMnr459pS3AtK7efqlgFak2PPcYnhdZ
2Ygs1iKY51dKoAio/Ds+shWePCaI2/qDy3yMPGwoYDFjKZANEFV3P0ylBCj5GAfB
wiKUzAjJ3fpgktnK7nGVxQz+8m6/GlA7rnfAmH8iVBXaF3tOgSs=
=CQXT
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--
