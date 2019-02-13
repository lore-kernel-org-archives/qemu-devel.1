Received: from eggs.gnu.org ([209.51.188.92]:34158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gtoeh-0004cZ-72
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gtoeY-00013J-T6
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:08:22 -0500
References: <20190210174421.22062-1-mark.cave-ayland@ilande.co.uk>
	<442139a2-5ab2-9259-03a0-11d2f3c86c59@redhat.com>
	<28a8cd58-51a9-6301-1d25-02289af8c81d@ilande.co.uk>
	<alpine.BSF.2.21.9999.1902121157470.75929@zero.eik.bme.hu>
	<971ba38d-d883-d51c-55b2-531639336ed4@ilande.co.uk>
	<d78bc91b-efef-bb69-e443-6526ca433197@redhat.com>
	<e8329ece-32a2-d591-2ffc-3cdb468d56aa@ilande.co.uk>
	<bff82e7a-2315-fd42-cdae-e7d0baa2fd08@redhat.com>
	<de84d0a5-1942-5a22-b71e-e9bf888a0fc1@ilande.co.uk>
	<20190213002118.GR1884@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3b91465d-b5bd-e9ba-bc3d-871a9d8269e2@ilande.co.uk>
Date: Wed, 13 Feb 2019 07:08:08 +0000
MIME-Version: 1.0
In-Reply-To: <20190213002118.GR1884@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] cuda: decrease time delay
 before raising VIA SR interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, hsp.cat7@gmail.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org

On 13/02/2019 00:21, David Gibson wrote:

> On Tue, Feb 12, 2019 at 08:01:22PM +0000, Mark Cave-Ayland wrote:
>> On 12/02/2019 18:21, Philippe Mathieu-Daudé wrote:
>>
>>> On 2/12/19 6:50 PM, Mark Cave-Ayland wrote:
>>>> On 12/02/2019 17:21, Philippe Mathieu-Daudé wrote:
>>>>
>>>>>>> If this delay is to prevent a bug which only happens in MacOS then that's the hack
>>>>>>> not the normal code path to run without the delay that you've just removed. So maybe
>>>>>>> this should be kept if possible to avoid unecessary delays for other guests.
>>>>>>> (Although if this only affects mac99,via=cuda but not mac99,via=pmu then I don't care
>>>>>>> much as long as pmu works.)
>>>>>>
>>>>>> Well the reality is that the detection above doesn't actually seem to work anyway -
>>>>>> at least a quick boot test with Linux, MacOS X and MacOS 9 with a printf() added into
>>>>>> the if() shows nothing firing once the kernel takes over. So the slow path with the
>>>>>> delay included was always being taken within the OS anyway.
>>>>>>
>>>>>> And indeed, the code doesn't affect pmu so you won't see any difference there.
>>>>>>
>>>>>>>> As a plus it also prevents a guest OS from accidentally triggering the hack whilst
>>>>>>>> programming the VIA port.
>>>>>>>
>>>>>>> That may be a problem though. What's the issue exactly? Why is the delay needed in
>>>>>>> the first place?
>>>>>>
>>>>>> It's some kind of racy polling with OS 9 (I wasn't involved in the technical details,
>>>>>> sorry) which causes OS 9 to hang on boot if the delay isn't present. And even better
>>>>>> the slow path that was previously always being taken has now been reduced from 300us
>>>>>> to 30us so whichever way you look at it, having this patch applied is a win.
>>>>>
>>>>> Can you write a paragraph about this, that David can amend to your
>>>>> patch? That would stop worrying me about looking at this patch in
>>>>> various months...
>>>>
>>>> Hmmmm well the existing description already describes the interrupt race in OS 9 so I
>>>> guess the only part missing is the bit about the fast path. How about the revised
>>>> text below for the patch description?
>>>>
>>>>
>>>>     cuda: decrease time delay before raising VIA SR interrupt and remove fast path
>>>>
>>>>     In order to handle a race condition in the MacOS 9 CUDA driver, a delay was
>>>>     introduced when raising the VIA SR interrupt inspired by similar code in
>>>>     MacOnLinux.
>>>>
>>>>     During original testing of the MacOS 9 patches it was found that the 30us
>>>>     delay used in MacOnLinux did not work reliably within QEMU, and a value of
>>>>     300us was required to function correctly.
>>>>
>>>>     Recent experiments have shown two things: firstly when booting Linux, MacOS
>>>>     9 and MacOS X the fast path which bypasses the delay is never triggered once the
>>>>     OS kernel is loaded making it effectively useless. Rather than leave this code
>>>>     in place where a guest could potentially enable it by accident and break itself,
>>>>     we might as well just remove it.
>>>>
>>>>     Secondly the previous reliability issues are no longer present, and this value
>>>>     can be reduced down to 20us with no apparent ill effects. This has the benefit of
>>>>     considerably improving the responsiveness of the ADB keyboard and mouse within
>>>>     the guest.
>>>>
>>>>     Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>
>>>
>>> Thanks!
>>>
>>> Phil.
>>
>> No worries. David, are you able to update the commit message in your ppc-for-4.0
>> branch accordingly?
> 
> Done.

Great, thanks!


ATB,

Mark.
