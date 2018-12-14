Received: from eggs.gnu.org ([2001:4830:134:3::10]:46474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gXk9W-00032W-Lu
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:53:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gXk9R-00029u-Op
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:53:02 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181114145857.19720-1-berto@igalia.com>
References: <20181114145857.19720-1-berto@igalia.com>
Date: Fri, 14 Dec 2018 10:52:54 +0100
Message-ID: <w51pnu4cu4p.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: Assert that refcount block
 offsets fit in the refcount table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

ping

I suppose this one can go in now.

On Wed 14 Nov 2018 03:58:57 PM CET, Alberto Garcia wrote:
> Refcount table entries have a field to store the offset of the
> refcount block. The rest of the bits of the entry are currently
> reserved.
>
> The offset is always taken from the entry using REFT_OFFSET_MASK to
> ensure that we only use the bits that belong to that field.
>
> While that mask is used every time we read from the refcount table, it
> is never used when we write to it. Due to the other constraints of the
> qcow2 format QEMU can never produce refcount block offsets that don't
> fit in that field so any such offset when allocating a refcount block
> would indicate a bug in QEMU.
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
> v2: Add missing Signed-off-by: line
> ---
>  block/qcow2-refcount.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 46082aeac1..31a2e1f845 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -367,6 +367,9 @@ static int alloc_refcount_block(BlockDriverState *bs,
>          return new_block;
>      }
>  
> +    /* The offset must fit in the offset field of the refcount table entry */
> +    assert((new_block & REFT_OFFSET_MASK) == new_block);
> +
>      /* If we're allocating the block at offset 0 then something is wrong */
>      if (new_block == 0) {
>          qcow2_signal_corruption(bs, true, -1, -1, "Preventing invalid "
> -- 
> 2.11.0
