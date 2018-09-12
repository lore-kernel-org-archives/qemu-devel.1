Received: from eggs.gnu.org ([2001:4830:134:3::10]:33509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g08fF-0004S4-Nq
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g08fF-0006qG-4U
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:10:53 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Sep 2018 19:10:37 +0200
Message-Id: <20180912171040.1732-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] aio-posix: polling mode bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com, kwolf@redhat.com, stefanha@redhat.com

Patch 1 fixes a too-strict assertion that could fire when aio_poll
is called in parallel with aio_set_fd_handler.

Patch 2 and 3 reinstate the performance benefits of polling, which were
essentially disabled by commit 70232b5253 ("aio-posix: Don't count
ctx->notifier as progress when polling", 2018-08-15).

Please review carefully! :)

Thanks,

Paolo

Paolo Bonzini (3):
  aio-posix: fix concurrent access to poll_disable_cnt
  aio-posix: compute timeout before polling
  aio-posix: do skip system call if ctx->notifier polling succeeds

 util/aio-posix.c  | 88 +++++++++++++++++++++++++++--------------------
 util/trace-events |  4 +--
 2 files changed, 53 insertions(+), 39 deletions(-)

-- 
2.17.1
