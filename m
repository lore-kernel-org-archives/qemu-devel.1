Received: from eggs.gnu.org ([2001:4830:134:3::10]:46102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBCv-00035m-VO
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 12:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBCu-0004SX-Tv
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 12:52:38 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBCu-0004OR-Nb
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 12:52:36 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 17:52:27 +0000
Message-Id: <1513187549-2435-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] Don't abort on writes to ROMs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Paul Burton <paul.burton@mips.com>

Currently we set up the io_mem_rom special memory region using the
unassigned_mem_ops structure; this is then used when a guest tries to
write to ROM.  This is incorrect, because the behaviour of unassigned
memory may be different from that of ROM for writes.  In particular,
on some architectures writing to unassigned memory generates a guest
exception, whereas writing to ROM is generally ignored.

This patchset creates a separate readonly_mem_ops for handling the
writes to readonly memory, which just ignores them.

Patch 2 removes a workaround in the MIPS boston board which
is no longer needed once the core memory system is fixed.

Disclaimer: I haven't tested the mips change beyond 'make check'
(I tested the exec patch with a temporary hack to the Arm
virt board), but I believe it to be correct...

thanks
-- PMM


Peter Maydell (2):
  exec: Don't reuse unassigned_mem_ops for io_mem_rom
  hw/mips/boston: Remove workaround for writes to ROM aborting

 exec.c           | 34 +++++++++++++++++++++++++++++++++-
 hw/mips/boston.c | 14 ++------------
 2 files changed, 35 insertions(+), 13 deletions(-)

-- 
2.7.4
