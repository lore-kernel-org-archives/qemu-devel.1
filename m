Received: from eggs.gnu.org ([2001:4830:134:3::10]:44446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eddCo-00012K-4Y
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:36:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eddCl-00016C-Fa
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:36:14 -0500
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:35210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eddCl-00015X-7P
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:36:11 -0500
Received: by mail-pg0-x229.google.com with SMTP id o13so2096476pgs.2
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 06:36:10 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <1516326941-11832-1-git-send-email-minyard@acm.org>
	<20180119051309-mutt-send-email-mst@kernel.org>
	<19605015-5d30-f91e-3344-32ae4555a7dd@acm.org>
	<3dc61d47-9315-0d59-912d-9952cbff970c@acm.org>
	<c027971f-e8e0-2cb1-4411-1cf93dc03eb4@reactos.org>
From: Corey Minyard <minyard@acm.org>
Message-ID: <e5713994-931a-d69d-b909-2af9fbb28a53@acm.org>
Date: Mon, 22 Jan 2018 08:36:06 -0600
MIME-Version: 1.0
In-Reply-To: <c027971f-e8e0-2cb1-4411-1cf93dc03eb4@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH] Revert "smbus: do not immediately complete
 commands"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Corey Minyard <cminyard@mvista.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 01/21/2018 11:36 AM, Hervé Poussineau wrote:
> Le 19/01/2018 à 22:15, Corey Minyard a écrit :
>> On 01/19/2018 08:07 AM, Corey Minyard wrote:
>>> On 01/18/2018 09:17 PM, Michael S. Tsirkin wrote:
>>>> On Thu, Jan 18, 2018 at 07:55:41PM -0600, minyard@acm.org wrote:
>>>>> From: Corey Minyard <cminyard@mvista.com>
>>>>>
>>>>> This reverts commit 880b1ffe6ec2f0ae25cc4175716227ad275e8b8a.
>>>>>
>>>>> The commit being reverted says:
>>>>>
>>>>>      PIIX4 errata says that "immediate polling of the Host Status 
>>>>> Register BUSY
>>>>>      bit may indicate that the SMBus is NOT busy."
>>>>>      Due to this, some code does the following steps:
>>>>>      (a) set parameters
>>>>>      (b) start command
>>>>>      (c) check for smbus busy bit set (to know that command started)
>>>>>      (d) check for smbus busy bit not set (to know that command 
>>>>> finished)
>>>>>
>>>>>      Let (c) happen, by immediately setting the busy bit, and 
>>>>> really executing
>>>>>      the command when status register has been read once.
>>>>>
>>>>>      This fixes a problem with AMIBIOS, which can now properly 
>>>>> initialize the
>>>>>      PIIX4.
>>>>>
>>>>> Emulating bad hardware so badly written software will work doesn't 
>>>>> sound
>>>>> like a good idea to me.  I have patches that add interrupt capability
>>>>> to pm_smbus, but this change breaks that because the Linux driver
>>>>> starts the transaction then waits for interrupts before reading the
>>>>> status register.  That obviously won't work with these changes.
>>>>>
>>>>> The right way to fix this in AMIBIOS is to ignore the host busy bit
>>>>> and use the other bits in the host status register to tell if the
>>>>> transaction has completed.  Using host busy is racy, anyway, if you
>>>>> get interrupted or something while processing, you may miss step (c)
>>>>> in your algorithm and fail.
>>>>>
>>>>> Cc: Hervé Poussineau <hpoussin@reactos.org>
>>>>> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>>>> Would it be possible to limit the change to when guest uses
>>>> interrupts?
>>>
>>> I did think about that, but it seems rather frail.  What if another 
>>> piece of software
>>> does this but has the interrupt enable bit set?  And AMIBIOS is 
>>> still broken doing
>>> that algorithm on real hardware.  If you get a bus collision, for 
>>> instance, that will
>>> be almost instantaneous and the firmware is likely to miss it.
>>>
>>> The 82801 documentation is pretty clear that you should use the INTR 
>>> and error
>>> bits in the status register to know if a transaction is complete.
>>>
>>> If you really want to emulate real hardware, I guess the right way 
>>> to do this
>>> would be to add a delay between the start bit being set and the 
>>> transaction
>>> being done.  I'm not sure how timers work with vmstate, I'd have to 
>>> look at
>>> that.
>>
>> I realized that the timer is not going to be able to correctly work 
>> around the
>> AMIBIOS.  It would probably work most of the time, but if qemu got 
>> switched
>> out, then switched back and the timer went off before the guest was 
>> allowed
>> to run, then you would have the same issue.
>>
>> Also, looking at a more complete implementation of the pm_smbus device,
>> using the host busy bit to know when to start the transaction won't 
>> work,
>> that bit also does other things when doing byte at a time block 
>> transfers.
>> So a separate bool is needed to know when to do this.
>
> AMIBIOS can't be fixed to do the right thing.

That's a real bummer.

> My first implementation of this patch was using a timer, and it was 
> working quite well.
> I don't think that smbus is very latency-sensitive, so I think a timer 
> is a valid
> solution to this problem. If a timer also works for your use case, 
> I'll be happy with it.

A timer is not a 100% guaranteed solution.  It should work most of the 
time, but if you
get a situation like I describe above, it is possible for the BIOS to 
miss the setting of the
busy bit.

I've modified my code that adds interrupts to use your solution only 
when interrupts are
disabled  Unfortunately, the current pm_smbus.c code is a fairly 
incomplete implementation
of the device, so I can't do a patch to the main tree for that change.

-corey

>
> See my patch proposal to use a timer instead. Does it fit your needs?
>
> An improvement might be to execute the command either on the timer or 
> when the guest
> reads the host status register.
>
> Regards,
>
> Hervé
