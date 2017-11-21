Received: from eggs.gnu.org ([2001:4830:134:3::10]:50352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eH6iJ-0001jP-B9
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 06:27:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eH6iG-0003c9-0L
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 06:27:39 -0500
Received: from mail-ve1eur01on0127.outbound.protection.outlook.com
	([104.47.1.127]:43893
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eH6iF-0003bH-0m
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 06:27:35 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <243ad517-3fb9-43a4-5cb3-118b312a5720@virtuozzo.com>
Date: Tue, 21 Nov 2017 14:27:28 +0300
MIME-Version: 1.0
In-Reply-To: <20171012185916.22776-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 00/20] add byte-based block_status
 driver callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Hi!

Is it a latest portion of moving to byte-based? All other parts are 
already merged? Are you going to update it? (or this version if ok for 
review?)

12.10.2017 21:58, Eric Blake wrote:
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
> part 1: bdrv_is_allocated (merged, commit 51b0a488)
> part 2: dirty-bitmap (merged, commit ca759622)
> part 3: bdrv_get_block_status (v6 is posted [1], partially reviewed)
> part 4: .bdrv_co_block_status (this series, v3 was here [2])
>
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-callback-v4
>
> Based-on: <20171012034720.11947-1-eblake@redhat.com>
> ([PATCH v6 00/24] make bdrv_get_block_status byte-based)
>
> Since v3:
> - rebase to series 3 tweak in get_status interface
> - further simplify qed code
> - better documentation of optimization flag (s/mapping/want_zero/)
>
> 001/20:[0033] [FC] 'block: Add .bdrv_co_block_status() callback'
> 002/20:[0077] [FC] 'block: Switch passthrough drivers to .bdrv_co_block_status()'
> 003/20:[0020] [FC] 'file-posix: Switch to .bdrv_co_block_status()'
> 004/20:[0019] [FC] 'gluster: Switch to .bdrv_co_block_status()'
> 005/20:[----] [--] 'iscsi: Switch cluster_sectors to byte-based'
> 006/20:[----] [--] 'iscsi: Switch iscsi_allocmap_update() to byte-based'
> 007/20:[0022] [FC] 'iscsi: Switch to .bdrv_co_block_status()'
> 008/20:[0013] [FC] 'null: Switch to .bdrv_co_block_status()'
> 009/20:[0017] [FC] 'parallels: Switch to .bdrv_co_block_status()'
> 010/20:[0014] [FC] 'qcow: Switch to .bdrv_co_block_status()'
> 011/20:[0019] [FC] 'qcow2: Switch to .bdrv_co_block_status()'
> 012/20:[0086] [FC] 'qed: Switch to .bdrv_co_block_status()'
> 013/20:[0015] [FC] 'raw: Switch to .bdrv_co_block_status()'
> 014/20:[0011] [FC] 'sheepdog: Switch to .bdrv_co_block_status()'
> 015/20:[----] [--] 'vdi: Avoid bitrot of debugging code'
> 016/20:[0017] [FC] 'vdi: Switch to .bdrv_co_block_status()'
> 017/20:[0013] [FC] 'vmdk: Switch to .bdrv_co_block_status()'
> 018/20:[0019] [FC] 'vpc: Switch to .bdrv_co_block_status()'
> 019/20:[0010] [FC] 'vvfat: Switch to .bdrv_co_block_status()'
> 020/20:[0019] [FC] 'block: Drop unused .bdrv_co_get_block_status()'
>
> Eric Blake (20):
>    block: Add .bdrv_co_block_status() callback
>    block: Switch passthrough drivers to .bdrv_co_block_status()
>    file-posix: Switch to .bdrv_co_block_status()
>    gluster: Switch to .bdrv_co_block_status()
>    iscsi: Switch cluster_sectors to byte-based
>    iscsi: Switch iscsi_allocmap_update() to byte-based
>    iscsi: Switch to .bdrv_co_block_status()
>    null: Switch to .bdrv_co_block_status()
>    parallels: Switch to .bdrv_co_block_status()
>    qcow: Switch to .bdrv_co_block_status()
>    qcow2: Switch to .bdrv_co_block_status()
>    qed: Switch to .bdrv_co_block_status()
>    raw: Switch to .bdrv_co_block_status()
>    sheepdog: Switch to .bdrv_co_block_status()
>    vdi: Avoid bitrot of debugging code
>    vdi: Switch to .bdrv_co_block_status()
>    vmdk: Switch to .bdrv_co_block_status()
>    vpc: Switch to .bdrv_co_block_status()
>    vvfat: Switch to .bdrv_co_block_status()
>    block: Drop unused .bdrv_co_get_block_status()
>
>   include/block/block.h     |   9 ++-
>   include/block/block_int.h |  43 +++++++------
>   block/io.c                |  80 +++++++++++-------------
>   block/blkdebug.c          |  20 +++---
>   block/commit.c            |   2 +-
>   block/file-posix.c        |  59 ++++++++++--------
>   block/gluster.c           |  67 +++++++++++---------
>   block/iscsi.c             | 154 +++++++++++++++++++++++++---------------------
>   block/mirror.c            |   2 +-
>   block/null.c              |  23 +++----
>   block/parallels.c         |  22 ++++---
>   block/qcow.c              |  27 ++++----
>   block/qcow2.c             |  24 ++++----
>   block/qed.c               |  84 +++++++++----------------
>   block/raw-format.c        |  16 ++---
>   block/sheepdog.c          |  26 ++++----
>   block/throttle.c          |   2 +-
>   block/vdi.c               |  45 +++++++-------
>   block/vmdk.c              |  28 ++++-----
>   block/vpc.c               |  42 +++++++------
>   block/vvfat.c             |  16 +++--
>   21 files changed, 404 insertions(+), 387 deletions(-)
>


-- 
Best regards,
Vladimir
