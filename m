Received: from eggs.gnu.org ([2001:4830:134:3::10]:39052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYcjM-0007Pa-MI
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYcjL-0003uJ-U0
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:32:52 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 21 Jul 2017 13:32:41 -0500
Message-Id: <20170721183243.22706-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/2] Bug fixes from byte-based block
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

Series 2-4 of my byte-based conversion missed soft freeze, so they
are now 2.11 material.  However, there are some bug fixes in those
series that we should fix now in 2.10 (patch 1 from series two
on dirty bitmaps, patch 2 extracted from "qcow2: Switch qcow2_measure()
to byte-based iteration" from series three on block status).

I don't know if it is worth enhancing iotest 178 to probe the size
of a 2T image.  The test is simple, and fast when patched:

$ qemu-img create -f qcow2 -o cluster_size=2M huge 2T
$ time ./qemu-img measure -O qcow2 -f qcow2 huge
required size: 335806464
fully allocated size: 2199359062016

real	0m0.021s
user	0m0.017s
sys	0m0.004s

but the inf-loop when unpatched is annoying; meanwhile, 'huge' only
occupies 6 megabytes on disk, so it's not that invasive.

Eric Blake (2):
  dirty-bitmap: Report BlockDirtyInfo.count in bytes, as documented
  qcow2: Fix sector calculation in qcow2_measure()

 block/dirty-bitmap.c | 2 +-
 block/qcow2.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.13.3
