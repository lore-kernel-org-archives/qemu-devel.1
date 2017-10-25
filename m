Received: from eggs.gnu.org ([2001:4830:134:3::10]:41306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1e7KiK-0005zx-Ip
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1e7KiD-0002bx-75
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:23:16 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:45019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <batmanustc@gmail.com>)
	id 1e7KiC-0002b7-Vl
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:23:09 -0400
Received: by mail-qt0-x22a.google.com with SMTP id 8so34478851qtv.1
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 05:23:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171025120619.GA2484@work-vm>
References: <CAOE=1Z2jr8qrXnHe1nRVCTvuAQbVyJSoUbM=1aWbhw2m2pPmSw@mail.gmail.com>
	<20171025104438.GA3107@work-vm>
	<CAOE=1Z1VW9Ca+n8xcovqDs+EaS0GnCx2TF1ZHqt7zcKRv8pc0g@mail.gmail.com>
	<20171025120619.GA2484@work-vm>
From: Sam <batmanustc@gmail.com>
Date: Wed, 25 Oct 2017 20:23:07 +0800
Message-ID: <CAOE=1Z1-sYVzqbfxoDdhn3wB2WB5uc8bED-27-2TwXBkdNYOXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Why qemu log start late and qemu start guest so
 long while using '-mem-prealloc' option?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Waiting time is different in different server, and different with memory
and cpu usage in one server.

For HP PowerEdge R720 with 15+ VM running, it's 10+ second.

But If I remove '-mem-prealloc', it's 1 second.

2017-10-25 20:06 GMT+08:00 Dr. David Alan Gilbert <dgilbert@redhat.com>:

> * Sam (batmanustc@gmail.com) wrote:
> > So if I remove '-mem-prealloc' option, the qemu will not mmap while
> > starting guest vm? Or will mmap after some thing? Or will mmap when admin
> > to trigger it by qemu command?
>
> It will mmap, but the kernel won't have allocated all of the memory, it
> will get allocated as it is used; so instead of one long wait for 40GB
> you'll get some tiny pauses as it needs to find another 2MB page.
>
> How much longer is it taking with -mem-prealloc?
>
> Dave
>
> > 2017-10-25 18:44 GMT+08:00 Dr. David Alan Gilbert <dgilbert@redhat.com>:
> >
> > > * Sam (batmanustc@gmail.com) wrote:
> > > > Hi all,
> > > >
> > > > I'm using qemu to start vm in huge page enviroment, I use CMD1 and
> CMD2
> > > to
> > > > test the time of start of a vm, CMD1 contains option '-mem-prealloc',
> > > CMD2
> > > > does not contain this.
> > > >
> > > > I found while using CMD1, the time to run this command is longer then
> > > CMD2.
> > > > For words, I know this option is to wait memory ready, but for code,
> I
> > > > don't know where is the different with CMD1 and CMD2.
> > > >
> > > > As I print log of CMD1 and CMD2, I found for CMD1, there are about 10
> > > > second to print first log. I don't know for '-mem-prealloc' option,
> what
> > > > qemu wait for? thank you~
> > >
> > > It's waiting for the kernel to allocate that 40GB of RAM that you asked
> > > for, and as huge pages.
> > >
> > > If you strace  it you'll probably see it sitting in an madvise or mmap
> > > for all the extra time.
> > >
> > > Dave
> > >
> > > >
> > > > detail of test:
> > > >
> > > > CMD1="$QEMU_CMD -D qemu.log -trace events=qemu-events-all -enable-kvm
> > > -cpu
> > > > qemu64,+vmx,+ssse3,+sse4.1,+sse4.2,+x2apic,+aes,+avx,+vme,
> > > +pat,+ss,+pclmulqdq,+xsave,level=13
> > > > -machine pc,accel=kvm -chardev
> > > > socket,id=hmqmondev,port=55908,host=127.0.0.1,nodelay,server,nowait
> -mon
> > > > chardev=hmqmondev,id=hmqmon,mode=readline -rtc
> > > > base=utc,clock=host,driftfix=none -usb -device usb-tablet -daemonize
> > > > -nodefaults -nodefconfig -no-kvm-pit-reinjection -global
> > > > kvm-pit.lost_tick_policy=discard -vga std -k en-us -smp 8 -name
> > > > gangyewei-qemutime-1 -m 40960 -boot order=cdn -vnc :8,password -drive
> > > > file=$DISK_0,if=none,id=drive_0,format=qcow2,cache=none,aio=native
> > > -device
> > > > virtio-blk-pci,id=dev_drive_0,drive=drive_0,bus=pci.0,addr=0x5
> -drive
> > > > file=$DISK_1,if=none,id=drive_1,format=qcow2,cache=none,aio=native
> > > -device
> > > > virtio-blk-pci,id=dev_drive_1,drive=drive_1,bus=pci.0,addr=0x6
> -drive
> > > > file=$DISK_2,if=none,id=drive_2,format=qcow2,cache=none,aio=native
> > > -device
> > > > virtio-blk-pci,id=dev_drive_2,drive=drive_2,bus=pci.0,addr=0x7
> -device
> > > > ide-cd,drive=ide0-cd0,bus=ide.1,unit=1 -drive
> > > > id=ide0-cd0,media=cdrom,if=none -chardev
> > > > socket,id=char-n-52b49b80,path=/usr/local/var/run/
> > > openvswitch/n-52b49b80,server
> > > > -netdev type=vhost-user,id=n-52b49b80,chardev=char-n-52b49b80,
> > > vhostforce=on
> > > > -device
> > > > virtio-net-pci,netdev=n-52b49b80,mac=00:22:52:b4:9b:
> > > 80,id=netdev-n-52b49b80,addr=0xf$(nic_speed
> > > > 10000) -object
> > > > memory-backend-file,id=mem,size=40960M,mem-path=/mnt/huge,share=on
> -numa
> > > > node,memdev=mem -pidfile $PID_FILE -chardev
> > > > socket,path=/opt/cloud/workspace/servers/4511f52a-
> > > f450-40d3-9417-a1e0a27ed507/qga.sock,server,nowait,id=qga0
> > > > -device virtio-serial -device
> > > > virtserialport,chardev=qga0,name=org.qemu.guest_agent.0"
> > > >
> > > > CMD2="$QEMU_CMD -D qemu.log -trace events=qemu-events-all -enable-kvm
> > > -cpu
> > > > qemu64,+vmx,+ssse3,+sse4.1,+sse4.2,+x2apic,+aes,+avx,+vme,
> > > +pat,+ss,+pclmulqdq,+xsave,level=13
> > > > -machine pc,accel=kvm -chardev
> > > > socket,id=hmqmondev,port=55908,host=127.0.0.1,nodelay,server,nowait
> -mon
> > > > chardev=hmqmondev,id=hmqmon,mode=readline -rtc
> > > > base=utc,clock=host,driftfix=none -usb -device usb-tablet -daemonize
> > > > -nodefaults -nodefconfig -no-kvm-pit-reinjection -global
> > > > kvm-pit.lost_tick_policy=discard -vga std -k en-us -smp 8 -name
> > > > gangyewei-qemutime-1 -m 40960 -boot order=cdn -vnc :8,password -drive
> > > > file=$DISK_0,if=none,id=drive_0,format=qcow2,cache=none,aio=native
> > > -device
> > > > virtio-blk-pci,id=dev_drive_0,drive=drive_0,bus=pci.0,addr=0x5
> -drive
> > > > file=$DISK_1,if=none,id=drive_1,format=qcow2,cache=none,aio=native
> > > -device
> > > > virtio-blk-pci,id=dev_drive_1,drive=drive_1,bus=pci.0,addr=0x6
> -drive
> > > > file=$DISK_2,if=none,id=drive_2,format=qcow2,cache=none,aio=native
> > > -device
> > > > virtio-blk-pci,id=dev_drive_2,drive=drive_2,bus=pci.0,addr=0x7
> -device
> > > > ide-cd,drive=ide0-cd0,bus=ide.1,unit=1 -drive
> > > > id=ide0-cd0,media=cdrom,if=none -chardev
> > > > socket,id=char-n-52b49b80,path=/usr/local/var/run/
> > > openvswitch/n-52b49b80,server
> > > > -netdev type=vhost-user,id=n-52b49b80,chardev=char-n-52b49b80,
> > > vhostforce=on
> > > > -device
> > > > virtio-net-pci,netdev=n-52b49b80,mac=00:22:52:b4:9b:
> > > 80,id=netdev-n-52b49b80,addr=0xf$(nic_speed
> > > > 10000) -object
> > > > memory-backend-file,id=mem,size=40960M,mem-path=/mnt/huge,share=on
> -numa
> > > > node,memdev=mem -mem-prealloc -pidfile $PID_FILE -chardev
> > > > socket,path=/opt/cloud/workspace/servers/4511f52a-
> > > f450-40d3-9417-a1e0a27ed507/qga.sock,server,nowait,id=qga0
> > > > -device virtio-serial -device
> > > > virtserialport,chardev=qga0,name=org.qemu.guest_agent.0"
> > > >
> > > >
> > > > time to run CMD1:
> > > > [root@yf-mos-test-net14 4511f52a-f450-40d3-9417-a1e0a27ed507]# sh
> > > startvm
> > > > ls: cannot access
> > > > /opt/cloud/workspace/servers/4511f52a-f450-40d3-9417-
> > > a1e0a27ed507/STATEFILE*:
> > > > No such file or directory
> > > > Wed Oct 25 16:52:51 CST 2017  (unix time is 1508921571)
> > > > qemu-system-x86_64_2.6.0:qemu-events-all:1045: WARNING: trace event
> > > > 'qxl_interface_set_mm_time' is not traceable
> > > > qemu-system-x86_64_2.6.0:qemu-events-all:1046: WARNING: trace event
> > > > 'qxl_io_write_vga' is not traceable
> > > > qemu-system-x86_64_2.6.0:qemu-events-all:1318: WARNING: trace event
> > > > 'exec_tb' is not traceable
> > > > qemu-system-x86_64_2.6.0:qemu-events-all:1319: WARNING: trace event
> > > > 'exec_tb_nocache' is not traceable
> > > > qemu-system-x86_64_2.6.0:qemu-events-all:1320: WARNING: trace event
> > > > 'exec_tb_exit' is not traceable
> > > > qemu-system-x86_64_2.6.0: -no-kvm-pit-reinjection: warning:
> deprecated,
> > > > replaced by -global kvm-pit.lost_tick_policy=discard
> > > > Wed Oct 25 16:53:02 CST 2017  (unix time is 1508921582)
> > > > qemu started
> > > >
> > > > first log of CMD1:
> > > > 45704@1508921581.767831:qio_channel_socket_new Socket new
> > > ioc=0x55555640efd0
> > > > I don't know why first log happends in 1508921581, not the start up
> time,
> > > > which is 1508921571.
> > > >
> > > >
> > > > time to run CMD2:
> > > > [root@yf-mos-test-net14 4511f52a-f450-40d3-9417-a1e0a27ed507]# sh
> > > startvm
> > > > ls: cannot access
> > > > /opt/cloud/workspace/servers/4511f52a-f450-40d3-9417-
> > > a1e0a27ed507/STATEFILE*:
> > > > No such file or directory
> > > > Wed Oct 25 18:15:35 CST 2017
> > > > qemu-system-x86_64_2.6.0:qemu-events-all:1045: WARNING: trace event
> > > > 'qxl_interface_set_mm_time' is not traceable
> > > > qemu-system-x86_64_2.6.0:qemu-events-all:1046: WARNING: trace event
> > > > 'qxl_io_write_vga' is not traceable
> > > > qemu-system-x86_64_2.6.0:qemu-events-all:1318: WARNING: trace event
> > > > 'exec_tb' is not traceable
> > > > qemu-system-x86_64_2.6.0:qemu-events-all:1319: WARNING: trace event
> > > > 'exec_tb_nocache' is not traceable
> > > > qemu-system-x86_64_2.6.0:qemu-events-all:1320: WARNING: trace event
> > > > 'exec_tb_exit' is not traceable
> > > > qemu-system-x86_64_2.6.0: -no-kvm-pit-reinjection: warning:
> deprecated,
> > > > replaced by -global kvm-pit.lost_tick_policy=discard
> > > > Wed Oct 25 18:15:36 CST 2017
> > > > qemu started
> > > >
> > > > first log of CMD1:
> > > > 45167@1508926535.502360:qio_channel_socket_new Socket new
> > > ioc=0x55555640efd0
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
