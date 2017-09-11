Received: from eggs.gnu.org ([2001:4830:134:3::10]:43446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1drSaA-0002VY-8t
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1drSa9-0000eh-0S
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:33:14 -0400
MIME-Version: 1.0
In-Reply-To: <2a61ae5a-dd09-d782-8cc1-66afd7a31559@amsat.org>
References: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
	<1505137930-13255-2-git-send-email-peter.maydell@linaro.org>
	<2a61ae5a-dd09-d782-8cc1-66afd7a31559@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 11 Sep 2017 10:32:38 -0700
Message-ID: <CAKmqyKNrk_aBGwMs0gL_xf5PiA6BEL0x3xxxsFf+i3NJReEEaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/7] target/arm: Use
 M_REG_NUM_BANKS rather than hardcoding 2
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

On Mon, Sep 11, 2017 at 7:59 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On 09/11/2017 10:52 AM, Peter Maydell wrote:
>>
>> Use a symbolic constant M_REG_NUM_BANKS for the array size for
>> registers which are banked by M profile security state, rather
>> than hardcoding lots of 2s.
>>
>> Suggested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

>
>> ---
>> Philippe suggested this in review on the last round of
>> patches but I forgot about it :-(
>
>
> Thank you, it eases review and looks cleaner :)
>
>
>> ---
>>   target/arm/cpu.h | 35 +++++++++++++++++++----------------
>>   1 file changed, 19 insertions(+), 16 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 98b9b26..5a1f957 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -81,8 +81,11 @@
>>    * accessed via env->registerfield[env->v7m.secure] (whether the
>> security
>>    * extension is implemented or not).
>>    */
>> -#define M_REG_NS 0
>> -#define M_REG_S 1
>> +enum {
>> +    M_REG_NS =3D 0,
>> +    M_REG_S =3D 1,
>> +    M_REG_NUM_BANKS =3D 2,
>> +};
>>     /* ARM-specific interrupt pending bits.  */
>>   #define CPU_INTERRUPT_FIQ   CPU_INTERRUPT_TGT_EXT_1
>> @@ -433,19 +436,19 @@ typedef struct CPUARMState {
>>           uint32_t other_sp;
>>           uint32_t other_ss_msp;
>>           uint32_t other_ss_psp;
>> -        uint32_t vecbase[2];
>> -        uint32_t basepri[2];
>> -        uint32_t control[2];
>> -        uint32_t ccr[2]; /* Configuration and Control */
>> -        uint32_t cfsr[2]; /* Configurable Fault Status */
>> +        uint32_t vecbase[M_REG_NUM_BANKS];
>> +        uint32_t basepri[M_REG_NUM_BANKS];
>> +        uint32_t control[M_REG_NUM_BANKS];
>> +        uint32_t ccr[M_REG_NUM_BANKS]; /* Configuration and Control */
>> +        uint32_t cfsr[M_REG_NUM_BANKS]; /* Configurable Fault Status */
>>           uint32_t hfsr; /* HardFault Status */
>>           uint32_t dfsr; /* Debug Fault Status Register */
>> -        uint32_t mmfar[2]; /* MemManage Fault Address */
>> +        uint32_t mmfar[M_REG_NUM_BANKS]; /* MemManage Fault Address */
>>           uint32_t bfar; /* BusFault Address */
>> -        unsigned mpu_ctrl[2]; /* MPU_CTRL */
>> +        unsigned mpu_ctrl[M_REG_NUM_BANKS]; /* MPU_CTRL */
>>           int exception;
>> -        uint32_t primask[2];
>> -        uint32_t faultmask[2];
>> +        uint32_t primask[M_REG_NUM_BANKS];
>> +        uint32_t faultmask[M_REG_NUM_BANKS];
>>           uint32_t secure; /* Is CPU in Secure state? (not guest visible=
)
>> */
>>       } v7m;
>>   @@ -546,7 +549,7 @@ typedef struct CPUARMState {
>>           uint32_t *drbar;
>>           uint32_t *drsr;
>>           uint32_t *dracr;
>> -        uint32_t rnr[2];
>> +        uint32_t rnr[M_REG_NUM_BANKS];
>>       } pmsav7;
>>         /* PMSAv8 MPU */
>> @@ -556,10 +559,10 @@ typedef struct CPUARMState {
>>            *  pmsav7.rnr (region number register)
>>            *  pmsav7_dregion (number of configured regions)
>>            */
>> -        uint32_t *rbar[2];
>> -        uint32_t *rlar[2];
>> -        uint32_t mair0[2];
>> -        uint32_t mair1[2];
>> +        uint32_t *rbar[M_REG_NUM_BANKS];
>> +        uint32_t *rlar[M_REG_NUM_BANKS];
>> +        uint32_t mair0[M_REG_NUM_BANKS];
>> +        uint32_t mair1[M_REG_NUM_BANKS];
>>       } pmsav8;
>>         void *nvic;
>>
>
