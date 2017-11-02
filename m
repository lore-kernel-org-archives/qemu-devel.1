Received: from eggs.gnu.org ([2001:4830:134:3::10]:36384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1eA6OF-0008B0-Je
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 23:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1eA6OD-0006Dc-Vb
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 23:41:59 -0400
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:44422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <batmanustc@gmail.com>)
	id 1eA6OD-0006Cf-Oz
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 23:41:57 -0400
Received: by mail-qk0-x22e.google.com with SMTP id r64so5198770qkc.1
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 20:41:57 -0700 (PDT)
MIME-Version: 1.0
From: Sam <batmanustc@gmail.com>
Date: Thu, 2 Nov 2017 11:41:56 +0800
Message-ID: <CAOE=1Z1HT4wfb9Z09VO22aNH7n8oHJEtLKR3HbzdSTUUkMcsDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Please help me to debug memory mis-unmap in ovs-dpdk.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ovs-dev@openvswitch.org, dev@dpdk.org, QEMU Developers <qemu-devel@nongnu.org>

Hi all,

I'm debugging a mis-unmap bug in ovs-dpdk, process is this:

1. start ovs-dpdk with 10G socket memory, then use `top`, ovs-vswitchd take
10G memory. command is bellow.
2. start qemu vm1 with vhost device as server to connect port on ovs-dpdk,
command is bellow. qemu share 40G memory with ovs-dpdk, then use `top`,
ovs-vswitchd take 50G memory.
3. start qemu vm2 with vhost device as server to connect port on ovs-dpdk,
command is bellow. qemu share 20G memory with ovs-dpdk, then use `top`,
ovs-vswitchd take 70G memory.
4. stop vm1, then use `top`, ovs-vswitchd take 50G memory (I think it
should be 30G?). use `cat /proc/meminfo`, 70G memory is not released.

Please tell me where is the code ovs-dpdk and qemu communicate with each
other about the map/unmap memory region. Thank you~

Is it old bug? Refer this link:
http://dev.dpdk.narkive.com/m04py1jJ/dpdk-dev-vhost-user-technical-isssues


Command to start ovs-dpdk:
ovs-vswitchd --dpdk -c 0x14 -n 4 --socket-mem 10240 --proc-type secondary
-w 0000:01:00.0 -w 0000:01:00.1 --
unix:/usr/local/var/run/openvswitch/db.sock --pidfile --detach --log-file
--mlockall --no-chdir
--log-file=/usr/local/var/log/openvswitch/ovs-vswitchd.log
--pidfile=/usr/local/var/run/openvswitch/ovs-vswitchd.pid --detach --monitor

Command to start qemu:
/usr/local/bin/qemu-system-x86_64 -enable-kvm -cpu
qemu64,+vmx,+ssse3,+sse4.1,+sse4.2,+x2apic,+aes,+avx,+vme,+pat,+ss,+pclmulqdq,+xsave,level=13
-machine pc,accel=kvm -chardev
socket,id=hmqmondev,port=55919,host=127.0.0.1,nodelay,server,nowait -mon
chardev=hmqmondev,id=hmqmon,mode=readline -rtc
base=utc,clock=host,driftfix=none -usb -device usb-tablet -daemonize
-nodefaults -nodefconfig -no-kvm-pit-reinjection -global
kvm-pit.lost_tick_policy=discard -vga std -k en-us -smp 1 -name
gangyewei-qemutime-07-1 -m 20480 -boot order=cdn -vnc :19,password -drive
file=/opt/cloud/workspace/disks/4a5148da-e34e-4c81-aada-12a247c0337e,if=none,id=drive_0,format=qcow2,cache=none,aio=native
-device virtio-blk-pci,id=dev_drive_0,drive=drive_0,bus=pci.0,addr=0x5
-drive
file=/opt/cloud/workspace/disks/08eb3f72-07ba-44e9-8ee9-4ab662dbbd1f,if=none,id=drive_1,format=qcow2,cache=none,aio=native
-device virtio-blk-pci,id=dev_drive_1,drive=drive_1,bus=pci.0,addr=0x6
-device ide-cd,drive=ide0-cd0,bus=ide.1,unit=1 -drive
id=ide0-cd0,media=cdrom,if=none -chardev
socket,id=char-n-f879ac2f,path=/usr/local/var/run/openvswitch/n-f879ac2f,server
-netdev type=vhost-user,id=n-f879ac2f,chardev=char-n-f879ac2f,vhostforce=on
-device
virtio-net-pci,netdev=n-f879ac2f,mac=00:22:f8:79:ac:2f,id=netdev-n-f879ac2f,addr=0xf,speed=1000
-object
memory-backend-file,id=mem,size=20480M,mem-path=/dev/hugepages,share=on
-mem-prealloc -numa node,memdev=mem -pidfile
/opt/cloud/workspace/servers/63ef2ec4-556f-47ea-93e0-23089bb59be5/pid
-chardev
socket,path=/opt/cloud/workspace/servers/63ef2ec4-556f-47ea-93e0-23089bb59be5/qga.sock,server,nowait,id=qga0
-device virtio-serial -device
virtserialport,chardev=qga0,name=org.qemu.guest_agent.0 -qmp
unix:/opt/cloud/workspace/servers/63ef2ec4-556f-47ea-93e0-23089bb59be5/qmp.sock,server,nowait

Process:
[gangyewei@yf-mos-test-net07 63ef2ec4-556f-47ea-93e0-23089bb59be5]$ top
  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
38470 root      10 -10 79.751g 223160  10636 S 200.0  0.2  58:26.77
ovs-vswitchd
 4575 root      20   0 41.338g  90036   2924 S   0.0  0.1   0:21.71
qemu-system-x86
 5914 root      20   0 20.652g  66824   2876 S   0.0  0.1   0:11.90
qemu-system-x86

[gangyewei@yf-mos-test-net07 63ef2ec4-556f-47ea-93e0-23089bb59be5]$ cd
../46c035e2-605c-4997-b4df-15d13f97758f
[gangyewei@yf-mos-test-net07 46c035e2-605c-4997-b4df-15d13f97758f]$ sudo sh
stopvm
Remove PID
/opt/cloud/workspace/servers/46c035e2-605c-4997-b4df-15d13f97758f/pid
Remove VNC
/opt/cloud/workspace/servers/46c035e2-605c-4997-b4df-15d13f97758f/vnc
[gangyewei@yf-mos-test-net07 46c035e2-605c-4997-b4df-15d13f97758f]$ top
  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
38470 root      10 -10 55.751g 223160  10636 S 200.3  0.2  59:30.31
ovs-vswitchd
 5914 root      20   0 20.652g  66824   2876 S   0.0  0.1   0:11.92
qemu-system-x86

[gangyewei@yf-mos-test-net07 46c035e2-605c-4997-b4df-15d13f97758f]$ cat
/proc/meminfo
HugePages_Total:     112
HugePages_Free:       42
