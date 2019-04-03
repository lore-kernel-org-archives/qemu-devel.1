Received: from eggs.gnu.org ([209.51.188.92]:33447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBaiY-0004wx-Ly
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBaiX-0003hm-Oq
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:53:54 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:46626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBaiX-0003hO-D9
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:53:53 -0400
Received: by mail-pg1-x536.google.com with SMTP id q1so7877084pgv.13
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 00:53:53 -0700 (PDT)
References: <1554218121-26766-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554218121-26766-3-git-send-email-mateja.marjanovic@rt-rk.com>
	<CAL1e-=i8fUExfeinjYYrc-g19KoEJnUSXpiiL=bwr5E9OEHY+A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c08fb69e-5625-d3e7-8ea7-8e5a3fae8329@linaro.org>
Date: Wed, 3 Apr 2019 14:53:46 +0700
MIME-Version: 1.0
In-Reply-To: <CAL1e-=i8fUExfeinjYYrc-g19KoEJnUSXpiiL=bwr5E9OEHY+A@mail.gmail.com>
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
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Cc: amarkovic@wavecomp.com, qemu-devel@nongnu.org, aurelien@aurel32.net, arikalo@wavecomp.com

On 4/3/19 5:28 AM, Aleksandar Markovic wrote:
>> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
>> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2], t1, msa_wr_d[ws * 2], 32, 32);
>> +
>> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
>> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2 + 1], t1, msa_wr_d[ws * 2 + 1], 32, 32);
>> +
>> +    tcg_temp_free_i64(t1);
>> +}
>> +
> 
> This can be further optimized this way: (doublecheck the accuracy, writing from
> home)
> 
> gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
>                                 uint32_t ws, uint32_t wt)
> {
>     tcg_gen_shli_i64(msa_wr_d[wd * 2], msa_wr_d[ws * 2], 32);
>     tcg_gen_deposit_i64(msa_wr_d[wd * 2], t1, msa_wr_d[wt * 2], 0, 32);
> 

No, the shift can be performed by the deposit.
See my other reply in this thread.


r~
