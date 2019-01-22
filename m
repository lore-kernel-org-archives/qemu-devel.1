Received: from eggs.gnu.org ([209.51.188.92]:33285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glsaw-0002s6-9p
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glsau-0004tJ-Ak
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:43:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glsaq-0004ni-Io
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:43:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so26500713wrt.7
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 01:43:37 -0800 (PST)
References: <20190121184314.14311-1-peter.maydell@linaro.org>
	<383fd07d-9c2a-a7b2-5b88-f9a411c8b91a@redhat.com>
	<CAFEAcA9G7CuZ3wSO9YLs-OH4m1zQ7s73yWp8rwsDBSyUZokyGg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0941b5d5-b399-7306-6779-7c82e53e08c1@redhat.com>
Date: Tue, 22 Jan 2019 10:43:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9G7CuZ3wSO9YLs-OH4m1zQ7s73yWp8rwsDBSyUZokyGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] xlnx-zynqmp: Don't create rpu-cluster if
 there are no RPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, Luc Michel <luc.michel@greensocs.com>, "patches@linaro.org" <patches@linaro.org>

On 1/22/19 10:28 AM, Peter Maydell wrote:
> On Mon, 21 Jan 2019 at 20:12, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Hi Peter,
>>
>> On 1/21/19 7:43 PM, Peter Maydell wrote:
>>> If we aren't going to create any RPUs, then don't create the
>>> rpu-cluster unit. This allows us to add an assertion to the
>>> cluster object that it contains at least one CPU, which helps
>>> to avoid bugs in creating clusters and putting CPUs in them.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> This is a preparatory patch that is necessary for the series
>>> "[PATCH v3 0/4] tcg: support heterogenous CPU clusters"
>>> (20190121152218.9592-1-peter.maydell@linaro.org)
>>> in order to avoid the xlnx-zcu102 board asserting if started with
>>> fewer than 5 CPUs.
>>>
>>>  hw/arm/xlnx-zynqmp.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
>>> index 370b0e44a38..16cba433cb7 100644
>>> --- a/hw/arm/xlnx-zynqmp.c
>>> +++ b/hw/arm/xlnx-zynqmp.c
>>> @@ -178,6 +178,11 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
>>>      int i;
>>>      int num_rpus = MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYNQMP_NUM_RPU_CPUS);
>>
>> Not related to this patch, but this check seems dangerous, i.e. using
>> "-smp 2" we get num_rpus=-2 which luckyly doesn't enter the for() loop.
>>
>>>
>>> +    if (num_rpus == 0) {
>>
>> With the current codebase, you'd have to check for "num_rpus <= 0", ...
> 
> Oops, nice catch.
> 
>> What about this instead?
>>
>> -- >8 --
>> @@ -451,10 +451,12 @@ static void xlnx_zynqmp_realize(DeviceState *dev,
>> Error **errp)
>>                      "RPUs just use -smp 6.");
>>      }
>>
>> -    xlnx_zynqmp_create_rpu(s, boot_cpu, &err);
>> -    if (err) {
>> -        error_propagate(errp, err);
>> -        return;
>> +    if (smp_cpus > XLNX_ZYNQMP_NUM_APU_CPUS) {
>> +        xlnx_zynqmp_create_rpu(s, boot_cpu, &err);
>> +        if (err) {
>> +            error_propagate(errp, err);
>> +            return;
>> +        }
>>      }
> 
> Yeah, that would work too. I think I would just go for
> using "if (num_rpus <= 0)" in the function, though.

OK, whichever patch you prefer, you can add:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Regards,

Phil.

> 
> thanks
> -- PMM
> 
