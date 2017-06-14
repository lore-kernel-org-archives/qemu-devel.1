Received: from eggs.gnu.org ([2001:4830:134:3::10]:55371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLCPU-0008UF-Hw
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLCPP-0001rq-JD
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:48:52 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dLCPP-0001rQ-Bb
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:48:47 -0400
Received: by mail-wr0-x22a.google.com with SMTP id 77so10746171wrb.1
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 10:48:47 -0700 (PDT)
References: <20170614140209.29847-1-alex.bennee@linaro.org>
	<20170614140209.29847-4-alex.bennee@linaro.org>
	<09a35585-d876-6c9e-7045-8cda418455e0@twiddle.net>
	<a1a0b43c-b074-a1a4-dc26-717964121b1a@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <a1a0b43c-b074-a1a4-dc26-717964121b1a@redhat.com>
Date: Wed, 14 Jun 2017 18:49:20 +0100
Message-ID: <871sqmo3xb.fsf@linaro.org>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, peter.maydell@linaro.org, cota@braap.org, qemu-devel@nongnu.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 14/06/2017 17:45, Richard Henderson wrote:
>> While the next TB would detect the exit flag has been set there is no
>> point if we can exit sooner. We also check cpu->interrupt_request as
>> some front-ends can set it rather than using the cpu_interrupt() API
>> call and would normally be expecting the IRQ to get picked up on the
>> previously fairly regular exits from the run loop.
>
> This is not what happens actually; it's not about front-ends setting
> cpu->interrupt_request, it's about front-ends doing exit_tb when they
> wanted to re-evaluate cpu_handle_interrupt.
>
> cpu_exit is used when device code causes a rising edge in
> cpu->interrupt_request.  What we have here is that the MSR write causes
> cc->cpu_exec_interrupt's return value to change from false to true.
>
> I think this is a band-aid, and would rather fix the front-ends as in
> Emilio's patch.

It seems a shame to cause all msr accesses to trigger and exit when we
only care about the unmasking case. How about:


Author: Alex Bennée <alex.bennee@linaro.org>
Date:   Wed Jun 14 18:46:01 2017 +0100

    target/arm/op_helper: ensure we exit the run-loop

    When IRQs are un-masked we need to ensure the run-loop is exited so we
    can evaluate arm_cpu_do_interrupt.

    Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 2a85666579..7e67bb3db2 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -835,6 +835,9 @@ void HELPER(msr_i_pstate)(CPUARMState *env, uint32_t op, uint32_t imm)
         break;
     case 0x1f: /* DAIFClear */
         env->daif &= ~((imm << 6) & PSTATE_DAIF);
+        /* This may result in pending IRQs being unmasked so ensure we
+           exit the loop */
+        cpu_exit(ENV_GET_CPU(env));
         break;
     default:
         g_assert_not_reached();
