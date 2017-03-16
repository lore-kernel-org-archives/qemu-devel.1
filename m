Received: from eggs.gnu.org ([2001:4830:134:3::10]:46573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1coJYS-0002zQ-I6
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1coJYR-0004Vj-IV
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:46:12 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 15 Mar 2017 20:46:00 -0400
Message-Id: <20170316004603.20609-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC patch 0/3] block: pause block jobs for
 bdrv_drain_begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

Reference: https://bugzilla.redhat.com/show_bug.cgi?id=1367369#c8

It's possible to wedge QEMU if the guest tries to reset a virtio-pci
device as QEMU is also using the drive for a blockjob. This patchset
aims to allow us to safely pause/resume jobs attached to individual
nodes in a manner similar to how bdrv_drain_all_begin/end do.

Kevin suggested a DevOps approach which I've approximated here, but
I've got a number of questions before I push the point any further.

John Snow (3):
  blockjob: add block_job_start_shim
  block-backend: add drained_begin / drained_end ops
  blockjob: add devops to blockjob backends

 block/block-backend.c          | 25 ++++++++++++++++++
 blockjob.c                     | 60 +++++++++++++++++++++++++++++++++---------
 include/sysemu/block-backend.h |  8 ++++++
 3 files changed, 81 insertions(+), 12 deletions(-)

-- 
2.9.3
