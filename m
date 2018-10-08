Received: from eggs.gnu.org ([2001:4830:134:3::10]:58225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9d4P-000559-0E
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9cz2-0008FK-DK
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1g9cz0-0008Aw-LZ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9427188E52
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 21:22:22 +0000 (UTC)
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-31-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a93edd67-8c1a-bb2d-7b52-db46b1e2abbd@redhat.com>
Date: Mon, 8 Oct 2018 23:22:19 +0200
MIME-Version: 1.0
In-Reply-To: <20181008173125.19678-31-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zgWoOEsp7jv5zl915KaCgs6RL8Wi2EuOZ"
Subject: Re: [Qemu-devel] [PATCH 30/31] blockdev: Convert drive_new() to
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
--zgWoOEsp7jv5zl915KaCgs6RL8Wi2EuOZ
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>
Message-ID: <a93edd67-8c1a-bb2d-7b52-db46b1e2abbd@redhat.com>
Subject: Re: [PATCH 30/31] blockdev: Convert drive_new() to Error
References: <20181008173125.19678-1-armbru@redhat.com>
 <20181008173125.19678-31-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-31-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.10.18 19:31, Markus Armbruster wrote:
> Calling error_report() from within a a function that takes an Error **
> argument is suspicious.  drive_new() does that, and its caller
> drive_init_func() then exit()s.

I'm afraid I don't quite follow you here.  There is no function here
that takes an Error ** already and then calls error_report().  There is
however drive_new() that does not take an Error **, consequentially
calls error_report(), and there is its caller drive_init_func() which
does take an Error ** but does not set it.

So while I fully agree with you to make drive_new() take an Error **
(and thus effectively fix drive_init_func()), I don't quite understand
this explanation.

(Furthermore, drive_init_func() does not exit().  It's main() that
exit()s after calling drive_init_func().)

> Its caller main(), via
> qemu_opts_foreach(), is fine with it, but clean it up anyway:
>=20
> * Convert drive_new() to Error
>=20
> * Update add_init_drive() to report the error received from
>   drive_new().
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
>  vl.c                      | 11 ++++-------
>  4 files changed, 24 insertions(+), 22 deletions(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index a8755bd908..574adbcb7f 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -759,7 +759,8 @@ QemuOptsList qemu_legacy_drive_opts =3D {

[...]

> @@ -991,7 +992,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInter=
faceType block_default_type)
>      bs_opts =3D NULL;
>      if (!blk) {
>          if (local_err) {
> -            error_report_err(local_err);
> +            error_propagate(errp, local_err);
>          }

Wait, what would be the case where blockdev_init() returns NULL but
*errp remains unse=E2=80=94=E2=80=94=E2=80=94 oh no.

There is only one case which is someone specified "format=3Dhelp".  Hm.  =
I
suppose you are as unhappy as me about the fact that because of this
drive_new() cannot guarantee that *errp is set in case of an error.

I think it's ""fine"" (*gnashing teeth*) to keep it this way, but it
means that callers need to continue to check the return value and not
*errp alone.

>          goto fail;
>      } else {
> diff --git a/device-hotplug.c b/device-hotplug.c
> index cd427e2c76..6090d5f1e9 100644
> --- a/device-hotplug.c
> +++ b/device-hotplug.c
> @@ -28,6 +28,7 @@
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
>  #include "qapi/qmp/qdict.h"
> +#include "qapi/error.h"
>  #include "qemu/config-file.h"
>  #include "qemu/option.h"
>  #include "sysemu/sysemu.h"
> @@ -36,6 +37,7 @@
> =20
>  static DriveInfo *add_init_drive(const char *optstr)
>  {
> +    Error *err =3D NULL;
>      DriveInfo *dinfo;
>      QemuOpts *opts;
>      MachineClass *mc;
> @@ -45,8 +47,9 @@ static DriveInfo *add_init_drive(const char *optstr)
>          return NULL;
> =20
>      mc =3D MACHINE_GET_CLASS(current_machine);
> -    dinfo =3D drive_new(opts, mc->block_default_type);
> +    dinfo =3D drive_new(opts, mc->block_default_type, &err);
>      if (!dinfo) {
> +        error_report_err(err);
>          qemu_opts_del(opts);
>          return NULL;
>      }
> diff --git a/include/sysemu/blockdev.h b/include/sysemu/blockdev.h
> index 24954b94e0..d34c4920dc 100644
> --- a/include/sysemu/blockdev.h
> +++ b/include/sysemu/blockdev.h
> @@ -54,7 +54,8 @@ DriveInfo *drive_get_next(BlockInterfaceType type);
>  QemuOpts *drive_def(const char *optstr);
>  QemuOpts *drive_add(BlockInterfaceType type, int index, const char *fi=
le,
>                      const char *optstr);
> -DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_t=
ype);
> +DriveInfo *drive_new(QemuOpts *arg, BlockInterfaceType block_default_t=
ype,
> +                     Error **errp);
> =20
>  /* device-hotplug */
> =20
> diff --git a/vl.c b/vl.c
> index 0d25956b2f..101e0123d9 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1129,7 +1129,7 @@ static int drive_init_func(void *opaque, QemuOpts=
 *opts, Error **errp)
>  {
>      BlockInterfaceType *block_default_type =3D opaque;
> =20
> -    return drive_new(opts, *block_default_type) =3D=3D NULL;
> +    return drive_new(opts, *block_default_type, errp) =3D=3D NULL;
>  }
> =20
>  static int drive_enable_snapshot(void *opaque, QemuOpts *opts, Error *=
*errp)
> @@ -1155,8 +1155,7 @@ static void default_drive(int enable, int snapsho=
t, BlockInterfaceType type,
>          drive_enable_snapshot(NULL, opts, NULL);
>      }
> =20
> -    dinfo =3D drive_new(opts, type);
> -    assert(dinfo);
> +    dinfo =3D drive_new(opts, type, &error_abort);

Which means the assertion is still necessary here.

>      dinfo->is_default =3D true;
> =20
>  }
> @@ -4348,10 +4347,8 @@ int main(int argc, char **argv, char **envp)
>          qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapsh=
ot,
>                            NULL, NULL);
>      }
> -    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
> -                          &machine_class->block_default_type, NULL)) {=

> -        exit(1);
> -    }
> +    qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
> +                      &machine_class->block_default_type, &error_fatal=
);

And we still have to keep an exit() here.

Alternative: You transform blockdev_init()'s format=3Dhelp into an error
(or construct a new error in drive_new() if blockdev_init() returned
NULL but no error).

Max

> =20
>      default_drive(default_cdrom, snapshot, machine_class->block_defaul=
t_type, 2,
>                    CDROM_OPTS);
>=20



--zgWoOEsp7jv5zl915KaCgs6RL8Wi2EuOZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu7yosACgkQ9AfbAGHV
z0Ayxwf/S+fwWJJ8iyCn922FGFKEGtzLdzFtdjMRTBgdO2x+Zw0mT14d2p0Jv7sU
XaOMVCAuoJwehxpinAJvK559krlz0A/JTvaxqURiSE37jCPX2X/rpXirSfD0lFpe
4+wbrDHyfbrJ8eNaOKi63uacQqhUFJSlBw0MaDn9IfA86qPmvEiGw0N/ED8olLGc
hEGgz02el3xaJxooEdZCM1Zr4Tcfxc51sxDBf/L1+45lSVcoFYuBXhBCJXawjRic
YJ2jjJfp3mKSJd1hoHyHx6W447iIk+inHkura80288YBdZu7iEUZTfUWG9s/u6WF
x7tRrYcfcHNj4VMW7q5axsvq1NJk5g==
=GuV/
-----END PGP SIGNATURE-----

--zgWoOEsp7jv5zl915KaCgs6RL8Wi2EuOZ--
