Received: from eggs.gnu.org ([2001:4830:134:3::10]:53754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fCBG2-0003go-2m
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 17:50:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fCBFx-0005na-MC
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 17:50:22 -0400
Date: Fri, 27 Apr 2018 23:50:15 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA8TbXCR=pqpyueUN3ZLiup+NBxyZsh3ZwpuNRQdpq65Lg@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1804272338470.26364@zero.eik.bme.hu>
References: <20180216100617.25265-1-david@gibson.dropbear.id.au>
	<20180216100617.25265-15-david@gibson.dropbear.id.au>
	<CAFEAcA8TbXCR=pqpyueUN3ZLiup+NBxyZsh3ZwpuNRQdpq65Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PULL 14/14] ppc4xx: Add device models found in
 PPC440 core SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>, surajjs@au1.ibm.com

On Fri, 27 Apr 2018, Peter Maydell wrote:
> On 16 February 2018 at 10:06, David Gibson <david@gibson.dropbear.id.au> wrote:
>> From: BALATON Zoltan <balaton@eik.bme.hu>
>>
>> These devices are found in newer SoCs based on 440 core e.g. the 460EX
>> (http://www.embeddeddeveloper.com/assets/processors/amcc/datasheets/
>> PP460EX_DS2063.pdf)
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>
>> +static target_ulong sdram_size(uint32_t bcr)
>> +{
>> +    target_ulong size;
>> +    int sh;
>> +
>> +    sh = 1024 - ((bcr >> 6) & 0x3ff);
>> +    if (sh == 0) {
>> +        size = -1;
>> +    } else {
>> +        size = 8 * M_BYTE * sh;
>> +    }
>> +
>> +    return size;
>> +}
>
> Hi. Coverity (CID 1390588) points out that the calculation
> "1024 - ((bcr >> 6) & 0x3ff" must result in a value of sh
> between 1 and 1024, and therefore the "sh == 0" branch of
> the if() is dead code.
>
> Is there an error in the size calculation here?

Likely this is not entirely correct (see also the FIXME comment in 
sam460ex.c:73) but I still could not obtain the user manual of the SoC 
where I think this is documented so I don't really know what's the correct 
way here and I don't have time at the moment to try to guess from 
accessible sources (such as Linux and U-Boot). So for now I'd leave it as 
it is until I can find out what would be correct here but if the warning 
from Coverity is in your way feel free to patch this to remove the sh == 0 
which should be OK if it can't ever happen.

Regards,
BALATON Zoltan
