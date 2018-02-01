Received: from eggs.gnu.org ([2001:4830:134:3::10]:42663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhunxun@gmail.com>) id 1ehBvp-00058u-Nw
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhunxun@gmail.com>) id 1ehBvj-0006gD-NP
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:17:25 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:42717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhunxun@gmail.com>) id 1ehBvj-0006fc-I6
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:17:19 -0500
Received: by mail-ot0-x244.google.com with SMTP id a7so13497047otk.9
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 02:17:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180201095118.GA2457@work-vm>
References: <CADUDsAo6ku+WT1+DTG6u6CUjdg6xzG6LwBt8RwHK4eR_UWY=Jg@mail.gmail.com>
	<20180131173154.GA2520@work-vm>
	<CADUDsArE1tfNyiHB13a_GoizMn7pEoT2_s8JX7OeDuK_=xcB=A@mail.gmail.com>
	<20180201095118.GA2457@work-vm>
From: "jack.chen" <zhunxun@gmail.com>
Date: Thu, 1 Feb 2018 18:17:18 +0800
Message-ID: <CADUDsApj9ScOSNq0PJfH7XdFxbZau_=yuBbBNFc9vaEQrr3B3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu <qemu-devel@nongnu.org>, maxime.coquelin@redhat.com

Thanks,But my question is how the fd belonging to qemu can be used in
another process such as DPDK=EF=BC=9Fis fd just effective within one proces=
s?
for example ,if process A open file a.txt,and it gets one fd=E3=80=82the fd
can only be used in process A ,can it be used in process B?

2018-02-01 17:51 GMT+08:00 Dr. David Alan Gilbert <dgilbert@redhat.com>:
> * jack.chen (zhunxun@gmail.com) wrote:
>> thanks,but I really can not understand how the fd works,can someone
>> explain it or give me some  reference material??
>
> Probably the man page for the mmap system call, or an introduction to
> linux/unix syscalls.  Just remember that any shared memory will be
> 'backed' by a file (or something that works like a file), and if it's a
> file, when you open it you get a file descriptor.  Once you have that fd
> you can map it somewhere else.
>
> Dave
>
>>
>> 2018-02-01 1:31 GMT+08:00 Dr. David Alan Gilbert <dgilbert@redhat.com>:
>> > * jack.chen (zhunxun@gmail.com) wrote:
>> >> hello,I am confused when I read vhost-user source code in qemu.I know
>> >> vhost-user app shared memory with qemu by mmap,but why it can use fd =
which
>> >> is belong to qemu?
>> >> relative code:
>> >>  qemu code in function vhost_user_set_mem_table
>> >> fd =3D memory_region_get_fd(mr);
>> >>         if (fd > 0) {
>> >>             msg.payload.memory.regions[fd_num].userspace_addr =3D
>> >> reg->userspace_addr;
>> >>             msg.payload.memory.regions[fd_num].memory_size  =3D
>> >> reg->memory_size;
>> >>             msg.payload.memory.regions[fd_num].guest_phys_addr =3D
>> >> reg->guest_phys_addr;
>> >>             msg.payload.memory.regions[fd_num].mmap_offset =3D offset=
;
>> >>             assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
>> >>             fds[fd_num++] =3D fd;
>> >>         }
>> >>
>> >> =E2=80=A6=E2=80=A6
>> >> DPDK code in vhost_user_set_mem_table
>> >>
>> >> mmap_addr =3D mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
>> >> MAP_SHARED | MAP_POPULATE, fd, 0);
>> >> =E2=80=A6=E2=80=A6
>> >>
>> >> thanks a lot!
>> >
>> > Because that's how the dpdk/vhost-user binary knows what to mmap;
>> > each fd corresponds to the backing file of the memory area that's bein=
g
>> > shared.  This way the dpdk/vhost doesn't need to open those files itse=
lf
>> > or try and match the exact memory configuration of qemu; QEMU just giv=
es
>> > it the exact thing it needs to mmap - which is just the fd and offsets=
.
>> >
>> > Dave
>> >
>> > --
>> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
