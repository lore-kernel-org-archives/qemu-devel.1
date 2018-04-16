Received: from eggs.gnu.org ([2001:4830:134:3::10]:56100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f85r2-0002Au-Is
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 11:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f85r1-0005s5-71
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 11:15:40 -0400
References: <20180412170711.GA6240@igalia.com>
	<1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
	<w517ep7gpsz.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
Date: Mon, 16 Apr 2018 17:15:21 +0200
MIME-Version: 1.0
In-Reply-To: <w517ep7gpsz.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iUOI3PJf8Z0XH0uG7r6CRnZxoKCzkNA0P"
Subject: Re: [Qemu-devel] [RFC] Intermediate block mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iUOI3PJf8Z0XH0uG7r6CRnZxoKCzkNA0P
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <ee24e79d-b37e-ac8f-c349-b0fa637ba2a6@redhat.com>
Subject: Re: [RFC] Intermediate block mirroring
References: <20180412170711.GA6240@igalia.com>
 <1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
 <w517ep7gpsz.fsf@maestria.local.igalia.com>
In-Reply-To: <w517ep7gpsz.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-16 16:59, Alberto Garcia wrote:
> On Fri 13 Apr 2018 04:23:07 PM CEST, Max Reitz wrote:
>> On 2018-04-12 19:07, Alberto Garcia wrote:
>>> Hello,
>>>
>>> I mentioned this some time ago, but I'd like to retake it now: I'm
>>> checking how to copy arbitrary nodes on a backing chain, so if I have=

>>> e.g.
>>>
>>>    [A] <- [B] <- [C] <- [D]
>>>
>>> I'd like to end up with
>>>
>>>    [A] <- [E] <- [C] <- [D]
>>>
>>> where [E] is a copy of [B]. The most obvious use case is to move [B]
>>> to a different storage backend.
>>>
>>> At the moment we can already copy [B] into [E] (outside QEMU) and the=
n
>>> do
>>>
>>>    change-backing-file device=3D[D] image-node-name=3D[C] backing-fil=
e=3D[E]
>>>
>>> However this only changes the image on disk and the bs->backing_file
>>> string in memory. QEMU keeps using the [B] BlockDriverState, and we
>>> need to make it switch to [E].
>>>
>>> One possible way to do this would be to modify blockdev-mirror so the=

>>> source image can be located anywhere on a chain. Currently there's
>>> bs->backing_blocker preventing that, plus qmp_blockdev_mirror()
>>> refuses to take any non-root source node. Other than permission
>>> changes I don't think the algorithm itself needs any additional
>>> modification, although I suppose we'd like to change the backing file=

>>> as part of the same job, and that would require API changes.
>>
>> Another way would be to write blockdev-copy. :-)
>=20
> Something like blockdev-backup but without copying data from backing
> files? blockdev-mirror already allows configuring that using the
> MirrorSyncMode parameter.

No, a block job that unites blockdev-backup, blockdev-mirror, and
block-commit.

Active commit already is just mirror, non-active commit probably can
easily be implemented with mirror (we just need an auto-complete), and
it should be possible to add a backup mode to mirror (like active
mirroring).  So we'd just have a single blockdev-copy job that can
simply... Copy data from any node to any other.

I think we wanted to exclude streaming, because that works differently.
But, well, streaming would be just installing a COR filter node and
doing a blockdev-copy to null-co://, right? :-)

>> I don't think there should be a limitation which nodes can be used as
>> the source of blockdev-mirror, and I think the hardest part about
>> lifting that limitation is about thinking what might break...  Maybe
>> we should just drop the limitation and deal with the fallout later?  I=

>> can't imagine a single node configuration where we'd want to disallow
>> copying off a node, so I suppose if that breaks in some edge case that=

>> wouldn't be something we'd have to disallow again but we'd just have
>> to fix it.
>=20
> I can't think of any problem either. The important question is what to
> do if the source node is read/write, but that's what blockdev-mirror is=

> already about. In all other cases the source node is going to be read
> only, isn't it?

I guess so.

I just now remembered a bitmap issue, but that probably shouldn't stop
you.  There is an issue with bitmaps on nodes with shared-writing childre=
n.

Imagine you have some qcow2 node or whatever, and you have a guest
running on it.  Then you attach a filter to it (which allows shared
writing) and put a mirror job on top of the filter.  Now whenever the
guest writes to the qcow2 node, the bitmap the mirror job installed on
the filter won't reflect that.  So that's an issue, but I think that
case isn't forbidden by the current permission system, so we're already
screwed there.

So on the contrary, I'd suspect that running mirror inside of some
backing chain or whatever may be less problematic than running it on
top, actually...

>>> One other way is to have a more generic replace-node command which
>>> would call bdrv_replace_node(), but I don't know if we want to expose=

>>> that and I don't have any other use case for it at the moment.
>>
>> I think we do want to expose that.  As far as I'm informed, for graph
>> manipulation we want a command that can replace nodes (including
>> replacing nothing by a new node or replacing an existing node by
>> nothing, if the parent supports that).
>=20
> Was there any discussion about this in the mailing list? (proposed name=

> for this function, features, etc.)

Well, there is x-blockdev-change.  But we probably want to expose
bdrv_reopen() in the long run.

http://lists.nongnu.org/archive/html/qemu-block/2017-12/msg00522.html is
what I can offer you.  That also has some info on blockdev-copy and the
bitmap issue ("omniscient bitmaps" is the keyword).

Max

>> Also, well, there is blockdev-mirror already has a @replaces
>> parameter, right?  That was supposed to work with quorum, but it seems=

>> obvious to use it here, too.
>=20
> Yes, it could be used for this.
>=20
> Berto
>=20



--iUOI3PJf8Z0XH0uG7r6CRnZxoKCzkNA0P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrUvgkACgkQ9AfbAGHV
z0D1xQf+Oh7CSv4MhFi8S2XmKbF0zjZB0njq9QanNuntxXCicQh1zbJeVwiVzVrR
ywK0rnAHRFCLDxUgylWbXLpeyBN8ZJ2ONc6BvGrg5d68/H8GDFKlOVRRd8bDn1iZ
IKq3nplzulXf/dBVtb1r57RWiF9Sf8vGJ0aDA/pZuocOe+TnLbpXb5sjjP3xL3Sh
2rNbxdtI382Z6SmtJw0bZcYVdVTJd1anS2ZjoPz45c7V4DHO2Xuu3rgFjGgTHinY
Hx0bK6Sx2Dt0N0VLch4ZdWqxhjupVeR16LLdmpZ9vsurWcLS9qxU/gWNJzGytKYW
um0M1x8toj3wvEwdF7qHCXOkkCrFrg==
=UzRd
-----END PGP SIGNATURE-----

--iUOI3PJf8Z0XH0uG7r6CRnZxoKCzkNA0P--
