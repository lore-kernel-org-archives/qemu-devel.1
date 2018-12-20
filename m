Received: from eggs.gnu.org ([2001:4830:134:3::10]:60152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gZr4j-0003UG-JM
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 00:40:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gZr4g-0005hn-Db
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 00:40:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gZr4g-0005gm-7l
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 00:40:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 566C3356E5
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 05:40:45 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 20 Dec 2018 13:40:34 +0800
Message-Id: <20181220054037.24320-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] q35: change defaults for kernel irqchip
 and IR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

v2:
- drop patch 1, so we don't even need to consider old kernels for the
  default value [Paolo, Eduardo]
- fix up commit message of the split irqchip patch to mention that

============= Original cover letter ================

This only changes q35.  Nothing else.

Before this series, we have these default parameters:

  - machine kernel-irqchip: on
  - intel-iommu IR: off

This series wants to change these default variables into:

  - machine kernel-irqchip: split
  - intel-iommu IR: on

and at the meantime we should keep compatibility with old kernels and
old versions of QEMU.

For old versions of QEMU: we used machine compat properties.

For old kernels (<4.4): if user didn't specify split kernel irqchip,
we'll take it only as the first priority if it's supported by the
kernel; otherwise, we will continue with complete kernel irqchip.

Both of these parameters should be good to have (split irqchip gains
more security, while IR gets it too but even more, like x2apic).  So
let's try to make them as default if capable.

Tests ("split" stands for whether kernel split irqchip enabled, "IR"
stands for whether IR is turned on):

   |--------------------------------------------------------+-------+----|
   | params                                                 | split | IR |
   |--------------------------------------------------------+-------+----|
   | -M q35                                                 |     0 | /  |
   | -M q35,accel=kvm                                       |     1 | /  |
   | -M pc-q35-3.1,accel=kvm                                |     0 | /  |
   | -M q35,accel=kvm,kernel-irqchip=off                    |     0 | /  |
   | -M q35,accel=kvm,kernel-irqchip=on                     |     0 | /  |
   | -M q35 -device intel-iommu                             |     0 | 1  |
   | -M q35,accel=kvm -device intel-iommu                   |     1 | 1  |
   | -M q35,accel=kvm,kernel-irqchip=on -device intel-iommu |     0 | 0  |
   |--------------------------------------------------------+-------+----|

I didn't try old kernels, though.

Any comment would be welcomed, thanks.

Peter Xu (3):
  q35: set split kernel irqchip as default
  x86-iommu: switch intr_supported to OnOffAuto type
  x86-iommu: turn on IR by default if proper

 hw/core/machine.c           |  2 ++
 hw/i386/acpi-build.c        |  6 +++---
 hw/i386/amd_iommu.c         |  2 +-
 hw/i386/intel_iommu.c       |  6 +++---
 hw/i386/pc.c                |  2 +-
 hw/i386/pc_q35.c            |  2 ++
 hw/i386/x86-iommu.c         | 18 +++++++++++++++---
 include/hw/boards.h         |  1 +
 include/hw/i386/x86-iommu.h |  4 +++-
 9 files changed, 31 insertions(+), 12 deletions(-)

-- 
2.17.1
