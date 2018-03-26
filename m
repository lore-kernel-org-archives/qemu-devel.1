Received: from eggs.gnu.org ([2001:4830:134:3::10]:38062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f0We0-00027j-Vb
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f0We0-0006SO-7a
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:14:56 -0400
References: <CAGhAadf5A=t=0CM6bC3LaUf-53NV8PynHgQ2A5_UtL+hE5eZUg@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <45f3dc22-709c-7f76-20cb-b9b25c9d2c9e@redhat.com>
Date: Mon, 26 Mar 2018 20:14:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAGhAadf5A=t=0CM6bC3LaUf-53NV8PynHgQ2A5_UtL+hE5eZUg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QOWK18pPX1t22lq7L19XwgSq0On9ZV5MC"
Subject: Re: [Qemu-devel] qemu-nbd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pascal <patatetom@gmail.com>, nbd@other.debian.org, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QOWK18pPX1t22lq7L19XwgSq0On9ZV5MC
From: Max Reitz <mreitz@redhat.com>
To: Pascal <patatetom@gmail.com>, nbd@other.debian.org,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Message-ID: <45f3dc22-709c-7f76-20cb-b9b25c9d2c9e@redhat.com>
Subject: Re: qemu-nbd
References: <CAGhAadf5A=t=0CM6bC3LaUf-53NV8PynHgQ2A5_UtL+hE5eZUg@mail.gmail.com>
In-Reply-To: <CAGhAadf5A=t=0CM6bC3LaUf-53NV8PynHgQ2A5_UtL+hE5eZUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-22 13:17, Pascal wrote:
> hi everybody,
>=20
> when I use `qemu-nbd -s -c /dev/nbd0 /dev/sda` where are changes to
> /dev/ndb0 saved ?
> I searched in /proc/{pid_of_qemu-nbd}/ but found nothing there...

In snapshot mode, qemu (or in this case qemu-nbd) creates a temporary
qcow2 file in $TMPDIR (or /var/tmp) which will get the changes.  You
should see a link to that file in /proc/$pid/fd, like this:

lrwx------. [...] 10 -> /var/tmp/vl.JjYLDm (deleted)

As you can see, the file is deleted right after it is opened, though.

If you want to have control over where the data is stored, you can just
create the overlay yourself, like so:

$ qemu-img create -f qcow2 -b /dev/sda -F raw overlay.qcow2
$ qemu-nbd -c /dev/nbd0 overlay.qcow2

Max


--QOWK18pPX1t22lq7L19XwgSq0On9ZV5MC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlq5OI8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AzVIH/igD751OUkfRT9gUBRv0FxAYeVW3g41j
HAlhtxmpUxI8Jk1nxjlsye8sLSOwSSvqhMhjP/MPDjkzxsXGiRYSFosriV7HOKo/
eP6F5xtCPvCaNXcvS303NDXNfW0kdpzLmh6qqj9Ut1kztaZXoTSqfjKNVZ8n0hOg
Iu8KTIrQdstaKRqW1DQ42mJLZy61rs90VKUVCgXZtCdM8K8E+R8PgPn/rCwbf5NT
5KIiFRyXpkMPe4BCfYSitwuvdDDILTJ6+G6wNBpA07vgNXzKyyrauzPo9D1zgjr0
hE3iVgPgeJ8QgUAyu1CKqvEwSPXdIrBJVN7dl/JxgkplXRL486t7yN4=
=742N
-----END PGP SIGNATURE-----

--QOWK18pPX1t22lq7L19XwgSq0On9ZV5MC--
