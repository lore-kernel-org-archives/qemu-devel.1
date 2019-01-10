Received: from eggs.gnu.org ([209.51.188.92]:53238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=906201598=anthony.perard@citrix.com>)
	id 1ghaio-00057D-Pb
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=906201598=anthony.perard@citrix.com>)
	id 1ghaii-0001fZ-Mc
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:50:10 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:11318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=906201598=anthony.perard@citrix.com>)
	id 1ghaii-0001ep-Ee
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:50:04 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Thu, 10 Jan 2019 13:48:52 +0000
Message-ID: <20190110134917.16425-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/25] xen queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Anthony PERARD <anthony.perard@citrix.com>

The following changes since commit 8ae951fbc1068308313b2c57a4fc3c68451641f4:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20190109' into staging (2019-01-09 16:08:31 +0000)

are available in the Git repository at:

  https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20190110

for you to fetch changes up to 24edb91f5009fa941e1294aaf4bb2103d9ad077e:

  xen-block: avoid repeated memory allocation (2019-01-10 11:25:17 +0000)

----------------------------------------------------------------
xen queue

* Xen PV backend 'qdevification'.
  Starting with xen_disk.
* Performance improvements for xen-block.
* Remove of the Xen PV domain builder.
* bug fixes.

----------------------------------------------------------------
Anthony PERARD (2):
      Remove broken Xen PV domain builder
      xen: Replace few mentions of xend by libxl

Paul Durrant (18):
      xen: re-name XenDevice to XenLegacyDevice...
      xen: introduce new 'XenBus' and 'XenDevice' object hierarchy
      xen: introduce 'xen-block', 'xen-disk' and 'xen-cdrom'
      xen: create xenstore areas for XenDevice-s
      xen: add xenstore watcher infrastructure
      xen: add grant table interface for XenDevice-s
      xen: add event channel interface for XenDevice-s
      xen: duplicate xen_disk.c as basis of dataplane/xen-block.c
      xen: remove unnecessary code from dataplane/xen-block.c
      xen: add header and build dataplane/xen-block.c
      xen: remove 'XenBlkDev' and 'blkdev' names from dataplane/xen-block
      xen: remove 'ioreq' struct/varable/field names from dataplane/xen-block.c
      xen: purge 'blk' and 'ioreq' from function names in dataplane/xen-block.c
      xen: add implementations of xen-block connect and disconnect functions...
      xen: add a mechanism to automatically create XenDevice-s...
      xen: automatically create XenBlockDevice-s
      MAINTAINERS: add myself as a Xen maintainer
      xen: remove the legacy 'xen_disk' backend

Peter Maydell (1):
      hw/xen/xen_pt_graphics: Don't trust the BIOS ROM contents so much

Tim Smith (3):
      xen-block: improve batching behaviour
      xen-block: improve response latency
      xen-block: avoid repeated memory allocation

Zhao Yan (1):
      xen/pt: allow passthrough of devices with bogus interrupt pin

 MAINTAINERS                                        |    5 +-
 configure                                          |   17 -
 hw/9pfs/xen-9p-backend.c                           |   16 +-
 hw/block/Makefile.objs                             |    2 +-
 hw/block/dataplane/Makefile.objs                   |    1 +
 hw/block/dataplane/xen-block.c                     |  827 ++++++++++++++
 hw/block/dataplane/xen-block.h                     |   29 +
 hw/block/trace-events                              |   14 +
 hw/block/xen-block.c                               |  963 ++++++++++++++++
 hw/block/xen_disk.c                                | 1011 -----------------
 hw/char/xen_console.c                              |   12 +-
 hw/display/xenfb.c                                 |   25 +-
 hw/i386/xen/xen-hvm.c                              |    5 +-
 hw/i386/xen/xen-mapcache.c                         |    2 +-
 hw/i386/xen/xen_platform.c                         |    2 +-
 hw/net/xen_nic.c                                   |   14 +-
 hw/usb/xen-usb.c                                   |   25 +-
 hw/xen/Makefile.objs                               |    2 +-
 hw/xen/trace-events                                |   26 +
 hw/xen/xen-backend.c                               |  165 +++
 hw/xen/xen-bus-helper.c                            |  184 +++
 hw/xen/xen-bus.c                                   | 1197 ++++++++++++++++++++
 hw/xen/xen-common.c                                |    2 +-
 hw/xen/{xen_backend.c => xen-legacy-backend.c}     |   80 +-
 hw/xen/xen_devconfig.c                             |    2 +-
 hw/xen/xen_pt.c                                    |    8 +-
 hw/xen/xen_pt_config_init.c                        |    6 +-
 hw/xen/xen_pt_graphics.c                           |   18 +-
 hw/xen/xen_pt_msi.c                                |    2 +-
 hw/xen/xen_pvdev.c                                 |   20 +-
 hw/xenpv/Makefile.objs                             |    2 -
 hw/xenpv/xen_domainbuild.c                         |  299 -----
 hw/xenpv/xen_domainbuild.h                         |   13 -
 hw/xenpv/xen_machine_pv.c                          |   21 +-
 include/hw/xen/xen-backend.h                       |   39 +
 include/hw/xen/xen-block.h                         |   94 ++
 include/hw/xen/xen-bus-helper.h                    |   45 +
 include/hw/xen/xen-bus.h                           |  138 +++
 .../hw/xen/{xen_backend.h => xen-legacy-backend.h} |   43 +-
 include/hw/xen/xen.h                               |    3 +-
 include/hw/xen/xen_common.h                        |   18 -
 include/hw/xen/xen_pvdev.h                         |   38 +-
 include/qemu/module.h                              |    3 +
 qemu-options.hx                                    |   12 +-
 vl.c                                               |    7 -
 45 files changed, 3921 insertions(+), 1536 deletions(-)
 create mode 100644 hw/block/dataplane/xen-block.c
 create mode 100644 hw/block/dataplane/xen-block.h
 create mode 100644 hw/block/xen-block.c
 delete mode 100644 hw/block/xen_disk.c
 create mode 100644 hw/xen/xen-backend.c
 create mode 100644 hw/xen/xen-bus-helper.c
 create mode 100644 hw/xen/xen-bus.c
 rename hw/xen/{xen_backend.c => xen-legacy-backend.c} (89%)
 delete mode 100644 hw/xenpv/xen_domainbuild.c
 delete mode 100644 hw/xenpv/xen_domainbuild.h
 create mode 100644 include/hw/xen/xen-backend.h
 create mode 100644 include/hw/xen/xen-block.h
 create mode 100644 include/hw/xen/xen-bus-helper.h
 create mode 100644 include/hw/xen/xen-bus.h
 rename include/hw/xen/{xen_backend.h => xen-legacy-backend.h} (61%)
