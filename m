Received: from eggs.gnu.org ([2001:4830:134:3::10]:43892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5a5u-0001c2-6Q
	for Qemu-devel@nongnu.org; Tue, 02 May 2017 11:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5a5r-0007jO-2u
	for Qemu-devel@nongnu.org; Tue, 02 May 2017 11:52:06 -0400
References: <CAKVPjOY+sK5gnMGVX18VWk5sifnasPGeO61J_7zV12GZ_3nHrw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c9325e46-a7be-9213-76d0-c1c0a7519722@redhat.com>
Date: Tue, 2 May 2017 10:52:00 -0500
MIME-Version: 1.0
In-Reply-To: <CAKVPjOY+sK5gnMGVX18VWk5sifnasPGeO61J_7zV12GZ_3nHrw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Sx5BenxrmJU2dCb1duJQmFS2nSTVnCVuE"
Subject: Re: [Qemu-devel] [Qemu-block] migration: add incremental
 drive-mirror and blockdev-mirror with dirtymap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_Ku=c4=8dera?= <daniel.kucera@gmail.com>, qemu-block@nongnu.org, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sx5BenxrmJU2dCb1duJQmFS2nSTVnCVuE
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_Ku=c4=8dera?= <daniel.kucera@gmail.com>,
 qemu-block@nongnu.org, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>
Message-ID: <c9325e46-a7be-9213-76d0-c1c0a7519722@redhat.com>
Subject: Re: [Qemu-block] migration: add incremental drive-mirror and
 blockdev-mirror with dirtymap
References: <CAKVPjOY+sK5gnMGVX18VWk5sifnasPGeO61J_7zV12GZ_3nHrw@mail.gmail.com>
In-Reply-To: <CAKVPjOY+sK5gnMGVX18VWk5sifnasPGeO61J_7zV12GZ_3nHrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[qemu-devel added in cc]

On 05/02/2017 09:26 AM, Daniel Ku=C4=8Dera wrote:
> added parameter bitmap which will be used instead of newly created dirt=
ymap
> in mirror_start_job
>=20
> diff --git i/block/mirror.c w/block/mirror.c

All patches MUST be sent to qemu-devel@nongnu.org, in addition to
whatever other lists (including qemu-block, which you chose) are
specified by scripts/get_maintainer.pl.

Furthermore, ALL patches must have Signed-off-by: attribution that you
are legally able to submit the patch and agree to its proper licensing.
Without that, we can't take it.

Your patch is also missing diffstat information, which 'git
format-patch' includes by default, and which can quickly let readers
gauge the scope of your patch by the size of the changes to the files it
touches.

For more patch submission hints, see:
http://wiki.qemu.org/Contribute/SubmitAPatch


> +++ w/qapi/block-core.json
> @@ -1502,6 +1502,10 @@
>  #
>  # @speed:  the maximum speed, in bytes per second
>  #
> +# @bitmap: the name of dirty bitmap if sync is "incremental".
> +#          Must be present if sync is "incremental", must NOT be prese=
nt
> +#          otherwise. (Since 2.4)

Whoa - you've missed 2.4 by 5 releases.  Now that 2.9 is released, new
additions should be marked since 2.10.

> +#
>  # @sync: what parts of the disk image should be copied to the destinat=
ion
>  #        (all the disk, only the sectors allocated in the topmost imag=
e, or
>  #        only new I/O).
> @@ -1533,7 +1537,7 @@
>    'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
>              '*format': 'str', '*node-name': 'str', '*replaces': 'str',=

>              'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
> -            '*speed': 'int', '*granularity': 'uint32',
> +            '*speed': 'int', '*bitmap': 'str', '*granularity': 'uint32=
',
>              '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',=

>              '*on-target-error': 'BlockdevOnError',
>              '*unmap': 'bool' } }
> @@ -1652,6 +1656,10 @@
>  #
>  # @speed:  the maximum speed, in bytes per second
>  #
> +# @bitmap: the name of dirty bitmap if sync is "incremental".
> +#          Must be present if sync is "incremental", must NOT be prese=
nt
> +#          otherwise. (Since 2.4)

and again

> +#
>  # @sync: what parts of the disk image should be copied to the destinat=
ion
>  #        (all the disk, only the sectors allocated in the topmost imag=
e, or
>  #        only new I/O).
> @@ -1694,7 +1702,7 @@
>    'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
>              '*replaces': 'str',
>              'sync': 'MirrorSyncMode',
> -            '*speed': 'int', '*granularity': 'uint32',
> +            '*speed': 'int', '*bitmap': 'str', '*granularity': 'uint32=
',
>              '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',=

>              '*on-target-error': 'BlockdevOnError',
>              '*filter-node-name': 'str' } }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Sx5BenxrmJU2dCb1duJQmFS2nSTVnCVuE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCKsgAAoJEKeha0olJ0NqnccH/jXLVz9p2Q1iyccTn7epdyGZ
xcT+Awql3Pn0HxrehhzYQ92F8Li1f07LcJ8boZIPJ870UVEWNYVQbLbJ3O4SZx+C
8HlXa6aOY3gbZeADfdqCtugqOY9N8cFL0KHa/cDmeKh5uSCY5SW4b6dtty3TA32h
dTWSaNy8cNT2DlBstykPo6gIj7Jc/XQvDGMU4i8H/+g0pC+CqNeq7TF18VkpBdYZ
dmIddBgZ0tXK5loHExyGlxuAhr9H/dHoJ+MF+ZdyoMH5X6JTW8cKIIxsyYOvc1qz
CZ4lteNrCGQfYtpytMqd3Gm5KRJGLtL7pvCW/6oEd6l0ecuKHiMAkutRz7DZ9oU=
=oiGl
-----END PGP SIGNATURE-----

--Sx5BenxrmJU2dCb1duJQmFS2nSTVnCVuE--
