Received: from eggs.gnu.org ([2001:4830:134:3::10]:55770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1EwH-00004z-5Q
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1EwE-0003xE-HW
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:32:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:45870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1f1EwE-0003wM-8J
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:32:42 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 28 Mar 2018 20:32:34 +0300
Message-Id: <20180328173238.507470-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/4] qemugdb: coroutine backtrace for coredump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all. Here are some qemugdb enhancements around qemu coroutine command.
The main feature is a backtrace for coroutine, when debugging with a
coredump file.

The problem is that we can't get coroutine backtrace through obvious way
 - set regs
 - bt
 - restore regs
when debugging a coredump.
So, let's go hard way: clone current coredump file, patch regs
in it and execute a subprocess gdb to get backtrace from this
patched coredump.

Vladimir Sementsov-Ogievskiy (4):
  scripts/qemugdb: get pthread_self from "info threads" command
  scripts/qemugdb: improve "qemu coroutine" command
  scripts/qemugdb: add coredump.py for coredump patching
  scripts/qemugdb: backtraces for coroutines in coredump

 scripts/qemugdb/coredump.py  | 51 ++++++++++++++++++++++++++++++++++++++++++
 scripts/qemugdb/coroutine.py | 53 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 99 insertions(+), 5 deletions(-)
 create mode 100644 scripts/qemugdb/coredump.py

-- 
2.11.1
