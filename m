Received: from eggs.gnu.org ([209.51.188.92]:43826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1guArk-0002Zn-Jh
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 01:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1guAfN-0003r3-01
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 01:38:38 -0500
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:60771)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1guAfM-0003px-PA
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 01:38:36 -0500
Received: from player756.ha.ovh.net (unknown [10.109.146.163])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 470B151C51
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 07:38:34 +0100 (CET)
References: <20190213210756.27032-1-clg@kaod.org>
	<20190214004902.GX1884@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ec91f7e7-9689-8325-20af-e2e860dcc32f@kaod.org>
Date: Thu, 14 Feb 2019 07:38:28 +0100
MIME-Version: 1.0
In-Reply-To: <20190214004902.GX1884@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] spapr/irq: remove the XICS offset
 adjustment for the dual machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 2/14/19 1:49 AM, David Gibson wrote:
> On Wed, Feb 13, 2019 at 10:07:54PM +0100, C=E9dric Le Goater wrote:
>> Hello,
>>
>> When using the 'dual' interrupt mode, the source numbers of both sPAPR
>> IRQ backends are aligned to share a common IRQ number space and to use
>> a similar mapping of the machine qemu_irq array which is indexed by
>> the source number.
>>
>> The XICS IRQ number range initially being [ 0x1000 - 0x2000 ], this
>> requires to change the XICS ICSState offset to 0 and to provision for
>> an extra 4K of source numbers and qemu_irqs which will never be used
>> by the machine when running under the XICS interrupt mode. This is not
>> an optimal solution.
>>
>> Moreover, the KVM support for the 'dual' interrupt mode will require
>> some adjustments. The XICS KVM device considers that the IRQ numbers
>> start at XICS_IRQ_BASE (0x1000) and we have no way to inform KVM of
>> the offset change. We will need to ignore the lower 4K numbers when
>> capturing or restoring the source states from the XICS KVM device.
>>
>> The first patch allocates an IRQ number space of the expected size for

s/IRQ number space/source numbers/

There is still some confusion in the way I use the terms "IRQ number"=20
and "source number". These are two different number spaces. I should
pay more attention.

>> the XICS sPAPR IRQ backend. The overall IRQ number space size and the
>> qemu_irq array size is still the one required by the 'dual' sPAPR IRQ
>> backend, that is, in sync with XIVE. The second patch removes the
>> ICSState offset adjustment. This last change adds some benefits as it
>> simplifies greatly the qirq() method of the 'dual' sPAPR IRQ
>> backend.
>=20
> Ah, much nicer.  Applied to ppc-for-4.0, thanks.

I will just drop patch "spapr/xics: ignore the lower 4K in the IRQ=20
number space"

Thanks,

C.
