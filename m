Received: from eggs.gnu.org ([2001:4830:134:3::10]:57493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL70N-0007sD-Lb
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL70H-00057Q-Pp
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:02:35 -0400
References: <20170609170100.3599-1-alex.bennee@linaro.org>
	<20170609170100.3599-4-alex.bennee@linaro.org>
	<fc351edb-7c08-c341-d8ee-85f6768e4931@twiddle.net>
	<87vao4b4z5.fsf@linaro.org>
	<9776b437-90b4-f2c2-4a0c-c1c6585379bf@twiddle.net>
	<20170611050730.GA12317@flamenco> <20170613225352.GA26288@flamenco>
	<db800d74-7cfa-d9e3-60d7-3e7b19565b9b@twiddle.net>
	<5036e9ad-257a-b098-5093-050fca825627@redhat.com>
	<87r2ymiyht.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9c7ea148-2ca7-ec56-48ed-eabac0fe7896@redhat.com>
Date: Wed, 14 Jun 2017 14:02:19 +0200
MIME-Version: 1.0
In-Reply-To: <87r2ymiyht.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/aarch64: exit to main loop after
 handling MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>, peter.maydell@linaro.org, edgar.iglesias@xilinx.com, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>



On 14/06/2017 13:45, Alex Benn=C3=A9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 14/06/2017 06:48, Richard Henderson wrote:
>>>>
>>>> Commit e75449a3 ("target/aarch64: optimize indirect branches") cause=
s
>>>> a regression by which aarch64 guests freeze under TCG with -smp > 1,
>>>> even with `-accel accel=3Dtcg,thread=3Dsingle' (i.e. MTTCG disabled)=
.
>>>>
>>>> I isolated the problem to the MSR handler. This patch forces an exit
>>>> after the handler is executed, which fixes the regression.
>>>
>>> Why would that be?  The cpu_get_tb_cpu_state within helper_lookup_tb_=
ptr
>>> is supposed to read the new state that the msr handler would have
>>> installed.
>>
>> Could some of these cause an interrupt, or some other change in the
>> cpu_exec flow?
>=20
> Well what I was observing was the secondary_start_kernel stalling and
> leaving the main cpu spinning. The msr is actually:
>=20
> 	local_irq_enable();
> 	local_fiq_enable();
>=20
> Which I assume would re-enable IRQs if they are ready to go. However I
> guess if we sink into our cpu_idle without exiting the main loop we
> never set any pending IRQs?

Then Emilio's patch, if a bit of a heavy hammer, is correct. After
aa64_daif_write needs you need an exit_tb so that arm_cpu_exec_interrupt
is executed again.

Compare with this from the x86 front-end:

        /* if irq were inhibited with HF_INHIBIT_IRQ_MASK, we clear
           the flag and abort the translation to give the irqs a
           change to be happen */
        if (dc->tf || dc->singlestep_enabled ||
            (flags & HF_INHIBIT_IRQ_MASK)) {
            gen_jmp_im(pc_ptr - dc->cs_base);
            gen_eob(dc);
            break;
        }

(This triggers one instruction after a STI instruction, due to how x86's
"interrupt shadow" work, so it doesn't happen immediately after
helper_sti; but the idea is the same).

Paolo
