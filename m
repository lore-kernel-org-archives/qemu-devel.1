Received: from eggs.gnu.org ([2001:4830:134:3::10]:60554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnBiC-00008V-GB
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnBiB-0007Xk-4y
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:43:52 -0400
References: <20170830210542.2153-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5fc29501-2c1f-1342-fb2b-cd40cf3e8589@redhat.com>
Date: Wed, 30 Aug 2017 18:43:42 -0400
MIME-Version: 1.0
In-Reply-To: <20170830210542.2153-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/18] make dirty-bitmap byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org



On 08/30/2017 05:05 PM, Eric Blake wrote:
> There are patches floating around to add NBD_CMD_BLOCK_STATUS,
> but NBD wants to report status on byte granularity (even if the
> reporting will probably be naturally aligned to sectors or even
> much higher levels).  I've therefore started the task of
> converting our block status code to report at a byte granularity
> rather than sectors.
> 
> Now that 2.11 is open, I'm rebasing/reposting the remaining patches.
> 
> The overall conversion currently looks like:
> part 1: bdrv_is_allocated (merged in 2.10, commit 51b0a488)
> part 2: dirty-bitmap (this series, v5 was here [1])
> part 3: bdrv_get_block_status (v3 is posted [2] and is mostly reviewed, but
> needs a rebase)
> part 4: .bdrv_co_block_status (v2 is posted [3], but needs a rebase)
> 
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-dirty-v6
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg03512.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg03853.html
> [3] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04370.html
> 
> Diff from v5:
> - add another patch (more for ease of bookkeeping, as it was previously
> posted independently)
> - drop bug fixes that were hoisted into 2.10 (v5 1/18, plus 14/18)
> 
> 001/18:[down] 'block: Make bdrv_img_create() size selection easier to read'
> 002/18:[----] [--] 'hbitmap: Rename serialization_granularity to serialization_align'
> 003/18:[----] [--] 'qcow2: Ensure bitmap serialization is aligned'
> 004/18:[----] [--] 'dirty-bitmap: Drop unused functions'
> 005/18:[----] [--] 'dirty-bitmap: Change bdrv_dirty_bitmap_size() to report bytes'
> 006/18:[----] [--] 'dirty-bitmap: Change bdrv_dirty_bitmap_*serialize*() to take bytes'
> 007/18:[----] [--] 'qcow2: Switch sectors_covered_by_bitmap_cluster() to byte-based'
> 008/18:[----] [--] 'dirty-bitmap: Set iterator start by offset, not sector'
> 009/18:[----] [--] 'dirty-bitmap: Change bdrv_dirty_iter_next() to report byte offset'
> 010/18:[----] [--] 'dirty-bitmap: Change bdrv_get_dirty_count() to report bytes'
> 011/18:[----] [--] 'dirty-bitmap: Change bdrv_get_dirty_locked() to take bytes'
> 012/18:[----] [--] 'dirty-bitmap: Change bdrv_[re]set_dirty_bitmap() to use bytes'
> 013/18:[----] [--] 'mirror: Switch mirror_dirty_init() to byte-based iteration'
> 014/18:[0004] [FC] 'qcow2: Switch qcow2_measure() to byte-based iteration'
> 015/18:[----] [--] 'qcow2: Switch load_bitmap_data() to byte-based iteration'
> 016/18:[----] [--] 'qcow2: Switch store_bitmap_data() to byte-based iteration'
> 017/18:[----] [--] 'dirty-bitmap: Switch bdrv_set_dirty() to bytes'
> 018/18:[----] [--] 'dirty-bitmap: Convert internal hbitmap size/granularity'
> 
> Eric Blake (18):
>   block: Make bdrv_img_create() size selection easier to read
>   hbitmap: Rename serialization_granularity to serialization_align
>   qcow2: Ensure bitmap serialization is aligned
>   dirty-bitmap: Drop unused functions
>   dirty-bitmap: Change bdrv_dirty_bitmap_size() to report bytes
>   dirty-bitmap: Change bdrv_dirty_bitmap_*serialize*() to take bytes
>   qcow2: Switch sectors_covered_by_bitmap_cluster() to byte-based
>   dirty-bitmap: Set iterator start by offset, not sector
>   dirty-bitmap: Change bdrv_dirty_iter_next() to report byte offset
>   dirty-bitmap: Change bdrv_get_dirty_count() to report bytes
>   dirty-bitmap: Change bdrv_get_dirty_locked() to take bytes
>   dirty-bitmap: Change bdrv_[re]set_dirty_bitmap() to use bytes
>   mirror: Switch mirror_dirty_init() to byte-based iteration
>   qcow2: Switch qcow2_measure() to byte-based iteration
>   qcow2: Switch load_bitmap_data() to byte-based iteration
>   qcow2: Switch store_bitmap_data() to byte-based iteration
>   dirty-bitmap: Switch bdrv_set_dirty() to bytes
>   dirty-bitmap: Convert internal hbitmap size/granularity
> 
>  include/block/block_int.h    |   2 +-
>  include/block/dirty-bitmap.h |  41 +++++---------
>  include/qemu/hbitmap.h       |   8 +--
>  block/io.c                   |   6 +-
>  block.c                      |   2 +-
>  block/backup.c               |   7 +--
>  block/dirty-bitmap.c         | 130 ++++++++++++++-----------------------------
>  block/mirror.c               |  76 +++++++++++--------------
>  block/qcow2-bitmap.c         |  57 +++++++++----------
>  block/qcow2.c                |  22 ++++----
>  migration/block.c            |  12 ++--
>  tests/test-hbitmap.c         |  10 ++--
>  util/hbitmap.c               |   8 +--
>  13 files changed, 154 insertions(+), 227 deletions(-)
> 

Should this go through the bitmap tree, or since it's touching qcow2,
I'll let Kevin/Max/Stefan stage it?

--js
