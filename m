Received: from eggs.gnu.org ([2001:4830:134:3::10]:60742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dN9JO-00079C-5u
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 22:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dN9JJ-0003zH-BD
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 22:54:38 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dN9JJ-0003y3-1j
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 22:54:33 -0400
Received: by mail-pf0-x243.google.com with SMTP id y7so20434091pfd.3
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 19:54:31 -0700 (PDT)
References: <CAFEAcA_3Uf-t7MgvTqO52XX61z3Mcnmpk1XNJRqgdFJiVP1ALQ@mail.gmail.com>
	<08ab93cb-4d42-2b8b-71e6-057b9529d0b7@suse.de>
	<e72dab1b-7544-65ea-0e07-abfd78413706@redhat.com>
	<20170620010258.GK22449@umbus>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4df57772-2f40-2538-399c-77118b6c01e7@ozlabs.ru>
Date: Tue, 20 Jun 2017 12:54:24 +1000
MIME-Version: 1.0
In-Reply-To: <20170620010258.GK22449@umbus>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iVEvoCuHpGe550eV4BLBDCk1Dge1pr7wV"
Subject: Re: [Qemu-devel] spapr guests warn "System page size 0x2000 is not
 enabled in page_size_mask (0x11000). Performance may be slow" on SPARC
 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iVEvoCuHpGe550eV4BLBDCk1Dge1pr7wV
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <4df57772-2f40-2538-399c-77118b6c01e7@ozlabs.ru>
Subject: Re: [Qemu-devel] spapr guests warn "System page size 0x2000 is not
 enabled in page_size_mask (0x11000). Performance may be slow" on SPARC hosts
References: <CAFEAcA_3Uf-t7MgvTqO52XX61z3Mcnmpk1XNJRqgdFJiVP1ALQ@mail.gmail.com>
 <08ab93cb-4d42-2b8b-71e6-057b9529d0b7@suse.de>
 <e72dab1b-7544-65ea-0e07-abfd78413706@redhat.com>
 <20170620010258.GK22449@umbus>
In-Reply-To: <20170620010258.GK22449@umbus>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 20/06/17 11:02, David Gibson wrote:
> On Mon, Jun 19, 2017 at 12:32:48PM +0200, Thomas Huth wrote:
>> On 19.06.2017 11:39, Alexander Graf wrote:
>>> On 06/15/2017 03:33 PM, Peter Maydell wrote:
>>>> I've just noticed that on a SPARC host, some of the PPC guests
>>>> warn during make check:
>>>>
>>>>    /ppc64/prom-env/pseries:
>>>> qemu-system-ppc64: System page size 0x2000 is not enabled in
>>>> page_size_mask (0x11000). Performance may be slow
>>>>
>>>> Is this really a performance problem on a TCG guest?
>>>> It makes the 'make check' output a bit noisy, but not
>>>> unbearably so.
>>>
>>> From what I can tell this really only affects DDW which should be pag=
e
>>> size agnostic when only using emulated devices. Maybe Alexey thought =
of
>>> using VFIO-pci devices in a TCG guest?
>>
>> Maybe we could at least silence the warning by checking
>> qtest_enabled()?
>=20
>=20
> So,
>=20
> 1) Yes, we should at least silence the warning.

Agree, wrapping it into kvm_enabled() should do it.


>=20
> 2) Certainly the mentioned slowdown shouldn't be significant for TCG
> guests.

It is not significant at all. While in-kernel TCE handling improves
throughput for VFIO devices quite a lot (200mb/s -> 1000mb/s), TCG could
not do any better than 20mb/s anyway.


> 3) I _think_ the restriction which causes the slowdown doesn't even
> exist for TCG, but I haven't 100% convinced myself of this.  I've been
> sick lately, so my brain isn't working all that well.

Mismatch between system page size and IOMMU page size means H_PUT_TCE is
going to be called more often than needed; if VFIO is involved, then more=

ioctl(vfio_container_fd, DMAP_MAP) calls. But - we cannot do 8K IOMMU pag=
es
at all, SPARC does not support VFIO (or does it?), and TCG is slow anyway=
=2E



--=20
Alexey


--iVEvoCuHpGe550eV4BLBDCk1Dge1pr7wV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZSI5hDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5TeEQAIJe
AGKPbjtCtzcuh4Axy9zdX0k5BVUU8GfiAEYwfYTvws/ZOuqt7s7kKXUtQkZOBvfZ
j7aF4/cP1ojHxVBFzxfjgWEdheKZjZpzsbN9z0LFG76myr9tJB++zNCgeSBDf5q8
Cqno/lKHCpqrpk3h1/uZVl8CRFvmKsIE/JJAKCVqpz6wwXuTV7sRqQo3iNDzHyGu
VJ5OSWoGkEDKn42MRBaUW7gvs7YFChBv8DgiLxO6zoGtCN24Fwx7YQYoDk99BsJe
yhtzVe7JHwE74SXcQIJ9pCXgk+HmaqqgGenkcCfc3Jdgr76qBZvW3Q4/2odbYJU6
Ekk+PXclBewHVLlA2QTj4bcr1khKLLYRENQHY+GcU7tBUvNeeZIIdLVBhcpZr9QI
jTOP5PJuOkZCB6IEtNUCL87B6fDVKS3mez9VeXnSuQc08R6saaavKkm3ih9U31Ks
xFLor8PS+Ab9c4kqohvfxCHpGDy+AyoMxvmE7YPwYEWQR7yn+yTl4Usv9caTurV7
5Q2pnEB2PNHFr1Z8gbRaNuaPtKdGZT/ENwqMWf0KDIccDsUVyUgjA2y1uvvhQVt4
P8aknaQWylNVZ4MbUFjhCIi6G7TwHpHQ8m2n+WG6ZoRuUdSTiQuFr9hdmE8w6xoD
Gn3CoNEHlDwLkFUl+zvZ6AYtrA66yN5fweZIEWqQ
=apyu
-----END PGP SIGNATURE-----

--iVEvoCuHpGe550eV4BLBDCk1Dge1pr7wV--
