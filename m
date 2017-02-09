Received: from eggs.gnu.org ([2001:4830:134:3::10]:53797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cbnr6-0007U4-3H
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:29:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cbnr5-0008Nt-3q
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:29:44 -0500
References: <1486560712-44171-1-git-send-email-agraf@suse.de>
	<ef6b903b-5224-b4eb-1080-a3689fcec70a@redhat.com>
	<f2f119bc-9c22-ad52-ff26-7d6ecc213a3c@suse.de>
	<c1ff3829-b068-881a-1523-317ef0d31689@redhat.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <52f06298-6ddb-2ff7-a213-d5738bdcfbc5@suse.de>
Date: Thu, 9 Feb 2017 13:29:36 +0100
MIME-Version: 1.0
In-Reply-To: <c1ff3829-b068-881a-1523-317ef0d31689@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mst@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Shannon Zhao <shannon.zhao@linaro.org>



On 08/02/2017 17:17, Laszlo Ersek wrote:
> On 02/08/17 17:12, Alexander Graf wrote:
>> On 02/08/2017 04:29 PM, Laszlo Ersek wrote:
>>> CC'ing Ard and Shannon (I recall this property from earlier):
>>>
>>> On 02/08/17 14:31, Alexander Graf wrote:
>>>> QEMU emulated hardware is always dma coherent with its guest. We do
>>>> annotate that correctly on the PCI host controller, but left out
>>>> virtio-mmio.
>>> I recommend to reference the following commit here:
>>>
>>> commit 5d636e21c44ecf982a22a7bc4ca89186079ac283
>>> Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> Date:   Mon Jul 4 13:06:36 2016 +0100
>>>
>>>      hw/arm/virt: mark the PCIe host controller as DMA coherent in the DT
>>>           Since QEMU performs cacheable accesses to guest memory when
>>> doing DMA
>>>      as part of the implementation of emulated PCI devices, guest drivers
>>>      should use cacheable accesses as well when running under KVM.
>>> Since this
>>>      essentially means that emulated PCI devices are DMA coherent, set
>>> the
>>>      'dma-coherent' DT property on the PCIe host controller DT node.
>>>           This brings the DT description into line with the ACPI
>>> description,
>>>      which already marks the PCI bridge as cache coherent (see commit
>>>      bc64b96c984abf).
>>>           Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>      Message-id:
>>> 1467134090-5099-1-git-send-email-ard.biesheuvel@linaro.org
>>>      Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>>      Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>
>>>> Recent kernels have started to interpret that flag rather than take
>>>> dma coherency as granted with virtio-mmio. While that is considered
>>>> a kernel bug, as it breaks previously working systems, it showed that
>>>> our dt description is incomplete.
>>>>
>>>> This patch adds the respective marker that allows guest OSs to evaluate
>>>> that our virtio-mmio devices are indeed cache coherent.
>>> As noted above, commit bc64b96c984a ("hw/arm/virt-acpi-build: _CCA
>>> attribute is compulsory", 2015-11-03) had done the same in the ACPI
>>> description of the PCIe host controller.
>>>
>>> Thus, do we need _CCA in the ACPI description of the virtio-mmio
>>> transports, to parallel the DT change? See the LNRO0005 device in
>>> acpi_dsdt_add_virtio().
>>
>> Yes, we should also annotate it correctly in the DSDT. Today it's not a
>> deal breaker as Linux always assumes virtio-mmio to be dma coherent, but
>> it would make our platform description more accurate.
>>
>>> If that's the case, then I propose that either the patch please fix
>>> both DT and ACPI, or that at least we file a bug "somewhere", for
>>> adding _CCA in acpi_dsdt_add_virtio().
>>
>> I agree that it should happen in the same patch (set). While I don't
>> care a lot about ACPI right now (since dt is preferred on upstream
>> kernels), I can take a look.
>
> Thank you!

In fact, don't some other devices also suffer from this? Fw-cfg is now 
DMA capable IIUC, so that should also get a _CCA attribute for example.


Alex
