Received: from eggs.gnu.org ([2001:4830:134:3::10]:50105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAxcL-00019p-DJ
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAxcK-0000bK-Mo
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:59:49 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170516204724.1617-10-eblake@redhat.com> (Eric Blake's message
	of "Tue, 16 May 2017 15:47:21 -0500")
References: <20170516204724.1617-1-eblake@redhat.com>
	<20170516204724.1617-10-eblake@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 17 May 2017 13:59:23 +0200
Message-ID: <871srnd78k.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 09/12] dirty-bitmap: Change
 bdrv_[re]set_dirty_bitmap() to use bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Eric Blake <eblake@redhat.com> wrote:
> Some of the callers were already scaling bytes to sectors; others
> can be easily converted to pass byte offsets, all in our shift
> towards a consistent byte interface everywhere.  Making the change
> will also make it easier to write the hold-out callers to use byte
> rather than sectors for their iterations; it also makes it easier
> for a future dirty-bitmap patch to offload scaling over to the
> internal hbitmap.  Although all callers happen to pass
> sector-aligned values, make the internal scaling robust to any
> sub-sector requests.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> +
>      assert(bdrv_dirty_bitmap_enabled(bitmap));
> -    hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
> +    hbitmap_set(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
> +                end_sector - (offset >> BDRV_SECTOR_BITS));

It is just me, or we use:

bytes = sectors * BDRV_SECTOR_SIZE
or
bytes = sectors << BDRV_SECTOR_BITS

and the same from bytes to sectors (no, this patch is consistent,
but just looking at the file ....)

Later, Juan.
