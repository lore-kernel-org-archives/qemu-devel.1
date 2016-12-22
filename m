Received: from eggs.gnu.org ([2001:4830:134:3::10]:48298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cJwxm-0003e6-9A
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 01:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <harrynjit@gmail.com>) id 1cJwxk-0003Xq-Sb
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 01:34:50 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <harrynjit@gmail.com>) id 1cJwxk-0003XU-Mh
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 01:34:48 -0500
Received: by mail-qt0-x241.google.com with SMTP id 3so2315659qtr.2
	for <qemu-devel@nongnu.org>; Wed, 21 Dec 2016 22:34:48 -0800 (PST)
MIME-Version: 1.0
From: Weiwei Jia <harrynjit@gmail.com>
Date: Thu, 22 Dec 2016 01:34:47 -0500
Message-ID: <CA+scX6=rRiGHsOj8oxjTe4KqEF7S_GUao3k=TUQeE7FpyT_K8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Performance about x-data-plane
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, libvir-list@redhat.com

Hi,

With QEMU x-data-plane, I find the performance has not been improved
very much. Please see following two settings.

Setting 1: I/O thread in host OS (VMM) reads 4KB each time from disk
(8GB in total). Pin the I/O thread to pCPU 5 which will serve I/O
thread dedicatedly. I find the performance is around 250 MB/s.

Setting 2: I/O thread in guest OS (VMM) reads 4KB each time from
virtual disk (8GB in total). Pin the I/O thread to vCPU 5 and pin vCPU
5 thread to pCPU5 so that vCPU 5 handles this I/O thread dedicatedly
and pCPU5 serve vCPU5 dedicatedly. In order to keep vCPU5 not to be
idle, I also pin one cpu intensive thread (while (1) {i++}) on vCPU 5
so that the I/O thread on it can be served without delay. For this
setting, I find the performance for this I/O thread is around 190
MB/s.

NOTE: For setting 2, I also pin the QEMU dedicated IOthread
(x-data-plane) in host OS to pCPU to handle I/O requests from guest OS
dedicatedly.

I think for setting 2, the performance of I/O thread should be almost
the same as setting 1. I cannot understand why it is 60 MB/s lower
than setting 1. I am wondering whether there are something wrong with
my x-data-plane setting or virtio setting for VM.  Would you please
give me some hints? Thank you.

Libvirt version: 2.4.0
QEMU version: 2.3.0

The libvirt xml  configuration file is like following (I only start
one VM with following xml config).

<domain type='kvm' id='1'
xmlns:qemu='http://libvirt.org/schemas/domain/qemu/1.0'>
  <name>vm</name>
  <uuid>3290a8d0-9d9f-b2c4-dd46-5d0d8a730cd6</uuid>
  <memory unit='KiB'>8290304</memory>
  <currentMemory unit='KiB'>8290304</currentMemory>
  <vcpu placement='static'>15</vcpu>
  <cputune>
    <vcpupin vcpu='0' cpuset='0'/>
    <vcpupin vcpu='1' cpuset='1'/>
    <vcpupin vcpu='2' cpuset='2'/>
    <vcpupin vcpu='3' cpuset='3'/>
    <vcpupin vcpu='4' cpuset='4'/>
    <vcpupin vcpu='5' cpuset='5'/>
    <vcpupin vcpu='6' cpuset='6'/>
    <vcpupin vcpu='7' cpuset='7'/>
    <vcpupin vcpu='8' cpuset='8'/>
    <vcpupin vcpu='9' cpuset='9'/>
    <vcpupin vcpu='10' cpuset='10'/>
    <vcpupin vcpu='11' cpuset='11'/>
    <vcpupin vcpu='12' cpuset='12'/>
    <vcpupin vcpu='13' cpuset='13'/>
    <vcpupin vcpu='14' cpuset='14'/>
  </cputune>
  <resource>
    <partition>/machine</partition>
  </resource>
  <os>
    <type arch='x86_64' machine='pc-i440fx-2.2'>hvm</type>
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
      <driver name='qemu' type='raw' cache='none' io='native'/>
      <source file='/var/lib/libvirt/images/vm.img'/>
      <target dev='vda' bus='virtio'/>
      <alias name='virtio-disk0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x06'
function='0x0'/>
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
    <controller type='ide' index='0'>
      <alias name='ide0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x01'
function='0x1'/>
    </controller>
    <controller type='scsi' index='0'>
      <alias name='scsi0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x04'
function='0x0'/>
    </controller>
    <interface type='network'>
      <mac address='52:54:00:8e:3d:06'/>
      <source network='default'/>
      <target dev='vnet0'/>
      <model type='virtio'/>
      <alias name='net0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03'
function='0x0'/>
    </interface>
    <serial type='pty'>
      <source path='/dev/pts/8'/>
      <target port='0'/>
      <alias name='serial0'/>
    </serial>
    <console type='pty' tty='/dev/pts/8'>
      <source path='/dev/pts/8'/>
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
  <qemu:commandline>
    <qemu:arg value='-set'/>
    <qemu:arg value='device.virtio-disk0.scsi=off'/>
    <qemu:arg value='-set'/>
    <qemu:arg value='device.virtio-disk0.config-wce=off'/>
    <qemu:arg value='-set'/>
    <qemu:arg value='device.virtio-disk0.x-data-plane=on'/>
  </qemu:commandline>
</domain>


Thank you,
Weiwei Jia
