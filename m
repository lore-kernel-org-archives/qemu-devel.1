Received: from eggs.gnu.org ([2001:4830:134:3::10]:52290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1duZ5b-0008RY-V4
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1duZ5a-0003z6-P4
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:06:31 -0400
Date: Wed, 20 Sep 2017 09:06:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170920070620.GB4730@localhost.localdomain>
References: <87tvzyu3p4.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvzyu3p4.fsf@igalia.com>
Subject: Re: [Qemu-devel] RFC: Reducing the size of entries in the qcow2 L2
 cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>

Am 19.09.2017 um 17:07 hat Alberto Garcia geschrieben:
> Hi everyone,
> 
> over the past few weeks I have been testing the effects of reducing
> the size of the entries in the qcow2 L2 cache. This was briefly
> mentioned by Denis in the same thread where we discussed subcluster
> allocation back in April, but I'll describe here the problem and the
> proposal in detail.
> [...]

Thanks for working on this, Berto! I think this is essential for large
cluster sizes and have been meaning to make a change like this for a
long time, but I never found the time for it.

> Some results from my tests (using an SSD drive and random 4K reads):
> 
> |-----------+--------------+-------------+---------------+--------------|
> | Disk size | Cluster size | L2 cache    | Standard QEMU | Patched QEMU |
> |-----------+--------------+-------------+---------------+--------------|
> | 16 GB     | 64 KB        | 1 MB [8 GB] | 5000 IOPS     | 12700 IOPS   |
> |  2 TB     |  2 MB        | 4 MB [1 TB] |  576 IOPS     | 11000 IOPS   |
> |-----------+--------------+-------------+---------------+--------------|
> 
> The improvements are clearly visible, but it's important to point out
> a couple of things:
> 
>    - L2 cache size is always < total L2 metadata on disk (otherwise
>      this wouldn't make sense). Increasing the L2 cache size improves
>      performance a lot (and makes the effect of these patches
>      disappear), but it requires more RAM.

Do you have the numbers for the two cases abve if the L2 tables covered
the whole image?

>    - Doing random reads over the whole disk is probably not a very
>      realistic scenario. During normal usage only certain areas of the
>      disk need to be accessed, so performance should be much better
>      with the same amount of cache.
>    - I wrote a best-case scenario test (several I/O jobs each accesing
>      a part of the disk that requires loading its own L2 table) and my
>      patched version is 20x faster even with 64KB clusters.

I suppose you choose the scenario so that the number of jobs is larger
than the number of cached L2 tables without the patch, but smaller than
than the number of cache entries with the patch?

We will probably need to do some more benchmarking to find a good
default value for the cached chunks. 4k is nice and small, so we can
cover many parallel jobs without using too much memory. But if we have a
single sequential job, we may end up doing the metadata updates in
small 4k chunks instead of doing a single larger write.

Of course, if this starts becoming a problem (maybe unlikely?), we can
always change the cache code to gather any adjacent dirty chunks in the
cache when writing out something. Same thing for readahead, if we can
find a policy when to evict old entries for readahead.

>    - We need a proper name for these sub-tables that we are loading
>      now. I'm actually still struggling with this :-) I can't think of
>      any name that is clear enough and not too cumbersome to use (L2
>      subtables? => Confusing. L3 tables? => they're not really that).

L2 table chunk? Or just L2 cache entry?

> I think I haven't forgotten anything. As I said I have a working
> prototype of this and if you like the idea I'd like to publish it
> soon. Any questions or comments will be appreciated.

Please do post it!

Kevin
