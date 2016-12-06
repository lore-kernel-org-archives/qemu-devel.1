Received: from eggs.gnu.org ([2001:4830:134:3::10]:33688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEEyh-0008MC-R7
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEEye-00036q-Om
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:36:11 -0500
Received: from mail-ua0-f181.google.com ([209.85.217.181]:36282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cEEye-00036W-K3
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:36:08 -0500
Received: by mail-ua0-f181.google.com with SMTP id b35so379140255uaa.3
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 04:36:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161206113915.26308.72810.malonedeb@wampee.canonical.com>
References: <20161206113915.26308.72810.malonedeb@wampee.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Dec 2016 12:34:47 +0000
Message-ID: <CAFEAcA-Uc_g0NP78oEwg3u1cCmGPCxruMptt_OOAhhLiGfd4QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Bug 1647683] [NEW] Bad interaction between tb
 flushing & gdb stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1647683 <1647683@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <bonzini@gnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 6 December 2016 at 11:39, Julian Brown <1647683@bugs.launchpad.net> wrote:
> Running QEMU under GDB in the test harness via Valgrind, using something
> akin to:
>
> (gdb) target remote | valgrind --tool=memcheck qemu-arm-system [...]
>
> leads to intermittent (and quite hard-to-reproduce) segfaults in QEMU of
> the form:
>
> ==52333== Process terminating with default action of signal 11 (SIGSEGV)
> ==52333==  Access not within mapped region at address 0x24
> ==52333==    at 0x1D55F2: tb_page_remove (translate-all.c:1026)
> ==52333==    by 0x1D58B4: tb_phys_invalidate (translate-all.c:1119)
> ==52333==    by 0x1D63AA: tb_invalidate_phys_page_range (translate-all.c:1519)
> ==52333==    by 0x1D66D7: tb_invalidate_phys_addr (translate-all.c:1714)
> ==52333==    by 0x1CBA7F: breakpoint_invalidate (exec.c:704)
> ==52333==    by 0x1CC01F: cpu_breakpoint_remove_by_ref (exec.c:869)
> ==52333==    by 0x1CBF97: cpu_breakpoint_remove (exec.c:857)
> ==52333==    by 0x218FAA: gdb_breakpoint_remove (gdbstub.c:717)
> ==52333==    by 0x219E35: gdb_handle_packet (gdbstub.c:1035)
> ==52333==    by 0x21AF62: gdb_read_byte (gdbstub.c:1459)
> ==52333==    by 0x21B096: gdb_chr_receive (gdbstub.c:1672)
> ==52333==    by 0x3AF2BC: qemu_chr_be_write_impl (qemu-char.c:419)
>
> These crashes didn't happen on a 2.6-era QEMU, so I bisected and
> discovered the commit 3359baad36889b83df40b637ed993a4b816c4906 ("tcg:
> Make tb_flush() thread safe") appears to be the thing that triggers this
> intermittent failure. Reverting the patch on the branch tip makes the
> crashes go away.

I saw something similar the other day as well, not involving valgrind,
just a simple gdb connected to the gdbstub.

thanks
-- PMM
