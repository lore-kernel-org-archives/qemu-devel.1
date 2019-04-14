Received: from eggs.gnu.org ([209.51.188.92]:51159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hFmcS-0002Wb-2H
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 17:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hFmcR-0002gJ-1i
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 17:24:56 -0400
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
	<1555103178-21894-5-git-send-email-atar4qemu@gmail.com>
	<29f79530-fd9e-ea60-8cf3-df593b855f10@reactos.org>
	<CACXAS8De=OS0O4O2=Q721KCUc9RuQryOGNfedejM+yzWcX9aOg@mail.gmail.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <4eec1d45-01a6-1c96-ee49-6c3131823b83@reactos.org>
Date: Sun, 14 Apr 2019 23:24:43 +0200
MIME-Version: 1.0
In-Reply-To: <CACXAS8De=OS0O4O2=Q721KCUc9RuQryOGNfedejM+yzWcX9aOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/isa/i82378.c: use 1900 as a base
 year
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "open list:PReP" <qemu-ppc@nongnu.org>

Le 14/04/2019 à 20:53, Artyom Tarasenko a écrit :
> On Sun, Apr 14, 2019 at 7:01 PM Hervé Poussineau <hpoussin@reactos.org> wrote:
>>
>> Le 12/04/2019 à 23:06, Artyom Tarasenko a écrit :
>>> AIX 5.1 expects the base year to be 1900. Adjust accordingly.
>>>
>>> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
>>> ---
>>>    hw/isa/i82378.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
>>> index a5d67bc..546c928 100644
>>> --- a/hw/isa/i82378.c
>>> +++ b/hw/isa/i82378.c
>>> @@ -107,7 +107,9 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
>>>        isa = isa_create_simple(isabus, "i82374");
>>>
>>>        /* timer */
>>> -    isa_create_simple(isabus, TYPE_MC146818_RTC);
>>> +    isa = isa_create(isabus, TYPE_MC146818_RTC);
>>> +    qdev_prop_set_int32(DEVICE(isa), "base_year", 1900);
>>> +    qdev_init_nofail(DEVICE(isa));
>>
>> I am not sure the base_year should be hardcoded in i82378. I can assume other machines with a i82378 can have another base_year.
> 
> I doubt it to be honest. How would it work in the hardware? Is there a
> pin which would switch a year?
> I do believe the different i823xx may have the different base years though.

OK, I don't really know. So, your patch looks fine.

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>

> 
>> Maybe you can you add a base_year property to i82378, and forward it to mc146818 with object_property_add_alias?
>> Then, change 40p machine to set it to 1900, without changing it for prep machine.
> 
> Were you not going to drop the -M prep ? Because I sort of dropped the
> support for it in OFW.
> I had a branch were I added some registers to -M prep  enough that it
> would be able to turn itself out as a PowerStack II Utah,
> but then again I couldn't find any advantage of having two PReP machines.
> AFAIK, the only OS which can run on Powerstack, but not on 40p is Motorola AIX.
> But since we can have IBM AIX, I don't see why would we want to keep -M prep.

I really want to drop support for prep. But, as long as prep is in code base, we shouldn't regress it too much.

> 
> On the other hand, if you plan to revive it, I'll think about adding
> the support for it to OFW.
> PowerStack had a Cirrus VGA which we already have.
> 
>>>    }
>>>
>>>    static void i82378_init(Object *obj)
>>>
>>
>> Hervé
> 
> 
> 
