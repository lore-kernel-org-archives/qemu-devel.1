Received: from eggs.gnu.org ([2001:4830:134:3::10]:53350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1ga07Y-0006dB-IV
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1ga07V-0005mL-BA
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:20:20 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:33067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <remy.noel@blade-group.com>)
	id 1ga07U-0005j5-Vh
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:20:17 -0500
Received: by mail-ed1-x543.google.com with SMTP id p6so2083740eds.0
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 07:20:16 -0800 (PST)
From: remy.noel@blade-group.com
Date: Thu, 20 Dec 2018 16:20:28 +0100
Message-Id: <20181220152030.28035-1-remy.noel@blade-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [QEMU-devel][PATCH v4 0/2] Fix concurrent
 aio_poll/set_fd_handler.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Remy Noel <remy.noel@blade-group.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>

From: Remy Noel <remy.noel@blade-group.com>

It is possible for an io_poll/read/write callback to be concurrently executed along
with an aio_set_fd_handlers. This can cause all sorts of problems, like
a NULL callback or a bad opaque pointer.

V2:
    * Do not use RCU anymore as it inccurs a performance loss
V3:
    * Don't drop revents when a handler is modified [Stefan]
V4:
    * Unregister fd from ctx epoll when removing fd_handler [Paolo]

Remy Noel (2):
  aio-posix: Unregister fd from ctx epoll when removing fd_handler.
  aio-posix: Fix concurrent aio_poll/set_fd_handler.

 util/aio-posix.c | 90 +++++++++++++++++++++++++++++-------------------
 util/aio-win32.c | 67 ++++++++++++++++-------------------
 2 files changed, 84 insertions(+), 73 deletions(-)

-- 
2.19.2
