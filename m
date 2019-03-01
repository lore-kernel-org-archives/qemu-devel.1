Received: from eggs.gnu.org ([209.51.188.92]:50748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gzmKx-0004WG-Bk
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gzmKv-0007i9-LL
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:52:43 -0500
References: <20190220224003.4420-1-eric.auger@redhat.com>
	<20190222172742.18c3835a@redhat.com>
	<c016024e-9f4b-8953-f492-8802675f7e22@redhat.com>
	<20190225104212.7d40e65e@Igors-MacBook-Pro.local>
	<70249194-349e-37f6-0e8d-dc50b39082b7@redhat.com>
	<cd283485-49a9-ddd1-a020-26110ee093be@redhat.com>
	<20190226175653.6ca2b6c4@Igors-MacBook-Pro.local>
	<c68ba5a2-0d24-c1ad-c2af-c957768abf9f@redhat.com>
	<20190227111025.4bb39cc7@redhat.com>
	<116c5375-0ff4-8f91-ac05-05a53e7fe206@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8392D6690@lhreml524-mbs.china.huawei.com>
	<20190227185123.314171ae@redhat.com>
	<f9518e2d-0e46-d25f-f9f5-809b21f744aa@redhat.com>
	<20190228150531.184f5974@redhat.com>
	<0ddadb92-cd96-c6c7-40f6-51663936c0b2@redhat.com>
	<20190301173300.33848636@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c8e22c4d-079b-b6e8-d7b2-61fbf7bc3239@redhat.com>
Date: Fri, 1 Mar 2019 18:52:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190301173300.33848636@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 00/17] ARM virt: Initial RAM expansion
 and PCDIMM/NVDIMM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "drjones@redhat.com" <drjones@redhat.com>, "david@redhat.com" <david@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Linuxarm <linuxarm@huawei.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>

Hi Igor,

On 3/1/19 5:33 PM, Igor Mammedov wrote:
> On Fri, 1 Mar 2019 15:18:14 +0100
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi Igor,
>>
>> [..]
>>
>>>    
>>>> What still remains fuzzy for me is in case of cold plug the mmio hotplug
>>>> control region part only is read (despite the slot selection of course)
>>>> and returns 0 for addr/size and also flags meaning the slot is not
>>>> enabled.  
>>> If you mean guest reads 0s than it looks broken, could you show
>>> trace log with mhp_* tracepoints enabled during a dimm hotplug.  
>>
>> Please find the traces + cmd line on x86
> I've thought that you where talking about pc-dimms, so here it goes:
> 
> nvdimm is not part of memory hotplug interface, they have their own
> mmio region through which they let guest read completely rebuilt
> NFIT table and their own GPE._E04 event handler.
> 
> you see 0's in trace because guest enumerates all PNP0C80 in DSDT
> to check if for any present pc-dimm for which mem hotplug interface
> reports 0s since there is none.
> 
> PS:
> In ACPI spec there is an example of NVDIMMs where they also have
> associated memory device (PNP0C80) and that it's somehow related
> to nvdimm hotplug, but it's not described in sufficient detail
> so I'm honestly do not know what to do with it. Hence QEMU doesn't
> have PNP0C80 counterpart for nvdimm. To me it looks more like
> a mistake in the spec, but that's a topic for another discussion.

Oh my bad. Indeed with PCDIMM I can see the actual addresses being read.

Thank you for the explanation!

Have a nice WE.

Eric

> 
> 
>> /qemu-system-x86_64 -M
>> q35,usb=off,dump-guest-core=off,kernel_irqchip=split,nvdimm -cpu
>> Haswell,-hle,-rtm -smp 4,sockets=4,cores=1,threads=1 -m
>> 16G,maxmem=32G,slots=4 -display none --enable-kvm -serial
>> tcp:localhost:4444,server -trace
>> events=/home/augere/UPSTREAM/qemu2/nvdimm.txt -qmp
>> unix:/home/augere/TEST/QEMU/qmp-sock,server,nowait -rtc
>> base=utc,driftfix=slew -global kvm-pit.lost_tick_policy=delay -realtime
>> mlock=off -no-hpet -no-shutdown -global PIIX4_PM.disable_s3=1 -global
>> PIIX4_PM.disable_s4=1 -boot strict=on -machine kernel_irqchip=split
>> -object
>> memory-backend-file,id=mem3,share,mem-path=/home/augere/TEST/QEMU/nv-dimm-3,size=2G,align=128M
>> -device nvdimm,memdev=mem3,id=dimm3,label-size=2M -object
>> memory-backend-file,id=mem4,share,mem-path=/home/augere/TEST/QEMU/nv-dimm-4,size=2G,align=128M
>> -device nvdimm,memdev=mem4,id=dimm4,label-size=2M -device
>> virtio-blk-pci,bus=pcie.0,scsi=off,drive=drv0,id=virtio-disk0,bootindex=1,werror=stop,rerror=stop
>> -drive
>> file=/home/augere/VM/IMAGES/x86_64-vm1-f28.raw,format=raw,if=none,cache=writethrough,id=drv0
>> -device virtio-net-pci,bus=pcie.0,netdev=nic0,mac=6a:f5:10:b1:3d:d2
>> -netdev
>> tap,id=nic0,script=/home/augere/TEST/SCRIPTS/qemu-ifup,downscript=/home/augere/TEST/SCRIPTS/qemu-ifdown,vhost=on
>> -net none -d guest_errors
>>
>> ******************************************************************
>> ioctl(TUNSETIFF): Device or resource busy
>> qemu-system-x86_64: -serial tcp:localhost:4444,server: info: QEMU
>> waiting for connection on: disconnected:tcp:::1:4444,server
>> qemu-system-x86_64: warning: global PIIX4_PM.disable_s3=1 not used
>> qemu-system-x86_64: warning: global PIIX4_PM.disable_s4=1 not used
>> 29556@1551449303.339464:mhp_acpi_write_slot set active slot: 0x0
>> 29556@1551449303.339496:mhp_acpi_read_addr_hi slot[0x0] addr hi: 0x0
>> 29556@1551449303.339505:mhp_acpi_read_addr_lo slot[0x0] addr lo: 0x0
>> 29556@1551449303.339512:mhp_acpi_read_size_hi slot[0x0] size hi: 0x0
>> 29556@1551449303.339520:mhp_acpi_read_size_lo slot[0x0] size lo: 0x0
>> 29556@1551449303.339563:mhp_acpi_write_slot set active slot: 0x0
>> 29556@1551449303.339574:mhp_acpi_read_flags slot[0x0] flags: 0x0
>> 29556@1551449303.339621:mhp_acpi_write_slot set active slot: 0x1
>> 29556@1551449303.339643:mhp_acpi_read_addr_hi slot[0x1] addr hi: 0x0
>> 29556@1551449303.339651:mhp_acpi_read_addr_lo slot[0x1] addr lo: 0x0
>> 29556@1551449303.339659:mhp_acpi_read_size_hi slot[0x1] size hi: 0x0
>> 29556@1551449303.339667:mhp_acpi_read_size_lo slot[0x1] size lo: 0x0
>> 29556@1551449303.339705:mhp_acpi_write_slot set active slot: 0x1
>> 29556@1551449303.339713:mhp_acpi_read_flags slot[0x1] flags: 0x0
>> 29556@1551449303.339757:mhp_acpi_write_slot set active slot: 0x2
>> 29556@1551449303.339779:mhp_acpi_read_addr_hi slot[0x2] addr hi: 0x0
>> 29556@1551449303.339787:mhp_acpi_read_addr_lo slot[0x2] addr lo: 0x0
>> 29556@1551449303.339796:mhp_acpi_read_size_hi slot[0x2] size hi: 0x0
>> 29556@1551449303.339804:mhp_acpi_read_size_lo slot[0x2] size lo: 0x0
>> 29556@1551449303.339861:mhp_acpi_write_slot set active slot: 0x2
>> 29556@1551449303.339870:mhp_acpi_read_flags slot[0x2] flags: 0x0
>> 29556@1551449303.339916:mhp_acpi_write_slot set active slot: 0x3
>> 29556@1551449303.339944:mhp_acpi_read_addr_hi slot[0x3] addr hi: 0x0
>> 29556@1551449303.339954:mhp_acpi_read_addr_lo slot[0x3] addr lo: 0x0
>> 29556@1551449303.339963:mhp_acpi_read_size_hi slot[0x3] size hi: 0x0
>> 29556@1551449303.339971:mhp_acpi_read_size_lo slot[0x3] size lo: 0x0
>> 29556@1551449303.340012:mhp_acpi_write_slot set active slot: 0x3
>> 29556@1551449303.340020:mhp_acpi_read_flags slot[0x3] flags: 0x0
>> 29556@1551449303.439695:mhp_acpi_write_slot set active slot: 0x0
>> 29556@1551449303.439713:mhp_acpi_read_flags slot[0x0] flags: 0x0
>> 29556@1551449303.439733:mhp_acpi_write_slot set active slot: 0x1
>> 29556@1551449303.439740:mhp_acpi_read_flags slot[0x1] flags: 0x0
>> 29556@1551449303.439759:mhp_acpi_write_slot set active slot: 0x2
>> 29556@1551449303.439767:mhp_acpi_read_flags slot[0x2] flags: 0x0
>> 29556@1551449303.439793:mhp_acpi_write_slot set active slot: 0x3
>> 29556@1551449303.439801:mhp_acpi_read_flags slot[0x3] flags: 0x0
>> 29556@1551449303.539590:mhp_acpi_write_slot set active slot: 0x0
>> 29556@1551449303.539606:mhp_acpi_read_flags slot[0x0] flags: 0x0
>> 29556@1551449303.539627:mhp_acpi_write_slot set active slot: 0x1
>> 29556@1551449303.539634:mhp_acpi_read_flags slot[0x1] flags: 0x0
>> 29556@1551449303.539652:mhp_acpi_write_slot set active slot: 0x2
>> 29556@1551449303.539659:mhp_acpi_read_flags slot[0x2] flags: 0x0
>> 29556@1551449303.539677:mhp_acpi_write_slot set active slot: 0x3
>> 29556@1551449303.539684:mhp_acpi_read_flags slot[0x3] flags: 0x0
>>
>> That's the only traces I get until I get the login prompt.
>>
>> Thanks
>>
>> Eric
>>
>>
>>>   
>>>> So despite the slots are advertised as hotpluggable/enabled in
>>>> the SRAT; I am not sure for the OS it actually makes any difference
>>>> whether the DSDT definition blocks are described or not.  
>>> SRAT isn't used fro informing guests about amount of present RAM,
>>> it holds affinity information for present and possible RAM
>>>   
>>>> To be honest I am afraid this is too late to add those additional
>>>> features for 4.0 now. This is going to jeopardize the first preliminary
>>>> part which is the introduction of the new memory map, allowing the
>>>> expansion of the initial RAM and paving the way for device memory
>>>> introduction. So I think I am going to resend the first 10 patches in a
>>>> standalone series. And we can iterate on the PCDIMM/NVDIMM parts
>>>> independently.  
>>> sounds good to me, I'll try to review 1-10 today 
>>>    
>>>> Thanks
>>>>
>>>> Eric  
>>>>>
>>>>>     
>>>>>>
>>>>>> Thanks,
>>>>>> Shameer
>>>>>>    
>>>>>>> Then would remain the GED/GPIO actual integration.
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>> Eric      
>>>>>>>>      
>>>>>>>>> Also don't DIMM slots already make sense in DT mode. Usually we accept
>>>>>>>>> to add one feature in DT and then in ACPI. For instance we can benefit      
>>>>>>>> usually it doesn't conflict with each other (at least I'm not aware of it)
>>>>>>>> but I see a problem with in this case.
>>>>>>>>      
>>>>>>>>> from nvdimm in dt mode right? So, considering an incremental approach I
>>>>>>>>> would be in favour of keeping the DT nodes.      
>>>>>>>> I'd guess it is the same as for DIMMs, ACPI support for NVDIMMs is much
>>>>>>>> more versatile.
>>>>>>>>
>>>>>>>> I consider target application of arm/virt as a board that's used to
>>>>>>>> run in production generic ACPI capable guest in most use cases and
>>>>>>>> various DT only guests as secondary ones. It's hard to make
>>>>>>>> both usecases be happy with defaults (that's probably  one of the
>>>>>>>> reasons why 'sbsa' board is being added).
>>>>>>>>
>>>>>>>> So I'd give priority to ACPI based arm/virt versus DT when defaults are
>>>>>>>> considered.
>>>>>>>>      
>>>>>>>>> Thanks
>>>>>>>>>
>>>>>>>>> Eric      
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>      
>>>>>>>>      
>>>>>
>>>>>     
>>>   
> 
> 
