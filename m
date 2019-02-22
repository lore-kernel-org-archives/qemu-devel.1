Received: from eggs.gnu.org ([209.51.188.92]:52438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gx9Uq-0004va-Nd
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:00:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gx9Uo-0004AI-7i
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:00:04 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:39611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gx9Un-0003pk-PX
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:00:02 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 22 Feb 2019 13:59:09 +0200
Message-Id: <cover.1550836631.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/3] char-socket: Fix race condition
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

This is essentially v1 rebased on top of the current master, after
Daniel and Marc-André's chardev series have been merged.

Note: vhost-user-test still fails if QTEST_VHOST_USER_FIXME is set.

Berto

RFC: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01510.html

v1: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01834.html
- Fixes memory leaks and adds a qemu_idle_add() function

v2:
- Rebased on top of the current master (fc3dbb90f2eb069801bfb4cfe9cbc)
- Patches 1 and 2: Remove the changes in char-pty.c, they're not
                   needed after the rebase.
- Patch 3: Fix conflicts after the rebase.

git backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/3:[down] 'main-loop: Fix GSource leak in qio_task_thread_worker()'
002/3:[0027] [FC] 'main-loop: Add qemu_idle_add()'
003/3:[0004] [FC] 'char-socket: Lock tcp_chr_disconnect() and socket_reconnect_timeout()'

Alberto Garcia (3):
  main-loop: Fix GSource leak in qio_task_thread_worker()
  main-loop: Add qemu_idle_add()
  char-socket: Lock tcp_chr_disconnect() and socket_reconnect_timeout()

 chardev/char-socket.c    | 19 +++++++++++++++++--
 include/qemu/main-loop.h | 12 ++++++++++++
 io/task.c                |  9 +++------
 util/main-loop.c         |  9 +++++++++
 4 files changed, 41 insertions(+), 8 deletions(-)

-- 
2.11.0
