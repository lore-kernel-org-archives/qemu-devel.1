Received: from eggs.gnu.org ([2001:4830:134:3::10]:33175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcUle-0007yn-I5
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcUld-0001Gv-Gm
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:51:14 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:36717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dcUld-0001G8-AN
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:51:13 -0400
Received: by mail-wr0-x22b.google.com with SMTP id y43so5158272wrd.3
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 03:51:13 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Aug 2017 11:50:51 +0100
Message-ID: <CAFEAcA_Kj8wCp-BLS45ds-RmZbp7UK_8oEBcEKgpP98CE0jNcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Cleaning up handling of CPU exceptions accessing
 non-existent memory/devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>

Hi; I've been looking at our code to handle allowing guest CPUs
to generate exceptions when they access non-existent memory or
devices (in ARM terms, external aborts; also often called bus errors).

At the moment we have a hook for this: do_unassigned_access().
Unfortunately this was designed a long time ago and has some nasty
problems. The hook is called from the unassigned_mem_write() and
unassigned_mem_read() functions if the current_cpu pointer is non-NULL.
This means that:
 * it will be called even if the access was not directly done by the
   CPU -- for instance if the CPU writes to an ethernet device enable
   register and triggers the ethernet device to try to read a packet
   out of non-existent memory, the CPU will take a bogus exception
 * it won't be called if there really is a device there and it actively
   reports a bus error by returning a failure MemTxResult code
 * it's called even when KVM is enabled even though trying to
   raise an exception then will crash because there's no setjmp
   context to longjmp back to

Since we have MemTxResult now, we don't need to try to call the CPU
hook from down at the bottom of the memory system; we can just call
it near the top when we get back a failure status.

My proposal is that we should define a new QOM CPU hook:
  void (*do_transaction_failed)(CPUState *cpu, hwaddr physaddr, vaddr addr,
                                unsigned size, MMUAccessType access_type,
                                MemTxAttrs attrs, MemTxResult response);

which is called from io_readx() and io_writex() if their calls
to memory_region_dispatch_{read,write} return something other than
MEMTX_OK. We can also call it from get_page_addr_code() as a
way to report instruction-fetch faults (where we currently call
cpu_unassigned_access), though I have a feeling there is a nicer
place to handle this (perhaps best left for later cleanup).

That will mean that:
 * memory accesses from generated code can cause exceptions due to
   bus faults
 * memory accesses by C code calling helper functions which take a
   virtual address can cause busfaults (which longjump out) -- but
   that should be already expected as those calls can cause MMU
   exceptions and alignment exceptions. (This kind of helper I think
   is just helper_{le,be,ret}_{ld,st}_*)
 * any other memory access by C code (ie by physical address) will not
   cause a bus fault exception -- C code must use one of the load/store
   functions that returns a MemTxResult and handle it appropriately
   if it needs some particular behaviour.

I think this is an easy rule of thumb to remember ('exceptions for
vaddr accesses; handle failure yourself for physaddr accesses') and
it seems likely that most physaddr accesses will want special casing
anyway.

The awkward part is the transition from the current hook to the new one;
we can put in the new hook easily enough, but the old one is used by:
 alpha, microblaze, mips, sparc, xtensa
Converting the hook code from the old API to the new will be easy,
but it's harder to know if there were places where the target is
relying on the old behaviour that an access by physical address
would generate an exception; in an ideal world we'd audit all the
loads and stores the target code did to check their behaviour...
I can have a go at converting some of these archs, but I can't
necessarily promise I'll get all the obscure corner cases.

When we've got all the archs converted we can delete the old
hook code.

Does this seem like a good plan?

thanks
-- PMM
