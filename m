Received: from eggs.gnu.org ([2001:4830:134:3::10]:53179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjlFZ-0003sc-Uz
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:19:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjlFY-0007U0-Vk
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:19:53 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:34428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjlFY-0007Tr-PD
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:19:52 -0500
Received: by mail-wm0-x234.google.com with SMTP id 196so7572091wmm.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 03:19:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87pohy1uyk.fsf@linaro.org>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-5-alex.bennee@linaro.org>
	<CAFEAcA_REYx=z1x9K_P1UK4j-fNyZ3717UrHDCLVySPanb28KQ@mail.gmail.com>
	<87pohy1uyk.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 11:19:31 +0000
Message-ID: <CAFEAcA9UWALr0iQZrjdCMrPJeZ4f-GYufG9USgtqtmGOQ1uqnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, MTTCG Devel <mttcg@listserver.greensocs.com>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 3 March 2017 at 11:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> According to the commit that added it
> (c552d6c038f7cf4058d1fd5987118ffd41e0e050) it is meant to be a hint to
> the compiler. Reading the GCC notes however seems to contradict that.
>
> FWIW I did test it in both builds and we do used tese for a bunch of
> other asserts and they haven't blown up.
>
>> If what we want is "don't actually check this condition in
>> the non-tcg-debug config" then we should do something
>> that means we don't actually check the condition...
>
> Hmm:
>
> 28      intptr_t qemu_real_host_page_mask;
> 29
> 30      #ifndef CONFIG_USER_ONLY
> 31      /* mask must never be zero, except for A20 change call */
> 32      static void tcg_handle_interrupt(CPUState *cpu, int mask)
> 33      {
> 34          int old_mask;
> 35          tcg_debug_assert(qemu_mutex_iothread_locked());
> 36
> 37          old_mask =3D cpu->interrupt_request;
> Line 34 of "/home/alex/lsrc/qemu/qemu.git/translate-common.c" is at addre=
ss 0x24db0a <tcg_handle_interrupt+10> but contains no code.
> Line 35 of "/home/alex/lsrc/qemu/qemu.git/translate-common.c" starts at a=
ddress 0x24db0a <tcg_handle_interrupt+10> and ends at 0x24db0f <tcg_handle_=
interrupt+15>.
> Line 36 of "/home/alex/lsrc/qemu/qemu.git/translate-common.c" is at addre=
ss 0x24db0f <tcg_handle_interrupt+15> but contains no code.
> Line 37 of "/home/alex/lsrc/qemu/qemu.git/translate-common.c" starts at a=
ddress 0x24db0f <tcg_handle_interrupt+15> and ends at 0x24db15 <tcg_handle_=
interrupt+21>.
>    0x24db0a <tcg_handle_interrupt+10>:  callq  0x27a570 <qemu_mutex_iothr=
ead_locked>
>    0x24db0f <tcg_handle_interrupt+15>:  mov    0xa8(%rbx),%ebp
>    0x24db15 <tcg_handle_interrupt+21>:  mov    %r12d,%eax
>    0x24db18 <tcg_handle_interrupt+24>:  mov    %rbx,%rdi
>    0x24db1b <tcg_handle_interrupt+27>:  or     %ebp,%eax
>    0x24db1d <tcg_handle_interrupt+29>:  mov    %eax,0xa8(%rbx)
>    0x24db23 <tcg_handle_interrupt+35>:  callq  0x27a530 <qemu_cpu_is_self=
>
>
> It certainly looks as though it makes the call but ignores the result?

That is one permitted implementation of the undefined behaviour,
certainly. Not the only one, though. In particular you're telling
the compiler's optimization passes "this can never be reached"
which can result in the optimizer making significantly different
decisions (especially if it manages to inline things or it can
look "inside" the condition being asserted here, etc etc).

thanks
-- PMM
