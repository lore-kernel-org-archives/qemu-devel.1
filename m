Received: from eggs.gnu.org ([2001:4830:134:3::10]:48896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePqQF-0001ZQ-H5
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePqQE-0002Qt-Of
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:53:07 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePqQE-0002MG-IP
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:53:06 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2017 13:52:54 +0000
Message-Id: <1513345976-22958-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] linux-user: Fix length calculations in
 host_to_target_cmsg()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Bruno Haible <bruno@clisp.org>

This patchset fixes this bug:
https://bugs.launchpad.net/qemu/+bug/1701808

where we were getting our message length calculations in
host_to_target_cmsg() wrong and could thus overwrite the end of the
guest buffer when we tried to fill it with the results of a
recvmsg().

Patch 1 is the bugfix; patch 2 is a minor cleanup which removes some
unnecessary and confusing alignment arithmetic and brings us into
alignment with what the kernel currently does.

thanks
-- PMM

Peter Maydell (2):
  linux-user: Fix length calculations in host_to_target_cmsg()
  linux-user: Don't use CMSG_ALIGN(sizeof struct cmsghdr)

 linux-user/syscall_defs.h |  6 +++---
 linux-user/syscall.c      | 33 ++++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.7.4
