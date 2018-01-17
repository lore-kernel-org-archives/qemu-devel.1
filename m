Received: from eggs.gnu.org ([2001:4830:134:3::10]:55266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ebm5T-0003zR-1m
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ebm5O-00006K-UH
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:40:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ebm5O-00005K-Nn
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:40:54 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1516170720-4948-2-git-send-email-wei.w.wang@intel.com> (Wei
	Wang's message of "Wed, 17 Jan 2018 14:31:57 +0800")
References: <1516170720-4948-1-git-send-email-wei.w.wang@intel.com>
	<1516170720-4948-2-git-send-email-wei.w.wang@intel.com>
Reply-To: quintela@redhat.com
Date: Wed, 17 Jan 2018 12:40:38 +0100
Message-ID: <878tcw4ssp.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1 1/4] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_VQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

Wei Wang <wei.w.wang@intel.com> wrote:
> The new feature enables the virtio-balloon device to receive the hint of
> guest free pages from the free page vq, and clears the corresponding bits
> of the free page from the dirty bitmap, so that those free pages are not
> transferred by the migration thread.
>
> Without this feature, to local live migrate an 8G idle guest takes
> ~2286 ms. With this featrue, it takes ~260 ms, which redues the
> migration time to ~11%.
>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: Liang Li <liang.z.li@intel.com>
> CC: Michael S. Tsirkin <mst@redhat.com>

I don't claim to understandthe full balloon driver


> diff --git a/migration/ram.c b/migration/ram.c
> index cb1950f..d6f462c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2186,6 +2186,16 @@ static int ram_init_all(RAMState **rsp)
>      return 0;
>  }
>  
> +void skip_free_pages_from_dirty_bitmap(RAMBlock *block, ram_addr_t offset,
> +                                       size_t len)
> +{
> +    long start = offset >> TARGET_PAGE_BITS,
> +         nr = len >> TARGET_PAGE_BITS;
> +
> +    bitmap_clear(block->bmap, start, nr);

But what assures us that all the nr pages are dirty?


> +    ram_state->migration_dirty_pages -= nr;

This should be
ram_state->migration_dirty_pages -=
     count_ones(block->bmap, start, nr);

For a count_ones function, no?

Furthermore, we have one "optimization" and this only works for the
second stages onward:

static inline
unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
                                          unsigned long start)
{
    unsigned long size = rb->used_length >> TARGET_PAGE_BITS;
    unsigned long *bitmap = rb->bmap;
    unsigned long next;

    if (rs->ram_bulk_stage && start > 0) {
        next = start + 1;
    } else {
        next = find_next_bit(bitmap, size, start);
    }

    return next;
}

So, for making this really work, we have more work to do.

Actually, what I think we should do was to _ask_ the guest which pages
are used at the beggining, instead of just setting all pages as dirty,
but that requires kernel changes and lot of search of corner cases.

Later, Juan.
