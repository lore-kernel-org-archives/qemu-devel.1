Received: from eggs.gnu.org ([2001:4830:134:3::10]:50361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gCQF9-00068k-G8
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gCQF6-0007k8-8Y
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:22:43 -0400
Received: from mail-eopbgr720119.outbound.protection.outlook.com
	([40.107.72.119]:23424
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1gCQF5-0007jg-UJ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:22:40 -0400
References: <1535031276-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1535031276-22911-30-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAFEAcA_aMAn5fND1U32q4u8Lf7P6OOVHG0EKUHeLsH7MmsTxkw@mail.gmail.com>
From: Stefan Markovic <smarkovic@wavecomp.com>
Message-ID: <ef130dd3-ad83-d34d-60fb-c89de39ff97e@wavecomp.com>
Date: Tue, 16 Oct 2018 16:22:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_aMAn5fND1U32q4u8Lf7P6OOVHG0EKUHeLsH7MmsTxkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PULL v4 29/46] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>


On 16.10.18. 16:00, Peter Maydell wrote:
> On 23 August 2018 at 14:34, Aleksandar Markovic
> <aleksandar.markovic@rt-rk.com> wrote:
>> From: Stefan Markovic <smarkovic@wavecomp.com>
>>
>> Add emulation of DSP ASE instructions for nanoMIPS - part 1.
>>
>> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Hi. Coverity points out a bug in this patch (CID 1395627):
>
>> ---
>>   target/mips/translate.c | 554 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 554 insertions(+)
>>
>> diff --git a/target/mips/translate.c b/target/mips/translate.c
>> index 95632dd..d3635e7 100644
>> --- a/target/mips/translate.c
>> +++ b/target/mips/translate.c
>> @@ -18061,6 +18061,554 @@ static void gen_pool32f_nanomips_insn(DisasContext *ctx)
>>       }
>>   }
>>
>> +static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
>> +                                       int rd, int rs, int rt)
>> +{
> [...]
>
>> +    case NM_SHRA_R_PH:
>> +        check_dsp(ctx);
>> +        tcg_gen_movi_tl(t0, rd >> 1);
>> +        switch (extract32(ctx->opcode, 10, 1)) {
>> +        case 0:
>> +            /* SHRA_PH */
>> +            gen_helper_shra_ph(v1_t, t0, v1_t);
>> +            break;
>> +            gen_store_gpr(v1_t, rt);
> This gen_store_gpr() call is unreachable because it
> is after the 'break'. Should the two lines be in the
> other order?


Yes, those two lines should be in the other order:

+        case 0:
+            /* SHRA_PH */
+            gen_helper_shra_ph(v1_t, t0, v1_t);
+            gen_store_gpr(v1_t, rt);
+            break;


>> +        case 1:
>> +            /* SHRA_R_PH */
>> +            gen_helper_shra_r_ph(v1_t, t0, v1_t);
>> +            gen_store_gpr(v1_t, rt);
>> +            break;
>> +        }
>> +        break;
> thanks
> -- PMM
