Received: from eggs.gnu.org ([2001:4830:134:3::10]:34757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9ZhY-0000hI-2r
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 12:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9ZhW-0005FL-UM
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 12:47:44 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:49225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9ZhW-0005F3-Mz
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 12:47:42 -0400
Received: by mail-wr0-x242.google.com with SMTP id g90so16539553wrd.6
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 09:47:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <92e2caac-31e2-d32f-1b71-810b8297736c@bitwagon.com>
References: <92e2caac-31e2-d32f-1b71-810b8297736c@bitwagon.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2017 16:47:20 +0000
Message-ID: <CAFEAcA-3t01P6sJZ=ZUVjmoMt5Z_n61w8YEzBLakKPv2w_qMGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] unfaithful emulation of system calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Reiser <jreiser@bitwagon.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 31 October 2017 at 16:18, John Reiser <jreiser@bitwagon.com> wrote:
> On real Linux on PowerPC64, a system call trashes registers {r0, r4-r12,
> ctr};
> qemu-ppc64 preserves them.  [Both preserve: r13-r31, r1 (sp), r2 (TOC), r3
> (set to
> return value), lr (link register).]  Looking at the code in
> qemu/linux-user/syscall.c
> (tip commit 92c7ec5cd4d15c76218703f7bd3ca75bd46353b7), I do not see anything
> which
> "enforces the ABI", such as by setting all volatile registers to a random
> value,
> or a flag such as 0xA5A5A5...A5A5, or at least to 0.  qemu-user should.
>
> This raises the question, "What *is* the ABI for system calls?".
> The documentation
> http://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi.html#REG
> does not state explicitly that a system call is the same as a subroutine
> call.
> Indeed it isn't, because a system call preserves the link register lr,
> but a subroutine call need not.
>
> So, how about qemu-user enforcing the ABI for system calls?

The ABI is in general "the caller can rely on register set A
being preserved across the syscall instruction; it cannot rely
on register set B being preserved" (for values of A and B that
vary across architectures). The kernel doesn't guarantee
that it is going to trash registers in set B; it merely does
not provide the guarantee that it won't trash them. Exactly
what happens for the set B regs is an implementation detail
and one which could vary from kernel version to kernel version.
qemu's linux-user mode implements the ABI; we happen to not
trash things in set B because of our implementation, but that's
OK because the ABI doesn't require us to trash them.

thanks
-- PMM
