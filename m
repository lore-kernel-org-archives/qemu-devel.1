Received: from eggs.gnu.org ([2001:4830:134:3::10]:57158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d5dHy-00087j-9y
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d5dHt-0002W3-6Q
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:16:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32433)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d5dHs-0002V9-Sb
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:16:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7EB4C20AE86
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 19:16:39 +0000 (UTC)
Date: Tue, 2 May 2017 20:16:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170502191630.GF5640@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] crash in vhost-user-bridge on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, peterx@redhat.com
Cc: qemu-devel@nongnu.org

Hi,
  I've started playing with vhost-user-bridge and have it
basically up and going, but I've just tried migration and
I've got a reliable crash for it; I'm not that sure I've
got it set up right, so suggestions please:

This is with qemu head, on an f26 host running an f25-ish
guest.

Program received signal SIGSEGV, Segmentation fault.
0x000055c414112ce4 in vring_avail_idx (vq=0x55c41582fd68, vq=0x55c41582fd68)
    at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:940
940	    vq->shadow_avail_idx = vq->vring.avail->idx;
(gdb) p vq
$1 = (VuVirtq *) 0x55c41582fd68
(gdb) p vq->vring
$2 = {num = 0, desc = 0x0, avail = 0x0, used = 0x0, log_guest_addr = 0, flags = 0}
(gdb) p vq->shadow_avail_idx
$3 = 0

#0  0x000055c414112ce4 in vring_avail_idx (vq=0x55c41582fd68, vq=0x55c41582fd68)
    at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:940
No locals.
#1  virtqueue_num_heads (idx=0, vq=0x55c41582fd68, dev=0x55c41582fc20)
    at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:960
        num_heads = <optimized out>
#2  vu_queue_get_avail_bytes (dev=0x55c41582fc20, vq=0x55c41582fd68, in_bytes=in_bytes@entry=0x7fffd035d7c0, 
    out_bytes=out_bytes@entry=0x7fffd035d7c4, max_in_bytes=max_in_bytes@entry=0, 
    max_out_bytes=max_out_bytes@entry=0) at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:1034
        idx = 0
        total_bufs = 0
        in_total = 0
        out_total = 0
        rc = <optimized out>
#3  0x000055c414112fbd in vu_queue_avail_bytes (dev=<optimized out>, vq=<optimized out>, in_bytes=0, out_bytes=0)
    at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:1116
        in_total = 0
        out_total = 0
#4  0x000055c4141114da in vubr_backend_recv_cb (sock=<optimized out>, ctx=0x55c41582fc20)
    at /home/dgilbert/git/qemu/tests/vhost-user-bridge.c:276
        vubr = 0x55c41582fc20
        dev = 0x55c41582fc20
        vq = 0x55c41582fd68
        elem = 0x0
        mhdr_sg = {{iov_base = 0x0, iov_len = 0} <repeats 740 times>, {iov_base = 0x0, iov_len = 140512740079088}, {
                   .....}

        mhdr = {hdr = {flags = 0 '\000', gso_type = 0 '\000', hdr_len = 0, gso_size = 0, csum_start = 0, 
            csum_offset = 0}, num_buffers = 0}
        mhdr_cnt = 0
        hdrlen = 0
        i = 0
        hdr = {flags = 0 '\000', gso_type = 0 '\000', hdr_len = 0, gso_size = 0, csum_start = 0, csum_offset = 0}
        __PRETTY_FUNCTION__ = "vubr_backend_recv_cb"
#5  0x000055c414110ad3 in dispatcher_wait (timeout=200000, dispr=0x55c4158300b8)
    at /home/dgilbert/git/qemu/tests/vhost-user-bridge.c:154
        e = 0x55c415830180

That's from the destination bridge; I'm running both on a single
host and that's happening when I just do a :
   migrate_set_speed 1G
   migrate tcp:localhost:8888

The destination qemu spits out:
qemu-system-x86_64: Failed to set msg fds.
qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Resource temporarily unavailable (11)
qemu-system-x86_64: Failed to set msg fds.
qemu-system-x86_64: vhost VQ 1 ring restore failed: -1: Resource temporarily unavailable (11)

but I'm not sure if that's before or after the seg of the bridge.

I've got:
  a) One qemu that just has the -net socket / -net user setup as per the docs - but I've got
     two lots of sockets for either side
  b) Two qemus for the guests, teh second with just the -incoming
  c) The two vhost-user-bridge instances - the destination being pointed at the second set of sockets.

My test is run by doing:
#!/bin/bash -x
SESS=vhost
tmux -L $SESS new-session -d
tmux -L $SESS set-option -g set-remain-on-exit on
# Start a router using the system qemu
tmux -L $SESS new-window -n router qemu-system-x86_64 -M none -nographic -net socket,vlan=0,udp=localhost:4444,localaddr=localhost:5555 -net socket,vlan=0,udp=localhost:4445,localaddr=localhost:5556 -net user,vlan=0
# Start source vhost bridge
tmux -L $SESS new-window -n srcvhostbr ./tests/vhost-user-bridge -u /tmp/vubrsrc.sock
tmux -L $SESS new-window -n source "./x86_64-softmmu/qemu-system-x86_64 -enable-kvm -m 1G -smp 2 -object memory-backend-file,id=mem,size=1G,mem-path=/dev/shm,share=on -numa node,memdev=mem -mem-prealloc -chardev socket,id=char0,path=/tmp/vubrsrc.sock -netdev type=vhost-user,id=mynet1,chardev=char0,vhostforce -device virtio-net-pci,netdev=mynet1 /home/vmimages/f25.qcow2 -net none"
# Start dest vhost bridge
tmux -L $SESS new-window -n destvhostbr ./tests/vhost-user-bridge -u /tmp/vubrdst.sock -l 127.0.0.1:4445 -r 127.0.0.1:5556
tmux -L $SESS new-window -n dest "./x86_64-softmmu/qemu-system-x86_64 -enable-kvm -m 1G -smp 2 -object memory-backend-file,id=mem,size=1G,mem-path=/dev/shm,share=on -numa node,memdev=mem -mem-prealloc -chardev socket,id=char0,path=/tmp/vubrdst.sock -netdev type=vhost-user,id=mynet1,chardev=char0,vhostforce -device virtio-net-pci,netdev=mynet1 /home/vmimages/f25.qcow2 -net none -incoming tcp::8888"

(I've got a few added printf's so the lines might be off by a few).

Thanks,

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
