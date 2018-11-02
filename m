Received: from eggs.gnu.org ([2001:4830:134:3::10]:39335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gIUFR-0003Mj-4b
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gIUFN-0005An-Nz
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:52:05 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gIUFL-00058T-HL
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:52:01 -0400
Received: by mail-wm1-x342.google.com with SMTP id q12-v6so1099078wmq.0
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 00:51:57 -0700 (PDT)
References: <d5d6e09a-78ed-41c4-bbb9-260263c05bf2@windriver.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <d5d6e09a-78ed-41c4-bbb9-260263c05bf2@windriver.com>
Date: Fri, 02 Nov 2018 07:51:53 +0000
Message-ID: <87pnvn6hnq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] strange situation,
 guest cpu thread spinning at ~100%, but display not yet initialized
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chris Friesen <chris.friesen@windriver.com>
Cc: qemu-devel@nongnu.org


Chris Friesen <chris.friesen@windriver.com> writes:

> Hi all,
>
> I have an odd situation which occurs very infrequently and I'm hoping
> to get some advice on how to debug.  Apologies for the length of this
> message, I tried to include as much potentially useful information as
> possible.
>
> In the context of an OpenStack compute node I have a qemu guest (with
> kvm acceleration) that has started up.  The virtual console shows
> "Guest has not initialized the display (yet)."   I'm trying to figure
> out what's going on and how we got into this state.  I assume it's
> some sort of deadlock/livelock, but I can't figure out what's causing
> it.
>
> I'm using qemu 2.10.0 (qemu-kvm-ev-2.10.0-0), with CentOS 7.4.1708 as
> the underlying OS.  Kernel is 3.10.0-693.21.1.el7.36.
>
> On the host, the "CPU 0/KVM" thread for this guest is at 99.9% cpu
> utilization on host cpu 43.  There are two other threads of a separate
> process which are chewing up host cpus 2 and 3.  Host cpus 0 and 1
> (and their HT siblings 36 and 37) are ~90% idle and are used for
> general host overhead.
>
> The qemu process looks like this:
>
> controller-0:~# ps -ef|grep qemu
> root      48250      1 99 18:16 ?        01:17:35
> /usr/libexec/qemu-kvm -c 0x00000000000000000000000000000001 -n 4
> --proc-type=3Dsecondary --file-prefix=3Dvs -- -enable-dpdk -name
> guest=3Dinstance-00000001,debug-threads=3Don -S -object
> secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-2=
88-instance-00000001/master-key.aes
> -machine pc-i440fx-rhel7.4.0,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff =
-m
> 1024 -realtime mlock=3Doff -smp 4,sockets=3D4,cores=3D1,threads=3D1 -obje=
ct
> memory-backend-file,id=3Dram-node0,prealloc=3Dyes,mem-path=3D/mnt/huge-20=
48kB/libvirt/qemu/288-instance-00000001,share=3Dyes,size=3D1073741824,host-=
nodes=3D0,policy=3Dbind
> -numa node,nodeid=3D0,cpus=3D0-3,memdev=3Dram-node0 -uuid
> 146389d6-0190-4b41-9fbc-6fc7c957b81a -smbios
> type=3D1,manufacturer=3DFedora Project,product=3DOpenStack
> Nova,version=3D16.0.2-1.tis.156,serial=3Dd6e1c3bf-126e-4518-a46d-aa33f27e=
c0ab,uuid=3D146389d6-0190-4b41-9fbc-6fc7c957b81a,family=3DVirtual
> Machine -no-user-config -nodefaults -chardev
> socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-288-instance-=
00000001/monitor.sock,server,nowait
> -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
> base=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-h=
pet
> -no-shutdown -boot reboot-timeout=3D5000,strict=3Don -global
> i440FX-pcihost.pci-hole64-size=3D67108864K -device
> piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive
> file=3D/etc/nova/instances/146389d6-0190-4b41-9fbc-6fc7c957b81a/disk,form=
at=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone
> -device
> virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virtio-dis=
k0,id=3Dvirtio-disk0,bootindex=3D1
> -chardev
> socket,id=3Dcharnet0,path=3D/var/run/vswitch/usvhost-a19a0e3b-6c85-4726-9=
18d-572c223bd23c
> -netdev vhost-user,chardev=3Dcharnet0,id=3Dhostnet0 -device
> virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3Dfa:16:3e:68:4a:a2,bus=3D=
pci.0,addr=3D0x3
> -add-fd set=3D0,fd=3D78 -chardev
> pty,id=3Dcharserial0,logfile=3D/dev/fdset/0,logappend=3Don -device
> isa-serial,chardev=3Dcharserial0,id=3Dserial0 -device
> usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -vnc 0.0.0.0:0 -k en-us -devi=
ce
> cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -device
> virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5 -msg timestamp=3D=
on
>
>
> The CPU affinity looks a little odd, since we have a number of host
> CPUs reserved for other things, and the qemu process is affined to the
> CPUs of a single host NUMA node.
>
> controller-0:~# taskset -apc 48250
> pid 48250's current affinity list: 5-17,41-53
> pid 48271's current affinity list: 5-17,41-53
> pid 48272's current affinity list: 5-17,41-53
> pid 48316's current affinity list: 5-17,41-53
> pid 48317's current affinity list: 5-17,41-53
> pid 48318's current affinity list: 5-17,41-53
> pid 48319's current affinity list: 5-17,41-53
> pid 48335's current affinity list: 5-17,41-53
>
>
> CPU scheduler policy:
> controller-0:~# chrt -ap 48250
> pid 48250's current scheduling policy: SCHED_OTHER
> pid 48250's current scheduling priority: 0
> pid 48271's current scheduling policy: SCHED_OTHER
> pid 48271's current scheduling priority: 0
> pid 48272's current scheduling policy: SCHED_OTHER
> pid 48272's current scheduling priority: 0
> pid 48316's current scheduling policy: SCHED_OTHER
> pid 48316's current scheduling priority: 0
> pid 48317's current scheduling policy: SCHED_OTHER
> pid 48317's current scheduling priority: 0
> pid 48318's current scheduling policy: SCHED_OTHER
> pid 48318's current scheduling priority: 0
> pid 48319's current scheduling policy: SCHED_OTHER
> pid 48319's current scheduling priority: 0
> pid 48335's current scheduling policy: SCHED_OTHER
> pid 48335's current scheduling priority: 0
>
>
> Kernel stack for the CPU 0/KVM task.  This is kind of strange, because
> I'd expect it to be in the "ioctl" call in the kernel or somewhere
> further down the stack.
> controller-0:~# cat /proc/48316/stack
> [<ffffffffffffffff>] 0xffffffffffffffff
>
>
> Strace for the CPU 0/KVM task:
> controller-0:~# strace -s 2000 -ttt -p 48316
> strace: Process 48316 attached
> 1541102776.498402 rt_sigtimedwait([USR1], 0x7f6f689fa4c0, {0, 0}, 8) =3D
> -1 EAGAIN (Resource temporarily unavailable)
> 1541102776.498978 rt_sigpending([], 8)  =3D 0
> 1541102776.499053 ioctl(28, KVM_RUN                    #process is
> stuck here
>
> The output of /proc/sched_debug shows the CPU0/KVM task interrupted
> primarily by the "watchdog/43" task, with 2 interruptions in 10
> seconds.
>
> If I attach gdb to the CPU0/KVM task, running "bt" gives this:
> (gdb) bt
> #0  0x00007f6fb4a8a5d7 in ioctl () from /lib64/libc.so.6
> #1  0x000055886e96b0a4 in kvm_vcpu_ioctl ()
> #2  0x000055886e96b173 in kvm_cpu_exec ()
> #3  0x000055886e94aeca in qemu_kvm_cpu_thread_fn ()
> #4  0x00007f6fb4d69e25 in start_thread () from /lib64/libpthread.so.0
> #5  0x00007f6fb4a93bad in clone () from /lib64/libc.so.6
>
> If I then single-step forward, I get this:
> (gdb) n
> Single stepping until exit from function ioctl,
> which has no line number information.
> 0x000055886e96b0a4 in kvm_vcpu_ioctl ()
> (gdb)
> Single stepping until exit from function kvm_vcpu_ioctl,
> which has no line number information.
> 0x000055886e96b173 in kvm_cpu_exec ()
> (gdb)
> Single stepping until exit from function kvm_cpu_exec,
> which has no line number information.
> 0x000055886e94aeca in qemu_kvm_cpu_thread_fn ()
> (gdb)
> Single stepping until exit from function qemu_kvm_cpu_thread_fn,
> which has no line number information.
>
> At this point gdb appears to be stuck, though the task is still
> chewing 99.9% of host cpu 43.

That's because the vcpu_ioctl you just trace through is into the
VCPU_RUN, basically when you enter the guest code (assuming the in
kernel KVM code isn't spinning).

On a modern top like htop the time should be accounted as guest time.

If you want to get an idea why your guest is spinning you probably want
to enable the gdb stub and look at what your guest kernel is doing.

>
>
> Chris


--
Alex Benn=C3=A9e
