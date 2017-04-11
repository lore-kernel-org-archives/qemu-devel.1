Received: from eggs.gnu.org ([2001:4830:134:3::10]:46671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cxwpj-0001lT-C6
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cxwpf-0007QW-B4
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:31:51 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
	<w5160ibyufr.fsf@maestria.local.igalia.com>
	<9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
Date: Tue, 11 Apr 2017 16:31:08 +0200
Message-ID: <w5137dfyq1f.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue 11 Apr 2017 04:04:53 PM CEST, Max Reitz wrote:
>>> (We could even get one more bit if we had a subcluster-flag, because I
>>> guess we can always assume subclustered clusters to have OFLAG_COPIED
>>> and be uncompressed. But still, three bits missing.)
>> 
>> Why can we always assume OFLAG_COPIED?
>
> Because partially allocated clusters cannot be used with internal
> snapshots, and that is what OFLAG_COPIED is for.

Why can't they be used?

>>> If course, if you'd be willing to give up the all-zeroes state for
>>> subclusters, it would be enough...
>> 
>> I still think that it looks like a better idea to allow having more
>> subclusters, but giving up the all-zeroes state is a valid
>> alternative. Apart from having to overwrite with zeroes when a
>> subcluster is discarded, is there anything else that we would miss?
>
> It if it's a real discard you can just discard it (which is what we do
> for compat=0.10 images anyway); but zero-writes will then have to be
> come real writes, yes.

Perhaps we can give up that bit for subclusters then, that would allow
us to double their number. We would still have the zero flag at the
cluster level. Opinions on this, anyone?

>>> By the way, if you'd only allow multiple of 1s overhead
>>> (i.e. multiples of 32 subclusters), I think (3) would be pretty much
>>> the same as (2) if you just always write the subcluster information
>>> adjacent to the L2 table. Should be just the same caching-wise and
>>> performance-wise.
>> 
>> Then (3) is effectively the same as (2), just that the subcluster
>> bitmaps are at the end of the L2 cluster, and not next to each entry.
>
> Exactly. But it's a difference in implementation, as you won't have to
> worry about having changed the L2 table layout; maybe that's a
> benefit.

I'm not sure if that would simplify or complicate things, but it's worth
considering.

Berto
