Received: from eggs.gnu.org ([2001:4830:134:3::10]:41717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLBW2-00056a-FG
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLBVz-0007ZK-Dt
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:51:34 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLBVz-0007Z7-8C
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:51:31 -0400
Received: by mail-qt0-x242.google.com with SMTP id w1so1063838qtg.0
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 09:51:31 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170614140209.29847-1-alex.bennee@linaro.org>
	<20170614140209.29847-4-alex.bennee@linaro.org>
	<09a35585-d876-6c9e-7045-8cda418455e0@twiddle.net>
	<a1a0b43c-b074-a1a4-dc26-717964121b1a@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f32b9b12-73b4-e803-6425-271b48858a8b@twiddle.net>
Date: Wed, 14 Jun 2017 09:51:26 -0700
MIME-Version: 1.0
In-Reply-To: <a1a0b43c-b074-a1a4-dc26-717964121b1a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org
Cc: qemu-devel@nongnu.org

On 06/14/2017 09:08 AM, Paolo Bonzini wrote:
> I think this is a band-aid, and would rather fix the front-ends as in
> Emilio's patch.  For Alpha my guess would be:
> 
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index 7c45ae360c..6e2ee3f958 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -1198,7 +1198,9 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
>               tcg_gen_andi_i64(tmp, ctx->ir[IR_A0], PS_INT_MASK);
>                tcg_gen_st8_i64(tmp, cpu_env, offsetof(CPUAlphaState, ps));
>               tcg_temp_free(tmp);
> -            break;
> +
> +            /* Reevaluate interrupts */
> +            return EXIT_PC_STALE;
>   
>           case 0x36:
>               /* RDPS */

Thanks!

You're right that adjusting SWPIPL along these lines does fix the problem for 
Alpha.  Given that Alpha would typically hang in arch_idle, I'd been focusing 
primarily on WTINT.


r~
