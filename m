Received: from eggs.gnu.org ([2001:4830:134:3::10]:44568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIbdw-000814-CE
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dIbdr-0002YM-9T
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:09:04 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  7 Jun 2017 17:08:21 +0300
Message-Id: <cover.1496844254.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 0/7] qcow2: Reduce the number of I/O ops
 when doing COW
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

This is version v2, please refer to the original e-mail for a complete
description:

https://lists.gnu.org/archive/html/qemu-block/2017-05/msg00882.html

Regards,

Berto

Changes:

v2:
- Patch 1: Update commit message [Eric]
- Patch 7: Make sure that the number of iovs does not exceed IOV_MAX [Anton]
- Patch 7: Don't add zero-length buffers to the qiov in perform_cow()

v1: https://lists.gnu.org/archive/html/qemu-block/2017-05/msg00882.html
- Initial version

Output of git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/7:[down] 'qcow2: Remove unused Error variable in do_perform_cow()'
002/7:[----] [--] 'qcow2: Use unsigned int for both members of Qcow2COWRegion'
003/7:[----] [--] 'qcow2: Make perform_cow() call do_perform_cow() twice'
004/7:[----] [--] 'qcow2: Split do_perform_cow() into _read(), _encrypt() and _write()'
005/7:[----] [--] 'qcow2: Allow reading both COW regions with only one request'
006/7:[----] [--] 'qcow2: Pass a QEMUIOVector to do_perform_cow_{read,write}()'
007/7:[0014] [FC] 'qcow2: Merge the writing of the COW regions with the guest data'

Alberto Garcia (7):
  qcow2: Remove unused Error variable in do_perform_cow()
  qcow2: Use unsigned int for both members of Qcow2COWRegion
  qcow2: Make perform_cow() call do_perform_cow() twice
  qcow2: Split do_perform_cow() into _read(), _encrypt() and _write()
  qcow2: Allow reading both COW regions with only one request
  qcow2: Pass a QEMUIOVector to do_perform_cow_{read,write}()
  qcow2: Merge the writing of the COW regions with the guest data

 block/qcow2-cluster.c | 192 +++++++++++++++++++++++++++++++++++++-------------
 block/qcow2.c         |  64 ++++++++++++++---
 block/qcow2.h         |  11 ++-
 3 files changed, 207 insertions(+), 60 deletions(-)

-- 
2.11.0
