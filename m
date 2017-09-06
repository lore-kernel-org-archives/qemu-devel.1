Received: from eggs.gnu.org ([2001:4830:134:3::10]:57627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dphFX-0002Xu-Bs
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dphFW-0004g2-AW
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:48:39 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-13-eblake@redhat.com>
	<13667793-2b90-2e9d-4582-6087258adfc2@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <757785c4-8a8b-ad76-75f9-48bbec4187b8@redhat.com>
Date: Wed, 6 Sep 2017 15:48:23 -0500
MIME-Version: 1.0
In-Reply-To: <13667793-2b90-2e9d-4582-6087258adfc2@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WPXFrUrWWltjwb5XUgP8J1HhIhThEr4Pg"
Subject: Re: [Qemu-devel] [PATCH v6 12/29] libqos: Track QTestState with
 QPCIBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>, armbru@redhat.com, "open list:sPAPR" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WPXFrUrWWltjwb5XUgP8J1HhIhThEr4Pg
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>,
 armbru@redhat.com, "open list:sPAPR" <qemu-ppc@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Message-ID: <757785c4-8a8b-ad76-75f9-48bbec4187b8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 12/29] libqos: Track QTestState with
 QPCIBus
References: <20170901180340.30009-1-eblake@redhat.com>
 <20170901180340.30009-13-eblake@redhat.com>
 <13667793-2b90-2e9d-4582-6087258adfc2@amsat.org>
In-Reply-To: <13667793-2b90-2e9d-4582-6087258adfc2@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/01/2017 02:20 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Eric,
>=20
> On 09/01/2017 03:03 PM, Eric Blake wrote:
>> When initializing a QPCIBus, track which QTestState the bus is
>> associated with (so that a later patch can then explicitly use
>> that test state for all communication on the bus, rather than
>> blindly relying on global_qtest).=C2=A0 Update the initialization
>> functions to take another parameter, and update all callers to
>> pass in state (for now, most callers get away with passing the
>> current global_qtest as the current state, although this required
>> fixing the order of initialization to ensure qtest_start() is
>> called before qpci_init*() in rtl8139-test, and provided an
>> opportunity to pass in the allocator in e1000e-test).
>>

>> +++ b/tests/libqos/pci-pc.c
>> @@ -115,11 +115,14 @@ static void qpci_pc_config_writel(QPCIBus *bus,
>> int devfn, uint8_t offset, uint3
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 outl(0xcfc, value);
>> =C2=A0 }
>>
>> -QPCIBus *qpci_init_pc(QGuestAllocator *alloc)
>> +QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QPCIBusPC *ret;
>>
>> +=C2=A0=C2=A0=C2=A0 assert(qts);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D g_malloc(sizeof(*ret));
>=20
> I'd rather use g_malloc0() here (safer!)

Pre-existing, but yes, I can touch it while in the area.

>=20
>> +=C2=A0=C2=A0=C2=A0 ret->bus.qts =3D qts;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret->bus.pio_readb =3D qpci_pc_pio_read=
b;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret->bus.pio_readw =3D qpci_pc_pio_read=
w;
>=20
> or init qts field in same order than struct:

Okay.

>=20
> Either ways:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WPXFrUrWWltjwb5XUgP8J1HhIhThEr4Pg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwXxcACgkQp6FrSiUn
Q2qJQwf/TYKOcZe0te0Az3iCKzsRmhjQSQf8kr736iEE0SkXy04bZA6/KzRoW2SA
hm4yTSQ+Kdohut23A+ggOqQVoVomsoxNHekE4nziQBa2v3wFmwssozpMDHLElTVc
JLK5aSCkqIwYI5ltXef9jw5Ys55DWGS56AZawezgAhblRrBdQJZF011GYzqpt8Tl
7hkJ+sROd+uoFdt7vvMrJfnIGAqWvySzPHWCjZG6TNylFai3JMSd9ygvvqFiKkaj
FHk81ilbXf127FNp2nT+O38aY8Md0QvaR8vfbrfmfb9Ciem4wjY3WX4iTnNJPUa4
uKBajvSqXh4Xvu2cNmwpLAj4wWyoLA==
=xLgF
-----END PGP SIGNATURE-----

--WPXFrUrWWltjwb5XUgP8J1HhIhThEr4Pg--
