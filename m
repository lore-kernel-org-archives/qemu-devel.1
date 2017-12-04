Received: from eggs.gnu.org ([2001:4830:134:3::10]:60047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLqHD-00067y-JU
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:55:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLqH7-00008x-Rb
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:55:15 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon,  4 Dec 2017 13:55:00 +0100
Message-Id: <20171204125505.29203-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.12 0/5] s390x/tcg: CCW hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

Hotplugging a ccw device currently fails due to different reasons.

1. The stored machine check information is partially wrong.
2. The TOD programmable field cannot be restored.
3. STCRW cannot get executed.

With these patches, I am able to sucessfully hotplug e.g. virtio-rng by
issuing "device_add virtio-rng-ccw,id=rng0" to a Linux guest.

David Hildenbrand (5):
  s390x/kvm: factor out build_channel_report_mcic() into cpu.h
  s390x/tcg: fix and cleanup mcck injection
  s390x/tcg: implement SET CLOCK PROGRAMMABLE FIELD
  s390x/tcg: indicate value of TODPR in STCKE
  s390x/tcg: wire up STORE CHANNEL REPORT WORD

 target/s390x/cpu.h         | 20 ++++++++++++++++++++
 target/s390x/excp_helper.c | 18 ++++++++----------
 target/s390x/helper.h      |  2 ++
 target/s390x/insn-data.def |  3 +++
 target/s390x/internal.h    |  6 +++---
 target/s390x/kvm.c         | 25 ++-----------------------
 target/s390x/misc_helper.c | 20 ++++++++++++++++++++
 target/s390x/translate.c   | 20 ++++++++++++++++++++
 8 files changed, 78 insertions(+), 36 deletions(-)

-- 
2.14.3
