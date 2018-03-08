Received: from eggs.gnu.org ([2001:4830:134:3::10]:38779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1etwpW-00036M-IC
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1etwpV-0007oC-FY
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:47:38 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1etwpV-0007nP-86
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:47:37 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  8 Mar 2018 14:47:31 +0000
Message-Id: <20180308144733.25615-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] Drop dead linux-user/unicore32 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Guan Xuetao <gxt@mprc.pku.edu.cn>

We disabled the unicore32-linux-user in commit 5e2b40f7271cf9d
in 2016, due to a problem with the syscall ABI it implemented
being out of date and out of sync with the mainline kernel.
In the intervening year and a half there have been no proposals
to fix these problems so that we could re-enable it. This
patchset removes the 750 lines of dead code from linux-user.
(I suggested this in
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06634.html
and there were no objections.)

The second patch is a cleanup we can make as a result, since
with unicore32 gone all our targets implement signal handling:
we can remove the default "not implemented" stub functions.
You could argue that these might be helpful for future new targets,
but IMHO signal handling support is too important to allow a
hypothetical new target to silently get away without implementing
it.  For initial development it's easy enough to stub out the
per-architecture functions, and then we will have a clear view of
which targets (if any) don't have the signal handling implemented
yet, and the missing feature will show up in code review.

thanks
-- PMM


Peter Maydell (2):
  linux-user: Drop unicore32 code
  linux-user: Remove the unused "not implemented" signal handling stubs

 linux-user/qemu.h                     |   5 +-
 linux-user/syscall_defs.h             |   6 +-
 linux-user/unicore32/syscall_nr.h     | 371 ----------------------------------
 linux-user/unicore32/target_cpu.h     |  27 ---
 linux-user/unicore32/target_elf.h     |  14 --
 linux-user/unicore32/target_signal.h  |  30 ---
 linux-user/unicore32/target_structs.h |  58 ------
 linux-user/unicore32/target_syscall.h |  62 ------
 linux-user/unicore32/termbits.h       |   2 -
 linux-user/elfload.c                  |  72 -------
 linux-user/main.c                     |  99 +--------
 linux-user/signal.c                   |  32 +--
 12 files changed, 7 insertions(+), 771 deletions(-)
 delete mode 100644 linux-user/unicore32/syscall_nr.h
 delete mode 100644 linux-user/unicore32/target_cpu.h
 delete mode 100644 linux-user/unicore32/target_elf.h
 delete mode 100644 linux-user/unicore32/target_signal.h
 delete mode 100644 linux-user/unicore32/target_structs.h
 delete mode 100644 linux-user/unicore32/target_syscall.h
 delete mode 100644 linux-user/unicore32/termbits.h

-- 
2.16.2
