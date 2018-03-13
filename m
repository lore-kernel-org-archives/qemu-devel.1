Received: from eggs.gnu.org ([2001:4830:134:3::10]:36607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evt9x-0004NK-GL
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 19:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evt9u-0001HV-Bs
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 19:16:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-9-peter.maydell@linaro.org>
	<MWHPR21MB018983B74A652443B70680F19ED20@MWHPR21MB0189.namprd21.prod.outlook.com>
	<CAFEAcA8O7EEhoS83eRLH5bVmog_Qu1tAgUzR6NsE+GD2a7FsDw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <837c5be7-a153-5a7e-8e2c-dccdb9945a4e@amsat.org>
Date: Wed, 14 Mar 2018 00:16:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8O7EEhoS83eRLH5bVmog_Qu1tAgUzR6NsE+GD2a7FsDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/9] hw/arm/bcm2836: Hardcode correct CPU
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pekka Enberg <penberg@iki.fi>, "patches@linaro.org" <patches@linaro.org>

On 03/13/2018 06:09 PM, Peter Maydell wrote:
> On 13 March 2018 at 16:55, Andrew Baumann <Andrew.Baumann@microsoft.com> wrote:
>>> From: Qemu-devel <qemu-devel-
>>> bounces+andrew.baumann=microsoft.com@nongnu.org> On Behalf Of Peter
>>> Maydell
>>> Sent: Tuesday, 13 March 2018 08:35
>>>
>>> Now we have separate types for BCM2386 and BCM2387, we might as well
>>> just hard-code the CPU type they use rather than having it passed
>>> through as an object property. This then lets us put the initialization
>>> of the CPU object in init rather than realize.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
>>>  static const BCM283XInfo bcm283x_socs[] = {
>>>      {
>>>          .name = TYPE_BCM2836,
>>> +        .cpu_type = ARM_CPU_TYPE_NAME("cortex-a15"),
>>
>> At some point I remember seeing a patch to change this to cortex-a7. Is there a reason we didn't make that change?
>>
>> (Background: the real Pi2 has an A7. When I first implemented the machine model there was no A7 emulation in QEMU, so I used the A15 which was the closest equivalent.)
> 
> Yeah, we should do that. I'd forgotten about that, I think
> things just got lost in the shuffle of having several
> patchsets that tried to change the same things at once.
> 
> I guess the simplest thing is to add a patch at the end of
> the series that fixes the cpu type for bcm2836.

Peter, here is the patch Andrew remembered (maybe can be applied at the
end):
http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg04286.html

> 
> 
>>> --- a/hw/arm/raspi.c
>>> +++ b/hw/arm/raspi.c
>>> @@ -150,8 +150,6 @@ static void raspi_init(MachineState *machine, int
>>> version)
>>>      /* Setup the SOC */
>>>      object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
>>>                                     &error_abort);
>>> -    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
>>> -                            &error_abort);
>>>      object_property_set_int(OBJECT(&s->soc), smp_cpus, "enabled-cpus",
>>>                              &error_abort);
>>>      int board_rev = version == 3 ? 0xa02082 : 0xa21041;
>>
>> What about the default_cpu_type field of MachineClass set in
>> raspi[23]_machine_init? That seems irrelevant now...
> 
> Mmm. It doesn't hurt anything, though.
> 
>> Also, if anyone cares (I don't), we also just lost the ability
>> to override the CPU type of a raspi model.
> 
> Yeah, that's deliberate -- I think that letting the user randomly
> plug nonexistent combinations together just confuses people when
> they don't work. I guess I should call it out in the commit message
> though.
> 
> thanks
> -- PMM
> 
