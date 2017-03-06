Received: from eggs.gnu.org ([2001:4830:134:3::10]:49674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ckmth-0001Zp-JD
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1ckmtd-00005y-MB
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:17:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1ckmtd-000053-Gj
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:17:29 -0500
From: P J P <ppandit@redhat.com>
Date: Mon,  6 Mar 2017 12:47:19 +0530
Message-Id: <20170306071721.26708-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Limit and protect execve arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Eric Blake <eblake@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Jann Horn <jannh@google.com>, Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Hello,

A user program could pass large number of 'argv','env' arguments to an
execve(2) call. It could lead to bad behaviour as the TARGET_NR_execve:
allocates stack memory(via alloca) for these arguments. alloca(3) is
better for allocations of upto one page(4KB) of stack memory. As anything
more could smash stack protectors in place.

This patch(v2) set attempts to fix these issues.
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg00750.html

Thank you.
--
Prasad J Pandit (2):
  linux-user: limit number of arguments to execve
  linux-user: allocate heap memory for execve arguments

 linux-user/syscall.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--
2.9.3
