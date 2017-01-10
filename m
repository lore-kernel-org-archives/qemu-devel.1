Received: from eggs.gnu.org ([2001:4830:134:3::10]:47100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0Wy-00051c-3Z
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cR0Wu-0007fo-6b
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cR0Wt-0007fD-UI
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:48:16 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30FB23B713
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 17:48:15 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Jan 2017 18:47:50 +0100
Message-Id: <20170110174810.17748-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/20] chardev: qom-ify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

qemu-char.c is quite a large file (~130k, 5000 loc) with many chardev
and a lot of #ifdef. It doesn't use qemu Object. Using qemu Object
hopefully brings cleaner, more consitent code base. It helps to split
the various backends in different files. Eventually, we could also
allow or switch to -object-add CLI option instead of -chardev.

This series is the first of a pretty large chardev refactoring series
that I keep here:
https://github.com/elmarco/qemu/commits/chrfe

The series is based after "char: fix ctrl-a b not working" patch sent
earlier.

For "spice-char: improve error reporting" to not introduce a regression,
"error: report hints on stderr when no monitor" is required (sent
earlier in the ML).

v1->v2:
- fix intermediate patches regressions spotted by Eric
- code style improvements
- add r-b tags

WIP->v1:
- took most of Eric review comments, they were mostly about style

Marc-Andr=C3=A9 Lureau (20):
  tests: fix linking test-char on win32
  qemu-options: stdio is available on win32
  char: add qemu_chr_fe_add_watch() Returns description
  doc: fix spelling
  char: use a const CharDriver
  char: use a static array for backends
  char: move callbacks in CharDriver
  char: fold single-user functions in caller
  char: introduce generic qemu_chr_get_kind()
  char: use a feature bit for replay
  char: allocate CharDriverState as a single object
  bt: use qemu_chr_alloc()
  char: rename CharDriverState Chardev
  char: rename TCPChardev and NetChardev
  spice-char: improve error reporting
  char: use error_report()
  gtk: overwrite the console.c char driver
  baum: use a common prefix for chr callbacks
  vc: use a common prefix for chr callbacks
  chardev: qom-ify

 hw/lm32/lm32.h                    |    4 +-
 hw/lm32/milkymist-hw.h            |    2 +-
 include/hw/arm/exynos4210.h       |    2 +-
 include/hw/arm/omap.h             |    6 +-
 include/hw/bt.h                   |    4 +-
 include/hw/char/cadence_uart.h    |    2 +-
 include/hw/char/escc.h            |    2 +-
 include/hw/char/pl011.h           |    4 +-
 include/hw/char/serial.h          |    4 +-
 include/hw/char/xilinx_uartlite.h |    2 +-
 include/hw/cris/etraxfs.h         |    2 +-
 include/hw/devices.h              |    2 +-
 include/hw/i386/pc.h              |    2 +-
 include/hw/m68k/mcf.h             |    4 +-
 include/hw/ppc/spapr_vio.h        |    2 +-
 include/hw/qdev-properties.h      |    2 +-
 include/hw/sh4/sh.h               |    2 +-
 include/hw/sparc/grlib.h          |    2 +-
 include/hw/xen/xen.h              |    2 +-
 include/monitor/monitor.h         |    2 +-
 include/qemu/typedefs.h           |    2 +-
 include/sysemu/char.h             |  155 +--
 include/sysemu/replay.h           |    4 +-
 include/sysemu/sysemu.h           |    4 +-
 include/ui/console.h              |    2 +
 include/ui/gtk.h                  |    2 +-
 include/ui/qemu-spice.h           |    2 +-
 backends/baum.c                   |  102 +-
 backends/msmouse.c                |   77 +-
 backends/rng-egd.c                |    4 +-
 backends/testdev.c                |   53 +-
 gdbstub.c                         |   45 +-
 hw/arm/fsl-imx25.c                |    2 +-
 hw/arm/fsl-imx31.c                |    2 +-
 hw/arm/fsl-imx6.c                 |    2 +-
 hw/arm/nseries.c                  |    2 +-
 hw/arm/omap2.c                    |    2 +-
 hw/arm/pxa2xx.c                   |    2 +-
 hw/arm/virt.c                     |    2 +-
 hw/bt/hci-csr.c                   |   64 +-
 hw/char/escc.c                    |    2 +-
 hw/char/exynos4210_uart.c         |    2 +-
 hw/char/imx_serial.c              |    2 +-
 hw/char/mcf_uart.c                |    4 +-
 hw/char/omap_uart.c               |    6 +-
 hw/char/parallel.c                |    2 +-
 hw/char/serial-isa.c              |    2 +-
 hw/char/serial.c                  |    4 +-
 hw/char/sh_serial.c               |    2 +-
 hw/char/spapr_vty.c               |    2 +-
 hw/char/virtio-console.c          |    2 +-
 hw/core/qdev-properties-system.c  |    4 +-
 hw/display/milkymist-tmu2.c       |    2 +-
 hw/display/sm501.c                |    2 +-
 hw/isa/isa-bus.c                  |    2 +-
 hw/isa/pc87312.c                  |    2 +-
 hw/mips/mips_malta.c              |    4 +-
 hw/misc/ivshmem.c                 |    2 +-
 hw/misc/milkymist-pfpu.c          |    2 +-
 hw/usb/ccid-card-passthru.c       |    2 +-
 hw/usb/dev-serial.c               |    6 +-
 hw/usb/redirect.c                 |    4 +-
 monitor.c                         |    6 +-
 net/colo-compare.c                |    4 +-
 net/filter-mirror.c               |    4 +-
 net/slirp.c                       |    2 +-
 net/vhost-user.c                  |   10 +-
 qemu-char.c                       | 1914 ++++++++++++++++++++-----------=
------
 qmp.c                             |    2 +-
 qtest.c                           |    2 +-
 replay/replay-char.c              |    8 +-
 spice-qemu-char.c                 |  231 +++--
 stubs/get-next-serial.c           |    2 +-
 stubs/monitor-init.c              |    2 +-
 stubs/replay.c                    |    4 +-
 tests/test-char.c                 |   10 +-
 tests/vhost-user-test.c           |    4 +-
 ui/console.c                      |  111 ++-
 ui/gtk.c                          |   86 +-
 vl.c                              |   12 +-
 xen-common-stub.c                 |    2 +-
 xen-common.c                      |    4 +-
 qemu-options.hx                   |    4 +-
 tests/Makefile.include            |    2 +-
 84 files changed, 1729 insertions(+), 1343 deletions(-)

--=20
2.11.0
