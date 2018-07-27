Received: from eggs.gnu.org ([2001:4830:134:3::10]:41355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fiy4A-0001RO-Lv
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fiy47-0007Be-Gt
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:25:38 -0400
Received: from 7.mo7.mail-out.ovh.net ([46.105.43.131]:46372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fiy47-0007Ao-7K
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 04:25:35 -0400
Received: from player759.ha.ovh.net (unknown [10.109.160.217])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 5FE21C1727
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 10:25:33 +0200 (CEST)
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<20180718061230.GE2102@umbus.fritz.box>
	<f6500bf1-792b-aba5-9deb-adc3303eeee7@kaod.org>
	<20180727053247.GK3694@umbus.fritz.box>
	<e642d9da57a167aeb5ae65566dd61317fcd37d2c.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d743b921-d1bc-2bc8-cbad-cd1a90d33850@kaod.org>
Date: Fri, 27 Jul 2018 10:25:22 +0200
MIME-Version: 1.0
In-Reply-To: <e642d9da57a167aeb5ae65566dd61317fcd37d2c.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 07/27/2018 10:08 AM, Benjamin Herrenschmidt wrote:
> On Fri, 2018-07-27 at 15:32 +1000, David Gibson wrote:
>>
>>>> What is this pci bridge representing?  I know PCI-e PHBs typically
>>>> have a pseudo P2P bridge right under them, but isn't that represnted
>>>> by the root complex above?
>>>
>>> This is the legacy pci bridge under the pcie bus.
>>
>> Ah, ok.  Didn't realise there was a vanilla PCI bridge built in.
> 
> There isn't. That should probably be created by the machine.

Each PHB creates a pci-bridge device and the PCI bus that comes with it. 
It makes things easier to define PCI devices. 

It is still quite complex ... Here is a sample :

qemu-system-ppc64 -m 2G -machine powernv \
  -cpu POWER8 -smp 2,cores=2,threads=1 -accel tcg,thread=multi \
  -kernel ./zImage.epapr -initrd ./rootfs.cpio.xz -bios ./skiboot.lid \
  \
  -device megasas,id=scsi0,bus=pci.0,addr=0x1 \
  -drive file=./rhel7-ppc64le.qcow2,if=none,id=drive-scsi0-0-0-0,format=qcow2,cache=none \
  -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0,bootindex=2 \
  \
  -device ich9-ahci,id=sata0,bus=pci.1,addr=0x1 \
  -drive file=./ubuntu-ppc64le.qcow2,if=none,id=drive0,format=qcow2,cache=none \
  -device ide-hd,bus=sata0.0,unit=0,drive=drive0,id=ide,bootindex=1 \
  -device e1000,netdev=net0,mac=C0:FF:EE:00:00:02,bus=pci.1,addr=0x2 \
  -netdev bridge,helper=/usr/libexec/qemu-bridge-helper,br=virbr0,id=net0 \
  -device nec-usb-xhci,bus=pci.1,addr=0x7 \


 


>>> Here is is the qdev hierarchy :
>>>
>>>   dev: pnv-phb3, id ""
>>>     index = 0 (0x0)
>>>     chip-id = 0 (0x0)
>>>     bus: phb3-root-bus
>>>       type pnv-phb3-root-bus
>>>       dev: pnv-phb3-rc, id ""
>>>         power_controller_present = true
>>>         chassis = 0 (0x0)
>>>         slot = 1 (0x1)
>>>         port = 0 (0x0)
>>>         aer_log_max = 8 (0x8)
>>>         addr = 00.0
>>>         romfile = ""
>>>         rombar = 1 (0x1)
>>>         multifunction = false
>>>         command_serr_enable = true
>>>         x-pcie-lnksta-dllla = true
>>>         x-pcie-extcap-init = true
>>>         class PCI bridge, addr 00:00.0, pci id 1014:03dc (sub 0000:0000)
>>>         bus: pcie.0
>>>           type PCIE
>>>           dev: pci-bridge, id ""
>>>             chassis_nr = 128 (0x80)
>>>             msi = "off"
>>>             shpc = false
>>>             addr = 00.0
>>>             romfile = ""
>>>             rombar = 1 (0x1)
>>>             multifunction = false
>>>             command_serr_enable = true
>>>             x-pcie-lnksta-dllla = true
>>>             x-pcie-extcap-init = true
>>>             class PCI bridge, addr 00:00.0, pci id 1b36:0001 (sub 0000:0000)
>>>             bus: pci.0
>>>               type PCI
>>>
>>> [ ... ]
>>>
>>>>> +static const PropertyInfo pnv_phb3_phb_id_propinfo = {
>>>>> +    .name = "irq",
>>>>> +    .get = pnv_phb3_get_phb_id,
>>>>> +    .set = pnv_phb3_set_phb_id,
>>>>> +};
>>>>
>>>> Can't you use a static DeviceProps style property for this, which is a
>>>> bit simpler?
>>>
>>> OK. We will address user creatable PHBs in some other way. Most
>>> certainly in the realize routine like you suggested.
>>>
>>> Thanks,
>>>
>>> C. 
>>>
>>
> 
