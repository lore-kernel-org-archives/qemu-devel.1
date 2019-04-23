Received: from eggs.gnu.org ([209.51.188.92]:49059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hIuTm-000283-RO
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hIuHf-0003AK-UV
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:12:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hIuHf-00039l-L6
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:12:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E65362D4B78
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 12:12:22 +0000 (UTC)
Date: Tue, 23 Apr 2019 14:12:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190423121218.GF9041@localhost.localdomain>
References: <20190423113028.GD30014@wheatley>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20190423113028.GD30014@wheatley>
Subject: Re: [Qemu-devel] Possibly incorrect data sparsification by qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Kletzander <mkletzan@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Jones <rjones@redhat.com>, Eric Blake <eblake@redhat.com>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 23.04.2019 um 13:30 hat Martin Kletzander geschrieben:
> Hi,
>=20
> I am using qemu-img with nbdkit to transfer a disk image and the update i=
t with
> extra data from newer snapshots.  The end image cannot be transferred bec=
ause
> the snapshots will be created later than the first transfer and we want t=
o save
> some time up front.  You might think of it as a continuous synchronisatio=
n.  It
> looks something like this:
>=20
> I first transfer the whole image:
>=20
>  qemu-img convert -p $nbd disk.raw
>=20
> Where `$nbd` is something along the lines of `nbd+unix:///?socket=3Dnbdki=
t.sock`
>=20
> Then, after the next snapshot is created, I can update it thanks to the `=
-n`
> parameter (the $nbd now points to the newer snapshot with unchanged data =
looking
> like holes in the file):
>=20
>  qemu-img convert -p -n $nbd disk.raw
>=20
> This is fast and efficient as it uses block status nbd extension, so it o=
nly
> transfers new data.

This is an implementation detail. Don't rely on it. What you're doing is
abusing 'qemu-img convert', so problems like what you describe are to be
expected.

> This can be done over and over again to keep the local
> `disk.raw` image up to date with the latest remote snapshot.
>=20
> However, when the guest OS zeroes some of the data and it gets written in=
to the
> snapshot, qemu-img scans for those zeros and does not write them to the
> destination image.  Checking the output of `qemu-img map --output=3Djson =
$nbd`
> shows that the zeroed data is properly marked as `data: true`.
>=20
> Using `-S 0` would write zeros even where the holes are, effectively over=
writing
> the data from the last snapshot even though they should not be changed.
>=20
> Having gone through some workarounds I would like there to be another way=
=2E  I
> know this is far from the typical usage of qemu-img, but is this really t=
he
> expected behaviour or is this just something nobody really needed before?=
  If it
> is the former, would it be possible to have a parameter that would contro=
l this
> behaviour?  If the latter is the case, can that behaviour be changed so t=
hat it
> properly replicates the data when `-n` parameter is used?
>=20
> Basically the only thing we need is to either:
>=20
> 1) write zeros where they actually are or
>=20
> 2) turn off explicit sparsification without requesting dense image (basic=
ally
>    sparsify only the par that is reported as hole on the source) or
>=20
> 3) ideally, just FALLOC_FL_PUNCH_HOLE in places where source did report d=
ata,
>    but qemu-img found they are all zeros (or source reported HOLE+ZERO wh=
ich, I
>    believe, is effectively the same)
>=20
> If you want to try this out, I found the easiest reproducible way is using
> nbdkit's data plugin, which can simulate whatever source image you like.

I think what you _really_ want is a commit block job. The problem is
just that you don't have a proper backing file chain, but just a bunch
of NBD connections.

Can't you get an NBD connection that already provides the condensed form
of the whole snapshot chain directly at the source? If the NBD server
was QEMU, this would actually be easier than providing each snapshot
individually.

If this isn't possible, I think you need to replicate the backing chain
on the destination instead of converting into the same image again and
again so that qemu-img knows that it must take existing data of the
backing file into consideration:

    qemu-img convert -O qcow2 nbd://... base.qcow2
    qemu-img convert -O qcow2 -F qcow2 -B base.qcow2 nbd://... overlay1.qco=
w2
    qemu-img convert -O qcow2 -F qcow2 -B overlay1.qcow2 nbd://... overlay2=
=2Eqcow2
    ...

And at the end you can merge the snapshot chain (using a commit or
stream b=C4=BAock job, or qemu-img commit/rebase).

Kevin

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcvwEiAAoJEH8JsnLIjy/W7FUQALrCfi/4GvfD1v6q2iK3PXb6
Y+0eRQApdfYkn52gSFciYcIfO/PvQPSoeoo6IbwYnXNALNida1im59P+ne02l+S1
9/vHxnwkJ1c+aabWMVYkQy2fFU/5eLggt+V8yY+vnH4bDNBwTvEkrRvnoyyduIEQ
NHremXwNVv99gAb1bvTP6+iHohYHJKr+H5CSVB1gJhXPa2el13l8eXNKRH34xF6o
fsrCuRuS7YGYrHP1tCpU4uXTA2Axfm1rKzZPYIvkEk/UUDYH4kOuoSTezOwwU2eB
4OPNaLSzwUUNG5pWPNuI/UldxPi8aUlfSMq6wdyNMgJ252HPwhaluk6Yxw4nX0P5
bHDyyFQ4ZG9aT5Cdc7D0MauSakWyFSX8yEr1iKgpqMF9ny3x+7xNRVouH6RAg5+Y
D3CZbYC/qqZxXpE+4KGBNhiSHR2rJb/cfBAHFzOJHw7WOpovQfE3Y/TfnN3eYqD0
L4LC7wmHrD3OXZIE//lMxBvVxIgOEd3nif7QA6b+ACTlR6vzHAT6BWAxwI57zgnx
209TMpltBylZ5ObLnnCVAimCn2fnQiw8FgTWdVUleYDHKbnCT7mThVf4D0HKz7wO
uSCshLngsHRAurMOUvmOS6jmXBF8Np3oYRD7XSBDXfQJTuT1u33N/bl/TSJcIoer
uWtVNO4Nz7JmnqcEIlDj
=wSaw
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
