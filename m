Received: from eggs.gnu.org ([2001:4830:134:3::10]:57110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etF4O-0000FO-Jr
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:04:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etF4M-0001J5-Gq
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:04:04 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:39281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etF4M-0001Ip-B9
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:04:02 -0500
Received: by mail-ot0-x242.google.com with SMTP id h8so18796216oti.6
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 08:04:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306161617.07459ef6@redhat.com>
References: <20180306125526.27838-1-peter.maydell@linaro.org>
	<20180306125526.27838-5-peter.maydell@linaro.org>
	<20180306161617.07459ef6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 16:03:40 +0000
Message-ID: <CAFEAcA8bHYcCkwVLCqp7YTBSF5kH96i343CfY1-wEAB=0Ka4vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 4/6] target/arm: Make 'any' CPU just an
 alias for 'max'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "patches@linaro.org" <patches@linaro.org>

On 6 March 2018 at 15:16, Igor Mammedov <imammedo@redhat.com> wrote:
> On Tue,  6 Mar 2018 12:55:24 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> Now we have a working '-cpu max', the linux-user-only
>> 'any' CPU is pretty much the same thing, so implement it
>> that way.
>>
>> For the moment we don't add any of the extra feature bits
>> to the system-emulation "max", because we don't set the
>> ID register bits we would need to to advertise those
>> features as present.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/arm/cpu.c   | 50 +++++++++++++++++++++++----------------------
>>  target/arm/cpu64.c | 59 ++++++++++++++++++++++++++----------------------------
>>  2 files changed, 54 insertions(+), 55 deletions(-)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index e46ddcc613..c8d3da2140 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -965,9 +965,17 @@ static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
>>      ObjectClass *oc;
>>      char *typename;
>>      char **cpuname;
>> +    const char *cpunamestr;
>>
>>      cpuname = g_strsplit(cpu_model, ",", 1);
>> -    typename = g_strdup_printf(ARM_CPU_TYPE_NAME("%s"), cpuname[0]);
>> +    cpunamestr = cpuname[0];
>> +#ifdef CONFIG_USER_ONLY
>> +    /* For backwards compatibility usermode emulation allows "-cpu any",
>> +     * which has the same semantics as "-cpu max".
>> +     */
>> +    cpunamestr = "max";
> shouldn't it be
>  if (!strcmp(cpuname[0], "any")) {
>      cpunamestr = "max";
>  }

Yes. I shuffled the code around a bit and managed to lose the
comparison...


>> @@ -1789,7 +1791,7 @@ static const ARMCPUInfo arm_cpus[] = {
>>      { .name = "max",         .initfn = arm_max_initfn },
>>  #endif
>>  #ifdef CONFIG_USER_ONLY
>> -    { .name = "any",         .initfn = arm_any_initfn },
>> +    { .name = "any",         .initfn = arm_max_initfn },
> Note,
>  'any' will disappear from "-cpu help"
> but that's probably fine, old users would still be able to use alias
> and new ones won't even suspect about its existence and use 'max'.

Yeah, I guess that's OK.

thanks
-- PMM
