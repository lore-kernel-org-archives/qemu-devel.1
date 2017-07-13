Received: from eggs.gnu.org ([2001:4830:134:3::10]:53817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVkX3-0001Jt-En
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVkWy-0001Fu-HM
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:16:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dVkWy-0001FZ-8v
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 16:16:12 -0400
References: <CAFEAcA9A0fBB+QE68O7aea+c6SXPaVK4+7B8DJoYE27qshtrcQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cd8f1049-b975-06d8-528b-9d1c3c4bc0fb@redhat.com>
Date: Thu, 13 Jul 2017 15:16:10 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9A0fBB+QE68O7aea+c6SXPaVK4+7B8DJoYE27qshtrcQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HnqnHqD6Ev9bfj6sWSnlqNbJHfeCOrSRb"
Subject: Re: [Qemu-devel] tests/Makefile.include non-portable use of $RANDOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HnqnHqD6Ev9bfj6sWSnlqNbJHfeCOrSRb
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <cd8f1049-b975-06d8-528b-9d1c3c4bc0fb@redhat.com>
Subject: Re: tests/Makefile.include non-portable use of $RANDOM
References: <CAFEAcA9A0fBB+QE68O7aea+c6SXPaVK4+7B8DJoYE27qshtrcQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9A0fBB+QE68O7aea+c6SXPaVK4+7B8DJoYE27qshtrcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 12:32 PM, Peter Maydell wrote:
> Currently our test makefile does
>=20
>    MALLOC_PERTURB_=3D$${MALLOC_PERTURB_:-$$((RANDOM % 255 + 1))}
>=20
> This works on bash, but $RANDOM is bash-specific.
> On dash, it doesn't do what we want, but it does do something:
>=20
> $ echo $((RANDOM % 255 + 1))
> 1

Being non-random doesn't hurt (it's just less test coverage by default).

>=20
> On NetBSD the shell complains:
> # echo $((RANDOM % 255 + 1))
> -sh: arith: syntax error: "RANDOM % 255 + 1"
>=20
> and so 'make check' doesn't work.
>=20
> Any suggestions for something more portable?

Yes; echo $(( ${RANDOM:-0} % 255 + 1))

should reliably give you 1, even on current BSD /bin/sh, regardless of
whether BSD adds $RANDOM support in the future.

> https://unix.stackexchange.com/questions/140750/generate-random-numbers=
-in-specific-range
> suggests
>   awk 'BEGIN{srand(); print int(1+rand()*256)}'
> and of course there are similar things possible with perl et al.

But why bother. MALLOC_PERTURB_ only makes sense on glibc systems, so
picking a non-random value is no worse on non-glibc systems.

>=20
> Or we could just have the makefile check whether we have bash,
> and if not then set
>   RANDOM=3D4

Picking that is the same as using ${RANDOM:-4}, without having to
hardcode a check for whether you have bash.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HnqnHqD6Ev9bfj6sWSnlqNbJHfeCOrSRb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ9UKAAoJEKeha0olJ0NqsDIH/3zUDingGWaBga3Ek7KSxSiO
HJWcOrKHr6iy1gV8wBwWNVtWqa4W2c/3H7k3LY6dt98ZxogO1reRf5k9aWBlHBpA
lDnhebJN7taGBH0L1LJrZm3Z+hBzPQsrU8+Sz+UeWX/I6pKgUztweLtWu7qfNvZZ
9Gp/FxCcnilyzDPskRVHIvPonQDHeh+yzn8dFchVi+nX7iD/aoQH5p0PC/5dL6Q+
UIaUzyUqIATZbrUvc7QREQoh48G9Ct/iYFQ88oNVMoJJIMr+1L7CAOH+2coszPFL
ImgZkGHnTOpSh/c9E/XLPDF5OzKF1DzDS1zV5kfLik++tbA9YD5SvP9EZT5x//U=
=tZnK
-----END PGP SIGNATURE-----

--HnqnHqD6Ev9bfj6sWSnlqNbJHfeCOrSRb--
