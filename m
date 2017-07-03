Received: from eggs.gnu.org ([2001:4830:134:3::10]:60531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dS1sp-0003r4-Tv
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dS1sk-0002Th-U6
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:59:23 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:30211)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dS1sk-0002NZ-L0
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:59:18 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OSI00HT7PIC0090@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:59:00 +0100 (BST)
Date: Mon, 03 Jul 2017 16:58:58 +0300
From: Alexey <a.perevalov@samsung.com>
Message-id: <20170703135135.GA4557@aperevalov-ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<CGME20170703135859eucas1p1edc55e3318a3079b026bed81e0ae0388@eucas1p1.samsung.com>
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
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com


Hello, David!

Thank for you patch set.

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

userfault fd should be only one per all affected processes. But
why are you opening userfaultfd on client side, why not to pass
userfault fd which was opened at QEMU side? I guess, it could
be several virtual switches with different ports (it's exotic
configuration, but configuration when we have one QEMU, one vswitchd,
and serveral vhost-user ports is typical), and as example,
QEMU could be connected to these vswitches through these ports.
In this case you will obtain 2 different userfault fd in QEMU.
In case of one QEMU, one vswitchd and several vhost-user ports,
you are keeping userfaultfd in VuDev structure on client side,
looks like it's virtion_net sibling from DPDK, and that structure
is per vhost-user connection (per one port).

So from my point of view it's better to open fd on QEMU side, and pass it
the same way as shared mem fd in SET_MEM_TABLE, but in POSTCOPY_ADVISE.


> 
> QEMU then reads the clients UFD in it's fault thread and issues
> requests back to the source as needed.
> QEMU also issues 'WAKE' ioctls on the UFD to let the client know
> that the page has arrived and can carry on.
Not so clear for me why QEMU have to inform vhost client,
due to single userfault fd, and kernel should wake up another faulted
thread/processes.
In my approach I just to send information about copied/received page
to vhot client, to be able to enable previously disabled VRING.

> 
> A new feature (VHOST_USER_PROTOCOL_F_POSTCOPY) is added so that
> the QEMU knows the client can talk postcopy.
> Three new messages (VHOST_USER_POSTCOPY_{ADVISE/LISTEN/END}) are
> added to guide the process along.
> 
> Current known issues:
>    I've not tested it with hugepages yet; and I suspect the madvises
>    will need tweaking for it.
I saw you didn't change order of SET_MEM_TABLE call in QEMU side,
some part or pages already arrived and copied, so I'm doing
hole here according to received map.

> 
>    The qemu gets to see the base addresses that the client has its
>    regions mapped at; that's not great for security
> 
>    Take care of deadlocking; any thread in the client that
>    accesses a userfault protected page can stall.
That's why I decided to disable VRINGs, but not the way as you did
in GET_VRING_BASE, I send received bitmap, right after SET_MEM_TABLE,
here could be synchronization problem, maybe similar problem as you described in
"vhost+postcopy: Lock around set_mem_table"

Unfortunately, my patches isn't yet ready.

> 
>    There's a nasty hack of a lock around the set_mem_table message.
> 
>    I've not looked at the recent IOMMU code.
> 
>    Some cleanup and a lot of corner cases need thinking about.
> 
>    There are probably plenty of unknown issues as well.
> 
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
> 
> 

-- 

BR
Alexey
