Received: from eggs.gnu.org ([2001:4830:134:3::10]:55369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fY5A8-0008WB-AM
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fY5A5-0003KR-5n
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:46:48 -0400
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:47807)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fY5A4-0003Jd-UC
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:46:45 -0400
Received: from player734.ha.ovh.net (unknown [10.109.120.40])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 19F83E5CEA
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 09:46:43 +0200 (CEST)
References: <20180626135928.23950-1-clg@kaod.org>
	<20180627033321-mutt-send-email-mst@kernel.org>
	<1d70c0f9179990cd33d7c82c5190179e60ae4ce3.camel@kernel.crashing.org>
	<20180627072825.GH14434@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <65c545f3-6279-62af-9bd8-2be93a3d7d18@kaod.org>
Date: Wed, 27 Jun 2018 09:46:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180627072825.GH14434@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Add model for Power8 PHB3 PCIe
 Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>

On 06/27/2018 09:28 AM, David Gibson wrote:
> On Wed, Jun 27, 2018 at 11:38:17AM +1000, Benjamin Herrenschmidt wrote:
>> On Wed, 2018-06-27 at 03:35 +0300, Michael S. Tsirkin wrote:
>>>
>>>> +
>>>> +/* Extract field fname from val */
>>>> +#define GETFIELD(fname, val)                    \
>>>> +        (((val) & fname##_MASK) >> fname##_LSH)
>>>> +
>>>> +/* Set field fname of oval to fval
>>>> + * NOTE: oval isn't modified, the combined result is returned
>>>> + */
>>>> +#define SETFIELD(fname, oval, fval)                     \
>>>> +        (((oval) & ~fname##_MASK) | \
>>>> +         ((((typeof(oval))(fval)) << fname##_LSH) & fname##_MASK))
>>>> +
>>>
>>> Pls don't make up macros like these. We can't have each device do it.
>>
>> So what ? We move the macros in a generic place ? These are MUCH better
>> than open-coding the masks & shifts and much less error prone.
> 
> There are already deposit32 and deposit64() functions which I think
> would cover this.

OK. I understand but we can't include target/ppc/cpu.h in this file
either and we want to use these specific macros to keep the register 
definition file similar to the one in skiboot.

Is their a common area for such needs ? 

>>
>>>> @@ -1031,6 +1110,7 @@ static Property pnv_chip_properties[] = {
>>>>      DEFINE_PROP_UINT64("ram-size", PnvChip, ram_size, 0),
>>>>      DEFINE_PROP_UINT32("nr-cores", PnvChip, nr_cores, 1),
>>>>      DEFINE_PROP_UINT64("cores-mask", PnvChip, cores_mask, 0x0),
>>>> +    DEFINE_PROP_UINT32("num-phbs", PnvChip, num_phbs, 1),
>>>>      DEFINE_PROP_END_OF_LIST(),
>>>>  };
>>>
>>> How about instanciating each extra phb using -device?
>>> Seems better than teaching everyone about platform-specific
>>> options.
>>
>> It's about which PHBs are enabled, not which are instanciated, if I
>> understand Cedric changes ...
>>
>> This aims are implementing the POWER8 chip correctly, it has a fixed
>> number of PHBs per-chip at very specific XSCOM addresses, that the
>> firwmare knows about.
> 
> Yeah, this is a recurring design conflict, which I'm not sure how to
> address.  Usually instantiating things with -device works better, but
> when do we do when that allows more flexibility with hardware
> arrangement than is actually possible in the hardware.
> 

So the "IBM PHB3 PCIE Root Port" is already user createable.

I can take a look at user createable PHB3s. I think this is OK from a model
perspective. The object is rather standalone, it needs the machine for 
the XICS fabric and a couple of ids, phb id and chip id. These can come
from the command line.

We want at least one PHB3 per socket/chip though. 

C. 
