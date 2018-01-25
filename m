Received: from eggs.gnu.org ([2001:4830:134:3::10]:56077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1eecU4-00014o-8c
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 03:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1eecTy-0005HJ-Vj
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 03:02:08 -0500
Received: from victor.provo.novell.com ([137.65.250.26]:42387
	helo=prv3-mh.provo.novell.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1eecTy-0005C1-MH
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 03:02:02 -0500
From: Fei Li <fli@suse.com>
Message-ID: <7833ad34-e056-c1f7-3a92-f7598dcf1467@suse.com>
Date: Thu, 25 Jan 2018 16:01:39 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] Can not hotplug device to pci-to-pci bridge using
 machine type older than 1.7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

After I hotplug a pci device to a pci2pci bridge (I use "pci.1") with 
machine type 1.7 or older,
I can not see the pci device via `lspci` in the guest, but can see it 
via `info qtree` in the hmp.
What's more, after I reboot the guest or hotplug another pci device to 
pci.0, I can see the
previous hotplugged pci device via `lspci`.

I use qemu v2.9.* (but machine type =1.7 or 1.6) and kernel 4.4.
I also do the test on self-build qemu v1.7, v1.6 and kernel 4.4, the 
same phenomenon.
My qemu command line is as follows:
/usr/bin/qemu-system-x86_64 -m 1024 -machine 
pc-i440fx-1.7,accel=kvm,kernel_irqchip=on -enable-kvm \
-smp sockets=1,cores=1,threads=1 -no-user-config -cpu Skylake-Client \
-name "pci-hp-qemu" -monitor telnet:127.0.0.1:8848,server,nowait \
-drive file=/opt/pcihp.qcow2,if=none,id=drive0,format=qcow2 \
-device virtio-blk-pci,drive=drive0,id=sata0,bootindex=1 \
-device pci-bridge,chassis_nr=1 \
-device virtio-net-pci,bus=pci.1,addr=01,id=netdev1 \
-device virtio-net-pci,bus=pci.0,addr=07,id=netdev2 \
-boot order=c
...
(qemu) device_add virtio-net-pci,bus=pci.1,addr=12,id=netdev12

Checking the qemu commit log, I see qemu v2.0 introduces the acpi based 
pci hotplug
support and enables hotplug for pci devices behind pci2pci bridges
(upstream commit 99fd437d, 9e047b98 and db4728e6).

I also checked qemu v2.9 code, and notice there's a judge: if 
use_acpi_pci_hotplug is true (MT >= 2.0),
the code will update the hotplug_handler for *all buses* to PIIX4PMState 
and uses
acpi_pcihp_device_plug_cb as the hp callback; else, for MT<=1.7, the 
code will only update the
hotplug_handler for pci.0 and leave other buses continue to use its 
default hp_handler: the
pci2pci bridge and default callback: pci_bridge_dev_hotplug_cb => 
shpc_device_hotplug_cb.
With the latter shpc* hotplug callback, hotplug a pci device to a 
pci2pci bridge, like pci.1, I can
not be seen it in the guest via `lspci`.

I am just wondering whether the qemu code does not support the shpc 
hotplug to pci2pci bridge,
or the shpc spec does not support this.
Could someone shed some light on me? Thanks a lot!

Have a nice day
Fei
