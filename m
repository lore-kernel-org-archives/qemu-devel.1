Received: from eggs.gnu.org ([2001:4830:134:3::10]:35834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEHZ5-0001EU-H2
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEHZ4-0003QB-8w
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:21:55 -0500
References: <20161205234235.5728-1-eblake@redhat.com>
	<20161206092523.GA4990@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <871488c7-b870-da8f-1a71-c2462214e650@redhat.com>
Date: Tue, 6 Dec 2016 09:21:42 -0600
MIME-Version: 1.0
In-Reply-To: <20161206092523.GA4990@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i6oRtubBbos6M5sNo1uMH7T6ilnd8bJIc"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] doc: Propose
 NBD_FLAG_INIT_ZEROES extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: nbd-general@lists.sourceforge.net, xieyingtai@huawei.com, subo7@huawei.com, qemu-block@nongnu.org, eric.fangyi@huawei.com, qemu-devel@nongnu.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i6oRtubBbos6M5sNo1uMH7T6ilnd8bJIc
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: nbd-general@lists.sourceforge.net, xieyingtai@huawei.com,
 subo7@huawei.com, qemu-block@nongnu.org, eric.fangyi@huawei.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Message-ID: <871488c7-b870-da8f-1a71-c2462214e650@redhat.com>
Subject: Re: [Qemu-block] [PATCH] doc: Propose NBD_FLAG_INIT_ZEROES extension
References: <20161205234235.5728-1-eblake@redhat.com>
 <20161206092523.GA4990@noname.str.redhat.com>
In-Reply-To: <20161206092523.GA4990@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2016 03:25 AM, Kevin Wolf wrote:
> Am 06.12.2016 um 00:42 hat Eric Blake geschrieben:
>> While not directly related to NBD_CMD_WRITE_ZEROES, the qemu
>> team discovered that it is useful if a server can advertise
>> whether an export is in a known-all-zeroes state at the time
>> the client connects.
>=20
> Does a server usually have the information to set this flag, other than=

> querying the block status of all blocks at startup? If so, the client
> could just query this by itself.

Well, only if the client can query information at all (we don't have the
documentation finished for extent queries, let alone a reference
implementation).

>=20
> The patch that was originally sent to qemu-devel just forwarded qemu's
> .bdrv_has_zero_init() call to the server. However, what this function
> returns is not a known-all-zeroes state on open, but just a
> known-all-zeroes state immediately after bdrv_create(), i.e. creating a=

> new image. Then it becomes information that is easy to get and doesn't
> involve querying all blocks (e.g. true for COW image formats, true for
> raw on regular files, false for raw on block devices).

Just because the NBD spec describes the bit does NOT require that
servers HAVE to set the bit on all images that are all zeroes.  It is
perfectly compliant if the server never advertises the bit.  That said,
I think there are cases where qemu can easily advertise the bit.

I _do_ agree that it is NOT as trivial as the qemu server just
forwarding the value of .bdrv_has_zero_init() - the server HAS to prove
that no data has been written to the image.  But for a qcow2 image just
created with qemu-img, it is a fairly easy proof: If the L1 table has
all-zero entries, then the image has not been written to yet.  Reading
the L1 table for all-zeroes is only a single cluster read, which is MUCH
faster than crawling the entire image for extent status.  And for
regular files, a single lseek(SEEK_DATA) is sufficient to see if the
entire image is currently sparse.

Note that I only proposed the NBD implementation - it still remains to
be coded into the qemu code for the client to make use of the bit
(fairly easy: if the bit is set, the client can make its own
=2Ebdrv_has_zero_init() return true), as well as for the server to set th=
e
bit (harder: the server has to check .bdrv_has_zero_init() of the
wrapped image, but also has to prove the image is still unwritten).
Maybe this means that qemu's block layer wants to add a new
=2Ebdrv_has_been_written() [or whatever name] to better abstract the proo=
f
across drivers.  But those patches would be qemu 2.9 material, and do
not need to further cc the NBD list.

>=20
> This is useful for 'qemu-img convert', which creates an image and then
> writes the whole contents, but I'm not sure if this property is
> applicable for NBD, which I think doesn't even have a create operation.=


Another option on the NBD server side is to create a server option -
when firing up a server to serve a particular file as an export, the
user can explicitly tell the server to advertise the bit because the
user has side knowledge that the file was just created (and then the
burden of misbehavior is on the user if they mistakenly request the
advertisement when it is not true).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--i6oRtubBbos6M5sNo1uMH7T6ilnd8bJIc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRteGAAoJEKeha0olJ0NqG5UH/12iEPL6jTLJm4H/haWrQFs6
XEUq6anU75J156j2+4P1mYxHCvE5Qw4K5IUGx4DCJt7FHEQYyMYvmsyWZoswvpr/
JGhU9bWaLWtdsjOmsCMk1cbmJXt+U141BPB9LkEJU4sAKyjDxwTLc8Q61RplJPBR
tPBbaWBT12XiqRfsGTULnjlaLaVG+MGDF4IbXNXsFXSvfVoK+Xl9FjF1m2IHP8hk
NH1xdNb8Lhc3+R+F/hFB5mEROn87owjpk3+LRPuSwgyXRrFd/p+rESqlEFwxF2Od
eOHjR+Y9iUq84ozC+x+bka9AGo68Fpv+rm4davnm3yMaTCFOj7ssK3+x1jpKWVs=
=1zsd
-----END PGP SIGNATURE-----

--i6oRtubBbos6M5sNo1uMH7T6ilnd8bJIc--
