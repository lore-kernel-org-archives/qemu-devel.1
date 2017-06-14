Received: from eggs.gnu.org ([2001:4830:134:3::10]:45854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLBmT-0000Fx-VT
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLBmP-00050F-1R
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:08:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dLBmO-0004zq-Rw
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:08:28 -0400
References: <20170614140209.29847-1-alex.bennee@linaro.org>
	<20170614140209.29847-4-alex.bennee@linaro.org>
	<09a35585-d876-6c9e-7045-8cda418455e0@twiddle.net>
	<a1a0b43c-b074-a1a4-dc26-717964121b1a@redhat.com>
	<f32b9b12-73b4-e803-6425-271b48858a8b@twiddle.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be99bef9-eeb2-6816-e0ca-979780a48a06@redhat.com>
Date: Wed, 14 Jun 2017 19:08:24 +0200
MIME-Version: 1.0
In-Reply-To: <f32b9b12-73b4-e803-6425-271b48858a8b@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org
Cc: qemu-devel@nongnu.org

On 14/06/2017 18:51, Richard Henderson wrote:
> On 06/14/2017 09:08 AM, Paolo Bonzini wrote:
>> I think this is a band-aid, and would rather fix the front-ends as in
>> Emilio's patch.  For Alpha my guess would be:
>>
>> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
>> index 7c45ae360c..6e2ee3f958 100644
>> --- a/target/alpha/translate.c
>> +++ b/target/alpha/translate.c
>> @@ -1198,7 +1198,9 @@ static ExitStatus gen_call_pal(DisasContext
>> *ctx, int palcode)
>>               tcg_gen_andi_i64(tmp, ctx->ir[IR_A0], PS_INT_MASK);
>>                tcg_gen_st8_i64(tmp, cpu_env, offsetof(CPUAlphaState,
>> ps));
>>               tcg_temp_free(tmp);
>> -            break;
>> +
>> +            /* Reevaluate interrupts */
>> +            return EXIT_PC_STALE;
>>             case 0x36:
>>               /* RDPS */
> 
> Thanks!
> 
> You're right that adjusting SWPIPL along these lines does fix the
> problem for Alpha.  Given that Alpha would typically hang in arch_idle,
> I'd been focusing primarily on WTINT.

And MIPS:

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 559f8fed89..244f3cb9ab 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -13403,8 +13403,9 @@ static void gen_pool32axf (CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
                 save_cpu_state(ctx, 1);
                 gen_helper_ei(t0, cpu_env);
                 gen_store_gpr(t0, rs);
-                /* Stop translation as we may have switched the execution mode */
-                ctx->bstate = BS_STOP;
+                /* BS_STOP isn't good enough here, reevaluate cpu_mips_hw_interrupts_enabled. */
+                gen_save_pc(ctx->pc + 4);
+                ctx->bstate = BS_EXCP;
                 tcg_temp_free(t0);
             }
             break;

The others seem okay.

Paolo
