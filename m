Received: from eggs.gnu.org ([2001:4830:134:3::10]:44686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLDcc-0001Gy-HK
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLDcZ-0004jp-E2
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:06:30 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:34557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dLDcZ-0004jc-5z
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:06:27 -0400
Received: by mail-wr0-x235.google.com with SMTP id 77so13490963wrb.1
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 12:06:27 -0700 (PDT)
References: <20170614140209.29847-1-alex.bennee@linaro.org>
	<20170614140209.29847-4-alex.bennee@linaro.org>
	<09a35585-d876-6c9e-7045-8cda418455e0@twiddle.net>
	<a1a0b43c-b074-a1a4-dc26-717964121b1a@redhat.com>
	<f32b9b12-73b4-e803-6425-271b48858a8b@twiddle.net>
	<be99bef9-eeb2-6816-e0ca-979780a48a06@redhat.com>
	<9daac065-1738-f872-0267-94cffa96ab6d@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <9daac065-1738-f872-0267-94cffa96ab6d@twiddle.net>
Date: Wed, 14 Jun 2017 20:07:00 +0100
Message-ID: <87zidamlrf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 3/3] tcg-runtime: short-circuit
 lookup_tb_ptr on IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peter.maydell@linaro.org, cota@braap.org, qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> On 06/14/2017 10:08 AM, Paolo Bonzini wrote:
>> And MIPS:
>>
>> diff --git a/target/mips/translate.c b/target/mips/translate.c
>> index 559f8fed89..244f3cb9ab 100644
>> --- a/target/mips/translate.c
>> +++ b/target/mips/translate.c
>> @@ -13403,8 +13403,9 @@ static void gen_pool32axf (CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
>>                   save_cpu_state(ctx, 1);
>>                   gen_helper_ei(t0, cpu_env);
>>                   gen_store_gpr(t0, rs);
>> -                /* Stop translation as we may have switched the execution mode */
>> -                ctx->bstate = BS_STOP;
>> +                /* BS_STOP isn't good enough here, reevaluate cpu_mips_hw_interrupts_enabled. */
>> +                gen_save_pc(ctx->pc + 4);
>> +                ctx->bstate = BS_EXCP;
>>                   tcg_temp_free(t0);
>>               }
>>               break;
>>
>> The others seem okay.
>
> Thanks for this bit.  We also need to fix SSM for s390x.

If your rolling a series for all these can you also pick up Thomas
Huth's fix for --accel?

--
Alex Bennée
