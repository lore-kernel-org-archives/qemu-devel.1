Received: from eggs.gnu.org ([2001:4830:134:3::10]:56866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dMwuz-0008RN-Nz
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dMwuw-0001di-Hy
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 09:40:37 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 19 Jun 2017 16:40:01 +0300
Message-Id: <cover.1497879398.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 0/7] Reduce the number of I/O ops when doing
 COW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>

Hi all,

here's a patch series that rewrites the copy-on-write code in the
qcow2 driver to reduce the number of I/O operations.

This is version v4, please refer to the original e-mail for a complete
description:

https://lists.gnu.org/archive/html/qemu-block/2017-05/msg00882.html

Regards,

Berto

v4:
- Patch 6: Initialize the QEMUIOVector with only 1 iovecs [Kevin]
- Patch 7: Initialize the QEMUIOVector with 2 + m->data_qiov->niov [Kevin]
- Patch 7: Rename can_merge_cow() to merge_cow() [Kevin]

v3: https://lists.gnu.org/archive/html/qemu-block/2017-06/msg00472.html
- Patch 4: Over-allocate the read buffer in perform_cow() so both COW
           sectors are optimally aligned [Eric]

v2: https://lists.gnu.org/archive/html/qemu-block/2017-06/msg00227.html
- Patch 1: Update commit message [Eric]
- Patch 7: Make sure that the number of iovs does not exceed IOV_MAX [Anton]
- Patch 7: Don't add zero-length buffers to the qiov in perform_cow()

v1: https://lists.gnu.org/archive/html/qemu-block/2017-05/msg00882.html
- Initial version

Output of git-backport-diff against v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/7:[----] [--] 'qcow2: Remove unused Error variable in do_perform_cow()'
002/7:[----] [--] 'qcow2: Use unsigned int for both members of Qcow2COWRegion'
003/7:[----] [--] 'qcow2: Make perform_cow() call do_perform_cow() twice'
004/7:[----] [--] 'qcow2: Split do_perform_cow() into _read(), _encrypt() and _write()'
005/7:[----] [--] 'qcow2: Allow reading both COW regions with only one request'
006/7:[0002] [FC] 'qcow2: Pass a QEMUIOVector to do_perform_cow_{read,write}()'
007/7:[0008] [FC] 'qcow2: Merge the writing of the COW regions with the guest data'

Alberto Garcia (7):
  qcow2: Remove unused Error variable in do_perform_cow()
  qcow2: Use unsigned int for both members of Qcow2COWRegion
  qcow2: Make perform_cow() call do_perform_cow() twice
  qcow2: Split do_perform_cow() into _read(), _encrypt() and _write()
  qcow2: Allow reading both COW regions with only one request
  qcow2: Pass a QEMUIOVector to do_perform_cow_{read,write}()
  qcow2: Merge the writing of the COW regions with the guest data

 block/qcow2-cluster.c | 201 ++++++++++++++++++++++++++++++++++++++------------
 block/qcow2.c         |  64 +++++++++++++---
 block/qcow2.h         |  11 ++-
 3 files changed, 216 insertions(+), 60 deletions(-)

-- 
2.11.0
