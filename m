Received: from eggs.gnu.org ([2001:4830:134:3::10]:47469)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1f5dj0-0005ds-90
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 16:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1f5dix-0006TX-7N
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 16:49:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:60073)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1f5diw-0006T1-Rq
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 16:49:11 -0400
References: <CAFEAcA8+gJg4O-ys-KjEVXSEsgd0CZaGXJ=o6nFx4Dv8ccNn0A@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <ed5e0354-11e9-5778-128b-680bab83cbca@gmx.com>
Date: Mon, 9 Apr 2018 22:51:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8+gJg4O-ys-KjEVXSEsgd0CZaGXJ=o6nFx4Dv8ccNn0A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C7x6m6BC4sXXo5MmBUfojcwMt2qWvXWtD"
Subject: Re: [Qemu-devel] qom-test on netbsd can be very slow
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
--C7x6m6BC4sXXo5MmBUfojcwMt2qWvXWtD
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <ed5e0354-11e9-5778-128b-680bab83cbca@gmx.com>
Subject: Re: [Qemu-devel] qom-test on netbsd can be very slow
References: <CAFEAcA8+gJg4O-ys-KjEVXSEsgd0CZaGXJ=o6nFx4Dv8ccNn0A@mail.gmail.com>
In-Reply-To: <CAFEAcA8+gJg4O-ys-KjEVXSEsgd0CZaGXJ=o6nFx4Dv8ccNn0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.04.2018 19:10, Peter Maydell wrote:
> My NetBSD build system recently seems to have taken a nosedive
> in how long it takes to finish "make check". This seems to be
> because qom-test (and probably other things where the test interacts
> with the QEMU process) can run very slowly.
>=20
> netbsdvm# for i in 1 2 3 4 5 6 7 8 9 10; do
> (QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 time
> tests/qom-test -p /x86_64/qom/pc-i440fx-2.0); done
> /x86_64/qom/pc-i440fx-2.0: OK
>         8.49 real         1.18 user         7.34 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>        10.41 real         1.32 user         9.09 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>         8.45 real         1.24 user         7.24 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>         9.88 real         1.10 user         8.31 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>        11.60 real         1.47 user         9.90 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>        10.94 real         1.28 user         9.68 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>        10.06 real         1.32 user         8.76 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>        13.38 real         1.37 user        12.04 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>        16.19 real         1.46 user        14.29 sys
> /x86_64/qom/pc-i440fx-2.0: OK
>         9.70 real         1.17 user         8.51 sys
>=20
> Admittedly this is running in a (KVM) VM, but still, there seems
> something wrong with how long each of these is taking. On Linux
> each run is less than a second, so there's an order-of-magnitude
> slowdown here. Further, I've occasionally seen a run take 100 seconds!
>=20
> Does anybody else see this, and any ideas why it might be running slow?=

> I'm not very familiar with debugging on netbsd; I had a look at
> ktrace output, and the QEMU process seems to sometimes spend
> quite a lot of time in a poll() loop not actually doing anything.
> I couldn't figure out how to get the ktrace logs to annotate
> which thread was making which syscall though, so they weren't
> easy to interpret. If anybody's more experienced at debugging
> things in the BSDs that would also be helpful.
>=20
> On OpenBSD, for comparison, each test run seems to fairly reliably
> take 5 seconds give-or-take, there's much less run-to-run
> variation, though it's still much slower than Linux is.
> The OpenBSD and FreeBSD build VMs seem to complete more
> reasonably quickly than the NetBSD one.
>=20
> One thing I noticed looking at ktrace output is that we do
> all our reading of QMP input and output with a read syscall
> per character. I don't think that's the cause of this slowness,
> though.
>=20
> thanks
> -- PMM
>=20

I'm running these tests natively and get apparently expected results:

/x86_64/qom/pc-i440fx-2.0: OK
        2,05 real         1,36 user         0,71 sys
/x86_64/qom/pc-i440fx-2.0: OK
        1,92 real         1,17 user         0,79 sys
/x86_64/qom/pc-i440fx-2.0: OK
        1,84 real         1,14 user         0,77 sys
/x86_64/qom/pc-i440fx-2.0: OK
        1,85 real         1,16 user         0,76 sys
/x86_64/qom/pc-i440fx-2.0: OK
        1,79 real         1,04 user         0,82 sys
/x86_64/qom/pc-i440fx-2.0: OK
        1,84 real         1,00 user         0,91 sys
/x86_64/qom/pc-i440fx-2.0: OK
        1,86 real         1,18 user         0,75 sys
/x86_64/qom/pc-i440fx-2.0: OK
        1,85 real         1,27 user         0,64 sys
/x86_64/qom/pc-i440fx-2.0: OK
        1,84 real         1,27 user         0,64 sys
/x86_64/qom/pc-i440fx-2.0: OK
        1,82 real         1,18 user         0,71 sys


--C7x6m6BC4sXXo5MmBUfojcwMt2qWvXWtD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlrL0kEMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsodEP/A+s4SkL+a0bBTP7Uguva91eUPLlNYDAfdiME2dS
2lT/XhBnc4dC4cQUHlyE3exWjEVOGjUE60bR9dsKs8NjdpG2Qf7dKinWyN5ahrXU
OEdGiwDkaHJfAAqufECnj5IoJnsiq5XXGI23H9vt16g2xSUopKp3mC5nv4kcrMhj
Nupirg9EH1gXwCBeXYQ/0pzU6OV7Pn0NbQQl0LHIdWre7LOMB5HtRuGvlrqGxlzJ
bodGGY/BHeyY4Kmd4u+1itHG2lV+CYZeNtVkr1O1y9uHJBdt0HNKvjwvtJ0l3IVo
AN3ulMfzHfMmBhrp5PC+Y+138/JYO3pvSf/BQCbdd974KRPoj6WKPwl5CpPzhCxU
8YtmaUAjCAwzgDyRRpW9LzY+kVDecyMsXQ38t4JRFLHa8pJzEkjJiLJstQLCTjmi
W72cVGSVdTFhUjGLBaB7hsJoZ4i0ME1glY7769g+fmGXVPlCq21Oa5BSgmh5wF05
vYoJx0EU+Dd/+fJLyZzddm0BuqtaXW0hNFWu87KuKS54WfFV6X6uqVmjhFnE2IWy
pNz+QFz6OsvirxiTzdfvMTxqGy2JK2h634XlkzUfwxUw3loU1ERTiabXNTlG9fo3
GFVxPJeDeNRdpbQ9yyAwkYtMUSbO16JFVJerytbc3jTEF9f1WEV2dd7iI8UkG/RJ
8eqJ
=UHDJ
-----END PGP SIGNATURE-----

--C7x6m6BC4sXXo5MmBUfojcwMt2qWvXWtD--
