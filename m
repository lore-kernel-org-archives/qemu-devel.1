Received: from eggs.gnu.org ([2001:4830:134:3::10]:43425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dufDS-0004Ow-3k
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dufDM-0002p8-2m
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:39:02 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170920070620.GB4730@localhost.localdomain>
References: <87tvzyu3p4.fsf@igalia.com>
	<20170920070620.GB4730@localhost.localdomain>
Date: Wed, 20 Sep 2017 15:10:45 +0200
Message-ID: <w518th91pnu.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Wed 20 Sep 2017 09:06:20 AM CEST, Kevin Wolf wrote:
>> |-----------+--------------+-------------+---------------+--------------|
>> | Disk size | Cluster size | L2 cache    | Standard QEMU | Patched QEMU |
>> |-----------+--------------+-------------+---------------+--------------|
>> | 16 GB     | 64 KB        | 1 MB [8 GB] | 5000 IOPS     | 12700 IOPS   |
>> |  2 TB     |  2 MB        | 4 MB [1 TB] |  576 IOPS     | 11000 IOPS   |
>> |-----------+--------------+-------------+---------------+--------------|
>> 
>> The improvements are clearly visible, but it's important to point out
>> a couple of things:
>> 
>>    - L2 cache size is always < total L2 metadata on disk (otherwise
>>      this wouldn't make sense). Increasing the L2 cache size improves
>>      performance a lot (and makes the effect of these patches
>>      disappear), but it requires more RAM.
>
> Do you have the numbers for the two cases abve if the L2 tables
> covered the whole image?

Yeah, sorry, it's around 60000 IOPS in both cases (more or less what I
also get with a raw image).

>>    - Doing random reads over the whole disk is probably not a very
>>      realistic scenario. During normal usage only certain areas of the
>>      disk need to be accessed, so performance should be much better
>>      with the same amount of cache.
>>    - I wrote a best-case scenario test (several I/O jobs each accesing
>>      a part of the disk that requires loading its own L2 table) and my
>>      patched version is 20x faster even with 64KB clusters.
>
> I suppose you choose the scenario so that the number of jobs is larger
> than the number of cached L2 tables without the patch, but smaller than
> than the number of cache entries with the patch?

Exactly, I should have made that explicit :) I had 32 jobs, each one of
them limited to a small area (32MB), so with 4K pages you only need
128KB of cache memory (vs 2MB with the current code).

> We will probably need to do some more benchmarking to find a good
> default value for the cached chunks. 4k is nice and small, so we can
> cover many parallel jobs without using too much memory. But if we have
> a single sequential job, we may end up doing the metadata updates in
> small 4k chunks instead of doing a single larger write.

Right, although a 4K table can already hold pointers to 512 data
clusters, so even if you do sequential I/O you don't need to update the
metadata so often, do you?

I guess the default value should probably depend on the cluster size.

>>    - We need a proper name for these sub-tables that we are loading
>>      now. I'm actually still struggling with this :-) I can't think of
>>      any name that is clear enough and not too cumbersome to use (L2
>>      subtables? => Confusing. L3 tables? => they're not really that).
>
> L2 table chunk? Or just L2 cache entry?

Yeah, something like that, but let's see how variables end up being
named :)

Berto
