Received: from eggs.gnu.org ([2001:4830:134:3::10]:53889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cLxJX-0004zq-AY
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cLxJU-0006ki-7D
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:21:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cLxJU-0006kR-11
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:21:32 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 27 Dec 2016 17:21:16 -0200
Message-Id: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Allow migration with invtsc if there's no
 frequency mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>

This series makes QEMU accept migration with invtsc if:

a) The destination host has a matching TSC frequency; or
b) The destination host has TSC scaling available.

There are two cases where we can ensure the above conditions.
This series implements both:

1) tsc-khz explicitly set on the configuration. This case is
   trivial because the current code already refuses to start if
   there's a TSC frequency mismatch and tsc-khz is explicitly
   configured. (Implemented by patch 2/4)

2) A newer machine-type is being used. This means we know that
   the migration destination is running a QEMU version that will
   check for (a) and (b) on migration even if tsc-khz is not set
   explicitly. (Implemented by patch 4/4)

Eduardo Habkost (4):
  kvm: Simplify invtsc check
  kvm: Allow invtsc migration if tsc-khz is set explicitly
  pc: Add 2.9 machine-types
  kvm: Allow migration with invtsc

 include/hw/i386/pc.h |  6 ++++++
 target/i386/cpu.h    |  1 +
 hw/i386/pc_piix.c    | 15 ++++++++++++---
 hw/i386/pc_q35.c     | 13 +++++++++++--
 target/i386/cpu.c    |  1 +
 target/i386/kvm.c    | 32 ++++++++++++++++++--------------
 6 files changed, 49 insertions(+), 19 deletions(-)

-- 
2.7.4
