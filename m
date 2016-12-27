Received: from eggs.gnu.org ([2001:4830:134:3::10]:40213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cM0Lt-00021K-97
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 17:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cM0Ls-0000Ib-De
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 17:36:13 -0500
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:33128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cM0Ls-0000IX-7u
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 17:36:12 -0500
Received: by mail-ua0-x233.google.com with SMTP id i68so89561996uad.0
	for <qemu-devel@nongnu.org>; Tue, 27 Dec 2016 14:36:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <DB6PR0401MB2613DAE7BA80EA45AA90C416BA690@DB6PR0401MB2613.eurprd04.prod.outlook.com>
References: <DB6PR0401MB2613DAE7BA80EA45AA90C416BA690@DB6PR0401MB2613.eurprd04.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 22:35:51 +0000
Message-ID: <CAFEAcA_5WzHWn8r=p8yS1oiXCoM_XU+w=vm-RbNUOxt1F1isXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Question - Is precise assembly code transpilation
 possible?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Adeel Mujahid <adeelbm@outlook.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 27 December 2016 at 21:45, Adeel Mujahid <adeelbm@outlook.com> wrote:
> For instance, consider a C/C++ project with couple of .asm/.S files
> containing Intel or ATT flavored assembly code for AMD64, and the
> aim is to port to AARCH64 -- is it even a deterministic problem
> to transpile precise and bug free AARCH64 assembly code, given the
> full usage context and all code paths at our disposal?

I don't think this approach is likely to produce useful results.
Generally the reason for some code being in assembly is because
it is a critical path for the program and has to execute as
fast as possible. If you try to automatedly translate that to
a different instruction set (with QEMU or otherwise) you will
produce output which is slower than it should be, because it
has to reproduce all the effects of the original code (like
setting flags correctly, getting the right floating point
results, etc).

If you want something that will work on any host architecture
(at the cost of being slightly slow) you should write a C
language version of the assembly code as a fallback path,
or even as the only code path. The C code can then correctly
express what the code actually requires (with no unwanted
side effects like having to set flags, etc) and the compiler
can produce good native code.
(This is useful anyway for testing whether the native assembly
version is broken.)

If the codepath is sufficiently hot that a native assembly
version is absolutely needed, then there is no substitute
for a real human doing the work, possibly starting from what
the C compiler produced. The oddities of different architecture
instruction sets (like how their SIMD works, whether they have
custom instructions for particular operations, etc) are not
something that's really possible for automatic code generation
to make full use of. (If it were possible, you could just
do that in the C compiler back end and write the code in C
in the first place.)

TLDR: doing C -> asm (with the C compiler) will get you
much better quality code than trying to do asm -> asm
with any kind of JIT/emulator like QEMU.

thanks
-- PMM
