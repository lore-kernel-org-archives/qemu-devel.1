Received: from eggs.gnu.org ([2001:4830:134:3::10]:37195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQ6uW-0000Ip-JD
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQ6uS-00083C-1z
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:01:44 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:40846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fQ6uR-00082S-PU
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:01:39 -0400
Received: by mail-wr0-x244.google.com with SMTP id l41-v6so1291425wre.7
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 01:01:39 -0700 (PDT)
References: <20180528071332.9424.27343.stgit@pasha-VirtualBox>
	<b2f04223-f52d-44e6-95a6-6ed91d021dad@ispras.ru>
	<87in6yd146.fsf@linaro.org> <001201d3fc8d$e8a06390$b9e12ab0$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <001201d3fc8d$e8a06390$b9e12ab0$@ru>
Date: Tue, 05 Jun 2018 09:01:37 +0100
Message-ID: <87h8mhd5lq.fsf@linaro.org>
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
>> Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru> writes:
>>
>> > Ping?
>>
>> I started having a look but I ran into this straight away. First I
>> recorded a boot of the kernel:
>>
>>   ./aarch64-softmmu/qemu-system-aarch64 -machine virt,graphics=3Don,gic-
>> version=3D3,virtualization=3Don -cpu cortex-a53 --serial mon:stdio -disp=
lay none -kernel
>> ../images/aarch64-current-linux-initrd-guest.img -icount shift=3D7,rr=3D=
record,rrfile=3Dreplay.bin
>>
>> Then played back:
>>
>>   ./aarch64-softmmu/qemu-system-aarch64 -machine virt,graphics=3Don,gic-
>> version=3D3,virtualization=3Don -cpu cortex-a53 --serial mon:stdio -disp=
lay none -kernel
>> ../images/aarch64-current-linux-initrd-guest.img -icount shift=3D7,rr=3D=
replay,rrfile=3Dreplay.bin -
>> s -S
>
> This looks ok, but...
>
>> And did the following on gdb:
>>
>> (gdb) i
>> 0x0000000040000004 in ?? ()
>> =3D> 0x40000004:  mov     x1, xzr
>>    0x40000008:  mov     x2, xzr
>>    0x4000000c:  mov     x3, xzr
>> (gdb)
>> 0x0000000040000008 in ?? ()
>> =3D> 0x40000008:  mov     x2, xzr
>>    0x4000000c:  mov     x3, xzr
>>    0x40000010:  ldr     x4, 0x40000020
>> (gdb)
>> 0x000000004000000c in ?? ()
>> =3D> 0x4000000c:  mov     x3, xzr
>>    0x40000010:  ldr     x4, 0x40000020
>>    0x40000014:  br      x4
>> (gdb)
>> 0x0000000040000010 in ?? ()
>> =3D> 0x40000010:  ldr     x4, 0x40000020
>>    0x40000014:  br      x4
>>    0x40000018:  .inst   0x44000000 ; undefined
>> (gdb)
>> 0x0000000040000014 in ?? ()
>> =3D> 0x40000014:  br      x4
>>    0x40000018:  .inst   0x44000000 ; undefined
>>    0x4000001c:  .inst   0x00000000 ; undefined
>> (gdb) p/x $x4
>> $1 =3D 0x40080000
>> (gdb) reverse-stepi
>> warning: Remote failure reply: E14
>>
>> Surely this is the simple case and doesn't require any snapshots for
>> block devices as there are none. Am I missing something?
>
> Reverse debugging requires the snapshotting. QEMU can't revert the VM sta=
te without the snapshots.
> You can try adding an empty qcow2 image to allow snapshotting there.

I got confused with block device snapshots and rr snapshots. Let me try
again ;-)


--
Alex Benn=C3=A9e
