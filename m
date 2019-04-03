Received: from eggs.gnu.org ([209.51.188.92]:52892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hBfxP-0003bw-5z
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 09:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hBfxO-0003eS-8V
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 09:29:35 -0400
References: <20190321104745.28068-1-shameerali.kolothum.thodi@huawei.com>
	<20190321104745.28068-8-shameerali.kolothum.thodi@huawei.com>
	<98c7f0fd-8446-8897-0808-e7615af29670@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA83933836A@lhreml524-mbs.china.huawei.com>
	<0dcd3f3c-15c4-318f-28bd-4b6706708c0d@redhat.com>
	<CAKv+Gu_-nRqeCT0s6ZwW+q3=sbGmtazFJ9R=19U5SJ=gSUmJLw@mail.gmail.com>
	<a2c37d40-e2ee-e7aa-3f34-ab39a9a6449d@redhat.com>
	<459862f9-18f7-0a37-dfb9-b8ca9aa6a2d2@redhat.com>
	<3de6adf3-30c7-5908-e153-2195bc6879c5@redhat.com>
	<9e939ea4-4be2-a165-dce4-47d8196020b0@redhat.com>
	<20190403114901.6e4ea653@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA839353082@lhreml524-mbs.china.huawei.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ebf745ce-f5bc-be0c-c0ce-3ce25bd7afa9@redhat.com>
Date: Wed, 3 Apr 2019 15:29:23 +0200
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA839353082@lhreml524-mbs.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/10] hw/arm/virt: Introduce opt-in
 feature "fdt"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei (O)" <xuwei5@huawei.com>, "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>, Leif Lindholm <Leif.Lindholm@arm.com>

On 04/03/19 14:10, Shameerali Kolothum Thodi wrote:

>>>>> So, the condition for hiding the hotpluggable memory nodes in question
>>>>> from the DT is:
>>>>
>>>>>
>>>>>   (aarch64 && firmware_loaded && acpi_enabled)

>>> While UEFI has bindings for both 32-bit and 64-bit ARM, ACPI has a
>>> 64-bit-only binding for ARM. (And you can have UEFI without ACPI, but
>>> not the reverse, on ARM.) So if you run the 32-bit build of the
>>> ArmVirtQemu firmware, you get no ACPI at all; all you can rely on with
>>> the OS is the DT.
> 
> Just to confirm, does that mean with 32-bit build of the UEFI, the OS cannot
> boot with ACPI and uses DT only.

Indeed.

> So,
> 
> If ((aarch64 && firmware_loaded && acpi_enabled) {
>    Hide_hotpluggable_memory_nodes()
> } else {
>    Add_ hotpluggable_memory_nodes()
> }
> 
> should work for all cases?

Yes.

Here's what happens when any one of the subconditions evaluates to false:

- ARM32 has no ACPI bindings, so the guest kernel can only use DT.

- On AARCH64, if you don't "load the firmware" (= don't use UEFI), then
  there won't be an ACPI entry point for the OS to locate (the RSD PTR
  is defined by the ACPI spec in UEFI terms, for AARCH64). So the guest
  kernel can only use DT.

- When on AARCH64 and using UEFI, but asking QEMU not to generate ACPI
  content, the firmware will not install any ACPI tables, so the guest
  kernel can only use DT.

>>> This "bitness distinction" is implemented in the firmware already. If
>>> you hid the memory nodes from the DT under the condition
>>>
>>>   (!aarch64 && firmware_loaded && acpi_enabled)
>>>
>>> then the nodes would not be seen by the OS at all (because
>>> "acpi_enabled" is irrelevant for the 32-bit build of ArmVirtQemu, and
>>> all the OS can ever get is DT).
>>
>> It's getting tricky and I don't like a bit that we are trying to carter
>> 64 bit only UEFI build (or any other build) on QEMU side. Also Peter has
>> a valid about guessing on QEMU side (that's usually a source of problem
>> in the future).
> 
> If the above is correct(with 32-bit variant of UEFI, OS cannot have ACPI boot),
> then do we really have the issue of memory becoming non hot-un-unpluggable?
> May be I am missing something. 

I think Igor and Peter dislike adding complex logic to QEMU that
reflects the behavior of a specific firmware. AIUI their objection isn't
that it wouldn't work, but that it's not the right thing to do, from a
design perspective.

Thanks,
Laszlo
