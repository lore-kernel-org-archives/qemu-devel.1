Received: from eggs.gnu.org ([2001:4830:134:3::10]:60228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpLP1-0002si-Ob
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 17:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpLOx-0003dN-1L
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 17:28:59 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpLOw-0003cm-QJ
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 17:28:54 -0400
Received: by mail-wr0-x22e.google.com with SMTP id a47so9185988wra.1
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 14:28:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cfc75c71-1558-3405-8e5c-188cdb329bfe@amsat.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-2-git-send-email-peter.maydell@linaro.org>
	<cfc75c71-1558-3405-8e5c-188cdb329bfe@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 22:28:32 +0100
Message-ID: <CAFEAcA_OcZ6SzGioQcscv2YQZ1t_xGB3fg7iJrJKui3gwwoKQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 01/20] target/arm: Implement
 ARMv8M's PMSAv8 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 5 September 2017 at 20:16, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> Hi Peter,
>
>
> On 08/22/2017 12:08 PM, Peter Maydell wrote:
>>   diff --git a/target/arm/machine.c b/target/arm/machine.c
>> index 3193b00..05e2909 100644
>> --- a/target/arm/machine.c
>> +++ b/target/arm/machine.c
>> @@ -159,7 +159,8 @@ static bool pmsav7_needed(void *opaque)
>>       CPUARMState *env =3D &cpu->env;
>>         return arm_feature(env, ARM_FEATURE_PMSA) &&
>> -           arm_feature(env, ARM_FEATURE_V7);
>> +           arm_feature(env, ARM_FEATURE_V7) &&
>> +           !arm_feature(env, ARM_FEATURE_V8);
>>   }
>>     static bool pmsav7_rgnr_vmstate_validate(void *opaque, int version_i=
d)
>> @@ -209,6 +210,31 @@ static const VMStateDescription vmstate_pmsav7_rnr =
=3D
>> {
>>       }
>>   };
>>   +static bool pmsav8_needed(void *opaque)
>> +{
>> +    ARMCPU *cpu =3D opaque;
>> +    CPUARMState *env =3D &cpu->env;
>> +
>> +    return arm_feature(env, ARM_FEATURE_PMSA) &&
>> +        arm_feature(env, ARM_FEATURE_V8);
>> +}
>> +
>> +static const VMStateDescription vmstate_pmsav8 =3D {
>> +    .name =3D "cpu/pmsav8",
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .needed =3D pmsav8_needed,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_VARRAY_UINT32(env.pmsav8.rbar, ARMCPU, pmsav7_dregion, =
0,
>> +                              vmstate_info_uint32, uint32_t),
>> +        VMSTATE_VARRAY_UINT32(env.pmsav8.rlar, ARMCPU, pmsav7_dregion, =
0,
>> +                              vmstate_info_uint32, uint32_t),
>> +        VMSTATE_UINT32(env.pmsav8.mair0, ARMCPU),
>> +        VMSTATE_UINT32(env.pmsav8.mair1, ARMCPU),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
>>                       VMStateField *field)
>>   {
>>
>
> maybe you plan to add migration between version 22 and 23 in a later patc=
h,
> else
>
> ...
> const VMStateDescription vmstate_arm_cpu =3D {
>     ...
>     .subsections =3D (const VMStateDescription*[]) {
>         ...
>         &vmstate_pmsav8,
>
> do not forget this ^

Whoops, yes, I forgot that bit. I'm surprised the compiler
didn't complain about the unused variables...

There's no need to worry about migration compat in any
of these v8M-specific vmstate structs, because right now
there are no QEMU CPUs with v8M enabled and so the
vmstate struct can't be used. That means we can freely
add fields to them in later patches without having to
bump version numbers or otherwise keep compatibility.
Once the patch which adds a cortex-m33 CPU lands in
master the rules will change and we'll need to be more
careful.


thanks
-- PMM
