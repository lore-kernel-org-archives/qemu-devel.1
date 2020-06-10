Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B38C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 09:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DFFC2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 09:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8AnJqfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFFC2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jixIo-0003av-Ja
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 05:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jixF4-0006Ff-6m
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 05:41:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24793
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jixF2-0001cb-Hr
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 05:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591782111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=egvF608gFHxGary+8rBTgq/vwGG9B7Qci8nAFP1C2w0=;
 b=P8AnJqfsRPQy/71Ip0WY5yQlqyRlWDK9eeT/8juI0L1JRa4sIa9JFhyUhAlqFv7z7VqJip
 gVqiSHIvgwgfCQrnT/R1Gv8CfSgi8zW1BapqbgBjuhEfJZk5S1sNVHwMcp8s/KepWQFHwK
 ehhzCzcZJVYk36gnaR+Zmavw8UKMacc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-JF6XSe7ONAiQXS4u_QzRAA-1; Wed, 10 Jun 2020 05:41:48 -0400
X-MC-Unique: JF6XSe7ONAiQXS4u_QzRAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1855420DA;
 Wed, 10 Jun 2020 09:41:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3DFB61985;
 Wed, 10 Jun 2020 09:41:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9AD0B16E16; Wed, 10 Jun 2020 11:41:31 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 0/9] acpi: i386 tweaks
Date: Wed, 10 Jun 2020 11:41:22 +0200
Message-Id: <20200610094131.13346-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

take care,
  Gerd

Gerd Hoffmann (9):
  acpi: move aml builder code for floppy device
  floppy: make isa_fdc_get_drive_max_chs static
  floppy: move cmos_get_fd_drive_type() from pc
  acpi: move aml builder code for i8042 (kbd+mouse) device
  acpi: factor out fw_cfg_add_acpi_dsdt()
  acpi: simplify build_isa_devices_aml()
  acpi: drop serial/parallel enable bits from dsdt
  acpi: drop build_piix4_pm()
  acpi: q35: drop _SB.PCI0.ISA.LPCD opregion.

 hw/i386/fw_cfg.h       |   1 +
 include/hw/block/fdc.h |   3 +-
 include/hw/i386/pc.h   |   1 -
 hw/block/fdc.c         | 111 +++++++++++++++++++++-
 hw/i386/acpi-build.c   | 211 ++---------------------------------------
 hw/i386/fw_cfg.c       |  28 ++++++
 hw/i386/pc.c           |  25 -----
 hw/input/pckbd.c       |  31 ++++++
 stubs/cmos.c           |   7 ++
 stubs/Makefile.objs    |   1 +
 10 files changed, 184 insertions(+), 235 deletions(-)
 create mode 100644 stubs/cmos.c

-- 
2.18.4


