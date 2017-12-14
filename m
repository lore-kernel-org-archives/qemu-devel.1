Received: from eggs.gnu.org ([2001:4830:134:3::10]:52455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePRoR-0006G3-N0
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:36:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePRoO-0002tD-IK
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:36:27 -0500
References: <20171213213557.26561-1-f4bug@amsat.org>
	<20171214093907.GA14433@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4d649fc-4bb2-9b61-7e48-46a6a51e7b01@redhat.com>
Date: Thu, 14 Dec 2017 12:35:46 +0100
MIME-Version: 1.0
In-Reply-To: <20171214093907.GA14433@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="x1NLimutSg6NrOdXeCB0xCqX7bkncvU1o"
Subject: Re: [Qemu-devel] [PATCH 0/6] QTests: use Python to run complex tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x1NLimutSg6NrOdXeCB0xCqX7bkncvU1o
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?=
 <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <d4d649fc-4bb2-9b61-7e48-46a6a51e7b01@redhat.com>
Subject: Re: [PATCH 0/6] QTests: use Python to run complex tests
References: <20171213213557.26561-1-f4bug@amsat.org>
 <20171214093907.GA14433@stefanha-x1.localdomain>
In-Reply-To: <20171214093907.GA14433@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 14/12/2017 10:39, Stefan Hajnoczi wrote:
>>             # verify Card ID
>>             data =3D self.bus.do_cmd(ALL_SEND_CID)
>>             oid, pnm, psn =3D struct.unpack(">x2s5sxLxxx", data)
>>             self.assertEqual(oid, "XY") # QEMU default
>>             self.assertEqual(pnm, "QEMU!") # QEMU default
>>             self.assertEqual(psn, 0xdeadbeef) # QEMU default
> Device qtests are better done in C than Python.  Python is not good at
> binary I/O and porting this to Python 3 will be extra work later (Pytho=
n
> 2 is set for End-of-Life in 2020, see https://pythonclock.org/).
>=20
> More importantly, we already have libqos in C with a guest memory
> allocator, PCI, and virtio support.  Fragmenting the small amount effor=
t
> that goes into device testing will delay libqos reaching critical mass.=

> Critical mass is where libqos provides all the infrastructure you need
> to set up a device and focus on your actual test instead of machine,
> bus, or device initialization.  Starting a Python device testing effort=

> will just lead to duplication and 2 underdeveloped device testing
> frameworks.

I agree that fragmentation is bad.  However, libqos is small (about 4k
lines of code, maybe 3k in Python).

I also agree that any qtest written in Python should be written in
Python 3 from the beginning (in fact we should consider dropping Python
2.x support in 2.12).  Doing so should not make binary I/O much
different than C.

=46rom my point of view, the main advantage of Python is the reflection
mechanisms.  Those would make it possible to automatically discover the
set of runnable tests; for example, based on:

- two machine descriptions (including malloc) for ARM -M virt and x86 -M =
q35

- a driver for the generic PCIe host bridge

- a driver for virtio-pci

- a driver for virtio-scsi

- a set of SCSI tests

=2E.. it should be possible to run the same tests as either ARM or x86
qtests.  This would be a very different framework compared to the C libqo=
s.

Thanks,

Paolo

> Is there a specific reason why adding SD Card support to libqos is not
> possible in C?



--x1NLimutSg6NrOdXeCB0xCqX7bkncvU1o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAloyYhIACgkQv/vSX3jH
roNUxwf+LvjVvv78MurxA9phFQsDpKUylGtjVXc0MX9Vx+PjJUAWUm2BfdpGVPwL
0/f8U2hno14Q9+oASTVnjtsPyulwOJ+M5rqwUrv0K5bgCJS7HbRLo5InpUgs5qB8
RdiE3fRh7QbcLMCB+T72eQBgylHhBQwaMv88k3bmzuaUIgow7djbyp9O0bPrJwhH
UQ+dZPdax2DxZUPQgbPDst9tWyBWOgNrr3Midli8S/esOOr5GBSq/d0bgyihPEVA
Y6tVhsqfi69eP2Hg4bHOG0cth5ZKh89p2bWGrGs3SgLqQAB0PVtXxvdjtO0Rwkqm
3GTkehGzjJYBBfvxkpfsSelDYETLrA==
=jUjb
-----END PGP SIGNATURE-----

--x1NLimutSg6NrOdXeCB0xCqX7bkncvU1o--
