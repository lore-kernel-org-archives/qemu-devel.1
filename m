Received: from eggs.gnu.org ([2001:4830:134:3::10]:56377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN1f8-0000LE-7y
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 14:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN1f7-0005xE-7z
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 14:16:50 -0500
References: <20171207170834.15843-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <83722fb4-2458-fc9c-ddfe-6b7e7b65ca46@redhat.com>
Date: Thu, 7 Dec 2017 13:16:41 -0600
MIME-Version: 1.0
In-Reply-To: <20171207170834.15843-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xtJsthM05Hs1TdwBvKCJb0mvP5MkorvBH"
Subject: Re: [Qemu-devel] [PATCH] iotests: Tweak 030 in order to trigger a
 race condition with parallel jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xtJsthM05Hs1TdwBvKCJb0mvP5MkorvBH
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <83722fb4-2458-fc9c-ddfe-6b7e7b65ca46@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Tweak 030 in order to trigger a
 race condition with parallel jobs
References: <20171207170834.15843-1-berto@igalia.com>
In-Reply-To: <20171207170834.15843-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 11:08 AM, Alberto Garcia wrote:
> This patch tweaks TestParallelOps in iotest 030 so it allocates data
> in smaller regions (256KB/512KB instead of 512KB/1MB) and the
> block-stream job in test_stream_commit() only needs to copy data that
> is at the very end of the image.
>=20
> This way when the block-stream job is waken up it will finish right

s/waken up/awakened/

> away without any chance of being stopped by block_job_sleep_ns(). This
> triggers the bug that was fixed by 3d5d319e1221082974711af1d09d82f07
> and is therefore a more useful test case for parallel block jobs.
>=20
> After this patch the aforementiond bug can also be reproduced with the
> test_stream_parallel() test case.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/030 | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20

>          # Put data into the images we are copying data from
>          for i in range(self.num_imgs / 2):
> -            img_index =3D i * 2 + 1
> -            # Alternate between 512k and 1M.
> +            img_index =3D self.num_imgs - i * 2 - 2
> +            # Alternate between 256KB and 512KB.
>              # This way jobs will not finish in the same order they wer=
e created
> -            num_kb =3D 512 + 512 * (i % 2)
> +            num_kb =3D 256 + 256 * (i % 2)
>              qemu_io('-f', iotests.imgfmt,
> -                    '-c', 'write -P %d %d %d' % (i, i*1024*1024, num_k=
b * 1024),
> +                    '-c', 'write -P 0xFF %dk %dk' % (i * 512, num_kb),=


I guess changing from a variable to a fixed 0xff pattern doesn't make a
difference?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xtJsthM05Hs1TdwBvKCJb0mvP5MkorvBH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlopk5kACgkQp6FrSiUn
Q2oZNQf/f3sZ008qIeFH3xTObGXoIg2V33UP4nmFyCzDrFiPCdk3f7zjdKy0tJJ+
qVzLlFAexvBQIkRqfnCjTOyoQkQjxPR16BCH5YX03HkGowhhR2LEYKlEnB5Oe135
VO5aaugQ+XaDHhqfuopOmcM7Uk+h42rDqfpwerQBfQzT2BtPfvCqH5wOcolK6fOB
PKmW+hzINY7gLP6ip+3vqVMhipMM0rnAiW9KxjV0vk4WUXbQ3Ka5eQWD2DCd9sOI
zeneJYrtR2bUQznqp29n5mzhwF2xYM+6jr+iguaRTqCa4ugsB3YdDOaafQc5gyEG
I2b7m8WpZQlo29BLXXfB9tY0f+kRSA==
=1q1O
-----END PGP SIGNATURE-----

--xtJsthM05Hs1TdwBvKCJb0mvP5MkorvBH--
