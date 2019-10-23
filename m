Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C09DCA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F417F21928
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ev2MUb0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F417F21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNMOu-0004gV-Hc
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 15:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKbV-0001bw-Vq
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKbT-0005h5-QS
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:39:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59298
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKbR-0005fi-Tr
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571851934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pmXQHe+rWCvel74Q+ujxEdZVMUQNzVj52uZOOpW0iGg=;
 b=Ev2MUb0p9Rd6og7FkRwzTSOgaHT4l2qk8duXq2I5FLR1mmgbc+1CcSx12gnRzsTceWcW6i
 t1UBzuedOFdRfSA1yTrEx+PDNDDOuOGzu65GIdKwadaqIQftPQRxOQb9dB2Wou/NGCrq9u
 aYZfxAuNDTQZBfcg0SbvYC5LhDf68Zw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-OwsQ3D6iPUq19Zj2ib_NBA-1; Wed, 23 Oct 2019 13:32:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FDA3100550E;
 Wed, 23 Oct 2019 17:32:04 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6433C5C1D4;
 Wed, 23 Oct 2019 17:31:55 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/33] Clean-ups: qom-ify serial and remove QDEV_PROP_PTR
Date: Wed, 23 Oct 2019 19:31:21 +0200
Message-Id: <20191023173154.30051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: OwsQ3D6iPUq19Zj2ib_NBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
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
proper usage of qemu_irq is the solution.

The serial code wasn't converted to qdev, which makes it a bit more
archaic to deal with. Let's convert it first, so we can more easily
embed it from other devices, and re-export some properties.

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

Marc-Andr=C3=A9 Lureau (33):
  qdev: remove unused qdev_prop_int64
  sysbus: remove unused sysbus_try_create*
  sysbus: remove outdated comment
  chardev: generate an internal id when none given
  serial-pci-multi: factor out multi_serial_get_nr_ports
  serial: initial qom-ification
  serial: register vmsd with DeviceClass
  serial: add "chardev" property
  serial: add "baudbase" property
  serial: add "instance-id" property
  serial: realize the serial device
  serial: replace serial_exit_core() with unrealize
  serial: start making SerialMM a sysbus device
  serial-mm: add "regshift" property
  serial-mm: add endianness property
  serial-mm: use sysbus facilities
  serial: make SerialIO a sysbus device
  mips: inline serial_init
  sm501: make SerialMM a child, export chardev property
  vmmouse: replace PROP_PTR with PROP_LINK
  lance: replace PROP_PTR with PROP_LINK
  etraxfs: remove PROP_PTR usage
  dp8393x: replace PROP_PTR with PROP_LINK
  leon3: use qemu_irq framework instead of callback as property
  sparc: move PIL irq handling to cpu.c
  RFC: mips/cps: fix setting saar property
  cris: improve passing PIC interrupt vector to the CPU
  smbus-eeprom: remove PROP_PTR
  omap-intc: remove PROP_PTR
  omap-i2c: remove PROP_PTR
  omap-gpio: remove PROP_PTR
  qdev: remove PROP_MEMORY_REGION
  qdev: remove QDEV_PROP_PTR

 chardev/char.c               |  32 +++++--
 hw/arm/omap1.c               |   8 +-
 hw/arm/omap2.c               |  25 +++---
 hw/char/omap_uart.c          |   2 +-
 hw/char/serial-isa.c         |  11 ++-
 hw/char/serial-pci-multi.c   |  45 +++++++---
 hw/char/serial-pci.c         |  17 +++-
 hw/char/serial.c             | 164 ++++++++++++++++++++++++++++-------
 hw/core/qdev-properties.c    |  50 -----------
 hw/core/sysbus.c             |  32 -------
 hw/cris/axis_dev88.c         |   4 -
 hw/display/sm501.c           |  31 +++++--
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
 hw/mips/boston.c             |   2 +-
 hw/mips/cps.c                |   2 +-
 hw/mips/mips_jazz.c          |   3 +-
 hw/mips/mips_malta.c         |   2 +-
 hw/mips/mips_mipssim.c       |  13 ++-
 hw/net/dp8393x.c             |   7 +-
 hw/net/etraxfs_eth.c         |  44 +++++++---
 hw/net/lance.c               |   5 +-
 hw/net/pcnet-pci.c           |   2 +-
 hw/net/pcnet.h               |   2 +-
 hw/sh4/r2d.c                 |   2 +-
 hw/sparc/leon3.c             |  38 +-------
 hw/sparc/trace-events        |   4 -
 include/hw/arm/omap.h        |  52 +++++++++++
 include/hw/char/serial.h     |  44 +++++++---
 include/hw/cris/etraxfs.h    |  20 +----
 include/hw/input/i8042.h     |   4 +-
 include/hw/qdev-properties.h |  27 ------
 include/hw/sysbus.h          |  13 +--
 include/qemu/id.h            |   1 +
 target/cris/cpu.c            |   8 ++
 target/cris/cpu.h            |   1 +
 target/sparc/cpu.c           |  39 +++++++++
 target/sparc/cpu.h           |   1 +
 target/sparc/trace-events    |   4 +
 util/id.c                    |   1 +
 48 files changed, 515 insertions(+), 428 deletions(-)

--=20
2.23.0.606.g08da6496b6


