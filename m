Received: from eggs.gnu.org ([2001:4830:134:3::10]:34281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gHAW1-0000nP-8J
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gHAVx-00062m-4V
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:35:45 -0400
References: <CAFEAcA8R6dPxEq=-6oZiHSzgkaMWfjyKvXip6FG4h5HWj4mtwQ@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c4bf0aa6-f53e-7197-e2d4-c3a553af378c@redhat.com>
Date: Mon, 29 Oct 2018 17:35:09 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8R6dPxEq=-6oZiHSzgkaMWfjyKvXip6FG4h5HWj4mtwQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="juRCGP8DIwlGsAN4q2IysVZdP4uUQcn6o"
Subject: Re: [Qemu-devel] [Qemu-block] could somebody who understands the
 block refcounting look at CID 1395870, CID 1395871?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--juRCGP8DIwlGsAN4q2IysVZdP4uUQcn6o
From: Max Reitz <mreitz@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Message-ID: <c4bf0aa6-f53e-7197-e2d4-c3a553af378c@redhat.com>
Subject: Re: [Qemu-block] could somebody who understands the block refcounting
 look at CID 1395870, CID 1395871?
References: <CAFEAcA8R6dPxEq=-6oZiHSzgkaMWfjyKvXip6FG4h5HWj4mtwQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8R6dPxEq=-6oZiHSzgkaMWfjyKvXip6FG4h5HWj4mtwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.10.18 11:51, Peter Maydell wrote:
> Hi; could somebody who understands the block layer refcounting have
> a look at Coverity issues CID 1395870 and 1395871, please?

Don't forget 1395869.

> In both
> cases, Coverity reports a use-after-free because it thinks that a
> sequence where a code path might (conditionally) end up calling
> blk_deref() twice could be freeing the memory in the first call
> and using it after. I'm not sure whether these are false positives
> because the refcounting has confused Coverity, or genuine issues where
> we have got refcounting logic wrong, so I don't know if we need a
> fix or if we should squash the coverity bug as a false-positive...

It looks basically reasonable to me (just like 1395869).  All of these
block devices have two refcounts, one from the device state, and one
from the monitor.  These three places drop both refcounts after one anoth=
er.

On first glance I found the order in qdev-properties-system.c a bit
weird because it unrefs the monitor reference first (which is definitely
there), and the device state reference only afterwards (which piix.c
implies may or may not be there).  However, @dev cannot be NULL
(otherwise "*ptr" would have segfaulted), so the device state reference
is guaranteed to be there.  OTOH, it appears that in this case the
monitor reference may be missing, so it's correct to try to drop that
reference first here, in case there is none.

So all looks good to me, I'll mark them as false positives (like Paolo
has done for 1395869 already).

Max


--juRCGP8DIwlGsAN4q2IysVZdP4uUQcn6o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvXNr0ACgkQ9AfbAGHV
z0Cc0wf9GSut1yybrpYRZYy+yQ5uo4/4O1EG5EaDIkBb+kekOesGvG8qBWPFsDi5
uJjVHtjgBYMuwLDJIt5J9BTdexuNz7jo/Nmg//f0Luh+Xb1AhKluNpwC3IGjQ2tT
bvJJc96l4CMd/vuHQii+RxeIq2GRtskbYYt3xE/YrU6Zho8NC6tZrSJz6mJ/3bnx
2rzXuyTojX9C3SHRgAW+/JfgD3jGXc5P/iAnPgeJrwGyc9qHb5mR2tNExaN6kDqx
R6F1cQY+xnmNTdmafrExYnt8Npf6cg4cv1FMC/P4klnzQ99dWbIMXFhDVgYuAezM
0OjwtcohoMTsOfi7OXmJyjj8Oiy0Sg==
=cEc5
-----END PGP SIGNATURE-----

--juRCGP8DIwlGsAN4q2IysVZdP4uUQcn6o--
