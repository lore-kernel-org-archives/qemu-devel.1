Received: from eggs.gnu.org ([2001:4830:134:3::10]:50897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cvOAh-0008DN-0j
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cvOAf-0007Kr-6b
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:06:55 -0400
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-4-ehabkost@redhat.com>
	<CAFEAcA_uRHZR0N-=h=eWsDKjZpN4csua1j++wLVfZbsNVpaH5Q@mail.gmail.com>
	<20170403201026.GJ1910@thinpad.lan.raisama.net>
	<f612e8c0-0f2a-d373-12c1-a20d6dccc7d0@suse.de>
	<20170403210030.GK1910@thinpad.lan.raisama.net>
	<522a3489-2e8c-b31a-c592-391fe5cf3b5f@suse.de>
	<40848cee-6a6b-75fa-c395-2ba4705d5bf0@redhat.com>
	<cab14f30-929d-c5ab-143e-07e63009f808@suse.de>
	<20170404125904.GQ1910@thinpad.lan.raisama.net>
From: Alexander Graf <agraf@suse.de>
Message-ID: <9d0341ca-6713-3d1f-4d91-0818957c28fb@suse.de>
Date: Tue, 4 Apr 2017 15:06:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170404125904.GQ1910@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 03/19] sysbus: Set user_creatable=false by
 default on TYPE_SYS_BUS_DEVICE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Scott Wood <scottwood@freescale.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Beniamino Galvani <b.galvani@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "Gabriel L . Somlo" <somlo@cmu.edu>, Igor Mammedov <imammedo@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>

On 04/04/2017 02:59 PM, Eduardo Habkost wrote:
> On Tue, Apr 04, 2017 at 09:02:28AM +0200, Alexander Graf wrote:
>>
>> On 04.04.17 08:58, Thomas Huth wrote:
>>> On 04.04.2017 08:53, Alexander Graf wrote:
>>>>
>>>> On 03.04.17 23:00, Eduardo Habkost wrote:
>>>>> On Mon, Apr 03, 2017 at 10:15:44PM +0200, Alexander Graf wrote:
>>>>>>
>>>>>> On 03.04.17 22:10, Eduardo Habkost wrote:
>>>>>>> On Mon, Apr 03, 2017 at 08:49:16PM +0100, Peter Maydell wrote:
>>>>>>>> On 1 April 2017 at 01:46, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>>>>>>> commit 33cd52b5d7b9adfd009e95f07e6c64dd88ae2a31 unset
>>>>>>>>> cannot_instantiate_with_device_add_yet in TYPE_SYSBUS, making
>>>>>>>>> all kinds of untested devices available to -device and
>>>>>>>>> device_add.
>>>>>>>>>
>>>>>>>>> The problem with that is: setting has_dynamic_sysbus on a
>>>>>>>>> machine-type lets it accept all the 288 sysbus device types we
>>>>>>>>> have in QEMU, and most of them were never meant to be used with
>>>>>>>>> -device. That's a lot of untested code.
>>>>>>>>>
>>>>>>>>> Fortunately today we have just a few has_dynamic_sysbus=1
>>>>>>>>> machines: virt, pc-q35-*, ppce500, and spapr.
>>>>>>>>>
>>>>>>>>> virt, ppce500, and spapr have extra checks to ensure just a few
>>>>>>>>> device types can be instantiated:
>>>>>>>>>
>>>>>>>>> * virt supports only TYPE_VFIO_CALXEDA_XGMAC, TYPE_VFIO_AMD_XGBE.
>>>>>>>>> * ppce500 supports only TYPE_ETSEC_COMMON.
>>>>>>>>> * spapr supports only TYPE_SPAPR_PCI_HOST_BRIDGE.
>>>>>>>>>
>>>>>>>>> q35 has no code to block unsupported sysbus devices, however, and
>>>>>>>>> accepts all device types. Fortunately, only the following 20
>>>>>>>>> device types are compiled into the qemu-system-x86_64 and
>>>>>>>>> qemu-system-i386 binaries:
>>>>>>>>>
>>>>>>>>> * allwinner-ahci
>>>>>>>>> * amd-iommu
>>>>>>>>> * cfi.pflash01
>>>>>>>>> * esp
>>>>>>>>> * fw_cfg_io
>>>>>>>>> * fw_cfg_mem
>>>>>>>>> * generic-sdhci
>>>>>>>>> * hpet
>>>>>>>>> * intel-iommu
>>>>>>>>> * ioapic
>>>>>>>>> * isabus-bridge
>>>>>>>>> * kvmclock
>>>>>>>>> * kvm-ioapic
>>>>>>>>> * kvmvapic
>>>>>>>>> * SUNW,fdtwo
>>>>>>>>> * sysbus-ahci
>>>>>>>>> * sysbus-fdc
>>>>>>>>> * sysbus-ohci
>>>>>>>>> * unimplemented-device
>>>>>>>>> * virtio-mmio
>>>>>>>>>
>>>>>>>>> Instead of requiring each machine-type with has_dynamic_sysbus=1
>>>>>>>>> to implement its own mechanism to block unsupported devices, we
>>>>>>>>> can use the user_creatable flag to ensure we won't let the user
>>>>>>>>> plug anything that will never work.
>>>>>>>> How does this work? Which devices can be dynamically
>>>>>>>> plugged is machine dependent. You can't dynamically-plug
>>>>>>>> an intel-iommu on the ARM virt board, and you can't
>>>>>>>> dynamically-plug the vfio-calxeda-xgmac on the spapr
>>>>>>>> board, and so on. So I don't see how we can just have
>>>>>>>> a flag on the device itself that controls whether
>>>>>>>> it can be dynamically plugged.
>>>>>>>>
>>>>>>>> So I'm definitely coming around to the opinion that
>>>>>>>> it's just a bug in the q35 board that it doesn't have
>>>>>>>> any device whitelisting, and we should fix that.
>>>>>>> OK, let's assume q35 must implement a whitelist:
>>>>>>>
>>>>>>> To build that whitelist, we need to be able to know what should
>>>>>>> be in the whitelist, or not. And nobody knew for sure what was
>>>>>>> user-creatable in q35 by accident, and what was really supposed
>>>>>>> to be user-creatable in q35. See the "q35 and sysbus devices"
>>>>>>> thread I started ~2 weeks ago.
>>>>>>>
>>>>>>> Building a q35 whitelist will be much easier if make
>>>>>>> sys-bus-devices non-user-creatable by default.
>>>>>> So why are they user creatable in the first place?
>>>>>>
>>>>>> We used to have boards that were dynamic sysbus aware (ppce500, virt)
>>>>>> that
>>>>>> allowed dynamic creation and every other board did not. I don't
>>>>>> remember the
>>>>>> exact mechanism behind it though.
>>>>>>
>>>>>> When did that behavior change? It sounds like a regression somewhere.
>>>>> See patch description:
>>>>>
>>>>>>>>> commit 33cd52b5d7b9adfd009e95f07e6c64dd88ae2a31 unset
>>>>>>>>> cannot_instantiate_with_device_add_yet in TYPE_SYSBUS,
>>>>> Note that the commit above is not a regression[1] (because q35
>>>>> didn't have has_dynamic_sysbus=1 yet), but having sysbus devices
>>>>> have cannot_instantiate_with_device_add_yet=false/user_creatable=true
>>>>> by default makes it harder to build the whitelist for q35 (or
>>>>> other machines that will have has_dynamic_sysbus=1 in the
>>>>> future).
>>>> I seem to miss the bigger picture.
>>>>
>>>> Why would anyone set has_dynamic_sysbus=1 in a board file without an
>>>> explicit whitelist? The whitelist is *not* device specific. It's board
>>>> specific, because your board needs to know how to wire up a device and
>>>> how to expose the fact that it exists to the OS.
>>>>
>>>> So the real bug is that someone set has_dynamic_sysbus=1 in q35 without
>>>> implementing all of the dynamic sysbus logic, no?
>>> According to commit bf8d492405feaee2c1685b3b9d5e03228ed3e47f this was
>>> just introduced for allowing the "intel-iommu" device, so I guess this
>>> is the device that we want to have in a whitelist there?
>> If you want a dynamic intel-iommu, you also need to have dynamic ACPI
>> generation to create DMAR tables the OS can use to drive the IOMMU, no? At
>> last at that point, someone should have realized that a "whitelist" is
>> mandatory.
>>
>> But yes, please just only add a whitelist for intel-iommu to the q35 board.
>> That is the real bug.
> Look, I don't disagree that we need a whitelist on q35. But I
> don't know why you assume it is as simple as adding intel-iommu.

So why has intel-iommu worked in the first place? Who wired up its 
memory regions? Who wired up fault IRQs? Who added the DMAR table to 
ACPI when it was created?

> We *don't know* what should be on q35 whitelist until we review
> each device that is accepted by q35 today, and make sure it
> really is not supposed to be supported on -device.

If in doubt, not a single sysbus device should have ever worked without 
explicit code around it. Really :).

> Making has_dynamic_sysbus/user_creatable consistent on sysbus
> devices helps on that. It is not necessary nor sufficient to fix
> q35, that's true, but it helps *a lot*.
>
> See, after I start this series, I already found two exceptions to
> the "just add intel-iommu" rule:
>
> 1) amd-iommu
> 2) xen-backend
>
> I'm not sure yet if we have others, until people review the other
> "Remove user_creatable from <device>" patches in this
> series.

Same question as above there. How do they get mapped? How does the OS 
learn they exist?

>
>> The basic idea behind dynamic sysbus is that you move the responsibility of
>> sysbus spawnability checks from the sysbus layer to the board file. If the
>> board file ignores to do those checks, it's at fault.
> I think I will do this:
>
> I will submit v2 of this thread pretending it is just going to
> fix the "info qdm" regression introduced by commit
> bf8d492405feaee2c1685b3b9d5e03228ed3e47f, and remove any mention
> of the q35 bug from the series and patch description.
>
> I hopt this will make us stop diverging the discussion to "you
> should add a whitelist to q35 first", and stop ignoring that:
> 1) cannot_instantiate_with_device_add_yet is being set
>     incorrectly on the sysbus device classes and that's a bad
>     idea;
> 2) cannot_instantiate_with_device_add_yet is an awful name.


We need to make sure that the board has control over which devices are 
spawnable. I fail to see how this series helps or achieves that, but I'm 
happy to learn.



Alex
