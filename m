Received: from eggs.gnu.org ([2001:4830:134:3::10]:41224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMy9S-00005m-TV
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMy9L-000289-G6
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:31:50 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Dec 2017 16:31:36 +0100
Message-Id: <20171207153141.15523-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.12 0/5] s390x/tcg: CCW hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Hotplugging a ccw device currently fails due to different reasons.

1. The stored machine check information is partially wrong.
2. The TOD programmable field cannot be restored.
3. STCRW cannot get executed.

With these patches, I am able to sucessfully hotplug e.g. virtio-rng by
issuing "device_add virtio-rng-ccw,id=rng0" to a Linux guest. Unplug
also seems to work.

v1 -> v2:
- avoid accessing unmapped lowcore
- minor style issues, more/better comments and description fixes

David Hildenbrand (5):
  s390x/kvm: factor out build_channel_report_mcic() into cpu.h
  s390x/tcg: fix and cleanup mcck injection
  s390x/tcg: implement SET CLOCK PROGRAMMABLE FIELD
  s390x/tcg: indicate value of TODPR in STCKE
  s390x/tcg: wire up STORE CHANNEL REPORT WORD

 target/s390x/cpu.h         | 22 ++++++++++++++++++++++
 target/s390x/excp_helper.c | 12 ++++++------
 target/s390x/helper.h      |  2 ++
 target/s390x/insn-data.def |  3 +++
 target/s390x/internal.h    |  6 +++---
 target/s390x/kvm.c         | 25 ++-----------------------
 target/s390x/misc_helper.c | 20 ++++++++++++++++++++
 target/s390x/translate.c   | 20 ++++++++++++++++++++
 8 files changed, 78 insertions(+), 32 deletions(-)

-- 
2.14.3
