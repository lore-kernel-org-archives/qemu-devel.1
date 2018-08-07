Received: from eggs.gnu.org ([2001:4830:134:3::10]:49608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fmy7E-0007Am-MG
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fmy7D-00078d-ST
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:17:20 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  7 Aug 2018 17:16:53 +0800
Message-Id: <20180807091655.32472-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Fix aio_notify_accept()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, lersek@redhat.com, qemu-block@nongnu.org

v2: Implement the fix following Paolo's idea.
    Testing is still in progress.

Calling aio_notify_accept(iothread->ctx) from main loop when it does
aio_poll(iothread->ctx, false) is a bug because it may steal the event needed
by aio_poll(iothread->ctx, true) in the IOThread. This can cause IOThread
hanging.

Fam Zheng (2):
  aio-posix: Don't count ctx->notifier as progress when polling
  aio: Do aio_notify_accept only during blocking aio_poll

 util/aio-posix.c | 7 ++++---
 util/aio-win32.c | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.17.1
