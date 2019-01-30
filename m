Received: from eggs.gnu.org ([209.51.188.92]:37895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gonnQ-0000rM-RT
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gonnP-0002MB-Po
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:12:44 -0500
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:53519)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gonnP-0002KC-IJ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:12:43 -0500
Received: from player760.ha.ovh.net (unknown [10.109.160.93])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 254FC4AC9B
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 12:12:37 +0100 (CET)
References: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
	<1548841387-7670-1-git-send-email-thuth@redhat.com>
	<1548841387-7670-2-git-send-email-thuth@redhat.com>
	<381c04ec-8ec2-77d1-d3e7-403ce46f593e@kaod.org>
	<cf02981a-b80a-1645-f7f0-decbba9719d3@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <002a64a3-befe-d0f5-8014-205be2138691@kaod.org>
Date: Wed, 30 Jan 2019 12:12:32 +0100
MIME-Version: 1.0
In-Reply-To: <cf02981a-b80a-1645-f7f0-decbba9719d3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/5] ppc64: Express dependencies of
 'pseries' and 'powernv' machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, yang.zhong@intel.com
Cc: pbonzini@redhat.com, qemu-ppc@nongnu.org

On 1/30/19 12:04 PM, Thomas Huth wrote:
> On 2019-01-30 12:00, C=C3=A9dric Le Goater wrote:
>> On 1/30/19 10:43 AM, Thomas Huth wrote:
>>> The POWERNV switch should always select ISA_IPMI_BT, then the other
>>> IPMI options are turned on automatically now.
>>> CONFIG_DIMM should always be selected by the pseries machine,
>>> which in turn depends on CONFIG_MEM_DEVICE since DIMM implements
>>> this interface.
>>> CONFIG_VIRTIO_VGA can be dropped from default-configs/ppc64-softmmu.m=
ak
>>> completely since this device is already automatically enabled via
>>> hw/display/Kconfig now.
>>> CONFIG_SPAPR_RNG should stay in the ppc-softmmu.mak file since this
>>> is a completely optional device.
>>>
>>> Cc: C=C3=A9dric Le Goater <clg@kaod.org>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  default-configs/ppc64-softmmu.mak | 7 -------
>>>  hw/intc/Kconfig                   | 4 +---
>>>  hw/mem/Kconfig                    | 1 +
>>>  hw/ppc/Kconfig                    | 9 +++++++++
>>>  4 files changed, 11 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc6=
4-softmmu.mak
>>> index a0a9151..6f8d7ea 100644
>>> --- a/default-configs/ppc64-softmmu.mak
>>> +++ b/default-configs/ppc64-softmmu.mak
>>> @@ -5,14 +5,7 @@ include ppc-softmmu.mak
>>> =20
>>>  # For PowerNV
>>>  CONFIG_POWERNV=3Dy
>>> -CONFIG_IPMI=3Dy
>>> -CONFIG_IPMI_LOCAL=3Dy
>>> -CONFIG_IPMI_EXTERN=3Dy
>>> -CONFIG_ISA_IPMI_BT=3Dy
>>> =20
>>>  # For pSeries
>>>  CONFIG_PSERIES=3Dy
>>> -CONFIG_VIRTIO_VGA=3Dy
>>> -CONFIG_MEM_DEVICE=3Dy
>>> -CONFIG_DIMM=3Dy
>>>  CONFIG_SPAPR_RNG=3Dy
>>> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
>>> index 6eea14e..1e819d0 100644
>>> --- a/hw/intc/Kconfig
>>> +++ b/hw/intc/Kconfig
>>> @@ -31,13 +31,11 @@ config OPENPIC_KVM
>>> =20
>>>  config XICS
>>>      bool
>>> -    default y
>>> -    depends on PSERIES
>>> =20
>>>  config XICS_SPAPR
>>>      bool
>>>      default y
>>> -    depends on PSERIES
>>> +    depends on XICS && PSERIES
>>> =20
>>>  config XICS_KVM
>>>      bool
>>> diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
>>> index d1e635c..620fd4c 100644
>>> --- a/hw/mem/Kconfig
>>> +++ b/hw/mem/Kconfig
>>> @@ -1,5 +1,6 @@
>>>  config DIMM
>>>      bool
>>> +    select MEM_DEVICE
>>> =20
>>>  config MEM_DEVICE
>>>      bool
>>> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
>>> index b0095e1..b44e3bd 100644
>>> --- a/hw/ppc/Kconfig
>>> +++ b/hw/ppc/Kconfig
>>> @@ -1,11 +1,20 @@
>>>  config PSERIES
>>>      bool
>>> +    select DIMM
>>> +    select PCI
>>> +    select VFIO
>>> +    select XICS
>>
>> Don't we want XICS_SPAPR ? or is there another toggle with KVM ?
>>
>>>  config SPAPR_RNG
>>>      bool
>>> +    depends on PSERIES
>>> =20
>>>  config POWERNV
>>>      bool
>>> +    select ISA_IPMI_BT
>>
>> yes.
>>
>> It is possible to start a PowerNV machine without defining a=20
>> BT device but the machine relies on the BT device and the IPMI=20
>> backend attached to it to powerdown.=20
>>
>> Ideally I would have preferred to define the device internally=20
>> in the machine and plug it on the ISA bus but I couldn't find=20
>> a way to do it cleanly.=20
>>
>>> +    select ISA_BUS
>>> +    select MC146818RTC
>>> +    select XICS
>>
>> only for POWER8 machines. POWER9 uses XIVE.
>=20
> Sure, but you don't know at compile time yet whether the user wants to
> use a POWER8 or a POWER9 CPU. So this currently always needs to be sele=
cted.

ah yes :) Please add XIVE then. I should get the Pnv model merged one day=
.

Thanks,

C.=20
