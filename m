Received: from eggs.gnu.org ([2001:4830:134:3::10]:59037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhunxun@gmail.com>) id 1ehCRc-0002vT-5P
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:50:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhunxun@gmail.com>) id 1ehCRY-0004xM-8I
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:50:16 -0500
Received: from mail-it0-x22c.google.com ([2607:f8b0:4001:c0b::22c]:53527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhunxun@gmail.com>) id 1ehCRY-0004we-02
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:50:12 -0500
Received: by mail-it0-x22c.google.com with SMTP id b5so3640995itc.3
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 02:50:11 -0800 (PST)
Date: Thu, 1 Feb 2018 18:50:09 +0800
From: jack <zhunxun@gmail.com>
Message-ID: <6A9ADB26-2A6F-4411-8DCC-D4253F903189@gmail.com>
In-Reply-To: <20180201103026.GC2457@work-vm>
References: <CADUDsAo6ku+WT1+DTG6u6CUjdg6xzG6LwBt8RwHK4eR_UWY=Jg@mail.gmail.com>
	<20180131173154.GA2520@work-vm>
	<CADUDsArE1tfNyiHB13a_GoizMn7pEoT2_s8JX7OeDuK_=xcB=A@mail.gmail.com>
	<20180201095118.GA2457@work-vm>
	<CADUDsApj9ScOSNq0PJfH7XdFxbZau_=yuBbBNFc9vaEQrr3B3g@mail.gmail.com>
	<20180201103026.GC2457@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] vhost-user question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?utf-8?Q?qemu=E5=BC=80=E5=8F=91=E8=80=85=E9=82=AE=E4=BB=B6=E5=88=97=E8=A1=A8?= <qemu-devel@nongnu.org>, "=?utf-8?Q?maxime.coquelin=40redhat.com?=" <maxime.coquelin@redhat.com>

   that is what i really  want to know,thanks very very much!!!
   from jack chen
   On 2/1/2018 18:30，[1]Dr. David Alan Gilbert<dgilbert@redhat.com> wrote：

     * jack.chen (zhunxun@gmail.com) wrote:
     > Thanks,But my question is how the fd belonging to qemu can be used
      in
     > another process such as DPDK？is fd just effective within one proce
     ss?
     > for example ,if process A open file a.txt,and it gets one fd。the f
     d
     > can only be used in process A ,can it be used in process B?
     Both processes can use the fd - but it needs a trick.
     Unix sockets can pass fd's between processes - so you pass the fd do
     wn
     the socket and it's received on the destination - the number the fd
     gets
     is different on the two processes, but ti still represents the same
     underlying fd on the same file.
     Follow the call to vhost_user_write in vhost_user_set_mem_table you
     see
     it takes the 'fds' array, that eventually gets passed over the unix
     socket.
     Dave
     > 2018-02-01 17:51 GMT+08:00 Dr. David Alan Gilbert <dgilbert@redhat
     .com>:
     > > * jack.chen (zhunxun@gmail.com) wrote:
     > >> thanks,but I really can not understand how the fd works,can som
     eone
     > >> explain it or give me some  reference material??
     > >
     > > Probably the man page for the mmap system call, or an introducti
     on to
     > > linux/unix syscalls.  Just remember that any shared memory will
     be
     > > 'backed' by a file (or something that works like a file), and if
      it's a
     > > file, when you open it you get a file descriptor.  Once you have
      that fd
     > > you can map it somewhere else.
     > >
     > > Dave
     > >
     > >>
     > >> 2018-02-01 1:31 GMT+08:00 Dr. David Alan Gilbert <dgilbert@redh
     at.com>:
     > >> > * jack.chen (zhunxun@gmail.com) wrote:
     > >> >> hello,I am confused when I read vhost-user source code in qe
     mu.I know
     > >> >> vhost-user app shared memory with qemu by mmap,but why it ca
     n use fd which
     > >> >> is belong to qemu?
     > >> >> relative code:
     > >> >>  qemu code in function vhost_user_set_mem_table
     > >> >> fd = memory_region_get_fd(mr);
     > >> >>         if (fd > 0) {
     > >> >>             msg.payload.memory.regions[fd_num].userspace_add
     r =
     > >> >> reg->userspace_addr;
     > >> >>             msg.payload.memory.regions[fd_num].memory_size
     =
     > >> >> reg->memory_size;
     > >> >>             msg.payload.memory.regions[fd_num].guest_phys_ad
     dr =
     > >> >> reg->guest_phys_addr;
     > >> >>             msg.payload.memory.regions[fd_num].mmap_offset =
      offset;
     > >> >>             assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
     > >> >>             fds[fd_num++] = fd;
     > >> >>         }
     > >> >>
     > >> >> ……
     > >> >> DPDK code in vhost_user_set_mem_table
     > >> >>
     > >> >> mmap_addr = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
     > >> >> MAP_SHARED | MAP_POPULATE, fd, 0);
     > >> >> ……
     > >> >>
     > >> >> thanks a lot!
     > >> >
     > >> > Because that's how the dpdk/vhost-user binary knows what to m
     map;
     > >> > each fd corresponds to the backing file of the memory area th
     at's being
     > >> > shared.  This way the dpdk/vhost doesn't need to open those f
     iles itself
     > >> > or try and match the exact memory configuration of qemu; QEMU
      just gives
     > >> > it the exact thing it needs to mmap - which is just the fd an
     d offsets.
     > >> >
     > >> > Dave
     > >> >
     > >> > --
     > >> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
     > > --
     > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
     --
     Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

References

   1. mailto:dgilbert@redhat.com
