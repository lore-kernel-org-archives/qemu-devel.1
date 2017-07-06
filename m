Received: from eggs.gnu.org ([2001:4830:134:3::10]:35759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dT5bE-0005FM-MN
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dT5bA-0004bb-Kc
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:09:36 -0400
Received: from mail-ve1eur01on0136.outbound.protection.outlook.com
	([104.47.1.136]:54000
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dT5b9-0004az-Rp
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:09:32 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu,  6 Jul 2017 15:08:47 +0300
Message-ID: <1499342940-56739-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 00/13] chardevice hotswap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, amit@kernel.org, mst@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Changed in v6:
  - patch 3: chr_lock mutex removed (as discussed, thread safety can be lef=
t to
    the front-ends, and the front-ends currently supported are good as is).
  - patch 5 now includes related changes for serial and virtio-serial=20
  - patch 13 commit message extended

=3D=3D=3D=3D=3D=3D=3D=3D

Changed in v5:
  - rebased
  - patch 6 fixed (wouldn't compile until patch 7 (broken by previous rebas=
e))
  - patch 11 commit message added

=3D=3D=3D=3D=3D=3D=3D=3D

Changed in v4:
  - rebased on top of the latest chardev changes
  - remarks applied
  - patch 1 fixed so it works with alias names

=3D=3D=3D=3D=3D=3D=3D=3D

Changed in v3:
  - minor remarks to patch 1 applied
  - patch 3: avoid using bottom-half, handle syncronously
    As mentioned, it gets thing complicated and is only a problem for
    a monitor-connected chardev hotswap and that is not supported for now
  - tests added (patches 6-9)

=3D=3D=3D=3D=3D=3D=3D=3D

This serie is a v2 of the February submit
http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg01989.html

The interface is changed as requested and the changes are slightly reworked
and split into separate patches.

=3D=3D=3D=3D=3D=3D=3D=3D

The patchset adds support of the character device change without
a frontend device removal.
Yet isa-serial and virtio-serial frontends are supported.

The feature can be helpful for e.g. Windows debug allowing to
establish connection to a live VM from VM with WinDbg.

Anton Nefedov (13):
  char: move QemuOpts->ChardevBackend translation to a separate func
  char: add backend hotswap handler
  char: chardevice hotswap
  char: forbid direct chardevice access for hotswap devices
  char: avoid chardevice direct access
  test-char: destroy chardev-udp after test
  test-char: split char_udp_test
  test-char: split char_file_test
  test-char: add hotswap test
  hmp: add hmp analogue for qmp-chardev-change
  virtio-console: chardev hotswap support
  serial: move TIOCM update to a separate function
  serial: chardev hotswap support

 include/chardev/char-fe.h   |  22 ++++
 include/chardev/char.h      |  19 +++
 hmp.h                       |   1 +
 backends/rng-egd.c          |   2 +-
 chardev/char-fe.c           |  16 ++-
 chardev/char-mux.c          |   1 +
 chardev/char.c              | 164 +++++++++++++++++++++-----
 gdbstub.c                   |   2 +-
 hmp-commands.hx             |  18 ++-
 hmp.c                       |  34 ++++++
 hw/arm/pxa2xx.c             |   3 +-
 hw/arm/strongarm.c          |   4 +-
 hw/char/bcm2835_aux.c       |   2 +-
 hw/char/cadence_uart.c      |   4 +-
 hw/char/debugcon.c          |   4 +-
 hw/char/digic-uart.c        |   2 +-
 hw/char/escc.c              |   8 +-
 hw/char/etraxfs_ser.c       |   2 +-
 hw/char/exynos4210_uart.c   |   4 +-
 hw/char/grlib_apbuart.c     |   4 +-
 hw/char/imx_serial.c        |   2 +-
 hw/char/ipoctal232.c        |   4 +-
 hw/char/lm32_juart.c        |   2 +-
 hw/char/lm32_uart.c         |   2 +-
 hw/char/mcf_uart.c          |   2 +-
 hw/char/milkymist-uart.c    |   2 +-
 hw/char/parallel.c          |   2 +-
 hw/char/pl011.c             |   2 +-
 hw/char/sclpconsole-lm.c    |   4 +-
 hw/char/sclpconsole.c       |   4 +-
 hw/char/serial.c            |  63 +++++++---
 hw/char/sh_serial.c         |   4 +-
 hw/char/spapr_vty.c         |   4 +-
 hw/char/stm32f2xx_usart.c   |   3 +-
 hw/char/terminal3270.c      |   4 +-
 hw/char/virtio-console.c    |  35 +++++-
 hw/char/xen_console.c       |   4 +-
 hw/char/xilinx_uartlite.c   |   2 +-
 hw/ipmi/ipmi_bmc_extern.c   |   4 +-
 hw/mips/boston.c            |   2 +-
 hw/mips/mips_malta.c        |   2 +-
 hw/misc/ivshmem.c           |   6 +-
 hw/usb/ccid-card-passthru.c |   6 +-
 hw/usb/dev-serial.c         |   7 +-
 hw/usb/redirect.c           |   7 +-
 monitor.c                   |   4 +-
 net/colo-compare.c          |  10 +-
 net/filter-mirror.c         |   8 +-
 net/slirp.c                 |   2 +-
 net/vhost-user.c            |   7 +-
 qapi-schema.json            |  40 +++++++
 qtest.c                     |   2 +-
 tests/test-char.c           | 275 ++++++++++++++++++++++++++++++++--------=
----
 tests/test-hmp.c            |   1 +
 tests/vhost-user-test.c     |   2 +-
 55 files changed, 647 insertions(+), 199 deletions(-)

--=20
2.7.4
