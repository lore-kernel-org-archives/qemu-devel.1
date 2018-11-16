Received: from eggs.gnu.org ([2001:4830:134:3::10]:52564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gNjNY-0006Wj-B9
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 14:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gNjNS-0004af-9H
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 14:02:08 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <remy.noel@blade-group.com>)
	id 1gNjNS-0004Xb-0g
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 14:02:02 -0500
Received: by mail-wm1-x344.google.com with SMTP id f1-v6so1580187wmg.1
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 11:02:01 -0800 (PST)
From: remy.noel@blade-group.com
Date: Fri, 16 Nov 2018 20:02:07 +0100
Message-Id: <20181116190211.17622-1-remy.noel@blade-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] aio_poll race condition.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Remy Noel <remy.noel@blade-group.com>

From: Remy Noel <remy.noel@blade-group.com>

It is possible for an io_poll callback to be concurrently executed along
with an aio_set_fd_handlers. This can cause all sorts of problems, like
a NULL callback or a bad opaque pointer.
We fixes that by using an remove/insert RCU scheme.

Please note that i did not test the win32 version.

Remy Noel (3):
  aio-posix: Fix concurrent aio_poll/set_fd_handler.
  util/aio-posix: Use RCU for handler insertion.
  aio: Do not use list_lock as a sync mechanism for aio_handlers
    anymore.

 include/block/aio.h |   4 +-
 util/aio-posix.c    | 148 ++++++++++++++++++++------------------------
 util/aio-win32.c    |  82 +++++++++---------------
 util/async.c        |   7 ++-
 4 files changed, 103 insertions(+), 138 deletions(-)

-- 
2.19.1
