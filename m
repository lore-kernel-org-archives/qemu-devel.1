Received: from eggs.gnu.org ([2001:4830:134:3::10]:42106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dnm63-00032p-7K
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 09:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dnm5y-0001SA-5m
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 09:34:55 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49555)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dnm5x-0001Pa-T9
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 09:34:50 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <ad360122-de03-39a8-21a8-d8968e885875@samsung.com>
Date: Fri, 01 Sep 2017 16:34:36 +0300
MIME-version: 1.0
In-reply-to: <20170824192730.8440-1-dgilbert@redhat.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <CGME20170824192750epcas5p484df9724ca7c0a259a4dd85425a69e1d@epcas5p4.samsung.com>
	<20170824192730.8440-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 00/32] postcopy+vhost-user/shared ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, maxime.coquelin@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

Hello David,

You wrote in previous version:

>We've had a postcopy migrate work now, with a few hacks we're still
>cleaning up, both on vhost-user-bridge and dpdk; so I'll get this
>updated and reposted.

I want to know more about DPDK work, do you know, is somebody assigned to that task?



On 08/24/2017 10:26 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Hi,
>    This is a RFC/WIP series that enables postcopy migration
> with shared memory to a vhost-user process.
> It's based off current-head + Alexey's bitmap series
>
> It's tested with vhost-user-bridge and a dpdk (modified by Maxime
> that will get posted separately) - both very lightly.
>
> It's still got a few very rough edges, but it succesfully migrates
> with both normal and huge pages (2M).
>
> The major difference over v1 is that there's a set of code
> that merges vhost regions together on the qemu side so that
> we get a single hugepage region on the PC spanning the 640k
> hole (the hole hopefully isn't accessed by the client,
> but the client used to align around it anyway).
>
> It's also got a lot of cleanups from the comments from v1
> but there's still a few things that need work.
> In particular, there's still the hack around qemu waiting
> for the set_mem_table to come back; I also worry what would
> happen if a set-mem-table was triggered during a migrate;
> I suspect it would break badly.
>
> One problem that didn't cause a problem was madvises for hugepages;
> because we register userfault directly after mmap'ing the
> region in the client, we have no pages mapped and hence
> the madvise's/fallocate's are fortunately not compulsary.
> Still, I'd like a way to do it, it would feel safer.
>
> A copy of this code, based off the current 2.10.0-rc4
> together with Alexey's bitmap code is available here:
>      https://github.com/dagrh/qemu/tree/vhost-wipv2
>
> Dave
>
> Dr. David Alan Gilbert (32):
>    vhu: vu_queue_started
>    vhub: Only process received packets on started queues
>    migrate: Update ram_block_discard_range for shared
>    qemu_ram_block_host_offset
>    migration/ram: ramblock_recv_bitmap_test_byte_offset
>    postcopy: use UFFDIO_ZEROPAGE only when available
>    postcopy: Add notifier chain
>    postcopy: Add vhost-user flag for postcopy and check it
>    vhost-user: Add 'VHOST_USER_POSTCOPY_ADVISE' message
>    vhub: Support sending fds back to qemu
>    vhub: Open userfaultfd
>    postcopy: Allow registering of fd handler
>    vhost+postcopy: Register shared ufd with postcopy
>    vhost+postcopy: Transmit 'listen' to client
>    vhost+postcopy: Register new regions with the ufd
>    vhost+postcopy: Send address back to qemu
>    vhost+postcopy: Stash RAMBlock and offset
>    vhost+postcopy: Send requests to source for shared pages
>    vhost+postcopy: Resolve client address
>    postcopy: wake shared
>    postcopy: postcopy_notify_shared_wake
>    vhost+postcopy: Add vhost waker
>    vhost+postcopy: Call wakeups
>    vub+postcopy: madvises
>    vhost+postcopy: Lock around set_mem_table
>    vhost: Add VHOST_USER_POSTCOPY_END message
>    vhost+postcopy: Wire up POSTCOPY_END notify
>    postcopy: Allow shared memory
>    vhost-user: Claim support for postcopy
>    vhost: Merge neighbouring hugepage regions where appropriate
>    vhost: Don't break merged regions on small remove/non-adds
>    postcopy shared docs
>
>   contrib/libvhost-user/libvhost-user.c | 226 ++++++++++++++++++++-
>   contrib/libvhost-user/libvhost-user.h |  22 ++-
>   docs/devel/migration.txt              |  39 ++++
>   docs/interop/vhost-user.txt           |  39 ++++
>   exec.c                                |  60 ++++--
>   hw/virtio/trace-events                |  27 +++
>   hw/virtio/vhost-user.c                | 326 +++++++++++++++++++++++++++++-
>   hw/virtio/vhost.c                     | 121 +++++++++++-
>   include/exec/cpu-common.h             |   4 +
>   migration/migration.c                 |   3 +
>   migration/migration.h                 |   4 +
>   migration/postcopy-ram.c              | 359 +++++++++++++++++++++++++++-------
>   migration/postcopy-ram.h              |  69 +++++++
>   migration/ram.c                       |   5 +
>   migration/ram.h                       |   1 +
>   migration/savevm.c                    |  13 ++
>   migration/trace-events                |   6 +
>   tests/vhost-user-bridge.c             |   1 +
>   trace-events                          |   3 +
>   vl.c                                  |   2 +
>   20 files changed, 1241 insertions(+), 89 deletions(-)
>

-- 
Best regards,
Alexey Perevalov
