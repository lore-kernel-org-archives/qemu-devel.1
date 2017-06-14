Received: from eggs.gnu.org ([2001:4830:134:3::10]:56400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLCUG-00040a-54
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLCUB-0003db-6z
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:53:48 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLCUB-0003dW-2R
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:53:43 -0400
Received: by mail-qt0-x244.google.com with SMTP id w1so1468956qtg.0
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 10:53:42 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170614140209.29847-1-alex.bennee@linaro.org>
	<20170614140209.29847-4-alex.bennee@linaro.org>
	<09a35585-d876-6c9e-7045-8cda418455e0@twiddle.net>
	<a1a0b43c-b074-a1a4-dc26-717964121b1a@redhat.com>
	<871sqmo3xb.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <56f8e0d0-1eb6-f605-e0fd-3b4a74520572@twiddle.net>
Date: Wed, 14 Jun 2017 10:53:38 -0700
MIME-Version: 1.0
In-Reply-To: <871sqmo3xb.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: peter.maydell@linaro.org, cota@braap.org, qemu-devel@nongnu.org

On 06/14/2017 10:49 AM, Alex Bennée wrote:
>> I think this is a band-aid, and would rather fix the front-ends as in
>> Emilio's patch.
> 
> It seems a shame to cause all msr accesses to trigger and exit when we
> only care about the unmasking case. How about:
> 
> 
> Author: Alex Bennée <alex.bennee@linaro.org>
> Date:   Wed Jun 14 18:46:01 2017 +0100
> 
>      target/arm/op_helper: ensure we exit the run-loop
> 
>      When IRQs are un-masked we need to ensure the run-loop is exited so we
>      can evaluate arm_cpu_do_interrupt.
> 
>      Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 2a85666579..7e67bb3db2 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -835,6 +835,9 @@ void HELPER(msr_i_pstate)(CPUARMState *env, uint32_t op, uint32_t imm)
>           break;
>       case 0x1f: /* DAIFClear */
>           env->daif &= ~((imm << 6) & PSTATE_DAIF);
> +        /* This may result in pending IRQs being unmasked so ensure we
> +           exit the loop */
> +        cpu_exit(ENV_GET_CPU(env));

That works for me.  And I guess that takes care of any potential problems with 
A32 as well?


r~
