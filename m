Received: from eggs.gnu.org ([2001:4830:134:3::10]:54381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dedqj-0001Qk-L3
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dedqe-0007Dh-N0
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:57:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dedqe-0007Cp-GQ
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:57:16 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon,  7 Aug 2017 10:56:59 +0200
Message-Id: <20170807085703.32267-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] i386/kvm: advertise Hyper-V frequency
 MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, david@redhat.com, rkrcmar@redhat.com

This is the QEMU part of the changes required for nested Hyper-V to read
timestamps with RDTSC + TSC page. Without exposing the frequency MSRs,
Windows with the Hyper-V role enabled use the much slower
HV_X64_MSR_TIME_REF_COUNT (0x40000020) RDMSR to read timestamps.

The new registers are exposed only if the TSC frequency is stable across
migration and known, as suggested by Paolo.

v1->v2:
* deleted an extra empty line in patch 1
* added patch 3 introducing a helper function for the "TSC is stable and
  known" check (David)

Ladi Prosek (4):
  i386/kvm: use a switch statement for MSR detection
  i386/kvm: set tsc_khz before configuring Hyper-V CPUID
  i386/kvm: introduce tsc_is_stable_and_known()
  i386/kvm: advertise Hyper-V frequency MSRs

 target/i386/kvm.c | 138 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 71 insertions(+), 67 deletions(-)

-- 
2.9.3
