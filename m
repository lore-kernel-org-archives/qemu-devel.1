Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5AFC2D0E8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A784206F8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SR4m6xsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A784206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHQq-0004ia-6q
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jKHKQ-0001A1-95
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jKHKO-00080S-U3
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46101
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jKHKO-0007yP-Np
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585901124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nyV04BkZ5GWpUICeK2RstEi8CwJgjc3tCQagpD7m34s=;
 b=SR4m6xsTYnjz5aNZEIwfUUiP+0wVnfd1aB/mOWucJ+Nwrc71GEqGGjn1ntoaxVKWkr+tx/
 OL8+RzOic1ylTMfpABPA54elkoi3Xvh0xVGnsrijKfHvm4ehUJQnQ55kIRfVqPMKZKvNgs
 fJdjpKOsrzPysoF1K6IZu6AfINCxSgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-zZIktSAvOn2irMykSCgMzw-1; Fri, 03 Apr 2020 04:05:14 -0400
X-MC-Unique: zZIktSAvOn2irMykSCgMzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E47F9801F74;
 Fri,  3 Apr 2020 08:05:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB8D3B19A4;
 Fri,  3 Apr 2020 08:05:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D87A21747F; Fri,  3 Apr 2020 10:05:02 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/12] acpi: i386 tweaks
Date: Fri,  3 Apr 2020 10:04:50 +0200
Message-Id: <20200403080502.8154-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

First batch of microvm patches, some generic acpi stuff.
Split the acpi-build.c monster, specifically split the
pc and q35 and pci bits into a separate file which we
can skip building at some point in the future.

v2 changes: leave acpi-build.c largely as-is, move useful
bits to other places to allow them being reused, specifically:

 * move isa device generator functions to individual isa devices.
 * move fw_cfg generator function to fw_cfg.c

Sneak preview: full microvm series at
    https://git.kraxel.org/cgit/qemu/log/?h=3Dsirius/microvm

take care,
  Gerd

Gerd Hoffmann (12):
  move 'typedef Aml' to qemu/types.h
  acpi: add aml builder stubs
  acpi: drop pointless _STA method
  acpi: serial: don't use _STA method
  acpi: parallel: don't use _STA method
  acpi: add ISADeviceClass->build_aml()
  acpi: move aml builder code for rtc device
  acpi: move aml builder code for serial device
  acpi: move aml builder code for parallel device
  acpi: move aml builder code for floppy device
  acpi: move aml builder code for i8042 (kbd+mouse) device
  acpi: factor out fw_cfg_add_acpi_dsdt()

 hw/i386/fw_cfg.h            |   1 +
 include/hw/acpi/aml-build.h |   1 -
 include/hw/isa/isa.h        |   2 +
 include/qemu/typedefs.h     |   1 +
 hw/acpi/aml-build-stub.c    |  79 +++++++++++
 hw/block/fdc.c              |  83 ++++++++++++
 hw/char/parallel.c          |  25 ++++
 hw/char/serial-isa.c        |  32 +++++
 hw/i386/acpi-build.c        | 258 +-----------------------------------
 hw/i386/fw_cfg.c            |  28 ++++
 hw/input/pckbd.c            |  31 +++++
 hw/isa/isa-bus.c            |  15 +++
 hw/rtc/mc146818rtc.c        |  20 +++
 stubs/cmos.c                |   7 +
 hw/acpi/Makefile.objs       |   4 +-
 stubs/Makefile.objs         |   1 +
 16 files changed, 330 insertions(+), 258 deletions(-)
 create mode 100644 hw/acpi/aml-build-stub.c
 create mode 100644 stubs/cmos.c

--=20
2.18.2


