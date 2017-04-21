Received: from eggs.gnu.org ([2001:4830:134:3::10]:53459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1Yzz-0001zD-5o
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1Yzy-00042V-26
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:53:23 -0400
References: <1492814072-4276-1-git-send-email-li.ping288@zte.com.cn>
From: Eric Blake <eblake@redhat.com>
Message-ID: <20a2f85e-3d26-a5f5-7bc6-e5e102a8bbc6@redhat.com>
Date: Fri, 21 Apr 2017 08:53:12 -0500
MIME-Version: 1.0
In-Reply-To: <1492814072-4276-1-git-send-email-li.ping288@zte.com.cn>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LWqUEjv6inR7ixI1ovpo194TUCkHsS2Ju"
Subject: Re: [Qemu-devel] [PATCH] Block layer core: Fix qemu-img 'amend'
 subcommand failure of adjusting backing file in different path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ping Li <li.ping288@zte.com.cn>, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LWqUEjv6inR7ixI1ovpo194TUCkHsS2Ju
From: Eric Blake <eblake@redhat.com>
To: Ping Li <li.ping288@zte.com.cn>, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <20a2f85e-3d26-a5f5-7bc6-e5e102a8bbc6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Block layer core: Fix qemu-img 'amend'
 subcommand failure of adjusting backing file in different path
References: <1492814072-4276-1-git-send-email-li.ping288@zte.com.cn>
In-Reply-To: <1492814072-4276-1-git-send-email-li.ping288@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/21/2017 05:34 PM, Ping Li wrote:

Subject line is too long.  Better would be:

block: Fix qemu-img amend failure

Your system clock is WAAY off.  According to headers:

> Received: from notes_smtp.zte.com.cn ([10.30.1.239])
> 	by mse01.zte.com.cn with ESMTP id v3L6FjYn087324;
> 	Fri, 21 Apr 2017 14:15:45 +0800 (GMT-8)
> 	(envelope-from li.ping288@zte.com.cn)
> Received: from localhost.localdomain ([10.74.120.79])
> 	by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
> 	with ESMTP id 2017042114155070-1062351 ;
> 	Fri, 21 Apr 2017 14:15:50 +0800=20
> From: Ping Li <li.ping288@zte.com.cn>
> To: kwolf@redhat.com, mreitz@redhat.com
> Date: Sat, 22 Apr 2017 06:34:32 +0800

you sent this at 22:34 UTC, but the next hop in the chain received it at
6:15 UTC (16 hours earlier!).  Incorrect timestamps mess with mail
clients that like to sort threads based on time of most recent activity.


> Currently, qemu-img 'amend' subcommand would fail to adjust image's bac=
king file
> which was moved into different path.
> For example, parent.qcow2, the backing file of leaf.qcow2, first is at =
/home/a/,
> then moved into /home/b/. Originally this command,
>  "qemu-img amend -f qcow2 -o backing_fmt=3Dqcow2,backing_file=3D/home/b=
/parent.qcow2 leaf.qcow2",
>  would fail because qemu-img failed to open the old backing file of lea=
f.qcow2.
> Give the 'amend' subcommand a '-u' option to not open the old backing f=
ile
>  while openning leaf.qcow2.

s/openning/opening/

>=20
> Signed-off-by: Li Ping<li.ping288@zte.com.cn>

Space before < is typical in git credits.

> ---
>  qemu-img.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20

General question before getting into the review - do we really need
amend -u, or should this behavior be automatic (that is, why do we need
access to the old backing image in the first place - can't we get along
with ONLY access to the new backing image always, when the amend options
include an update to the backing image)?

> diff --git a/qemu-img.c b/qemu-img.c
> index b220cf7..a32e9d6 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -145,9 +145,10 @@ static void QEMU_NORETURN help(void)
>             "  'snapshot_id_or_name' is deprecated, use 'snapshot_param=
'\n"
>             "    instead\n"
>             "  '-c' indicates that target image must be compressed (qco=
w format only)\n"
> -           "  '-u' enables unsafe rebasing. It is assumed that old and=
 new backing file\n"
> -           "       match exactly. The image doesn't need a working bac=
king file before\n"
> -           "       rebasing in this case (useful for renaming the back=
ing file)\n"
> +           "  '-u' enables unsafe rebasing or amending. It is assumed =
that old and new\n"
> +           "       backing file match exactly. For rebasing, the image=
 doesn't need a working\n"
> +           "       backing file before rebasing in this case(useful fo=
r renaming the backing file).\n"

Space before ( in English.

> +           "       For amending, it doesn't open backing file(useful f=
or moving images)\n"

and again

>             "  '-h' with or without a command shows this help and lists=
 the supported formats\n"
>             "  '-p' show progress of command (only certain commands)\n"=

>             "  '-q' use Quiet mode - do not print any output (except er=
rors)\n"
> @@ -3538,7 +3539,7 @@ static int img_amend(int argc, char **argv)
>      QemuOptsList *create_opts =3D NULL;
>      QemuOpts *opts =3D NULL;
>      const char *fmt =3D NULL, *filename, *cache;
> -    int flags;
> +    int flags =3D 0;
>      bool writethrough;
>      bool quiet =3D false, progress =3D false;
>      BlockBackend *blk =3D NULL;
> @@ -3553,7 +3554,7 @@ static int img_amend(int argc, char **argv)
>              {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
>              {0, 0, 0, 0}
>          };
> -        c =3D getopt_long(argc, argv, ":ho:f:t:pq",
> +        c =3D getopt_long(argc, argv, ":ho:f:t:pqu",
>                          long_options, NULL);
>          if (c =3D=3D -1) {
>              break;
> @@ -3595,6 +3596,9 @@ static int img_amend(int argc, char **argv)
>          case 'q':
>              quiet =3D true;
>              break;
> +        case 'u':
> +            flags |=3D BDRV_O_NO_BACKING;

Does this really do what we want? When amending an image, our choice of
whether to expand a cluster to all zeroes depends heavily on qcow2
version AND whether there is a backing file; will this flag make us do
the wrong thing when converting a v3 image back to v2?

> +            break;
>          case OPTION_OBJECT:
>              opts =3D qemu_opts_parse_noisily(&qemu_object_opts,
>                                             optarg, true);
> @@ -3639,7 +3643,7 @@ static int img_amend(int argc, char **argv)
>          goto out;
>      }
> =20
> -    flags =3D BDRV_O_RDWR;
> +    flags |=3D BDRV_O_RDWR;
>      ret =3D bdrv_parse_cache_mode(cache, &flags, &writethrough);
>      if (ret < 0) {
>          error_report("Invalid cache option: %s", cache);
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LWqUEjv6inR7ixI1ovpo194TUCkHsS2Ju
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+g7IAAoJEKeha0olJ0Nql0YH/j01jwEmcpUdXGB/I+vMPmOp
SEMRhD78yrvJunnh66g4o7d/VLnEsHmStOWlYpOVP5fm7mcSbxsAOdQiHAWeKpCR
ess6zbmFVJDqR6Ez3P9sHRtD7A7Syy55CK5OGVzZeeDMAko2W1AVJzq+vK91qCXv
N0bLT0/XAQE9q2ULFPK2ufiWfrXqsl/1zKCK0jvJW5Cjb0dskhYLLsRgcr5G8Vx1
FbXPuMMIv0DkEAEJqPOxBbNFWyM/l638uNCNARc6jWeGccDiGcFWC2UUmxtXnR3m
PU/3YvfSAmSaklSCbxnHzBK+Ymthio7/9hk3iSpo4LbwRt5qpAvaMQVzdVna9M8=
=EJKj
-----END PGP SIGNATURE-----

--LWqUEjv6inR7ixI1ovpo194TUCkHsS2Ju--
