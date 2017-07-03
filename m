Received: from eggs.gnu.org ([2001:4830:134:3::10]:41496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS5ZM-0006qb-JY
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 13:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS5ZJ-00087Z-Fu
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 13:55:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dS5ZJ-000875-5x
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 13:55:29 -0400
Date: Mon, 3 Jul 2017 20:55:20 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170703205127-mutt-send-email-mst@kernel.org>
References: <20170628190047.26159-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [RFC 00/29] postcopy+vhost-user/shared ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

On Wed, Jun 28, 2017 at 08:00:18PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   This is a RFC/WIP series that enables postcopy migration
> with shared memory to a vhost-user process.
> It's based off current-head + Juan's load_cleanup series, and
> Alexey's bitmap series (v4).  It's very lightly tested and seems
> to work, but it's quite rough.
> 
> I've modified the vhost-user-bridge (aka vhub) in qemu's tests/ to
> use the new feature, since this is about the simplest
> client around.
> 
> Structure:
> 
> The basic idea is that near the start of postcopy, the client
> opens its own userfaultfd fd and sends that back to QEMU over
> the socket it's already using for VHUST_USER_* commands.
> Then when VHOST_USER_SET_MEM_TABLE arrives it registers the
> areas with userfaultfd and sends the mapped addresses back to QEMU.
> 
> QEMU then reads the clients UFD in it's fault thread and issues
> requests back to the source as needed.
> QEMU also issues 'WAKE' ioctls on the UFD to let the client know
> that the page has arrived and can carry on.
> 
> A new feature (VHOST_USER_PROTOCOL_F_POSTCOPY) is added so that
> the QEMU knows the client can talk postcopy.
> Three new messages (VHOST_USER_POSTCOPY_{ADVISE/LISTEN/END}) are
> added to guide the process along.
> 
> Current known issues:
>    I've not tested it with hugepages yet; and I suspect the madvises
>    will need tweaking for it.
> 
>    The qemu gets to see the base addresses that the client has its
>    regions mapped at; that's not great for security

Not urgent to fix.

>    Take care of deadlocking; any thread in the client that
>    accesses a userfault protected page can stall.

And it can happen under a lock quite easily.
What exactly is proposed here?
Maybe we want to reuse the new channel that the IOMMU uses.


>    There's a nasty hack of a lock around the set_mem_table message.

Yes.

>    I've not looked at the recent IOMMU code.
> 
>    Some cleanup and a lot of corner cases need thinking about.
> 
>    There are probably plenty of unknown issues as well.

At the protocol level, I'd like to rename the feature to
USER_PAGEFAULT. Client does not really know anything about
copies, it's all internal to qemu.
Spec can document that it's used by qemu for postcopy.


> Test setup:
>   I'm running on one host at the moment, with the guest
>   scping a large file from the host as it migrates.
>   The setup is based on one I found in the vhost-user setups.
>   You'll need a recent kernel for the shared memory support
>   in userfaultfd, and userfault isn't that happy if a process
>   using shared memory core's - so make sure you have the
>   latest fixes.
> 
> SESS=vhost
> ulimit -c unlimited
> tmux -L $SESS new-session -d
> tmux -L $SESS set-option -g history-limit 30000
> # Start a router using the system qemu
> tmux -L $SESS new-window -n router ./x86_64-softmmu/qemu-system-x86_64 -M none -nographic -net socket,vlan=0,udp=loca
> lhost:4444,localaddr=localhost:5555 -net socket,vlan=0,udp=localhost:4445,localaddr=localhost:5556 -net user,vlan=0
> tmux -L $SESS set-option -g set-remain-on-exit on
> # Start source vhost bridge
> tmux -L $SESS new-window -n srcvhostbr "./tests/vhost-user-bridge -u /tmp/vubrsrc.sock 2>src-vub-log"
> sleep 0.5
> tmux -L $SESS new-window -n source "./x86_64-softmmu/qemu-system-x86_64 -enable-kvm -m 8G -smp 2 -object memory-backe
> nd-file,id=mem,size=8G,mem-path=/dev/shm,share=on -numa node,memdev=mem -mem-prealloc -chardev socket,id=char0,path=/
> tmp/vubrsrc.sock -netdev type=vhost-user,id=mynet1,chardev=char0,vhostforce -device virtio-net-pci,netdev=mynet1 my.qcow2 -net none -vnc :0 -monitor stdio -trace events=/root/trace-file 2>src-qemu-log "
> # Start dest vhost bridge
> tmux -L $SESS new-window -n destvhostbr "./tests/vhost-user-bridge -u /tmp/vubrdst.sock -l 127.0.0.1:4445 -r 127.0.0.
> 1:5556 2>dst-vub-log"
> sleep 0.5
> tmux -L $SESS new-window -n dest "./x86_64-softmmu/qemu-system-x86_64 -enable-kvm -m 8G -smp 2 -object memory-backend
> -file,id=mem,size=8G,mem-path=/dev/shm,share=on -numa node,memdev=mem -mem-prealloc -chardev socket,id=char0,path=/tm
> p/vubrdst.sock -netdev type=vhost-user,id=mynet1,chardev=char0,vhostforce -device virtio-net-pci,netdev=mynet1 my.qcow2 -net none -vnc :1 -monitor stdio -incoming tcp::8888 -trace events=/root/trace-file 2>dst-qemu-log"
> tmux -L $SESS send-keys -t source "migrate_set_capability postcopy-ram on
> tmux -L $SESS send-keys -t source "migrate_set_speed 20M
> tmux -L $SESS send-keys -t dest "migrate_set_capability postcopy-ram on
> 
> then once booted:
> tmux -L vhost send-keys -t source 'migrate -d tcp:0:8888^M'
> tmux -L vhost send-keys -t source 'migrate_start_postcopy^M'
> (Note those ^M's are actual ctrl-M's i.e. ctrl-v ctrl-M)
> 
> 
> Dave
> 
> Dr. David Alan Gilbert (29):
>   RAMBlock/migration: Add migration flags
>   migrate: Update ram_block_discard_range for shared
>   qemu_ram_block_host_offset
>   migration/ram: ramblock_recv_bitmap_test_byte_offset
>   postcopy: use UFFDIO_ZEROPAGE only when available
>   postcopy: Add notifier chain
>   postcopy: Add vhost-user flag for postcopy and check it
>   vhost-user: Add 'VHOST_USER_POSTCOPY_ADVISE' message
>   vhub: Support sending fds back to qemu
>   vhub: Open userfaultfd
>   postcopy: Allow registering of fd handler
>   vhost+postcopy: Register shared ufd with postcopy
>   vhost+postcopy: Transmit 'listen' to client
>   vhost+postcopy: Register new regions with the ufd
>   vhost+postcopy: Send address back to qemu
>   vhost+postcopy: Stash RAMBlock and offset
>   vhost+postcopy: Send requests to source for shared pages
>   vhost+postcopy: Resolve client address
>   postcopy: wake shared
>   postcopy: postcopy_notify_shared_wake
>   vhost+postcopy: Add vhost waker
>   vhost+postcopy: Call wakeups
>   vub+postcopy: madvises
>   vhost+postcopy: Lock around set_mem_table
>   vhu: enable = false on get_vring_base
>   vhost: Add VHOST_USER_POSTCOPY_END message
>   vhost+postcopy: Wire up POSTCOPY_END notify
>   postcopy: Allow shared memory
>   vhost-user: Claim support for postcopy
> 
>  contrib/libvhost-user/libvhost-user.c | 178 ++++++++++++++++-
>  contrib/libvhost-user/libvhost-user.h |   8 +
>  exec.c                                |  44 +++--
>  hw/virtio/trace-events                |  13 ++
>  hw/virtio/vhost-user.c                | 293 +++++++++++++++++++++++++++-
>  include/exec/cpu-common.h             |   3 +
>  include/exec/ram_addr.h               |   2 +
>  migration/migration.c                 |   3 +
>  migration/migration.h                 |   8 +
>  migration/postcopy-ram.c              | 357 +++++++++++++++++++++++++++-------
>  migration/postcopy-ram.h              |  69 +++++++
>  migration/ram.c                       |   5 +
>  migration/ram.h                       |   1 +
>  migration/savevm.c                    |  13 ++
>  migration/trace-events                |   6 +
>  trace-events                          |   3 +
>  vl.c                                  |   4 +-
>  17 files changed, 926 insertions(+), 84 deletions(-)
> 
> -- 
> 2.13.0
