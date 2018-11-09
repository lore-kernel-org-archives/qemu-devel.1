Received: from eggs.gnu.org ([2001:4830:134:3::10]:53003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gLFZO-0001OO-Eo
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 17:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gLFZN-0000U3-IX
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 17:48:06 -0500
References: <20180809223117.7846-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f1ea28e4-d5bd-ce22-74db-f108a22d2afa@redhat.com>
Date: Fri, 9 Nov 2018 16:47:57 -0600
MIME-Version: 1.0
In-Reply-To: <20180809223117.7846-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/11] block: Deal with filters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 8/9/18 5:31 PM, Max Reitz wrote:
> Note 1: This series depends on v10 of my =E2=80=9Cblock: Fix some filen=
ame
> generation issues=E2=80=9D series.
>=20
> Based-on: <20180809213528.14738-1-mreitz@redhat.com>
>=20
> Note 2: This is technically the first part of my active mirror followup=
.
> But just very technically.  I noticed that that followup started to
> consist of two parts, namely (A) fix filtery things in the block layer,
> and (B) fix active mirror.  So I decided to split it.  This is part A.
> Part B comes later.
>=20
>=20
> When we introduced filters, we did it a bit casually.  Sure, we talked =
a
> lot about them before, but that was mostly discussion about where
> implicit filters should be added to the graph (note that we currently
> only have two implicit filters, those being mirror and commit).  But in
> the end, we really just designated some drivers filters (Quorum,
> blkdebug, etc.) and added some specifically (throttle, COR), without
> really looking through the block layer to see where issues might occur.
>=20
> It turns out vast areas of the block layer just don't know about filter=
s
> and cannot really handle them.  Many cases will work in practice, in
> others, well, too bad, you cannot use some feature because some part
> deep inside the block layer looks at your filters and thinks they are
> format nodes.
>=20
> This series sets out to correct a bit of that.  I lost my head many
> times and I'm sure this series is incomplete in many ways, but it reall=
y
> doesn't do any good if it sits on my disk any longer, it needs to go ou=
t
> now.

Is there any of this series that still needs to go in 3.1?

I'm trying to fix an NBD bug with incorrect alignment in response to=20
NBD_CMD_BLOCK_STATUS.  I wanted to use blkdebug to force a=20
larger-than-512 minimum alignment exposure to the guest.  But right now,=20
nbd/server.c:nbd_export_bitmap() does a braindead:

     while (true) {
         bm =3D bdrv_find_dirty_bitmap(bs, bitmap);
         if (bm !=3D NULL || bs->backing =3D=3D NULL) {
             break;
         }

         bs =3D bs->backing->bs;
     }

which fails to see through a blkdebug filter to find a dirty bitmap in=20
the underlying qcow2 BDS (because blkdebug uses bs->file, not=20
bs->backing).  It looks like your series will make my task a lot easier,=20
but if it's not going in for 3.1, I still need to push my bug fix now,=20
and defer the testsuite additions to later when we can more sanely see=20
through filters.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
