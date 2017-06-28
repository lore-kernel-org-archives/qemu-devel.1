Received: from eggs.gnu.org ([2001:4830:134:3::10]:35305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQDKF-0007tP-3H
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dQDKE-0003mM-DP
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:48:11 -0400
Date: Wed, 28 Jun 2017 16:47:24 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170628134724.hubz7bd6es35kqwm@postretch>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-7-el13635@mail.ntua.gr>
	<w51efu41b5a.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jof2sn43pty5k3sh"
Content-Disposition: inline
In-Reply-To: <w51efu41b5a.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 6/8] block: add options parameter to
 bdrv_new_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--jof2sn43pty5k3sh
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline

On Wed, Jun 28, 2017 at 03:42:41PM +0200, Alberto Garcia wrote:
>On Fri 23 Jun 2017 02:46:58 PM CEST, Manos Pitsidianakis wrote:
>>  BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *node_name,
>> -                                       int flags, Error **errp)
>> +                                       int flags, QDict *options, Error **errp)
>>  {
>>      BlockDriverState *bs;
>>      int ret;
>>
>>      bs = bdrv_new();
>>      bs->open_flags = flags;
>> -    bs->explicit_options = qdict_new();
>> -    bs->options = qdict_new();
>> +    if (options) {
>> +        bs->explicit_options = qdict_clone_shallow(options);
>> +        bs->options = qdict_clone_shallow(options);
>> +    } else {
>> +        bs->explicit_options = qdict_new();
>> +        bs->options = qdict_new();
>> +    }
>>      bs->opaque = NULL;
>>
>>      update_options_from_flags(bs->options, flags);
>>
>> -    ret = bdrv_open_driver(bs, drv, node_name, bs->options, flags, errp);
>> +    ret = bdrv_open_driver(bs, drv, node_name, options, flags, errp);
>
>Why this last change? In the default case you're now passing NULL
>instead of the QDict created with qdict_new().

Duh, nice catch!

--jof2sn43pty5k3sh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllTs2wACgkQc2J8L2kN
9xDE7RAAplwtGGSh1/X+i8XZBmuuXS9XtRsaF1BMKPLxoA3v74t7DudFmfDq6Fga
Y6vm7BpY8cjUM4PBCrzkzMMDsqkw0LUuJ2ubhKfB3xDzY99HYeUDUdjvEO4g2FzJ
I0lSbS/gn3QvW2TPEGl85EpqVu0uQ3v2RAoqdVF/eIwUQxfzV+kp+k3ORdaR1jKi
Dmybv9peJYx3YGbCoPq8zC2e7aXUzEUFv3LeOQbbvq/uuVUZszteotlQh6XScJLI
z0BN7muaZ5pD6HUtFcMNdrp7jQ+5XyxYMWoJT6va0gI5H4cMx027mVNBdJmHaD+y
huq4oHUNp42AsvrQ1ORkxEPksHqeLFzo3l618nMzU5efhY7BF+e8m+oNvRiMSOFu
1r13MGRi0bXzRBPfy+qzmHB1H+fgELh/EI77O8JpMPis3tbIoNLecthVHGuQ5Hkd
rvRRcPp/o3ckzcpFw/kAnRKji1UwgEx4+4wFuWmfa4xDNvk2kYjivUSx+ZGatUxQ
KyH0o8mauAHfb7ALNkKzGtdWc8sI+/ddQRQusx1zOFUvktzf4/Yu1yMCjw264nrw
gRiiZNeS1rRKkL2xvuQlzrYn++NKbwfIHvvbHyp7B5UtlMUT8MW5fQlw6SE3khbR
GrgFO9nrVU8Fq13Ltw00kchKdsXbP+7Ooaa5KurJH7bC2nBGddI=
=n54n
-----END PGP SIGNATURE-----

--jof2sn43pty5k3sh--
