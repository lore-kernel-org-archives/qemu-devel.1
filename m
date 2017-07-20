Received: from eggs.gnu.org ([2001:4830:134:3::10]:36500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dYC1y-0001xe-G0
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dYC1u-00072K-8Q
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:02:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dYC1t-00071g-Uv
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 10:02:14 -0400
References: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
	<96e5169c-6149-fd7a-3347-0994089e01ac@redhat.com>
	<ac3a06a2-bc47-92bb-50e2-0b8174c2b515@redhat.com>
	<7f47afb9-fef3-3ca3-185f-d6844589798c@linux.vnet.ibm.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <39e1eddf-3010-caac-218f-1233281f1ed7@redhat.com>
Date: Thu, 20 Jul 2017 09:52:10 -0400
MIME-Version: 1.0
In-Reply-To: <7f47afb9-fef3-3ca3-185f-d6844589798c@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1FWHuiD9xEPdPvDe6wUrgCLG51F7Xwgnf"
Subject: Re: [Qemu-devel] Question for iotests 188, 189 and 087
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jing Liu <liujbjl@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Lukas Doktor <ldoktor@redhat.com>, Amador Segundo <asegundo@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1FWHuiD9xEPdPvDe6wUrgCLG51F7Xwgnf
From: Cleber Rosa <crosa@redhat.com>
To: Jing Liu <liujbjl@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Cc: Lukas Doktor <ldoktor@redhat.com>, Amador Segundo <asegundo@redhat.com>
Message-ID: <39e1eddf-3010-caac-218f-1233281f1ed7@redhat.com>
Subject: Re: [Qemu-devel] Question for iotests 188, 189 and 087
References: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
 <96e5169c-6149-fd7a-3347-0994089e01ac@redhat.com>
 <ac3a06a2-bc47-92bb-50e2-0b8174c2b515@redhat.com>
 <7f47afb9-fef3-3ca3-185f-d6844589798c@linux.vnet.ibm.com>
In-Reply-To: <7f47afb9-fef3-3ca3-185f-d6844589798c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/20/2017 04:37 AM, Jing Liu wrote:
> Hi Cleber Rosa,
>=20
>=20
> On 2017/7/19 =E4=B8=8A=E5=8D=885:22, Cleber Rosa wrote:
>>
>> On 07/18/2017 02:07 PM, John Snow wrote:
>>>
>>> On 07/17/2017 11:01 PM, Jing Liu wrote:
>>>
> [...]
>> I see issues here:
>>
>> 1) The qemu-iotests "runner", that is, "./check", understands that a
>> file number is a test.  No further granularity is (currently?)
>> achievable here.
>>
>> The easy solution would be to split tests which depend on optional
>> features to separate test files.  In the 087 test given as example,
>> the "=3D=3D=3D aio=3Dnative without O_DIRECT =3D=3D=3D" block would be=
come, say, 190.
>>
>> 2) Skip tests based on features more easily.  There's already support
>> for skipping tests on various situations.  From 087:
>>
>> ...
>> _supported_fmt qcow2
>> _supported_proto file
>> _supported_os Linux
>> ...
>>
>> It's trivial to also have access to other compile time settings.  I di=
d
>> a quick experiment that would add a "_required_feature" function to
>> "common.rc".
> This seems a good way to solve this problem.
> I failed for 087 just because there is no CONFIG_NETTLE_KDF.
>=20

Good.  This actually raises a question about requirements.  I haven't
checked thoroughly, but it looks like either gnutls or nettle can be
used as crypto libraries.  I'll take a better look at that.

> I wonder how can common.rc detect if there's CONFIG_XXX in
> config-host.mak ?
>=20

My experiment was based on a standalone tool that can be used like this:

$ ./scripts/buildconf.py CONFIG_NETTLE_KDF
False
$ echo $?
255

And similarly, but considering a specific target configuration:

$ ./scripts/buildconf.py CONFIG_MARVELL_88W8618 arm-softmmu
True
$ ./scripts/buildconf.py CONFIG_MARVELL_88W8618 x86_64-softmmu
False

And a 'common.rc' function that makes use of it.  I also have use cases
for doing something similar from Python code, so it should also be
possible to use it as a (Python) module.

- Cleber.

> Thanks.
> Jing
>>   For 087 (or 190?) it would look like:
>>
>> ...
>> _supported_fmt qcow2
>> _supported_proto file
>> _supported_os Linux
>> _required_feature CONFIG_LINUX_AIO
>> ...
>>
>> Does it make sense?  Would a patch series along those lines would be
>> welcomed by reviews?
>>
>> Thanks!
>>
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--1FWHuiD9xEPdPvDe6wUrgCLG51F7Xwgnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZcLWOAAoJEGV+jTOl8gnzDKoP/0KypTO5KAhoou4GQMgOFd1/
LVrv1yKamUKCTtLDOAnZnWU/wQNYNpS3TrnMs1LkBz6STsuRb4t1meIYRC2mNAas
cmwjZ7pwIvEh/JVqqYZZkKfYb6bgFGxxFqOWp4FjUdMWOTpb894Dh8kwXZrsMSdC
qBJNI8uelF3DAiUlVYl+6YRbCo054oDBVghLpCxp4oC6qeR4UKGjlDeSKUZUK5wY
rsC4eBuYR4uw9CI3ZVTm3vpOPLfKRDVpejyka4ns/HXM/EwMbgN7YyqOsc6W/B8U
IhBDe687pvX9cIejymGqST6fKA0/79rs3m8C5D2ANOUIiGZ+kTlNaYdx+p1HfSgP
hbF/dre0Y55yyKGnTOFSoTRYRA2rNXwXIHclwRxeYtgtTJ9M/Oi8b1RK1NAT7F4o
+xx0eQ0d9dgDD6y5aXfQxB79BJ5hgKpmcMCDiIes5jeOLz1ex4wQ3gcu1s2ewMx7
P5MAAzbAXv03841s1/Bv314JRw0Ik0snRZxfX1i3ndKwoFFu7ouf2jmZ1sb6JoWN
oS68kE3aQ1zJRPU2KlqOQ5R8nc3rZUSeiT3OPz0SKKrfd0g//JL8iyWbzFezcbR7
UysgaM1t0vZ5oPnH0USILhuxqOUA1j3+NzRYc+dih+EJHWs5ZyBfaqD1+10AvEuv
tv26EOKXofo36Z/KDOdV
=X2kL
-----END PGP SIGNATURE-----

--1FWHuiD9xEPdPvDe6wUrgCLG51F7Xwgnf--
