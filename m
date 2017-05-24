Received: from eggs.gnu.org ([2001:4830:134:3::10]:39691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dDRiX-00064l-K8
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dDRiW-0005aW-L8
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:32:29 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20170511144208.24075-1-pbonzini@redhat.com>
Message-ID: <3e999ccc-5a8b-9111-06eb-d10bb83f6c43@redhat.com>
Date: Wed, 24 May 2017 10:32:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170511144208.24075-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/18] Block layer thread safety, part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com



On 11/05/2017 16:41, Paolo Bonzini wrote:
> This series uses mutexes or atomic operations around core block layer
> operations.  The remaining parts include:
> 
> I've removed the failing assertion in bdrv_aligned_pwritev in order to
> test block migration.
> 
> Paolo
> 
> v1->v2: add missing comment for 'wakeup' member [Fam]
>         rewrite throttle-groups part [Stefan]
>         rename ThrottleState CoMutex [Fam]
>         minor stats64 changes [Fam, Roman, me]
>         fixed bdrv_flush [Fam, me]
>         dropped request spinlock optimization for now [Stefan]
>         avoid global dirty bitmap mutex [Fam]
>         avoid introducing unlocked bdrv_get_dirty API [Stefan]
>         replaced spinlock with mutex for accounting [Stefan]
>         
> 
> Paolo Bonzini (18):
>   block: access copy_on_read with atomic ops
>   block: access quiesce_counter with atomic ops
>   block: access io_limits_disabled with atomic ops
>   block: access serialising_in_flight with atomic ops
>   block: access wakeup with atomic ops
>   block: access io_plugged with atomic ops
>   throttle-groups: only start one coroutine from drained_begin
>   throttle-groups: do not use qemu_co_enter_next
>   throttle-groups: protect throttled requests with a CoMutex
>   util: add stats64 module
>   block: use Stat64 for wr_highest_offset
>   block: access write_gen with atomics
>   block: protect tracked_requests and flush_queue with reqs_lock
>   block: introduce dirty_bitmap_mutex
>   migration/block: reset dirty bitmap before reading
>   block: protect modification of dirty bitmaps with a mutex
>   block: introduce block_account_one_io
>   block: make accounting thread-safe
> 
>  block.c                        |   9 +-
>  block/accounting.c             |  64 ++++++++------
>  block/block-backend.c          |   5 +-
>  block/dirty-bitmap.c           | 112 ++++++++++++++++++++++--
>  block/io.c                     |  51 ++++++-----
>  block/mirror.c                 |  14 ++-
>  block/nfs.c                    |   4 +-
>  block/qapi.c                   |   2 +-
>  block/sheepdog.c               |   3 +-
>  block/throttle-groups.c        |  91 ++++++++++++++-----
>  blockdev.c                     |  46 ++--------
>  include/block/accounting.h     |   8 +-
>  include/block/block.h          |   5 +-
>  include/block/block_int.h      |  61 ++++++++-----
>  include/block/dirty-bitmap.h   |  25 ++++--
>  include/qemu/stats64.h         | 193 +++++++++++++++++++++++++++++++++++++++++
>  include/sysemu/block-backend.h |  10 +--
>  migration/block.c              |  17 ++--
>  util/Makefile.objs             |   1 +
>  util/stats64.c                 | 136 +++++++++++++++++++++++++++++
>  20 files changed, 679 insertions(+), 178 deletions(-)
>  create mode 100644 include/qemu/stats64.h
>  create mode 100644 util/stats64.c
> 

Ping?

Paolo
