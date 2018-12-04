Received: from eggs.gnu.org ([2001:4830:134:3::10]:41453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gU9tI-0006Xt-5e
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gU9tE-00034q-V0
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:33:28 -0500
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:44947)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gU9tE-00033A-ON
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:33:24 -0500
Received: from player715.ha.ovh.net (unknown [10.109.160.153])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 2CAB010A074
	for <qemu-devel@nongnu.org>; Tue,  4 Dec 2018 13:33:22 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-28-clg@kaod.org>
	<20181129040917.GF14697@umbus.fritz.box>
	<CAFEAcA8=xJCoTmXmygpK2yVdq5Viqi-dQoiTJrML=goutzKujQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f92e8c2c-3384-ba88-3d85-0c168441b052@kaod.org>
Date: Tue, 4 Dec 2018 13:33:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8=xJCoTmXmygpK2yVdq5Viqi-dQoiTJrML=goutzKujQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 27/36] sysbus: add a sysbus_mmio_unmap()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hello Peter,

On 12/3/18 6:48 PM, Peter Maydell wrote:
> On Thu, 29 Nov 2018 at 04:55, David Gibson <david@gibson.dropbear.id.au=
> wrote:
>>
>> On Fri, Nov 16, 2018 at 11:57:20AM +0100, C=C3=A9dric Le Goater wrote:
>>> This will be used to remove the MMIO regions of the POWER9 XIVE
>>> interrupt controller when the sPAPR machine is reseted.
>>>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>>
>> Since the code looks sane.
>>
>> Hoever, I think using memory_region_set_enabled() would be a better
>> idea for our purposes than actually adding/deleting the subregion.
>=20
> The other approach I've used in the past is to use
> sysbus_mmio_get_region() and then just map and unmap
> that directly, rather than using the sysbus_mmio_map()
> convenience function. (Often the kind of device that's
> doing complicated things like this will be working in
> a setup where it doesn't necessarily want to be mapping
> directly into system memory rather than an SoC or similar
> container MemoryRegion anyway.)

Thanks for chiming in on that patch. Here is some background on=20
what we are trying to model. May be you have some suggestions.

A completely new interrupt controller was introduced on the POWER9=20
processor and it uses MMIO regions for interrupt management. These
regions are backed by simple MRs in QEMU, when using TCG, and backed
by ram_device_ptr MRs under KVM.

Difficulties arise with the fact that POWER9 pseries guests need
to support the old mode (XICS, no MMIOs) and the new mode XIVE.
The interrupt mode is negotiated at boot between the hypervisor
and the guest and a reset is generated to take into account=20
the changes. Which means that, at reset, we may need to disconnect=20
from a KVM IC device and reconnect to another.=20

When switching from XICS to XIVE mode :=20

  if kvm
    - destroy KVM XICS device
    - create KVM XIVE device=20
    - get fd, mmap, init ram_device_ptr MRs
    - map mmio
  - enable MMIOs

When switching from XIVE to XICS  :=20
 =20
  - disable MMIOs=20
  if kvm
    - delete MRs
    - munmap
    - destroy KVM XIVE device
    - create KVM XICS device=20


Thanks,

C.
