Received: from eggs.gnu.org ([2001:4830:134:3::10]:49318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVKQh-0003Vr-Jd
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVKQc-0001SX-Ow
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:00:47 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVKQc-0001Rs-Hx
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:00:42 -0500
Received: by mail-ot1-x341.google.com with SMTP id 40so4601235oth.4
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 10:00:41 -0800 (PST)
References: <20181205134243.4791-1-aaron@os.amperecomputing.com>
	<20181205134243.4791-9-aaron@os.amperecomputing.com>
	<20181205153242.GE5549@quinoa.localdomain>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <75ec3369-0f1c-0ea7-1fc5-9e2263f6f86e@linaro.org>
Date: Fri, 7 Dec 2018 12:00:37 -0600
MIME-Version: 1.0
In-Reply-To: <20181205153242.GE5549@quinoa.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 08/14] target/arm: Make PMCEID[01]_EL0
 64 bit registers, add PMCEID[23]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 12/5/18 9:32 AM, Aaron Lindsay wrote:
> On Dec 05 08:43, Aaron Lindsay wrote:
>> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
>> ---
>>  target/arm/cpu.h    |  4 ++--
>>  target/arm/helper.c | 18 ++++++++++++++++--
>>  2 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 304e6e47b3..4216fe22db 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -837,8 +837,8 @@ struct ARMCPU {
>>      uint32_t id_pfr0;
>>      uint32_t id_pfr1;
>>      uint32_t id_dfr0;
>> -    uint32_t pmceid0;
>> -    uint32_t pmceid1;
>> +    uint64_t pmceid0;
>> +    uint64_t pmceid1;
>>      uint32_t id_afr0;
>>      uint32_t id_mmfr0;
>>      uint32_t id_mmfr1;
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 71be6fb578..fb6939e99c 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -5256,6 +5256,20 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>>      } else {
>>          define_arm_cp_regs(cpu, not_v7_cp_reginfo);
>>      }
>> +    if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >= 4) {
> 
> After further discussion on my last version, this should be
> 
> if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >= 4 &&
> 	FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) != 0xf) {
> 
> to guard against defining these registers for implementation-defined
> PMUs.

When id fields define values like 0b1111, that is a hint that the field should
be interpreted as signed, and you should still use a >= comparison.  (See
D12.1.4, Principles of the ID scheme for fields in ID registers.)

A patch adding

#define FIELD_EX32S(storage, reg, field)                                   \
    sextract32((storage), R_ ## reg ## _ ## field ## _SHIFT,               \
               R_ ## reg ## _ ## field ## _LENGTH)
#define FIELD_EX64S(storage, reg, field)                                   \
    sextract64((storage), R_ ## reg ## _ ## field ## _SHIFT,               \
               R_ ## reg ## _ ## field ## _LENGTH)

to include/hw/registerfields.h would be welcome and appropriate, I think.


r~
