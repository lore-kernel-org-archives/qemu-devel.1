Received: from eggs.gnu.org ([2001:4830:134:3::10]:57467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLAqA-0003ER-RZ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLAq7-0007A2-He
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:08:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dLAq7-00079X-Am
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:08:15 -0400
References: <20170614140209.29847-1-alex.bennee@linaro.org>
	<20170614140209.29847-4-alex.bennee@linaro.org>
	<09a35585-d876-6c9e-7045-8cda418455e0@twiddle.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a1a0b43c-b074-a1a4-dc26-717964121b1a@redhat.com>
Date: Wed, 14 Jun 2017 18:08:10 +0200
MIME-Version: 1.0
In-Reply-To: <09a35585-d876-6c9e-7045-8cda418455e0@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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



On 14/06/2017 17:45, Richard Henderson wrote:
> While the next TB would detect the exit flag has been set there is no
> point if we can exit sooner. We also check cpu->interrupt_request as
> some front-ends can set it rather than using the cpu_interrupt() API
> call and would normally be expecting the IRQ to get picked up on the
> previously fairly regular exits from the run loop.=20

This is not what happens actually; it's not about front-ends setting=20
cpu->interrupt_request, it's about front-ends doing exit_tb when they=20
wanted to re-evaluate cpu_handle_interrupt.

cpu_exit is used when device code causes a rising edge in=20
cpu->interrupt_request.  What we have here is that the MSR write causes=20
cc->cpu_exec_interrupt's return value to change from false to true.

I think this is a band-aid, and would rather fix the front-ends as in=20
Emilio's patch.  For Alpha my guess would be:

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 7c45ae360c..6e2ee3f958 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1198,7 +1198,9 @@ static ExitStatus gen_call_pal(DisasContext *ctx, i=
nt palcode)
             tcg_gen_andi_i64(tmp, ctx->ir[IR_A0], PS_INT_MASK);
              tcg_gen_st8_i64(tmp, cpu_env, offsetof(CPUAlphaState, ps));
             tcg_temp_free(tmp);
-            break;
+
+            /* Reevaluate interrupts */
+            return EXIT_PC_STALE;
=20
         case 0x36:
             /* RDPS */


It's okay as a last resort I guess, but there's still a lot of
time before 2.9.

Paolo
