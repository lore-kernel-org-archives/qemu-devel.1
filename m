Received: from eggs.gnu.org ([2001:4830:134:3::10]:58384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dwbhu-0007VZ-0u
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dwbhs-0006qO-Nn
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:18:30 -0400
References: <20170925145526.32690-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0dd26890-560e-26a3-9997-1292be7aecdd@redhat.com>
Date: Mon, 25 Sep 2017 18:18:15 -0400
MIME-Version: 1.0
In-Reply-To: <20170925145526.32690-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 00/20] make dirty-bitmap byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org



On 09/25/2017 10:55 AM, Eric Blake wrote:
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
> part 2: dirty-bitmap (this series, v9 was here [1])
> part 3: bdrv_get_block_status (v4 is posted [2] and is mostly reviewed)
> part 4: .bdrv_co_block_status (v3 is posted [3], but needs review)
> 
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-dirty-v10
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg05387.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03543.html
> [3] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03812.html
> 
> Since v9:
> - another try at patch 5 [John]
> - add R-b where appropriate
> 
> 001/20:[----] [--] 'block: Make bdrv_img_create() size selection easier to read'
> 002/20:[----] [--] 'hbitmap: Rename serialization_granularity to serialization_align'
> 003/20:[----] [--] 'qcow2: Ensure bitmap serialization is aligned'
> 004/20:[----] [--] 'dirty-bitmap: Drop unused functions'
> 005/20:[0003] [FC] 'dirty-bitmap: Avoid size query failure during truncate'
> 006/20:[----] [--] 'dirty-bitmap: Change bdrv_dirty_bitmap_size() to report bytes'
> 007/20:[----] [--] 'dirty-bitmap: Track bitmap size by bytes'
> 008/20:[----] [--] 'dirty-bitmap: Change bdrv_dirty_bitmap_*serialize*() to take bytes'
> 009/20:[----] [--] 'qcow2: Switch sectors_covered_by_bitmap_cluster() to byte-based'
> 010/20:[----] [--] 'dirty-bitmap: Set iterator start by offset, not sector'
> 011/20:[----] [--] 'dirty-bitmap: Change bdrv_dirty_iter_next() to report byte offset'
> 012/20:[----] [--] 'dirty-bitmap: Change bdrv_get_dirty_count() to report bytes'
> 013/20:[----] [--] 'dirty-bitmap: Change bdrv_get_dirty_locked() to take bytes'
> 014/20:[----] [--] 'dirty-bitmap: Change bdrv_[re]set_dirty_bitmap() to use bytes'
> 015/20:[----] [--] 'mirror: Switch mirror_dirty_init() to byte-based iteration'
> 016/20:[----] [--] 'qcow2: Switch qcow2_measure() to byte-based iteration'
> 017/20:[----] [--] 'qcow2: Switch load_bitmap_data() to byte-based iteration'
> 018/20:[----] [--] 'qcow2: Switch store_bitmap_data() to byte-based iteration'
> 019/20:[----] [--] 'dirty-bitmap: Switch bdrv_set_dirty() to bytes'
> 020/20:[----] [--] 'dirty-bitmap: Convert internal hbitmap size/granularity'
> 
> Eric Blake (20):
>   block: Make bdrv_img_create() size selection easier to read
>   hbitmap: Rename serialization_granularity to serialization_align
>   qcow2: Ensure bitmap serialization is aligned
>   dirty-bitmap: Drop unused functions
>   dirty-bitmap: Avoid size query failure during truncate
>   dirty-bitmap: Change bdrv_dirty_bitmap_size() to report bytes
>   dirty-bitmap: Track bitmap size by bytes
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
>  include/block/dirty-bitmap.h |  43 ++++++--------
>  include/qemu/hbitmap.h       |   8 +--
>  block/io.c                   |   6 +-
>  block.c                      |  18 ++++--
>  block/backup.c               |   7 +--
>  block/dirty-bitmap.c         | 134 ++++++++++++++-----------------------------
>  block/mirror.c               |  79 +++++++++++--------------
>  block/qcow2-bitmap.c         |  62 +++++++++++---------
>  block/qcow2.c                |  22 ++++---
>  migration/block.c            |  12 ++--
>  tests/test-hbitmap.c         |  10 ++--
>  util/hbitmap.c               |   8 +--
>  tests/qemu-iotests/165       |   2 +-
>  14 files changed, 174 insertions(+), 239 deletions(-)
> 

Tested-by: John Snow <jsnow@redhat.com>

(Just in case I had to merge it, I ran tests.)
