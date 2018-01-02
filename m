Received: from eggs.gnu.org ([2001:4830:134:3::10]:43512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <roy.shterman@gmail.com>) id 1eWShv-00013i-1g
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 14:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <roy.shterman@gmail.com>) id 1eWSht-0006WX-Sa
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 14:58:43 -0500
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:38585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <roy.shterman@gmail.com>)
	id 1eWSht-0006Vi-NN
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 14:58:41 -0500
Received: by mail-qt0-x233.google.com with SMTP id d4so64095450qtj.5
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 11:58:41 -0800 (PST)
MIME-Version: 1.0
From: Roy Shterman <roy.shterman@gmail.com>
Date: Tue, 2 Jan 2018 21:58:40 +0200
Message-ID: <CAOBqJ54HDeQNOv++XjimiSfmLTyNgy2AjBdpO6_SChVGfr5U+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Problem to start VM with libiscsi + qemu upstream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, pl@kamp.de, ronnie sahlberg <ronniesahlberg@gmail.com>

Hi all,

I'm trying to get VM started with libiscsi (iSCSI initiator) device. Every
thing seems good from iSCSI point of view, but I'm stuck in VM boot,
"Booting from Hard Disk".
Any idea what can get wrong? how I can assure that the boot itself is from
the wanted disk.
Also will be helpful if someone can tell me how can I debug issues like
that.

below my xml part of disks:

<domain type='kvm'>
  <name>client</name>
  <uuid>d4e60885-22be-4270-94ca-1be8209686d2</uuid>
  <memory unit='KiB'>1048576</memory>
  <currentMemory unit='KiB'>1048576</currentMemory>
  <vcpu placement='static'>1</vcpu>
  <os>
    <type arch='x86_64' machine='pc-i440fx-2.7'>hvm</type>
    <bootmenu enable='yes'/>
  </os>
  <features>
    <acpi/>
    <apic/>
    <vmport state='off'/>
  </features>
  <cpu mode='host-model' check='partial'>
    <model fallback='allow'/>
  </cpu>
  <clock offset='utc'>
    <timer name='rtc' tickpolicy='catchup'/>
    <timer name='pit' tickpolicy='delay'/>
    <timer name='hpet' present='no'/>
  </clock>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>restart</on_crash>
  <devices>
    <emulator>/usr/bin/qemu-system-x86_64</emulator>
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='/var/lib/libvirt/images/4.7-rc2_client.qcow2'/>
      <target dev='vda' bus='virtio'/>
      <boot order='1'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x07'
function='0x0'/>
    </disk>
    <disk type='network' device='disk'>
      <driver name='qemu' type='raw'/>
      <source protocol='iscsi' name='iqn.2001-04.com.client-tgt-1/0'>
        <host name='192.168.64.75' port='3260'/>
      </source>
      <target dev='vdb' bus='virtio'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x06'
function='0x0'/>
    </disk>
    <controller type='pci' index='0' model='pci-root'/>
    <controller type='usb' index='0' model='piix3-uhci'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x01'
function='0x2'/>
    </controller>
    <controller type='scsi' index='0'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x04'
function='0x0'/>
    </controller>
    <interface type='bridge'>
      <mac address='52:54:00:bf:6c:56'/>
      <source bridge='br0'/>
      <model type='virtio'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03'
function='0x0'/>
    </interface>

Thanks,
Roy
