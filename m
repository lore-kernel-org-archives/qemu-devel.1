Received: from eggs.gnu.org ([2001:4830:134:3::10]:60559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEHNU-0003eP-Dt
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:09:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEHNO-0007ut-H7
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:09:56 -0500
Date: Tue, 6 Dec 2016 16:09:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161206150942.GF4990@noname.str.redhat.com>
References: <1480589964-29411-1-git-send-email-w.bumiller@proxmox.com>
	<f67785d9-7f7e-703d-b026-3e9adbb04c5a@redhat.com>
	<20161205082639.GA17546@olga.wb>
	<20161206095921.GB4990@noname.str.redhat.com>
	<dd6faa78-fa3c-90f9-8ddb-905c9a29d9b3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <dd6faa78-fa3c-90f9-8ddb-905c9a29d9b3@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] glusterfs: allow partial reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.12.2016 um 16:02 hat Eric Blake geschrieben:
> On 12/06/2016 03:59 AM, Kevin Wolf wrote:
>=20
> >>>> I'm not sure what the original rationale was to treat both partial
> >>>> reads as well as well as writes as I/O error. (Seems to have happened
> >>>> from original glusterfs v1 to v2 series with a note but no reasoning
> >>>> for the read side as far as I could see.)
> >>>> The general direction lately seems to be to move away from sector
> >>>> based block APIs. Also eg. the NFS code allows partial reads. (It
> >>>> does, however, have an old patch (c2eb918e3) dedicated to aligning
> >>>> sizes to 512 byte boundaries for file creation for compatibility to
> >>>> other parts of qemu like qcow2. This already happens in glusterfs,
> >>>> though, but if you move a file from a different storage over to
> >>>> glusterfs you may end up with a qcow2 file with eg. the L1 table in
> >>>> the last 80 bytes of the file aligned to _begin_ at a 512 boundary,
> >>>> but not _end_ at one.)
> >=20
> > Hm, does this really happen? I always thought that the file size of
> > qcow2 images is aligned to the cluster size. If it isn't, maybe we
> > should fix that.
>=20
> Yes, it absolutely happens all the time!  In fact, it is often the case
> that our images are not even sector-aligned, let alone cluster-aligned:
>=20
> $ qemu-img create -f qcow2 file 1M
> Formatting 'file', fmt=3Dqcow2 size=3D1048576 encryption=3Doff
> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> $ ls -l file
> -rw-r--r--. 1 eblake eblake 196616 Dec  6 08:58 file
> $ echo $((384*512))
> 196608
> $ echo $((385*512))
> 197120
>=20
> 196616 is a fraction more than 384 sectors.
>=20
> This is because the qcow2 format explicitly requires that if the L1 or
> L2 table is at the end of the file (which is what happens by default in
> qemu-img create), any entries not physically present in the table
> (because the file ends early) are read as 0.
>=20
> >>> Would it be better to switch to byte-based interfaces rather than
> >>> continue to force gluster interaction in 512-byte sector chunks,
> >>> since gluster can obviously store files that are not 512-aligned?
> >=20
> > The gluster I/O functions are byte-based anyway, and the driver already
> > implements .bdrv_co_readv, so going to .bdrv_co_preadv should be
> > trivial. Probably the best solution here indeed.
> >=20
>=20
> Are we still hoping to fix this bug (the gluster behavior on unaligned
> files, not the larger [non-?]bug of qemu-img create giving unaligned
> images in the first place) for 2.8, or are we pushing our luck here,
> where the correct patch should be 2.9 material and cc qemu-stable?

I think we're too late for 2.8.

Kevin

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYRtS2AAoJEH8JsnLIjy/WKl8P/iSXNvcGHtQNywXnBT76FB4D
espu1sicIHxPxORUJQHEivFgRHtOJip0v3iW25hKT+i/RDFEbIeItD202gZRkyR/
qs8vqzu1Pw5ytZ22IKV0waBhQPOCou1TDo5XAn1jjhdgvdaT6tyU/BGgWP6XJjCw
ARbwo73cyBFc2bKPOJYIkKsJOXFz4ez7Ga5SO9tBgBGAVvjbehVdNaotS+iH7AFa
DwwdNd6zTklYVKJnyu9iOgZOcOlGVSicDFvxc79gEjq7W3+dy2HU9fNB8XbE8iX2
PSQMG+0TuPjR13MXtmPEi9S5U/4l7/wO9y3RBWzsEgiDToNzC96rB/Smv1eZz/Pk
8g2S0BlndY6MVP2LRpABkvP/jgw0h6SUZb7KYf+aEbLVTppd+GnVXaDCWWrWGiXV
S206KcU01tOv7T0L/x5OyLrIo7omT7iO9tF4O8b6b6XbVRGCrNcUDPphHvMHwgkY
9MLKl0zP9H8D42y2hd9hY/tbz4j04hdFmSbUk74UCg+6DLJn2SLRBeP2XtmJyAvi
1ie5UVJrUrQqlLeO4N1fCd5a9Fsgr756xfQ8tL0MuShKpc9GUwWhnjIwJzUDD1tY
vJCz+eKK3VAEdI3K3+HOinQkGl6OlS4BA7p4LasUU/XVyysrNempRiT1SEPswelm
oi9Z4zPrgDTPFN+JRvgH
=MmKB
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
