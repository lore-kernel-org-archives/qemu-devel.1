Received: from eggs.gnu.org ([209.51.188.92]:60706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBaeK-00037B-KB
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBaeJ-0000aZ-MH
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:49:32 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32]:37325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBaeJ-0000Zo-Dw
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:49:31 -0400
Received: by mail-io1-xd32.google.com with SMTP id x7so1232738ioh.4
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 00:49:31 -0700 (PDT)
References: <1554218121-26766-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554218121-26766-3-git-send-email-mateja.marjanovic@rt-rk.com>
	<9d208883-c16b-e24a-7aa3-97688897acc2@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <99bf488d-af7e-3ead-242a-a4570ba992dd@linaro.org>
Date: Wed, 3 Apr 2019 14:49:19 +0700
MIME-Version: 1.0
In-Reply-To: <9d208883-c16b-e24a-7aa3-97688897acc2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 2/2] target/mips: Optimize
 ILVEV.<B|H|W|D> MSA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 4/2/19 11:19 PM, Philippe Mathieu-Daudé wrote:
>> +static inline void gen_ilvev_b(CPUMIPSState *env, uint32_t wd,
>> +                               uint32_t ws, uint32_t wt)
>> +{
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    const uint64_t mask = 0x00ff00ff00ff00ffULL;
>> +
>> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
>> +    tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
>> +    tcg_gen_shli_i64(t2, t2, 8);
>> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
>> +
> 
> Richard, is it cheaper to use another register to keep the constant mask
> (here reused 4x)?
> 
> Such:
> 
>        TCGv_i64 mask = tcg_const_i64(0x00ff00ff00ff00ffULL);
> 
>        tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
>        tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
>        tcg_gen_shli_i64(t2, t2, 8);
>        tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);

With the current state of the tcg optimizer, yes.


r~
