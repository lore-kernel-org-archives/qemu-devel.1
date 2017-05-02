Received: from eggs.gnu.org ([2001:4830:134:3::10]:40569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5ZwV-00044T-2N
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5ZwU-0004Nl-1h
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:42:23 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170420120058.28404-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4f58049d-957a-a5ab-91ae-5dfa46b56a69@redhat.com>
Date: Tue, 2 May 2017 17:42:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170420120058.28404-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 00/17] Block layer thread safety,
 part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org



On 20/04/2017 14:00, Paolo Bonzini wrote:
> This series uses mutexes or atomic operations around core block layer
> operations.  The remaining parts include:
> 
> - drivers, though most of them are already thread safe (part 2, 8 patches,
>   depends on Kevin's conversion of QED to coroutines)
> 
> - block jobs, before-write notifiers, the write threshold mechanism,
>   snapshots, replication, key management (part 3, 16 patches)
> 
> - devices (virtio-blk/virtio-scsi, part 4, 5 patches)
> 
> Once these four parts are done the AioContext lock can be removed
> together with all temporary workarounds that have accumulated.

Ping?

Paolo

> Paolo
> 
> Paolo Bonzini (17):
>   block: access copy_on_read with atomic ops
>   block: access quiesce_counter with atomic ops
>   block: access io_limits_disabled with atomic ops
>   block: access serialising_in_flight with atomic ops
>   block: access wakeup with atomic ops
>   block: access io_plugged with atomic ops
>   throttle-groups: do not use qemu_co_enter_next
>   throttle-groups: protect throttled requests with a CoMutex
>   util: add stats64 module
>   block: use Stat64 for wr_highest_offset
>   block: access write_gen with atomics
>   block: protect tracked_requests and flush_queue with reqs_lock
>   coroutine-lock: introduce qemu_co_mutex_lock_unlock
>   block: optimize access to reqs_lock
>   block: introduce dirty_bitmap_mutex
>   block: protect modification of dirty bitmaps with a mutex
>   block: make accounting thread-safe
> 
>  block.c                        |  10 +-
>  block/accounting.c             |  15 +++
>  block/block-backend.c          |   5 +-
>  block/dirty-bitmap.c           | 125 ++++++++++++++++++++++--
>  block/io.c                     |  70 +++++++++-----
>  block/mirror.c                 |  14 ++-
>  block/nfs.c                    |   4 +-
>  block/qapi.c                   |   2 +-
>  block/sheepdog.c               |   3 +-
>  block/throttle-groups.c        |  76 +++++++++++++--
>  block/write-threshold.c        |  37 ++++----
>  blockdev.c                     |  46 ++-------
>  include/block/accounting.h     |   8 +-
>  include/block/block.h          |   5 +-
>  include/block/block_int.h      |  63 ++++++++-----
>  include/block/dirty-bitmap.h   |  23 ++++-
>  include/qemu/coroutine.h       |   6 ++
>  include/qemu/stats64.h         | 210 +++++++++++++++++++++++++++++++++++++++++
>  include/sysemu/block-backend.h |  10 +-
>  migration/block.c              |   6 --
>  util/Makefile.objs             |   1 +
>  util/qemu-coroutine-lock.c     |  36 +++++++
>  util/stats64.c                 | 135 ++++++++++++++++++++++++++
>  23 files changed, 763 insertions(+), 147 deletions(-)
>  create mode 100644 include/qemu/stats64.h
>  create mode 100644 util/stats64.c
> 
