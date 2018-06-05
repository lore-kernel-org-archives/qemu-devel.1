Received: from eggs.gnu.org ([2001:4830:134:3::10]:50805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQDNQ-0006kl-3o
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQDNN-00054q-0l
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:56:00 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fQDNM-000529-FD
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:55:56 -0400
Received: by mail-wr0-x22a.google.com with SMTP id a12-v6so2789162wro.1
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 07:55:56 -0700 (PDT)
References: <20180528071332.9424.27343.stgit@pasha-VirtualBox>
	<b2f04223-f52d-44e6-95a6-6ed91d021dad@ispras.ru>
	<87in6yd146.fsf@linaro.org> <001201d3fc8d$e8a06390$b9e12ab0$@ru>
	<87fu21d3gh.fsf@linaro.org> <001c01d3fcae$f0443fb0$d0ccbf10$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <001c01d3fcae$f0443fb0$d0ccbf10$@ru>
Date: Tue, 05 Jun 2018 15:55:53 +0100
Message-ID: <87bmcpcmfa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/19] reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

>> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>>
>> >> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>> >> Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru> writes:
>> >>
>> >> > Ping?
>> >>
>> >> I started having a look but I ran into this straight away. First I
>> >> recorded a boot of the kernel:
>> >>
>> >>   ./aarch64-softmmu/qemu-system-aarch64 -machine virt,graphics=3Don,g=
ic-
>> >> version=3D3,virtualization=3Don -cpu cortex-a53 --serial mon:stdio -d=
isplay none -kernel
>> >> ../images/aarch64-current-linux-initrd-guest.img -icount
>> shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin
>> >>
>> >> Then played back:
>> >>
>> >>   ./aarch64-softmmu/qemu-system-aarch64 -machine virt,graphics=3Don,g=
ic-
>> >> version=3D3,virtualization=3Don -cpu cortex-a53 --serial mon:stdio -d=
isplay none -kernel
>> >> ../images/aarch64-current-linux-initrd-guest.img -icount
>> shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin -
>> >> s -S
>> >
>> > This looks ok, but...
>> >
>> >> And did the following on gdb:
>> >>
>> >> (gdb) i
>> >> 0x0000000040000004 in ?? ()
>> >> =3D> 0x40000004:  mov     x1, xzr
>> >>    0x40000008:  mov     x2, xzr
>> >>    0x4000000c:  mov     x3, xzr
>> >> (gdb)
>> >> 0x0000000040000008 in ?? ()
>> >> =3D> 0x40000008:  mov     x2, xzr
>> >>    0x4000000c:  mov     x3, xzr
>> >>    0x40000010:  ldr     x4, 0x40000020
>> >> (gdb)
>> >> 0x000000004000000c in ?? ()
>> >> =3D> 0x4000000c:  mov     x3, xzr
>> >>    0x40000010:  ldr     x4, 0x40000020
>> >>    0x40000014:  br      x4
>> >> (gdb)
>> >> 0x0000000040000010 in ?? ()
>> >> =3D> 0x40000010:  ldr     x4, 0x40000020
>> >>    0x40000014:  br      x4
>> >>    0x40000018:  .inst   0x44000000 ; undefined
>> >> (gdb)
>> >> 0x0000000040000014 in ?? ()
>> >> =3D> 0x40000014:  br      x4
>> >>    0x40000018:  .inst   0x44000000 ; undefined
>> >>    0x4000001c:  .inst   0x00000000 ; undefined
>> >> (gdb) p/x $x4
>> >> $1 =3D 0x40080000
>> >> (gdb) reverse-stepi
>> >> warning: Remote failure reply: E14
>> >>
>> >> Surely this is the simple case and doesn't require any snapshots for
>> >> block devices as there are none. Am I missing something?
>> >
>> > Reverse debugging requires the snapshotting. QEMU can't revert the VM =
state without the
>> snapshots.
>> > You can try adding an empty qcow2 image to allow snapshotting there.
>>
>> I suspect a recent patch has broken locking again:
>>
>> Starting program: /home/alex/lsrc/qemu/qemu.git/aarch64-softmmu/qemu-sys=
tem-aarch64 -machine
>> virt,graphics=3Don,gic-version=3D3,virtualization=3Don -cpu cortex-a53 -=
-serial mon:stdio -display
>> none -kernel ../images/aarch64-current-linux-initrd-guest.img -icount
>> shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin,rrsnapshot=3Ddebug -drive
>> file=3Drr.qcow2,if=3Dnone,snapshot,id=3Drr -s -S
>> [Thread debugging using libthread_db enabled]
>> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1=
".
>> [New Thread 0x7fffd8536700 (LWP 32452)]
>> [New Thread 0x7fffd5bb3700 (LWP 32453)]
>> [New Thread 0x7fffd4eab700 (LWP 32454)]
>> **
>> ERROR:replay/replay-time.c:49:replay_read_clock: assertion failed: (repl=
ay_file &&
>> replay_mutex_locked())
>
> Have you recorded it with the attached disk before replaying?

Yes. I assume the -drive doesn't actually have to be visible to the
guest, it's just the mechanism rr needs for saving snapshots?

> Are you using the latest version?
> If the both answers are 'yes', then can you share the kernel? My i386
> runs work normally.

I'll have a go with x86 first as aarch64 hasn't been proven yet.

>
>> Once I have the linux-user TCG tests merged I'm planning on focusing on
>> the system emulation tests and we should be able to add some
>> record/replay tests to defend the behaviour.
>
> That will be great.
> There are some Ciro's attempts on that: https://github.com/cirosantilli/q=
emu-test/blob/master/arm/rr
>
> Pavel Dovgalyuk


--
Alex Benn=C3=A9e
