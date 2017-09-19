Received: from eggs.gnu.org ([2001:4830:134:3::10]:60585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1duKIE-0004fs-HH
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1duKID-0007SU-0i
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:18:34 -0400
References: <87tvzyu3p4.fsf@igalia.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <218c0446-a921-a14b-f318-c3768665de33@openvz.org>
Date: Tue, 19 Sep 2017 18:18:17 +0300
MIME-Version: 1.0
In-Reply-To: <87tvzyu3p4.fsf@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
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
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 09/19/2017 06:07 PM, Alberto Garcia wrote:
> Hi everyone,
>
> over the past few weeks I have been testing the effects of reducing
> the size of the entries in the qcow2 L2 cache. This was briefly
> mentioned by Denis in the same thread where we discussed subcluster
> allocation back in April, but I'll describe here the problem and the
> proposal in detail.
>
> =3D=3D=3D Problem =3D=3D=3D
>
> In the qcow2 file format guest addresses are mapped to host addresses
> using the so-called L1 and L2 tables. The size of an L2 table is the
> same as the cluster size, therefore a larger cluster means more L2
> entries in a table, and because of that an L2 table can map a larger
> portion of the address space (not only because it contains more
> entries, but also because the data cluster that each one of those
> entries points at is larger).
>
> There are two consequences of this:
>
>    1) If you double the cluster size of a qcow2 image then the maximum
>       space needed for all L2 tables is divided by two (i.e. you need
>       half the metadata).
>
>    2) If you double the cluster size of a qcow2 image then each one of
>       the L2 tables will map four times as much disk space.
>
> With the default cluster size of 64KB, each L2 table maps 512MB of
> contiguous disk space. This table shows what happens when you change
> the cluster size:
>
>      |--------------+------------------|
>      | Cluster size | An L2 table maps |
>      |--------------+------------------|
>      |       512  B |            32 KB |
>      |         1 KB |           128 KB |
>      |         2 KB |           512 KB |
>      |         4 KB |             2 MB |
>      |         8 KB |             8 MB |
>      |        16 KB |            32 MB |
>      |        32 KB |           128 MB |
>      |        64 KB |           512 MB |
>      |       128 KB |             2 GB |
>      |       256 KB |             8 GB |
>      |       512 KB |            32 GB |
>      |         1 MB |           128 GB |
>      |         2 MB |           512 GB |
>      |--------------+------------------|
>
> When QEMU wants to convert a guest address into a host address, it
> needs to read the entry from the corresponding L2 table. The qcow2
> driver doesn't read those entries directly, it does it by loading the
> tables in the L2 cache so they can be kept in memory in case they are
> needed later.
>
> The problem here is that the L2 cache (and the qcow2 driver in
> general) always works with complete L2 tables: if QEMU needs a
> particular L2 entry then the whole cluster containing the L2 table is
> read from disk, and if the cache is full then a cluster worth of
> cached data has to be discarded.
>
> The consequences of this are worse the larger the cluster size is, not
> only because we're reading (and discarding) larger amounts of data,
> but also because we're using that memory in a very inefficient way.
>
> Example: with 1MB clusters each L2 table maps 128GB of contiguous
> virtual disk, so that's the granularity of our cache. If we're
> performing I/O in a 4GB area that overlaps two of those 128GB chunks,
> we need to have in the cache two complete L2 tables (2MB) even when in
> practice we're only using 32KB of those 2MB (32KB contain enough L2
> entries to map the 4GB that we're using).
>
> =3D=3D=3D The proposal =3D=3D=3D
>
> One way to solve the problems described above is to decouple the L2
> table size (which is equal to the cluster size) from the cache entry
> size.
>
> The qcow2 cache doesn't actually know anything about the data that
> it's loading, it just receives a disk offset and checks that it is
> properly aligned. It's perfectly possible to make it load data blocks
> smaller than a cluster.
>
> I already have a working prototype, and I was doing tests using a 4KB
> cache entry size. 4KB is small enough, it allows us to make a more
> flexible use of the cache, it's also a common file system block size
> and it can hold enough L2 entries to cover substantial amounts of disk
> space (especially with large clusters).
>
>      |--------------+-----------------------|
>      | Cluster size | 4KB of L2 entries map |
>      |--------------+-----------------------|
>      | 64 KB        | 32 MB                 |
>      | 128 KB       | 64 MB                 |
>      | 256 KB       | 128 MB                |
>      | 512 KB       | 256 MB                |
>      | 1 MB         | 512 MB                |
>      | 2 MB         | 1 GB                  |
>      |--------------+-----------------------|
>
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
>    - Doing random reads over the whole disk is probably not a very
>      realistic scenario. During normal usage only certain areas of the
>      disk need to be accessed, so performance should be much better
>      with the same amount of cache.
>    - I wrote a best-case scenario test (several I/O jobs each accesing
>      a part of the disk that requires loading its own L2 table) and my
>      patched version is 20x faster even with 64KB clusters.
>
> =3D=3D=3D What needs to change? =3D=3D=3D
>
> Not so much, fortunately:
>
>    - The on-disk format does not need any change, qcow2 images remain
>      the same.
>    - The qcow2 cache driver needs almost no changes, the entry size
>      is no longer assumed to be equal to the cluster size, and it has
>      to be explicitly set. Other than that it remains the same (it can
>      even be simplified).
>
> The QEMU qcow2 driver does need a few changes:
>
>    - qcow2_get_cluster_offset() and get_cluster_table() simply need to
>      be aware that they're not loading full L2 tables anymore.
>    - handle_copied(), handle_alloc(), discard_single_l2() and
>      zero_single_l2() only need to update the calculation of
>      nb_clusters.
>    - l2_allocate() and qcow2_update_snapshot_refcount() cannot load a
>      full L2 table in memory at once, they need to loop over the
>      sub-tables. Other than wrapping the core of those functions
>      inside a loop I haven't detected any major problem.
>    - We need a proper name for these sub-tables that we are loading
>      now. I'm actually still struggling with this :-) I can't think of
>      any name that is clear enough and not too cumbersome to use (L2
>      subtables? =3D> Confusing. L3 tables? =3D> they're not really that).
>
> =3D=3D=3D What about the refcount cache? =3D=3D=3D
>
> This proposal would not touch this at all, the assumption would remain
> that "refcount cache entry size =3D cluster size".
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> I think I haven't forgotten anything. As I said I have a working
> prototype of this and if you like the idea I'd like to publish it
> soon. Any questions or comments will be appreciated.
>
> Thanks!
>
> Berto
very good analysis :)

I have two words about real life-ness of the scenario. There is very common
test by our customers when they create 1-2-4-16 Tb disk and starts random
IO over that disk. They are trying to emulate database access with all-flas=
h
driver.

IMHO this scenario is important and I like this very much.

Thank you in advance,
=C2=A0=C2=A0=C2=A0 Den
