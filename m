Received: from eggs.gnu.org ([2001:4830:134:3::10]:37045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dhelh-0005Dw-3F
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dheld-0007dW-2n
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:32:37 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:36735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dhelc-0007dF-S9
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:32:33 -0400
Received: by mail-pg0-x231.google.com with SMTP id i12so8587579pgr.3
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 09:32:32 -0700 (PDT)
References: <20170815145714.17635-1-richard.henderson@linaro.org>
	<20170815145714.17635-4-richard.henderson@linaro.org>
	<c30ad9c1-bd1c-0fdf-085e-2449d9034dd6@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8846d546-5dc3-4d71-ff57-f1978ae91528@linaro.org>
Date: Tue, 15 Aug 2017 09:32:29 -0700
MIME-Version: 1.0
In-Reply-To: <c30ad9c1-bd1c-0fdf-085e-2449d9034dd6@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 3/3] target/arm: Require
 alignment for load exclusive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, alistair.francis@xilinx.com

On 08/15/2017 08:56 AM, Philippe Mathieu-Daudé wrote:
>> @@ -1885,7 +1886,7 @@ static void gen_load_exclusive(DisasContext *s, int rt,
>> int rt2,
>>               tcg_gen_mov_i64(cpu_reg(s, rt2), cpu_exclusive_high);
>>           }
>>       } else {
>> -        memop |= size;
>> +        memop |= size | MO_ALIGN;
> 
> MO_ALIGN_8 here too?
> 
>>           tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
>>           tcg_gen_mov_i64(cpu_reg(s, rt), cpu_exclusive_val);

Peter already pointed out that MO_ALIGN_N should be reserved for those cases
where an explicit size really needed.  You should note that using MO_ALIGN_8
would be actively wrong here -- it would incorrectly require 8 byte alignment
for the single byte access of LDXRB.


r~
