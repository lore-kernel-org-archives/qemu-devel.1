Received: from eggs.gnu.org ([2001:4830:134:3::10]:58023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dUzXQ-0006FT-D1
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dUzXN-0000Fq-72
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:05:32 -0400
Received: from chuckie.co.uk ([82.165.15.123]:34644
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dUzXM-0000Eh-V0
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:05:29 -0400
References: <20170703113940.0e0415a2@nial.brq.redhat.com>
	<0efc917e-16d3-f01b-6fd8-a3bb71580bf4@ilande.co.uk>
	<20170707133320.2e0d741d@nial.brq.redhat.com>
	<1b4f1872-2ea2-8c10-593f-e2adf013b234@ilande.co.uk>
	<20170707164453.4ba325fd@nial.brq.redhat.com>
	<20170707150707.GJ10776@localhost.localdomain>
	<58f2d98e-ae7e-e2e7-e7f3-68e937b0b79f@ilande.co.uk>
	<20170710100147.0a7339e4@nial.brq.redhat.com>
	<20170710145331.GJ12152@localhost.localdomain>
	<20170710172336.33c64f86@nial.brq.redhat.com>
	<20170710173821.GD5167@localhost.localdomain>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <0abba0de-d15c-e43f-30ec-d31ae74ec325@ilande.co.uk>
Date: Tue, 11 Jul 2017 19:05:16 +0100
MIME-Version: 1.0
In-Reply-To: <20170710173821.GD5167@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv7 5/6] fw_cfg: move qdev_init_nofail() from
 fw_cfg_init1() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On 10/07/17 18:38, Eduardo Habkost wrote:

> On Mon, Jul 10, 2017 at 05:23:36PM +0200, Igor Mammedov wrote:
>> On Mon, 10 Jul 2017 11:53:31 -0300
>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>>
>>> On Mon, Jul 10, 2017 at 10:01:47AM +0200, Igor Mammedov wrote:
>>>> On Fri, 7 Jul 2017 17:20:25 +0100
>>>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
>>>>   
>>>>> On 07/07/17 16:07, Eduardo Habkost wrote:
>>>>>   
>>>>>>> looks fine,
>>>>>>>
>>>>>>> so what I'd do is:
>>>>>>>  * drop 4/6    
>>>>>
>>>>> Yes.
>>>>>   
>>>>>> Agreed on this point.  But:
>>>>>>     
>>>>>>>  * make fw_cfg_find() use ambiguous argument and error_abort if ambiguous == true    
>>>>>
>>>>> During my latest tests I've found that everything works fine without the
>>>>> ambiguous argument.
>>>>>
>>>>> Do we still want to keep it? And I don't think error_abort() is the
>>>>> right thing to do here, I'd much rather return NULL and add a suitable
>>>>> comment.  
>>>> I'd still use ambiguous argument and since you prefer not to assert
>>>> I'd add errp argument to fw_cfg_find() and handle error at callsites.
>>>>
>>>> Just returning NULL isn't sufficient if you need to distinguish
>>>> 'not found' vs 'duplicate' usecases, additionally  'not found'
>>>> in most cases isn't even error but 'duplicate' definitely is.
>>>>
>>>> Aborting on diplicate in fw_cfg_find() is fine and would
>>>> help to avoid touching current callers if you wish to limit
>>>> patches scope, but you can go with proper error propagating
>>>> route if you wish.  
>>>
>>> Just making realize refuse to create two devices sounds much
>>> simpler to me.  No need to make fw_cfg_find() more complex (if we
>>> add errp argument to it) or less useful (if we add
>>> assert(!ambiguous) to it).
>> the problem here was a error message to print if fw_cfg_find()
>> returns NULL for missing or duplicate, if we need to print
>> precise error we would need proper error handling.
> 
> I don't see where we would need a precise error message, except
> for realizefn (where the only case fw_cfg_find() would return
> NULL is for duplicate devices).
> 
>>
>> Considering to fw_cfg is builtin device I'd prefer just
>> assert in fw_cfg_find() on duplicate (all the callers consider it as error)
>> and let developer to deal with assert if it is triggered.
> 
> Except that it would make it more difficult for realizefn to
> return a proper error message.
> 
> Anyway, I am not completely against adding assert(!ambiguous) to
> fw_cfg_find() if Mark wants to follow your advice.  I just think
> it's not necessary.  I will only continue discussing this if I
> see issues in the next version of the series.

I agree that it's also not necessary. The aim of the patch is to get the
fw_cfg device to the point where it can be instantiated directly via
qdev - and while the patch does use fw_cfg_find() to help with that,
fw_cfg_find() has other callers too and I feel that it goes beyond the
scope of the patch to start changing those semantics too.

As freeze is coming up next week, I will post a v8 shortly.


ATB,

Mark.
