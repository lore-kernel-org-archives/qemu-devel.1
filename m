Received: from eggs.gnu.org ([2001:4830:134:3::10]:57804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC4AD-0003ge-O6
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gC4A8-0005NO-KW
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:48:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gC4A8-0005Mj-BH
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 10:48:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A94788314
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 14:48:03 +0000 (UTC)
References: <20181015115309.17089-1-armbru@redhat.com>
	<20181015115309.17089-34-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <31daa4d5-96bf-ac50-7a3d-e503b13c9872@redhat.com>
Date: Mon, 15 Oct 2018 16:48:00 +0200
MIME-Version: 1.0
In-Reply-To: <20181015115309.17089-34-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9ej0UiAvQFpHewAX1Pzrq3SPiFr31yiZY"
Subject: Re: [Qemu-devel] [PATCH v2 33/35] blockdev: Convert drive_new() to
 Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9ej0UiAvQFpHewAX1Pzrq3SPiFr31yiZY
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>
Message-ID: <31daa4d5-96bf-ac50-7a3d-e503b13c9872@redhat.com>
Subject: Re: [PATCH v2 33/35] blockdev: Convert drive_new() to Error
References: <20181015115309.17089-1-armbru@redhat.com>
 <20181015115309.17089-34-armbru@redhat.com>
In-Reply-To: <20181015115309.17089-34-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.10.18 13:53, Markus Armbruster wrote:
> Calling error_report() from within a function that takes an Error **
> argument is suspicious.  drive_new() calls error_report() even though
> it can run within drive_init_func(), which takes an Error ** argument.
> drive_init_func()'s caller main(), via qemu_opts_foreach(), is fine
> with it, but clean it up anyway:
>=20
> * Convert drive_new() to Error
>=20
> * Update add_init_drive() to report the error received from
>   drive_new()
>=20
> * Make main() pass &error_fatal through qemu_opts_foreach(),
>   drive_init_func() to drive_new()
>=20
> * Make default_drive() pass &error_abort through qemu_opts_foreach(),
>   drive_init_func() to drive_new()
>=20
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  blockdev.c                | 27 ++++++++++++++-------------
>  device-hotplug.c          |  5 ++++-
>  include/sysemu/blockdev.h |  3 ++-
>  vl.c                      |  8 ++++----
>  4 files changed, 24 insertions(+), 19 deletions(-)

[...]

> diff --git a/vl.c b/vl.c
> index 65366b961e..22beca29d1 100644
> --- a/vl.c
> +++ b/vl.c

[...]
> @@ -4396,7 +4395,8 @@ int main(int argc, char **argv, char **envp)
>                            NULL, NULL);
>      }
>      if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
> -                          &machine_class->block_default_type, NULL)) {=

> +                          &machine_class->block_default_type, &error_f=
atal)) {
> +        /* We printed help */
>          exit(1);
>      }

I thought you wanted it to become an exit(0)?  I don't care either way,
though, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--9ej0UiAvQFpHewAX1Pzrq3SPiFr31yiZY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvEqKAACgkQ9AfbAGHV
z0DtPAf7BPZdddUWbLsfYx2O2CZu+iF5fomMS125bmkjBi49Vg7FtpgcfvUo9sb8
4werqMnjIeOgOJXoGyC5w9Leu3saePJvH3HS+/ydmAn6j2NKiYnLPfnHYhGhVl0a
+tXxTmrGk/wTskbTJ3Uzon5UwN+u7NimEya7p9KC08t9nLFi0RIwoQyoIp+Nuouz
42D6A+aqqma7oiep1Bh5RVEgAghefiw/UXVkXupiywczIDGgfAXBYM8QS0JvFqt/
JTF8UGu+3WAJNa53TFNC3X/09nzDehmf2LsC/t2BRr6ql51JYCSa/nLUQC8yvG7H
xZJb2wBi7KXAGVbbohCHqsQ2AwNJrQ==
=Ha1D
-----END PGP SIGNATURE-----

--9ej0UiAvQFpHewAX1Pzrq3SPiFr31yiZY--
