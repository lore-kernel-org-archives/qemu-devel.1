Received: from eggs.gnu.org ([209.51.188.92]:41127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gz0R2-00035h-Gc
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gz0R0-0007AS-KX
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:43:47 -0500
References: <20181214134240.217870-1-vsementsov@virtuozzo.com>
	<20181214134240.217870-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09afd97f-0e16-82f2-df02-eccec310c4ab@redhat.com>
Date: Wed, 27 Feb 2019 08:43:34 -0600
MIME-Version: 1.0
In-Reply-To: <20181214134240.217870-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qcow2-refcount: avoid eating RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

On 12/14/18 7:42 AM, Vladimir Sementsov-Ogievskiy wrote:
> qcow2_inc_refcounts_imrt() (through realloc_refcount_array()) can eat
> an unpredictable amount of memory on corrupted table entries, which are
> referencing regions far beyond the end of file.
> 
> Prevent this, by skipping such regions from further processing.
> 
> Interesting that iotest 138 checks exactly the behavior which we fix
> here. So, change the test appropriately.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

> +    /* Last cluster of qcow2 image may be semi-allocated, so it's may be OK to
> +     * reference some space after file end but it should be less than one
> +     * cluster.

Are we guaranteed that this is always the case, even when incrementally
building up an image.  That is, if we get a power failure in the middle
of allocating both a new L2 table and a larger refcount table, can we
see an image which temporary references 2 or more clusters beyond the
end of the file that it was previously using?  Or are we guaranteed that
the way we update the refcount table will never see more than one
cluster beyond the end of the file for any other reference?  I guess
where I'm going with this is a question of whether we should permit a
finite overrun to account for multiple pieces of metadata all being in
flight at once, and only reject the obvious overruns that are definitely
beyond that sane limit, and whether 1 cluster is too small for that sane
limit.

> +     */
> +    if (offset + size - file_len >= s->cluster_size) {
> +        fprintf(stderr, "ERROR: counting reference for region exceeding the "
> +                "end of the file by one cluster or more: offset 0x%" PRIx64
> +                " size 0x%" PRIx64 "\n", offset, size);

Should we be using something smarter than fprintf() here?

Grammar suggestion:

ERROR: reference to a region too far beyond the end of the file:

(which is shorter than what you wrote, and also has the nice property of
allowing us to change our mind on whether it is 1 cluster, 2, 10, or
some other finite limit as our heuristic of when we consider the image
corrupt without having to reword it).


> +++ b/tests/qemu-iotests/138
> @@ -54,15 +54,13 @@ $QEMU_IO -c 'write 0 512' "$TEST_IMG" | _filter_qemu_io
>  # Put the data cluster at a multiple of 2 TB, resulting in the image apparently
>  # having a multiple of 2^32 clusters
>  # (To be more specific: It is at 32 PB)
> -poke_file "$TEST_IMG" 2048 "\x80\x80\x00\x00\x00\x00\x00\x00"
> +poke_file "$TEST_IMG" $((2048 + 8)) "\x00\x80\x00\x00\x00\x00\x00\x00"
>  
>  # An offset of 32 PB results in qemu-img check having to allocate an in-memory
> -# refcount table of 128 TB (16 bit refcounts, 512 byte clusters).
> -# This should be generally too much for any system and thus fail.
> -# What this test is checking is that the qcow2 driver actually tries to allocate
> -# such a large amount of memory (and is consequently aborting) instead of having
> -# truncated the cluster count somewhere (which would result in much less memory
> -# being allocated and then a segfault occurring).
> +# refcount table of 128 TB (16 bit refcounts, 512 byte clusters), if qemu-img
> +# don't check that referenced data cluster is far beyond the end of file.
> +# But starting from 4.0, qemu-img does this check, and instead of "Cannot
> +# allocate memory", we have an error showing that l2 entry is invalid.
>  _check_test_img

In other words, we are still gracefully invalidating the file, but now
because of a heuristic rather than a memory allocation failure.

I might word the comment differently:

An offset of 32 PB would result in qemu-img check having to allocate an
in-memory refcount table of 128 TB (16 bit refcounts, 512 byte
clusters). It is unlikely that a system has this much memory, so the
test ensures that qemu-img either gracefully fails an allocation (prior
to 4.0) or flags the image as invalid (the reference points to a cluster
too far beyond the actual file), rather than silently allocating a
truncated memory amount or dumping core.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
