Received: from eggs.gnu.org ([2001:4830:134:3::10]:38937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNL6O-0001nh-6c
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:02:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNL6L-0005JE-5k
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:02:16 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  8 Dec 2017 17:01:53 +0100
Message-Id: <20171208160207.26494-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.12 00/14] s390x/tcg: CCW hotplug,
 facilities, instructions
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

Both series in one piece as (most probably) most reviewing is done.

Wire up some io instructions and implement new facilitites. Make sure
to take care of MTTCG when it comes to atomic operations. Make CCW
hotplug work.

As we are now able to install/boot a Fedora 26/27 as well as an upstream
kernel compiled for z12, let's bump up the QEMU cpu model to a very
stripped down version of a z12 (with missing base features). Take care
of backwards compatibility (as we defined the QEMU model as
migration-safe).

Avilable at: https://github.com/davidhildenbrand/qemu.git s390x-queue

v2 -> v3:
- squashed the ASI/ASGI and ALSI/ALSGI patches.
 - Both now emulate old behavior.
- "s390x/tcg: implement Interlocked-Access Facility 2"
 - now also emulates old behavior.
- "s390x/tcg: implement SET CLOCK PROGRAMMABLE FIELD"
 - now forwards r1 into the helper.
- "s390x/tcg: implement extract-CPU-time facility"
 - takes care of user-only
- "s390x: change the QEMU cpu model to a stripped down z12"
  - const -> static const for two feature bitmaps


David Hildenbrand (14):
  s390x/kvm: factor out build_channel_report_mcic() into cpu.h
  s390x/tcg: fix and cleanup mcck injection
  s390x/tcg: implement SET CLOCK PROGRAMMABLE FIELD
  s390x/tcg: indicate value of TODPR in STCKE
  s390x/tcg: wire up STORE CHANNEL REPORT WORD
  s390x/tcg: ASI/ASGI/ALSI/ALSGI are atomic with Interlocked-acccess
    facility 1
  s390x/tcg: implement Interlocked-Access Facility 2
  s390x/tcg: wire up SET ADDRESS LIMIT
  s390x/tcg: wire up SET CHANNEL MONITOR
  s390x/tcg: Implement STORE CHANNEL PATH STATUS
  s390x/tcg: Implement SIGNAL ADAPTER instruction
  s390x/tcg: implement extract-CPU-time facility
  s390x/tcg: we already implement the Set-Program-Parameter facility
  s390x: change the QEMU cpu model to a stripped down z12

 hw/s390x/s390-virtio-ccw.c  |   8 +++
 target/s390x/cpu.h          |  26 +++++++
 target/s390x/cpu_models.c   |  97 +++++++++++---------------
 target/s390x/cpu_models.h   |   1 +
 target/s390x/excp_helper.c  |  12 ++--
 target/s390x/gen-features.c |  87 +++++++++++++++++++++++
 target/s390x/helper.h       |   6 +-
 target/s390x/insn-data.def  |  29 +++++---
 target/s390x/internal.h     |   6 +-
 target/s390x/kvm.c          |  25 +------
 target/s390x/misc_helper.c  |  59 ++++++++++++++--
 target/s390x/translate.c    | 164 ++++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 415 insertions(+), 105 deletions(-)

-- 
2.14.3
