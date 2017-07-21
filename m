Received: from eggs.gnu.org ([2001:4830:134:3::10]:52042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dYSzy-00070b-DV
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dYSzu-0008L6-9b
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:09:22 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:60096
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dYSzu-0008KY-0u
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:09:18 -0400
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-iWRqhNhrJsrvODRunkwMGTUsTMfhdHZw3aCjoc3p1Mg@mail.gmail.com>
	<CAJy5ezpvpohU5x48WrKz57k9+s39hkSCUm+f_u2qf7E0Zin7Mw@mail.gmail.com>
	<20170717185830.GD31820@work-vm>
	<CAFEAcA-yt=fkPrGL_6X_A8n=+u5YuX1+V82Sc7+2MeuA38kH0A@mail.gmail.com>
	<20170720100232.GA2456@work-vm>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <408f467d-08dc-bb3e-0bfc-9825ca07107c@adacore.com>
Date: Fri, 21 Jul 2017 10:09:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170720100232.GA2456@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v1 0/7] MMIO Exec pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>



On 07/20/2017 12:02 PM, Dr. David Alan Gilbert wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> On 17 July 2017 at 19:58, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
>>> * Edgar E. Iglesias (edgar.iglesias@gmail.com) wrote:
>>>> Is there a way we can prevent migration of the RAMBlock?
>>>
>>> Not yet, I think we'd have to:
>>>     a) Add a flag to the RAMBlock
>>>     b) Set it/clear it on registration
>>>     c) Have a RAMBLOCK_FOREACH_MIGRATABLE macro
>>>     d) Replace all of the RAMBLOCK_FOREACH (and the couple of hand coded
>>>     cases) with the RAMBLOCK_FOREACH_MIGRATABLE
>>>     e) Worry about the corner cases!
>>>
>>> I've got a few worries about what happens when the kernel tries to
>>> do dirty yncing - I'm not sure if we have to change anything on that
>>> interface to skip those RAMBlocks.
>>
>> OK, so what should we do for 2.10 ?
>>
>> We could:
>>   * implement the changes you suggest above, and mark only
>>     vmstate_register_ram'd blocks as migratable
>>     (would probably need to fix some places which buggily
>>     don't call vmstate_register_ram)
>>   * implement the changes above, but special case mmio-interface
>>     so only its ramblock is marked unmigratable
> 
> I think either of these is too late for 2.10 - I don't fancy prodding
> about in all of the migration RAM loops at this stage.
> 
>>   * postpone the changes above until 2.11, and for 2.10 register
>>     a migration-blocker in mmio-interface so that we at least
>>     give the user a useful error rather than having it fail
>>     obscurely on vmload (and release note this)
> 
> I think that's best, especially because I've just thought of another nasty.
> If I understand the way mmio-interface is working, you're dynamically
> changing the RAMBlock list while the guest is running.
> And while we are using QLIST_FOREACH_RCU I'm not convinced we're
> actually safe against dynamic modification of that list.

Hi Dave,

Hmmm I'm not totally convinced..

Let's imagine somebody (eg: u-boot guest) wants to execute code
from the LQSPI area.

memory_region_request_mmio_ptr is called (the guest is not
running yet) it will create a mmio-interface which create the
ram memory region with a pointer provided by the device.
Then the guest can execute code from that and this somehow is
breaking migration because this ram memory region is migrated.

Now something is writing to the device.. The cache is no longer
valid, we have to drop this mmio-interface. This is done in an
async_safe work so cpu are stopped at this moment. So I think we
are safe for that.

> 
>> (Or something else?)
>>
>> I do think we definitely need to fix this for 2.11 at latest.
> 
> OK, I can do a-e OK, I'm more worried now about that dynamic
> modification I just thought of.
> 

What's an a-e?

BTW sorry for this pain :( I didn't figure out that the
ram MemoryRegion would be migrated..

Thanks,
Fred

> Dave
> 
>> thanks
>> -- PMM
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
