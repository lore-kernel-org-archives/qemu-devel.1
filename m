Received: from eggs.gnu.org ([2001:4830:134:3::10]:41846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gEFSc-000771-5U
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gEFF0-0003aE-I1
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:02:07 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gEFF0-0003ZK-4N
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:02:06 -0400
Received: by mail-ot1-x342.google.com with SMTP id k9so37596033otl.10
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 08:02:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <12592ba3-ea47-e7c2-d67b-c58012c64287@linaro.org>
References: <20181016174911.9052-1-richard.henderson@linaro.org>
	<CAFEAcA-NEN7MymyzmeOwz7bX99P_o6D9dMraHYA8LcFS7w9=_A@mail.gmail.com>
	<12592ba3-ea47-e7c2-d67b-c58012c64287@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 21 Oct 2018 16:01:44 +0100
Message-ID: <CAFEAcA_08zpaSh3g76dXXqzFoAepHzMzo_Bac8BrGJqGRL=n=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/21] tcg patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 October 2018 at 07:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 10/18/18 3:34 AM, Peter Maydell wrote:
>> The win32 build fails with:
>>
>> target/arm/helper-a64.o: In function `helper_paired_cmpxchg64_le_parallel':
>> /home/petmay01/qemu-for-merges/target/arm/helper-a64.c:573: undefined
>> reference to `helper_atomic_cmpxchgo_le_mmu'
>> target/arm/helper-a64.o: In function `helper_paired_cmpxchg64_be_parallel':
>> /home/petmay01/qemu-for-merges/target/arm/helper-a64.c:647: undefined
>> reference to `helper_atomic_cmpxchgo_be_mmu'
>> target/arm/helper-a64.o: In function `helper_casp_le_parallel':
>> /home/petmay01/qemu-for-merges/target/arm/helper-a64.c:669: undefined
>> reference to `helper_atomic_cmpxchgo_le_mmu'
>> target/arm/helper-a64.o: In function `helper_casp_be_parallel':
>> /home/petmay01/qemu-for-merges/target/arm/helper-a64.c:690: undefined
>> reference to `helper_atomic_cmpxchgo_be_mmu'
>
> This one I could not reproduce.  Tested with i686-w64-mingw32-gcc
> and x86_64-w64-mingw32-gcc, both version 6.2.
>
> I suspect configure misfired.  If you can, start this one over with a blank
> build directory.

Something odd is going on here. My merge test when I merged your v2
passed (unless I managed to miss a failure message first time around
which isn't impossible). But on a subsequent test for a later merge,
I get the same error:

  LINK    aarch64-softmmu/qemu-system-aarch64w.exe
target/arm/helper-a64.o: In function `helper_paired_cmpxchg64_le_parallel':
/home/petmay01/qemu-for-merges/target/arm/helper-a64.c:573: undefined
reference to `helper_atomic_cmpxchgo_le_mmu'
target/arm/helper-a64.o: In function `helper_paired_cmpxchg64_be_parallel':
/home/petmay01/qemu-for-merges/target/arm/helper-a64.c:647: undefined
reference to `helper_atomic_cmpxchgo_be_mmu'
target/arm/helper-a64.o: In function `helper_casp_le_parallel':
/home/petmay01/qemu-for-merges/target/arm/helper-a64.c:669: undefined
reference to `helper_atomic_cmpxchgo_le_mmu'
target/arm/helper-a64.o: In function `helper_casp_be_parallel':
/home/petmay01/qemu-for-merges/target/arm/helper-a64.c:690: undefined
reference to `helper_atomic_cmpxchgo_be_mmu'
collect2: error: ld returned 1 exit status

I did a complete "blow away build/w32 entirely and
reconfigure" and the failure is still there.
config-host.mak defines neither CONFIG_ATOMIC128 nor CONFIG_CMPXCHG128,
which is what I'd expect for a w32 build. (The w64 build does
define CONFIG_ATOMIC128, and does build.)

Any idea what's going on here? tcg/tcg.h has a comment saying
 * The cmpxchg functions are only defined if HAVE_CMPXCHG128
so presumably the issue is that the helper-a64 code is
trying to refer to them anyway. There certainly doesn't
seem to be any kind of #defining around the listed functions
in helper-a64.c to stop them being compiled in this situation.

NB: I build with --enable-debug in this tree -- are you
perhaps accidentally relying on the compiler's optimisation
to discard these functions if they're not needed?

thanks
-- PMM
