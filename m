Received: from eggs.gnu.org ([2001:4830:134:3::10]:48303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db8Ej-00066r-DY
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db8Ei-0001Tu-71
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:35:37 -0400
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-10-eblake@redhat.com>
	<20170728130538.GQ12364@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3c27944c-bb18-a501-39b5-139059a4aa85@redhat.com>
Date: Fri, 28 Jul 2017 11:35:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170728130538.GQ12364@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AoobCjxMjxlwikrL7rhRL4A371EBjqb8w"
Subject: Re: [Qemu-devel] [PATCH v3 09/12] tests/libqos/pci: Clean up string
 interpolation into QMP input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, "open list:virtio-blk" <qemu-block@nongnu.org>, armbru@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AoobCjxMjxlwikrL7rhRL4A371EBjqb8w
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, "open list:virtio-blk" <qemu-block@nongnu.org>,
 armbru@redhat.com, stefanha@redhat.com
Message-ID: <3c27944c-bb18-a501-39b5-139059a4aa85@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/12] tests/libqos/pci: Clean up string
 interpolation into QMP input
References: <20170725211523.3998-1-eblake@redhat.com>
 <20170725211523.3998-10-eblake@redhat.com>
 <20170728130538.GQ12364@stefanha-x1.localdomain>
In-Reply-To: <20170728130538.GQ12364@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 08:05 AM, Stefan Hajnoczi wrote:
> On Tue, Jul 25, 2017 at 04:15:20PM -0500, Eric Blake wrote:
>> @@ -419,19 +420,18 @@ static void test_ivshmem_server_irq(void)
>>  static void test_ivshmem_hotplug(void)
>>  {
>>      const char *arch =3D qtest_get_arch();
>> -    gchar *opts;
>> +    QObject *extra_args =3D qobject_from_jsonf("{ 'shm': '%s', 'size'=
: '1M' }",
>> +                                             tmpshm);
>=20
> Is there a difference between:
>=20
>   qobject_from_jsonf("{ 'shm': '%s' }", tmpshm);
>=20
> and:
>=20
>   qobject_from_jsonf("{ 'shm': %s }", tmpshm);

Yes, and it's important.

sprintf("{ 'shm': '%s' }", tmpshm);

is the same as

qobject_from_jsonf("{ 'shm': %s }" tmpshm);

Passing '%s' through qobject_from_jsonf() is generally wrong (it would
produce ''...'' instead of the intended '...').

Looks like something to fix on the next round.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AoobCjxMjxlwikrL7rhRL4A371EBjqb8w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7Z84ACgkQp6FrSiUn
Q2oPrAf/V/Czzkm+VXbySs6mfmYzBK+rT+2BIelK1DakXiDtbzBnoIGHtMC4SGck
lHAVFt7t4R+OsBSqX7/ZAOIRieWgXAbrsD2likh0v6Gb9szk1dVT0Gig+n1ZAI3q
etD9xJ02srUNkkiLc2coB2AvrEhN2CFpickZ8W2GL0Jpqnltj4pO2WCWtVdiyd+a
vb+FgtlcK0sLkJtw5Xef65RkEOVh398bzyj1hSHeANwZwksfy1kbmT233Ji+2X3R
pcs6FQqAy1CYXyXYtJdFzcL7PU70wDTliwSbYYwsYzURD97TTNGRco4Z92GD9LIR
dypI2ng0TSd0ONXNY353Q9mYzNPV7g==
=6VGU
-----END PGP SIGNATURE-----

--AoobCjxMjxlwikrL7rhRL4A371EBjqb8w--
