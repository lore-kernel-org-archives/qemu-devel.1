Received: from eggs.gnu.org ([2001:4830:134:3::10]:53752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLsic-0002G2-Uu
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLsiZ-00084W-Pm
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:59:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17249)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dLsiZ-000849-Jb
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:59:23 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 16 Jun 2017 16:59:06 +0200
Message-Id: <1497625153-19812-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/7] Poison some more target-specific defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This series marks some more #defines as poisoned, which are
target-specific (declared in config-target.h) and thus must
not be used in common code.

v2:
 - First two patches are the same as in v1
 - Reworked the CONFIG_KVM patches according to Paolo's review feedback
 - Added two new patches to finally poison CONFIG_SOFTMMU, too
 - Added a final patch to move bootdevice.o to common-obj now
   (based on an earlier patch where I also tried to move numa.o and
   balloon.o, too - but these files are indirectly target-dependent as
   I now know, so they can't be moved)

Thomas Huth (7):
  include/exec/poison: Add missing TARGET defines
  include/exec/poison: Mark some CONFIG defines as poisoned, too
  Move CONFIG_KVM related definitions to kvm_i386.h
  include/exec/poison: Mark CONFIG_KVM as poisoned, too
  cpu: Introduce a wrapper for tlb_flush() that can be used in common
    code
  include/exec/poison: Mark CONFIG_SOFTMMU as poisoned
  Makefile: Move bootdevice.o to common-obj-y

 Makefile.objs             |  2 +-
 Makefile.target           |  2 +-
 bootdevice.c              |  2 +-
 hw/acpi/ich9.c            |  1 -
 hw/i386/pc_q35.c          |  1 +
 include/exec/cpu-common.h |  2 ++
 include/exec/poison.h     | 33 +++++++++++++++++++++++++++++++++
 include/hw/i386/pc.h      | 13 -------------
 include/qom/cpu.h         |  8 ++++++++
 include/sysemu/kvm.h      | 31 ++++++++++++-------------------
 qom/cpu.c                 |  5 ++---
 target/i386/kvm_i386.h    | 23 +++++++++++++++++++++++
 translate-all.c           |  8 ++++++++
 13 files changed, 92 insertions(+), 39 deletions(-)

-- 
1.8.3.1
