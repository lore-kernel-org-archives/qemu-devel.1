Received: from eggs.gnu.org ([2001:4830:134:3::10]:43880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciSYZ-00016J-FU
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 16:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciSYX-0003G9-L4
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 16:10:06 -0500
References: <1488193394-28453-1-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <07ef9e24-a17b-536b-8ef3-9a105cfe6bc6@redhat.com>
Date: Mon, 27 Feb 2017 15:09:57 -0600
MIME-Version: 1.0
In-Reply-To: <1488193394-28453-1-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q4hkm1wfmdBWvHiVviUCs8ttrqUJmeqt2"
Subject: Re: [Qemu-devel] [PATCH V2] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@gmail.com, ct@flyingcircus.io, mreitz@redhat.com, famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q4hkm1wfmdBWvHiVviUCs8ttrqUJmeqt2
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, stefanha@gmail.com,
 ct@flyingcircus.io, mreitz@redhat.com, famz@redhat.com
Message-ID: <07ef9e24-a17b-536b-8ef3-9a105cfe6bc6@redhat.com>
Subject: Re: [PATCH V2] qemu-img: make convert async
References: <1488193394-28453-1-git-send-email-pl@kamp.de>
In-Reply-To: <1488193394-28453-1-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 05:03 AM, Peter Lieven wrote:
> the convert process is currently completely implemented with sync opera=
tions.
> That means it reads one buffer and then writes it. No parallelism and e=
ach sync
> request takes as long as it takes until it is completed.
>=20

>=20
> This patches introduces 2 new cmdline parameters. The -m parameter to s=
pecify
> the number of coroutines running in parallel (defaults to 8). And the -=
W paremeter to

s/paremeter/parameter/

> allow qemu-img to write to the target out of order rather than sequenti=
al. This improves
> performance as the writes do not have to wait for each other to complet=
e.
>=20
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---

> @@ -1798,7 +1908,7 @@ static int img_convert(int argc, char **argv)
>              {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
>              {0, 0, 0, 0}
>          };
> -        c =3D getopt_long(argc, argv, "hf:O:B:ce6o:s:l:S:pt:T:qn",
> +        c =3D getopt_long(argc, argv, "hf:O:B:ce6o:s:l:S:pt:T:qnm:W",
>                          long_options, NULL);
>          if (c =3D=3D -1) {
>              break;
> @@ -1890,6 +2000,18 @@ static int img_convert(int argc, char **argv)
>          case 'n':
>              skip_create =3D 1;
>              break;
> +        case 'm':
> +            num_coroutines =3D atoi(optarg);

atoi() should be avoided. It has no error checking, so it treats '-m 1'
and '-m 1k' identically.  You are a bit justified in that '-m junk' gets
treated like '-m 0' and rejected, but it's still a poor error message in
that case.

> +            if (num_coroutines < 1 || num_coroutines > MAX_COROUTINES)=
 {
> +                error_report("Allowed number of coroutines is between =
1 and %d",
> +                             MAX_COROUTINES);

> +++ b/qemu-img.texi
> @@ -137,6 +137,12 @@ Parameters to convert subcommand:
> =20
>  @item -n
>  Skip the creation of the target volume
> +@item -m
> +Number of parallel coroutines for the convert process
> +@item -W
> +Allow to write out of order to the destination. This is option improve=
s performance,

Grammar suggestion:

Allow out-of-order writes to the destination.  This option ...

> +but is only recommened for preallocated devices like host devices or o=
ther

s/recommened/recommended/

> +raw block devices.
>  @end table
> =20


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Q4hkm1wfmdBWvHiVviUCs8ttrqUJmeqt2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtJWlAAoJEKeha0olJ0Nq+ZIH/RTee8W/bLr76IX16icFq9vA
uhkz2dx1C0vUZr9oUprRbttKo70tg0w7j3AxEFMSiXX+bvsUAsdc+iB4T6pgZ0V9
93FqTzvXTOjDORd7eabEO61ZK8NKvW5t9LAMRySCJl9ar59PB4gbezDx3CWJ8Iwt
4hP5joSKcDsGKM5bigJVRIAIOe97k8leYBCqGCESfrfsctHYm11wus0uEGMTcKEq
0rqN6fDrapa90+wpr/gV4+IZUEdppuLjZMxZYWdkVmBY6eWXGQ740U0hiW2Yh2VH
cnQpsdnzO18Wo1TFcpw6pPIKojgKKWGsBuB/L+86Nw+JTle/7p25mKXrQ4n6oFI=
=OoOt
-----END PGP SIGNATURE-----

--Q4hkm1wfmdBWvHiVviUCs8ttrqUJmeqt2--
