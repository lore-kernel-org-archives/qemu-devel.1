Received: from eggs.gnu.org ([209.51.188.92]:57305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gw730-0007GY-JQ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gw72r-0005eU-PR
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:10:57 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gw72h-0005VV-Gw
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:10:45 -0500
Received: by mail-pl1-x641.google.com with SMTP id p8so10586538plo.2
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 07:10:35 -0800 (PST)
References: <20190214040652.4811-1-richard.henderson@linaro.org>
	<20190214040652.4811-3-richard.henderson@linaro.org>
	<87bm376dh7.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4f6114d9-eef6-e889-8756-74db559a4a20@linaro.org>
Date: Tue, 19 Feb 2019 07:10:31 -0800
MIME-Version: 1.0
In-Reply-To: <87bm376dh7.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] target/arm: Rebuild hflags at el
 changes and MSR writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, cota@braap.org

On 2/19/19 6:48 AM, Alex Bennée wrote:
>> +++ b/target/arm/translate-a64.c
>> @@ -1841,11 +1841,15 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
>>          /* I/O operations must end the TB here (whether read or write) */
>>          gen_io_end();
>>          s->base.is_jmp = DISAS_UPDATE;
>> -    } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
>> +    }
>> +    if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
> Does this potentially introduce a icount bug (or fix an existing bug)?
> 
>>          /* We default to ending the TB on a coprocessor register write,
>>           * but allow this to be suppressed by the register definition
>>           * (usually only necessary to work around guest bugs).
>>           */
>> +        TCGv_i32 tcg_el = tcg_const_i32(s->current_el);
>> +        gen_helper_rebuild_hflags_a64(cpu_env, tcg_el);
>> +        tcg_temp_free_i32(tcg_el);
>>          s->base.is_jmp = DISAS_UPDATE;
>>      }

Neither.

Previously, all that was required was that either icount or !SUPPRESS_TB_END
and a TB, and that was done simply by setting DISAS_UPDATE.  Which both if
blocks did.

Now, icount ends a TB (still by setting DISAS_UPDATE).  But if !SUPPRESS_TB_END
then we must also rebuild hflags (with a possible harmless double-set of
DISAS_UPDATE).


r~
