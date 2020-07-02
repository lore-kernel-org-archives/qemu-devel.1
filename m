Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF332C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 21:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B21C20936
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 21:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcxK1uxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B21C20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr6Jm-00075o-Jk
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 17:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jr69I-0004s1-Ch
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 16:49:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53210
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jr69B-0003aF-Pr
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 16:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593722969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+D/ug5/o/j1UfsayiPE69auBjRpMax1pAYi57HqCtt4=;
 b=YcxK1uxa/BTvZsqo5bpu+gJ9L4XklYXAdKd6e8ghW7T+vyKzPprMVdTSb/mPmNs4OwTW60
 V/iJnsJxBogAZIX24qhUwPTJL5XP3RHoG2yy6/ywGGFoUyeLtCJFCOh0DoDNu629glFBgF
 s9SRU47uZ86bK7SkTG/vzk2PLBkrEZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-rq0YC5JDPPGhUyqfUmyPGw-1; Thu, 02 Jul 2020 16:49:15 -0400
X-MC-Unique: rq0YC5JDPPGhUyqfUmyPGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1534107ACCA;
 Thu,  2 Jul 2020 20:49:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3629371678;
 Thu,  2 Jul 2020 20:49:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BEE25EB2; Thu,  2 Jul 2020 22:48:59 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/21] microvm: add acpi support
Date: Thu,  2 Jul 2020 22:48:38 +0200
Message-Id: <20200702204859.9876-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I know that not supporting ACPI in microvm is intentional.  If you still
don't want ACPI this is perfectly fine, you can use the usual -no-acpi
switch to toggle ACPI support.

These are the advantages you are going to loose then:

  (1) virtio-mmio device discovery without command line hacks (tweaking
      the command line is a problem when not using direct kernel boot).
  (2) Better IO-APIC support, we can use IRQ lines 16-23.
  (3) ACPI power button (aka powerdown request) works.
  (4) machine poweroff (aka S5 state) works.

Together with seabios patches for virtio-mmio support this allows to
boot standard fedora images (cloud, coreos, workstation live) with the
microvm machine type.

git branch for testing (including updated seabios):
	https://git.kraxel.org/cgit/qemu/log/?h=sirius/microvm

changes in v2:
  * some acpi cleanups are an separate patch series now.
  * switched to hw reduced acpi & generic event device.
  * misc fixes here and there.

changes in v3:
  * depeds on "[PATCH v6 00/16] acpi: i386 tweaks" series.
  * renamed qboot to qboot.bin
  * updated seabios to master branch snapshot.
    - this version boots fine with rtc=off
  * generic event device tweaks (Igor's comments).
  * make SMP work.
  * add RfC patches to turn off acpi by default for microvm.
  * misc fixes here and there.

changes in v4
  * rebase to latest master
    - this also depends on the pending seabios update
  * drop some patches which got cherry-picked.
  * wire up cpu hotplug (also does coldplug cpu init).
  * add microvm acpi test case.
  * dropped RfC patches to turn off acpi by default for microvm.
  * misc fixes here and there.

take care,
  Gerd

Gerd Hoffmann (21):
  microvm: name qboot binary qboot.rom
  seabios: add microvm config, update build rules
  seabios: add bios-microvm.bin binary
  acpi: ged: add control regs
  acpi: ged: add x86 device variant.
  acpi: move acpi_dsdt_add_power_button() to ged
  microvm: make virtio irq base runtime configurable
  microvm/acpi: add minimal acpi support
  microvm/acpi: add acpi_dsdt_add_virtio() for x86
  microvm/acpi: use GSI 16-23 for virtio
  microvm/acpi: use seabios with acpi=on
  microvm/acpi: disable virtio-mmio cmdline hack
  x86: constify x86_machine_is_*_enabled
  x86: move acpi_dev from pc/microvm
  x86: move cpu plug from pc to x86
  microvm: wire up hotplug
  tests/acpi: clear bios-tables-test-allowed-diff.h
  tests/acpi: allow microvm test data updates.
  tests/acpi: allow override blkdev
  tests/acpi: add microvm test
  tests/acpi: update expected data files for microvm

 hw/i386/acpi-microvm.h                      |   8 +
 include/hw/acpi/generic_event_device.h      |  12 +
 include/hw/i386/microvm.h                   |  10 +-
 include/hw/i386/pc.h                        |   1 -
 include/hw/i386/x86.h                       |  11 +-
 tests/qtest/bios-tables-test-allowed-diff.h |  18 --
 hw/acpi/generic_event_device.c              |  52 ++++
 hw/arm/virt-acpi-build.c                    |   8 -
 hw/i386/acpi-build.c                        |   2 +-
 hw/i386/acpi-microvm.c                      | 234 ++++++++++++++++++
 hw/i386/generic_event_device_x86.c          |  36 +++
 hw/i386/microvm.c                           | 105 +++++++-
 hw/i386/pc.c                                | 260 ++------------------
 hw/i386/pc_piix.c                           |   2 +-
 hw/i386/pc_q35.c                            |   2 +-
 hw/i386/x86.c                               | 226 ++++++++++++++++-
 tests/qtest/bios-tables-test.c              |  21 +-
 hw/i386/Kconfig                             |   1 +
 hw/i386/Makefile.objs                       |   2 +
 pc-bios/bios-microvm.bin                    | Bin 65536 -> 131072 bytes
 pc-bios/qboot.rom                           | Bin 0 -> 65536 bytes
 roms/Makefile                               |  11 +-
 roms/config.seabios-microvm                 |  26 ++
 tests/data/acpi/microvm/APIC                | Bin 0 -> 70 bytes
 tests/data/acpi/microvm/DSDT                | Bin 0 -> 365 bytes
 tests/data/acpi/microvm/FACP                | Bin 0 -> 268 bytes
 26 files changed, 761 insertions(+), 287 deletions(-)
 create mode 100644 hw/i386/acpi-microvm.h
 create mode 100644 hw/i386/acpi-microvm.c
 create mode 100644 hw/i386/generic_event_device_x86.c
 create mode 100644 pc-bios/qboot.rom
 create mode 100644 roms/config.seabios-microvm
 create mode 100644 tests/data/acpi/microvm/APIC
 create mode 100644 tests/data/acpi/microvm/DSDT
 create mode 100644 tests/data/acpi/microvm/FACP

-- 
2.18.4


