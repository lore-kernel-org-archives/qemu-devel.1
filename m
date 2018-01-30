Received: from eggs.gnu.org ([2001:4830:134:3::10]:52356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egZt2-0008K2-30
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egZsy-0004LI-4r
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:40:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1egZsx-0004Ab-Sb
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:39:56 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0UHddFE061896
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 12:39:47 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fttpbgsqc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 12:39:46 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 30 Jan 2018 17:39:43 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 30 Jan 2018 18:39:25 +0100
Message-Id: <20180130173935.5172-1-groug@kaod.org>
Subject: [Qemu-devel] [PULL 00/10] 9p patches for 2.12 20180130
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

The following changes since commit 30d9fefe1aca1e92c785214aa9201fd7c2287d56:

  Merge remote-tracking branch 'remotes/kraxel/tags/input-20180129-v2-pull-request' into staging (2018-01-29 15:52:27 +0000)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 0dfef72861261bdfd30f2cc53d61c12c097af11a:

  tests/virtio-9p: explicitly handle potential integer overflows (2018-01-30 15:28:56 +0100)

----------------------------------------------------------------
This series is mostly about 9p request cancellation. It fixes a
long standing bug (read "specification violation") where the server
would send an invalid response when the client has cancelled an
in-flight request. This was causing annoying spurious EINTR returns
in linux. The fix comes with some related testing in QTEST.

Other patches are code cleanup and improvements.

----------------------------------------------------------------
Greg Kurz (9):
      9pfs: drop v9fs_register_transport()
      tests: virtio-9p: move request tag to the test functions
      tests: virtio-9p: wait for completion in the test code
      tests: virtio-9p: use the synth backend
      tests: virtio-9p: add LOPEN operation test
      tests: virtio-9p: add WRITE operation test
      libqos/virtio: return length written into used descriptor
      tests: virtio-9p: add FLUSH operation test
      tests/virtio-9p: explicitly handle potential integer overflows

Keno Fischer (1):
      9pfs: Correctly handle cancelled requests

 hw/9pfs/9p-synth.c         |  56 +++++++++
 hw/9pfs/9p-synth.h         |  11 ++
 hw/9pfs/9p.c               |  25 +++-
 hw/9pfs/9p.h               |  10 +-
 hw/9pfs/trace-events       |   1 +
 hw/9pfs/virtio-9p-device.c |   8 +-
 hw/9pfs/xen-9p-backend.c   |   3 +-
 tests/libqos/virtio.c      |  25 ++--
 tests/libqos/virtio.h      |   3 +-
 tests/virtio-9p-test.c     | 293 ++++++++++++++++++++++++++++++++++++++-------
 tests/virtio-blk-test.c    |  24 ++--
 tests/virtio-net-test.c    |   6 +-
 tests/virtio-scsi-test.c   |   3 +-
 13 files changed, 386 insertions(+), 82 deletions(-)
-- 
2.13.6
