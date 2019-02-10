Received: from eggs.gnu.org ([209.51.188.92]:39182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsdqW-0007Nx-SA
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 20:23:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsdqU-00064n-MX
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 20:23:48 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsdqU-00064S-DS
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 20:23:46 -0500
Received: by mail-pg1-x541.google.com with SMTP id r11so3287915pgp.6
	for <qemu-devel@nongnu.org>; Sat, 09 Feb 2019 17:23:46 -0800 (PST)
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-4-richard.henderson@linaro.org>
	<CAFEAcA-BEfqu=BU-2y+8dUBdXsyC4n2zhZm5nZ1MofUj3cE2Lg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c37e6649-b2f9-88cf-913d-d0394a635045@linaro.org>
Date: Sat, 9 Feb 2019 17:23:42 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-BEfqu=BU-2y+8dUBdXsyC4n2zhZm5nZ1MofUj3cE2Lg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/17] target/arm: Add MTE system registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 2/5/19 11:27 AM, Peter Maydell wrote:
>> +++ b/target/arm/translate-a64.c
>> @@ -1668,6 +1668,17 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
>>          s->base.is_jmp = DISAS_UPDATE;
>>          break;
>>
>> +    case 0x1c: /* TCO */
>> +        if (!dc_isar_feature(aa64_mte_insn_reg, s)) {
>> +            goto do_unallocated;
>> +        }
>> +        if (crm & 1) {
>> +            set_pstate_bits(PSTATE_TCO);
>> +        } else {
>> +            clear_pstate_bits(PSTATE_TCO);
>> +        }
>> +        break;
> Don't we need to break the TB here or something to pick up
> the new value of TCO when we generate code for a following
> load or store ? (TCO is self-synchronizing so there is no
> requirement for an ISB before it takes effect.)

Actually, we already break the TB here by default.


r~
