Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A9BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A4720714
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJXlCbTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A4720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRqm-00067s-2d
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRq9-0005dr-AF
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:24:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRq7-0003xS-T4
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:24:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47720
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRq7-0003wK-PL
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ev/gTvgFyXtJSHrl5YfYWtFbubKtiOYjVJl5Vz1aJ5Y=;
 b=GJXlCbTnFZPLSoQhs6FpQLE0frLANx9RMgWgkDdFISNjNNJFKG9prJoaccDHzg1nEQhWB4
 zzMRjOIgiR8WIho6RIisVirS8KI4gGnBpjFhUDbk+19V5P72YJg45VkIpkOT/dzF9uhZhq
 1ssmqAfE3OjGRPJCkQ46wmG3W6GWE+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-3ReFl-cjOA2FZZQoBplOQA-1; Wed, 20 Nov 2019 10:24:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8D6C800A02;
 Wed, 20 Nov 2019 15:24:14 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96AC06715F;
 Wed, 20 Nov 2019 15:24:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/37] Clean-ups: qom-ify serial and remove QDEV_PROP_PTR
Date: Wed, 20 Nov 2019 19:23:23 +0400
Message-Id: <20191120152400.26012-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3ReFl-cjOA2FZZQoBplOQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Marc-Andr=C3=A9 Lureau (37):
  qdev: remove unused qdev_prop_int64
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
  RFC: mips/cps: fix setting saar property
  cris: improve passing PIC interrupt vector to the CPU
  smbus-eeprom: remove PROP_PTR
  omap-intc: remove PROP_PTR
  omap-i2c: remove PROP_PTR
  omap-gpio: remove PROP_PTR
  qdev: remove PROP_MEMORY_REGION
  qdev: remove QDEV_PROP_PTR
  qdev/qom: remove some TODO limitations now that PROP_PTR is gone

 chardev/char.c               |  32 +++++--
 hw/arm/omap1.c               |   8 +-
 hw/arm/omap2.c               |  25 +++---
 hw/char/omap_uart.c          |   2 +-
 hw/char/serial-isa.c         |  12 ++-
 hw/char/serial-pci-multi.c   |  55 +++++++-----
 hw/char/serial-pci.c         |  18 +++-
 hw/char/serial.c             | 170 ++++++++++++++++++++++++++++-------
 hw/core/qdev-properties.c    |  50 -----------
 hw/core/qdev.c               |  15 +---
 hw/core/sysbus.c             |  32 -------
 hw/cris/axis_dev88.c         |   4 -
 hw/display/sm501.c           |  33 +++++--
 hw/dma/sparc32_dma.c         |   2 +-
 hw/gpio/omap_gpio.c          |  42 ++++-----
 hw/i2c/omap_i2c.c            |  19 ++--
 hw/i2c/smbus_eeprom.c        |  17 ++--
 hw/i386/pc.c                 |   7 +-
 hw/i386/vmmouse.c            |   8 +-
 hw/input/pckbd.c             |   8 +-
 hw/intc/etraxfs_pic.c        |  26 +-----
 hw/intc/grlib_irqmp.c        |  35 +-------
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
 hw/sparc/leon3.c             |  15 +++-
 include/hw/arm/omap.h        |  52 +++++++++++
 include/hw/char/serial.h     |  43 ++++++---
 include/hw/cris/etraxfs.h    |  20 +----
 include/hw/input/i8042.h     |   4 +-
 include/hw/qdev-properties.h |  27 ------
 include/hw/sysbus.h          |  13 +--
 include/qemu/id.h            |   1 +
 qom/qom-qmp-cmds.c           |  10 ---
 target/cris/cpu.c            |   8 ++
 target/cris/cpu.h            |   1 +
 util/id.c                    |   1 +
 47 files changed, 497 insertions(+), 423 deletions(-)

--=20
2.24.0


