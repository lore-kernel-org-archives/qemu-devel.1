Received: from eggs.gnu.org ([2001:4830:134:3::10]:58505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6zbq-0002wN-RT
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6zbp-000467-GR
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:23:26 -0400
References: <20180412170711.GA6240@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1695266a-47ac-1f6d-49d1-bdfb81e0e345@redhat.com>
Date: Fri, 13 Apr 2018 16:23:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180412170711.GA6240@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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

On 2018-04-12 19:07, Alberto Garcia wrote:
> Hello,
>=20
> I mentioned this some time ago, but I'd like to retake it now: I'm
> checking how to copy arbitrary nodes on a backing chain, so if I have
> e.g.
>=20
>    [A] <- [B] <- [C] <- [D]
>=20
> I'd like to end up with
>=20
>    [A] <- [E] <- [C] <- [D]
>=20
> where [E] is a copy of [B]. The most obvious use case is to move [B]
> to a different storage backend.
>=20
> At the moment we can already copy [B] into [E] (outside QEMU) and then
> do
>=20
>    change-backing-file device=3D[D] image-node-name=3D[C] backing-file=3D=
[E]
>=20
> However this only changes the image on disk and the bs->backing_file
> string in memory. QEMU keeps using the [B] BlockDriverState, and we
> need to make it switch to [E].
>=20
> One possible way to do this would be to modify blockdev-mirror so the
> source image can be located anywhere on a chain. Currently there's
> bs->backing_blocker preventing that, plus qmp_blockdev_mirror()
> refuses to take any non-root source node. Other than permission
> changes I don't think the algorithm itself needs any additional
> modification, although I suppose we'd like to change the backing file
> as part of the same job, and that would require API changes.

Another way would be to write blockdev-copy. :-)

I don't think there should be a limitation which nodes can be used as
the source of blockdev-mirror, and I think the hardest part about
lifting that limitation is about thinking what might break...  Maybe we
should just drop the limitation and deal with the fallout later?  I
can't imagine a single node configuration where we'd want to disallow
copying off a node, so I suppose if that breaks in some edge case that
wouldn't be something we'd have to disallow again but we'd just have to
fix it.

> One other way is to have a more generic replace-node command which
> would call bdrv_replace_node(), but I don't know if we want to expose
> that and I don't have any other use case for it at the moment.

I think we do want to expose that.  As far as I'm informed, for graph
manipulation we want a command that can replace nodes (including
replacing nothing by a new node or replacing an existing node by
nothing, if the parent supports that).

Also, well, there is blockdev-mirror already has a @replaces parameter,
right?  That was supposed to work with quorum, but it seems obvious to
use it here, too.

Max
