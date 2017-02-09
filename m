Received: from eggs.gnu.org ([2001:4830:134:3::10]:59385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cbtRE-0007Nv-DL
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 13:27:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cbtRD-0006HX-E1
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 13:27:24 -0500
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20170209201301-mutt-send-email-mst@kernel.org>
Date: Thu, 9 Feb 2017 19:27:15 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <B93CA3EA-D7F6-4395-BFBD-6362FAAE2822@suse.de>
References: <1486644810-33181-1-git-send-email-agraf@suse.de>
	<70829774-a0c4-79ae-2eaf-cfac19e9dd7d@redhat.com>
	<20170209201301-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] target-arm: Add some omitted dma
 cache coherency flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Shannon Zhao <shannon.zhao@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>



> Am 09.02.2017 um 19:13 schrieb Michael S. Tsirkin <mst@redhat.com>:
>=20
>> On Thu, Feb 09, 2017 at 02:15:36PM +0100, Laszlo Ersek wrote:
>>> On 02/09/17 13:53, Alexander Graf wrote:
>>> ARM is amazing when it comes to cache coherency and VMs. While any sane
>>> architecture allows the host to override the guest's caching attributes,=

>>> that's very hard to do on ARM.
>>>=20
>>> That means that the guest may directly access guest memory bypassing the=

>>> cache while QEMU happily writes to / reads from cache. The end result is=

>>> very nasty, because both sides see very different views of the world.
>>>=20
>>> That means that we need to be very cautious to tell guests that devices
>>> that QEMU emulates are going to use data in the cache rather than direct=
ly
>>> on memory.
>>>=20
>>> We added this to PCI a while back for DT (5d636e21 "hw/arm/virt: mark th=
e PCIe
>>> host controller as DMA coherent in the DT") and ACPI (bc64b96 "hw/arm/vi=
rt-
>>> acpi-build: _CCA attribute is compulsory") but never updated virtio-mmio=
 or
>>> fw-cfg in DT or ACPI tables.
>>>=20
>>> This patch set adds the respective cache coherency flags for them in bot=
h DT and
>>> ACPI.
>>>=20
>>> Fortunately, no guests except for Linux 4.9.7 and 4.9.8 are broken becau=
se of
>>> this. Upstream realized quickly enough that every user of virtio-mmio ou=
t there
>>> describes its cache coherency incorrectly and reverted the patch that wo=
uld
>>> require said dma coherency flag. But we should be safe for the future an=
d "do
>>> the right thing".
>>>=20
>>> Alexander Graf (4):
>>>  target-arm: Declare virtio-mmio as dma-coherent in dt
>>>  hw/arm/virt: Declare virtio-mmio as dma cache coherent in ACPI
>>>  hw/arm/virt: Declare fwcfg as dma cache coherent in ACPI
>>>  hw/arm/virt: Declare fwcfg as dma cache coherent in dt
>>>=20
>>> hw/arm/vexpress.c        | 1 +
>>> hw/arm/virt-acpi-build.c | 2 ++
>>> hw/arm/virt.c            | 2 ++
>>> 3 files changed, 5 insertions(+)
>>>=20
>>=20
>> Famous last words:
>> series
>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>>=20
>> Should we replicate patch #3 to QEMU0002 / FWCF in
>> "hw/i386/acpi-build.c" too? Or is it that we couldn't care less about
>> _CCA on x86? :) (Can't really muster the energy right now to look it up
>> in the ACPI spec, sorry!)
>>=20
>> Thanks
>> Laszlo
>=20
> ACPI spec says:
> On platforms for which existing default cache-coherency behavior of the OS=
 is not adequate, _CCA
> enables the OS to adapt to the differences
>=20
> So I think we don't need it on x86.

According to acpi 6.1, x86 explicitly defaults to dma coherent if _CCA is om=
itted. It's only illegal for ARM.

Alex
