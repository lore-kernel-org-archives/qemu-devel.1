Received: from eggs.gnu.org ([209.51.188.92]:47953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghhIg-0007Vs-A2
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghhIf-0007PU-6K
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:51:38 -0500
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <acf4d082-dabd-55ec-4435-da3e93b6c4ab@redhat.com>
Date: Thu, 10 Jan 2019 14:51:27 -0600
MIME-Version: 1.0
In-Reply-To: <20190110132048.49451-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rGOrE4NyoQvnrfnsHa0ovug1yHN1cCp6C"
Subject: Re: [Qemu-devel] [PATCH] block: don't probe zeroes in bs->file by
 default on block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rGOrE4NyoQvnrfnsHa0ovug1yHN1cCp6C
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, fam@euphon.net, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <acf4d082-dabd-55ec-4435-da3e93b6c4ab@redhat.com>
Subject: Re: [PATCH] block: don't probe zeroes in bs->file by default on
 block_status
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190110132048.49451-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/10/19 7:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> drv_co_block_status digs bs->file for additional, more accurate search
> for hole inside region, reported as DATA by bs since 5daa74a6ebc.

s/region, reported/regions reported/

>=20
> This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
> knows, where are holes and where is data. But every block_status

Not quite true. qcow2 knows where some holes are, but does not know if
there are even more holes hiding in the sections marked data (such as
because of how the disk was pre-allocated).

> request calls lseek additionally. Assume a big disk, full of
> data, in any iterative copying block job (or img convert) we'll call
> lseek(HOLE) on every iteration, and each of these lseeks will have to
> iterate through all metadata up to the end of file. It's obviously
> ineffective behavior. And for many scenarios we don't need this lseek
> at all.

How much performance can we buy back without any knobs at all, if we
just taught posix-file.c to cache lseek() results?  That is, when
visiting a file sequentially, if lseek(fd, 0, SEEK_HOLE) returns EOF on
our first block status query, then all subsequent block status queries
fall within what we know to be data, and we can skip the lseek() calls.

>=20
> So, let's "5daa74a6ebc" by default, leaving an option to return

s/let's/let's undo/

> previous behavior, which is needed for scenarios with preallocated
> images.
>=20
> Add iotest illustrating new option semantics.

And none of the existing iotests fail due to changed output?  Does that
mean our testsuite does not have good coverage of pre-allocation modes
where the zero probe mattered?

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20

> +++ b/qapi/block-core.json
> @@ -3673,6 +3673,8 @@
>  #                 (default: off)
>  # @force-share:   force share all permission on added nodes.
>  #                 Requires read-only=3Dtrue. (Since 2.10)
> +# @probe-zeroes:  Probe zeroes on protocol layer if format reports dat=
a
> +#                 (default: false) (since 4.0)

Why do we need a new bool?  Can we instead...

>  #
>  # Remaining options are determined by the block driver.
>  #
> @@ -3686,7 +3688,8 @@
>              '*read-only': 'bool',
>              '*auto-read-only': 'bool',
>              '*force-share': 'bool',
> -            '*detect-zeroes': 'BlockdevDetectZeroesOptions' },
> +            '*detect-zeroes': 'BlockdevDetectZeroesOptions',
> +            '*probe-zeroes': 'bool' },

=2E..add another enum value to 'detect-zeroes', since after all, what we
are really doing is fine-tuning what level of zero probing we are
willing to do?


> +++ b/qemu-options.hx
> @@ -615,6 +615,7 @@ DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
>      "-blockdev [driver=3D]driver[,node-name=3DN][,discard=3Dignore|unm=
ap]\n"
>      "          [,cache.direct=3Don|off][,cache.no-flush=3Don|off]\n"
>      "          [,read-only=3Don|off][,detect-zeroes=3Don|off|unmap]\n"=

> +    "          [,probe-zeroes=3Don|off]\n"
>      "          [,driver specific parameters...]\n"
>      "                configure a block backend\n", QEMU_ARCH_ALL)
>  STEXI
> @@ -670,6 +671,8 @@ discard requests.
>  conversion of plain zero writes by the OS to driver specific optimized=

>  zero write commands. You may even choose "unmap" if @var{discard} is s=
et
>  to "unmap" to allow a zero write to be converted to an @code{unmap} op=
eration.
> +@item probe-zeroes=3D@var{probe-zeroes}
> +Probe zeroes on protocol layer if format reports data. Default is "off=
".

Again, fitting this into detect-zeroes seems better than inventing a new
knob.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--rGOrE4NyoQvnrfnsHa0ovug1yHN1cCp6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw3sE8ACgkQp6FrSiUn
Q2ovugf+OulvLz5CARWfzl46sxE9Mi5PR6ZPajlfYeNN1NaNpIIPbjrSqa/n1kf4
VI2JYXM7o+RZRAh6hm2Bdtlp6NqdM/DAvDQv6VdqmiU39gufXOcrlHvSJcgztjrk
1vJxz0m/RYFgsX2vTwxk1hO9jdxiUQFEZ1WM7UePemE+M8Kf6uPCY3LJ7TNxBLUG
/AGywTRZhey7MbuWSOkc62PFpcQhOZOSyrYrkr7I7A/Q7kNi704PEOkEwCvjpYwb
aYU17RTcZNl//+SL4NpvIi22YyzUkYEBMBdVLizKy+MpP3AgclOoyGjzFHfiWCJ3
4OBToXc6pR87WkIL2ciemZtKXPsVbA==
=GwlN
-----END PGP SIGNATURE-----

--rGOrE4NyoQvnrfnsHa0ovug1yHN1cCp6C--
