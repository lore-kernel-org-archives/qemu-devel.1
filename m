Received: from eggs.gnu.org ([209.51.188.92]:58633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzAYU-0004I8-Gd
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 20:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzAYR-0005yk-0J
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 20:32:09 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzAYH-0005mh-GN
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 20:32:01 -0500
Received: by mail-pg1-x541.google.com with SMTP id i130so8861010pgd.1
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 17:31:47 -0800 (PST)
References: <20190220235017.1060-1-richard.henderson@linaro.org>
	<20190220235017.1060-2-richard.henderson@linaro.org>
	<CAFEAcA9GW2HGGw1FjFSTOJgOn+eRs-1anQDJ7nb3FnOSNbQesQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6605b2a8-e46f-4b01-5f6b-6bc84eb9affc@linaro.org>
Date: Wed, 27 Feb 2019 17:18:27 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9GW2HGGw1FjFSTOJgOn+eRs-1anQDJ7nb3FnOSNbQesQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] target/arm: Implement ARMv8.0-SB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2/26/19 10:31 AM, Peter Maydell wrote:
> On Wed, 20 Feb 2019 at 23:50, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
>> @@ -9192,6 +9192,17 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>>                   */
>>                  gen_goto_tb(s, 0, s->pc & ~1);
>>                  return;
>> +            case 7: /* sb */
>> +                if (!dc_isar_feature(aa32_sb, s)) {
>> +                    goto illegal_op;
>> +                }
>> +                /*
>> +                 * TODO: There is no speculation barrier opcode
>> +                 * for TCG; MB and end the TB instead.
>> +                 */
>> +                tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
>> +                s->base.is_jmp = DISAS_TOO_MANY;
> 
> Why do we do the "end the TB" code differently here than we
> do for the implementation of ISB in the case immediately
> above ?

No good reason, I suppose.  This is how we end the TB for MSR, I think.  But I
can change it.


r~
