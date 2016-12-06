Received: from eggs.gnu.org ([2001:4830:134:3::10]:58843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEHGh-0001Rd-3f
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEHGe-0005g4-2P
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:02:55 -0500
References: <1480589964-29411-1-git-send-email-w.bumiller@proxmox.com>
	<f67785d9-7f7e-703d-b026-3e9adbb04c5a@redhat.com>
	<20161205082639.GA17546@olga.wb>
	<20161206095921.GB4990@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd6faa78-fa3c-90f9-8ddb-905c9a29d9b3@redhat.com>
Date: Tue, 6 Dec 2016 09:02:33 -0600
MIME-Version: 1.0
In-Reply-To: <20161206095921.GB4990@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HIT7UNhoR6uQ9I7xTlMFawNn8uIclV3IU"
Subject: Re: [Qemu-devel] [RFC PATCH] glusterfs: allow partial reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc: qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HIT7UNhoR6uQ9I7xTlMFawNn8uIclV3IU
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc: qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <dd6faa78-fa3c-90f9-8ddb-905c9a29d9b3@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] glusterfs: allow partial reads
References: <1480589964-29411-1-git-send-email-w.bumiller@proxmox.com>
 <f67785d9-7f7e-703d-b026-3e9adbb04c5a@redhat.com>
 <20161205082639.GA17546@olga.wb>
 <20161206095921.GB4990@noname.str.redhat.com>
In-Reply-To: <20161206095921.GB4990@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2016 03:59 AM, Kevin Wolf wrote:

>>>> I'm not sure what the original rationale was to treat both partial
>>>> reads as well as well as writes as I/O error. (Seems to have happene=
d
>>>> from original glusterfs v1 to v2 series with a note but no reasoning=

>>>> for the read side as far as I could see.)
>>>> The general direction lately seems to be to move away from sector
>>>> based block APIs. Also eg. the NFS code allows partial reads. (It
>>>> does, however, have an old patch (c2eb918e3) dedicated to aligning
>>>> sizes to 512 byte boundaries for file creation for compatibility to
>>>> other parts of qemu like qcow2. This already happens in glusterfs,
>>>> though, but if you move a file from a different storage over to
>>>> glusterfs you may end up with a qcow2 file with eg. the L1 table in
>>>> the last 80 bytes of the file aligned to _begin_ at a 512 boundary,
>>>> but not _end_ at one.)
>=20
> Hm, does this really happen? I always thought that the file size of
> qcow2 images is aligned to the cluster size. If it isn't, maybe we
> should fix that.

Yes, it absolutely happens all the time!  In fact, it is often the case
that our images are not even sector-aligned, let alone cluster-aligned:

$ qemu-img create -f qcow2 file 1M
Formatting 'file', fmt=3Dqcow2 size=3D1048576 encryption=3Doff
cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
$ ls -l file
-rw-r--r--. 1 eblake eblake 196616 Dec  6 08:58 file
$ echo $((384*512))
196608
$ echo $((385*512))
197120

196616 is a fraction more than 384 sectors.

This is because the qcow2 format explicitly requires that if the L1 or
L2 table is at the end of the file (which is what happens by default in
qemu-img create), any entries not physically present in the table
(because the file ends early) are read as 0.

>>> Would it be better to switch to byte-based interfaces rather than
>>> continue to force gluster interaction in 512-byte sector chunks,
>>> since gluster can obviously store files that are not 512-aligned?
>=20
> The gluster I/O functions are byte-based anyway, and the driver already=

> implements .bdrv_co_readv, so going to .bdrv_co_preadv should be
> trivial. Probably the best solution here indeed.
>=20

Are we still hoping to fix this bug (the gluster behavior on unaligned
files, not the larger [non-?]bug of qemu-img create giving unaligned
images in the first place) for 2.8, or are we pushing our luck here,
where the correct patch should be 2.9 material and cc qemu-stable?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--HIT7UNhoR6uQ9I7xTlMFawNn8uIclV3IU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRtMJAAoJEKeha0olJ0NqNSAH/RNbKHhAk6our2SDgmvCtEVz
KlGtk38DynkRuSrky7CztoZQNFTs+kgk5Wiq/1DCRplNU3++8lJMRuRK4+Rscugz
Zp3/8GV/rMUYAQ8ot9xF8Dyq1ec0GJS/JWxx/1CxFELF9kJu/Lc96giLFeHxHmuf
s8cMiTdfdqEQb6xowCWoDgI+pqobVprOj/YqrGnxdqSAuS4P60rYJCT2is6xdOrX
Zqp+4vqVYxGzLuXEj0+1V+g+0fjhFKRt/CEuGCziKyHbcsBjg4FbN2Q9jGM1jFq/
Cra0zC4NdbIq19yLUIx5iTxKEgp4djplJz39aOL72NwdP3lIkQGGpm7GAbreQnU=
=BleN
-----END PGP SIGNATURE-----

--HIT7UNhoR6uQ9I7xTlMFawNn8uIclV3IU--
