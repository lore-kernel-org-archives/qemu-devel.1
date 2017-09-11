Received: from eggs.gnu.org ([2001:4830:134:3::10]:47682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1drSm8-0004f0-F3
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1drSm7-00062w-FY
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:45:36 -0400
MIME-Version: 1.0
In-Reply-To: <eece5841-17c1-a469-81e5-c65a518eca94@amsat.org>
References: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
	<1505137930-13255-8-git-send-email-peter.maydell@linaro.org>
	<eece5841-17c1-a469-81e5-c65a518eca94@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 11 Sep 2017 10:45:01 -0700
Message-ID: <CAKmqyKMgcmvZVYvfQJT9wv_pMr8MW9fU8jiuYk_FkKxbFt+rRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 7/7] target/arm: Rename 'type'
 to 'excret' in do_v7m_exception_exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On Mon, Sep 11, 2017 at 8:03 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On 09/11/2017 10:52 AM, Peter Maydell wrote:
>>
>> In the v7M and v8M ARM ARM, the magic exception return values are
>> referred to as EXC_RETURN values, and in QEMU we use V7M_EXCRET_*
>> constants to define bits within them. Rename the 'type' variable
>> which holds the exception return value in do_v7m_exception_exit()
>> to excret, making it clearer that it does hold an EXC_RETURN value.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

>
>
>> ---
>>   target/arm/helper.c | 23 ++++++++++++-----------
>>   1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index a502e4e..4f41841 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -6212,7 +6212,7 @@ static void v7m_push_stack(ARMCPU *cpu)
>>   static void do_v7m_exception_exit(ARMCPU *cpu)
>>   {
>>       CPUARMState *env =3D &cpu->env;
>> -    uint32_t type;
>> +    uint32_t excret;
>>       uint32_t xpsr;
>>       bool ufault =3D false;
>>       bool return_to_sp_process =3D false;
>> @@ -6233,18 +6233,19 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>>        * the target value up between env->regs[15] and env->thumb in
>>        * gen_bx(). Reconstitute it.
>>        */
>> -    type =3D env->regs[15];
>> +    excret =3D env->regs[15];
>>       if (env->thumb) {
>> -        type |=3D 1;
>> +        excret |=3D 1;
>>       }
>>         qemu_log_mask(CPU_LOG_INT, "Exception return: magic PC %" PRIx32
>>                     " previous exception %d\n",
>> -                  type, env->v7m.exception);
>> +                  excret, env->v7m.exception);
>>   -    if ((type & R_V7M_EXCRET_RES1_MASK) !=3D R_V7M_EXCRET_RES1_MASK) =
{
>> +    if ((excret & R_V7M_EXCRET_RES1_MASK) !=3D R_V7M_EXCRET_RES1_MASK) =
{
>>           qemu_log_mask(LOG_GUEST_ERROR, "M profile: zero high bits in
>> exception "
>> -                      "exit PC value 0x%" PRIx32 " are UNPREDICTABLE\n"=
,
>> type);
>> +                      "exit PC value 0x%" PRIx32 " are UNPREDICTABLE\n"=
,
>> +                      excret);
>>       }
>>         if (env->v7m.exception !=3D ARMV7M_EXCP_NMI) {
>> @@ -6255,7 +6256,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>>            * which security state's faultmask to clear. (v8M ARM ARM
>> R_KBNF.)
>>            */
>>           if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
>> -            int es =3D type & R_V7M_EXCRET_ES_MASK;
>> +            int es =3D excret & R_V7M_EXCRET_ES_MASK;
>>               if (armv7m_nvic_raw_execution_priority(env->nvic) >=3D 0) =
{
>>                   env->v7m.faultmask[es] =3D 0;
>>               }
>> @@ -6283,7 +6284,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>>           g_assert_not_reached();
>>       }
>>   -    switch (type & 0xf) {
>> +    switch (excret & 0xf) {
>>       case 1: /* Return to Handler */
>>           return_to_handler =3D true;
>>           break;
>> @@ -6306,7 +6307,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>>            */
>>           env->v7m.cfsr[env->v7m.secure] |=3D R_V7M_CFSR_INVPC_MASK;
>>           armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
>> -        v7m_exception_taken(cpu, type);
>> +        v7m_exception_taken(cpu, excret);
>>           qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on existing "
>>                         "stackframe: failed exception return integrity
>> check\n");
>>           return;
>> @@ -6341,14 +6342,14 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
>>         /* The restored xPSR exception field will be zero if we're
>>        * resuming in Thread mode. If that doesn't match what the
>> -     * exception return type specified then this is a UsageFault.
>> +     * exception return excret specified then this is a UsageFault.
>>        */
>>       if (return_to_handler !=3D arm_v7m_is_handler_mode(env)) {
>>           /* Take an INVPC UsageFault by pushing the stack again. */
>>           armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
>>           env->v7m.cfsr[env->v7m.secure] |=3D R_V7M_CFSR_INVPC_MASK;
>>           v7m_push_stack(cpu);
>> -        v7m_exception_taken(cpu, type);
>> +        v7m_exception_taken(cpu, excret);
>>           qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on new
>> stackframe: "
>>                         "failed exception return integrity check\n");
>>           return;
>>
>
