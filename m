Received: from eggs.gnu.org ([2001:4830:134:3::10]:50879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgbK8-0005BZ-E8
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgbK7-00071I-Km
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:07:32 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 22 Feb 2017 19:07:22 +0100
Message-Id: <20170222180725.28611-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] do not use aio_context_acquire/release
 in AIO-based drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, jcody@redhat.com, qemu-block@nongnu.org

aio_context_acquire/release are only going away as soon as the block layer
becomes thread-safe, but we can already move away to other finer-grained
mutex whenever possible.

These three drivers don't use coroutines, hence a QemuMutex is a fine
primitive to use for protecting any per-BDS data in the libraries
they use.  The QemuMutex must protect any fd handlers or bottom halves,
and also the BlockDriver callbacks which were implicitly being called
under aio_context_acquire.

Paolo

v1->v2: missing unlock in error paths (patch 2, Stefan)

Paolo Bonzini (3):
  curl: do not use aio_context_acquire/release
  nfs: do not use aio_context_acquire/release
  iscsi: do not use aio_context_acquire/release

 block/curl.c  | 24 ++++++++++-------
 block/iscsi.c | 83 +++++++++++++++++++++++++++++++++++++++++++++--------------
 block/nfs.c   | 23 ++++++++++++++---
 3 files changed, 98 insertions(+), 32 deletions(-)

-- 
2.9.3
