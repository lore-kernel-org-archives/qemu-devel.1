Received: from eggs.gnu.org ([2001:4830:134:3::10]:55773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8828e3297=Paul.Durrant@citrix.com>)
	id 1gYsyW-0003Ei-Oi
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8828e3297=Paul.Durrant@citrix.com>)
	id 1gYsyQ-0005Vo-7V
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:30:22 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Mon, 17 Dec 2018 13:29:53 +0000
Message-ID: <20181217133011.31433-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 00/18] Xen PV backend 'qdevification'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Greg Kurz <groug@kaod.org>, Jason Wang <jasowang@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Tim Smith <tim.smith@citrix.com>

This series introduces a new QOM compliant framework for Xen PV backends.
This is achieved by first moving the current non-compliant framework aside,
before building up a new framework incrementally.

This series was prompted by a thread [1] started by Kevin Wolf in response
to patches against xen_disk.c posted by Tim Smith. Therefore, alongside
the patches introducing the new framework, other patches build up a QOM
compliant replacement for 'xen_disk', called 'xen-qdisk'. Patch #16 swaps
this new device into place (having establisheda mechanism to auto-
instantiate devices that is compliant with existing Xen toolstacks in
patch #15) and patch #18 then removes the old xen_disk code.

Subsequent series will port other Xen PV backends across to the new
framework.

The series is also available as a repository branch [2] on xenbits.xen.org.

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg00259.html
[2] http://xenbits.xen.org/gitweb/?p=people/pauldu/qemu.git;a=shortlog;h=refs/heads/qom31

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
  xen: remove 'ioreq' struct/varable/field names from
    dataplane/xen-block.c
  xen: purge 'blk' and 'ioreq' from function names in
    dataplane/xen-block.c
  xen: add implementations of xen-block connect and disconnect
    functions...
  xen: add a mechanism to automatically create XenDevice-s...
  xen: automatically create XenBlockDevice-s
  MAINTAINERS: add myself as a Xen maintainer
  xen: remove the legacy 'xen_disk' backend

 MAINTAINERS                                   |    5 +-
 hw/9pfs/xen-9p-backend.c                      |   16 +-
 hw/block/Makefile.objs                        |    2 +-
 hw/block/dataplane/Makefile.objs              |    1 +
 hw/block/dataplane/xen-block.c                |  808 +++++++++++
 hw/block/dataplane/xen-block.h                |   29 +
 hw/block/trace-events                         |   14 +
 hw/block/xen-block.c                          | 1007 ++++++++++++++
 hw/block/xen_disk.c                           | 1011 --------------
 hw/char/xen_console.c                         |   12 +-
 hw/display/xenfb.c                            |   25 +-
 hw/i386/xen/xen-hvm.c                         |    5 +-
 hw/i386/xen/xen-mapcache.c                    |    2 +-
 hw/i386/xen/xen_platform.c                    |    2 +-
 hw/net/xen_nic.c                              |   14 +-
 hw/usb/xen-usb.c                              |   25 +-
 hw/xen/Makefile.objs                          |    2 +-
 hw/xen/trace-events                           |   26 +
 hw/xen/xen-backend.c                          |  165 +++
 hw/xen/xen-bus-helper.c                       |  184 +++
 hw/xen/xen-bus.c                              | 1197 +++++++++++++++++
 hw/xen/xen-common.c                           |    2 +-
 .../{xen_backend.c => xen-legacy-backend.c}   |   80 +-
 hw/xen/xen_devconfig.c                        |    2 +-
 hw/xen/xen_pt.c                               |    2 +-
 hw/xen/xen_pt_config_init.c                   |    2 +-
 hw/xen/xen_pt_graphics.c                      |    2 +-
 hw/xen/xen_pt_msi.c                           |    2 +-
 hw/xen/xen_pvdev.c                            |   20 +-
 hw/xenpv/xen_domainbuild.c                    |    2 +-
 hw/xenpv/xen_machine_pv.c                     |    5 +-
 include/hw/xen/xen-backend.h                  |   39 +
 include/hw/xen/xen-block.h                    |   95 ++
 include/hw/xen/xen-bus-helper.h               |   45 +
 include/hw/xen/xen-bus.h                      |  138 ++
 .../{xen_backend.h => xen-legacy-backend.h}   |   43 +-
 include/hw/xen/xen_pvdev.h                    |   38 +-
 include/qemu/module.h                         |    3 +
 38 files changed, 3919 insertions(+), 1153 deletions(-)
 create mode 100644 hw/block/dataplane/xen-block.c
 create mode 100644 hw/block/dataplane/xen-block.h
 create mode 100644 hw/block/xen-block.c
 delete mode 100644 hw/block/xen_disk.c
 create mode 100644 hw/xen/xen-backend.c
 create mode 100644 hw/xen/xen-bus-helper.c
 create mode 100644 hw/xen/xen-bus.c
 rename hw/xen/{xen_backend.c => xen-legacy-backend.c} (89%)
 create mode 100644 include/hw/xen/xen-backend.h
 create mode 100644 include/hw/xen/xen-block.h
 create mode 100644 include/hw/xen/xen-bus-helper.h
 create mode 100644 include/hw/xen/xen-bus.h
 rename include/hw/xen/{xen_backend.h => xen-legacy-backend.h} (61%)
---
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Tim Smith <tim.smith@citrix.com>

v6:
 - Fix boilerplate in patch #9 again
 - Move to newer version of git

v5:
 - Re-worked backend auto-creation

v4:
 - Add missing boilerplate fix

v3:
 - Various fixes, including unplug

v2:
 - Fix boilerplates of introduced files and leave existing ones alone

-- 
2.20.1.2.gb21ebb6
