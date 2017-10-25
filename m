Received: from eggs.gnu.org ([2001:4830:134:3::10]:45971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e7JB2-00026Q-SQ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 06:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e7JAz-0005wQ-KW
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 06:44:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e7JAz-0005rw-Ba
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 06:44:45 -0400
Date: Wed, 25 Oct 2017 11:44:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171025104438.GA3107@work-vm>
References: <CAOE=1Z2jr8qrXnHe1nRVCTvuAQbVyJSoUbM=1aWbhw2m2pPmSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOE=1Z2jr8qrXnHe1nRVCTvuAQbVyJSoUbM=1aWbhw2m2pPmSw@mail.gmail.com>
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
To: Sam <batmanustc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

* Sam (batmanustc@gmail.com) wrote:
> Hi all,
> 
> I'm using qemu to start vm in huge page enviroment, I use CMD1 and CMD2 to
> test the time of start of a vm, CMD1 contains option '-mem-prealloc', CMD2
> does not contain this.
> 
> I found while using CMD1, the time to run this command is longer then CMD2.
> For words, I know this option is to wait memory ready, but for code, I
> don't know where is the different with CMD1 and CMD2.
> 
> As I print log of CMD1 and CMD2, I found for CMD1, there are about 10
> second to print first log. I don't know for '-mem-prealloc' option, what
> qemu wait for? thank you~

It's waiting for the kernel to allocate that 40GB of RAM that you asked
for, and as huge pages.

If you strace  it you'll probably see it sitting in an madvise or mmap
for all the extra time.

Dave

> 
> detail of test:
> 
> CMD1="$QEMU_CMD -D qemu.log -trace events=qemu-events-all -enable-kvm -cpu
> qemu64,+vmx,+ssse3,+sse4.1,+sse4.2,+x2apic,+aes,+avx,+vme,+pat,+ss,+pclmulqdq,+xsave,level=13
> -machine pc,accel=kvm -chardev
> socket,id=hmqmondev,port=55908,host=127.0.0.1,nodelay,server,nowait -mon
> chardev=hmqmondev,id=hmqmon,mode=readline -rtc
> base=utc,clock=host,driftfix=none -usb -device usb-tablet -daemonize
> -nodefaults -nodefconfig -no-kvm-pit-reinjection -global
> kvm-pit.lost_tick_policy=discard -vga std -k en-us -smp 8 -name
> gangyewei-qemutime-1 -m 40960 -boot order=cdn -vnc :8,password -drive
> file=$DISK_0,if=none,id=drive_0,format=qcow2,cache=none,aio=native -device
> virtio-blk-pci,id=dev_drive_0,drive=drive_0,bus=pci.0,addr=0x5 -drive
> file=$DISK_1,if=none,id=drive_1,format=qcow2,cache=none,aio=native -device
> virtio-blk-pci,id=dev_drive_1,drive=drive_1,bus=pci.0,addr=0x6 -drive
> file=$DISK_2,if=none,id=drive_2,format=qcow2,cache=none,aio=native -device
> virtio-blk-pci,id=dev_drive_2,drive=drive_2,bus=pci.0,addr=0x7 -device
> ide-cd,drive=ide0-cd0,bus=ide.1,unit=1 -drive
> id=ide0-cd0,media=cdrom,if=none -chardev
> socket,id=char-n-52b49b80,path=/usr/local/var/run/openvswitch/n-52b49b80,server
> -netdev type=vhost-user,id=n-52b49b80,chardev=char-n-52b49b80,vhostforce=on
> -device
> virtio-net-pci,netdev=n-52b49b80,mac=00:22:52:b4:9b:80,id=netdev-n-52b49b80,addr=0xf$(nic_speed
> 10000) -object
> memory-backend-file,id=mem,size=40960M,mem-path=/mnt/huge,share=on -numa
> node,memdev=mem -pidfile $PID_FILE -chardev
> socket,path=/opt/cloud/workspace/servers/4511f52a-f450-40d3-9417-a1e0a27ed507/qga.sock,server,nowait,id=qga0
> -device virtio-serial -device
> virtserialport,chardev=qga0,name=org.qemu.guest_agent.0"
> 
> CMD2="$QEMU_CMD -D qemu.log -trace events=qemu-events-all -enable-kvm -cpu
> qemu64,+vmx,+ssse3,+sse4.1,+sse4.2,+x2apic,+aes,+avx,+vme,+pat,+ss,+pclmulqdq,+xsave,level=13
> -machine pc,accel=kvm -chardev
> socket,id=hmqmondev,port=55908,host=127.0.0.1,nodelay,server,nowait -mon
> chardev=hmqmondev,id=hmqmon,mode=readline -rtc
> base=utc,clock=host,driftfix=none -usb -device usb-tablet -daemonize
> -nodefaults -nodefconfig -no-kvm-pit-reinjection -global
> kvm-pit.lost_tick_policy=discard -vga std -k en-us -smp 8 -name
> gangyewei-qemutime-1 -m 40960 -boot order=cdn -vnc :8,password -drive
> file=$DISK_0,if=none,id=drive_0,format=qcow2,cache=none,aio=native -device
> virtio-blk-pci,id=dev_drive_0,drive=drive_0,bus=pci.0,addr=0x5 -drive
> file=$DISK_1,if=none,id=drive_1,format=qcow2,cache=none,aio=native -device
> virtio-blk-pci,id=dev_drive_1,drive=drive_1,bus=pci.0,addr=0x6 -drive
> file=$DISK_2,if=none,id=drive_2,format=qcow2,cache=none,aio=native -device
> virtio-blk-pci,id=dev_drive_2,drive=drive_2,bus=pci.0,addr=0x7 -device
> ide-cd,drive=ide0-cd0,bus=ide.1,unit=1 -drive
> id=ide0-cd0,media=cdrom,if=none -chardev
> socket,id=char-n-52b49b80,path=/usr/local/var/run/openvswitch/n-52b49b80,server
> -netdev type=vhost-user,id=n-52b49b80,chardev=char-n-52b49b80,vhostforce=on
> -device
> virtio-net-pci,netdev=n-52b49b80,mac=00:22:52:b4:9b:80,id=netdev-n-52b49b80,addr=0xf$(nic_speed
> 10000) -object
> memory-backend-file,id=mem,size=40960M,mem-path=/mnt/huge,share=on -numa
> node,memdev=mem -mem-prealloc -pidfile $PID_FILE -chardev
> socket,path=/opt/cloud/workspace/servers/4511f52a-f450-40d3-9417-a1e0a27ed507/qga.sock,server,nowait,id=qga0
> -device virtio-serial -device
> virtserialport,chardev=qga0,name=org.qemu.guest_agent.0"
> 
> 
> time to run CMD1:
> [root@yf-mos-test-net14 4511f52a-f450-40d3-9417-a1e0a27ed507]# sh startvm
> ls: cannot access
> /opt/cloud/workspace/servers/4511f52a-f450-40d3-9417-a1e0a27ed507/STATEFILE*:
> No such file or directory
> Wed Oct 25 16:52:51 CST 2017  (unix time is 1508921571)
> qemu-system-x86_64_2.6.0:qemu-events-all:1045: WARNING: trace event
> 'qxl_interface_set_mm_time' is not traceable
> qemu-system-x86_64_2.6.0:qemu-events-all:1046: WARNING: trace event
> 'qxl_io_write_vga' is not traceable
> qemu-system-x86_64_2.6.0:qemu-events-all:1318: WARNING: trace event
> 'exec_tb' is not traceable
> qemu-system-x86_64_2.6.0:qemu-events-all:1319: WARNING: trace event
> 'exec_tb_nocache' is not traceable
> qemu-system-x86_64_2.6.0:qemu-events-all:1320: WARNING: trace event
> 'exec_tb_exit' is not traceable
> qemu-system-x86_64_2.6.0: -no-kvm-pit-reinjection: warning: deprecated,
> replaced by -global kvm-pit.lost_tick_policy=discard
> Wed Oct 25 16:53:02 CST 2017  (unix time is 1508921582)
> qemu started
> 
> first log of CMD1:
> 45704@1508921581.767831:qio_channel_socket_new Socket new ioc=0x55555640efd0
> I don't know why first log happends in 1508921581, not the start up time,
> which is 1508921571.
> 
> 
> time to run CMD2:
> [root@yf-mos-test-net14 4511f52a-f450-40d3-9417-a1e0a27ed507]# sh startvm
> ls: cannot access
> /opt/cloud/workspace/servers/4511f52a-f450-40d3-9417-a1e0a27ed507/STATEFILE*:
> No such file or directory
> Wed Oct 25 18:15:35 CST 2017
> qemu-system-x86_64_2.6.0:qemu-events-all:1045: WARNING: trace event
> 'qxl_interface_set_mm_time' is not traceable
> qemu-system-x86_64_2.6.0:qemu-events-all:1046: WARNING: trace event
> 'qxl_io_write_vga' is not traceable
> qemu-system-x86_64_2.6.0:qemu-events-all:1318: WARNING: trace event
> 'exec_tb' is not traceable
> qemu-system-x86_64_2.6.0:qemu-events-all:1319: WARNING: trace event
> 'exec_tb_nocache' is not traceable
> qemu-system-x86_64_2.6.0:qemu-events-all:1320: WARNING: trace event
> 'exec_tb_exit' is not traceable
> qemu-system-x86_64_2.6.0: -no-kvm-pit-reinjection: warning: deprecated,
> replaced by -global kvm-pit.lost_tick_policy=discard
> Wed Oct 25 18:15:36 CST 2017
> qemu started
> 
> first log of CMD1:
> 45167@1508926535.502360:qio_channel_socket_new Socket new ioc=0x55555640efd0
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
