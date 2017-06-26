Received: from eggs.gnu.org ([2001:4830:134:3::10]:35287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPMUO-0004VL-Ak
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 01:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPMUJ-0005zB-9n
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 01:23:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPMUJ-0005wL-3K
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 01:23:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0A7159
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 05:23:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 26 Jun 2017 07:22:51 +0200
Message-Id: <1498454578-18709-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/7] Poison some more target-specific defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This series marks some more #defines as poisoned, which are
target-specific (declared in config-target.h) and thus must
not be used in common code.

v4:
- Rebased to master since the v2 versions of the first two patches
  have already been merged. The diff between v2 and v3 can now be
  found in the first patch of this series.

v3:
- Mark some more TARGET_xxx and CONFIG_xxx defines as poisoned in
  the first two patches (as requested by Richard)
- Added the final patch to move the edu device to common-obj-y

v2:
- First two patches are the same as in v1
- Reworked the CONFIG_KVM patches according to Paolo's review feedback
- Added two new patches to finally poison CONFIG_SOFTMMU, too
- Added a final patch to move bootdevice.o to common-obj now
  (based on an earlier patch where I also tried to move numa.o and
  balloon.o, too - but these files are indirectly target-dependent as
  I now know, so they can't be moved)

Thomas Huth (7):
  include/exec/poison: Add some more missing TARGET and CONFIG defines
  Move CONFIG_KVM related definitions to kvm_i386.h
  include/exec/poison: Mark CONFIG_KVM as poisoned, too
  cpu: Introduce a wrapper for tlb_flush() that can be used in common
    code
  include/exec/poison: Mark CONFIG_SOFTMMU as poisoned
  Makefile: Move bootdevice.o to common-obj-y
  hw/misc/edu: Compile the edu device as common object

 Makefile.objs             |  2 +-
 Makefile.target           |  2 +-
 accel/tcg/translate-all.c |  8 ++++++++
 bootdevice.c              |  2 +-
 hw/acpi/ich9.c            |  1 -
 hw/i386/pc_q35.c          |  1 +
 hw/misc/Makefile.objs     |  2 +-
 include/exec/cpu-common.h |  2 ++
 include/exec/poison.h     |  8 ++++++++
 include/hw/i386/pc.h      | 13 -------------
 include/qom/cpu.h         |  8 ++++++++
 include/sysemu/kvm.h      | 31 ++++++++++++-------------------
 qom/cpu.c                 |  5 ++---
 target/i386/kvm_i386.h    | 23 +++++++++++++++++++++++
 14 files changed, 68 insertions(+), 40 deletions(-)

-- 
1.8.3.1
