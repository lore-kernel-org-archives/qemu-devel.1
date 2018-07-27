Received: from eggs.gnu.org ([2001:4830:134:3::10]:46592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fj2jT-0000HM-F0
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:24:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fj2jQ-00065t-9B
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:24:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fj2jQ-00064y-0E
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 09:24:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id c13-v6so5055596wrt.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 06:24:31 -0700 (PDT)
Date: Fri, 27 Jul 2018 14:24:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180727132429.GG28555@stefanha-x1.localdomain>
References: <20180723104342.22992-1-e.emanuelegiuseppe@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1XWsVB21DFCvn2e8"
Content-Disposition: inline
In-Reply-To: <20180723104342.22992-1-e.emanuelegiuseppe@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] pci-pc: add NULL check for qpci_free_pc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org


--1XWsVB21DFCvn2e8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 12:43:42PM +0200, Emanuele Giuseppe Esposito wrote:
> The current layout of struct QPCIBusPC provides only one field,
> QPCIBus bus, so passing a NULL pointer to qpci_free_pc()
> makes container_of(NULL, QPCIBusPC, bus)
> returning 0 (NULL), that is correctly handled by g_free().
> This is bad practice, allowing the caller to think that it's okay
> to always pass NULL to the function, even though this is just a
> particular case.
> In facts, qpci_free_pc() happens to return NULL only because container_of
> computes the subtraction between the given NULL
> pointer and offsetof(QPCIBus, bus), with the latter returning 0 too,
> since bus is the first element of the struct and there is no
> offset betwen itself and QPCIBusPC.
>=20
> However, if in future the bus field changes its position, for example bec=
oming
> the second field, offsetof will return a number > 0, since there is some =
offset
> between the beginning of the struct and the bus field.
> Therefore passing a NULL pointer to the container_of macro will return a
> negative number, that will be translated into an invalid address passed to
> g_free() and causing a seg fault.
>=20
> Adding a preventive safety check that returns from the function if the
> given pointer is NULL solves the problem.
>=20
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> ---
>  tests/libqos/pci-pc.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--1XWsVB21DFCvn2e8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbWx0NAAoJEJykq7OBq3PInlMH/37lAUvgn2H32T2r2jYZkCJp
goB9D72paalVosbI228kr2zxt03ECy3lv11+FBO9TsJiMw88E5NE6mDtZwUJYbMv
EUFjTkzuFr6UFQRZ6e7qxGkHgFuDmfzwvkp6OYhbwz/aBXNz09mr67XAyI2XwyBp
MFpKmHh7bOU4bPfx9Gd6hLUXxh4EEGEMZpNYpjolt0Dnv6Q/gJfW+imD9q86Y2N2
7SjdLFjBNLZqUaYj2C6q02HJm18mWJrkRDEaVTLH7mcIjzbhCx2LLi6blC+BPaDu
17NSEBP9cAZZzfR3UpX9Mg/Rbiu8Hs0Ypw2bjF++o5WodWmIWp1/r6pgvUr2WhU=
=lkjL
-----END PGP SIGNATURE-----

--1XWsVB21DFCvn2e8--
