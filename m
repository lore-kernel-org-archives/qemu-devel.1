Received: from eggs.gnu.org ([2001:4830:134:3::10]:51455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cyMib-0005Ak-Th
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 14:10:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cyMiZ-0005t7-MO
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 14:10:13 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <b55603db-5215-ac30-29e4-f4764f17c14e@openvz.org>
Date: Wed, 12 Apr 2017 20:55:08 +0300
MIME-Version: 1.0
In-Reply-To: <20170406150148.zwjpozqtale44jfh@perseus.local>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
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
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 04/06/2017 06:01 PM, Alberto Garcia wrote:
> Hi all,
>
> over the past couple of months I discussed with some of you the
> possibility to extend the qcow2 format in order to improve its
> performance and reduce its memory requirements (particularly with very
> large images).
>
> After some discussion in the mailing list and the #qemu IRC channel I
> decided to write a prototype of a new extension for qcow2 so I could
> understand better the scope of the changes and have some preliminary
> data about its effects.
>
> This e-mail is the formal presentation of my proposal to extend the
> on-disk qcow2 format. As you can see this is still an RFC. Due to the
> nature of the changes I would like to get as much feedback as possible
> before going forward.
>
> === Problem ===
>
> The original problem that I wanted to address is the memory
> requirements of qcow2 files if you want to have very large images and
> still keep good I/O performance. This is a consequence of its very
> structure, which I'm going to describe now.
>
> A qcow2 image is divided into units of constant size called clusters,
> and among other things it contains metadata that maps guest addresses
> to host addresses (the so-called L1 and L2 tables).
>
> There are two basic problems that result from this:
>
> 1) Reading from or writing to a qcow2 image involves reading the
>    corresponding entry on the L2 table that maps the guest address to
>    the host address. This is very slow because it involves two I/O
>    operations: one on the L2 table and the other one on the actual
>    data cluster.
>
> 2) A cluster is the smallest unit of allocation. Therefore writing a
>    mere 512 bytes to an empty disk requires allocating a complete
>    cluster and filling it with zeroes (or with data from the backing
>    image if there is one). This wastes more disk space and also has a
>    negative impact on I/O.
>
> Problem (1) can be solved by keeping in memory a cache of the L2
> tables (QEMU has an "l2_cache_size" parameter for this purpose). The
> amount of disk space used by L2 tables depends on two factors: the
> disk size and the cluster size.
>
> The cluster size can be configured when the image is created, and it
> can be any power of two between 512 bytes and 2 MB (it defaults to 64
> KB).
>
> The maximum amount of space needed for the L2 tables can be calculated
> with the following formula:
>
>    max_l2_size = virtual_disk_size * 8 / cluster_size
>
> Large images require a large amount of metadata, and therefore a large
> amount of memory for the L2 cache. With the default cluster size
> (64KB) that's 128MB of L2 cache for a 1TB qcow2 image.
>
> The only way to reduce the size of the L2 tables is therefore
> increasing the cluster size, but this makes the image less efficient
> as described earlier in (2).
>
> === The proposal ===
>
> The idea of this proposal is to extend the qcow2 format by allowing
> subcluster allocation. There would be an optional feature that would
> need to be enabled when creating the image. The on-disk format would
> remain essentially the same, except that each data cluster would be
> internally divided into a number of subclusters of equal size.
>
> What this means in practice is that each entry on an L2 table would be
> accompanied by a bitmap indicating the allocation state of each one of
> the subclusters for that cluster. There are several alternatives for
> storing the bitmap, described below.
>
> Other than L2 entries, all other data structures would remain
> unchanged, but for data clusters the smallest unit of allocation would
> now be the subcluster. Reference counting would still be at the
> cluster level, because there's no way to reference individual
> subclusters. Copy-on-write on internal snapshots would need to copy
> complete clusters, so that scenario would not benefit from this
> change.
>
> I see two main use cases for this feature:
>
> a) The qcow2 image is not too large / the L2 cache is not a problem,
>    but you want to increase the allocation performance. In this case
>    you can have something like a 128KB cluster with 4KB subclusters
>    (with 4KB being a common block size in ext4 and other filesystems)
>
> b) The qcow2 image is very large and you want to save metadata space
>    in order to have a smaller L2 cache. In this case you can go for
>    the maximum cluster size (2MB) but you want to have smaller
>    subclusters to increase the allocation performance and optimize the
>    disk usage. This was actually my original use case.
>
> === Test results ===
>
> I have a basic working prototype of this. It's still incomplete -and
> buggy :)- but it gives an idea of what we can expect from it. In my
> implementation each data cluster has 8 subclusters, but that's not set
> in stone (see below).
>
> I made all tests on an SSD drive, writing to an empty qcow2 image with
> a fully populated 40GB backing image, performing random writes using
> fio with a block size of 4KB.
>
> I tried with the default and maximum cluster sizes (64KB and 2MB) and
> also with some other sizes. I also made sure to try with 32KB clusters
> so the subcluster size matches the 4KB block size used for the I/O.
>
> It's important to point out that once a cluster has been completely
> allocated then having subclusters offers no performance benefit. For
> this reason the size of the image for these tests (40GB) was chosen to
> be large enough to guarantee that there are always new clusters being
> allocated. This is therefore a worst-case scenario (or best-case for
> this feature, if you want).
>
> Here are the results (subcluster size in brackets):
>
> |-----------------+----------------+-----------------+-------------------|
> |  cluster size   | subclusters=on | subclusters=off | Max L2 cache size |
> |-----------------+----------------+-----------------+-------------------|
> |   2 MB (256 KB) |   440 IOPS     |  100 IOPS       | 160 KB (*)        |
> | 512 KB  (64 KB) |  1000 IOPS     |  300 IOPS       | 640 KB            |
> |  64 KB   (8 KB) |  3000 IOPS     | 1000 IOPS       |   5 MB            |
> |  32 KB   (4 KB) | 12000 IOPS     | 1300 IOPS       |  10 MB            |
> |   4 KB  (512 B) |   100 IOPS     |  100 IOPS       |  80 MB            |
> |-----------------+----------------+-----------------+-------------------|
>
>                 (*) The L2 cache must be a multiple of the cluster
>                     size, so in this case it must be 2MB. On the table
>                     I chose to show how much of those 2MB are actually
>                     used so you can compare it with the other cases.
>
> Some comments about the results:
>
> - For the 64KB, 512KB and 2MB cases, having subclusters increases
>   write performance roughly by three. This happens because for each
>   cluster allocation there's less data to copy from the backing
>   image. For the same reason, the smaller the cluster, the better the
>   performance. As expected, 64KB clusters with no subclusters perform
>   roughly the same as 512KB clusters with 64KB subclusters.
>
> - The 32KB case is the most interesting one. Without subclusters it's
>   not very different from the 64KB case, but having a subcluster with
>   the same size of the I/O block eliminates the need for COW entirely
>   and the performance skyrockets (10 times faster!).
>
> - 4KB is however very slow. I attribute this to the fact that the
>   cluster size is so small that a new cluster needs to be allocated
>   for every single write and its refcount updated accordingly. The L2
>   and refcount tables are also so small that they are too inefficient
>   and need to grow all the time.
>
> Here are the results when writing to an empty 40GB qcow2 image with no
> backing file. The numbers are of course different but as you can see
> the patterns are similar:
>
> |-----------------+----------------+-----------------+-------------------|
> |  cluster size   | subclusters=on | subclusters=off | Max L2 cache size |
> |-----------------+----------------+-----------------+-------------------|
> |   2 MB (256 KB) |  1200 IOPS     |  255 IOPS       | 160 KB            |
> | 512 KB  (64 KB) |  3000 IOPS     |  700 IOPS       | 640 KB            |
> |  64 KB   (8 KB) |  7200 IOPS     | 3300 IOPS       |   5 MB            |
> |  32 KB   (4 KB) | 12300 IOPS     | 4200 IOPS       |  10 MB            |
> |   4 KB  (512 B) |   100 IOPS     |  100 IOPS       |  80 MB            |
> |-----------------+----------------+-----------------+-------------------|
>
> === Changes to the on-disk format ===
>
> The qcow2 on-disk format needs to change so each L2 entry has a bitmap
> indicating the allocation status of each subcluster. There are three
> possible states (unallocated, allocated, all zeroes), so we need two
> bits per subcluster.
>
> An L2 entry is 64 bits wide, and this is the current format (for
> uncompressed clusters):
>
> 63    56 55    48 47    40 39    32 31    24 23    16 15     8 7      0
> 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> **<----> <--------------------------------------------------><------->*
>   Rsrved              host cluster offset of data             Reserved
>   (6 bits)                (47 bits)                           (8 bits)
>
>     bit 63: refcount == 1   (QCOW_OFLAG_COPIED)
>     bit 62: compressed = 1  (QCOW_OFLAG_COMPRESSED)
>     bit 0: all zeros        (QCOW_OFLAG_ZERO)
>
> I thought of three alternatives for storing the subcluster bitmaps. I
> haven't made my mind completely about which one is the best one, so
> I'd like to present all three for discussion. Here they are:
>
> (1) Storing the bitmap inside the 64-bit entry
>
>     This is a simple alternative and is the one that I chose for my
>     prototype. There are 14 unused bits plus the "all zeroes" one. If
>     we steal one from the host offset we have the 16 bits that we need
>     for the bitmap and we have 46 bits left for the host offset, which
>     is more than enough.
>
>     * Pros:
>       + Simple. Few changes compared to the current qcow2 format.
>
>     * Cons:
>       - Only 8 subclusters per cluster. We would not be making the
>         most of this feature.
>
>       - No reserved bits left for the future.
>
> (2) Making L2 entries 128-bit wide.
>
>     In this alternative we would double the size of L2 entries. The
>     first half would remain unchanged and the second one would store
>     the bitmap. That would leave us with 32 subclusters per cluster.
>
>     * Pros:
>       + More subclusters per cluster. We could have images with
>         e.g. 128k clusters with 4k subclusters.
>
>     * Cons:
>       - More space needed for L2 entries. The same cluster size would
>         require a cache twice as large, although having subcluster
>         allocation would compensate for this.
>
>       - More changes to the code to handle 128-bit entries.
>
>       - We would still be wasting the 14 reserved bits that L2 entries
>         have.
>
> (3) Storing the bitmap somewhere else
>
>     This would involve storing the bitmap separate from the L2 tables
>     (perhaps using the bitmaps extension? I haven't looked much into
>     this).
>
>     * Pros:
>       + Possibility to make the number of subclusters configurable
>         by the user (32, 64, 128, ...)
>       + All existing metadata structures would remain untouched
>         (although the "all zeroes" bit in L2 entries would probably
>         become unused).
>
>     * Cons:
>       - As with alternative (2), more space needed for metadata.
>
>       - The bitmap would also need to be cached for performance
>         reasons.
>
>       - Possibly one more *_cache_size option.
>
>       - One more metadata structure to be updated for each
>         allocation. This would probably impact I/O negatively.
>
> === Compressed clusters ===
>
> My idea is that compressed clusters would remain the same. They are
> read-only anyway so they would not be affected by any of these
> changes.
>
> ===========================
>
> I think I managed to summarize all the ideas that I had in my mind,
> but I'm sure you probably have questions and comments, so I'd be happy
> to get as much feedback as possible.
>
> So, looking forward to reading your opinions.
>
> Regards,
>
> Berto
>
Let me rephrase a bit.

The proposal is looking very close to the following case:
- raw sparse file

In this case all writes are very-very-very fast and from the
guest point of view all is OK. Sequential data is really sequential.
Though once we are starting to perform any sequential IO, we
have real pain. Each sequential operation becomes random
on the host file system and the IO becomes very slow. This
will not be observed with the test, but the performance will
degrade very soon.

This is why raw sparse files are not used in the real life.
Hypervisor must maintain guest OS invariants and the data,
which is nearby from the guest point of view should be kept
nearby in host.

This is why actually that 64kb data blocks are extremely
small :) OK. This is offtopic.

One can easily recreate this case using the following simple
test:
- write each even 4kb page of the disk, one by one
- write each odd 4 kb page of the disk
- run sequential read with f.e. 1 MB data block

Normally we should still have native performance, but
with raw sparse files and (as far as understand the
proposal) sub-clusters we will have the host IO pattern
exactly like random.

This seems like a big and inevitable problem of the approach
for me. We still have the potential to improve current
algorithms and not introduce non-compatible changes.

Sorry if this is too emotional. We have learned above in a
very hard way.

Den
