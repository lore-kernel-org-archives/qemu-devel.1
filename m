Received: from eggs.gnu.org ([2001:4830:134:3::10]:41482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyHgI-0005BW-Il
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 08:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyHgE-0006dq-Le
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 08:47:30 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170411144921.GN4516@noname.str.redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
	<w5160ibyufr.fsf@maestria.local.igalia.com>
	<9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
	<w5137dfyq1f.fsf@maestria.local.igalia.com>
	<20170411144921.GN4516@noname.str.redhat.com>
Date: Wed, 12 Apr 2017 14:47:23 +0200
Message-ID: <w51d1chkd2c.fsf@maestria.local.igalia.com>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Tue 11 Apr 2017 04:49:21 PM CEST, Kevin Wolf wrote:
>> >>> (We could even get one more bit if we had a subcluster-flag, because I
>> >>> guess we can always assume subclustered clusters to have OFLAG_COPIED
>> >>> and be uncompressed. But still, three bits missing.)
>> >> 
>> >> Why can we always assume OFLAG_COPIED?
>> >
>> > Because partially allocated clusters cannot be used with internal
>> > snapshots, and that is what OFLAG_COPIED is for.
>> 
>> Why can't they be used?
>
> Refcounts are on a cluster granularity, so you have to COW the whole
> cluster at once. If you copied only a subcluster, you'd lose the
> information where to find the other subclusters.

Individual subclusters don't have reference counts, OFLAG_COPIED would
always be at the cluster level, but else I don't see the problem (see
the reply that I just wrote to Eric).

>> > It if it's a real discard you can just discard it (which is what we
>> > do for compat=0.10 images anyway); but zero-writes will then have
>> > to be come real writes, yes.
>> 
>> Perhaps we can give up that bit for subclusters then, that would
>> allow us to double their number. We would still have the zero flag at
>> the cluster level. Opinions on this, anyone?
>
> No, making the backing file contents reappear is really bad, we don't
> want that.

I'm not talking about making the backing file contents reappear, but
about writing zeroes instead of setting the zero flag.

>> >> Then (3) is effectively the same as (2), just that the subcluster
>> >> bitmaps are at the end of the L2 cluster, and not next to each
>> >> entry.
>> >
>> > Exactly. But it's a difference in implementation, as you won't have
>> > to worry about having changed the L2 table layout; maybe that's a
>> > benefit.
>> 
>> I'm not sure if that would simplify or complicate things, but it's
>> worth considering.
>
> Note that 64k between an L2 entry and the corresponding bitmap is
> enough to make an update not atomic any more. They need to be within
> the same sector to get atomicity.

Good point.

Berto
