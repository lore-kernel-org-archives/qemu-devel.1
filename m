Received: from eggs.gnu.org ([2001:4830:134:3::10]:41090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dej2v-0008Iv-PJ
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dej2q-0001Xw-Jd
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:30:17 -0400
References: <20170807141630.105066-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a27b8cf-f149-cb7c-681d-f4f7249bfbd5@redhat.com>
Date: Mon, 7 Aug 2017 09:29:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170807141630.105066-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="H6GHjnRXcg5F6T32ij1MnVgjAcH15OPmK"
Subject: Re: [Qemu-devel] [PATCH for-2.10] iotests: fix 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H6GHjnRXcg5F6T32ij1MnVgjAcH15OPmK
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com
Message-ID: <9a27b8cf-f149-cb7c-681d-f4f7249bfbd5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] iotests: fix 185
References: <20170807141630.105066-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170807141630.105066-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 09:16 AM, Vladimir Sementsov-Ogievskiy wrote:
> 185 iotest is broken.
>=20
> How to test:
>> i=3D0; while ./check -qcow2 -nocache 185; do ((i+=3D1)); echo N =3D $i=
; \
>   done; echo N =3D $i
>=20
> finished for me like this:
>=20
> 185 2s ... - output mismatch (see 185.out.bad)
> --- /work/src/qemu/master/tests/qemu-iotests/185.out    2017-07-14 \
>     15:14:29.520343805 +0300
> +++ 185.out.bad 2017-08-07 16:51:02.231922900 +0300
> @@ -37,7 +37,7 @@
>  {"return": {}}
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, \
>      "event": "SHUTDOWN", "data": {"guest": false}}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, \
>     "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", \
>         "len": 4194304, "offset": 4194304, "speed": 65536, "type": \
>             "mirror"}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, \
>     "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", \
>         "len": 0, "offset": 0, "speed": 65536, "type": "mirror"}}

This diff says both 'len' and 'offset' differ...

>=20
>  =3D=3D=3D Start backup job and exit qemu =3D=3D=3D
>=20
> Failures: 185
> Failed 1 of 1 tests
> N =3D 8
>=20
> It doesn't seems logical to expect the constant offset on cancel,
> so let filter it out.

s/let/let's/

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/185     | 2 +-
>  tests/qemu-iotests/185.out | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "=
offset": 4194304, "speed": 65536, "type": "mirror"}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "=
offset": OFFSET, "speed": 65536, "type": "mirror"}}

=2E..while this diff only touched 'offset'.  Did you copy-and-paste
incorrectly in the commit message?  If so, then with the commit message
fixed, I'm okay with:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--H6GHjnRXcg5F6T32ij1MnVgjAcH15OPmK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmIeVkACgkQp6FrSiUn
Q2oxjggAkN/qYErW93RWALLxi+zMPJP+QvK26DYIj8mYQfwCYrQTf0Nc/TC+6Ebg
5UUti8A5K+ZI3Q75ZhU1/DRCIh0iJXxCu2d8SJ9HLWSyumwjncnCvCTY8JvssuIC
DlMIYOvbxj5Rr0w2aYLa/9Tf/XQKnh6kcxwfeg9uGZVztHflJOb23unFgtq0YXYR
Pmrdq/+G69/FME9NQrFkDMCpQjEV/UoxxHTp2hi5WYVYrIqPZDxKiW87q5X7HWh2
RfD/I15zkUmt5RLheKJ1Ii9tV6Zb+gcUiQNZVCU69qMbGmwk7m5wkaKrrpC4xLj4
3Hp+asl1UHZpMlejqyfOeLyyQCNNzw==
=a/01
-----END PGP SIGNATURE-----

--H6GHjnRXcg5F6T32ij1MnVgjAcH15OPmK--
