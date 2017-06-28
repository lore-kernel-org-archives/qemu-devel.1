Received: from eggs.gnu.org ([2001:4830:134:3::10]:49932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBBo-0002sf-U0
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQBBg-0004Nx-M5
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQBBg-0004MW-Bf
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:31:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACD59C0587F6
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 11:31:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 28 Jun 2017 13:30:52 +0200
Message-Id: <20170628113106.5248-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 00/14] Migration pull request for 20170628
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

This is the migration pull request, it includes:
- return path capability (peter)
- objectify migration (peter)
  Thanks to all the people who helped debug the QOM/QAPI.
- fix access to ramblocks (Haozhong)
- add error hint to VMSTATE*EQUAL macros (halil)
  Fixed by hand the cases that didn't compile (me)

Please, apply.

The following changes since commit 577caa2672ccde7352fda3ef17e44993de862f0e:

  Merge remote-tracking branch 'remotes/edgar/tags/edgar/mmio-exec-v2.for-upstream' into staging (2017-06-27 16:56:55 +0100)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20170628

for you to fetch changes up to 084140bd4989095d39978269fd0f43e398a0015d:

  exec: fix access to ram_list.dirty_memory when sync dirty bitmap (2017-06-28 12:23:58 +0200)

----------------------------------------------------------------
migration/next for 20170628

----------------------------------------------------------------
Halil Pasic (1):
      vmstate: error hint for failed equal checks

Haozhong Zhang (1):
      exec: fix access to ram_list.dirty_memory when sync dirty bitmap

Peter Xu (12):
      machine: export register_compat_prop()
      accel: introduce AccelClass.global_props
      vl: clean up global property registration
      migration: let MigrationState be a qdev
      migration: move global_state.optional out
      migration: move only_migratable to MigrationState
      migration: move skip_configuration out
      migration: move skip_section_footers
      migration: merge enforce_config_section somewhat
      migration: hmp: dump globals
      migration: add comment for TYPE_MIGRATE
      migration: add "return-path" capability

 accel/accel.c                    |   6 ++
 hmp.c                            |   3 +
 hw/block/fdc.c                   |   2 +-
 hw/core/machine.c                |  13 ----
 hw/core/qdev-properties.c        |  21 ++++++
 hw/display/qxl.c                 |   4 +-
 hw/display/vga.c                 |   2 +-
 hw/display/virtio-gpu.c          |   2 +-
 hw/display/vmware_vga.c          |   2 +-
 hw/i386/pc_piix.c                |   3 -
 hw/ide/ahci.c                    |   2 +-
 hw/input/vmmouse.c               |   2 +-
 hw/intc/openpic.c                |   2 +-
 hw/intc/xics.c                   |   2 +-
 hw/misc/max111x.c                |   2 +-
 hw/nvram/eeprom93xx.c            |   2 +-
 hw/pci/pci.c                     |   2 +-
 hw/pci/pcie_aer.c                |   2 +-
 hw/ppc/spapr.c                   |   3 -
 hw/ppc/spapr_iommu.c             |   2 +-
 hw/ppc/spapr_pci.c               |   4 +-
 hw/ppc/spapr_vio.c               |   4 +-
 hw/usb/hcd-uhci.c                |   2 +-
 hw/xen/xen-common.c              |  25 +++++--
 include/exec/ram_addr.h          |   9 ++-
 include/hw/compat.h              |  12 ++++
 include/hw/qdev-properties.h     |  29 ++++++++
 include/migration/global_state.h |   1 -
 include/migration/misc.h         |   6 +-
 include/migration/vmstate.h      |  51 +++++++++-----
 include/sysemu/accel.h           |  11 +++
 include/sysemu/sysemu.h          |   1 -
 migration/global_state.c         |   9 +--
 migration/migration.c            | 142 ++++++++++++++++++++++++++++++++-------
 migration/migration.h            |  34 ++++++++++
 migration/savevm.c               |  32 ++-------
 migration/vmstate-types.c        |  15 +++++
 qapi-schema.json                 |   5 +-
 target/ppc/machine.c             |   8 +--
 vl.c                             |  41 +++++++++--
 40 files changed, 383 insertions(+), 137 deletions(-)
