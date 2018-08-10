Received: from eggs.gnu.org ([2001:4830:134:3::10]:33476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1fo9YF-0000hu-2w
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1fo9YD-0005g5-1L
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:42:07 -0400
Received: from mail-it0-x236.google.com ([2607:f8b0:4001:c0b::236]:38194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ciro.santilli@gmail.com>)
	id 1fo9YC-0005fW-Of
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:42:04 -0400
Received: by mail-it0-x236.google.com with SMTP id v71-v6so3212922itb.3
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 08:42:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <00a401d3dd5a$e8a048d0$b9e0da70$@ru>
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
	<CAFXrp_f-r4+G1BOVaCh9a6kzR45rnqgvq5UEnMzNjfHB=BDBCw@mail.gmail.com>
	<00a401d3dd5a$e8a048d0$b9e0da70$@ru>
From: Ciro Santilli <ciro.santilli@gmail.com>
Date: Fri, 10 Aug 2018 16:41:43 +0100
Message-ID: <CAFXrp_c4gHpHzfTnBzuoNaEmX8K6QHqW2kOAVUU=GEXG0c_B4g@mail.gmail.com>
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

On Thu, Apr 26, 2018 at 1:34 PM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:

> > From: Ciro Santilli [mailto:ciro.santilli@gmail.com]
> > On Wed, Apr 25, 2018 at 1:45 PM, Pavel Dovgalyuk
> > <Pavel.Dovgaluk@ispras.ru> wrote:
> > > GDB remote protocol supports reverse debugging of the targets.
> > > It includes 'reverse step' and 'reverse continue' operations.
> > > The first one finds the previous step of the execution,
> > > and the second one is intended to stop at the last breakpoint that
> > > would happen when the program is executed normally.
> > >
> > > Reverse debugging is possible in the replay mode, when at least
> > > one snapshot was created at the record or replay phase.
> > > QEMU can use these snapshots for travelling back in time with GDB.
> > >
> >
> > Hi Pavel,
> >
> > 1)
> >
> > Can you provide more details on how to run the reverse debugging? In
> > particular how to take the checkpoint?
>
> There is some information in docs/replay.txt, but I guess, that I can give
> some more.
>
> >
> > My test setup is described in detail at:
> > https://github.com/cirosantilli/qemu-test/tree/8127452e5685e
> d233dc7357a1fe34b7a2d173480
> > command "x86_64/reverse-debug".
> >
> > Here are the actual commands:
> >
> > #!/usr/bin/env bash
> > set -eu
> > dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."
> > cmd="\
> > time \
> > ./x86_64-softmmu/qemu-system-x86_64 \
> > -M pc \
> > -append 'root=/dev/sda console=ttyS0 nokaslr printk.time=y -
> > lkmc_eval=\"/rand_check.out;/sbin/ifup -a;wget -S
> > google.com;/poweroff.out;\"' \
> > -kernel '${dir}/out/x86_64/buildroot/images/bzImage' \
> > -nographic \
> > -serial mon:stdio \
> > -monitor telnet::45454,server,nowait \
> > \
> > -drive file='${dir}/out/x86_64/buildroot/images/rootfs.ext2.qcow2,
> if=none,id=img-
> > direct,format=qcow2,snapshot'
>
> The main thing for reverse debugging is snapshotting.
> Therefore you should have an image that does not use temporary overlay
> file (snapshot option).
> I'm using the following command line for record:
>
> rm ./images/xp.ovl
> # create overlay to avoid modifying the original image
> ./bin/qemu-img create -f qcow2 -b xp.qcow2 ./images/xp.ovl
> ./bin/qemu-system-i386 \
> # This is workaround for XP. I wonder is it needed for the current version
> or not.
>  -global apic-common.vapic=off \
> # using newly created overlay instead of the original image
> # rrsnapshot creates the snapshot at the start
>  -icount shift=7,rr=record,rrfile=xp.replay,rrsnapshot=init -drive
> file=./images/xp.ovl,if=none,id=img-direct \
>  -drive driver=blkreplay,if=none,image=img-direct,id=img-replay -device
> ide-hd,drive=img-replay -net none -m 256M -monitor stdio
>
> While recording I can create some snapshots with savevm.
> Command line for replaying differs only in "rr" option. rrsnapshot there
> loads the initial snapshot.
> Any of the previously created snapshots may be specified.
> You can also create new snapshots while replaying.
>
>
> > \
> > -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay \
> > -device ide-hd,drive=img-blkreplay \
> > \
> > -netdev user,id=net1 \
> > -device rtl8139,netdev=net1 \
> > -object filter-replay,id=replay,netdev=net1 \
> > "
> > cmd="${cmd} $@"
> > echo "$cmd"
> > eval "$cmd -icount 'shift=7,rr=record,rrfile=replay.bin'"
> > eval "$cmd -icount 'shift=7,rr=replay,rrfile=replay.bin' -S -s"
> >
> > Then I take a snapshot right at the beginning of the execution:
> >
> > telnet 45454
> > savevm a
> >
> > And on another shell:
> >
> > /data/git/linux-kernel-module-cheat/out/x86_64/buildroot/hos
> t/usr/bin/x86_64-linux-gdb
> > \
> > -q \
> > -ex 'file vmlinux' \
> > -ex 'target remote localhost:1234' \
> > -ex 'break start_kernel' \
> > -ex 'continue' \
> >
> > But now if I try on GDB:
> >
> > next
> > next
> > next
> > reverse-continue
> >
> > hoping to go back to start_kernel, but nothing happens.
>
> Yes, because you are missing your snapshot, that was actually created in
> the temporary overlay.
>
> > Same behavior if I take the snapshot after reaching start_kernel instead.
> >
> > 2)
> >
> > I wonder if it would be possible to expose checkpoint taking through
> > GDB example via:
> > https://sourceware.org/gdb/onlinedocs/gdb/Checkpoint_002fRestart.html
>
> We'll check this out.
>

Actually, this is not needed, I have learnt now that you can send QEMU
monitor commands with `monitor <qemu-monitor-command>`, so e.g. `monitor
savevm a`.


>
> > Or some other more convenient checkpoint generation method, e.g.
> > automatically take checkpoints every N instructions.
>
> We implemented 'taking snapshots every N seconds', but I'll prefer to
> submit
> it later, after approving the main idea.
>
> > > Running the execution in replay mode allows using GDB reverse debugging
> > > commands:
> > >  - reverse-stepi (or rsi): Steps one instruction to the past.
> > >    QEMU loads on of the prior snapshots and proceeds to the desired
> > >    instruction forward. When that step is reaches, execution stops.
> > >  - reverse-continue (or rc): Runs execution "backwards".
> > >    QEMU tries to find breakpoint or watchpoint by loaded prior snapshot
> > >    and replaying the execution. Then QEMU loads snapshots again and
> > >    replays to the latest breakpoint. When there are no breakpoints in
> > >    the examined section of the execution, QEMU finds one more snapshot
> > >    and tries again. After the first snapshot is processed, execution
> > >    stops at this snapshot.
> > >
> > > The set of patches include the following modifications:
> > >  - gdbstub update for reverse debugging support
> > >  - functions that automatically perform reverse step and reverse
> > >    continue operations
> > >  - hmp/qmp commands for manipulating the replay process
> > >  - improvement of the snapshotting for saving the execution step
> > >    in the snapshot parameters
> > >  - other record/replay fixes
> > >
> > > The patches are available in the repository:
> > > https://github.com/ispras/qemu/tree/rr-180207
>
> Pavel Dovgalyuk
>
>
