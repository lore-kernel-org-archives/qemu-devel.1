Received: from eggs.gnu.org ([2001:4830:134:3::10]:43493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cIyNu-0002Jv-Gk
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cIyNr-0005Sc-CJ
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:53:46 -0500
Date: Mon, 19 Dec 2016 13:53:39 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161219135339.GD17374@stefanha-x1.localdomain>
References: <20161215154330.700-1-pasic@linux.vnet.ibm.com>
	<20161216102528.GB4129@stefanha-x1.localdomain>
	<86f7031a-981a-ef51-8a20-0a3c38e88835@linux.vnet.ibm.com>
	<CAJSP0QVZQ=AXb+gZ3VftkYZ2y=SM_3uhV4VMAmK7GEmJYmpgHQ@mail.gmail.com>
	<c34179a0-edbb-cc28-7c28-aa34936877bd@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
In-Reply-To: <c34179a0-edbb-cc28-7c28-aa34936877bd@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: fix vring->inuse recalc after migr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2016 at 05:43:29PM +0100, Halil Pasic wrote:
>=20
>=20
> On 12/16/2016 05:12 PM, Stefan Hajnoczi wrote:
> >> You are not the first one complaining, so the sentence is definitively
> >> bad. What disturbs me regarding your formulation is that we do not use
> >> uint16_t to represent neither the ring size nor inuse.
> >>
> >> How about "Since max ring size < UINT16_MAX it's safe to use modulo
> >> UINT16_MAX + 1 subtraction."?
> > That doesn't mention "representing the size of the ring" so it's
> > unclear what "safe" means.
> >=20
> > Stefan
> >=20
>=20
> IMHO it is not about representation but about correct arithmetic.
> We introduce the cast, not because representing the ring size as
> int is necessarily an issue, but because we ended up with a wrong
> result. In my opinion how can 'inuse' be represented correctly and
> efficiently concerns the member of struct VirtQueue.

Fair enough, the type of VirtQueue.inuse doesn't need to be justified at
this point in the code.

> Here the important point is how conversions between signed unsigned
> integer types work in C.
>=20
> """
> 6.3.1.3 Signed and unsigned integers
> 1 When a value with integer type is converted to another integer
> type other than _Bool, if  the value can be represented by the new
> type, it is unchanged.
> 2 Otherwise, if the new type is unsigned, the value is converted by
> repeatedly adding or  subtracting one more than the maximum value that
> can be represented in the new type until the value is in the range
> of the new type.
> """
>=20
> That is we get mod UINT16_MAX + 1  subtraction which is what we
> need if we want to calculate the difference between the two counters
> under the assumption that the actual conceptual difference (that
> is if the counters where of type arbitrary natural) is less or equal that
> queue size which is less than UINT16_MAX.

-            vdev->vq[i].inuse =3D vdev->vq[i].last_avail_idx -
-                                vdev->vq[i].used_idx;
+            vdev->vq[i].inuse =3D (uint16_t)(vdev->vq[i].last_avail_idx -
+                                vdev->vq[i].used_idx);

Looking at C99 I learnt the cause of the bug is the integer promotion
performed on the uint16_t subtraction operands.  Previously I was only
aware of integer promotion on varargs and function arguments where no
prototype is declared.

So the original statement behaves like:

vdev->vq[i].inuse =3D (int)vdev->vq[i].last_avail_idx -
                    (int)vdev->vq[i].used_idx;

This is the real gotcha for me.

If you feel it helps to explain the signed -> unsigned cast behavior,
feel free.  I don't think it's necessary.

Stefan

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYV+ZjAAoJEJykq7OBq3PI7QAH/RBd2aAKcMlXzSLFYBLvuhN0
3RPg6aodUIffltRRItt6x0tYgGv81UGqPVzrt3ZwvK9lzQQItmE6Bi6q3U7oaqZB
3EZipeynjWHin7EtzPKlyymVc9O2lLaYX2hndgH884O4/xPF503I0SXWPZEcZpzB
s4Ao2IecgdBeYtLvdyw4qRPFNUEV3p3+wLyxqTiOxLsLFxpcRvPhQXLH/A1D94PJ
iG7OY7cdcewBKuCX8JTKcsF44OVFRHeZF2pNj7dBuQX44eq6vMZZ7scc+3yJ53+B
DEYroKPymxoi2E70x89ISqZaaPd988zDeuC1D200O1/ncPFrNvEebLTnluUHAEo=
=rOMT
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
