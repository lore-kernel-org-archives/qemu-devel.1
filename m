Received: from eggs.gnu.org ([209.51.188.92]:44364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmJem-000145-PV
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmJel-0003WI-R2
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:37:32 -0500
References: <20181221234750.23577-1-mreitz@redhat.com>
	<20181221234750.23577-4-mreitz@redhat.com>
	<84e62d4a-bf74-ba1c-d802-e01de14d693c@redhat.com>
	<3bf30595-c8fc-9058-3860-c4640718b33d@redhat.com>
	<c63ab4a5-7e28-2a21-c16e-a114a6ce7358@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <99a1dcdf-2b53-3aff-da21-56e719dad4d9@redhat.com>
Date: Wed, 23 Jan 2019 15:37:14 +0100
MIME-Version: 1.0
In-Reply-To: <c63ab4a5-7e28-2a21-c16e-a114a6ce7358@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9VmItbS3DXrcilG7kkusz7eOvRkD8u80c"
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
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9VmItbS3DXrcilG7kkusz7eOvRkD8u80c
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Message-ID: <99a1dcdf-2b53-3aff-da21-56e719dad4d9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] iotests: Allow 147 to be run
 concurrently
References: <20181221234750.23577-1-mreitz@redhat.com>
 <20181221234750.23577-4-mreitz@redhat.com>
 <84e62d4a-bf74-ba1c-d802-e01de14d693c@redhat.com>
 <3bf30595-c8fc-9058-3860-c4640718b33d@redhat.com>
 <c63ab4a5-7e28-2a21-c16e-a114a6ce7358@redhat.com>
In-Reply-To: <c63ab4a5-7e28-2a21-c16e-a114a6ce7358@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.19 15:33, Eric Blake wrote:
> On 1/23/19 7:12 AM, Max Reitz wrote:
>> On 21.01.19 22:02, Eric Blake wrote:
>>> On 12/21/18 5:47 PM, Max Reitz wrote:
>>>> To do this, we need to allow creating the NBD server on various port=
s
>>>> instead of a single one (which may not even work if you run just one=

>>>> instance, because something entirely else might be using that port).=

>>>
>>> Can you instead reuse the ideas from nbd_server_set_tcp_port() from
>>> qemu-iotests/common.nbd?
>>>
>>>>
>>>> So we just pick a random port in [32768, 32768 + 1024) and try to cr=
eate
>>>> a server there.  If that fails, we just retry until something sticks=
=2E
>>>
>>> That has the advantage of checking whether a port is actually in use
>>> (using 'ss' - although it does limit the test to Linux-only; perhaps
>>> using socat instead of ss could make the test portable to non-Linux?)=

>>
>> But doesn't that give you race conditions?  That's the point of this
>> series, so you can run multiple instances of 147 concurrently.
>=20
> Hmm - that does imply that common.nbd's use of ss IS racy because it
> checks in linear fashion and has a TOCTTOU window (affects at least
> iotest 233). Your observation that random probes within a range are les=
s
> susceptible (although not immune) to the race is correct.
>=20
>>> Do you actually need to attempt a qemu-nbd process, if you take my
>>> suggestion of using ss to probe for an unused port?  And if not, do w=
e
>>> still need qemu_nbd_pipe() added earlier in the series?
>>>
>>>
>>>> -        address =3D { 'type': 'inet',
>>>> -                    'data': {
>>>> -                        'host': 'localhost',
>>>> -                        'port': str(NBD_PORT)
>>>> -                    } }
>>>> -        self._server_up(address, export_name)
>>>> +        while True:
>>>> +            nbd_port =3D random.randrange(NBD_PORT_START, NBD_PORT_=
END)
>>>
>>> common.nbd just iterates, instead of trying random ports.
>>
>> I'm not sure which is better.  Iterating gives guaranteed termination,=

>> trying random ports means the first one you try will usually work.
>=20
> Is there any other way we can make the test more robust, perhaps by
> using socket activation (that is, pre-open the port prior to starting
> qemu_nbd, so that our code for finding a free socket is more easily
> reusable), or by using Unix sockets for test 147 (that test seems to be=

> using TCP sockets only as a means to get to the real feature under test=
,
> and not as the actual thing being tested)?

147 needs TCP sockets because that interface is tested.

Making the code reusable is not too high of a priority to me, as
normally NBD tests should just use Unix sockets.  This test is just a
special case.  But for this test, I can try to put the while loop into
an own function (that gets fed an address object without data.port), as
John has proposed.

Max

> Hmm, and you made me realize that socket activation is NOT documented i=
n
> 'man qemu-nbd'; I ought to fix that.
>=20



--9VmItbS3DXrcilG7kkusz7eOvRkD8u80c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxIfBoACgkQ9AfbAGHV
z0DOJQf+K2/Kk1d15zZP7q7c35mpruxINyCA2yzlVSobhKRXU4YFd0JQe+S91G70
pfdYI3C/3mrlmJpDpKMJF66CqHgVZhxr8LB3/1mim458/XGW+KeMakPPRvewS8bg
vuZbQWM/NKN5hrKSSuaXg92KKRlcbRCymE26RxuBRwFWGWjCF6ih5T8ogKHJVBQu
lX4/Vms3cJxixMIGoM2uW+fzoulCt3UJng36joAsyekq4GrRSY494s1qAe7N3Fse
XBqd5zZ6/xlXGaFpdQ5qWh3J50zE8ZQZhYfjDBYlFa8mpAB1L/lz0PWd1IHRncDj
NK/xA0Gv1KjwJPYOux6LEzzLvEf6gg==
=TKKb
-----END PGP SIGNATURE-----

--9VmItbS3DXrcilG7kkusz7eOvRkD8u80c--
