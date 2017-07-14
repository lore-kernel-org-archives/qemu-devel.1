Received: from eggs.gnu.org ([2001:4830:134:3::10]:33942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVvGz-0002qf-3c
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVvGx-0001f5-On
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:44:25 -0400
Date: Fri, 14 Jul 2017 09:44:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170714074414.GD4762@noname.redhat.com>
References: <20170712114700.20008-1-pbutsykin@virtuozzo.com>
	<20170712114700.20008-4-pbutsykin@virtuozzo.com>
	<20170712145251.GE4917@noname.str.redhat.com>
	<ca2e112d-23d7-48c1-07a9-b60ee8ab743f@redhat.com>
	<20170713084126.GA4139@noname.redhat.com>
	<e6d3c11d-a020-457c-d38f-4114e3023dc8@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6d3c11d-a020-457c-d38f-4114e3023dc8@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v5 3/4] qcow2: add shrink image support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, den@openvz.org

Am 13.07.2017 um 19:18 hat Pavel Butsykin geschrieben:
> On 13.07.2017 11:41, Kevin Wolf wrote:
> >Am 12.07.2017 um 18:58 hat Max Reitz geschrieben:
> >>On 2017-07-12 16:52, Kevin Wolf wrote:
> >>>Am 12.07.2017 um 13:46 hat Pavel Butsykin geschrieben:
> >>>>This patch add shrinking of the image file for qcow2. As a result, this allows
> >>>>us to reduce the virtual image size and free up space on the disk without
> >>>>copying the image. Image can be fragmented and shrink is done by punching holes
> >>>>in the image file.
> >>>>
> >>>>Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> >>>>Reviewed-by: Max Reitz <mreitz@redhat.com>
> >>>>---
> >>>>  block/qcow2-cluster.c  |  40 ++++++++++++++++++
> >>>>  block/qcow2-refcount.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>  block/qcow2.c          |  43 +++++++++++++++----
> >>>>  block/qcow2.h          |  14 +++++++
> >>>>  qapi/block-core.json   |   3 +-
> >>>>  5 files changed, 200 insertions(+), 10 deletions(-)
> >>>>
> >>>>diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> >>>>index f06c08f64c..518429c64b 100644
> >>>>--- a/block/qcow2-cluster.c
> >>>>+++ b/block/qcow2-cluster.c
> >>>>@@ -32,6 +32,46 @@
> >>>>  #include "qemu/bswap.h"
> >>>>  #include "trace.h"
> >>>>+int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t exact_size)
> >>>>+{
> >>>>+    BDRVQcow2State *s = bs->opaque;
> >>>>+    int new_l1_size, i, ret;
> >>>>+
> >>>>+    if (exact_size >= s->l1_size) {
> >>>>+        return 0;
> >>>>+    }
> >>>>+
> >>>>+    new_l1_size = exact_size;
> >>>>+
> >>>>+#ifdef DEBUG_ALLOC2
> >>>>+    fprintf(stderr, "shrink l1_table from %d to %d\n", s->l1_size, new_l1_size);
> >>>>+#endif
> >>>>+
> >>>>+    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_WRITE_TABLE);
> >>>>+    ret = bdrv_pwrite_zeroes(bs->file, s->l1_table_offset +
> >>>>+                                       sizeof(uint64_t) * new_l1_size,
> >>>>+                             (s->l1_size - new_l1_size) * sizeof(uint64_t), 0);
> >>>>+    if (ret < 0) {
> >>>>+        return ret;
> >>>>+    }
> >>>>+
> >>>>+    ret = bdrv_flush(bs->file->bs);
> >>>>+    if (ret < 0) {
> >>>>+        return ret;
> >>>>+    }
> >>>
> >>>If we have an error here (or after a partial bdrv_pwrite_zeroes()), we
> >>>have entries zeroed out on disk, but in memory we still have the
> >>>original L1 table.
> >>>
> >>>Should the in-memory L1 table be zeroed first? Then we can't
> >>>accidentally reuse stale entries, but would have to allocate new ones,
> >>>which would get on-disk state and in-memory state back in sync again.
> >>
> >>Yes, I thought of the same.  But this implies that the allocation is
> >>able to modify the L1 table, and I find that unlikely if that
> >>bdrv_flush() failed already...
> >>
> >>So I concluded not to have an opinion on which order is better.
> >
> >Well, let me ask the other way round: Is there any disadvantage in first
> >zeroing the in-memory table and then writing to the image?
> 
> If bdrv_flush/drv_pwrite_zeroes function failed, the subsequent writes
> to truncated area lead to allocation L2 tables. This implies two things:
> 
> 1. We need call qcow2_free_clusters() after bdrv_flush/drv_pwrite_zeroes
> anyway, otherwise it may lead to the situation when the l1 table will
> have two identical offsets.

Yes, I'm only talking about zeroing the in-memory L1 table first, not
moving anything else.

> 2. Old l2 blocks may be lost and will be dead weight for the image.

Yes, without a journal, we can't avoid leaked clusters in certain error
cases. They are harmless, though, and 'qemu-img check' can detect and
repair them without any risk.

Leaked clusters are always better than actual image corruption, which is
what would potentially happen with your current order of operations.

> >If I have a choice between "always safe" and "not completely safe, but I
> >think it's unlikely to happen", especially in image formats, then I will
> >certainly take the "always safe".
> 
> In my understanding both cases are "unsafe", because both cases may lead
> to inconsistent state between image and memory.

Yes, we cannot guarantee full consistency of the image, but that doesn't
make it unsafe yet. I would only call things unsafe if we may end up
corrupting user data. This is the most important thing for an image
format to avoid. If at all possible, we need to write our code so that
no matter what happens, the worst thing we get is leaked clusters.

> When writing this code I was looking at an existing approach in
> qcow2*.c to such kind of issues:
> ...
> static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
> ...
>     trace_qcow2_l2_allocate_write_l1(bs, l1_index);
>     s->l1_table[l1_index] = l2_offset | QCOW_OFLAG_COPIED;
>     ret = qcow2_write_l1_entry(bs, l1_index);
>     if (ret < 0) {
>         goto fail;
>     }
> 
>     *table = l2_table;
>     trace_qcow2_l2_allocate_done(bs, l1_index, 0);
>     return 0;
> 
> fail:
>     trace_qcow2_l2_allocate_done(bs, l1_index, ret);
>     if (l2_table != NULL) {
>         qcow2_cache_put(bs, s->l2_table_cache, (void**) table);
>     }
>     s->l1_table[l1_index] = old_l2_offset;
>     if (l2_offset > 0) {
>         qcow2_free_clusters(bs, l2_offset, s->l2_size * sizeof(uint64_t),
>                             QCOW2_DISCARD_ALWAYS);
>     }
>     return ret;
> 
> Do I understand correctly? that if qcow2_write_l1_entr call fails
> somewhere in the middle of bdrv_flush() then l1_table still contain the
> old l2_offset, but the image may already contain the new l2_offset. We
> can continue to use the image and write data, but in this case we lose
> the data after reopening image.

You're right, if the error happens somewhere in the middle, we have a
serious problem there. :-(

I think the only way out in this case would be to write the new data at
a different position in the image file than the old data. (Do I hear
anyone say "journal"?)

> So it seemed to me that in current conditions we can't escape from such
> kind of problem completely. But I understand your desire to do better
> even in little things, I agree that would be a little safer in the case
> "first zeroing the in-memory table and then writing". So if this
> solution suits all, let me write the next patch-set version :)

Yay! :-)

Kevin
