Received: from eggs.gnu.org ([2001:4830:134:3::10]:37940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQUoM-0005fn-Tj
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dQUoI-0001i9-TW
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:28:26 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:35907 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dQUoI-0001h7-Hz
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:28:22 -0400
References: <20170628175534.14295-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4e6a11e8-d2f9-faa0-8203-9421c79224f3@virtuozzo.com>
Date: Thu, 29 Jun 2017 11:28:11 +0300
MIME-Version: 1.0
In-Reply-To: <20170628175534.14295-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 00/11] make dirty-bitmap byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi!

Can we apply my "[PATCH v22 00/30] qcow2: persistent dirty bitmaps" 
first? It was already near to the victory a week ago, but I had to 
rebase it on new Paolo's patches.

28.06.2017 20:55, Eric Blake wrote:
> There are patches floating around to add NBD_CMD_BLOCK_STATUS,
> but NBD wants to report status on byte granularity (even if the
> reporting will probably be naturally aligned to sectors or even
> much higher levels).  I've therefore started the task of
> converting our block status code to report at a byte granularity
> rather than sectors.
>
> This is part two of that conversion: dirty-bitmap. Other parts
> include bdrv_is_allocated (at v3 [1]) and replacing
> bdrv_get_block_status with a byte based callback in all the
> drivers (at v1, needs a rebase [3]).
>
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-dirty-v3
>
> Depends on Kevin's block branch and my v3 bdrv_is_allocated [1]
>
> Since v2 [2], I had to rebase on top of Paolo's locking fixes;
> patch v2 2/12 is gone, and many of the others had a lot of
> context conflicts. But I felt the resolution was simple enough
> that I kept R-b on all but patch 8.
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06077.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03859.html
> [3] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02642.html
>
> (git backport-diff doesn't like the rename in 7/11)
>
> 001/11:[----] [--] 'dirty-bitmap: Report BlockDirtyInfo.count in bytes, as documented'
> 002/11:[0024] [FC] 'dirty-bitmap: Drop unused functions'
> 003/11:[----] [-C] 'dirty-bitmap: Track size in bytes'
> 004/11:[----] [-C] 'dirty-bitmap: Set iterator start by offset, not sector'
> 005/11:[----] [-C] 'dirty-bitmap: Change bdrv_dirty_iter_next() to report byte offset'
> 006/11:[----] [-C] 'dirty-bitmap: Change bdrv_get_dirty_count() to report bytes'
> 007/11:[down] 'dirty-bitmap: Change bdrv_get_dirty_locked() to take bytes'
> 008/11:[0036] [FC] 'dirty-bitmap: Change bdrv_[re]set_dirty_bitmap() to use bytes'
> 009/11:[----] [--] 'mirror: Switch mirror_dirty_init() to byte-based iteration'
> 010/11:[0001] [FC] 'dirty-bitmap: Switch bdrv_set_dirty() to bytes'
> 011/11:[----] [-C] 'dirty-bitmap: Convert internal hbitmap size/granularity'
>
> Eric Blake (11):
>    dirty-bitmap: Report BlockDirtyInfo.count in bytes, as documented
>    dirty-bitmap: Drop unused functions
>    dirty-bitmap: Track size in bytes
>    dirty-bitmap: Set iterator start by offset, not sector
>    dirty-bitmap: Change bdrv_dirty_iter_next() to report byte offset
>    dirty-bitmap: Change bdrv_get_dirty_count() to report bytes
>    dirty-bitmap: Change bdrv_get_dirty_locked() to take bytes
>    dirty-bitmap: Change bdrv_[re]set_dirty_bitmap() to use bytes
>    mirror: Switch mirror_dirty_init() to byte-based iteration
>    dirty-bitmap: Switch bdrv_set_dirty() to bytes
>    dirty-bitmap: Convert internal hbitmap size/granularity
>
>   include/block/block_int.h    |   2 +-
>   include/block/dirty-bitmap.h |  28 ++++--------
>   block/backup.c               |   7 ++-
>   block/dirty-bitmap.c         | 105 +++++++++++--------------------------------
>   block/io.c                   |   6 +--
>   block/mirror.c               |  73 +++++++++++++-----------------
>   migration/block.c            |  12 +++--
>   7 files changed, 79 insertions(+), 154 deletions(-)
>

-- 
Best regards,
Vladimir
