Received: from eggs.gnu.org ([2001:4830:134:3::10]:49578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhunxun@gmail.com>) id 1eh4E4-00073R-QX
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:03:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhunxun@gmail.com>) id 1eh4E3-0006YM-VQ
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:03:44 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhunxun@gmail.com>) id 1eh4E3-0006YF-Po
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:03:43 -0500
Received: by mail-oi0-x243.google.com with SMTP id 8so960764oix.7
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 18:03:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180131173154.GA2520@work-vm>
References: <CADUDsAo6ku+WT1+DTG6u6CUjdg6xzG6LwBt8RwHK4eR_UWY=Jg@mail.gmail.com>
	<20180131173154.GA2520@work-vm>
From: "jack.chen" <zhunxun@gmail.com>
Date: Thu, 1 Feb 2018 10:03:42 +0800
Message-ID: <CADUDsArE1tfNyiHB13a_GoizMn7pEoT2_s8JX7OeDuK_=xcB=A@mail.gmail.com>
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

thanks,but I really can not understand how the fd works,can someone
explain it or give me some  reference material??


2018-02-01 1:31 GMT+08:00 Dr. David Alan Gilbert <dgilbert@redhat.com>:
> * jack.chen (zhunxun@gmail.com) wrote:
>> hello,I am confused when I read vhost-user source code in qemu.I know
>> vhost-user app shared memory with qemu by mmap,but why it can use fd whi=
ch
>> is belong to qemu?
>> relative code:
>>  qemu code in function vhost_user_set_mem_table
>> fd =3D memory_region_get_fd(mr);
>>         if (fd > 0) {
>>             msg.payload.memory.regions[fd_num].userspace_addr =3D
>> reg->userspace_addr;
>>             msg.payload.memory.regions[fd_num].memory_size  =3D
>> reg->memory_size;
>>             msg.payload.memory.regions[fd_num].guest_phys_addr =3D
>> reg->guest_phys_addr;
>>             msg.payload.memory.regions[fd_num].mmap_offset =3D offset;
>>             assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
>>             fds[fd_num++] =3D fd;
>>         }
>>
>> =E2=80=A6=E2=80=A6
>> DPDK code in vhost_user_set_mem_table
>>
>> mmap_addr =3D mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
>> MAP_SHARED | MAP_POPULATE, fd, 0);
>> =E2=80=A6=E2=80=A6
>>
>> thanks a lot!
>
> Because that's how the dpdk/vhost-user binary knows what to mmap;
> each fd corresponds to the backing file of the memory area that's being
> shared.  This way the dpdk/vhost doesn't need to open those files itself
> or try and match the exact memory configuration of qemu; QEMU just gives
> it the exact thing it needs to mmap - which is just the fd and offsets.
>
> Dave
>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
