Received: from eggs.gnu.org ([2001:4830:134:3::10]:55449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ecLnO-0002Fp-Hr
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 20:48:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ecLnL-0005DI-Fe
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 20:48:42 -0500
Date: Fri, 19 Jan 2018 02:48:37 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA_tqP1Pu4B3x-Xgii_SkniNpCW+BxVdHnmhNtg1khDbWg@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1801190245190.64978@zero.eik.bme.hu>
References: <20180111045937.2119-1-david@gibson.dropbear.id.au>
	<20180111045937.2119-7-david@gibson.dropbear.id.au>
	<CAFEAcA_tqP1Pu4B3x-Xgii_SkniNpCW+BxVdHnmhNtg1khDbWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PULL 06/11] hw/ide: Emulate SiI3112 SATA
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, surajjs@au1.ibm.com

On Thu, 18 Jan 2018, Peter Maydell wrote:
> On 11 January 2018 at 04:59, David Gibson <david@gibson.dropbear.id.au> wrote:
>> From: BALATON Zoltan <balaton@eik.bme.hu>
>>
>> This is a common generic PCI SATA controller that is also used in PCs
>> but more importantly guests running on the Sam460ex board prefer this
>> card and have a driver for it (unlike for other SATA controllers
>> already emulated).
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Acked-by: John Snow <jsnow@redhat.com>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>
>> +    case 0x10:
>> +        val = d->i.bmdma[0].cmd;
>> +        val |= (d->regs[0].confstat & (1UL << 11) ? (1 << 4) : 0); /*SATAINT0*/
>> +        val |= (d->regs[1].confstat & (1UL << 11) ? (1 << 6) : 0); /*SATAINT1*/
>> +        val |= (d->i.bmdma[1].status & BM_STATUS_INT ? (1 << 14) : 0);
>> +        val |= d->i.bmdma[0].status << 16;
>> +        val |= d->i.bmdma[1].status << 24;
>> +        break;
>
> Hi. Coverity points out (CID 1385151) that the << 24 here will
> potentially inadvertently set the high 32 bits of val if the top
> bit in bmdma[1].status is 1. (This is because in x << 24 where
> x is uint8_t x gets promoted to signed int, and then when that
> signed int with a high bit set is converted to uint64_t for the
> logical or it's done by sign-extending.
>
> Adding a cast, like
>  val |= (uint32_t)d->i.bmdma[1].status << 24;
>
> should fix this.

Sent another patch for this. Also adding casts to similar places (some of 
which might not be needed but should not hurt and there for symmetry).

Thank you,
BALATON Zoltan
