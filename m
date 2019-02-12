Received: from eggs.gnu.org ([209.51.188.92]:41232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gtbHd-0008NZ-Bw
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gtbHa-0001WU-W6
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:51:45 -0500
References: <20190210174421.22062-1-mark.cave-ayland@ilande.co.uk>
	<442139a2-5ab2-9259-03a0-11d2f3c86c59@redhat.com>
	<28a8cd58-51a9-6301-1d25-02289af8c81d@ilande.co.uk>
	<alpine.BSF.2.21.9999.1902121157470.75929@zero.eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <971ba38d-d883-d51c-55b2-531639336ed4@ilande.co.uk>
Date: Tue, 12 Feb 2019 16:51:25 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1902121157470.75929@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
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
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, hsp.cat7@gmail.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 12/02/2019 11:03, BALATON Zoltan wrote:

> On Tue, 12 Feb 2019, Mark Cave-Ayland wrote:
>> On 11/02/2019 23:35, Philippe Mathieu-Daudé wrote:
>>
>>> Hi Mark,
>>>
>>> On 2/10/19 6:44 PM, Mark Cave-Ayland wrote:
>>>> In order to handle a race condition in MacOS 9, a delay was introduced when
>>>> raising the VIA SR interrupt inspired by similar code in MacOnLinux.
>>>>
>>>> During original testing of the MacOS 9 patches it was found that the 30us
>>>> delay used in MacOnLinux did not work reliably within QEMU, and a value of
>>>> 300us was required to function correctly.
>>>>
>>>> Recent experiments have shown that the previous reliability issues are no
>>>> longer present, and this value can be reduced down to 20us with no apparent
>>>> ill effects in my local tests. This has the benefit of considerably improving
>>>> the responsiveness of the ADB keyboard and mouse with the guest.
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> ---
>>>>  hw/misc/macio/cuda.c | 11 +----------
>>>>  1 file changed, 1 insertion(+), 10 deletions(-)
>>>>
>>>> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
>>>> index c4f7a2f39b..3febacdd1e 100644
>>>> --- a/hw/misc/macio/cuda.c
>>>> +++ b/hw/misc/macio/cuda.c
>>>> @@ -97,17 +97,8 @@ static void cuda_set_sr_int(void *opaque)
>>>>
>>>>  static void cuda_delay_set_sr_int(CUDAState *s)
>>>>  {
>>>> -    MOS6522CUDAState *mcs = &s->mos6522_cuda;
>>>> -    MOS6522State *ms = MOS6522(mcs);
>>>> -    MOS6522DeviceClass *mdc = MOS6522_DEVICE_GET_CLASS(ms);
>>>>      int64_t expire;
>>>>
>>>> -    if (ms->dirb == 0xff || s->sr_delay_ns == 0) {
>>>> -        /* Disabled or not in Mac OS, fire the IRQ directly */
>>>> -        mdc->set_sr_int(ms);
>>>> -        return;
>>>> -    }
>>>
>>> The change of sr_delay_ns below is well explained, but I don't
>>> understand why you remove the previous if().
>>
>> IIRC it was a hack by Alex to try and restrict the delay on the interrupt just to
>> MacOS instead of Linux, but with the reduced value it doesn't really matter any more.
> 
> If this delay is to prevent a bug which only happens in MacOS then that's the hack
> not the normal code path to run without the delay that you've just removed. So maybe
> this should be kept if possible to avoid unecessary delays for other guests.
> (Although if this only affects mac99,via=cuda but not mac99,via=pmu then I don't care
> much as long as pmu works.)

Well the reality is that the detection above doesn't actually seem to work anyway -
at least a quick boot test with Linux, MacOS X and MacOS 9 with a printf() added into
the if() shows nothing firing once the kernel takes over. So the slow path with the
delay included was always being taken within the OS anyway.

And indeed, the code doesn't affect pmu so you won't see any difference there.

>> As a plus it also prevents a guest OS from accidentally triggering the hack whilst
>> programming the VIA port.
> 
> That may be a problem though. What's the issue exactly? Why is the delay needed in
> the first place?

It's some kind of racy polling with OS 9 (I wasn't involved in the technical details,
sorry) which causes OS 9 to hang on boot if the delay isn't present. And even better
the slow path that was previously always being taken has now been reduced from 300us
to 30us so whichever way you look at it, having this patch applied is a win.


ATB,

Mark.
