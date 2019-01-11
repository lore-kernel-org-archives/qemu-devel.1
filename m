Received: from eggs.gnu.org ([209.51.188.92]:38159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1ghyrW-0000eX-GU
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1ghyrV-0003oD-0W
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:36:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:56401)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ghyrS-0003df-HR
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:36:43 -0500
From: Tao Xu <tao3.xu@intel.com>
Date: Fri, 11 Jan 2019 23:34:42 +0800
Message-Id: <20190111153451.14304-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH v2 0/9] Build ACPI Heterogeneous Memory
 Attribute Table (HMAT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, imammedo@redhat.com
Cc: marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, jingqi.liu@intel.com, danmei.wei@intel.com, tao3.xu@intel.com, qemu-devel@nongnu.org

This series of patches will build Heterogeneous Memory Attribute Table (HMAT)
according to the command line. The ACPI HMAT describes the memory attributes,
such as memory side cache attributes and bandwidth and latency details,
related to the System Physical Address (SPA) Memory Ranges.
The software is expected to use this information as hint for optimization.

OSPM evaluates HMAT only during system initialization. Any changes to the HMAT
state at runtime or information regarding HMAT for hot plug are communicated
using the _HMA method.

>From 1 to 6 patches are the former V1 patches. From 7 to 9 patches are the
updates per Igor and Eric's comments.

The V1 RESEND patches link:
http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg05368.html
The V1 patches link:
http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg01927.html

Changelog:
v2:
  Per Igor and Eric's comments, fix some coding style and small issues:
    - update the version number in qapi/misc.json
    - including the expansion of the acronym HMAT in qapi/misc.json
    - correct spell mistakes in qapi/misc.json and qemu-options.hx
    - fix the comment syle in hw/i386/acpi-build.c
    and hw/acpi/hmat.h
   - remove some unnecessary head files in hw/acpi/hmat.c
   - use hardcoded numbers from spec to generate
   Memory Subsystem Address Range Structure in hw/acpi/hmat.c
   - drop the struct AcpiHmat and AcpiHmatSpaRange
    in hw/acpi/hmat.h
  Per Igor's comment, rewrite NFIT code to build _HMA method.

Liu Jingqi (6):
  hmat acpi: Build Memory Subsystem Address Range Structure(s) in ACPI
    HMAT
  hmat acpi: Build System Locality Latency and Bandwidth Information
    Structure(s) in ACPI HMAT
  hmat acpi: Build Memory Side Cache Information Structure(s) in ACPI
    HMAT
  Extend the command-line to provide memory latency and bandwidth
    information
  numa: Extend the command-line to provide memory side cache information
  hmat acpi: Implement _HMA method to update HMAT at runtime

Tao Xu (3):
  hmat acpi: fix some coding style and small issues
  hmat acpi: move some function inside of the caller
  acpi: rewrite the _FIT method to use it in _HMA method

 default-configs/i386-softmmu.mak |   1 +
 hw/acpi/Makefile.objs            |   1 +
 hw/acpi/hmat.c                   | 424 +++++++++++++++++++++++++++++++
 hw/acpi/hmat.h                   | 244 ++++++++++++++++++
 hw/acpi/nvdimm.c                 | 389 ++++++++++++++++++----------
 hw/i386/acpi-build.c             | 125 +++++----
 hw/i386/acpi-build.h             |  10 +
 hw/i386/pc.c                     |   2 +
 hw/i386/pc_piix.c                |   3 +
 hw/i386/pc_q35.c                 |   3 +
 include/hw/i386/pc.h             |   2 +
 include/hw/mem/nvdimm.h          |  11 +
 include/sysemu/numa.h            |   2 +
 numa.c                           | 202 +++++++++++++++
 qapi/misc.json                   | 162 +++++++++++-
 qemu-options.hx                  |  28 +-
 16 files changed, 1426 insertions(+), 183 deletions(-)
 create mode 100644 hw/acpi/hmat.c
 create mode 100644 hw/acpi/hmat.h

-- 
2.17.1
