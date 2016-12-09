Received: from eggs.gnu.org ([2001:4830:134:3::10]:39407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cFLX9-0000ff-Ip
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 08:48:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cFLX3-0005Z0-I2
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 08:48:19 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri,  9 Dec 2016 15:47:03 +0200
Message-Id: <cover.1481290956.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH RFC 0/1] Allow storing the qcow2 L2 cache in
 disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

Hi all,

as we all know, one of the main things that can make the qcow2 format
slow is the need to load entries from the L2 table in order to map a
guest offset (on the virtual disk) to a host offset (on the qcow2
image).

We have an L2 cache to deal with this, and as long as the cache is big
enough then the peformance is comparable to that of a raw image.

For large qcow2 images the amount of RAM we need in order to cache all
L2 tables can be big (128MB per TB of disk image if we're using the
default cluster size of 64KB). In order to solve this problem we have
a setting that allows the user to clean unused cache entries after a
certain interval of time. This works fine most of the time, although
we can still have peaks of RAM usage if there's a lot of I/O going on
in one or more VMs.

In some scenarios, however, there's a different alternative: if the
qcow2 image is stored in a slow backend (eg. HDD), we could save
memory by putting the L2 cache in a faster one (SSD) instead of in
RAM.

I have been making some tests with exactly that scenario and the
results look good: storing the cache in disk gives roughly the same
performance as storing it in memory.

|---------------------+------------+------+------------+--------|
|                     | Random 4k reads   | Sequential 4k reads |
|                     | Throughput | IOPS | Throughput |  IOPS  |
|---------------------+------------+------+------------+--------|
| Cache in memory/SSD | 406 KB/s   |   99 | 84 MB/s    |  21000 |
| Default cache (1MB) | 200 KB/s   |   60 | 83 MB/s    |  21000 |
| No cache            | 200 KB/s   |   49 | 56 MB/s    |  14000 |
|---------------------+------------+------+------------+--------|

I'm including the patch that I used to get these results. This is the
simplest approach that I could think of.

Opinions, questions?

Thanks,

Berto

Alberto Garcia (1):
  qcow2: Allow storing the qcow2 L2 cache in disk

 block/qcow2-cache.c | 56 +++++++++++++++++++++++++++++++++++++++++++++--------
 block/qcow2.c       | 11 +++++++++--
 block/qcow2.h       |  3 ++-
 3 files changed, 59 insertions(+), 11 deletions(-)

-- 
2.10.2
