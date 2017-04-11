Received: from eggs.gnu.org ([2001:4830:134:3::10]:46028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cxvLE-0002B3-9Q
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cxvLB-0007EV-64
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:56:16 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
Date: Tue, 11 Apr 2017 14:56:08 +0200
Message-ID: <w5160ibyufr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Fri 07 Apr 2017 07:10:46 PM CEST, Max Reitz wrote:
>> =3D=3D=3D Changes to the on-disk format =3D=3D=3D
>>=20
>> The qcow2 on-disk format needs to change so each L2 entry has a bitmap
>> indicating the allocation status of each subcluster. There are three
>> possible states (unallocated, allocated, all zeroes), so we need two
>> bits per subcluster.
>
> You don't need two bits, you need log(3) / log(2) =3D ld(3) =E2=89=88 1.5=
8. You
> can encode the status of eight subclusters (3^8 =3D 6561) in 13 bits
> (ld(6561) =E2=89=88 12.68).

Right, although that would make the encoding more cumbersome to use and
to debug. Is it worth it?

> One case I'd be especially interested in are of course 4 kB
> subclusters for 64 kB clusters (because 4 kB is a usual page size and
> can be configured to be the block size of a guest device; and because
> 64 kB simply is the standard cluster size of qcow2 images
> nowadays[1]...).

I think that we should have at least that, but ideally larger
cluster-to-subcluster ratios.

> (We could even get one more bit if we had a subcluster-flag, because I
> guess we can always assume subclustered clusters to have OFLAG_COPIED
> and be uncompressed. But still, three bits missing.)

Why can we always assume OFLAG_COPIED?

> If course, if you'd be willing to give up the all-zeroes state for
> subclusters, it would be enough...

I still think that it looks like a better idea to allow having more
subclusters, but giving up the all-zeroes state is a valid
alternative. Apart from having to overwrite with zeroes when a
subcluster is discarded, is there anything else that we would miss?

> By the way, if you'd only allow multiple of 1s overhead
> (i.e. multiples of 32 subclusters), I think (3) would be pretty much
> the same as (2) if you just always write the subcluster information
> adjacent to the L2 table. Should be just the same caching-wise and
> performance-wise.

Then (3) is effectively the same as (2), just that the subcluster
bitmaps are at the end of the L2 cluster, and not next to each entry.

Berto
