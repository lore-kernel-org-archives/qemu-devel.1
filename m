Received: from eggs.gnu.org ([2001:4830:134:3::10]:42871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fAUCd-0004Yp-Pl
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 01:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fAUCa-0001r8-OJ
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 01:39:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58814 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fAUCa-0001qA-KB
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 01:39:48 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 23 Apr 2018 13:39:23 +0800
Message-Id: <20180423053927.13715-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/4] qemu-thread: support
 --enable-debug-mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Emilio G . Cota" <cota@braap.org>, peterx@redhat.com

v4:
- cherrypick Emilio's patch to add "-m" parameter to atomic_add-bench
  tool.
- use inline functions [Emilio]

Micro benchmark result on "taskset -c 0 atomic_add-bench -m":

|--------+---------------------+------------------------|
|        | with --enable-debug | without --enable-debug |
|--------+---------------------+------------------------|
| Before | 20 Mops/s           | 34 Mops/s              |
| After  | 18 Mops/s           | 34 Mops/s              |
|--------+---------------------+------------------------|

v3:
- note down owner for every locking operations [Emilio]
- let Windows use it too [Emilio]
- added two more patches: patch 1 & 3.

Patch 1 generalize some common hooks for qemu-thread implementation
for both POSIX and Windows.

Patch 2 introduces the new debugging facility.

Patch 3 turns on mutex debugging automatically for "--enable-debug". I
suppose most developers are with that so we naturally benefit from it.

Please review.  Thanks.

Emilio G. Cota (1):
  tests/atomic_add-bench: add -m option to use mutexes

Peter Xu (3):
  qemu-thread: introduce qemu-thread-common.h
  QemuMutex: support --enable-debug-mutex
  configure: enable debug-mutex if debug enabled

 configure                   | 11 +++++++++++
 include/qemu/thread-posix.h |  4 ++++
 include/qemu/thread-win32.h |  4 ++++
 util/qemu-thread-common.h   | 46 +++++++++++++++++++++++++++++++++++++++++++++
 tests/atomic_add-bench.c    | 19 +++++++++++++++++--
 util/qemu-thread-posix.c    | 17 +++++++----------
 util/qemu-thread-win32.c    | 15 +++++++--------
 7 files changed, 96 insertions(+), 20 deletions(-)
 create mode 100644 util/qemu-thread-common.h

-- 
2.14.3
