Received: from eggs.gnu.org ([209.51.188.92]:59214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1gyDH4-0002sE-65
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1gyDH2-0004IK-Do
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:14:14 -0500
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Date: Mon, 25 Feb 2019 10:13:57 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8392D4928@lhreml524-mbs.china.huawei.com>
References: <20190220224003.4420-1-eric.auger@redhat.com>
	<20190222172742.18c3835a@redhat.com>
	<c016024e-9f4b-8953-f492-8802675f7e22@redhat.com>
	<20190225104212.7d40e65e@Igors-MacBook-Pro.local>
In-Reply-To: <20190225104212.7d40e65e@Igors-MacBook-Pro.local>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Igor Mammedov <imammedo@redhat.com>, Auger Eric <eric.auger@redhat.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "drjones@redhat.com" <drjones@redhat.com>, "david@redhat.com" <david@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, Linuxarm <linuxarm@huawei.com>

Hi Igor,

> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: 25 February 2019 09:42
> To: Auger Eric <eric.auger@redhat.com>
> Cc: peter.maydell@linaro.org; drjones@redhat.com; david@redhat.com;
> qemu-devel@nongnu.org; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; dgilbert@redhat.com;
> qemu-arm@nongnu.org; david@gibson.dropbear.id.au;
> eric.auger.pro@gmail.com
> Subject: Re: [Qemu-devel] [PATCH v7 00/17] ARM virt: Initial RAM expansio=
n
> and PCDIMM/NVDIMM support
>=20
> On Fri, 22 Feb 2019 18:35:26 +0100
> Auger Eric <eric.auger@redhat.com> wrote:

[...]

> > I understand hotplug
> > would require extra modifications but I don't see anything else missing
> > for coldplug.
> > > Even though I've tried make mem hotplug ACPI parts not x86 specific,
> > > I'm afraid it might be tightly coupled with hotplug support.
> > > So here are 2 options make DSDT part work without hotplug or
> > > implement hotplug here. I think the former is just a waste of time
> > > and we should just add hotplug. It should take relatively minor effor=
t
> > > since you already implemented most of boiler plate here.
> >
> > Shameer sent an RFC series for supporting hotplug.
> >
> > [RFC PATCH 0/4] ARM virt: ACPI memory hotplug support
> > https://patchwork.kernel.org/cover/10783589/
> >
> > I tested PCDIMM hotplug (with ACPI) this afternoon and it seemed to be
> > OK, even after system_reset.
> >
> > Note the hotplug kernel support on ARM is very recent. I would prefer t=
o
> > dissociate both efforts if we want to get a chance making coldplug for
> > 4.0. Also we have an issue for NVDIMM since on reboot the guest does no=
t
> > boot properly.
> I guess we can merge implemetation that works on some kernel configs
> [DT based I'd guess], and add ACPI part later. Though that will be
> a bit of a mess as we do not version firmware parts (ACPI tables).
>=20
> > > As for how to implement ACPI HW part, I suggest to borrow GED
> > > device that NEMU guys trying to use instead of GPIO route,
> > > like we do now for ACPI_POWER_BUTTON_DEVICE to deliver event.
> > > So that it would be easier to share this with their virt-x86
> > > machine eventually.
> > Sounds like a different approach than the one initiated by Shameer?
> ARM boards were first to use ACPI hw-reduced profile so they picked up
> available back then GPIO based way to deliver hotplug event, later spec
> introduced Generic Event Device for that means to use with hw-reduced
> profile, which NEMU implemented[1], so I'd use that rather than ad-hoc
> GPIO mapping. I'd guess it will more compatible with various contemporary
> guests and we could reuse the same code for both x86/arm virt boards)
>=20
> 1) https://github.com/intel/nemu/blob/topic/virt-x86/hw/acpi/ged.c

Thanks for this suggestion. Looks like that is definitely a better way of h=
andling
ACPI events. I will take a look and use GED for the next revision of hotplu=
g=20
series.

Thanks,
Shameer

> > Thanks
> >
> > Eric
> > >
> > >
> > >> 3) Support of NV-DIMM [14 - 17]
> > > The same might be true for NUMA but I haven't dug this deep in to
> > > that part.
> > >
> > >>
> > >> 1) can be upstreamed before 2 and 2 can be upstreamed before 3.
> > >>
> > >> Work is ongoing to transform the whole memory as device memory.
> > >> However this move is not trivial and to me, is independent on
> > >> the improvements brought by this series:
> > >> - if we were to use DIMM for initial RAM, those DIMMs would use
> > >>   use slots. Although they would not be part of the ones provided
> > >>   using the ",slots" options, they are ACPI limited resources.
> > >> - DT and ACPI description needs to be reworked
> > >> - NUMA integration needs special care
> > >> - a special device memory object may be required to avoid consuming
> > >>   slots and easing the FW description.
> > >>
> > >> So I preferred to separate the concerns. This new implementation
> > >> based on device memory could be candidate for another virt
> > >> version.
> > >>
> > >> Best Regards
> > >>
> > >> Eric
> > >>
> > >> References:
> > >>
> > >> [0] [RFC v2 0/6] hw/arm: Add support for non-contiguous iova regions
> > >> http://patchwork.ozlabs.org/cover/914694/
> > >>
> > >> [1] [RFC PATCH 0/3] add nvdimm support on AArch64 virt platform
> > >> https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg04599.html
> > >>
> > >> This series can be found at:
> > >> https://github.com/eauger/qemu/tree/v3.1.0-dimm-v7
> > >>
> > >> History:
> > >>
> > >> v6 -> v7:
> > >> - Addressed Peter and Igor comments (exceptions sent my email)
> > >> - Fixed TCG case. Now device memory works also for TCG and vcpu
> > >>   pamax is checked
> > >> - See individual logs for more details
> > >>
> > >> v5 -> v6:
> > >> - mingw compilation issue fix
> > >> - kvm_arm_get_max_vm_phys_shift always returns the number of
> supported
> > >>   IPA bits
> > >> - new patch "hw/arm/virt: Rename highmem IO regions" that eases the
> review
> > >>   of "hw/arm/virt: Split the memory map description"
> > >> - "hw/arm/virt: Move memory map initialization into machvirt_init"
> > >>   squashed into the previous patch
> > >> - change alignment of IO regions beyond the RAM so that it matches t=
heir
> > >>   size
> > >>
> > >> v4 -> v5:
> > >> - change in the memory map
> > >> - see individual logs
> > >>
> > >> v3 -> v4:
> > >> - rebase on David's "pc-dimm: next bunch of cleanups" and
> > >>   "pc-dimm: pre_plug "slot" and "addr" assignment"
> > >> - kvm-type option not used anymore. We directly use
> > >>   maxram_size and ram_size machine fields to compute the
> > >>   MAX IPA range. Migration is naturally handled as CLI
> > >>   option are kept between source and destination. This was
> > >>   suggested by David.
> > >> - device_memory_start and device_memory_size not stored
> > >>   anymore in vms->bootinfo
> > >> - I did not take into account 2 Igor's comments: the one
> > >>   related to the refactoring of arm_load_dtb and the one
> > >>   related to the generation of the dtb after system_reset
> > >>   which would contain nodes of hotplugged devices (we do
> > >>   not support hotplug at this stage)
> > >> - check the end-user does not attempt to hotplug a device
> > >> - addition of "vl: Set machine ram_size, maxram_size and
> > >>   ram_slots earlier"
> > >>
> > >> v2 -> v3:
> > >> - fix pc_q35 and pc_piix compilation error
> > >> - kwangwoo's email being not valid anymore, remove his address
> > >>
> > >> v1 -> v2:
> > >> - kvm_get_max_vm_phys_shift moved in arch specific file
> > >> - addition of NVDIMM part
> > >> - single series
> > >> - rebase on David's refactoring
> > >>
> > >> v1:
> > >> - was "[RFC 0/6] KVM/ARM: Dynamic and larger GPA size"
> > >> - was "[RFC 0/5] ARM virt: Support PC-DIMM at 2TB"
> > >>
> > >> Best Regards
> > >>
> > >> Eric
> > >>
> > >>
> > >> Eric Auger (12):
> > >>   hw/arm/virt: Rename highmem IO regions
> > >>   hw/arm/virt: Split the memory map description
> > >>   hw/boards: Add a MachineState parameter to kvm_type callback
> > >>   kvm: add kvm_arm_get_max_vm_ipa_size
> > >>   vl: Set machine ram_size, maxram_size and ram_slots earlier
> > >>   hw/arm/virt: Dynamic memory map depending on RAM requirements
> > >>   hw/arm/virt: Implement kvm_type function for 4.0 machine
> > >>   hw/arm/virt: Bump the 255GB initial RAM limit
> > >>   hw/arm/virt: Add memory hotplug framework
> > >>   hw/arm/virt: Allocate device_memory
> > >>   hw/arm/boot: Expose the pmem nodes in the DT
> > >>   hw/arm/virt: Add nvdimm and nvdimm-persistence options
> > >>
> > >> Kwangwoo Lee (2):
> > >>   nvdimm: use configurable ACPI IO base and size
> > >>   hw/arm/virt: Add nvdimm hot-plug infrastructure
> > >>
> > >> Shameer Kolothum (3):
> > >>   hw/arm/boot: introduce fdt_add_memory_node helper
> > >>   hw/arm/boot: Expose the PC-DIMM nodes in the DT
> > >>   hw/arm/virt-acpi-build: Add PC-DIMM in SRAT
> > >>
> > >>  accel/kvm/kvm-all.c             |   2 +-
> > >>  default-configs/arm-softmmu.mak |   4 +
> > >>  hw/acpi/nvdimm.c                |  31 ++-
> > >>  hw/arm/boot.c                   | 136 ++++++++++--
> > >>  hw/arm/virt-acpi-build.c        |  23 +-
> > >>  hw/arm/virt.c                   | 364
> ++++++++++++++++++++++++++++----
> > >>  hw/i386/pc_piix.c               |   6 +-
> > >>  hw/i386/pc_q35.c                |   6 +-
> > >>  hw/ppc/mac_newworld.c           |   3 +-
> > >>  hw/ppc/mac_oldworld.c           |   2 +-
> > >>  hw/ppc/spapr.c                  |   2 +-
> > >>  include/hw/arm/virt.h           |  24 ++-
> > >>  include/hw/boards.h             |   5 +-
> > >>  include/hw/mem/nvdimm.h         |   4 +
> > >>  target/arm/kvm.c                |  10 +
> > >>  target/arm/kvm_arm.h            |  13 ++
> > >>  vl.c                            |   6 +-
> > >>  17 files changed, 556 insertions(+), 85 deletions(-)
> > >>
> > >
> > >
