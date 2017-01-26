Received: from eggs.gnu.org ([2001:4830:134:3::10]:34473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWlxr-0006Ve-2g
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWlxn-00025M-8K
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:27:55 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 26 Jan 2017 16:27:31 +0100
Message-Id: <1485444454-30749-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] hw: Deprecate unwanted use -drive if=scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Drives defined with if=scsi get connected to buses created with
-device, unlike other interface types.  Deprecate this usage.

There is no good default SCSI HBA for PC machines.  Deprecate if=scsi
there entirely.

Before this series, frontends for -drive if=scsi get created by SCSI
HBAs.  Frontends for other interface types get created by machine
initialization.

After this series, they get created by machine initialization, except
for deprecated cases, which get created by new function
scsi_legacy_handle_cmdline().

Based on "[PATCH v2 0/8] More sensible default for -drive interface
type".

Markus Armbruster (3):
  hw/scsi: Concentrate -drive if=scsi auto-create in one place
  hw: Deprecate -drive if=scsi with non-onboard HBAs
  hw/i386: Deprecate -drive if=scsi with PC machine types

 hw/arm/realview.c      |  2 +-
 hw/arm/versatilepb.c   |  2 +-
 hw/i386/pc.c           |  6 ++++++
 hw/scsi/esp-pci.c      |  3 ---
 hw/scsi/esp.c          |  6 ------
 hw/scsi/lsi53c895a.c   | 10 +++++++---
 hw/scsi/megasas.c      |  4 ----
 hw/scsi/mptsas.c       |  4 ----
 hw/scsi/scsi-bus.c     | 54 +++++++++++++++++++++++++++++++++++++++++++-------
 hw/scsi/spapr_vscsi.c  |  5 ++---
 hw/scsi/virtio-scsi.c  |  8 --------
 include/hw/pci/pci.h   |  2 ++
 include/hw/scsi/scsi.h |  3 ++-
 vl.c                   | 10 ++++++++++
 14 files changed, 78 insertions(+), 41 deletions(-)

-- 
2.7.4
