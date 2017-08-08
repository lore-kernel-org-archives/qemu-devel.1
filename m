Received: from eggs.gnu.org ([2001:4830:134:3::10]:50828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcin.juszkiewicz@linaro.org>) id 1df1vE-0004RZ-QD
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcin.juszkiewicz@linaro.org>) id 1df1vA-0002Em-Sr
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:39:36 -0400
Received: from mail-lf0-x22f.google.com ([2a00:1450:4010:c07::22f]:34905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcin.juszkiewicz@linaro.org>)
	id 1df1vA-0002Du-8J
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:39:32 -0400
Received: by mail-lf0-x22f.google.com with SMTP id t128so13018217lff.2
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 03:39:31 -0700 (PDT)
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <743158bc-15e4-46fe-38cb-161397b5b240@linaro.org>
Date: Tue, 8 Aug 2017 12:39:28 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------4F9A9E6BE53CFBECE917A7F9"
Content-Language: en-GB
Subject: [Qemu-devel] Qemu and 32 PCIe devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

This is a multi-part message in MIME format.
--------------4F9A9E6BE53CFBECE917A7F9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello

Few days ago I had an issue with getting PCIe hotplug working on AArch64
machine. Enabled PCI hotplug in kernel and then got hit by some issues.

Out setup is a bunch of aarch64 servers and we use OpenStack to provide
access to arm64 systems. OpenStack uses libvirt to control VMs and
allows to add network interfaces and disk volumes to running systems.

By libvirt AArch64 is treated as PCIe machine without legacy PCI slots.
So to hotplug anything you first need to have enough pcie-root-port
entries as it is described in Qemu docs/pcie.txt and by patch to libvirt
documentation [1][2].

1. https://bugs.linaro.org/attachment.cgi?id=782
2. https://www.redhat.com/archives/libvir-list/2017-July/msg01033.html


But things get complicated once you are going to 32 PCIe devices limit
(which in our setup will rather not happen). UEFI first takes ages to
boot just to land in UEFI shell as it forgot all PCIe devices. With 31
devices it boots (also after long time).


I attached two xml files with VM definitions (for use with virsh). Also
attached their qemu command lines. One has 31 PCI devices, second has
32. Both use [30] as rootfs.

30.
https://builds.96boards.org/snapshots/reference-platform/components/developer-cloud/debian/cloud-image/30/debian-cloud-image.qcow2

Output from 31 PCI devices VM:

root@unassigned-hostname:~# lspci;lspci |wc -l
00:00.0 Host bridge: Red Hat, Inc. Device 0008
00:01.0 PCI bridge: Red Hat, Inc. Device 000c
00:01.1 PCI bridge: Red Hat, Inc. Device 000c
00:01.2 PCI bridge: Red Hat, Inc. Device 000c
00:01.3 PCI bridge: Red Hat, Inc. Device 000c
00:01.4 PCI bridge: Red Hat, Inc. Device 000c
00:01.5 PCI bridge: Red Hat, Inc. Device 000c
00:01.6 PCI bridge: Red Hat, Inc. Device 000c
00:01.7 PCI bridge: Red Hat, Inc. Device 000c
00:02.0 PCI bridge: Red Hat, Inc. Device 000c
00:02.1 PCI bridge: Red Hat, Inc. Device 000c
00:02.2 PCI bridge: Red Hat, Inc. Device 000c
00:02.3 PCI bridge: Red Hat, Inc. Device 000c
00:02.4 PCI bridge: Red Hat, Inc. Device 000c
00:02.5 PCI bridge: Red Hat, Inc. Device 000c
00:02.6 PCI bridge: Red Hat, Inc. Device 000c
01:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
02:00.0 SCSI storage controller: Red Hat, Inc Device 1048 (rev 01)
03:00.0 Communication controller: Red Hat, Inc Device 1043 (rev 01)
04:00.0 SCSI storage controller: Red Hat, Inc Device 1042 (rev 01)
05:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
06:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
07:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
08:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
09:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
0a:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
0b:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
0c:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
0d:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
0e:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
0f:00.0 Ethernet controller: Red Hat, Inc Device 1041 (rev 01)
31
root@unassigned-hostname:~# lspci -t
-[0000:00]-+-00.0
           +-01.0-[01]----00.0
           +-01.1-[02]----00.0
           +-01.2-[03]----00.0
           +-01.3-[04]----00.0
           +-01.4-[05]----00.0
           +-01.5-[06]----00.0
           +-01.6-[07]----00.0
           +-01.7-[08]----00.0
           +-02.0-[09]----00.0
           +-02.1-[0a]----00.0
           +-02.2-[0b]----00.0
           +-02.3-[0c]----00.0
           +-02.4-[0d]----00.0
           +-02.5-[0e]----00.0
           \-02.6-[0f]----00.0

>From what I was told some parts of that issue lies in UEFI, some in
Qemu, some in Linux kernel.

--------------4F9A9E6BE53CFBECE917A7F9
Content-Type: text/xml; charset=utf-8;
 name="vm-pci-32.xml"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="vm-pci-32.xml"

<domain type=3D'kvm'>
  <name>pci</name>
  <uuid>5361dd27-bdc1-4178-b26f-323b4009b226</uuid>
  <memory unit=3D'KiB'>12312576</memory>
  <currentMemory unit=3D'KiB'>12312576</currentMemory>
  <vcpu placement=3D'static'>5</vcpu>
  <os>
    <type arch=3D'aarch64' machine=3D'virt-2.9'>hvm</type>
    <loader readonly=3D'yes' type=3D'pflash'>/usr/share/AAVMF/AAVMF_CODE.=
fd</loader>
    <nvram>/var/lib/libvirt/qemu/nvram/pci_VARS.fd</nvram>
    <boot dev=3D'hd'/>
  </os>
  <features>
    <acpi/>
    <gic version=3D'2'/>
  </features>
  <cpu mode=3D'host-passthrough' check=3D'none'/>
  <clock offset=3D'utc'/>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <devices>
    <emulator>/usr/bin/qemu-system-aarch64</emulator>
    <disk type=3D'file' device=3D'disk'>
      <driver name=3D'qemu' type=3D'qcow2'/>
      <source file=3D'/home/linaro/virt/debian-30.qcow2'/>
      <target dev=3D'vda' bus=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x04' slot=3D'0x00' =
function=3D'0x0'/>
    </disk>
    <controller type=3D'scsi' index=3D'0' model=3D'virtio-scsi'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' slot=3D'0x00' =
function=3D'0x0'/>
    </controller>
    <controller type=3D'pci' index=3D'0' model=3D'pcie-root'/>
    <controller type=3D'pci' index=3D'1' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'1' port=3D'0x8'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x0' multifunction=3D'on'/>
    </controller>
    <controller type=3D'pci' index=3D'2' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'2' port=3D'0x9'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x1'/>
    </controller>
    <controller type=3D'pci' index=3D'3' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'3' port=3D'0xa'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x2'/>
    </controller>
    <controller type=3D'pci' index=3D'4' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'4' port=3D'0xb'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x3'/>
    </controller>
    <controller type=3D'pci' index=3D'5' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'5' port=3D'0xc'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x4'/>
    </controller>
    <controller type=3D'pci' index=3D'6' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'6' port=3D'0xd'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x5'/>
    </controller>
    <controller type=3D'pci' index=3D'7' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'7' port=3D'0xe'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x6'/>
    </controller>
    <controller type=3D'pci' index=3D'8' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'8' port=3D'0xf'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x7'/>
    </controller>
    <controller type=3D'pci' index=3D'9' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'9' port=3D'0x10'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0' multifunction=3D'on'/>
    </controller>
    <controller type=3D'pci' index=3D'10' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'10' port=3D'0x11'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x1'/>
    </controller>
    <controller type=3D'pci' index=3D'11' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'11' port=3D'0x12'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x2'/>
    </controller>
    <controller type=3D'pci' index=3D'12' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'12' port=3D'0x13'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x3'/>
    </controller>
    <controller type=3D'pci' index=3D'13' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'13' port=3D'0x14'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x4'/>
    </controller>
    <controller type=3D'pci' index=3D'14' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'14' port=3D'0x15'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x5'/>
    </controller>
    <controller type=3D'pci' index=3D'15' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'15' port=3D'0x16'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x6'/>
    </controller>
    <controller type=3D'pci' index=3D'16' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'16' port=3D'0x17'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x7'/>
    </controller>
    <controller type=3D'virtio-serial' index=3D'0'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x03' slot=3D'0x00' =
function=3D'0x0'/>
    </controller>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:37:6a:d5'/>
      <source network=3D'default'/>
      <model type=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x01' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:db:35:b3'/>
      <source network=3D'default'/>
      <model type=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x05' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:8a:54:6c'/>
      <source network=3D'default'/>
      <model type=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x06' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:04:2b:e4'/>
      <source network=3D'default'/>
      <model type=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x07' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:6b:fc:ac'/>
      <source network=3D'default'/>
      <model type=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x08' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:d4:b0:e2'/>
      <source network=3D'default'/>
      <model type=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x09' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:52:2f:cc'/>
      <source network=3D'default'/>
      <model type=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x0a' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:0d:b1:bb'/>
      <source network=3D'default'/>
      <model type=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x0b' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:8a:a5:69'/>
      <source network=3D'default'/>
      <model type=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x0c' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:ad:60:b1'/>
      <source network=3D'default'/>
      <model type=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x0d' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:e3:9a:70'/>
      <source network=3D'default'/>
      <model type=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x0e' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:56:58:b3'/>
      <source network=3D'default'/>
      <model type=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x0f' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <serial type=3D'pty'>
      <target port=3D'0'/>
    </serial>
    <console type=3D'pty'>
      <target type=3D'serial' port=3D'0'/>
    </console>
    <channel type=3D'unix'>
      <target type=3D'virtio' name=3D'org.qemu.guest_agent.0'/>
      <address type=3D'virtio-serial' controller=3D'0' bus=3D'0' port=3D'=
1'/>
    </channel>
  </devices>
</domain>


--------------4F9A9E6BE53CFBECE917A7F9
Content-Type: text/xml; charset=utf-8;
 name="vm-pci-31.xml"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="vm-pci-31.xml"

<domain type=3D'kvm' id=3D'57'>
  <name>pci</name>
  <uuid>5361dd27-bdc1-4178-b26f-323b4009b226</uuid>
  <memory unit=3D'KiB'>12312576</memory>
  <currentMemory unit=3D'KiB'>12312576</currentMemory>
  <vcpu placement=3D'static'>5</vcpu>
  <resource>
    <partition>/machine</partition>
  </resource>
  <os>
    <type arch=3D'aarch64' machine=3D'virt-2.9'>hvm</type>
    <loader readonly=3D'yes' type=3D'pflash'>/usr/share/AAVMF/AAVMF_CODE.=
fd</loader>
    <nvram>/var/lib/libvirt/qemu/nvram/pci_VARS.fd</nvram>
    <boot dev=3D'hd'/>
  </os>
  <features>
    <acpi/>
    <gic version=3D'2'/>
  </features>
  <cpu mode=3D'host-passthrough' check=3D'none'/>
  <clock offset=3D'utc'/>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <devices>
    <emulator>/usr/bin/qemu-system-aarch64</emulator>
    <disk type=3D'file' device=3D'disk'>
      <driver name=3D'qemu' type=3D'qcow2'/>
      <source file=3D'/home/linaro/virt/debian-30.qcow2'/>
      <backingStore/>
      <target dev=3D'vda' bus=3D'virtio'/>
      <alias name=3D'virtio-disk0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x04' slot=3D'0x00' =
function=3D'0x0'/>
    </disk>
    <controller type=3D'scsi' index=3D'0' model=3D'virtio-scsi'>
      <alias name=3D'scsi0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' slot=3D'0x00' =
function=3D'0x0'/>
    </controller>
    <controller type=3D'pci' index=3D'0' model=3D'pcie-root'>
      <alias name=3D'pcie.0'/>
    </controller>
    <controller type=3D'pci' index=3D'1' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'1' port=3D'0x8'/>
      <alias name=3D'pci.1'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x0' multifunction=3D'on'/>
    </controller>
    <controller type=3D'pci' index=3D'2' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'2' port=3D'0x9'/>
      <alias name=3D'pci.2'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x1'/>
    </controller>
    <controller type=3D'pci' index=3D'3' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'3' port=3D'0xa'/>
      <alias name=3D'pci.3'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x2'/>
    </controller>
    <controller type=3D'pci' index=3D'4' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'4' port=3D'0xb'/>
      <alias name=3D'pci.4'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x3'/>
    </controller>
    <controller type=3D'pci' index=3D'5' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'5' port=3D'0xc'/>
      <alias name=3D'pci.5'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x4'/>
    </controller>
    <controller type=3D'pci' index=3D'6' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'6' port=3D'0xd'/>
      <alias name=3D'pci.6'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x5'/>
    </controller>
    <controller type=3D'pci' index=3D'7' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'7' port=3D'0xe'/>
      <alias name=3D'pci.7'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x6'/>
    </controller>
    <controller type=3D'pci' index=3D'8' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'8' port=3D'0xf'/>
      <alias name=3D'pci.8'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x7'/>
    </controller>
    <controller type=3D'pci' index=3D'9' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'9' port=3D'0x10'/>
      <alias name=3D'pci.9'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0' multifunction=3D'on'/>
    </controller>
    <controller type=3D'pci' index=3D'10' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'10' port=3D'0x11'/>
      <alias name=3D'pci.10'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x1'/>
    </controller>
    <controller type=3D'pci' index=3D'11' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'11' port=3D'0x12'/>
      <alias name=3D'pci.11'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x2'/>
    </controller>
    <controller type=3D'pci' index=3D'12' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'12' port=3D'0x13'/>
      <alias name=3D'pci.12'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x3'/>
    </controller>
    <controller type=3D'pci' index=3D'13' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'13' port=3D'0x14'/>
      <alias name=3D'pci.13'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x4'/>
    </controller>
    <controller type=3D'pci' index=3D'14' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'14' port=3D'0x15'/>
      <alias name=3D'pci.14'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x5'/>
    </controller>
    <controller type=3D'pci' index=3D'15' model=3D'pcie-root-port'>
      <model name=3D'pcie-root-port'/>
      <target chassis=3D'15' port=3D'0x16'/>
      <alias name=3D'pci.15'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x6'/>
    </controller>
    <controller type=3D'virtio-serial' index=3D'0'>
      <alias name=3D'virtio-serial0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x03' slot=3D'0x00' =
function=3D'0x0'/>
    </controller>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:37:6a:d5'/>
      <source network=3D'default' bridge=3D'virbr0'/>
      <target dev=3D'vnet0'/>
      <model type=3D'virtio'/>
      <alias name=3D'net0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x01' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:db:35:b3'/>
      <source network=3D'default' bridge=3D'virbr0'/>
      <target dev=3D'vnet1'/>
      <model type=3D'virtio'/>
      <alias name=3D'net1'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x05' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:8a:54:6c'/>
      <source network=3D'default' bridge=3D'virbr0'/>
      <target dev=3D'vnet4'/>
      <model type=3D'virtio'/>
      <alias name=3D'net2'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x06' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:04:2b:e4'/>
      <source network=3D'default' bridge=3D'virbr0'/>
      <target dev=3D'vnet5'/>
      <model type=3D'virtio'/>
      <alias name=3D'net3'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x07' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:6b:fc:ac'/>
      <source network=3D'default' bridge=3D'virbr0'/>
      <target dev=3D'vnet6'/>
      <model type=3D'virtio'/>
      <alias name=3D'net4'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x08' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:d4:b0:e2'/>
      <source network=3D'default' bridge=3D'virbr0'/>
      <target dev=3D'vnet7'/>
      <model type=3D'virtio'/>
      <alias name=3D'net5'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x09' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:52:2f:cc'/>
      <source network=3D'default' bridge=3D'virbr0'/>
      <target dev=3D'vnet8'/>
      <model type=3D'virtio'/>
      <alias name=3D'net6'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x0a' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:0d:b1:bb'/>
      <source network=3D'default' bridge=3D'virbr0'/>
      <target dev=3D'vnet9'/>
      <model type=3D'virtio'/>
      <alias name=3D'net7'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x0b' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:8a:a5:69'/>
      <source network=3D'default' bridge=3D'virbr0'/>
      <target dev=3D'vnet10'/>
      <model type=3D'virtio'/>
      <alias name=3D'net8'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x0c' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:ad:60:b1'/>
      <source network=3D'default' bridge=3D'virbr0'/>
      <target dev=3D'vnet11'/>
      <model type=3D'virtio'/>
      <alias name=3D'net9'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x0d' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:e3:9a:70'/>
      <source network=3D'default' bridge=3D'virbr0'/>
      <target dev=3D'vnet12'/>
      <model type=3D'virtio'/>
      <alias name=3D'net10'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x0e' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <interface type=3D'network'>
      <mac address=3D'52:54:00:56:58:b3'/>
      <source network=3D'default' bridge=3D'virbr0'/>
      <target dev=3D'vnet13'/>
      <model type=3D'virtio'/>
      <alias name=3D'net11'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x0f' slot=3D'0x00' =
function=3D'0x0'/>
    </interface>
    <serial type=3D'pty'>
      <source path=3D'/dev/pts/4'/>
      <target port=3D'0'/>
      <alias name=3D'serial0'/>
    </serial>
    <console type=3D'pty' tty=3D'/dev/pts/4'>
      <source path=3D'/dev/pts/4'/>
      <target type=3D'serial' port=3D'0'/>
      <alias name=3D'serial0'/>
    </console>
    <channel type=3D'unix'>
      <source mode=3D'bind' path=3D'/var/lib/libvirt/qemu/channel/target/=
domain-57-pci/org.qemu.guest_agent.0'/>
      <target type=3D'virtio' name=3D'org.qemu.guest_agent.0' state=3D'di=
sconnected'/>
      <alias name=3D'channel0'/>
      <address type=3D'virtio-serial' controller=3D'0' bus=3D'0' port=3D'=
1'/>
    </channel>
  </devices>
  <seclabel type=3D'none' model=3D'none'/>
  <seclabel type=3D'dynamic' model=3D'dac' relabel=3D'yes'>
    <label>+64055:+64055</label>
    <imagelabel>+64055:+64055</imagelabel>
  </seclabel>
</domain>


--------------4F9A9E6BE53CFBECE917A7F9
Content-Type: text/plain; charset=UTF-8;
 name="pci-32.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pci-32.txt"

L3Vzci9iaW4vcWVtdS1zeXN0ZW0tYWFyY2g2NCAtbmFtZSBndWVzdD1wY2ksZGVidWctdGhy
ZWFkcz1vbiAtUyAtb2JqZWN0IHNlY3JldCxpZD1tYXN0ZXJLZXkwLGZvcm1hdD1yYXcsZmls
ZT0vdmFyL2xpYi9saWJ2aXJ0L3FlbXUvZG9tYWluLTEwOC1wY2kvbWFzdGVyLWtleS5hZXMg
LW1hY2hpbmUgdmlydC0yLjksYWNjZWw9a3ZtLHVzYj1vZmYsZHVtcC1ndWVzdC1jb3JlPW9m
ZiAtY3B1IGhvc3QgLWRyaXZlIGZpbGU9L3Vzci9zaGFyZS9BQVZNRi9BQVZNRl9DT0RFLmZk
LGlmPXBmbGFzaCxmb3JtYXQ9cmF3LHVuaXQ9MCxyZWFkb25seT1vbiAtZHJpdmUgZmlsZT0v
dmFyL2xpYi9saWJ2aXJ0L3FlbXUvbnZyYW0vcGNpX1ZBUlMuZmQsaWY9cGZsYXNoLGZvcm1h
dD1yYXcsdW5pdD0xIC1tIDEyMDI0IC1yZWFsdGltZSBtbG9jaz1vZmYgLXNtcCA1LHNvY2tl
dHM9NSxjb3Jlcz0xLHRocmVhZHM9MSAtdXVpZCA1MzYxZGQyNy1iZGMxLTQxNzgtYjI2Zi0z
MjNiNDAwOWIyMjYgLWRpc3BsYXkgbm9uZSAtbm8tdXNlci1jb25maWcgLW5vZGVmYXVsdHMg
LWNoYXJkZXYgc29ja2V0LGlkPWNoYXJtb25pdG9yLHBhdGg9L3Zhci9saWIvbGlidmlydC9x
ZW11L2RvbWFpbi0xMDgtcGNpL21vbml0b3Iuc29jayxzZXJ2ZXIsbm93YWl0IC1tb24gY2hh
cmRldj1jaGFybW9uaXRvcixpZD1tb25pdG9yLG1vZGU9Y29udHJvbCAtcnRjIGJhc2U9dXRj
IC1uby1zaHV0ZG93biAtYm9vdCBzdHJpY3Q9b24gLWRldmljZSBwY2llLXJvb3QtcG9ydCxw
b3J0PTB4OCxjaGFzc2lzPTEsaWQ9cGNpLjEsYnVzPXBjaWUuMCxtdWx0aWZ1bmN0aW9uPW9u
LGFkZHI9MHgxIC1kZXZpY2UgcGNpZS1yb290LXBvcnQscG9ydD0weDksY2hhc3Npcz0yLGlk
PXBjaS4yLGJ1cz1wY2llLjAsYWRkcj0weDEuMHgxIC1kZXZpY2UgcGNpZS1yb290LXBvcnQs
cG9ydD0weGEsY2hhc3Npcz0zLGlkPXBjaS4zLGJ1cz1wY2llLjAsYWRkcj0weDEuMHgyIC1k
ZXZpY2UgcGNpZS1yb290LXBvcnQscG9ydD0weGIsY2hhc3Npcz00LGlkPXBjaS40LGJ1cz1w
Y2llLjAsYWRkcj0weDEuMHgzIC1kZXZpY2UgcGNpZS1yb290LXBvcnQscG9ydD0weGMsY2hh
c3Npcz01LGlkPXBjaS41LGJ1cz1wY2llLjAsYWRkcj0weDEuMHg0IC1kZXZpY2UgcGNpZS1y
b290LXBvcnQscG9ydD0weGQsY2hhc3Npcz02LGlkPXBjaS42LGJ1cz1wY2llLjAsYWRkcj0w
eDEuMHg1IC1kZXZpY2UgcGNpZS1yb290LXBvcnQscG9ydD0weGUsY2hhc3Npcz03LGlkPXBj
aS43LGJ1cz1wY2llLjAsYWRkcj0weDEuMHg2IC1kZXZpY2UgcGNpZS1yb290LXBvcnQscG9y
dD0weGYsY2hhc3Npcz04LGlkPXBjaS44LGJ1cz1wY2llLjAsYWRkcj0weDEuMHg3IC1kZXZp
Y2UgcGNpZS1yb290LXBvcnQscG9ydD0weDEwLGNoYXNzaXM9OSxpZD1wY2kuOSxidXM9cGNp
ZS4wLG11bHRpZnVuY3Rpb249b24sYWRkcj0weDIgLWRldmljZSBwY2llLXJvb3QtcG9ydCxw
b3J0PTB4MTEsY2hhc3Npcz0xMCxpZD1wY2kuMTAsYnVzPXBjaWUuMCxhZGRyPTB4Mi4weDEg
LWRldmljZSBwY2llLXJvb3QtcG9ydCxwb3J0PTB4MTIsY2hhc3Npcz0xMSxpZD1wY2kuMTEs
YnVzPXBjaWUuMCxhZGRyPTB4Mi4weDIgLWRldmljZSBwY2llLXJvb3QtcG9ydCxwb3J0PTB4
MTMsY2hhc3Npcz0xMixpZD1wY2kuMTIsYnVzPXBjaWUuMCxhZGRyPTB4Mi4weDMgLWRldmlj
ZSBwY2llLXJvb3QtcG9ydCxwb3J0PTB4MTQsY2hhc3Npcz0xMyxpZD1wY2kuMTMsYnVzPXBj
aWUuMCxhZGRyPTB4Mi4weDQgLWRldmljZSBwY2llLXJvb3QtcG9ydCxwb3J0PTB4MTUsY2hh
c3Npcz0xNCxpZD1wY2kuMTQsYnVzPXBjaWUuMCxhZGRyPTB4Mi4weDUgLWRldmljZSBwY2ll
LXJvb3QtcG9ydCxwb3J0PTB4MTYsY2hhc3Npcz0xNSxpZD1wY2kuMTUsYnVzPXBjaWUuMCxh
ZGRyPTB4Mi4weDYgLWRldmljZSBwY2llLXJvb3QtcG9ydCxwb3J0PTB4MTcsY2hhc3Npcz0x
NixpZD1wY2kuMTYsYnVzPXBjaWUuMCxhZGRyPTB4Mi4weDcgLWRldmljZSB2aXJ0aW8tc2Nz
aS1wY2ksaWQ9c2NzaTAsYnVzPXBjaS4yLGFkZHI9MHgwIC1kZXZpY2UgdmlydGlvLXNlcmlh
bC1wY2ksaWQ9dmlydGlvLXNlcmlhbDAsYnVzPXBjaS4zLGFkZHI9MHgwIC1kcml2ZSBmaWxl
PS9ob21lL2xpbmFyby92aXJ0L2RlYmlhbi0zMC5xY293Mixmb3JtYXQ9cWNvdzIsaWY9bm9u
ZSxpZD1kcml2ZS12aXJ0aW8tZGlzazAgLWRldmljZSB2aXJ0aW8tYmxrLXBjaSxzY3NpPW9m
ZixidXM9cGNpLjQsYWRkcj0weDAsZHJpdmU9ZHJpdmUtdmlydGlvLWRpc2swLGlkPXZpcnRp
by1kaXNrMCxib290aW5kZXg9MSAtbmV0ZGV2IHRhcCxmZD0yNyxpZD1ob3N0bmV0MCx2aG9z
dD1vbix2aG9zdGZkPTI5IC1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PWhvc3RuZXQw
LGlkPW5ldDAsbWFjPTUyOjU0OjAwOjM3OjZhOmQ1LGJ1cz1wY2kuMSxhZGRyPTB4MCAtbmV0
ZGV2IHRhcCxmZD0zMCxpZD1ob3N0bmV0MSx2aG9zdD1vbix2aG9zdGZkPTMxIC1kZXZpY2Ug
dmlydGlvLW5ldC1wY2ksbmV0ZGV2PWhvc3RuZXQxLGlkPW5ldDEsbWFjPTUyOjU0OjAwOmRi
OjM1OmIzLGJ1cz1wY2kuNSxhZGRyPTB4MCAtbmV0ZGV2IHRhcCxmZD0zMixpZD1ob3N0bmV0
Mix2aG9zdD1vbix2aG9zdGZkPTMzIC1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PWhv
c3RuZXQyLGlkPW5ldDIsbWFjPTUyOjU0OjAwOjhhOjU0OjZjLGJ1cz1wY2kuNixhZGRyPTB4
MCAtbmV0ZGV2IHRhcCxmZD0zNCxpZD1ob3N0bmV0Myx2aG9zdD1vbix2aG9zdGZkPTM1IC1k
ZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PWhvc3RuZXQzLGlkPW5ldDMsbWFjPTUyOjU0
OjAwOjA0OjJiOmU0LGJ1cz1wY2kuNyxhZGRyPTB4MCAtbmV0ZGV2IHRhcCxmZD0zNixpZD1o
b3N0bmV0NCx2aG9zdD1vbix2aG9zdGZkPTM3IC1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0
ZGV2PWhvc3RuZXQ0LGlkPW5ldDQsbWFjPTUyOjU0OjAwOjZiOmZjOmFjLGJ1cz1wY2kuOCxh
ZGRyPTB4MCAtbmV0ZGV2IHRhcCxmZD0zOCxpZD1ob3N0bmV0NSx2aG9zdD1vbix2aG9zdGZk
PTM5IC1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PWhvc3RuZXQ1LGlkPW5ldDUsbWFj
PTUyOjU0OjAwOmQ0OmIwOmUyLGJ1cz1wY2kuOSxhZGRyPTB4MCAtbmV0ZGV2IHRhcCxmZD00
MCxpZD1ob3N0bmV0Nix2aG9zdD1vbix2aG9zdGZkPTQxIC1kZXZpY2UgdmlydGlvLW5ldC1w
Y2ksbmV0ZGV2PWhvc3RuZXQ2LGlkPW5ldDYsbWFjPTUyOjU0OjAwOjUyOjJmOmNjLGJ1cz1w
Y2kuMTAsYWRkcj0weDAgLW5ldGRldiB0YXAsZmQ9NDIsaWQ9aG9zdG5ldDcsdmhvc3Q9b24s
dmhvc3RmZD00MyAtZGV2aWNlIHZpcnRpby1uZXQtcGNpLG5ldGRldj1ob3N0bmV0NyxpZD1u
ZXQ3LG1hYz01Mjo1NDowMDowZDpiMTpiYixidXM9cGNpLjExLGFkZHI9MHgwIC1uZXRkZXYg
dGFwLGZkPTQ0LGlkPWhvc3RuZXQ4LHZob3N0PW9uLHZob3N0ZmQ9NDUgLWRldmljZSB2aXJ0
aW8tbmV0LXBjaSxuZXRkZXY9aG9zdG5ldDgsaWQ9bmV0OCxtYWM9NTI6NTQ6MDA6OGE6YTU6
NjksYnVzPXBjaS4xMixhZGRyPTB4MCAtbmV0ZGV2IHRhcCxmZD00NixpZD1ob3N0bmV0OSx2
aG9zdD1vbix2aG9zdGZkPTQ3IC1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PWhvc3Ru
ZXQ5LGlkPW5ldDksbWFjPTUyOjU0OjAwOmFkOjYwOmIxLGJ1cz1wY2kuMTMsYWRkcj0weDAg
LW5ldGRldiB0YXAsZmQ9NDgsaWQ9aG9zdG5ldDEwLHZob3N0PW9uLHZob3N0ZmQ9NDkgLWRl
dmljZSB2aXJ0aW8tbmV0LXBjaSxuZXRkZXY9aG9zdG5ldDEwLGlkPW5ldDEwLG1hYz01Mjo1
NDowMDplMzo5YTo3MCxidXM9cGNpLjE0LGFkZHI9MHgwIC1uZXRkZXYgdGFwLGZkPTUwLGlk
PWhvc3RuZXQxMSx2aG9zdD1vbix2aG9zdGZkPTUxIC1kZXZpY2UgdmlydGlvLW5ldC1wY2ks
bmV0ZGV2PWhvc3RuZXQxMSxpZD1uZXQxMSxtYWM9NTI6NTQ6MDA6NTY6NTg6YjMsYnVzPXBj
aS4xNSxhZGRyPTB4MCAtY2hhcmRldiBwdHksaWQ9Y2hhcnNlcmlhbDAgLXNlcmlhbCBjaGFy
ZGV2OmNoYXJzZXJpYWwwIC1jaGFyZGV2IHNvY2tldCxpZD1jaGFyY2hhbm5lbDAscGF0aD0v
dmFyL2xpYi9saWJ2aXJ0L3FlbXUvY2hhbm5lbC90YXJnZXQvZG9tYWluLTEwOC1wY2kvb3Jn
LnFlbXUuZ3Vlc3RfYWdlbnQuMCxzZXJ2ZXIsbm93YWl0IC1kZXZpY2UgdmlydHNlcmlhbHBv
cnQsYnVzPXZpcnRpby1zZXJpYWwwLjAsbnI9MSxjaGFyZGV2PWNoYXJjaGFubmVsMCxpZD1j
aGFubmVsMCxuYW1lPW9yZy5xZW11Lmd1ZXN0X2FnZW50LjAgLW1zZyB0aW1lc3RhbXA9b24K

--------------4F9A9E6BE53CFBECE917A7F9
Content-Type: text/plain; charset=UTF-8;
 name="pci-31.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pci-31.txt"

L3Vzci9iaW4vcWVtdS1zeXN0ZW0tYWFyY2g2NCAtbmFtZSBndWVzdD1wY2ksZGVidWctdGhy
ZWFkcz1vbiAtUyAtb2JqZWN0IHNlY3JldCxpZD1tYXN0ZXJLZXkwLGZvcm1hdD1yYXcsZmls
ZT0vdmFyL2xpYi9saWJ2aXJ0L3FlbXUvZG9tYWluLTEwNy1wY2kvbWFzdGVyLWtleS5hZXMg
LW1hY2hpbmUgdmlydC0yLjksYWNjZWw9a3ZtLHVzYj1vZmYsZHVtcC1ndWVzdC1jb3JlPW9m
ZiAtY3B1IGhvc3QgLWRyaXZlIGZpbGU9L3Vzci9zaGFyZS9BQVZNRi9BQVZNRl9DT0RFLmZk
LGlmPXBmbGFzaCxmb3JtYXQ9cmF3LHVuaXQ9MCxyZWFkb25seT1vbiAtZHJpdmUgZmlsZT0v
dmFyL2xpYi9saWJ2aXJ0L3FlbXUvbnZyYW0vcGNpX1ZBUlMuZmQsaWY9cGZsYXNoLGZvcm1h
dD1yYXcsdW5pdD0xIC1tIDEyMDI0IC1yZWFsdGltZSBtbG9jaz1vZmYgLXNtcCA1LHNvY2tl
dHM9NSxjb3Jlcz0xLHRocmVhZHM9MSAtdXVpZCA1MzYxZGQyNy1iZGMxLTQxNzgtYjI2Zi0z
MjNiNDAwOWIyMjYgLWRpc3BsYXkgbm9uZSAtbm8tdXNlci1jb25maWcgLW5vZGVmYXVsdHMg
LWNoYXJkZXYgc29ja2V0LGlkPWNoYXJtb25pdG9yLHBhdGg9L3Zhci9saWIvbGlidmlydC9x
ZW11L2RvbWFpbi0xMDctcGNpL21vbml0b3Iuc29jayxzZXJ2ZXIsbm93YWl0IC1tb24gY2hh
cmRldj1jaGFybW9uaXRvcixpZD1tb25pdG9yLG1vZGU9Y29udHJvbCAtcnRjIGJhc2U9dXRj
IC1uby1zaHV0ZG93biAtYm9vdCBzdHJpY3Q9b24gLWRldmljZSBwY2llLXJvb3QtcG9ydCxw
b3J0PTB4OCxjaGFzc2lzPTEsaWQ9cGNpLjEsYnVzPXBjaWUuMCxtdWx0aWZ1bmN0aW9uPW9u
LGFkZHI9MHgxIC1kZXZpY2UgcGNpZS1yb290LXBvcnQscG9ydD0weDksY2hhc3Npcz0yLGlk
PXBjaS4yLGJ1cz1wY2llLjAsYWRkcj0weDEuMHgxIC1kZXZpY2UgcGNpZS1yb290LXBvcnQs
cG9ydD0weGEsY2hhc3Npcz0zLGlkPXBjaS4zLGJ1cz1wY2llLjAsYWRkcj0weDEuMHgyIC1k
ZXZpY2UgcGNpZS1yb290LXBvcnQscG9ydD0weGIsY2hhc3Npcz00LGlkPXBjaS40LGJ1cz1w
Y2llLjAsYWRkcj0weDEuMHgzIC1kZXZpY2UgcGNpZS1yb290LXBvcnQscG9ydD0weGMsY2hh
c3Npcz01LGlkPXBjaS41LGJ1cz1wY2llLjAsYWRkcj0weDEuMHg0IC1kZXZpY2UgcGNpZS1y
b290LXBvcnQscG9ydD0weGQsY2hhc3Npcz02LGlkPXBjaS42LGJ1cz1wY2llLjAsYWRkcj0w
eDEuMHg1IC1kZXZpY2UgcGNpZS1yb290LXBvcnQscG9ydD0weGUsY2hhc3Npcz03LGlkPXBj
aS43LGJ1cz1wY2llLjAsYWRkcj0weDEuMHg2IC1kZXZpY2UgcGNpZS1yb290LXBvcnQscG9y
dD0weGYsY2hhc3Npcz04LGlkPXBjaS44LGJ1cz1wY2llLjAsYWRkcj0weDEuMHg3IC1kZXZp
Y2UgcGNpZS1yb290LXBvcnQscG9ydD0weDEwLGNoYXNzaXM9OSxpZD1wY2kuOSxidXM9cGNp
ZS4wLG11bHRpZnVuY3Rpb249b24sYWRkcj0weDIgLWRldmljZSBwY2llLXJvb3QtcG9ydCxw
b3J0PTB4MTEsY2hhc3Npcz0xMCxpZD1wY2kuMTAsYnVzPXBjaWUuMCxhZGRyPTB4Mi4weDEg
LWRldmljZSBwY2llLXJvb3QtcG9ydCxwb3J0PTB4MTIsY2hhc3Npcz0xMSxpZD1wY2kuMTEs
YnVzPXBjaWUuMCxhZGRyPTB4Mi4weDIgLWRldmljZSBwY2llLXJvb3QtcG9ydCxwb3J0PTB4
MTMsY2hhc3Npcz0xMixpZD1wY2kuMTIsYnVzPXBjaWUuMCxhZGRyPTB4Mi4weDMgLWRldmlj
ZSBwY2llLXJvb3QtcG9ydCxwb3J0PTB4MTQsY2hhc3Npcz0xMyxpZD1wY2kuMTMsYnVzPXBj
aWUuMCxhZGRyPTB4Mi4weDQgLWRldmljZSBwY2llLXJvb3QtcG9ydCxwb3J0PTB4MTUsY2hh
c3Npcz0xNCxpZD1wY2kuMTQsYnVzPXBjaWUuMCxhZGRyPTB4Mi4weDUgLWRldmljZSBwY2ll
LXJvb3QtcG9ydCxwb3J0PTB4MTYsY2hhc3Npcz0xNSxpZD1wY2kuMTUsYnVzPXBjaWUuMCxh
ZGRyPTB4Mi4weDYgLWRldmljZSB2aXJ0aW8tc2NzaS1wY2ksaWQ9c2NzaTAsYnVzPXBjaS4y
LGFkZHI9MHgwIC1kZXZpY2UgdmlydGlvLXNlcmlhbC1wY2ksaWQ9dmlydGlvLXNlcmlhbDAs
YnVzPXBjaS4zLGFkZHI9MHgwIC1kcml2ZSBmaWxlPS9ob21lL2xpbmFyby92aXJ0L2RlYmlh
bi0zMC5xY293Mixmb3JtYXQ9cWNvdzIsaWY9bm9uZSxpZD1kcml2ZS12aXJ0aW8tZGlzazAg
LWRldmljZSB2aXJ0aW8tYmxrLXBjaSxzY3NpPW9mZixidXM9cGNpLjQsYWRkcj0weDAsZHJp
dmU9ZHJpdmUtdmlydGlvLWRpc2swLGlkPXZpcnRpby1kaXNrMCxib290aW5kZXg9MSAtbmV0
ZGV2IHRhcCxmZD0yOCxpZD1ob3N0bmV0MCx2aG9zdD1vbix2aG9zdGZkPTMwIC1kZXZpY2Ug
dmlydGlvLW5ldC1wY2ksbmV0ZGV2PWhvc3RuZXQwLGlkPW5ldDAsbWFjPTUyOjU0OjAwOjM3
OjZhOmQ1LGJ1cz1wY2kuMSxhZGRyPTB4MCAtbmV0ZGV2IHRhcCxmZD0zMSxpZD1ob3N0bmV0
MSx2aG9zdD1vbix2aG9zdGZkPTMyIC1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PWhv
c3RuZXQxLGlkPW5ldDEsbWFjPTUyOjU0OjAwOmRiOjM1OmIzLGJ1cz1wY2kuNSxhZGRyPTB4
MCAtbmV0ZGV2IHRhcCxmZD0zMyxpZD1ob3N0bmV0Mix2aG9zdD1vbix2aG9zdGZkPTM0IC1k
ZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PWhvc3RuZXQyLGlkPW5ldDIsbWFjPTUyOjU0
OjAwOjhhOjU0OjZjLGJ1cz1wY2kuNixhZGRyPTB4MCAtbmV0ZGV2IHRhcCxmZD0zNSxpZD1o
b3N0bmV0Myx2aG9zdD1vbix2aG9zdGZkPTM2IC1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0
ZGV2PWhvc3RuZXQzLGlkPW5ldDMsbWFjPTUyOjU0OjAwOjA0OjJiOmU0LGJ1cz1wY2kuNyxh
ZGRyPTB4MCAtbmV0ZGV2IHRhcCxmZD0zNyxpZD1ob3N0bmV0NCx2aG9zdD1vbix2aG9zdGZk
PTM4IC1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PWhvc3RuZXQ0LGlkPW5ldDQsbWFj
PTUyOjU0OjAwOjZiOmZjOmFjLGJ1cz1wY2kuOCxhZGRyPTB4MCAtbmV0ZGV2IHRhcCxmZD0z
OSxpZD1ob3N0bmV0NSx2aG9zdD1vbix2aG9zdGZkPTQwIC1kZXZpY2UgdmlydGlvLW5ldC1w
Y2ksbmV0ZGV2PWhvc3RuZXQ1LGlkPW5ldDUsbWFjPTUyOjU0OjAwOmQ0OmIwOmUyLGJ1cz1w
Y2kuOSxhZGRyPTB4MCAtbmV0ZGV2IHRhcCxmZD00MSxpZD1ob3N0bmV0Nix2aG9zdD1vbix2
aG9zdGZkPTQyIC1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PWhvc3RuZXQ2LGlkPW5l
dDYsbWFjPTUyOjU0OjAwOjUyOjJmOmNjLGJ1cz1wY2kuMTAsYWRkcj0weDAgLW5ldGRldiB0
YXAsZmQ9NDMsaWQ9aG9zdG5ldDcsdmhvc3Q9b24sdmhvc3RmZD00NCAtZGV2aWNlIHZpcnRp
by1uZXQtcGNpLG5ldGRldj1ob3N0bmV0NyxpZD1uZXQ3LG1hYz01Mjo1NDowMDowZDpiMTpi
YixidXM9cGNpLjExLGFkZHI9MHgwIC1uZXRkZXYgdGFwLGZkPTQ1LGlkPWhvc3RuZXQ4LHZo
b3N0PW9uLHZob3N0ZmQ9NDYgLWRldmljZSB2aXJ0aW8tbmV0LXBjaSxuZXRkZXY9aG9zdG5l
dDgsaWQ9bmV0OCxtYWM9NTI6NTQ6MDA6OGE6YTU6NjksYnVzPXBjaS4xMixhZGRyPTB4MCAt
bmV0ZGV2IHRhcCxmZD00NyxpZD1ob3N0bmV0OSx2aG9zdD1vbix2aG9zdGZkPTQ4IC1kZXZp
Y2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PWhvc3RuZXQ5LGlkPW5ldDksbWFjPTUyOjU0OjAw
OmFkOjYwOmIxLGJ1cz1wY2kuMTMsYWRkcj0weDAgLW5ldGRldiB0YXAsZmQ9NDksaWQ9aG9z
dG5ldDEwLHZob3N0PW9uLHZob3N0ZmQ9NTAgLWRldmljZSB2aXJ0aW8tbmV0LXBjaSxuZXRk
ZXY9aG9zdG5ldDEwLGlkPW5ldDEwLG1hYz01Mjo1NDowMDplMzo5YTo3MCxidXM9cGNpLjE0
LGFkZHI9MHgwIC1uZXRkZXYgdGFwLGZkPTUxLGlkPWhvc3RuZXQxMSx2aG9zdD1vbix2aG9z
dGZkPTUyIC1kZXZpY2UgdmlydGlvLW5ldC1wY2ksbmV0ZGV2PWhvc3RuZXQxMSxpZD1uZXQx
MSxtYWM9NTI6NTQ6MDA6NTY6NTg6YjMsYnVzPXBjaS4xNSxhZGRyPTB4MCAtY2hhcmRldiBw
dHksaWQ9Y2hhcnNlcmlhbDAgLXNlcmlhbCBjaGFyZGV2OmNoYXJzZXJpYWwwIC1jaGFyZGV2
IHNvY2tldCxpZD1jaGFyY2hhbm5lbDAscGF0aD0vdmFyL2xpYi9saWJ2aXJ0L3FlbXUvY2hh
bm5lbC90YXJnZXQvZG9tYWluLTEwNy1wY2kvb3JnLnFlbXUuZ3Vlc3RfYWdlbnQuMCxzZXJ2
ZXIsbm93YWl0IC1kZXZpY2UgdmlydHNlcmlhbHBvcnQsYnVzPXZpcnRpby1zZXJpYWwwLjAs
bnI9MSxjaGFyZGV2PWNoYXJjaGFubmVsMCxpZD1jaGFubmVsMCxuYW1lPW9yZy5xZW11Lmd1
ZXN0X2FnZW50LjAgLW1zZyB0aW1lc3RhbXA9b24K
--------------4F9A9E6BE53CFBECE917A7F9--
