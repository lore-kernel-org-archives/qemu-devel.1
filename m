Received: from eggs.gnu.org ([2001:4830:134:3::10]:55317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cFMet-0001iy-E9
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 10:00:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cFMep-0001wc-HY
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 10:00:23 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20161209141823.GC3992@noname.redhat.com>
References: <cover.1481290956.git.berto@igalia.com>
	<20161209141823.GC3992@noname.redhat.com>
Date: Fri, 09 Dec 2016 16:00:14 +0100
Message-ID: <w51fulxw3k1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 0/1] Allow storing the qcow2 L2 cache
 in disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri 09 Dec 2016 03:18:23 PM CET, Kevin Wolf wrote:
>> I have been making some tests with exactly that scenario and the
>> results look good: storing the cache in disk gives roughly the same
>> performance as storing it in memory.
>> 
>> |---------------------+------------+------+------------+--------|
>> |                     | Random 4k reads   | Sequential 4k reads |
>> |                     | Throughput | IOPS | Throughput |  IOPS  |
>> |---------------------+------------+------+------------+--------|
>> | Cache in memory/SSD | 406 KB/s   |   99 | 84 MB/s    |  21000 |
>> | Default cache (1MB) | 200 KB/s   |   60 | 83 MB/s    |  21000 |
>> | No cache            | 200 KB/s   |   49 | 56 MB/s    |  14000 |
>> |---------------------+------------+------+------------+--------|
>> 
>> I'm including the patch that I used to get these results. This is the
>> simplest approach that I could think of.
>> 
>> Opinions, questions?
>
> I suppose you used the fact that the cache is now on disk to increase
> the cache size so that it covers the whole image?

Right, the wording on the table is not clear, but that's what I did. I
also don't think this makes much sense if the cache is not big enough to
cover the whole image.

> If so, are you sure that you aren't just testing that accessing memory
> in the kernel page cache is just as fast as accessing memory in qemu's
> own cache? It seems this would just bypass the cache size limit given
> to qemu by instead leaving things cached in the kernel where the limit
> doesn't apply.

Fair question: what I checked is that the PSS/RSS values match the
expected values (i.e, they don't grow as you read from the disk
image). If the kernel is caching those pages so accessing them after
MADV_DONTNEED does not require going to disk again is a possibility that
I haven't ruled out.

Berto
