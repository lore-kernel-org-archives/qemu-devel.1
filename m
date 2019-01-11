Received: from eggs.gnu.org ([209.51.188.92]:52903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghzg9-0006Dr-D3
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghzg8-0001d8-I0
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:29:05 -0500
References: <20190110191901.5082-1-eblake@redhat.com>
	<20190110191901.5082-3-eblake@redhat.com>
	<20190111103858.GB5010@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3772838c-a83e-ce76-c0a5-42c2bef2ca24@redhat.com>
Date: Fri, 11 Jan 2019 10:28:54 -0600
MIME-Version: 1.0
In-Reply-To: <20190111103858.GB5010@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7Q1hbFwx0FafgDlRzMvGArQDS7nLDmb8F"
Subject: Re: [Qemu-devel] [PATCH v3 2/6] block: Take advantage of QemuOpt
 default integers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, lbloch@janustech.com, armbru@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7Q1hbFwx0FafgDlRzMvGArQDS7nLDmb8F
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, lbloch@janustech.com, armbru@redhat.com,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jeff Cody <jcody@redhat.com>
Message-ID: <3772838c-a83e-ce76-c0a5-42c2bef2ca24@redhat.com>
Subject: Re: [PATCH v3 2/6] block: Take advantage of QemuOpt default integers
References: <20190110191901.5082-1-eblake@redhat.com>
 <20190110191901.5082-3-eblake@redhat.com>
 <20190111103858.GB5010@dhcp-200-186.str.redhat.com>
In-Reply-To: <20190111103858.GB5010@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 4:38 AM, Kevin Wolf wrote:
> Am 10.01.2019 um 20:18 hat Eric Blake geschrieben:
>> Instead of defining an integer to a default string value (where we
>> have to be careful how we spelled the integer because of the use of
>> stringify), populate a default integer value instead.
>>
>> Drop a useless stringify(0); a missing default is just as easy to
>> interpret as 0 as an explicit string 0.
>>

>>         {
>>             .name =3D VHDX_BLOCK_OPT_BLOCK_SIZE,
>>             .type =3D QEMU_OPT_SIZE,
>> -           .def_value_str =3D stringify(0),
>>             .help =3D "Block Size; min 1MB, max 256MB. " \
>>                     "0 means auto-calculate based on image size."
>>         },
>=20
> Before the patch:
> $ ./qemu-img create -f vhdx /tmp/test.vhdx 64M
> Formatting '/tmp/test.vhdx', fmt=3Dvhdx size=3D67108864 log_size=3D1048=
576 block_size=3D0
>=20
> After the patch:
> $ ./qemu-img create -f vhdx /tmp/test.vhdx 64M
> Formatting '/tmp/test.vhdx', fmt=3Dvhdx size=3D67108864 log_size=3D1048=
576
>=20
> Intentional?

Yes. Well, sort of.  A default of 0 is automatic, so right now, our help
output omits all variables with an implicit default of 0.  We have no
way to tell the difference between an explicit integer default of 0 and
an implicit one (we did with strings, but the point of the series is to
store default integers as integers rather than as strings), so we could
work around that by adding even more to QemuOpts to record a bool of
whether an int of 0 should be listed as an explicit zero in our help
output.  Or we could state that listing a default of zero doesn't help
anyone.  Or we could list ALL variable defaults (even the ones that
default to implicit 0) rather than the current code that special-cases
output to omit variables left at their implicit default, but that may
change output in the other direction (more output where we are now
silent - although that may not be a bad thing).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--7Q1hbFwx0FafgDlRzMvGArQDS7nLDmb8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw4xEYACgkQp6FrSiUn
Q2qjogf8DyY8w+ESNhjrISV0eWoYGwfIT6TJvK/xhDvJUMBtG3jE2En+aNS2b6v7
LlWCudSzuuFYpNm50Avwm9Q8Oe7dM+0b8n+BrP8E16+XLXPCii5Fs+6M/PJVf5y3
hQSFPWK6r6Tq/dekaQ92pn7kImLHTrZb4YcIuc3kHvXGGlCgtnxXPxRJ3wRPYzqK
TICyMkoHj7xUy4Zi5zq1/InHHxC72yomuj7izERvKWqfbeQJESX2R9U7y5XO5GFb
j07XUGHfeFGahdX3J2MXVvuh4kFecWu5ytyhxKutcuktSbZ15uNfwCqdy5yeNXfX
A0pcqQXTIP78JD2a1oyO7w/S/ll8TA==
=P4V5
-----END PGP SIGNATURE-----

--7Q1hbFwx0FafgDlRzMvGArQDS7nLDmb8F--
