Received: from eggs.gnu.org ([2001:4830:134:3::10]:53234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjszY-0008Tw-4P
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjszU-0004GL-Tw
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:35:52 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cjszU-0004Fn-Kq
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:35:48 -0500
Received: by mail-pf0-x243.google.com with SMTP id e66so5022566pfe.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 11:35:48 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-5-alex.bennee@linaro.org>
	<CAFEAcA_REYx=z1x9K_P1UK4j-fNyZ3717UrHDCLVySPanb28KQ@mail.gmail.com>
	<87pohy1uyk.fsf@linaro.org>
	<CAFEAcA9UWALr0iQZrjdCMrPJeZ4f-GYufG9USgtqtmGOQ1uqnQ@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <02c25dfe-1d90-6434-08c5-37826afbd993@twiddle.net>
Date: Sat, 4 Mar 2017 06:35:39 +1100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9UWALr0iQZrjdCMrPJeZ4f-GYufG9USgtqtmGOQ1uqnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, MTTCG Devel <mttcg@greensocs.com>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 03/03/2017 10:19 PM, Peter Maydell wrote:
> On 3 March 2017 at 11:05, Alex Bennée <alex.bennee@linaro.org> wrote:
>> According to the commit that added it
>> (c552d6c038f7cf4058d1fd5987118ffd41e0e050) it is meant to be a hint to
>> the compiler. Reading the GCC notes however seems to contradict that.
>>
>> FWIW I did test it in both builds and we do used tese for a bunch of
>> other asserts and they haven't blown up.
>>
>>> If what we want is "don't actually check this condition in
>>> the non-tcg-debug config" then we should do something
>>> that means we don't actually check the condition...
>>
>> Hmm:
>>
>> 28      intptr_t qemu_real_host_page_mask;
>> 29
>> 30      #ifndef CONFIG_USER_ONLY
>> 31      /* mask must never be zero, except for A20 change call */
>> 32      static void tcg_handle_interrupt(CPUState *cpu, int mask)
>> 33      {
>> 34          int old_mask;
>> 35          tcg_debug_assert(qemu_mutex_iothread_locked());
>> 36
>> 37          old_mask = cpu->interrupt_request;
>> Line 34 of "/home/alex/lsrc/qemu/qemu.git/translate-common.c" is at address 0x24db0a <tcg_handle_interrupt+10> but contains no code.
>> Line 35 of "/home/alex/lsrc/qemu/qemu.git/translate-common.c" starts at address 0x24db0a <tcg_handle_interrupt+10> and ends at 0x24db0f <tcg_handle_interrupt+15>.
>> Line 36 of "/home/alex/lsrc/qemu/qemu.git/translate-common.c" is at address 0x24db0f <tcg_handle_interrupt+15> but contains no code.
>> Line 37 of "/home/alex/lsrc/qemu/qemu.git/translate-common.c" starts at address 0x24db0f <tcg_handle_interrupt+15> and ends at 0x24db15 <tcg_handle_interrupt+21>.
>>    0x24db0a <tcg_handle_interrupt+10>:  callq  0x27a570 <qemu_mutex_iothread_locked>
>>    0x24db0f <tcg_handle_interrupt+15>:  mov    0xa8(%rbx),%ebp
>>    0x24db15 <tcg_handle_interrupt+21>:  mov    %r12d,%eax
>>    0x24db18 <tcg_handle_interrupt+24>:  mov    %rbx,%rdi
>>    0x24db1b <tcg_handle_interrupt+27>:  or     %ebp,%eax
>>    0x24db1d <tcg_handle_interrupt+29>:  mov    %eax,0xa8(%rbx)
>>    0x24db23 <tcg_handle_interrupt+35>:  callq  0x27a530 <qemu_cpu_is_self>
>>
>> It certainly looks as though it makes the call but ignores the result?
>
> That is one permitted implementation of the undefined behaviour,
> certainly. Not the only one, though. In particular you're telling
> the compiler's optimization passes "this can never be reached"
> which can result in the optimizer making significantly different
> decisions (especially if it manages to inline things or it can
> look "inside" the condition being asserted here, etc etc).

Yep, Peter's right.

Which is exactly the point when you have a condition like (X > 0); letting the 
compiler have the same information for the production build that it would have 
gleaned from the debug build.

But that's not the same as dropping the assert, which is what you wanted.

On the other hand, isn't "assert" instead of "g_assert" exactly what you 
wanted?  Don't we define NDEBUG for production builds?


r~
