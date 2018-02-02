Received: from eggs.gnu.org ([2001:4830:134:3::10]:54279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ehe6v-0001Qp-Px
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ehe47-00045b-3r
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:20:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ehe46-00043T-Dd
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:19:50 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w12GHweY036090
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 11:19:49 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fvrmared3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 11:19:48 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 2 Feb 2018 16:19:46 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri,  2 Feb 2018 17:19:25 +0100
Message-Id: <20180202161935.20803-1-groug@kaod.org>
Subject: [Qemu-devel] [PULL v2 00/10] 9p patches for 2.12 20180202
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

The following changes since commit b05631954d6dfe93340d516660397e2c1a2a5dd6:

  Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180131' into staging (2018-01-31 15:50:29 +0000)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 9ea776ee7d4061c043d0fbf89aa85f86ec0cf8a2:

  tests/virtio-9p: explicitly handle potential integer overflows (2018-02-02 11:15:34 +0100)

----------------------------------------------------------------
This series is mostly about 9p request cancellation. It fixes a
long standing bug (read "specification violation") where the server
would send an invalid response when the client has cancelled an
in-flight request. This was causing annoying spurious EINTR returns
in linux. The fix comes with some related testing in QTEST.

Other patches are code cleanup and improvements.

v2: fix the alignment issue that was presumably causing make check to
    fail on sparc hosts

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

 hw/9pfs/9p-synth.c         |  52 ++++++++
 hw/9pfs/9p-synth.h         |  13 ++
 hw/9pfs/9p.c               |  25 +++-
 hw/9pfs/9p.h               |  10 +-
 hw/9pfs/trace-events       |   1 +
 hw/9pfs/virtio-9p-device.c |   8 +-
 hw/9pfs/xen-9p-backend.c   |   3 +-
 tests/libqos/virtio.c      |  25 ++--
 tests/libqos/virtio.h      |   3 +-
 tests/virtio-9p-test.c     | 294 ++++++++++++++++++++++++++++++++++++++-------
 tests/virtio-blk-test.c    |  24 ++--
 tests/virtio-net-test.c    |   6 +-
 tests/virtio-scsi-test.c   |   3 +-
 13 files changed, 385 insertions(+), 82 deletions(-)
-- 
2.13.6
