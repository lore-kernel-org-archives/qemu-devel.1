Received: from eggs.gnu.org ([209.51.188.92]:53819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gywQk-0002Eb-IL
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 05:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gywAf-0005gn-BH
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 05:10:38 -0500
Date: Wed, 27 Feb 2019 11:10:25 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190227111025.4bb39cc7@redhat.com>
In-Reply-To: <c68ba5a2-0d24-c1ad-c2af-c957768abf9f@redhat.com>
References: <20190220224003.4420-1-eric.auger@redhat.com>
	<20190222172742.18c3835a@redhat.com>
	<c016024e-9f4b-8953-f492-8802675f7e22@redhat.com>
	<20190225104212.7d40e65e@Igors-MacBook-Pro.local>
	<70249194-349e-37f6-0e8d-dc50b39082b7@redhat.com>
	<cd283485-49a9-ddd1-a020-26110ee093be@redhat.com>
	<20190226175653.6ca2b6c4@Igors-MacBook-Pro.local>
	<c68ba5a2-0d24-c1ad-c2af-c957768abf9f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Auger Eric <eric.auger@redhat.com>
Cc: peter.maydell@linaro.org, drjones@redhat.com, david@redhat.com, dgilbert@redhat.com, shameerali.kolothum.thodi@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, eric.auger.pro@gmail.com, david@gibson.dropbear.id.au

On Tue, 26 Feb 2019 18:53:24 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Igor,
> 
> On 2/26/19 5:56 PM, Igor Mammedov wrote:
> > On Tue, 26 Feb 2019 14:11:58 +0100
> > Auger Eric <eric.auger@redhat.com> wrote:
> >   
> >> Hi Igor,
> >>
> >> On 2/26/19 9:40 AM, Auger Eric wrote:  
> >>> Hi Igor,
> >>>
> >>> On 2/25/19 10:42 AM, Igor Mammedov wrote:  
> >>>> On Fri, 22 Feb 2019 18:35:26 +0100
> >>>> Auger Eric <eric.auger@redhat.com> wrote:
> >>>>  
> >>>>> Hi Igor,
> >>>>>
> >>>>> On 2/22/19 5:27 PM, Igor Mammedov wrote:  
> >>>>>> On Wed, 20 Feb 2019 23:39:46 +0100
> >>>>>> Eric Auger <eric.auger@redhat.com> wrote:
> >>>>>>  
> >>>>>>> This series aims to bump the 255GB RAM limit in machvirt and to
> >>>>>>> support device memory in general, and especially PCDIMM/NVDIMM.
> >>>>>>>
> >>>>>>> In machvirt versions < 4.0, the initial RAM starts at 1GB and can
> >>>>>>> grow up to 255GB. From 256GB onwards we find IO regions such as the
> >>>>>>> additional GICv3 RDIST region, high PCIe ECAM region and high PCIe
> >>>>>>> MMIO region. The address map was 1TB large. This corresponded to
> >>>>>>> the max IPA capacity KVM was able to manage.
> >>>>>>>
> >>>>>>> Since 4.20, the host kernel is able to support a larger and dynamic
> >>>>>>> IPA range. So the guest physical address can go beyond the 1TB. The
> >>>>>>> max GPA size depends on the host kernel configuration and physical CPUs.
> >>>>>>>
> >>>>>>> In this series we use this feature and allow the RAM to grow without
> >>>>>>> any other limit than the one put by the host kernel.
> >>>>>>>
> >>>>>>> The RAM still starts at 1GB. First comes the initial ram (-m) of size
> >>>>>>> ram_size and then comes the device memory (,maxmem) of size
> >>>>>>> maxram_size - ram_size. The device memory is potentially hotpluggable
> >>>>>>> depending on the instantiated memory objects.
> >>>>>>>
> >>>>>>> IO regions previously located between 256GB and 1TB are moved after
> >>>>>>> the RAM. Their offset is dynamically computed, depends on ram_size
> >>>>>>> and maxram_size. Size alignment is enforced.
> >>>>>>>
> >>>>>>> In case maxmem value is inferior to 255GB, the legacy memory map
> >>>>>>> still is used. The change of memory map becomes effective from 4.0
> >>>>>>> onwards.
> >>>>>>>
> >>>>>>> As we keep the initial RAM at 1GB base address, we do not need to do
> >>>>>>> invasive changes in the EDK2 FW. It seems nobody is eager to do
> >>>>>>> that job at the moment.
> >>>>>>>
> >>>>>>> Device memory being put just after the initial RAM, it is possible
> >>>>>>> to get access to this feature while keeping a 1TB address map.
> >>>>>>>
> >>>>>>> This series reuses/rebases patches initially submitted by Shameer
> >>>>>>> in [1] and Kwangwoo in [2] for the PC-DIMM and NV-DIMM parts.
> >>>>>>>
> >>>>>>> Functionally, the series is split into 3 parts:
> >>>>>>> 1) bump of the initial RAM limit [1 - 9] and change in
> >>>>>>>    the memory map  
> >>>>>>  
> >>>>>>> 2) Support of PC-DIMM [10 - 13]  
> >>>>>> Is this part complete ACPI wise (for coldplug)? I haven't noticed
> >>>>>> DSDT AML here no E820 changes, so ACPI wise pc-dimm shouldn't be
> >>>>>> visible to the guest. It might be that DT is masking problem
> >>>>>> but well, that won't work on ACPI only guests.  
> >>>>>
> >>>>> guest /proc/meminfo or "lshw -class memory" reflects the amount of mem
> >>>>> added with the DIMM slots.  
> >>>> Question is how does it get there? Does it come from DT or from firmware
> >>>> via UEFI interfaces?
> >>>>  
> >>>>> So it looks fine to me. Isn't E820 a pure x86 matter?  
> >>>> sorry for misleading, I've meant is UEFI GetMemoryMap().
> >>>> On x86, I'm wary of adding PC-DIMMs to E802 which then gets exposed
> >>>> via UEFI GetMemoryMap() as guest kernel might start using it as normal
> >>>> memory early at boot and later put that memory into zone normal and hence
> >>>> make it non-hot-un-pluggable. The same concerns apply to DT based means
> >>>> of discovery.
> >>>> (That's guest issue but it's easy to workaround it not putting hotpluggable
> >>>> memory into UEFI GetMemoryMap() or DT and let DSDT describe it properly)
> >>>> That way memory doesn't get (ab)used by firmware or early boot kernel stages
> >>>> and doesn't get locked up.
> >>>>  
> >>>>> What else would you expect in the dsdt?  
> >>>> Memory device descriptions, look for code that adds PNP0C80 with _CRS
> >>>> describing memory ranges  
> >>>
> >>> OK thank you for the explanations. I will work on PNP0C80 addition then.
> >>> Does it mean that in ACPI mode we must not output DT hotplug memory
> >>> nodes or assuming that PNP0C80 is properly described, it will "override"
> >>> DT description?  
> >>
> >> After further investigations, I think the pieces you pointed out are
> >> added by Shameer's series, ie. through the build_memory_hotplug_aml()
> >> call. So I suggest we separate the concerns: this series brings support
> >> for DIMM coldplug. hotplug, including all the relevant ACPI structures
> >> will be added later on by Shameer.  
> > 
> > Maybe we should not put pc-dimms in DT for this series until it gets clear
> > if it doesn't conflict with ACPI in some way.  
> 
> I guess you mean removing the DT hotpluggable memory nodes only in ACPI
> mode? Otherwise you simply remove the DIMM feature, right?
Something like this so DT won't get in conflict with ACPI.
Only we don't have a switch for it something like, -machine fdt=on (with default off)
 
> I double checked and if you remove the hotpluggable memory DT nodes in
> ACPI mode:
> - you do not see the PCDIMM slots in guest /proc/meminfo anymore. So I
> guess you're right, if the DT nodes are available, that memory is
> considered as not unpluggable by the guest.
> - You can see the NVDIMM slots using ndctl list -u. You can mount a DAX
> system.
> 
> Hotplug/unplug is clearly not supported by this series and any attempt
> results in "memory hotplug is not supported". Is it really an issue if
> the guest does not consider DIMM slots as not hot-unpluggable memory? I
> am not even sure the guest kernel would support to unplug that memory.
> 
> In case we want all ACPI tables to be ready for making this memory seen
> as hot-unpluggable we need some Shameer's patches on top of this series.
May be we should push for this way (into 4.0), it's just a several patches
after all or even merge them in your series (I'd guess it would need to be
rebased on top of your latest work)
 
> Also don't DIMM slots already make sense in DT mode. Usually we accept
> to add one feature in DT and then in ACPI. For instance we can benefit
usually it doesn't conflict with each other (at least I'm not aware of it)
but I see a problem with in this case.

> from nvdimm in dt mode right? So, considering an incremental approach I
> would be in favour of keeping the DT nodes.
I'd guess it is the same as for DIMMs, ACPI support for NVDIMMs is much
more versatile.

I consider target application of arm/virt as a board that's used to
run in production generic ACPI capable guest in most use cases and
various DT only guests as secondary ones. It's hard to make
both usecases be happy with defaults (that's probably  one of the
reasons why 'sbsa' board is being added).

So I'd give priority to ACPI based arm/virt versus DT when defaults are
considered.

> Thanks
> 
> Eric
> > 
> > 
> > 
> >   
