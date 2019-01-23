Received: from eggs.gnu.org ([209.51.188.92]:43283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmJbK-0006lf-79
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmJbG-0001dU-0f
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:33:58 -0500
References: <20181221234750.23577-1-mreitz@redhat.com>
	<20181221234750.23577-4-mreitz@redhat.com>
	<84e62d4a-bf74-ba1c-d802-e01de14d693c@redhat.com>
	<3bf30595-c8fc-9058-3860-c4640718b33d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c63ab4a5-7e28-2a21-c16e-a114a6ce7358@redhat.com>
Date: Wed, 23 Jan 2019 08:33:41 -0600
MIME-Version: 1.0
In-Reply-To: <3bf30595-c8fc-9058-3860-c4640718b33d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qxw6ucldYGDGL8T63E6KkPTloAt1p5LBU"
Subject: Re: [Qemu-devel] [PATCH 3/3] iotests: Allow 147 to be run
 concurrently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qxw6ucldYGDGL8T63E6KkPTloAt1p5LBU
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Message-ID: <c63ab4a5-7e28-2a21-c16e-a114a6ce7358@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] iotests: Allow 147 to be run
 concurrently
References: <20181221234750.23577-1-mreitz@redhat.com>
 <20181221234750.23577-4-mreitz@redhat.com>
 <84e62d4a-bf74-ba1c-d802-e01de14d693c@redhat.com>
 <3bf30595-c8fc-9058-3860-c4640718b33d@redhat.com>
In-Reply-To: <3bf30595-c8fc-9058-3860-c4640718b33d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/23/19 7:12 AM, Max Reitz wrote:
> On 21.01.19 22:02, Eric Blake wrote:
>> On 12/21/18 5:47 PM, Max Reitz wrote:
>>> To do this, we need to allow creating the NBD server on various ports=

>>> instead of a single one (which may not even work if you run just one
>>> instance, because something entirely else might be using that port).
>>
>> Can you instead reuse the ideas from nbd_server_set_tcp_port() from
>> qemu-iotests/common.nbd?
>>
>>>
>>> So we just pick a random port in [32768, 32768 + 1024) and try to cre=
ate
>>> a server there.  If that fails, we just retry until something sticks.=

>>
>> That has the advantage of checking whether a port is actually in use
>> (using 'ss' - although it does limit the test to Linux-only; perhaps
>> using socat instead of ss could make the test portable to non-Linux?)
>=20
> But doesn't that give you race conditions?  That's the point of this
> series, so you can run multiple instances of 147 concurrently.

Hmm - that does imply that common.nbd's use of ss IS racy because it
checks in linear fashion and has a TOCTTOU window (affects at least
iotest 233). Your observation that random probes within a range are less
susceptible (although not immune) to the race is correct.

>> Do you actually need to attempt a qemu-nbd process, if you take my
>> suggestion of using ss to probe for an unused port?  And if not, do we=

>> still need qemu_nbd_pipe() added earlier in the series?
>>
>>
>>> -        address =3D { 'type': 'inet',
>>> -                    'data': {
>>> -                        'host': 'localhost',
>>> -                        'port': str(NBD_PORT)
>>> -                    } }
>>> -        self._server_up(address, export_name)
>>> +        while True:
>>> +            nbd_port =3D random.randrange(NBD_PORT_START, NBD_PORT_E=
ND)
>>
>> common.nbd just iterates, instead of trying random ports.
>=20
> I'm not sure which is better.  Iterating gives guaranteed termination,
> trying random ports means the first one you try will usually work.

Is there any other way we can make the test more robust, perhaps by
using socket activation (that is, pre-open the port prior to starting
qemu_nbd, so that our code for finding a free socket is more easily
reusable), or by using Unix sockets for test 147 (that test seems to be
using TCP sockets only as a means to get to the real feature under test,
and not as the actual thing being tested)?

Hmm, and you made me realize that socket activation is NOT documented in
'man qemu-nbd'; I ought to fix that.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--qxw6ucldYGDGL8T63E6KkPTloAt1p5LBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxIe0YACgkQp6FrSiUn
Q2q9vwf/YLIv2N4X9LeHfEve7BpIKpeDkG8AGFMf+2DWpUE8sMzSPvKgsOOk1/px
G4hxq/eWGNGvUHAfNx1H/eRnLRWVUY8cTSJQJMVAaSsuE1Fg+aixyf4WR2xA4hLo
Ho6MQI3a4WUKJtdMJkIo/b75zIkCc4XUcHEifwYKJzHTHSENHsqoLPCxUeE1un3k
z9rSh1tR8GJFcZwWi3yWldZnN8lgqwnhTZf9ST6oJTTcg6o4CVwpprvSHKXJbBad
Xf4Hx2qqCayqorpMtTlVOqIPMciHcp+Xxi0HNGa4MqzYD3M//Me+6/tbILdcoduJ
Amu7WhOrvfhfrs7odoLuIJFeKeWdBg==
=kXL0
-----END PGP SIGNATURE-----

--qxw6ucldYGDGL8T63E6KkPTloAt1p5LBU--
