Received: from eggs.gnu.org ([2001:4830:134:3::10]:44171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDWhz-0000Nt-5x
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDWhv-0007EM-1m
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:29:03 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDWhu-0007D6-FA
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:28:58 -0400
Received: by mail-pl1-x643.google.com with SMTP id bh10-v6so2628232plb.4
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 08:28:58 -0700 (PDT)
References: <20181016223115.24100-1-richard.henderson@linaro.org>
	<20181016223115.24100-2-richard.henderson@linaro.org>
	<6e1ea3f2-24c9-58a7-2f13-0b835b4180cb@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cee4bb3c-e735-245c-9e5a-f78e13ef3a89@linaro.org>
Date: Fri, 19 Oct 2018 08:28:53 -0700
MIME-Version: 1.0
In-Reply-To: <6e1ea3f2-24c9-58a7-2f13-0b835b4180cb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 1/8] target/arm: Move some system
 registers into a substructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 10/19/18 5:04 AM, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 17/10/2018 00:31, Richard Henderson wrote:
>> Create struct ARMISARegisters, to be accessed during translation.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/cpu.h      |  32 ++++----
>>  hw/intc/armv7m_nvic.c |  12 +--
>>  target/arm/cpu.c      | 178 +++++++++++++++++++++---------------------
>>  target/arm/cpu64.c    |  70 ++++++++---------
>>  target/arm/helper.c   |  28 +++----
>>  5 files changed, 162 insertions(+), 158 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index f00c0444c4..cff739b74d 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -788,13 +788,28 @@ struct ARMCPU {
>>       * ARMv7AR ARM Architecture Reference Manual. A reset_ prefix
>>       * is used for reset values of non-constant registers; no reset_
>>       * prefix means a constant register.
>> +     * Some of these registers are split out into a substructure that
>> +     * is shared with the translators to control the ISA.
>>       */
>> +    struct ARMISARegisters {
>> +        uint32_t id_isar0;
>> +        uint32_t id_isar1;
>> +        uint32_t id_isar2;
>> +        uint32_t id_isar3;
>> +        uint32_t id_isar4;
>> +        uint32_t id_isar5;
>> +        uint32_t id_isar6;
>> +        uint32_t mvfr0;
>> +        uint32_t mvfr1;
>> +        uint32_t mvfr2;
>> +        uint64_t id_aa64isar0;
>> +        uint64_t id_aa64isar1;
>> +        uint64_t id_aa64pfr0;
>> +        uint64_t id_aa64pfr1;
>> +    } isar;
> 
> I understand and agree with the change, however I find the 'isar' name
> confusing. Sadly unnamed structure is not useful here.

I assume the naming of these registers has some history within ARM, but I find
the distribution of fields between "ISA Registers" and "Processor Feature
Registers" and "Media & VFP Feature Registers" confusing, since they all have
much the same function.

I struggled with the naming myself, but couldn't find anything better than "ISA
Registers" myself.  Which they all are, really, despite the other two names.


r~
