Received: from eggs.gnu.org ([2001:4830:134:3::10]:52324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPtkb-0006lo-CD
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPtaV-0003gm-7L
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:43:42 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPtaV-0003fs-1S
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:43:39 -0400
Received: by mail-qk0-x243.google.com with SMTP id 91so4567667qkq.1
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 09:43:38 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170621024831.26019-1-rth@twiddle.net>
	<20170621024831.26019-14-rth@twiddle.net> <87r2y5wynr.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <027116e0-750a-dfcd-c48f-cd01c9bdfcef@twiddle.net>
Date: Tue, 27 Jun 2017 09:43:35 -0700
MIME-Version: 1.0
In-Reply-To: <87r2y5wynr.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 13/16] tcg: Export temp_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net

On 06/27/2017 02:46 AM, Alex Bennée wrote:
> 
> Richard Henderson <rth@twiddle.net> writes:
> 
>> At the same time, drop the TCGContext argument and use tcg_ctx instead.
>>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>   tcg/tcg.c | 15 ++++-----------
>>   tcg/tcg.h |  7 ++++++-
>>   2 files changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/tcg/tcg.c b/tcg/tcg.c
>> index f8d96fa..26931a7 100644
>> --- a/tcg/tcg.c
>> +++ b/tcg/tcg.c
>> @@ -473,13 +473,6 @@ void tcg_func_start(TCGContext *s)
>>       s->be = tcg_malloc(sizeof(TCGBackendData));
>>   }
>>
>> -static inline int temp_idx(TCGContext *s, TCGTemp *ts)
>> -{
>> -    ptrdiff_t n = ts - s->temps;
>> -    tcg_debug_assert(n >= 0 && n < s->nb_temps);
>> -    return n;
>> -}
>> -
>>   static inline TCGTemp *tcg_temp_alloc(TCGContext *s)
>>   {
>>       int n = s->nb_temps++;
>> @@ -516,7 +509,7 @@ static int tcg_global_reg_new_internal(TCGContext *s, TCGType type,
>>       ts->name = name;
>>       tcg_regset_set_reg(s->reserved_regs, reg);
>>
>> -    return temp_idx(s, ts);
>> +    return temp_idx(ts);
>>   }
>>
>>   void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size)
>> @@ -605,7 +598,7 @@ int tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
>>           ts->mem_offset = offset;
>>           ts->name = name;
>>       }
>> -    return temp_idx(s, ts);
>> +    return temp_idx(ts);
>>   }
>>
>>   static int tcg_temp_new_internal(TCGType type, int temp_local)
>> @@ -645,7 +638,7 @@ static int tcg_temp_new_internal(TCGType type, int temp_local)
>>               ts->temp_allocated = 1;
>>               ts->temp_local = temp_local;
>>           }
>> -        idx = temp_idx(s, ts);
>> +        idx = temp_idx(ts);
>>       }
>>
>>   #if defined(CONFIG_DEBUG_TCG)
>> @@ -963,7 +956,7 @@ static void tcg_reg_alloc_start(TCGContext *s)
>>   static char *tcg_get_arg_str_ptr(TCGContext *s, char *buf, int buf_size,
>>                                    TCGTemp *ts)
>>   {
>> -    int idx = temp_idx(s, ts);
>> +    int idx = temp_idx(ts);
>>
>>       if (ts->temp_global) {
>>           pstrcpy(buf, buf_size, ts->name);
>> diff --git a/tcg/tcg.h b/tcg/tcg.h
>> index 4f69d0c..b75a745 100644
>> --- a/tcg/tcg.h
>> +++ b/tcg/tcg.h
>> @@ -733,13 +733,18 @@ struct TCGContext {
>>   extern TCGContext tcg_ctx;
>>   extern bool parallel_cpus;
>>
>> -static inline TCGArg temp_arg(TCGTemp *ts)
>> +static inline size_t temp_idx(TCGTemp *ts)
>>   {
>>       ptrdiff_t n = ts - tcg_ctx.temps;
>>       tcg_debug_assert(n >= 0 && n < tcg_ctx.nb_temps);
>>       return n;
>>   }
>>
>> +static inline TCGArg temp_arg(TCGTemp *ts)
>> +{
>> +    return temp_idx(ts);
>> +}
> 
> I'm confused at the dropping of TCGArg in favour of size_t only for
> temp_arg to implicitly cast it back. Was this meant to be part of
> another patch?

It was meant to keep the types logical.  When talking about an "arg" use 
TCGArg; when talking about an index (or idx) use size_t (or quite often int, 
where this hasn't been cleaned up).

You'll see from the last patch that temp_arg no longer calls temp_idx.


r~
