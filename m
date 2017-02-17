Received: from eggs.gnu.org ([2001:4830:134:3::10]:40304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceoOM-0000R4-RW
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceoOJ-0002te-L3
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:40:30 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 17 Feb 2017 20:40:25 +0100
Message-Id: <20170217194028.8398-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] do not use aio_context_acquire/release in
 AIO-based drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com

aio_context_acquire/release are only going away as soon as the block layer
becomes thread-safe, but we can already move away to other finer-grained
mutex whenever possible.

These three drivers don't use coroutines, hence a QemuMutex is a fine
primitive to use for protecting any per-BDS data in the libraries
they use.  The QemuMutex must protect any fd handlers or bottom halves,
and also the BlockDriver callbacks which were implicitly being called
under aio_context_acquire.

Paolo

Paolo Bonzini (3):
  curl: do not use aio_context_acquire/release
  nfs: do not use aio_context_acquire/release
  iscsi: do not use aio_context_acquire/release

 block/curl.c  | 24 ++++++++++-------
 block/iscsi.c | 83 +++++++++++++++++++++++++++++++++++++++++++++--------------
 block/nfs.c   | 20 +++++++++++---
 3 files changed, 95 insertions(+), 32 deletions(-)

-- 
2.9.3
