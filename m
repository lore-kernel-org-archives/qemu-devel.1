Received: from eggs.gnu.org ([2001:4830:134:3::10]:53218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fnkuP-0007in-GZ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fnkuO-0002Ta-EL
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:23:21 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  9 Aug 2018 21:22:57 +0800
Message-Id: <20180809132259.18402-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] Fix aio_notify_accept()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Fam Zheng <famz@redhat.com>, qemu-stable@nongnu.org, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, lersek@redhat.com

v3: Fix commit message's bug description. [Paolo]

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
