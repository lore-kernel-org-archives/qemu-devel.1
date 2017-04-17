Received: from eggs.gnu.org ([2001:4830:134:3::10]:45539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d0GI2-0000tY-WC
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 19:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d0GI1-0003h2-Ss
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 19:42:39 -0400
References: <20170411222945.11741-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a00efe8e-e10a-da03-c31b-d2817d562aea@redhat.com>
Date: Mon, 17 Apr 2017 19:42:29 -0400
MIME-Version: 1.0
In-Reply-To: <20170411222945.11741-1-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 00/17] make
 bdrv_is_allocated[_above] byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org



On 04/11/2017 06:29 PM, Eric Blake wrote:
> There are patches floating around to add NBD_CMD_BLOCK_STATUS,
> but NBD wants to report status on byte granularity (even if the
> reporting will probably be naturally aligned to sectors or even
> much higher levels).  I've therefore started the task of
> converting our block status code to report at a byte granularity
> rather than sectors.
> 
> This is part one of that conversion: bdrv_is_allocated().
> Other parts (still to be written) include tracking dirty bitmaps
> by bytes (it's still one bit per granularity, but now we won't
> be double-scaling from bytes to sectors to granularity), then
> replacing bdrv_get_block_status() with a byte based callback
> in all the drivers.
> 
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-allocated-v1
> 
> It requires v9 or later of my prior work on blkdebug:
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01723.html
> which in turn requires Max's block-next tree:
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01298.html
> 
> Eric Blake (17):
>   blockjob: Track job ratelimits via bytes, not sectors
>   trace: Show blockjob actions via bytes, not sectors
>   stream: Switch stream_populate() to byte-based
>   stream: Switch stream_run() to byte-based
>   commit: Switch commit_populate() to byte-based
>   commit: Switch commit_run() to byte-based
>   mirror: Switch MirrorBlockJob to byte-based
>   mirror: Switch mirror_do_zero_or_discard() to byte-based
>   mirror: Switch mirror_cow_align() to byte-based
>   mirror: Switch mirror_do_read() to byte-based
>   mirror: Switch mirror_iteration() to byte-based
>   backup: Switch BackupBlockJob to byte-based
>   backup: Switch block_backup.h to byte-based
>   backup: Switch backup_do_cow() to byte-based
>   backup: Switch backup_run() to byte-based
>   block: Make bdrv_is_allocated() byte-based
>   block: Make bdrv_is_allocated_above() byte-based
> 
>  include/block/block.h        |   6 +-
>  include/block/block_backup.h |  11 +-
>  include/qemu/ratelimit.h     |   3 +-
>  block/backup.c               | 126 ++++++++----------
>  block/commit.c               |  54 ++++----
>  block/io.c                   |  59 +++++----
>  block/mirror.c               | 300 ++++++++++++++++++++++---------------------
>  block/replication.c          |  29 +++--
>  block/stream.c               |  35 +++--
>  block/vvfat.c                |  34 +++--
>  migration/block.c            |   9 +-
>  qemu-img.c                   |  15 ++-
>  qemu-io-cmds.c               |  57 ++++----
>  block/trace-events           |  14 +-
>  14 files changed, 381 insertions(+), 371 deletions(-)

Shame, you added ten lines!

> 

Patches 1-15:

Reviewed-by: John Snow <jsnow@redhat.com>

9: Is there a good reason for a void fn() to return its argument via a
passed parameter? I see you're matching the other interface, but that
strikes me as wonky.

11: Looks correct to me, but this one's a bit hairier than the rest. How
many times do we truly need to round, adjust, clip, round again, align,
clip, round, align, ...

I'll take a peek at the last two tomorrow.

--js
