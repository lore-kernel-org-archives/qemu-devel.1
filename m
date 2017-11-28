Received: from eggs.gnu.org ([2001:4830:134:3::10]:44025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eJgzL-0004Sp-9N
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eJgzK-0003rx-1o
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:35:55 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eJgzJ-0003lI-Qs
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:35:53 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2017 14:35:23 +0000
Message-Id: <1511879725-9576-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] linux-user: Fix race between threads in
 page_unprotect()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

If multiple guest threads in user-mode emulation write to a
page which QEMU has marked read-only because of cached TCG
translations, the threads can race in page_unprotect:

 * threads A & B both try to do a write to a page with code in it at
   the same time (ie which we've made non-writeable, so SEGV)
 * they race into the signal handler with this faulting address
 * thread A happens to get to page_unprotect() first and takes the
   mmap lock, so thread B sits waiting for it to be done
 * A then finds the page, marks it PAGE_WRITE and mprotect()s it writable
 * A can then continue OK (returns from signal handler to retry the
   memory access)
 * ...but when B gets the mmap lock it finds that the page is already
   PAGE_WRITE, and so it exits page_unprotect() via the "not due to
   protected translation" code path, and wrongly delivers the signal
   to the guest rather than just retrying the access

In particular, this meant that trying to run 'javac' in user-mode
emulation would fail with a spurious guest SIGSEGV.

Handle this by making page_unprotect() assume that a call for a page
which is already PAGE_WRITE is due to a race of this sort and return
a "fault handled" indication.

Since this would cause an infinite loop if we ever called
page_unprotect() for some other kind of fault than "write failed due
to bad access permissions", tighten the condition in
handle_cpu_signal() to check the signal number and si_code, and add a
comment so that if somebody does ever find themselves debugging an
infinite loop of faults they have some clue about why.

(The trick for identifying the correct setting for
current_tb_invalidated for thread B (needed to handle the precise-SMC
case) is due to Richard Henderson.  Paolo Bonzini suggested just
relying on si_code rather than trying anything more complicated.)

I'm slightly nervous about assuming that we get SEGV with SEGV_ACCERR
on a write if and only if the page permissions are set to non-writeable
(for instance https://www.mail-archive.com/tech@openbsd.org/msg40358.html
is a surprisingly recent patch to fix this for OpenBSD/x86, and I
would be unsurprised if QEMU usermode itself got the si_code wrong,
and the Boehm gc code at https://github.com/ivmai/bdwgc/blob/master/os_dep.c#L3182
is quite convoluted), but on the other hand we really ought in theory
to be able to rely on si_code, and trying to handle this some other way
gets pretty convoluted...

thanks
-- PMM

Peter Maydell (2):
  linux-user: Propagate siginfo_t through to handle_cpu_signal()
  page_unprotect(): handle calls to pages that are PAGE_WRITE

 accel/tcg/translate-all.c | 50 ++++++++++++++++++++++++++++-----------------
 accel/tcg/user-exec.c     | 52 +++++++++++++++++++++++------------------------
 2 files changed, 57 insertions(+), 45 deletions(-)

-- 
2.7.4
