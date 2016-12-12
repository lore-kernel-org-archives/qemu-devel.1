Received: from eggs.gnu.org ([2001:4830:134:3::10]:42584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZJn-00036b-5M
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZJj-0003C5-UT
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:43:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43667)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZJj-0003Bm-LT
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:43:31 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97D707DCF5
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:43:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:31 +0300
Message-Id: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/54] WIP: chardev: qom-ify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This is a followup of the series "char: fixes and improvements", where
I started to refactor a bit the code to allow qom-ification. Paolo
quickly reviewed some of those patches already.

qemu-char.c is quite a large file (~130k, 5000 loc) with may chardev
and a lot of #ifdef. It doesn't use qemu Object. Using Object
hopefully brings cleaner, more consitent code base. It helps to split
the various backends in different files. Eventually, we could also
allow or switch to -object-add interface.

Note: this series has been tested with Linux and cross-building with
mingw. It mostly breaks on other platforms, help welcome for
testing. I'd also like to write more chardev backend tests to ensure
no regression (test-char.c is quite limited for now)

Comments and testing welcome!

Marc-Andr=C3=A9 Lureau (54):
  gtk: avoid oob array access
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
  chardev: qom-ify
  spice-qemu-char: convert to finalize
  baum: convert to finalize
  msmouse: convert to finalize
  mux: convert to finalize
  char-udp: convert to finalize
  char-socket: convert to finalize
  char-pty: convert to finalize
  char-ringbuf: convert to finalize
  char-parallel: convert parallel to finalize
  char-stdio: convert to finalize
  char-win-stdio: convert to finalize
  char-win: do not override chr_free
  char-win: convert to finalize
  char-fd: convert to finalize
  char: remove chr_free
  char: get rid of CharDriver
  char: remove class kind field
  char: move to chardev/
  char: create chardev-obj-y
  char: make null_chr_write() the default method
  char: move null chardev to its own file
  char: move mux to its own file
  char: move ringbuf/memory to its own file
  char: rename and move to header CHR_READ_BUF_LEN
  char: remove unused READ_RETRIES
  char: move QIOChannel-related in char-io.h
  char: move fd chardev in its own file
  char: move win chardev base class in its own file
  char: move win-stdio into its own file
  char: move socket chardev to itw own file
  char: move udp chardev in its own file
  char: move file chardev in its own file
  char: move stdio in its own file
  char: move console in its own file
  char: move pipe chardev in its own file
  char: move pty chardev in its own file
  char: move serial chardev to itw own file
  char: move parallel chardev in its own file
  char: headers clean-up

 backends/baum.c                   |   97 +-
 backends/msmouse.c                |   72 +-
 backends/rng-egd.c                |    4 +-
 backends/testdev.c                |   48 +-
 chardev/char-console.c            |   30 +
 chardev/char-fd.c                 |  147 ++
 chardev/char-file.c               |  115 +
 chardev/char-io.c                 |  168 ++
 chardev/char-mux.c                |  332 +++
 chardev/char-null.c               |   31 +
 chardev/char-parallel.c           |  292 +++
 chardev/char-pipe.c               |  167 ++
 chardev/char-pty.c                |  277 +++
 chardev/char-ringbuf.c            |  225 ++
 chardev/char-serial.c             |  294 +++
 chardev/char-socket.c             |  995 ++++++++
 chardev/char-stdio.c              |  140 ++
 chardev/char-udp.c                |  211 ++
 chardev/char-win-stdio.c          |  243 ++
 chardev/char-win.c                |  245 ++
 chardev/char.c                    | 1311 ++++++++++
 gdbstub.c                         |   39 +-
 hw/arm/fsl-imx25.c                |    2 +-
 hw/arm/fsl-imx31.c                |    2 +-
 hw/arm/fsl-imx6.c                 |    2 +-
 hw/arm/nseries.c                  |    2 +-
 hw/arm/omap2.c                    |    2 +-
 hw/arm/pxa2xx.c                   |    2 +-
 hw/arm/virt.c                     |    2 +-
 hw/bt/hci-csr.c                   |   63 +-
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
 qemu-char.c                       | 4956 -------------------------------=
------
 qmp.c                             |    2 +-
 qtest.c                           |    2 +-
 replay/replay-char.c              |    8 +-
 spice-qemu-char.c                 |  221 +-
 stubs/get-next-serial.c           |    2 +-
 stubs/monitor-init.c              |    2 +-
 stubs/replay.c                    |    4 +-
 tests/test-char.c                 |   10 +-
 tests/vhost-user-test.c           |    4 +-
 ui/console.c                      |  104 +-
 ui/gtk.c                          |   82 +-
 vl.c                              |   12 +-
 xen-common-stub.c                 |    2 +-
 xen-common.c                      |    4 +-
 Makefile                          |    3 +-
 Makefile.objs                     |    4 +-
 Makefile.target                   |    3 +
 chardev/Makefile.objs             |   17 +
 tests/Makefile.include            |    6 +-
 MAINTAINERS                       |    2 +-
 chardev/char-fd.h                 |   21 +
 chardev/char-io.h                 |   24 +
 chardev/char-mux.h                |   40 +
 chardev/char-parallel.h           |    9 +
 chardev/char-serial.h             |   12 +
 chardev/char-win-stdio.h          |    6 +
 chardev/char-win.h                |   30 +
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
 include/sysemu/char.h             |  153 +-
 include/sysemu/replay.h           |    4 +-
 include/sysemu/sysemu.h           |    4 +-
 include/ui/console.h              |    2 +
 include/ui/gtk.h                  |    2 +-
 include/ui/qemu-spice.h           |    2 +-
 112 files changed, 6008 insertions(+), 5455 deletions(-)
 create mode 100644 chardev/char-console.c
 create mode 100644 chardev/char-fd.c
 create mode 100644 chardev/char-file.c
 create mode 100644 chardev/char-io.c
 create mode 100644 chardev/char-mux.c
 create mode 100644 chardev/char-null.c
 create mode 100644 chardev/char-parallel.c
 create mode 100644 chardev/char-pipe.c
 create mode 100644 chardev/char-pty.c
 create mode 100644 chardev/char-ringbuf.c
 create mode 100644 chardev/char-serial.c
 create mode 100644 chardev/char-socket.c
 create mode 100644 chardev/char-stdio.c
 create mode 100644 chardev/char-udp.c
 create mode 100644 chardev/char-win-stdio.c
 create mode 100644 chardev/char-win.c
 create mode 100644 chardev/char.c
 delete mode 100644 qemu-char.c
 create mode 100644 chardev/Makefile.objs
 create mode 100644 chardev/char-fd.h
 create mode 100644 chardev/char-io.h
 create mode 100644 chardev/char-mux.h
 create mode 100644 chardev/char-parallel.h
 create mode 100644 chardev/char-serial.h
 create mode 100644 chardev/char-win-stdio.h
 create mode 100644 chardev/char-win.h

--=20
2.11.0
