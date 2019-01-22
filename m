Received: from eggs.gnu.org ([209.51.188.92]:37323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1VH-0001rP-Me
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:14:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1V6-00057s-7g
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:14:24 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:46488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1V5-00055Z-Ik
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:14:20 -0500
Received: by mail-ot1-x32b.google.com with SMTP id w25so24653920otm.13
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20190115143650.15725-1-jusual@mail.ru>
	<CAKmqyKOyfP=ZT-diiFFfAieYKt98DPSxf0HyVdwYE4g+jv5w0w@mail.gmail.com>
	<797be79d-7ffc-222a-6acd-b01ff7269a63@mail.ru>
	<20190117101309.GA27840@stefanha-x1.localdomain>
	<960bbd92-a160-a65c-22c7-9e899dc3fa78@mail.ru>
	<CAFEAcA8vWOiXS7iM8heAG5wV1u8Dh_295NbWiqcXCmar9ePuPQ@mail.gmail.com>
	<CAFEAcA8=LMzbjFZh0tc5mRT8O2Kr3xKhk3xPgGZ_b53qp8qUvw@mail.gmail.com>
	<d9316f47-a3fb-171c-bc06-c7f699df0400@mail.ru>
In-Reply-To: <d9316f47-a3fb-171c-bc06-c7f699df0400@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 14:58:30 +0000
Message-ID: <CAFEAcA9wXu8UwBbNSmeDu4-tE36JpLQC6XkSNvttpwYnj6QRLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix PC overwriting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Alistair Francis <alistair23@gmail.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On Tue, 22 Jan 2019 at 13:59, Julia Suvorova <jusual@mail.ru> wrote:
> On 21.01.2019 20:24, Peter Maydell wrote:
> >> I think that probably what we ought to do is define that:
> >>   * set_pc has the logic that does whatever is expected
> >>     when the user sets the PC either by hand or when a
> >>     ELF file is loaded
> >>   * if that is not what is wanted in cpu_tb_exec() then
> >>     the target must implement the synchronize_from_tb hook
> >>     as well
> >>
> >> The trick here is figuring out whether we have a coherent
> >> cross-architecture definition of what we want set_pc's
> >> behaviour to be (or at least, if we are just baking in
> >> "act like an ELF file" we should document that...

> I checked all architectures. The trick with synchronize_from_tb() is
> made in mips and tricore. Others simply set "env->pc = value", some of
> them implement the more complex synchronize_from_tb() for use in
> cpu_tb_exec().
>
> I'm going to set "act like an ELF file" meaning to set_pc(), although I
> cannot be sure that simply setting pc to a value always means it in
> architectures other than these three.
>
> set_pc() is also called as cpu_set_pc() in the boot files, so we can
> remove all additional checks from them.
>
> Is the definition update for set_pc() and cpu_set_pc() in
> include/qom/cpu.h enough for documentation?

I think that is the documentation we ought to enhance to
make sure it's clear what we mean by "set the PC" (ie
"the same semantics as for setting execution to start at an
ELF file entry point"). The docs of synchronize_from_tb
are also a bit minimal.

How about this for some documentation text for cpu.h ?

 @set_pc: Callback for setting the Program Counter register. This
       should have the semantics used by the target architecture when
       setting the PC from a source such as an ELF file entry point;
       for example on Arm it will also set the Thumb mode bit based
       on the least significant bit of the new PC value.
       If the target behaviour here is anything other than "set
       the PC register to the value passed in" then the target must
       also implement the synchronize_from_tb hook.

 @synchronize_from_tb: Callback for synchronizing state from a TCG
       #TranslationBlock. This is called when we abandon execution
       of a TB before starting it, and must set all parts of the CPU
       state which the previous TB in the chain may not have updated.
       This always includes at least the program counter; some targets
       will need to do more. If this hook is not implemented then the
       default is to call @set_pc(tb->pc).

The code changes we need are:
 * implement synchronize_from_tb for Arm (since TYPE_AARCH64_CPU
   inherits from TYPE_ARM_CPU this means we either need to have
   the code handle both AArch64 and AArch32, or else implement
   separate versions of the hook for both)
 * make set_pc for Arm have the set-thumb-mode behaviour
 * remove now unnecessary code in target/arm/arm-powerctl.c that
   sets thumb mode itself and clears out the low bit of the PC value
 * ditto in hw/arm/boot.c

thanks
-- PMM
