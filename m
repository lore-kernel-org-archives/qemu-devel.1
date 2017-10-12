Received: from eggs.gnu.org ([2001:4830:134:3::10]:38992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fjZ-0001sj-19
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e2fjY-0008AD-4x
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:49:17 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1e2fjX-00088O-TA
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:49:16 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 16:30:43 +0100
Message-Id: <1507822245-15748-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] fix incorrect target ioctl numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, pgndev <pgnet.dev@gmail.com>

Some of our TARGET_* constant definitions for ioctls were
wrong because the ioctl number is based on the sizeof()
the type passed to the TARGET_IO* macros, and we were
passing a host type rather than a target type.
This was originally reported as a bug where the
FS_IOC_{GET,SET}FLAGS ioctls weren't working for 32-bit
arm guests on x86-64 hosts.

I did a quick audit of all the uses of the TARGET_IO* macros
in syscall_defs.h, and:
 * FS_IOC_GETFLAGS/SETFLAGS are indeed wrong
 * 3 ioctls to do with magtapes are also wrong
 * TARGET_FS_IOC_FIEMAP, TARGET_FICLONERANGE and
   TARGET_SOUND_MIXER_INFO take a host struct which
   is defined such that it's the same size for all archs
 * lots and lots of ioctls use 'int', which is OK as for
   us 'abi_int' is always 32 bits (it might have different
   alignment requirements, but they don't matter for this
   purpose)
 * TARGET_SIOCPGRP takes a pid_t, which is always 'int'

This patchset fixes the bugs in the first two bullet
points, and leaves everything else alone since it doesn't
actually manifest as wrong behaviour.

Patch 1 is tested by the LTP 'setxattrs3' test case.
There's no LTP test case for the magtape ioctls, so that
patch change is untested.


Peter Maydell (2):
  linux-user: Fix target FS_IOC_GETFLAGS and FS_IOC_SETFLAGS numbers
  linux-user: Fix TARGET_MTIOCTOP/MTIOCGET/MTIOCPOS values

 linux-user/syscall_defs.h | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

-- 
2.7.4
