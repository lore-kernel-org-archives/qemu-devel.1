Received: from eggs.gnu.org ([2001:4830:134:3::10]:34268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehBWl-0005H3-BN
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehBWg-00021R-Eh
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:51:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ehBWg-000204-8h
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 04:51:26 -0500
Date: Thu, 1 Feb 2018 09:51:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180201095118.GA2457@work-vm>
References: <CADUDsAo6ku+WT1+DTG6u6CUjdg6xzG6LwBt8RwHK4eR_UWY=Jg@mail.gmail.com>
	<20180131173154.GA2520@work-vm>
	<CADUDsArE1tfNyiHB13a_GoizMn7pEoT2_s8JX7OeDuK_=xcB=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADUDsArE1tfNyiHB13a_GoizMn7pEoT2_s8JX7OeDuK_=xcB=A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] vhost-user question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "jack.chen" <zhunxun@gmail.com>
Cc: qemu <qemu-devel@nongnu.org>, maxime.coquelin@redhat.com

* jack.chen (zhunxun@gmail.com) wrote:
> thanks,but I really can not understand how the fd works,can someone
> explain it or give me some  reference material??

Probably the man page for the mmap system call, or an introduction to
linux/unix syscalls.  Just remember that any shared memory will be
'backed' by a file (or something that works like a file), and if it's a
file, when you open it you get a file descriptor.  Once you have that fd
you can map it somewhere else.

Dave

>=20
> 2018-02-01 1:31 GMT+08:00 Dr. David Alan Gilbert <dgilbert@redhat.com>:
> > * jack.chen (zhunxun@gmail.com) wrote:
> >> hello,I am confused when I read vhost-user source code in qemu.I kno=
w
> >> vhost-user app shared memory with qemu by mmap,but why it can use fd=
 which
> >> is belong to qemu?
> >> relative code:
> >>  qemu code in function vhost_user_set_mem_table
> >> fd =3D memory_region_get_fd(mr);
> >>         if (fd > 0) {
> >>             msg.payload.memory.regions[fd_num].userspace_addr =3D
> >> reg->userspace_addr;
> >>             msg.payload.memory.regions[fd_num].memory_size  =3D
> >> reg->memory_size;
> >>             msg.payload.memory.regions[fd_num].guest_phys_addr =3D
> >> reg->guest_phys_addr;
> >>             msg.payload.memory.regions[fd_num].mmap_offset =3D offse=
t;
> >>             assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
> >>             fds[fd_num++] =3D fd;
> >>         }
> >>
> >> =E2=80=A6=E2=80=A6
> >> DPDK code in vhost_user_set_mem_table
> >>
> >> mmap_addr =3D mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
> >> MAP_SHARED | MAP_POPULATE, fd, 0);
> >> =E2=80=A6=E2=80=A6
> >>
> >> thanks a lot!
> >
> > Because that's how the dpdk/vhost-user binary knows what to mmap;
> > each fd corresponds to the backing file of the memory area that's bei=
ng
> > shared.  This way the dpdk/vhost doesn't need to open those files its=
elf
> > or try and match the exact memory configuration of qemu; QEMU just gi=
ves
> > it the exact thing it needs to mmap - which is just the fd and offset=
s.
> >
> > Dave
> >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
