Received: from eggs.gnu.org ([2001:4830:134:3::10]:58116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceqd8-0000Ol-2e
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 17:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceqd6-0000N1-Pp
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 17:03:54 -0500
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-23-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e0e003dd-32d8-7ca2-813f-bd69a6eae9e2@redhat.com>
Date: Fri, 17 Feb 2017 16:03:44 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-23-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dMwjf96EJAOo1a1i88bTUeE3b6j4bDaXg"
Subject: Re: [Qemu-devel] [PATCH 22/24] util/cutils: Return qemu_strtosz*()
 error and value separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dMwjf96EJAOo1a1i88bTUeE3b6j4bDaXg
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <e0e003dd-32d8-7ca2-813f-bd69a6eae9e2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 22/24] util/cutils: Return qemu_strtosz*()
 error and value separately
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-23-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-23-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:26 AM, Markus Armbruster wrote:
> This makes qemu_strtosz(), qemu_strtosz_mebi() and
> qemu_strtosz_metric() similar to qemu_strtoi64(), except negative
> values are rejected.

Yay. It also opens the door to allowing them to return an unsigned 64
bit value ;)

>=20
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
> Cc: Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
> Cc: Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
> Cc: qemu-block@nongnu.org (open list:Block layer core)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> @@ -1378,8 +1378,8 @@ void hmp_migrate_set_parameter(Monitor *mon, cons=
t QDict *qdict)
>                  break;
>              case MIGRATION_PARAMETER_MAX_BANDWIDTH:
>                  p.has_max_bandwidth =3D true;
> -                valuebw =3D qemu_strtosz_mebi(valuestr, NULL);
> -                if (valuebw < 0 || (size_t)valuebw !=3D valuebw) {
> +                ret =3D qemu_strtosz_mebi(valuestr, NULL, &valuebw);
> +                if (ret < 0 || (size_t)valuebw !=3D valuebw) {

Question: do we want a wrapper that takes a maximum, as in:

ret =3D qemu_strtosz_capped(valuestr, NULL, 'M', SIZE_MAX, &valuebw);

so that the caller doesn't have to check (size_t)valuebw !=3D valuebw ?

But not essential, so I can live with what you did here.


> +++ b/qemu-img.c
> @@ -370,10 +370,14 @@ static int add_old_style_options(const char *fmt,=
 QemuOpts *opts,
> =20
>  static int64_t cvtnum(const char *s)

> +++ b/qemu-io-cmds.c
> @@ -137,10 +137,14 @@ static char **breakline(char *input, int *count)
> =20
>  static int64_t cvtnum(const char *s)

May be some fallout based on rebase churn from earlier patch reviews,
but nothing too serious to prevent you from adding:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--dMwjf96EJAOo1a1i88bTUeE3b6j4bDaXg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp3NAAAoJEKeha0olJ0NqnCEH/08bNvtgB8spzMiFfJ8E0vJK
lOxlcBVmdF4V7+QWSWJUZ+PMdoapaT4kWfP7tuIekrQemcZR+/yQK5LjHc/TBOTN
fCZrbqj1uUT0MQwj4Gk3PiOQC2sK1nrg/ZFvX3D67d0uJoD+TKmhwVnCza8mO+nF
0LO8U88AQ9ShiHCju1mglcBBcxyWGdjhrbrZD5vsoEFLBzS7zw1nDXMBYuRzGkju
4rbsmgWn0S13opyZNUDd0PYuwMoFEXml4dTjSg2i1itft8nrAZsaxu9A9ccyFf++
2002shHf6grSdOnpixnkJ+6d5HhKWaLFKe5Cy1PQVCFvu0zEYH4tZRXeuwavdS8=
=Tgmj
-----END PGP SIGNATURE-----

--dMwjf96EJAOo1a1i88bTUeE3b6j4bDaXg--
