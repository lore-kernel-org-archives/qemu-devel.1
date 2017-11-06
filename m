Received: from eggs.gnu.org ([2001:4830:134:3::10]:35986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eBmCo-0002C7-2V
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:33:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eBmCn-0000qz-8u
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:33:06 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eBmCn-0000ky-2r
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:33:05 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  6 Nov 2017 18:33:22 +0000
Message-Id: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] linux-user: fix various SIGSEGV delivery
 bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

This patchset fixes most of the problems with delivering SIGSEGV
noted in https://bugs.launchpad.net/qemu/+bug/1705118:
 * s390x is missing masking operations on the fault address
   passed to the guest in si_addr
 * ppc is passing the PC of the offending insn, not the data
   address, into si_addr
 * sparc fails to record the address of a data fault and so
   passes 0 into si_addr
 * sparc isn't implementing rt_sigaction correctly (it has an
   extra 'restorer' argument, similar to alpha)

It doesn't actually get the sparc testcase from that bug working,
though, because SPARC is entirely missing support for setup_rt_frame()
and do_rt_sigreturn(), so it can't deliver RT signals.

Implementing RT signal delivery is too big a bugfix for an afternoon,
so here are the simpler parts. I'll leave the signal delivery part
to somebody who cares about SPARC guests...

thanks
-- PMM

Peter Maydell (4):
  linux-user/s390x: Mask si_addr for SIGSEGV
  linux-user/ppc: Report correct fault address for data faults
  linux-user/sparc: Put address for data faults where linux-user expects
    it
  linux-user: Handle rt_sigaction correctly for SPARC

 linux-user/main.c         |  8 ++++++--
 linux-user/syscall.c      | 27 +++++++++++++++++++++++----
 target/sparc/mmu_helper.c |  8 ++++++++
 3 files changed, 37 insertions(+), 6 deletions(-)

-- 
2.7.4
