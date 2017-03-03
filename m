Received: from eggs.gnu.org ([2001:4830:134:3::10]:49832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjl1p-0000gH-BE
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjl1m-000242-6L
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:05:41 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cjl1l-00023n-W2
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:05:38 -0500
Received: by mail-wr0-x231.google.com with SMTP id u48so71308915wrc.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 03:05:37 -0800 (PST)
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-5-alex.bennee@linaro.org>
	<CAFEAcA_REYx=z1x9K_P1UK4j-fNyZ3717UrHDCLVySPanb28KQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_REYx=z1x9K_P1UK4j-fNyZ3717UrHDCLVySPanb28KQ@mail.gmail.com>
Date: Fri, 03 Mar 2017 11:05:39 +0000
Message-ID: <87pohy1uyk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 04/11] translate: downgrade IRQ BQL
 asserts to tcg_debug_assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, MTTCG Devel <mttcg@listserver.greensocs.com>, KONRAD =?utf-8?B?RnLDqWTDqXJpYw==?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 2 March 2017 at 19:53, Alex Bennée <alex.bennee@linaro.org> wrote:
>> While on MTTCG hosts it is very important that updates to
>> cpu->interrupt_request are protected by the BQL not all guests have
>> been converted to the correct locking yet. As a result we are seeing
>> breaking on non-MTTCG enabled guests in production builds.
>>
>> The locking in the guests needs to be fixed but while running single
>> threaded they will continue to work. By moving the asserts to
>> tcg_debug_asserts() they will still be useful during conversion
>> work (much like the existing assert_memory_lock/assert_tb_lock
>> asserts).
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  translate-all.c    | 2 +-
>>  translate-common.c | 3 ++-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/translate-all.c b/translate-all.c
>> index 9bac061c9b..7ee273410d 100644
>> --- a/translate-all.c
>> +++ b/translate-all.c
>> @@ -1928,7 +1928,7 @@ void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf)
>>
>>  void cpu_interrupt(CPUState *cpu, int mask)
>>  {
>> -    g_assert(qemu_mutex_iothread_locked());
>> +    tcg_debug_assert(qemu_mutex_iothread_locked());
>
> If CONFIG_DEBUG_TCG isn't enabled then tcg_debug_assert()
> turns into "if (!(X)) { __builtin_unreachable(); }", which
> means that instead of asserting we now run straight
> into compiler undefined behaviour, don't we?

According to the commit that added it
(c552d6c038f7cf4058d1fd5987118ffd41e0e050) it is meant to be a hint to
the compiler. Reading the GCC notes however seems to contradict that.

FWIW I did test it in both builds and we do used tese for a bunch of
other asserts and they haven't blown up.

> If what we want is "don't actually check this condition in
> the non-tcg-debug config" then we should do something
> that means we don't actually check the condition...

Hmm:

28	intptr_t qemu_real_host_page_mask;
29
30	#ifndef CONFIG_USER_ONLY
31	/* mask must never be zero, except for A20 change call */
32	static void tcg_handle_interrupt(CPUState *cpu, int mask)
33	{
34	    int old_mask;
35	    tcg_debug_assert(qemu_mutex_iothread_locked());
36
37	    old_mask = cpu->interrupt_request;
Line 34 of "/home/alex/lsrc/qemu/qemu.git/translate-common.c" is at address 0x24db0a <tcg_handle_interrupt+10> but contains no code.
Line 35 of "/home/alex/lsrc/qemu/qemu.git/translate-common.c" starts at address 0x24db0a <tcg_handle_interrupt+10> and ends at 0x24db0f <tcg_handle_interrupt+15>.
Line 36 of "/home/alex/lsrc/qemu/qemu.git/translate-common.c" is at address 0x24db0f <tcg_handle_interrupt+15> but contains no code.
Line 37 of "/home/alex/lsrc/qemu/qemu.git/translate-common.c" starts at address 0x24db0f <tcg_handle_interrupt+15> and ends at 0x24db15 <tcg_handle_interrupt+21>.
   0x24db0a <tcg_handle_interrupt+10>:	callq  0x27a570 <qemu_mutex_iothread_locked>
   0x24db0f <tcg_handle_interrupt+15>:	mov    0xa8(%rbx),%ebp
   0x24db15 <tcg_handle_interrupt+21>:	mov    %r12d,%eax
   0x24db18 <tcg_handle_interrupt+24>:	mov    %rbx,%rdi
   0x24db1b <tcg_handle_interrupt+27>:	or     %ebp,%eax
   0x24db1d <tcg_handle_interrupt+29>:	mov    %eax,0xa8(%rbx)
   0x24db23 <tcg_handle_interrupt+35>:	callq  0x27a530 <qemu_cpu_is_self>

It certainly looks as though it makes the call but ignores the result?

>
> thanks
> -- PMM


--
Alex Bennée
