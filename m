Received: from eggs.gnu.org ([2001:4830:134:3::10]:51247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1fCL3M-0005oQ-UI
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 04:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1fCL3L-0005Wn-EI
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 04:17:56 -0400
Received: from mail-io0-x22e.google.com ([2607:f8b0:4001:c06::22e]:42509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ciro.santilli@gmail.com>)
	id 1fCL3L-0005WM-7S
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 04:17:55 -0400
Received: by mail-io0-x22e.google.com with SMTP id a10-v6so5065453ioc.9
	for <qemu-devel@nongnu.org>; Sat, 28 Apr 2018 01:17:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000401d3dec8$9c02c8d0$d4085a70$@ru>
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
	<CAFXrp_f-r4+G1BOVaCh9a6kzR45rnqgvq5UEnMzNjfHB=BDBCw@mail.gmail.com>
	<00a401d3dd5a$e8a048d0$b9e0da70$@ru>
	<CAFXrp_ddY34M8J+BwaRhPJrzxk=0XaQSBss1WnnZ8fNzAX+BjQ@mail.gmail.com>
	<000401d3dec8$9c02c8d0$d4085a70$@ru>
From: Ciro Santilli <ciro.santilli@gmail.com>
Date: Sat, 28 Apr 2018 09:17:34 +0100
Message-ID: <CAFXrp_cLTKWViVjXHuLnvg3-MFJiAXUFx06NNDqv7v_Hg+viJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 00/17] reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>

On Sat, Apr 28, 2018 at 9:12 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>> From: Ciro Santilli [mailto:ciro.santilli@gmail.com]
>> On Thu, Apr 26, 2018 at 1:34 PM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>> >> From: Ciro Santilli [mailto:ciro.santilli@gmail.com]
>> >> On Wed, Apr 25, 2018 at 1:45 PM, Pavel Dovgalyuk
>> >> <Pavel.Dovgaluk@ispras.ru> wrote:
>> >> > GDB remote protocol supports reverse debugging of the targets.
>> >> > It includes 'reverse step' and 'reverse continue' operations.
>> >> > The first one finds the previous step of the execution,
>> >> > and the second one is intended to stop at the last breakpoint that
>> >> > would happen when the program is executed normally.
>> >> >
>> >> > Reverse debugging is possible in the replay mode, when at least
>> >> > one snapshot was created at the record or replay phase.
>> >> > QEMU can use these snapshots for travelling back in time with GDB.
>> >> >
>> >>
>> >> Hi Pavel,
>> >>
>> >> 1)
>> >>
>> >> Can you provide more details on how to run the reverse debugging? In
>> >> particular how to take the checkpoint?
>> >
>> > There is some information in docs/replay.txt, but I guess, that I can give some more.
>> >
>> >>
>> >> My test setup is described in detail at:
>> >> https://github.com/cirosantilli/qemu-test/tree/8127452e5685ed233dc7357a1fe34b7a2d173480
>> >> command "x86_64/reverse-debug".
>> >>
>> >> Here are the actual commands:
>> >>
>> >> #!/usr/bin/env bash
>> >> set -eu
>> >> dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."
>> >> cmd="\
>> >> time \
>> >> ./x86_64-softmmu/qemu-system-x86_64 \
>> >> -M pc \
>> >> -append 'root=/dev/sda console=ttyS0 nokaslr printk.time=y -
>> >> lkmc_eval=\"/rand_check.out;/sbin/ifup -a;wget -S
>> >> google.com;/poweroff.out;\"' \
>> >> -kernel '${dir}/out/x86_64/buildroot/images/bzImage' \
>> >> -nographic \
>> >> -serial mon:stdio \
>> >> -monitor telnet::45454,server,nowait \
>> >> \
>> >> -drive file='${dir}/out/x86_64/buildroot/images/rootfs.ext2.qcow2,if=none,id=img-
>> >> direct,format=qcow2,snapshot'
>> >
>> > The main thing for reverse debugging is snapshotting.
>> > Therefore you should have an image that does not use temporary overlay file (snapshot
>> option).
>> > I'm using the following command line for record:
>> >
>> > rm ./images/xp.ovl
>> > # create overlay to avoid modifying the original image
>> > ./bin/qemu-img create -f qcow2 -b xp.qcow2 ./images/xp.ovl
>> > ./bin/qemu-system-i386 \
>> > # This is workaround for XP. I wonder is it needed for the current version or not.
>> >  -global apic-common.vapic=off \
>> > # using newly created overlay instead of the original image
>> > # rrsnapshot creates the snapshot at the start
>> >  -icount shift=7,rr=record,rrfile=xp.replay,rrsnapshot=init -drive
>> file=./images/xp.ovl,if=none,id=img-direct \
>> >  -drive driver=blkreplay,if=none,image=img-direct,id=img-replay -device ide-hd,drive=img-
>> replay -net none -m 256M -monitor stdio
>> >
>> > While recording I can create some snapshots with savevm.
>> > Command line for replaying differs only in "rr" option. rrsnapshot there loads the initial
>> snapshot.
>> > Any of the previously created snapshots may be specified.
>> > You can also create new snapshots while replaying.
>> >
>>
>> How is the snapshot to be used chosen? Does this patch make it try to
>> smartly use the snapshot that is closest to the target break?
>
> Yes, it selects the closest snapshot.
>
>> Does rrsnapshot select which snapshot will be used, or just creates a
>> snapshot at the start or record?
>
> rrsnapshot creates a snapshot at record and loads it at start.
> It is required, because the disk image is modified by the execution,
> when 'snapshot' option is omitted.
>
>> I have modified my commands to remove snapshot from -drive, and add
>> rrsnapshot=init to -icount and the following works:
>>
>> b start_kernel
>> n
>> n
>> n
>> b
>> n
>> n
>> rc
>
> Great!
>
>> However, if after the "b start_kernel" I make a new snapshot on telnet
>> with "savevm a" to try and make the restore faster, then
>> reverse-continue fails.
>
> That's strange. What did it say?
>

Nothing, it just stayed on the same line.

>> Also, if I do "loadvm a" after "savevm a" while the debugger is
>> attached at start_kernel, the monitor just hangs. Is there a way to
>> restore snapshots while debugging of replay is going on?
>
> Never tried to do this.
> I'll check this out.
>
>
> Pavel Dovgalyuk
>
