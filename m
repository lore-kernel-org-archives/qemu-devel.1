Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676F3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371A1207C4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUjUYWj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371A1207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbw6-0006Zn-DP
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 11:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbt9-0000pN-TM
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:04:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbt5-00018n-As
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589555074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ikU9qGHWdgdXj/CqFoeDCSlfKdLcMfsBsBzVy5IoNF0=;
 b=cUjUYWj4xF4b3REmzma9vWb1T5PTtUDCvX9PPb1nHTzUcNa7XdG/pXp48irLh+ImTkbuhr
 59/AnFeYxcu5CeZOOeWNnKOE/DEIjJXVk1tzudPUaq5yWbiI2GY213lS4Rwhjv3EGVXjIM
 mDbHn47LVoXzZeWfxrDB2uZFqw66Cc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-gb80-7iiOV-evS0fW3t-EQ-1; Fri, 15 May 2020 11:04:32 -0400
X-MC-Unique: gb80-7iiOV-evS0fW3t-EQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FB9E835B40;
 Fri, 15 May 2020 15:04:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 781D060C84;
 Fri, 15 May 2020 15:04:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 94DF69D54; Fri, 15 May 2020 17:04:21 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/16] acpi: i386 tweaks
Date: Fri, 15 May 2020 17:04:05 +0200
Message-Id: <20200515150421.25479-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
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

v3 changes: fix rtc, support multiple lpt devices.

v4 changes:
 * drop merged patches.
 * split rtc crs change to separata patch.
 * added two cleanup patches.
 * picked up ack & review tags.

v5 changes:
 * add comment for rtc crs update.
 * add even more cleanup patches.
 * picked up ack & review tags.

v6 changes:
 * floppy: move cmos_get_fd_drive_type.
 * picked up ack & review tags.

take care,
  Gerd

Gerd Hoffmann (16):
  qtest: allow DSDT acpi table changes
  acpi: move aml builder code for rtc device
  acpi: rtc: use a single crs range
  acpi: serial: don't use _STA method
  acpi: move aml builder code for serial device
  acpi: parallel: don't use _STA method
  acpi: move aml builder code for parallel device
  acpi: move aml builder code for floppy device
  floppy: make isa_fdc_get_drive_max_chs static
  floppy: move cmos_get_fd_drive_type() from pc
  acpi: move aml builder code for i8042 (kbd+mouse) device
  acpi: factor out fw_cfg_add_acpi_dsdt()
  acpi: simplify build_isa_devices_aml()
  acpi: drop serial/parallel enable bits from dsdt
  acpi: drop build_piix4_pm()
  acpi: q35: drop _SB.PCI0.ISA.LPCD opregion.

 hw/i386/fw_cfg.h                            |   1 +
 include/hw/block/fdc.h                      |   3 +-
 include/hw/i386/pc.h                        |   1 -
 tests/qtest/bios-tables-test-allowed-diff.h |  17 ++
 hw/block/fdc.c                              | 111 ++++++-
 hw/char/parallel.c                          |  22 ++
 hw/char/serial-isa.c                        |  22 ++
 hw/i386/acpi-build.c                        | 312 +-------------------
 hw/i386/fw_cfg.c                            |  28 ++
 hw/i386/pc.c                                |  25 --
 hw/input/pckbd.c                            |  31 ++
 hw/rtc/mc146818rtc.c                        |  24 ++
 stubs/cmos.c                                |   7 +
 stubs/Makefile.objs                         |   1 +
 14 files changed, 269 insertions(+), 336 deletions(-)
 create mode 100644 stubs/cmos.c

-- 
2.18.4


