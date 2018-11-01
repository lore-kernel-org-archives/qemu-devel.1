Received: from eggs.gnu.org ([2001:4830:134:3::10]:35470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1gIKRv-0003RN-Li
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 17:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1gIKRk-0000t6-V8
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 17:24:17 -0400
Received: from mail5.windriver.com ([192.103.53.11]:39912 helo=mail5.wrs.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
	id 1gIKRk-0000pS-Jh
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 17:24:08 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wA1LNd5c012760
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <qemu-devel@nongnu.org>; Thu, 1 Nov 2018 14:23:54 -0700
From: Chris Friesen <chris.friesen@windriver.com>
Message-ID: <d5d6e09a-78ed-41c4-bbb9-260263c05bf2@windriver.com>
Date: Thu, 1 Nov 2018 15:23:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] strange situation, guest cpu thread spinning at ~100%,
 but display not yet initialized
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,

I have an odd situation which occurs very infrequently and I'm hoping to 
get some advice on how to debug.  Apologies for the length of this 
message, I tried to include as much potentially useful information as 
possible.

In the context of an OpenStack compute node I have a qemu guest (with 
kvm acceleration) that has started up.  The virtual console shows "Guest 
has not initialized the display (yet)."   I'm trying to figure out 
what's going on and how we got into this state.  I assume it's some sort 
of deadlock/livelock, but I can't figure out what's causing it.

I'm using qemu 2.10.0 (qemu-kvm-ev-2.10.0-0), with CentOS 7.4.1708 as 
the underlying OS.  Kernel is 3.10.0-693.21.1.el7.36.

On the host, the "CPU 0/KVM" thread for this guest is at 99.9% cpu 
utilization on host cpu 43.  There are two other threads of a separate 
process which are chewing up host cpus 2 and 3.  Host cpus 0 and 1 (and 
their HT siblings 36 and 37) are ~90% idle and are used for general host 
overhead.

The qemu process looks like this:

controller-0:~# ps -ef|grep qemu
root      48250      1 99 18:16 ?        01:17:35 /usr/libexec/qemu-kvm 
-c 0x00000000000000000000000000000001 -n 4 --proc-type=secondary 
--file-prefix=vs -- -enable-dpdk -name 
guest=instance-00000001,debug-threads=on -S -object 
secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-288-instance-00000001/master-key.aes 
-machine pc-i440fx-rhel7.4.0,accel=kvm,usb=off,dump-guest-core=off -m 
1024 -realtime mlock=off -smp 4,sockets=4,cores=1,threads=1 -object 
memory-backend-file,id=ram-node0,prealloc=yes,mem-path=/mnt/huge-2048kB/libvirt/qemu/288-instance-00000001,share=yes,size=1073741824,host-nodes=0,policy=bind 
-numa node,nodeid=0,cpus=0-3,memdev=ram-node0 -uuid 
146389d6-0190-4b41-9fbc-6fc7c957b81a -smbios type=1,manufacturer=Fedora 
Project,product=OpenStack 
Nova,version=16.0.2-1.tis.156,serial=d6e1c3bf-126e-4518-a46d-aa33f27ec0ab,uuid=146389d6-0190-4b41-9fbc-6fc7c957b81a,family=Virtual 
Machine -no-user-config -nodefaults -chardev 
socket,id=charmonitor,path=/var/lib/libvirt/qemu/domain-288-instance-00000001/monitor.sock,server,nowait 
-mon chardev=charmonitor,id=monitor,mode=control -rtc 
base=utc,driftfix=slew -global kvm-pit.lost_tick_policy=delay -no-hpet 
-no-shutdown -boot reboot-timeout=5000,strict=on -global 
i440FX-pcihost.pci-hole64-size=67108864K -device 
piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 -drive 
file=/etc/nova/instances/146389d6-0190-4b41-9fbc-6fc7c957b81a/disk,format=qcow2,if=none,id=drive-virtio-disk0,cache=none 
-device 
virtio-blk-pci,scsi=off,bus=pci.0,addr=0x4,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1 
-chardev 
socket,id=charnet0,path=/var/run/vswitch/usvhost-a19a0e3b-6c85-4726-918d-572c223bd23c 
-netdev vhost-user,chardev=charnet0,id=hostnet0 -device 
virtio-net-pci,netdev=hostnet0,id=net0,mac=fa:16:3e:68:4a:a2,bus=pci.0,addr=0x3 
-add-fd set=0,fd=78 -chardev 
pty,id=charserial0,logfile=/dev/fdset/0,logappend=on -device 
isa-serial,chardev=charserial0,id=serial0 -device 
usb-tablet,id=input0,bus=usb.0,port=1 -vnc 0.0.0.0:0 -k en-us -device 
cirrus-vga,id=video0,bus=pci.0,addr=0x2 -device 
virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x5 -msg timestamp=on


The CPU affinity looks a little odd, since we have a number of host CPUs 
reserved for other things, and the qemu process is affined to the CPUs 
of a single host NUMA node.

controller-0:~# taskset -apc 48250
pid 48250's current affinity list: 5-17,41-53
pid 48271's current affinity list: 5-17,41-53
pid 48272's current affinity list: 5-17,41-53
pid 48316's current affinity list: 5-17,41-53
pid 48317's current affinity list: 5-17,41-53
pid 48318's current affinity list: 5-17,41-53
pid 48319's current affinity list: 5-17,41-53
pid 48335's current affinity list: 5-17,41-53


CPU scheduler policy:
controller-0:~# chrt -ap 48250
pid 48250's current scheduling policy: SCHED_OTHER
pid 48250's current scheduling priority: 0
pid 48271's current scheduling policy: SCHED_OTHER
pid 48271's current scheduling priority: 0
pid 48272's current scheduling policy: SCHED_OTHER
pid 48272's current scheduling priority: 0
pid 48316's current scheduling policy: SCHED_OTHER
pid 48316's current scheduling priority: 0
pid 48317's current scheduling policy: SCHED_OTHER
pid 48317's current scheduling priority: 0
pid 48318's current scheduling policy: SCHED_OTHER
pid 48318's current scheduling priority: 0
pid 48319's current scheduling policy: SCHED_OTHER
pid 48319's current scheduling priority: 0
pid 48335's current scheduling policy: SCHED_OTHER
pid 48335's current scheduling priority: 0


Kernel stack for the CPU 0/KVM task.  This is kind of strange, because 
I'd expect it to be in the "ioctl" call in the kernel or somewhere 
further down the stack.
controller-0:~# cat /proc/48316/stack
[<ffffffffffffffff>] 0xffffffffffffffff


Strace for the CPU 0/KVM task:
controller-0:~# strace -s 2000 -ttt -p 48316
strace: Process 48316 attached
1541102776.498402 rt_sigtimedwait([USR1], 0x7f6f689fa4c0, {0, 0}, 8) = 
-1 EAGAIN (Resource temporarily unavailable)
1541102776.498978 rt_sigpending([], 8)  = 0
1541102776.499053 ioctl(28, KVM_RUN                    #process is stuck 
here

The output of /proc/sched_debug shows the CPU0/KVM task interrupted 
primarily by the "watchdog/43" task, with 2 interruptions in 10 seconds.

If I attach gdb to the CPU0/KVM task, running "bt" gives this:
(gdb) bt
#0  0x00007f6fb4a8a5d7 in ioctl () from /lib64/libc.so.6
#1  0x000055886e96b0a4 in kvm_vcpu_ioctl ()
#2  0x000055886e96b173 in kvm_cpu_exec ()
#3  0x000055886e94aeca in qemu_kvm_cpu_thread_fn ()
#4  0x00007f6fb4d69e25 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f6fb4a93bad in clone () from /lib64/libc.so.6

If I then single-step forward, I get this:
(gdb) n
Single stepping until exit from function ioctl,
which has no line number information.
0x000055886e96b0a4 in kvm_vcpu_ioctl ()
(gdb)
Single stepping until exit from function kvm_vcpu_ioctl,
which has no line number information.
0x000055886e96b173 in kvm_cpu_exec ()
(gdb)
Single stepping until exit from function kvm_cpu_exec,
which has no line number information.
0x000055886e94aeca in qemu_kvm_cpu_thread_fn ()
(gdb)
Single stepping until exit from function qemu_kvm_cpu_thread_fn,
which has no line number information.

At this point gdb appears to be stuck, though the task is still chewing 
99.9% of host cpu 43.


Chris
