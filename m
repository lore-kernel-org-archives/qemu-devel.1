Received: from eggs.gnu.org ([2001:4830:134:3::10]:45292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLbnW-0001ue-Cc
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 16:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLbnT-0001NI-8t
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 16:55:22 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLbnT-0001Mx-40
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 16:55:19 -0400
Received: by mail-qt0-x244.google.com with SMTP id s33so5758104qtg.3
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 13:55:18 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-3-rth@twiddle.net> <87vanxmyac.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5fd00837-211a-011c-be1c-d5e2e7417d9d@twiddle.net>
Date: Thu, 15 Jun 2017 13:55:15 -0700
MIME-Version: 1.0
In-Reply-To: <87vanxmyac.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] target/alpha: Use
 tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, cota@braap.org, pbonzini@redhat.com

On 06/15/2017 01:48 AM, Alex Bennée wrote:
> 
> Richard Henderson <rth@twiddle.net> writes:
> 
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>   target/alpha/translate.c | 27 ++++++++++++++++++++++-----
>>   1 file changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
>> index 7c45ae3..a48e451 100644
>> --- a/target/alpha/translate.c
>> +++ b/target/alpha/translate.c
>> @@ -84,6 +84,7 @@ typedef enum {
>>          the PC (for whatever reason), so there's no need to do it again on
>>          exiting the TB.  */
>>       EXIT_PC_UPDATED,
>> +    EXIT_PC_UPDATED_NOCHAIN,
>>
>>       /* We are exiting the TB, but have neither emitted a goto_tb, nor
>>          updated the PC for the next instruction to be executed.  */
>> @@ -458,11 +459,17 @@ static bool in_superpage(DisasContext *ctx, int64_t addr)
>>   #endif
>>   }
>>
>> +static bool use_exit_tb(DisasContext *ctx)
>> +{
>> +    return ((ctx->tb->cflags & CF_LAST_IO)
>> +            || ctx->singlestep_enabled
>> +            || singlestep);
>> +}
> 
> minor nit: why start testing this global? At the least we should
> probably seed ctx->singlestep_enabled when we set up for translation.
> 
>> +
>>   static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
>>   {
>>       /* Suppress goto_tb in the case of single-steping and IO.  */
>> -    if ((ctx->tb->cflags & CF_LAST_IO)
>> -        || ctx->singlestep_enabled || singlestep) {

I didn't start testing this global.  It's already there.

Further, despite the name similarity these are very different conditions.

For ctx->singlestep_enabled we emit a debug exception at the end of every 
instruction.

For singlestep, we must execute only one insn in the TB and further we must 
return to the main loop after the TB.  Both are required for -singlestep -d cpu 
to log all that's being requested.

One cannot combine the two conditions.


r~
