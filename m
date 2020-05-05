Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16499C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 11:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED2620735
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 11:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1pYda3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED2620735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVvvn-0007FM-RU
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 07:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVvuf-0005VB-35
 for qemu-devel@nongnu.org; Tue, 05 May 2020 07:39:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23079
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVvuc-0002xA-Mk
 for qemu-devel@nongnu.org; Tue, 05 May 2020 07:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588678737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xYQubRLaeBIkXfV3lDNiOMXW1hs8NbE+0dBEIHKrFOQ=;
 b=Q1pYda3wc/NYYdK0vp/lHXCPg3M7oVcFARVVwlBicTzUefQ/w3V+POSiaRu6NBPNZgLmBJ
 ha3N54/tvCjpQqoh+9A62B6sN+1+7Knsuf/OMAYLlw0wS42P7QFrCdlFwBX0TTvsjU0b0B
 eL3bsL7CZ9TLDIpTyYKqluqDjkPxSTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-TFh-KY12N7eYNTtiSxNHJQ-1; Tue, 05 May 2020 07:38:56 -0400
X-MC-Unique: TFh-KY12N7eYNTtiSxNHJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1F5D1B18BC0;
 Tue,  5 May 2020 11:38:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B425F600F5;
 Tue,  5 May 2020 11:38:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 913FE17510; Tue,  5 May 2020 13:38:43 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/13] acpi: i386 tweaks
Date: Tue,  5 May 2020 13:38:30 +0200
Message-Id: <20200505113843.22012-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

v3 changes: fix rtc, support multiple lpt devices.

v4 changes:
 * drop merged patches.
 * split rtc crs change to separata patch.
 * added two cleanup patches.
 * picked up ack & review tags.

take care,
  Gerd

Gerd Hoffmann (13):
  qtest: allow DSDT acpi table changes
  acpi: move aml builder code for rtc device
  acpi: rtc: use a single crs range
  acpi: serial: don't use _STA method
  acpi: move aml builder code for serial device
  acpi: parallel: don't use _STA method
  acpi: move aml builder code for parallel device
  acpi: move aml builder code for floppy device
  acpi: move aml builder code for i8042 (kbd+mouse) device
  acpi: factor out fw_cfg_add_acpi_dsdt()
  acpi: simplify build_isa_devices_aml()
  acpi: drop serial/parallel enable bits from dsdt
  floppy: make isa_fdc_get_drive_max_chs static

 hw/i386/fw_cfg.h                            |   1 +
 include/hw/block/fdc.h                      |   2 -
 tests/qtest/bios-tables-test-allowed-diff.h |  17 ++
 hw/block/fdc.c                              |  87 +++++-
 hw/char/parallel.c                          |  32 +++
 hw/char/serial-isa.c                        |  32 +++
 hw/i386/acpi-build.c                        | 285 +-------------------
 hw/i386/fw_cfg.c                            |  28 ++
 hw/input/pckbd.c                            |  31 +++
 hw/rtc/mc146818rtc.c                        |  20 ++
 stubs/cmos.c                                |   7 +
 stubs/Makefile.objs                         |   1 +
 12 files changed, 260 insertions(+), 283 deletions(-)
 create mode 100644 stubs/cmos.c

-- 
2.18.4


