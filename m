Received: from eggs.gnu.org ([2001:4830:134:3::10]:52685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbTDO-0005n3-QJ
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbTDN-0005Oh-HS
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:27:22 -0500
References: <20170202123045.GA24714@chaz.gmail.com>
	<f8a93c01-682e-fbcb-7b81-012f6df97465@redhat.com>
	<20170208140646.GA19518@chaz.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <11bfda2a-7799-a5d5-4ba0-37b2b9dd92f6@redhat.com>
Date: Wed, 8 Feb 2017 15:27:11 +0100
MIME-Version: 1.0
In-Reply-To: <20170208140646.GA19518@chaz.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LBLDcL1U1L5hX4NmfC4mwQAhVHmCURRU0"
Subject: Re: [Qemu-devel] [qcow2] how to avoid qemu doing
 lseek(SEEK_DATA/SEEK_HOLE)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephane Chazelas <stephane.chazelas@gmail.com>
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LBLDcL1U1L5hX4NmfC4mwQAhVHmCURRU0
From: Max Reitz <mreitz@redhat.com>
To: Stephane Chazelas <stephane.chazelas@gmail.com>
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <11bfda2a-7799-a5d5-4ba0-37b2b9dd92f6@redhat.com>
Subject: Re: [Qemu-devel] [qcow2] how to avoid qemu doing
 lseek(SEEK_DATA/SEEK_HOLE)?
References: <20170202123045.GA24714@chaz.gmail.com>
 <f8a93c01-682e-fbcb-7b81-012f6df97465@redhat.com>
 <20170208140646.GA19518@chaz.gmail.com>
In-Reply-To: <20170208140646.GA19518@chaz.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08.02.2017 15:06, Stephane Chazelas wrote:
> 2017-02-08 00:43:18 +0100, Max Reitz:
> [...]
>> OTOH, it may make sense to offer a way for the user to disable
>> lseek(SEEK_{DATA,HOLE}) in our "file" block driver. That way your issu=
e
>> would be solved, too, I guess. I'll look into it.
> [...]
>=20
> Thanks Max,
>=20
> Yes, that would work for me and other users of ZFS. What I do
> for now is recompile with those lseek(SEEK_{DATA,HOLE}) disabled
> in the code and it's working fine.
>=20
> As I already hinted, something that would also possibly work for
> me and could benefit everyone (well at least Linux users on
> filesystems supporting hole punching), is instead of checking
> beforehand if the file is allocated, do a
> fallocate(FALLOC_FL_PUNCH_HOLE), or IOW, tell the underlying
> layer to deallocate the data.
>=20
> That would be those two lseek() replaced by a fallocate(), and
> some extra disk space being saved.

When using qcow2, however, qcow2 will try to take care of that by
discarding clusters or using special zero clusters.

The lseek() thing just tries to mitigate the effect of writing less than
a cluster of zeroes. Yes, we could punch a hole, but is that faster or
has at least the same speed as lseek(SEEK_{DATA,HOLE}) on all filesystems=
?

Also, is it the same speed on all protocols? We not only support files
as image storage, but also network protocols etc..

But this is just generally speaking for the "write zeroes" case. With
detect-zeroes=3Dunmap (as opposed to detect-zeroes=3Don), things are a bi=
t
different. It may indeed make sense to fall through to the protocol
level and punch holes there, even if it may be slower than lseek().

> One may argue that's what one would expect would be done when
> using detect-zeroes=3Dunmap.

A bit of a stupid question, but: How is your performance when using
detect-zeroes=3Doff?

> I suppose that would be quite significant work as that would
> imply a framework to pass those "deallocates" down and you'd
> probably have to differenciate "deallocates" that zero (like
> hole punching in a reguar file), and those that don't (like
> BLKDISCARD on a SSD)

Well, we internally already have different functions for writing zeroes
and discarding. The thing is, though, that qcow2 is supposed to handle
those deallocations and not hand them down, because qcow2 can handle
them -- but not if they're not aligned to whole qcow2 clusters (which,
by default, are 64 kB in size).

Max

>=20
> I also suppose that could cause fragmentation that  would be
> unwanted in some contexts, so maybe it should be tunable as
> well.
>=20



--LBLDcL1U1L5hX4NmfC4mwQAhVHmCURRU0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlibKr8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AC94H/Rei8AXH3GXVVTxYcsFGBL6DWiuhN2DO
dANv6NP3U7OuQU2Ga19lMvcUw8plD8yfJJnIqIbfVapORa4Cvdg+MdMzZ7fWWUPy
GrbcTIm9fKh9PV4UT8yXKBUxoIujUE84GwVBDNC2yPnU52oOMBJFgt6Yy1uyl6+F
iTV4desTNbzcU6YF3eCnDM350QHfscHrDJKK8x/4T+/rgcX+qtYFbwYfq4d/ijAJ
4xjCD+KiJ2nIrHUbn+Eetig5ID3S+oPgNjDuZOCuEQ+NvS75WzkfeJmMMyi5zjeR
ciNmRQbLpbbL7sXyeW98jSDaezTWZD8NhM2S3w/VJ/Ftfa+mo1iuR6o=
=YFGa
-----END PGP SIGNATURE-----

--LBLDcL1U1L5hX4NmfC4mwQAhVHmCURRU0--
