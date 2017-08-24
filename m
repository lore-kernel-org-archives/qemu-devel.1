Received: from eggs.gnu.org ([2001:4830:134:3::10]:51955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxn6-0001b0-IM
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxn5-00046B-7n
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:27:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxn4-00044M-V4
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:27:43 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:26:58 +0100
Message-Id: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 00/32] postcopy+vhost-user/shared ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This is a RFC/WIP series that enables postcopy migration
with shared memory to a vhost-user process.
It's based off current-head + Alexey's bitmap series

It's tested with vhost-user-bridge and a dpdk (modified by Maxime
that will get posted separately) - both very lightly.

It's still got a few very rough edges, but it succesfully migrates
with both normal and huge pages (2M).

The major difference over v1 is that there's a set of code
that merges vhost regions together on the qemu side so that
we get a single hugepage region on the PC spanning the 640k
hole (the hole hopefully isn't accessed by the client,
but the client used to align around it anyway).

It's also got a lot of cleanups from the comments from v1
but there's still a few things that need work.
In particular, there's still the hack around qemu waiting
for the set_mem_table to come back; I also worry what would
happen if a set-mem-table was triggered during a migrate;
I suspect it would break badly.

One problem that didn't cause a problem was madvises for hugepages;
because we register userfault directly after mmap'ing the
region in the client, we have no pages mapped and hence
the madvise's/fallocate's are fortunately not compulsary.
Still, I'd like a way to do it, it would feel safer.

A copy of this code, based off the current 2.10.0-rc4
together with Alexey's bitmap code is available here:
    https://github.com/dagrh/qemu/tree/vhost-wipv2

Dave

Dr. David Alan Gilbert (32):
  vhu: vu_queue_started
  vhub: Only process received packets on started queues
  migrate: Update ram_block_discard_range for shared
  qemu_ram_block_host_offset
  migration/ram: ramblock_recv_bitmap_test_byte_offset
  postcopy: use UFFDIO_ZEROPAGE only when available
  postcopy: Add notifier chain
  postcopy: Add vhost-user flag for postcopy and check it
  vhost-user: Add 'VHOST_USER_POSTCOPY_ADVISE' message
  vhub: Support sending fds back to qemu
  vhub: Open userfaultfd
  postcopy: Allow registering of fd handler
  vhost+postcopy: Register shared ufd with postcopy
  vhost+postcopy: Transmit 'listen' to client
  vhost+postcopy: Register new regions with the ufd
  vhost+postcopy: Send address back to qemu
  vhost+postcopy: Stash RAMBlock and offset
  vhost+postcopy: Send requests to source for shared pages
  vhost+postcopy: Resolve client address
  postcopy: wake shared
  postcopy: postcopy_notify_shared_wake
  vhost+postcopy: Add vhost waker
  vhost+postcopy: Call wakeups
  vub+postcopy: madvises
  vhost+postcopy: Lock around set_mem_table
  vhost: Add VHOST_USER_POSTCOPY_END message
  vhost+postcopy: Wire up POSTCOPY_END notify
  postcopy: Allow shared memory
  vhost-user: Claim support for postcopy
  vhost: Merge neighbouring hugepage regions where appropriate
  vhost: Don't break merged regions on small remove/non-adds
  postcopy shared docs

 contrib/libvhost-user/libvhost-user.c | 226 ++++++++++++++++++++-
 contrib/libvhost-user/libvhost-user.h |  22 ++-
 docs/devel/migration.txt              |  39 ++++
 docs/interop/vhost-user.txt           |  39 ++++
 exec.c                                |  60 ++++--
 hw/virtio/trace-events                |  27 +++
 hw/virtio/vhost-user.c                | 326 +++++++++++++++++++++++++++++-
 hw/virtio/vhost.c                     | 121 +++++++++++-
 include/exec/cpu-common.h             |   4 +
 migration/migration.c                 |   3 +
 migration/migration.h                 |   4 +
 migration/postcopy-ram.c              | 359 +++++++++++++++++++++++++++-------
 migration/postcopy-ram.h              |  69 +++++++
 migration/ram.c                       |   5 +
 migration/ram.h                       |   1 +
 migration/savevm.c                    |  13 ++
 migration/trace-events                |   6 +
 tests/vhost-user-bridge.c             |   1 +
 trace-events                          |   3 +
 vl.c                                  |   2 +
 20 files changed, 1241 insertions(+), 89 deletions(-)

-- 
2.13.5
