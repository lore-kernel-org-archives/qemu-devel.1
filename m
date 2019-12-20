Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6373EC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7B3222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4QO1gTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7B3222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIdd-0004AQ-Dc
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIbg-000297-EI
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIbd-0003gA-1c
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:46:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35790
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iiIbc-0003be-5o
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576849570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hBukgubQVDBmzERpip4joFl6Fkf3jz7yfiwfNGsYVpI=;
 b=B4QO1gThEDUmMxOCj2POWwxx9v86B7CtrzCFsSZxEmyGe2sNdPYaKqPKtkMU4ValOzhIUS
 c1DDNKWb8LtSv32ZERZ0+jHnCov/no4EC5qbr1vGKW/rhx2Nizi+lgcAWl6qgPJsL7rL/Z
 oGd9QEeMTEhT2ds63xyTk07iXqdRUl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-YqHFfRa_NJ6sV96xnmNyYA-1; Fri, 20 Dec 2019 08:46:09 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86E0C107B7F1;
 Fri, 20 Dec 2019 13:46:08 +0000 (UTC)
Received: from localhost (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58DEC1A8E4;
 Fri, 20 Dec 2019 13:46:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/37] Clean-ups: qom-ify serial and remove QDEV_PROP_PTR
Date: Fri, 20 Dec 2019 17:45:24 +0400
Message-Id: <20191220134601.571905-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: YqHFfRa_NJ6sV96xnmNyYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

QDEV_PROP_PTR is marked in multiple places as "FIXME/TODO/remove
me". In most cases, it can be easily replaced with QDEV_PROP_LINK when
the pointer points to an Object.

There are a few places where such substitution isn't possible. For
those places, it seems reasonable to use a specific setter method
instead, and keep the user_creatable =3D false. In other places,
proper usage of qdev or other facilies is the solution.

The serial code wasn't converted to qdev, which makes it a bit more
archaic to deal with. Let's convert it first, so we can more easily
embed it from other devices, and re-export some properties and drop
QDEV_PROP_PTR usage.

List of patches missing reviews/ack:
- "chardev: generate an internal id when none given"
- "serial: register vmsd with DeviceClass"
- "serial: start making SerialMM a sysbus device"
- "sm501: make SerialMM a child, export chardev property"
- "qdev/qom: remove some TODO limitations now that PROP_PTR is gone"

v5:
 - dropped "qdev: remove unused qdev_prop_int64"
 - move qdev serial realize to serial_mm_realize()
 - fix "leon3: use qdev gpio facilities for the PIL", s/env/cpu
 - various comments / commit message tweaks
 - added r-b tags

v4: (after Peter & Philippe reviews)
 - replaced "self" variable names with abbreviations
 - split "mips: inline serial_init()"
 - new patches: "mips: use sysbus_mmio_get_region() instead of internal
   fields", "leon3: use qdev gpio facilities for the PIL", "qdev: use
   g_strcmp0() instead of open-coding it", "qdev/qom: remove some TODO
   limitations now that PROP_PTR is gone"
 - dropped patches: "sparc: move PIL irq handling to cpu.c" & "serial:
   add "instance-id" property"
 - various comments / commit message tweaks
 - added r-b tags

v3:
 - introduce SerialMM and SerialIO sysbus devices
 - remove serial_mm_connect introduced in v2
 - replace "base" property introduced in v2, use "instance-id" for
   vmstate purpose only
 - add a few preliminary clean-ups

v2:
 - qom-ify serial
 - embed the serial from sm501, and expose a "chardev" property
 - add "leon3: use qemu_irq framework instead of callback as property"
 - add "sparc: move PIL irq handling to cpu.c"
 - add "cris: improve passing PIC interrupt vector to the CPU"
 - misc comment/todo changes, add r-b tags

Marc-Andr=C3=A9 Lureau (36):
  sysbus: remove unused sysbus_try_create*
  sysbus: remove outdated comment
  chardev: generate an internal id when none given
  serial-pci-multi: factor out multi_serial_get_port_count()
  serial: initial qom-ification
  serial: register vmsd with DeviceClass
  serial: add "chardev" property
  serial: add "baudbase" property
  serial: realize the serial device
  serial: replace serial_exit_core() with unrealize
  serial: start making SerialMM a sysbus device
  serial-mm: add "regshift" property
  serial-mm: add endianness property
  serial-mm: use sysbus facilities
  serial: make SerialIO a sysbus device
  mips: inline serial_init()
  mips: baudbase is 115200 by default
  mips: use sysbus_add_io()
  mips: use sysbus_mmio_get_region() instead of internal fields
  sm501: make SerialMM a child, export chardev property
  vmmouse: replace PROP_PTR with PROP_LINK
  lance: replace PROP_PTR with PROP_LINK
  etraxfs: remove PROP_PTR usage
  dp8393x: replace PROP_PTR with PROP_LINK
  leon3: use qemu_irq framework instead of callback as property
  leon3: use qdev gpio facilities for the PIL
  qdev: use g_strcmp0() instead of open-coding it
  mips/cps: fix setting saar property
  cris: improve passing PIC interrupt vector to the CPU
  smbus-eeprom: remove PROP_PTR
  omap-intc: remove PROP_PTR
  omap-i2c: remove PROP_PTR
  omap-gpio: remove PROP_PTR
  qdev: remove PROP_MEMORY_REGION
  qdev: remove QDEV_PROP_PTR
  qdev/qom: remove some TODO limitations now that PROP_PTR is gone

Philippe Mathieu-Daud=C3=A9 (1):
  hw/display/sm501: Always map the UART0

 chardev/char.c               |  32 ++++--
 hw/arm/omap1.c               |   8 +-
 hw/arm/omap2.c               |  25 ++---
 hw/char/omap_uart.c          |   2 +-
 hw/char/serial-isa.c         |  12 ++-
 hw/char/serial-pci-multi.c   |  55 +++++++----
 hw/char/serial-pci.c         |  18 +++-
 hw/char/serial.c             | 182 +++++++++++++++++++++++++++++------
 hw/core/qdev-properties.c    |  18 ----
 hw/core/qdev.c               |  15 +--
 hw/core/sysbus.c             |  32 ------
 hw/cris/axis_dev88.c         |   4 -
 hw/display/sm501.c           |  31 ++++--
 hw/dma/sparc32_dma.c         |   2 +-
 hw/gpio/omap_gpio.c          |  42 +++-----
 hw/i2c/omap_i2c.c            |  19 ++--
 hw/i2c/smbus_eeprom.c        |  18 ++--
 hw/i386/pc.c                 |   7 +-
 hw/i386/vmmouse.c            |   8 +-
 hw/input/pckbd.c             |   8 +-
 hw/intc/etraxfs_pic.c        |  26 +----
 hw/intc/grlib_irqmp.c        |  35 +------
 hw/intc/omap_intc.c          |  17 ++--
 hw/m68k/q800.c               |   3 +-
 hw/mips/boston.c             |   2 +-
 hw/mips/cps.c                |   2 +-
 hw/mips/mips_jazz.c          |   3 +-
 hw/mips/mips_malta.c         |   2 +-
 hw/mips/mips_mipssim.c       |  14 ++-
 hw/net/dp8393x.c             |   7 +-
 hw/net/etraxfs_eth.c         |  44 ++++++---
 hw/net/lance.c               |   5 +-
 hw/net/pcnet-pci.c           |   2 +-
 hw/net/pcnet.h               |   2 +-
 hw/sh4/r2d.c                 |   2 +-
 hw/sparc/leon3.c             |  15 ++-
 include/hw/arm/omap.h        |  52 ++++++++++
 include/hw/char/serial.h     |  43 ++++++---
 include/hw/cris/etraxfs.h    |  20 +---
 include/hw/input/i8042.h     |   4 +-
 include/hw/qdev-properties.h |  24 -----
 include/hw/sysbus.h          |  13 +--
 include/qemu/id.h            |   1 +
 qom/qom-qmp-cmds.c           |  10 --
 target/cris/cpu.c            |   8 ++
 target/cris/cpu.h            |   1 +
 util/id.c                    |   1 +
 47 files changed, 507 insertions(+), 389 deletions(-)

--=20
2.24.0.308.g228f53135a


