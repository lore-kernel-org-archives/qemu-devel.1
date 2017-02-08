Received: from eggs.gnu.org ([2001:4830:134:3::10]:57008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cbV6K-0007bu-Lp
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cbV6G-00041T-Ko
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:28:12 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1cbV6G-00040q-EP
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:28:08 -0500
Received: by mail-wm0-x235.google.com with SMTP id c85so204183151wmi.1
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 08:28:06 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
In-Reply-To: <c1ff3829-b068-881a-1523-317ef0d31689@redhat.com>
Date: Wed, 8 Feb 2017 16:27:54 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <C4E1DF44-1626-425D-880E-0053AD688422@linaro.org>
References: <1486560712-44171-1-git-send-email-agraf@suse.de>
	<ef6b903b-5224-b4eb-1080-a3689fcec70a@redhat.com>
	<f2f119bc-9c22-ad52-ff26-7d6ecc213a3c@suse.de>
	<c1ff3829-b068-881a-1523-317ef0d31689@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com, Shannon Zhao <shannon.zhao@linaro.org>


> On 8 Feb 2017, at 16:17, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
>> On 02/08/17 17:12, Alexander Graf wrote:
>>> On 02/08/2017 04:29 PM, Laszlo Ersek wrote:
>>> CC'ing Ard and Shannon (I recall this property from earlier):
>>>=20
>>>> On 02/08/17 14:31, Alexander Graf wrote:
>>>> QEMU emulated hardware is always dma coherent with its guest. We do
>>>> annotate that correctly on the PCI host controller, but left out
>>>> virtio-mmio.
>>> I recommend to reference the following commit here:
>>>=20
>>> commit 5d636e21c44ecf982a22a7bc4ca89186079ac283
>>> Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> Date:   Mon Jul 4 13:06:36 2016 +0100
>>>=20
>>>     hw/arm/virt: mark the PCIe host controller as DMA coherent in the DT=

>>>          Since QEMU performs cacheable accesses to guest memory when
>>> doing DMA
>>>     as part of the implementation of emulated PCI devices, guest drivers=

>>>     should use cacheable accesses as well when running under KVM.
>>> Since this
>>>     essentially means that emulated PCI devices are DMA coherent, set
>>> the
>>>     'dma-coherent' DT property on the PCIe host controller DT node.
>>>          This brings the DT description into line with the ACPI
>>> description,
>>>     which already marks the PCI bridge as cache coherent (see commit
>>>     bc64b96c984abf).
>>>          Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>     Message-id:
>>> 1467134090-5099-1-git-send-email-ard.biesheuvel@linaro.org
>>>     Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>>     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>=20
>>>> Recent kernels have started to interpret that flag rather than take
>>>> dma coherency as granted with virtio-mmio. While that is considered
>>>> a kernel bug, as it breaks previously working systems, it showed that
>>>> our dt description is incomplete.
>>>>=20
>>>> This patch adds the respective marker that allows guest OSs to evaluate=

>>>> that our virtio-mmio devices are indeed cache coherent.
>>> As noted above, commit bc64b96c984a ("hw/arm/virt-acpi-build: _CCA
>>> attribute is compulsory", 2015-11-03) had done the same in the ACPI
>>> description of the PCIe host controller.
>>>=20
>>> Thus, do we need _CCA in the ACPI description of the virtio-mmio
>>> transports, to parallel the DT change? See the LNRO0005 device in
>>> acpi_dsdt_add_virtio().
>>=20
>> Yes, we should also annotate it correctly in the DSDT. Today it's not a
>> deal breaker as Linux always assumes virtio-mmio to be dma coherent, but
>> it would make our platform description more accurate.
>>=20

The _CCA property is mandatory on arm64, and there is no default. So this is=
 a bug nonetheless, even if the de facto default matches the platform. So ye=
s, let's get this fixed please.


>>> If that's the case, then I propose that either the patch please fix
>>> both DT and ACPI, or that at least we file a bug "somewhere", for
>>> adding _CCA in acpi_dsdt_add_virtio().
>>=20
>> I agree that it should happen in the same patch (set). While I don't
>> care a lot about ACPI right now (since dt is preferred on upstream
>> kernels), I can take a look.
>=20
> Thank you!
> Laszlo
>=20
