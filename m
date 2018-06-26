Received: from eggs.gnu.org ([2001:4830:134:3::10]:37978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXocQ-0001Ag-Pv
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXocM-0000AL-2r
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:06:54 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:38648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXocL-00007A-TA
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:06:50 -0400
Received: by mail-pl0-x241.google.com with SMTP id d10-v6so8609495plo.5
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 07:06:49 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-3-richard.henderson@linaro.org>
	<87lgb1wvz6.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <292aa987-8644-c22e-4594-c3ad6518c4c3@linaro.org>
Date: Tue, 26 Jun 2018 07:06:46 -0700
MIME-Version: 1.0
In-Reply-To: <87lgb1wvz6.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 02/35] target/arm: Implement SVE
 Contiguous Load, first-fault and no-fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 06/26/2018 05:52 AM, Alex Bennée wrote:
>> +#define DO_LDFF1(PART, FN, TYPEE, TYPEM, H)                             \
>> +static void do_sve_ldff1##PART(CPUARMState *env, void *vd, void *vg,    \
>> +                               target_ulong addr, intptr_t oprsz,       \
>> +                               bool first, uintptr_t ra)                \
>> +{                                                                       \
>> +    intptr_t i = 0;                                                     \
>> +    do {                                                                \
>> +        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                 \
>> +        do {                                                            \
>> +            TYPEM m = 0;                                                \
>> +            if (pg & 1) {                                               \
>> +                if (!first &&                                           \
>> +                    page_check_range(addr, sizeof(TYPEM), PAGE_READ)) { \
>> +                    record_fault(env, i, oprsz);                        \
>> +                    return;                                             \
>> +                }                                                       \
>> +                m = FN(env, addr, ra);                                  \
>> +                first = false;                                          \
>> +            }                                                           \
>> +            *(TYPEE *)(vd + H(i)) = m;                                  \
>> +            i += sizeof(TYPEE), pg >>= sizeof(TYPEE);                   \
>> +            addr += sizeof(TYPEM);                                      \
>> +        } while (i & 15);                                               \
>> +    } while (i < oprsz);                                                \
>> +}
>>  \
> So I noticed that the disassembly of these two functions is mostly
> parameter pushing and popping. Is there a case to be made to use the
> __flatten__ approach and see how the compiler unrolls it all?

Em... for the most part the functions being called are not inlinable,
being defined in accel/tcg/.


r~
