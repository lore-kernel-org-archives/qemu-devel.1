Received: from eggs.gnu.org ([2001:4830:134:3::10]:48256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cHKVu-00064W-P1
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 20:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cHKVr-00025P-IO
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 20:07:14 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <harrynjit@gmail.com>) id 1cHKVr-00025A-Cw
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 20:07:11 -0500
Received: by mail-qt0-f181.google.com with SMTP id n6so42862152qtd.1
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 17:07:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161214193107.GB20648@stefanha-x1.localdomain>
References: <CA+scX6=9y4wDBWzXyqpGh9U__usKUa6sxwdc63iA8YRmpWFPqA@mail.gmail.com>
	<20161214193107.GB20648@stefanha-x1.localdomain>
From: Weiwei Jia <harrynjit@gmail.com>
Date: Wed, 14 Dec 2016 20:06:10 -0500
Message-ID: <CA+scX6=oc_eGteY8A0d8tuwzJFSu9M_6wnXBd5Tp=XGrg8FotQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Lock contention in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org

Hi Stefan,

Thanks for your reply. Please see the inline replies.

On Wed, Dec 14, 2016 at 2:31 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Wed, Dec 14, 2016 at 12:58:11AM -0500, Weiwei Jia wrote:
>> I find the timeslice of vCPU thread in QEMU/KVM is unstable when there
>> are lots of read requests (for example, read 4KB each time (8GB in
>> total) from one file) from Guest OS. I also find that this phenomenon
>> may be caused by lock contention in QEMU layer. I find this problem
>> under following workload.
>>
>> Workload settings:
>> In VMM, there are 6 pCPUs which are pCPU0, pCPU1, pCPU2, pCPU3, pCPU4,
>> pCPU5. There are two Kernel Virtual Machines (VM1 and VM2) upon VMM.
>> In each VM, there are 5 vritual CPUs (vCPU0, vCPU1, vCPU2, vCPU3,
>> vCPU4). vCPU0 in VM1 and vCPU0 in VM2 are pinned to pCPU0 and pCPU5
>> separately to handle interrupts dedicatedly. vCPU1 in VM1 and vCPU1 in
>> VM2 are pinned to pCPU1; vCPU2 in VM1 and vCPU2 in VM2 are pinned to
>> pCPU2; vCPU3 in VM1 and vCPU3 in VM2 are pinned to pCPU3; vCPU4 in VM1
>> and vCPU4 in VM2 are pinned to pCPU4. Besides vCPU0 in VM2 (pinned to
>> pCPU5), other vCPUs all have one CPU intensive thread (while(1){i++})
>> upon each of them in VM1 and VM2 to avoid the vCPU to be idle. In VM1,
>> I start one I/O thread on vCPU2, which the I/O thread reads 4KB from
>> one file each time (reads 8GB in total). The I/O scheduler in VM1 and
>> VM2 is NOOP. The I/O scheduler in VMM is CFQ. I also pinned the I/O
>> worker threads launched by QEMU to pCPU5 (note: there is no CPU
>> intensive thread on pCPU5 so the I/O requests will be handled by QEMU
>> I/O thread workers ASAP). The process scheduling class in VM and VMM
>> is CFS.
>
> Did you pin the QEMU main loop to pCPU5?  This is the QEMU process' main
> thread and it handles ioeventfd (virtqueue kick) and thread pool
> completions.

No, I did not pin main loop to pCPU5. Do you mean If I pin QEMU main
loop to pCPU5 under above workload, the timeslice of vCPU2 thread will
be stable even though there are lots of I/O requests? I didn't use
virtio for VM and I use SCSI. My whole VM xml configuration file is as
follows.

<domain type='kvm' id='2'>
  <name>kvm1</name>
  <uuid>8e9c4603-c4b5-fa41-b251-1dc4ffe1872c</uuid>
  <memory unit='KiB'>4194304</memory>
  <currentMemory unit='KiB'>4194304</currentMemory>
  <vcpu placement='static'>4</vcpu>
  <cputune>
    <vcpupin vcpu='0' cpuset='0'/>
    <vcpupin vcpu='1' cpuset='1'/>
    <vcpupin vcpu='2' cpuset='2'/>
    <vcpupin vcpu='3' cpuset='3'/>
  </cputune>
  <resource>
    <partition>/machine</partition>
  </resource>
  <os>
    <type arch='x86_64' machine='pc-i440fx-2.0'>hvm</type>
    <boot dev='hd'/>
  </os>
  <features>
    <acpi/>
    <apic/>
    <pae/>
  </features>
  <clock offset='utc'/>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>restart</on_crash>
  <devices>
    <emulator>/usr/bin/kvm-spice</emulator>
    <disk type='file' device='disk'>
      <driver name='qemu' type='raw' cache='none'/>
      <source file='/home/images/kvm1.img'/>
      <target dev='hda' bus='scsi'/>
      <alias name='scsi0-0-0'/>
      <address type='drive' controller='0' bus='0' target='0' unit='0'/>
    </disk>
    <disk type='block' device='cdrom'>
      <driver name='qemu' type='raw'/>
      <target dev='hdc' bus='ide'/>
      <readonly/>
      <alias name='ide0-1-0'/>
      <address type='drive' controller='0' bus='1' target='0' unit='0'/>
    </disk>
    <controller type='usb' index='0'>
      <alias name='usb0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x01'
function='0x2'/>
    </controller>
    <controller type='pci' index='0' model='pci-root'>
      <alias name='pci.0'/>
    </controller>
    <controller type='scsi' index='0'>
      <alias name='scsi0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x04'
function='0x0'/>
    </controller>
    <controller type='ide' index='0'>
      <alias name='ide0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x01'
function='0x1'/>
    </controller>
    <interface type='network'>
      <mac address='52:54:00:01:ab:ca'/>
      <source network='default'/>
      <target dev='vnet0'/>
      <model type='virtio'/>
      <alias name='net0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03'
function='0x0'/>
    </interface>
    <serial type='pty'>
      <source path='/dev/pts/13'/>
      <target port='0'/>
      <alias name='serial0'/>
    </serial>
    <console type='pty' tty='/dev/pts/13'>
      <source path='/dev/pts/13'/>
      <target type='serial' port='0'/>
      <alias name='serial0'/>
    </console>
    <input type='mouse' bus='ps2'/>
    <input type='keyboard' bus='ps2'/>
    <graphics type='vnc' port='5900' autoport='yes' listen='127.0.0.1'>
      <listen type='address' address='127.0.0.1'/>
    </graphics>
    <video>
      <model type='cirrus' vram='9216' heads='1'/>
      <alias name='video0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02'
function='0x0'/>
    </video>
    <memballoon model='virtio'>
      <alias name='balloon0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x05'
function='0x0'/>
    </memballoon>
  </devices>
  <seclabel type='none'/>
</domain>



>
>>
>> Linux Kernel version for VMM is: 3.16.39
>> Linux Kernel version for VM1 and VM2 is: 4.7.4
>> QEMU emulator version is: 2.0.0
>>
>> When I test above workload, I find the timeslice of vCPU2 thread
>> jitters very much. I suspect this is triggered by lock contention in
>> QEMU layer since my debug log in front of VMM Linux Kernel's
>> schedule->__schedule->context_switch is like following. Once the
>> timeslice jitters very much, following debug information will appear.
>>
>> 7097537 Dec 13 11:22:33 mobius04 kernel: [39163.015789] Call Trace:
>> 7097538 Dec 13 11:22:33 mobius04 kernel: [39163.015791]
>> [<ffffffff8176b2f0>] dump_stack+0x64/0x84
>> 7097539 Dec 13 11:22:33 mobius04 kernel: [39163.015793]
>> [<ffffffff8176bf85>] __schedule+0x5b5/0x960
>> 7097540 Dec 13 11:22:33 mobius04 kernel: [39163.015794]
>> [<ffffffff8176c409>] schedule+0x29/0x70
>> 7097541 Dec 13 11:22:33 mobius04 kernel: [39163.015796]
>> [<ffffffff810ef4d8>] futex_wait_queue_me+0xd8/0x150
>> 7097542 Dec 13 11:22:33 mobius04 kernel: [39163.015798]
>> [<ffffffff810ef6fb>] futex_wait+0x1ab/0x2b0
>> 7097543 Dec 13 11:22:33 mobius04 kernel: [39163.015800]
>> [<ffffffff810eef00>] ? get_futex_key+0x2d0/0x2e0
>> 7097544 Dec 13 11:22:33 mobius04 kernel: [39163.015804]
>> [<ffffffffc0290105>] ? __vmx_load_host_state+0x125/0x170 [kv
>> m_intel]
>> 7097545 Dec 13 11:22:33 mobius04 kernel: [39163.015805]
>> [<ffffffff810f1275>] do_futex+0xf5/0xd20
>> 7097546 Dec 13 11:22:33 mobius04 kernel: [39163.015813]
>> [<ffffffffc0222690>] ? kvm_vcpu_ioctl+0x100/0x560 [kvm]
>> 7097547 Dec 13 11:22:33 mobius04 kernel: [39163.015816]
>> [<ffffffff810b06f0>] ? __dequeue_entity+0x30/0x50
>> 7097548 Dec 13 11:22:33 mobius04 kernel: [39163.015818]
>> [<ffffffff81013d06>] ? __switch_to+0x596/0x690
>> 7097549 Dec 13 11:22:33 mobius04 kernel: [39163.015820]
>> [<ffffffff811f9f23>] ? do_vfs_ioctl+0x93/0x520
>> 7097550 Dec 13 11:22:33 mobius04 kernel: [39163.015822]
>> [<ffffffff810f1f1d>] SyS_futex+0x7d/0x170
>> 7097551 Dec 13 11:22:33 mobius04 kernel: [39163.015824]
>> [<ffffffff8116d1b2>] ? fire_user_return_notifiers+0x42/0x50
>> 7097552 Dec 13 11:22:33 mobius04 kernel: [39163.015826]
>> [<ffffffff810154b5>] ? do_notify_resume+0xc5/0x100
>> 7097553 Dec 13 11:22:33 mobius04 kernel: [39163.015828]
>> [<ffffffff81770a8d>] system_call_fastpath+0x1a/0x1f
>>
>>
>> If true, I think this may be a scalability problem caused by QEMU I/O
>> part. Do we have a feature in QEMU to avoid this? Would you please
>> give me some suggestions about how to make the timeslice of vCPU2
>> thread stable even though there are lots of I/O Read requests on it.
>
> Yes, there is a way to reduce jitter caused by the QEMU global mutex:
>
> qemu -object iothread,id=iothread0 \
>      -drive if=none,id=drive0,file=test.img,format=raw,cache=none \
>      -device virtio-blk-pci,iothread=iothread0,drive=drive0
>
> Now the ioeventfd and thread pool completions will be processed in
> iothread0 instead of the QEMU main loop thread.  This thread does not
> take the QEMU global mutex so vcpu execution is not hindered.
>
> This feature is called virtio-blk dataplane.
>
> You can query IOThread thread IDs using the query-iothreads QMP command.
> This will allow you to pin iothread0 to pCPU5.
>
> Please let us know if this helps.

Does this feature only work for VirtIO? Does it work for SCSI or IDE?

Thank you,
Weiwei Jia
