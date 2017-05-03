Received: from eggs.gnu.org ([2001:4830:134:3::10]:55254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5rZD-0006E6-Kv
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5rZB-0004Lg-JC
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:31:31 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d5rZB-0004LL-6t
	for qemu-devel@nongnu.org; Wed, 03 May 2017 06:31:29 -0400
Received: by mail-wr0-x22d.google.com with SMTP id w50so102993407wrc.0
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 03:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20170502191630.GF5640@work-vm>
In-Reply-To: <20170502191630.GF5640@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 03 May 2017 10:31:17 +0000
Message-ID: <CAJ+F1CJZ+-C4gj1TFz4rdcuiWyE=y3WrCA2gtmityPQ06cvK-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] crash in vhost-user-bridge on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, maxime.coquelin@redhat.com, peterx@redhat.com
Cc: qemu-devel@nongnu.org

Hi

On Tue, May 2, 2017 at 11:17 PM Dr. David Alan Gilbert <dgilbert@redhat.com=
>
wrote:

> Hi,
>   I've started playing with vhost-user-bridge and have it
> basically up and going, but I've just tried migration and
> I've got a reliable crash for it; I'm not that sure I've
> got it set up right, so suggestions please:
>
> This is with qemu head, on an f26 host running an f25-ish
> guest.
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x000055c414112ce4 in vring_avail_idx (vq=3D0x55c41582fd68,
> vq=3D0x55c41582fd68)
>     at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:940
> 940         vq->shadow_avail_idx =3D vq->vring.avail->idx;
> (gdb) p vq
> $1 =3D (VuVirtq *) 0x55c41582fd68
> (gdb) p vq->vring
> $2 =3D {num =3D 0, desc =3D 0x0, avail =3D 0x0, used =3D 0x0, log_guest_a=
ddr =3D 0,
> flags =3D 0}
> (gdb) p vq->shadow_avail_idx
> $3 =3D 0
>
> #0  0x000055c414112ce4 in vring_avail_idx (vq=3D0x55c41582fd68,
> vq=3D0x55c41582fd68)
>     at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:940
> No locals.
> #1  virtqueue_num_heads (idx=3D0, vq=3D0x55c41582fd68, dev=3D0x55c41582fc=
20)
>     at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:960
>         num_heads =3D <optimized out>
> #2  vu_queue_get_avail_bytes (dev=3D0x55c41582fc20, vq=3D0x55c41582fd68,
> in_bytes=3Din_bytes@entry=3D0x7fffd035d7c0,
>     out_bytes=3Dout_bytes@entry=3D0x7fffd035d7c4,
> max_in_bytes=3Dmax_in_bytes@entry=3D0,
>     max_out_bytes=3Dmax_out_bytes@entry=3D0) at
> /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:1034
>         idx =3D 0
>         total_bufs =3D 0
>         in_total =3D 0
>         out_total =3D 0
>         rc =3D <optimized out>
> #3  0x000055c414112fbd in vu_queue_avail_bytes (dev=3D<optimized out>,
> vq=3D<optimized out>, in_bytes=3D0, out_bytes=3D0)
>     at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:1116
>         in_total =3D 0
>         out_total =3D 0
> #4  0x000055c4141114da in vubr_backend_recv_cb (sock=3D<optimized out>,
> ctx=3D0x55c41582fc20)
>     at /home/dgilbert/git/qemu/tests/vhost-user-bridge.c:276
>         vubr =3D 0x55c41582fc20
>         dev =3D 0x55c41582fc20
>         vq =3D 0x55c41582fd68
>         elem =3D 0x0
>         mhdr_sg =3D {{iov_base =3D 0x0, iov_len =3D 0} <repeats 740 times=
>,
> {iov_base =3D 0x0, iov_len =3D 140512740079088}, {
>                    .....}
>
>         mhdr =3D {hdr =3D {flags =3D 0 '\000', gso_type =3D 0 '\000', hdr=
_len =3D 0,
> gso_size =3D 0, csum_start =3D 0,
>             csum_offset =3D 0}, num_buffers =3D 0}
>         mhdr_cnt =3D 0
>         hdrlen =3D 0
>         i =3D 0
>         hdr =3D {flags =3D 0 '\000', gso_type =3D 0 '\000', hdr_len =3D 0=
,
> gso_size =3D 0, csum_start =3D 0, csum_offset =3D 0}
>         __PRETTY_FUNCTION__ =3D "vubr_backend_recv_cb"
> #5  0x000055c414110ad3 in dispatcher_wait (timeout=3D200000,
> dispr=3D0x55c4158300b8)
>     at /home/dgilbert/git/qemu/tests/vhost-user-bridge.c:154
>         e =3D 0x55c415830180
>
>
This happens because vubr assumes that if a ring is enabled, it should be
able to use/read it.
This is not the case, as qemu may enable a ring before the slave has the
ring addresses.

The protocol has evolved regarding this. There are multiple ways to fix
this, I think the simplest is for vu_queue_avail_bytes() to return false if
the ring is not available. I'll send a patch.

That's from the destination bridge; I'm running both on a single
> host and that's happening when I just do a :
>    migrate_set_speed 1G
>    migrate tcp:localhost:8888
>
> The destination qemu spits out:
> qemu-system-x86_64: Failed to set msg fds.
> qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Resource
> temporarily unavailable (11)
> qemu-system-x86_64: Failed to set msg fds.
> qemu-system-x86_64: vhost VQ 1 ring restore failed: -1: Resource
> temporarily unavailable (11)
>
> but I'm not sure if that's before or after the seg of the bridge.
>

That is after, on disconnect.

>
> I've got:
>   a) One qemu that just has the -net socket / -net user setup as per the
> docs - but I've got
>      two lots of sockets for either side
>   b) Two qemus for the guests, teh second with just the -incoming
>   c) The two vhost-user-bridge instances - the destination being pointed
> at the second set of sockets.
>
> My test is run by doing:
> #!/bin/bash -x
> SESS=3Dvhost
> tmux -L $SESS new-session -d
> tmux -L $SESS set-option -g set-remain-on-exit on
> # Start a router using the system qemu
> tmux -L $SESS new-window -n router qemu-system-x86_64 -M none -nographic
> -net socket,vlan=3D0,udp=3Dlocalhost:4444,localaddr=3Dlocalhost:5555 -net
> socket,vlan=3D0,udp=3Dlocalhost:4445,localaddr=3Dlocalhost:5556 -net user=
,vlan=3D0
> # Start source vhost bridge
> tmux -L $SESS new-window -n srcvhostbr ./tests/vhost-user-bridge -u
> /tmp/vubrsrc.sock
> tmux -L $SESS new-window -n source "./x86_64-softmmu/qemu-system-x86_64
> -enable-kvm -m 1G -smp 2 -object
> memory-backend-file,id=3Dmem,size=3D1G,mem-path=3D/dev/shm,share=3Don -nu=
ma
> node,memdev=3Dmem -mem-prealloc -chardev
> socket,id=3Dchar0,path=3D/tmp/vubrsrc.sock -netdev
> type=3Dvhost-user,id=3Dmynet1,chardev=3Dchar0,vhostforce -device
> virtio-net-pci,netdev=3Dmynet1 /home/vmimages/f25.qcow2 -net none"
> # Start dest vhost bridge
> tmux -L $SESS new-window -n destvhostbr ./tests/vhost-user-bridge -u
> /tmp/vubrdst.sock -l 127.0.0.1:4445 -r 127.0.0.1:5556
> tmux -L $SESS new-window -n dest "./x86_64-softmmu/qemu-system-x86_64
> -enable-kvm -m 1G -smp 2 -object
> memory-backend-file,id=3Dmem,size=3D1G,mem-path=3D/dev/shm,share=3Don -nu=
ma
> node,memdev=3Dmem -mem-prealloc -chardev
> socket,id=3Dchar0,path=3D/tmp/vubrdst.sock -netdev
> type=3Dvhost-user,id=3Dmynet1,chardev=3Dchar0,vhostforce -device
> virtio-net-pci,netdev=3Dmynet1 /home/vmimages/f25.qcow2 -net none -incomi=
ng
> tcp::8888"
>
> (I've got a few added printf's so the lines might be off by a few).
>
>
Thanks for the report
--=20
Marc-Andr=C3=A9 Lureau
