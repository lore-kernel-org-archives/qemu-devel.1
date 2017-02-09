Received: from eggs.gnu.org ([2001:4830:134:3::10]:56439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cbo4S-0005QH-UR
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cbo4R-0004Tg-Qs
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:43:32 -0500
References: <1486560712-44171-1-git-send-email-agraf@suse.de>
	<ef6b903b-5224-b4eb-1080-a3689fcec70a@redhat.com>
	<f2f119bc-9c22-ad52-ff26-7d6ecc213a3c@suse.de>
	<c1ff3829-b068-881a-1523-317ef0d31689@redhat.com>
	<a5d47ced-527e-9fa5-9c31-5ffe7981b42c@suse.de>
	<CAKv+Gu_mtaczzEP4SenfiQ8qB0M3mfmDvzHObSrCMwUYLuFgdQ@mail.gmail.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <b1462c75-eb29-e3ec-7c3d-f82e4d930af3@suse.de>
Date: Thu, 9 Feb 2017 13:43:22 +0100
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_mtaczzEP4SenfiQ8qB0M3mfmDvzHObSrCMwUYLuFgdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-arm: Declare virtio-mmio as
 dma-coherent in dt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>



On 09/02/2017 13:30, Ard Biesheuvel wrote:
> On 9 February 2017 at 12:24, Alexander Graf <agraf@suse.de> wrote:
>>
>>
>> On 08/02/2017 17:17, Laszlo Ersek wrote:
>>>
>>> On 02/08/17 17:12, Alexander Graf wrote:
>>>>
>>>> On 02/08/2017 04:29 PM, Laszlo Ersek wrote:
>>>>>
>>>>> CC'ing Ard and Shannon (I recall this property from earlier):
>>>>>
>>>>> On 02/08/17 14:31, Alexander Graf wrote:
>>>>>>
>>>>>> QEMU emulated hardware is always dma coherent with its guest. We do
>>>>>> annotate that correctly on the PCI host controller, but left out
>>>>>> virtio-mmio.
>>>>>
>>>>> I recommend to reference the following commit here:
>>>>>
>>>>> commit 5d636e21c44ecf982a22a7bc4ca89186079ac283
>>>>> Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>> Date:   Mon Jul 4 13:06:36 2016 +0100
>>>>>
>>>>>      hw/arm/virt: mark the PCIe host controller as DMA coherent in the
>>>>> DT
>>>>>           Since QEMU performs cacheable accesses to guest memory when
>>>>> doing DMA
>>>>>      as part of the implementation of emulated PCI devices, guest
>>>>> drivers
>>>>>      should use cacheable accesses as well when running under KVM.
>>>>> Since this
>>>>>      essentially means that emulated PCI devices are DMA coherent, set
>>>>> the
>>>>>      'dma-coherent' DT property on the PCIe host controller DT node.
>>>>>           This brings the DT description into line with the ACPI
>>>>> description,
>>>>>      which already marks the PCI bridge as cache coherent (see commit
>>>>>      bc64b96c984abf).
>>>>>           Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>>      Message-id:
>>>>> 1467134090-5099-1-git-send-email-ard.biesheuvel@linaro.org
>>>>>      Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>>>>      Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>>>
>>>>>> Recent kernels have started to interpret that flag rather than take
>>>>>> dma coherency as granted with virtio-mmio. While that is considered
>>>>>> a kernel bug, as it breaks previously working systems, it showed that
>>>>>> our dt description is incomplete.
>>>>>>
>>>>>> This patch adds the respective marker that allows guest OSs to evaluate
>>>>>> that our virtio-mmio devices are indeed cache coherent.
>>>>>
>>>>> As noted above, commit bc64b96c984a ("hw/arm/virt-acpi-build: _CCA
>>>>> attribute is compulsory", 2015-11-03) had done the same in the ACPI
>>>>> description of the PCIe host controller.
>>>>>
>>>>> Thus, do we need _CCA in the ACPI description of the virtio-mmio
>>>>> transports, to parallel the DT change? See the LNRO0005 device in
>>>>> acpi_dsdt_add_virtio().
>>>>
>>>>
>>>> Yes, we should also annotate it correctly in the DSDT. Today it's not a
>>>> deal breaker as Linux always assumes virtio-mmio to be dma coherent, but
>>>> it would make our platform description more accurate.
>>>>
>>>>> If that's the case, then I propose that either the patch please fix
>>>>> both DT and ACPI, or that at least we file a bug "somewhere", for
>>>>> adding _CCA in acpi_dsdt_add_virtio().
>>>>
>>>>
>>>> I agree that it should happen in the same patch (set). While I don't
>>>> care a lot about ACPI right now (since dt is preferred on upstream
>>>> kernels), I can take a look.
>>>
>>>
>>> Thank you!
>>
>>
>> Is ACPI boot supposed to work at all with 4.9?
>>
>
> Yes, but only if you boot via UEFI

I see, thanks. I guess there's no boot protocol to fetch ACPI tables 
without UEFI.

Interestingly enough, omitting the _CCA property didn't actually make 
too much of a difference. The guest still seems to boot fine without it, 
so it seems to treat virtio-mmio as cache coherent. Only if I explicitly 
set _CCA as 0 it's broken the same as dt.

If that's the case, it's scary if we have different defaults for dt and 
acpi descriptions, no?

Also, we should probably explicitly warn in the kernel every time we see 
an ACPI device try to do DMA operations without _CCA set in its descriptor.


Alex
