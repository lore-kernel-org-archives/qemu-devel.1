Received: from eggs.gnu.org ([2001:4830:134:3::10]:52162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eHYAn-0003O9-V6
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:46:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eHYAj-0002GP-3U
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:46:54 -0500
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-9-mdavidsaver@gmail.com>
	<20171122040817.GM2380@umbus.fritz.box>
From: Michael Davidsaver <mdavidsaver@gmail.com>
Message-ID: <19c1689b-749d-a422-f2f0-88de6137718d@gmail.com>
Date: Wed, 22 Nov 2017 10:46:41 -0600
MIME-Version: 1.0
In-Reply-To: <20171122040817.GM2380@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OwKIFmenglwlJOiKrkqoNvieKugKRc8Q2"
Subject: Re: [Qemu-devel] [PATCH 08/12] e500: add mpc8540 i2c controller to
 ccsr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OwKIFmenglwlJOiKrkqoNvieKugKRc8Q2
From: Michael Davidsaver <mdavidsaver@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Message-ID: <19c1689b-749d-a422-f2f0-88de6137718d@gmail.com>
Subject: Re: [PATCH 08/12] e500: add mpc8540 i2c controller to ccsr
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
 <20171120032420.9134-9-mdavidsaver@gmail.com>
 <20171122040817.GM2380@umbus.fritz.box>
In-Reply-To: <20171122040817.GM2380@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/21/2017 10:08 PM, David Gibson wrote:
> On Sun, Nov 19, 2017 at 09:24:16PM -0600, Michael Davidsaver wrote:
>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>=20
> You're adding what seems to be a fairly specific device to the general
> e500 init - this again suggests that it should be split, putting
> creation of devices under control of individual machines.

I'll address the ppce500_init() part of this question separately.

In addition to the MPC8540, I find that documentation for the MPC8544
(modeled) and P2020 (un-modeled) show the same i2c controller registers.
 So I think it's reasonable for the generic ppce500 machine to have it
as well.

For what it's worth, the Linux driver for this unit
(drivers/i2c/busses/i2c-mpc.c) lists compatibility with a number of
other freescale SoCs with only some differences in clock selection (not
modeled).  The description for the module is:

> MODULE_DESCRIPTION("I2C-Bus adapter for MPC107 bridge and "
>                    "MPC824x/83xx/85xx/86xx/512x/52xx processors");



>> ---
>>  hw/ppc/e500.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>> index 6f77844303..bef7d313d4 100644
>> --- a/hw/ppc/e500.c
>> +++ b/hw/ppc/e500.c
>> @@ -861,6 +861,14 @@ void ppce500_init(MachineState *machine, PPCE500P=
arams *params)
>>      qdev_init_nofail(dev);
>>      ccsr_addr_space =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0=
);
>> =20
>> +    dev =3D qdev_create(NULL, "mpc8540-i2c");
>> +    object_property_add_child(qdev_get_machine(), "i2c[*]",
>> +                              OBJECT(dev), NULL);
>> +    qdev_init_nofail(dev);
>> +    s =3D SYS_BUS_DEVICE(dev);
>> +    memory_region_add_subregion(ccsr_addr_space, 0x3000,
>> +                                sysbus_mmio_get_region(s, 0));
>> +
>>      mpicdev =3D ppce500_init_mpic(machine, params, ccsr_addr_space, i=
rqs);
>> =20
>>      /* Serial */
>=20



--OwKIFmenglwlJOiKrkqoNvieKugKRc8Q2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYyRdrpxuENu06SOrlAHmyz1/GOoFAloVqfUACgkQlAHmyz1/
GOr6ZhAAmb0xc8atppjUrF3QXfJ60YyQ/ZSISXZIZT2RDNoznDjsDmMemduv8yxZ
w86cKxkutFCAQ9VYnLcxPqjrYNdT+UNeBP3w8easgMQK1QreXKxPj+tgZNmgKo02
CfoZASlPRXcEHWIwvAXXC9jVq1Ho2E+ZaKigkM7TV75Y6c8DzL5ja4uEJYzKhZEM
aWInzTUewRABwCEmxz8k3dnRzlo0EaT5pIWHNhR3BpWfQWOlj9QDu4Nc19Ljj4+6
U7AcRy6b4kJvatfQUWG5aYaJOqWXmrYivN8bkdXrB7nDxv+T2y0kfCRLhbUmfPZ1
O5yLLXX/9JJg8J2AFkfDeT56FuSrfgI04wAvQLQn+3s9XkhNY2Q5Pk4eDZtzMsv9
vjZ8AshzPy/5hu1PAl9B3aO3TQqTwta3iZng7t8pogctJADaZyiop07vAXTq2R8h
vkJzKVDQfEsQTgB7xza7bJLbgNc8irRL3ifKNeQk4ygZWMgaSoudKzrahq068IQc
iJ85FLUjyW+IiJGnxRw/OS7ACUGFDUcIFMYLOaNfiuRl6CooMUjYG5O2tRURz3u6
E5yXhag804PF3lN0/wUolbCkDMSydcxSPwog6/Wu9pOJ8HPKMXDv83YOVYzuxxvu
P9qFcG6c7+h7YwckSyuXgulHk3WuvM2iZPkkq1ZDmjXBdlliezI=
=45BV
-----END PGP SIGNATURE-----

--OwKIFmenglwlJOiKrkqoNvieKugKRc8Q2--
