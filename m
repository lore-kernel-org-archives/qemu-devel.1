Received: from eggs.gnu.org ([2001:4830:134:3::10]:41267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNd-0005AK-IX
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNZ-0005mY-Vb
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNZ-0005gF-Gl
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3366D7F40B
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CEBA212A6C
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:26 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:30:54 +0200
Message-Id: <20181008173125.19678-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/31] Replace some unwise uses of
 error_report() & friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Calling error_report() or similar in a function that takes an Error **
argument is suspicious.  Fux a number of instances that are actually
wrong.  Clean up a few more that are merely fragile / bad examples.

Markus Armbruster (31):
  Use error_fatal to simplify obvious fatal errors (again)
  block: Use warn_report() & friends to report warnings
  cpus hw target: Use warn_report() & friends to report warnings
  vfio: Use warn_report() & friends to report warnings
  vfio: Clean up error reporting after previous commit
  char: Use error_printf() to print help and such
  9pfs: Fix CLI parsing crash on error
  pc: Fix machine property nvdimm-persistence error handling
  ioapic: Fix error handling in realize()
  smbios: Clean up error handling in smbios_add()
  migration: Fix !replay_can_snapshot() error handling
  l2tpv3: Improve -netdev/netdev_add/-net/... error reporting
  net/socket: Fix invalid socket type error handling
  numa: Fix QMP command set-numa-node error handling
  xen/pt: Fix incomplete conversion to realize()
  seccomp: Clean up error reporting in parse_sandbox()
  vl: Clean up error reporting in parse_add_fd()
  qom: Clean up error reporting in user_creatable_add_opts_foreach()
  vl: Clean up error reporting in parse_add_fd()
  vl: Clean up error reporting in machine_set_property()
  vl: Clean up error reporting in mon_init_func()
  vl: Clean up error reporting in parse_fw_cfg()
  vl: Clean up error reporting in device_init_func()
  vl: Clean up error reporting in vnc_init_func()
  numa: Clean up error reporting in parse_numa()
  tpm: Clean up error reporting in tpm_init_tpmdev()
  spice: Clean up error reporting in add_channel()
  fsdev: Clean up error reporting in qemu_fsdev_add()
  vl: Assert drive_new() does not fail in default_drive()
  blockdev: Convert drive_new() to Error
  vl: Simplify call of parse_name()

 block/bochs.c                            |   8 +-
 block/cloop.c                            |   8 +-
 block/dmg.c                              |   8 +-
 block/iscsi.c                            |   2 +-
 block/rbd.c                              |  12 +-
 block/sheepdog.c                         |   2 +-
 block/vvfat.c                            |   8 +-
 blockdev.c                               |  27 ++---
 chardev/char-pty.c                       |   2 +-
 chardev/char.c                           |   2 +-
 cpus.c                                   |   8 +-
 device-hotplug.c                         |   5 +-
 fsdev/qemu-fsdev-dummy.c                 |   2 +-
 fsdev/qemu-fsdev.c                       |  12 +-
 fsdev/qemu-fsdev.h                       |   2 +-
 hw/9pfs/9p-handle.c                      |   6 +-
 hw/9pfs/xen-9p-backend.c                 |   7 +-
 hw/display/cg3.c                         |   2 +-
 hw/display/tcx.c                         |   2 +-
 hw/i386/pc.c                             |   5 +-
 hw/intc/ioapic.c                         |   8 +-
 hw/intc/xics_kvm.c                       |   7 +-
 hw/misc/ivshmem.c                        |   4 +-
 hw/net/virtio-net.c                      |   8 +-
 hw/smbios/smbios.c                       |  90 ++++++++++-----
 hw/vfio/pci-quirks.c                     |   4 +-
 hw/vfio/pci.c                            |  22 ++--
 hw/vfio/platform.c                       |   6 +-
 hw/virtio/virtio-pci.c                   |   4 +-
 hw/xen/xen_pt.c                          |   2 +-
 include/hw/vfio/vfio-common.h            |   3 +-
 include/sysemu/blockdev.h                |   3 +-
 include/sysemu/numa.h                    |   1 -
 include/sysemu/tpm.h                     |   2 +-
 migration/savevm.c                       |   8 +-
 net/l2tpv3.c                             |  26 ++---
 net/socket.c                             |   4 +-
 numa.c                                   |  21 ++--
 qemu-io.c                                |   8 +-
 qemu-nbd.c                               |  14 +--
 qemu-seccomp.c                           |  18 +--
 qom/object_interfaces.c                  |   4 +-
 scripts/coccinelle/use-error_fatal.cocci |  20 ++++
 stubs/tpm.c                              |   3 +-
 target/i386/cpu.c                        |  17 +--
 target/ppc/translate_init.inc.c          |   4 +-
 tpm.c                                    |  22 ++--
 ui/spice-core.c                          |  13 ++-
 ui/vnc.c                                 |   5 +-
 vl.c                                     | 140 +++++++++--------------
 50 files changed, 317 insertions(+), 304 deletions(-)
 create mode 100644 scripts/coccinelle/use-error_fatal.cocci

--=20
2.17.1
