Received: from eggs.gnu.org ([2001:4830:134:3::10]:39394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyHb0-0002dG-Ij
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 08:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyHaw-0004kj-Kb
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 08:42:02 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <5cb5f7fb-aadd-d8b5-7cf5-d677db045105@redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
	<w5160ibyufr.fsf@maestria.local.igalia.com>
	<9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
	<w5137dfyq1f.fsf@maestria.local.igalia.com>
	<5cb5f7fb-aadd-d8b5-7cf5-d677db045105@redhat.com>
Date: Wed, 12 Apr 2017 14:41:55 +0200
Message-ID: <w51fuhdkdbg.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] Proposed qcow2 extension:
 subcluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

On Tue 11 Apr 2017 04:45:29 PM CEST, Eric Blake wrote:
>>>>> (We could even get one more bit if we had a subcluster-flag,
>>>>> because I guess we can always assume subclustered clusters to have
>>>>> OFLAG_COPIED and be uncompressed. But still, three bits missing.)
>>>>
>>>> Why can we always assume OFLAG_COPIED?
>>>
>>> Because partially allocated clusters cannot be used with internal
>>>snapshots, and that is what OFLAG_COPIED is for.
>> 
>> Why can't they be used?
>
> An internal snapshot causes a COW to happen if another write happens
> anywhere in the cluster. Setting OFLAG_COPIED is a shorthand for
> whether the COW must happen, but it is always possible (but slower) to
> refer back to the refcount to learn the same information.  If we have
> a cluster with missing subclusters, and need to do a COW, we are
> already reading from the backing file - so we might as well populate
> the missing subclusters of the original cluster at that time we write
> the new updated cluster, at which point we no longer need to mark the
> cluster as using subclusters.

I still don't see why we can always assume OFLAG_COPIED. Before doing
the COW one cluster can have references from multiple snapshots, and
OFLAG_COPIED is equally valid in that context. We still need to know if
we need to perform COW when writing to it, regardless of whether it has
subclusters or not.

Also, when doing a COW for an internal snapshot we definitely have to
duplicate the whole cluster, but do we really need to read from the
backing file? Can't we leave the missing subclusters unallocated in the
copy?

> If we use option 2 or 3, it may still be worth burning a bit in the
> original 64 bits that says whether the subcluster secondary 64-bits is
> valid (it might speed up some operations if we only have to do one
> 64-bit read and realize that the entire cluster is uniform, compared
> to operations where the subcluster flag is set so we have to do a
> second 64-bit read to learn about the state of each subcluster).

Yeah, that might be a good idea.

Berto
