Received: from eggs.gnu.org ([2001:4830:134:3::10]:46831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBhJy-0000Y0-9S
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dBhJt-0004Dl-C0
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:47:54 -0400
Received: from mail-eopbgr00136.outbound.protection.outlook.com
	([40.107.0.136]:31167
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dBhJs-0004AG-JK
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:47:49 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 May 2017 15:47:13 +0300
Message-ID: <1495198042-124203-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/9] chardevice hotswap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

This serie is a v2 of the February submit
http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg01989.html

The interface is changed as requested and the changes are slightly reworked
and split into separate patches.

========

The patchset adds support of the character device change without
a frontend device removal.
Yet isa-serial and virtio-serial frontends are supported.

The feature can be helpful for e.g. Windows debug allowing to
establish connection to a live VM from VM with WinDbg.

Anton Nefedov (9):
  char: move QemuOpts->ChardevBackend translation to a separate func
  char: add backend hotswap handler
  char: chardevice hotswap
  hmp: add hmp analogue for qmp-chardev-change
  char: forbid direct chardevice access for hotswap devices
  virtio-console: chardev hotswap support
  serial: move TIOCM update to a separate function
  serial: chardev hotswap support
  char: avoid chardevice direct access

 backends/rng-egd.c          |   2 +-
 chardev/char-mux.c          |   1 +
 chardev/char.c              | 235 +++++++++++++++++++++++++++++++++++++-------
 gdbstub.c                   |   4 +-
 hmp-commands.hx             |  16 +++
 hmp.c                       |  34 +++++++
 hmp.h                       |   1 +
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
 hw/char/serial.c            |  63 +++++++++---
 hw/char/sh_serial.c         |   4 +-
 hw/char/spapr_vty.c         |   4 +-
 hw/char/stm32f2xx_usart.c   |   3 +-
 hw/char/terminal3270.c      |   4 +-
 hw/char/virtio-console.c    |  35 ++++++-
 hw/char/xen_console.c       |   4 +-
 hw/char/xilinx_uartlite.c   |   2 +-
 hw/ipmi/ipmi_bmc_extern.c   |   4 +-
 hw/mips/boston.c            |   2 +-
 hw/mips/mips_malta.c        |   2 +-
 hw/misc/ivshmem.c           |   6 +-
 hw/usb/ccid-card-passthru.c |   6 +-
 hw/usb/dev-serial.c         |   7 +-
 hw/usb/redirect.c           |   7 +-
 include/sysemu/char.h       |  44 +++++++++
 monitor.c                   |   4 +-
 net/colo-compare.c          |  14 +--
 net/filter-mirror.c         |   8 +-
 net/slirp.c                 |   2 +-
 net/vhost-user.c            |   7 +-
 qapi-schema.json            |  40 ++++++++
 qtest.c                     |   2 +-
 tests/test-char.c           |  14 ++-
 tests/vhost-user-test.c     |   2 +-
 52 files changed, 506 insertions(+), 140 deletions(-)

-- 
2.7.4
