Received: from eggs.gnu.org ([209.51.188.92]:55320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gxBBZ-0007Kj-8v
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gxBBX-0001pN-A1
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:48:17 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:56219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gxBBW-0000iT-98
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:48:15 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 22 Feb 2019 15:46:23 +0200
Message-Id: <cover.1550842915.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/3] char-socket: Fix race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This fixes a race condition in which the tcp_chr_read() ioc handler
can close a connection that is being written to from another thread.

Note: vhost-user-test still fails if QTEST_VHOST_USER_FIXME is set.

Berto

RFC: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01510.html

v1: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01834.html
- Fixes memory leaks and adds a qemu_idle_add() function

v2: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg06137.html
- Rebased on top of the current master (fc3dbb90f2eb069801bfb4cfe9cbc)
- Patches 1 and 2: Remove the changes in char-pty.c, they're not
                   needed after the rebase.
- Patch 3: Fix conflicts after the rebase.

v3:
- Patch 3: Add tcp_chr_disconnect_locked() [Daniel]

Alberto Garcia (3):
  main-loop: Fix GSource leak in qio_task_thread_worker()
  main-loop: Add qemu_idle_add()
  char-socket: Lock tcp_chr_disconnect() and socket_reconnect_timeout()

 chardev/char-socket.c    | 25 +++++++++++++++++++++----
 include/qemu/main-loop.h | 12 ++++++++++++
 io/task.c                |  9 +++------
 util/main-loop.c         |  9 +++++++++
 4 files changed, 45 insertions(+), 10 deletions(-)

-- 
2.11.0
