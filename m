Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0ADC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07315206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWSXnHvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07315206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSGF-0000sj-7V
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlSEz-000761-Sr
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:12:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45588
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlSEu-0000U6-Si
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592377923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=y54Y6QtUUoTle++FzPtUuED7F2fNxKC4cBGfSNCdIiY=;
 b=XWSXnHvVSMY691vu6h8bBRc3Tb5d+Fdv1ZrjthALfGe/8bK8Ee6BBI/4j8FZMfrLfQ1po/
 eH7HVxL5OgaiqvgePSs/7QqAETIpsNAodMNlUL3w0HMz7g0glxk2M2f8sZDzckGOMUyZN1
 LVgDJy0thMbxB0G8R6nehihh6duLJXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-wzYa9v_tP--_ObqXtWEzgA-1; Wed, 17 Jun 2020 03:11:59 -0400
X-MC-Unique: wzYa9v_tP--_ObqXtWEzgA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF232105251F;
 Wed, 17 Jun 2020 07:11:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B98297931A;
 Wed, 17 Jun 2020 07:11:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 88F9B16E16; Wed, 17 Jun 2020 09:11:38 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 00/10] acpi: i386 tweaks
Date: Wed, 17 Jun 2020 09:11:28 +0200
Message-Id: <20200617071138.11159-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

v7 changes:
 * rebased to mst/pci branch, resolved stubs conflict.
 * dropped patches already queued up in mst/pci.
 * added missing sign-off.
 * picked up ack & review tags.

v8 changes:
 * (re-)add patch to allow acpi table changes

v9 changes:
 * add asl changes to commit messages.
 * update acpi test data.

take care,
  Gerd

Gerd Hoffmann (10):
  acpi: bios-tables-test: show more context on asl diffs
  acpi: move aml builder code for floppy device
  floppy: make isa_fdc_get_drive_max_chs static
  floppy: move cmos_get_fd_drive_type() from pc
  acpi: move aml builder code for i8042 (kbd+mouse) device
  acpi: factor out fw_cfg_add_acpi_dsdt()
  acpi: simplify build_isa_devices_aml()
  acpi: drop serial/parallel enable bits from dsdt
  acpi: drop build_piix4_pm()
  acpi: q35: drop _SB.PCI0.ISA.LPCD opregion.

 hw/i386/fw_cfg.h                  |   1 +
 include/hw/block/fdc.h            |   3 +-
 include/hw/i386/pc.h              |   1 -
 hw/block/fdc.c                    | 111 +++++++++++++++-
 hw/i386/acpi-build.c              | 210 +-----------------------------
 hw/i386/fw_cfg.c                  |  28 ++++
 hw/i386/pc.c                      |  25 ----
 hw/input/pckbd.c                  |  31 +++++
 stubs/cmos.c                      |   7 +
 tests/qtest/bios-tables-test.c    |   2 +-
 stubs/Makefile.objs               |   1 +
 tests/data/acpi/pc/DSDT           | Bin 5014 -> 4934 bytes
 tests/data/acpi/pc/DSDT.acpihmat  | Bin 6338 -> 6258 bytes
 tests/data/acpi/pc/DSDT.bridge    | Bin 6873 -> 6793 bytes
 tests/data/acpi/pc/DSDT.cphp      | Bin 5477 -> 5397 bytes
 tests/data/acpi/pc/DSDT.dimmpxm   | Bin 6667 -> 6587 bytes
 tests/data/acpi/pc/DSDT.ipmikcs   | Bin 5086 -> 5006 bytes
 tests/data/acpi/pc/DSDT.memhp     | Bin 6373 -> 6293 bytes
 tests/data/acpi/pc/DSDT.numamem   | Bin 5020 -> 4940 bytes
 tests/data/acpi/q35/DSDT          | Bin 7752 -> 7678 bytes
 tests/data/acpi/q35/DSDT.acpihmat | Bin 9076 -> 9002 bytes
 tests/data/acpi/q35/DSDT.bridge   | Bin 7769 -> 7695 bytes
 tests/data/acpi/q35/DSDT.cphp     | Bin 8215 -> 8141 bytes
 tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9405 -> 9331 bytes
 tests/data/acpi/q35/DSDT.ipmibt   | Bin 7827 -> 7753 bytes
 tests/data/acpi/q35/DSDT.memhp    | Bin 9111 -> 9037 bytes
 tests/data/acpi/q35/DSDT.mmio64   | Bin 8882 -> 8808 bytes
 tests/data/acpi/q35/DSDT.numamem  | Bin 7758 -> 7684 bytes
 tests/data/acpi/q35/DSDT.tis      | Bin 8357 -> 8283 bytes
 29 files changed, 185 insertions(+), 235 deletions(-)
 create mode 100644 stubs/cmos.c

-- 
2.18.4


