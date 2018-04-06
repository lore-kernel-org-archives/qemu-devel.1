Received: from eggs.gnu.org ([2001:4830:134:3::10]:35507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4RUW-00081Z-UN
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4RUW-0004Rv-4D
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:33:20 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:40730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f4RUV-0004RI-SU
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:33:20 -0400
Received: by mail-pf0-x241.google.com with SMTP id y66so739635pfi.7
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 06:33:19 -0700 (PDT)
References: <20180217203132.31780-1-richard.henderson@linaro.org>
	<20180217203132.31780-4-richard.henderson@linaro.org>
	<0f27ac43-be6c-089d-5089-4eb08023f221@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a190a080-f235-bc0c-34e6-de04074b7903@linaro.org>
Date: Fri, 6 Apr 2018 23:33:13 +1000
MIME-Version: 1.0
In-Reply-To: <0f27ac43-be6c-089d-5089-4eb08023f221@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/19] target/hppa: Convert move to/from
 system registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org

On 04/06/2018 11:14 PM, Bastian Koppelmann wrote:
> On 02/17/2018 09:31 PM, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/hppa/translate.c  | 57 +++++++++++++++++++++---------------------------
>>  target/hppa/insns.decode | 15 +++++++++++++
>>  2 files changed, 40 insertions(+), 32 deletions(-)
>>
> [...]
>> @@ -2267,24 +2265,26 @@ static void trans_ssm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
>>      ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
>>      nullify_end(ctx);
>>  }
>> +#endif /* !CONFIG_USER_ONLY */
> 
> This seems to not belong to this patch.

It does though.

>> -static void trans_mtsm(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
>> +static void trans_mtsm(DisasContext *ctx, arg_mtsm *a, uint32_t insn)
>>  {
>> -    unsigned rr = extract32(insn, 16, 5);
>> -    TCGv_reg tmp, reg;
>> -
>>      CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
>> +#ifndef CONFIG_USER_ONLY
> 
> Why do you need to make this softmmu only in a simple convert patch?
> This makes it at least confusing for the reviewer.

Actually, it moves the function *out* of the softmmu only block.
That's the #endif being added above.

(1) The patterns in insns.decode are not (and cannot be) conditional
    on softmmu, so this function is now always called.

(2) This also enables a fix to a (trivial) emulation error between
    SIGILL (ILL_ILLOPC) and SIGILL (ILL_PRVOPC).  Although I think
    I would need an additional change in linux-user/ to effect this.


r~
