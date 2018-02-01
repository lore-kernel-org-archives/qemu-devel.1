Received: from eggs.gnu.org ([2001:4830:134:3::10]:33723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1eh8Pt-0005DL-7h
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 01:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1eh8Pq-0003BU-4Z
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 01:32:13 -0500
Received: from prv3-mh.provo.novell.com ([137.65.250.26]:50945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1eh8Pp-00037f-Rp
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 01:32:10 -0500
References: <7833ad34-e056-c1f7-3a92-f7598dcf1467@suse.com>
	<20180129143331.4c883601@redhat.com>
From: Fei Li <fli@suse.com>
Message-ID: <3bd1c7a8-1718-fd3a-c861-b29016b38199@suse.com>
Date: Thu, 1 Feb 2018 14:31:45 +0800
MIME-Version: 1.0
In-Reply-To: <20180129143331.4c883601@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Can not hotplug device to pci-to-pci bridge using
 machine type older than 1.7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org


On 01/29/2018 09:33 PM, Igor Mammedov wrote:
> On Thu, 25 Jan 2018 16:01:39 +0800
> Fei Li <fli@suse.com> wrote:
>
>> Hi,
>>
>> After I hotplug a pci device to a pci2pci bridge (I use "pci.1") with
>> machine type 1.7 or older,
>> I can not see the pci device via `lspci` in the guest, but can see it
>> via `info qtree` in the hmp.
>> What's more, after I reboot the guest or hotplug another pci device to
>> pci.0, I can see the
>> previous hotplugged pci device via `lspci`.
>>
>> I use qemu v2.9.* (but machine type =1.7 or 1.6) and kernel 4.4.
>> I also do the test on self-build qemu v1.7, v1.6 and kernel 4.4, the
>> same phenomenon.
>> My qemu command line is as follows:
>> /usr/bin/qemu-system-x86_64 -m 1024 -machine
>> pc-i440fx-1.7,accel=kvm,kernel_irqchip=on -enable-kvm \
>> -smp sockets=1,cores=1,threads=1 -no-user-config -cpu Skylake-Client \
>> -name "pci-hp-qemu" -monitor telnet:127.0.0.1:8848,server,nowait \
>> -drive file=/opt/pcihp.qcow2,if=none,id=drive0,format=qcow2 \
>> -device virtio-blk-pci,drive=drive0,id=sata0,bootindex=1 \
>> -device pci-bridge,chassis_nr=1 \
>> -device virtio-net-pci,bus=pci.1,addr=01,id=netdev1 \
>> -device virtio-net-pci,bus=pci.0,addr=07,id=netdev2 \
>> -boot order=c
>> ...
>> (qemu) device_add virtio-net-pci,bus=pci.1,addr=12,id=netdev12
>>
>> Checking the qemu commit log, I see qemu v2.0 introduces the acpi based
>> pci hotplug
>> support and enables hotplug for pci devices behind pci2pci bridges
>> (upstream commit 99fd437d, 9e047b98 and db4728e6).
>>
>> I also checked qemu v2.9 code, and notice there's a judge: if
>> use_acpi_pci_hotplug is true (MT >= 2.0),
>> the code will update the hotplug_handler for *all buses* to PIIX4PMState
>> and uses
>> acpi_pcihp_device_plug_cb as the hp callback; else, for MT<=1.7, the
>> code will only update the
>> hotplug_handler for pci.0 and leave other buses continue to use its
>> default hp_handler: the
>> pci2pci bridge and default callback: pci_bridge_dev_hotplug_cb =>
>> shpc_device_hotplug_cb.
>> With the latter shpc* hotplug callback, hotplug a pci device to a
>> pci2pci bridge, like pci.1, I can
>> not be seen it in the guest via `lspci`.
>>
>> I am just wondering whether the qemu code does not support the shpc
>> hotplug to pci2pci bridge,
> Last time, it used to 'work' i.e. guest is notified but fails to init
> hotplugged device due to lack of IO resources.
>
> I'd suggest to start looking at issue from guest side and see what
> SHPC driver does to figure out if something in QEMU/firmware needs
> to be fixed.
Sorry for my late reply..
Thanks very much for giving me the clear direction. I am afraid I need more
time to locate the reason. Considering pcihp to pci2pci bridge with old MT
(<=1.7) is a rare scenario, I'd like to continue investigating as long 
as I have
enough free time. :)

Again, thanks for your kindly suggestions.
Fei

>
>> or the shpc spec does not support this.
>> Could someone shed some light on me? Thanks a lot!
>>
>> Have a nice day
>> Fei
>>
>
>
