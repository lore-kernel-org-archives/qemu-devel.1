Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863EEC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204D8221F0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yc5B8ADL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204D8221F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFcgO-0005N4-45
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kFcTW-0001lq-CS
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:11:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30491
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kFcT0-0005iQ-Qz
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599567078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zOAENY3Xkyfv6TJ9i8uk0PyEiJmhbMa5sHpPRXJH5Pk=;
 b=Yc5B8ADLAWiKd/q/LdinsUSy4HW2t9DiDzjBWqpsYGXPLfFbgXpZ+ZGw0XrzjV1hVw2xX5
 Nak6OO5bpDynDl4h+xMaxJrUuB34fuxEJPz3YAtf+iYJG6BH7f1RHCuU3wqVDQxXSq2F5G
 7LopHABk/2XFD6DpSVkLPRhv/y16Qtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-y01QzgjKMhmPoz1Kjkjtog-1; Tue, 08 Sep 2020 08:11:04 -0400
X-MC-Unique: y01QzgjKMhmPoz1Kjkjtog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03A2280EF9E;
 Tue,  8 Sep 2020 12:11:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79B1B60C84;
 Tue,  8 Sep 2020 12:10:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6AEEA17538; Tue,  8 Sep 2020 14:10:50 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 00/21] microvm: add acpi support
Date: Tue,  8 Sep 2020 14:10:29 +0200
Message-Id: <20200908121050.1162-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I know that not supporting ACPI in microvm is intentional.  If you still=0D
don't want ACPI this is perfectly fine, you can use the usual -no-acpi=0D
switch to toggle ACPI support.=0D
=0D
These are the advantages you are going to loose then:=0D
=0D
  (1) virtio-mmio device discovery without command line hacks (tweaking=0D
      the command line is a problem when not using direct kernel boot).=0D
  (2) Better IO-APIC support, we can use IRQ lines 16-23.=0D
  (3) ACPI power button (aka powerdown request) works.=0D
  (4) machine poweroff (aka S5 state) works.=0D
=0D
Together with seabios patches for virtio-mmio support this allows to=0D
boot standard fedora images (cloud, coreos, workstation live) with the=0D
microvm machine type.=0D
=0D
git branch for testing (including updated seabios):=0D
=09https://git.kraxel.org/cgit/qemu/log/?h=3Dsirius/microvm=0D
=0D
changes in v2:=0D
  * some acpi cleanups are an separate patch series now.=0D
  * switched to hw reduced acpi & generic event device.=0D
  * misc fixes here and there.=0D
=0D
changes in v3:=0D
  * depeds on "[PATCH v6 00/16] acpi: i386 tweaks" series.=0D
  * renamed qboot to qboot.bin=0D
  * updated seabios to master branch snapshot.=0D
    - this version boots fine with rtc=3Doff=0D
  * generic event device tweaks (Igor's comments).=0D
  * make SMP work.=0D
  * add RfC patches to turn off acpi by default for microvm.=0D
  * misc fixes here and there.=0D
=0D
changes in v4:=0D
  * rebase to latest master=0D
    - this also depends on the pending seabios update=0D
  * drop some patches which got cherry-picked.=0D
  * wire up cpu hotplug (also does coldplug cpu init).=0D
  * add microvm acpi test case.=0D
  * dropped RfC patches to turn off acpi by default for microvm.=0D
  * misc fixes here and there.=0D
=0D
changes in v5:=0D
  * rebase to latest master (seabios dependency is merged meanwhile)=0D
  * fix DSDT version (mst).=0D
  * add comments referencing the ACPI spec for easier review (mst).=0D
=0D
changes in v6:=0D
  * rebase to latest master, adapt to meson build system.=0D
  * pick up some review tags.=0D
  * misc fixes here and there.=0D
=0D
changes in v7:=0D
  * rebase to latest master, adapt to x86 cpu hotplug changes.=0D
  * meson tweaks for firmware binaries.=0D
  * pick up some review tags.=0D
=0D
take care,=0D
  Gerd=0D
=0D
Gerd Hoffmann (21):=0D
  microvm: name qboot binary qboot.rom=0D
  seabios: add microvm config, update build rules=0D
  seabios: add bios-microvm.bin binary=0D
  acpi: ged: add control regs=0D
  acpi: ged: add x86 device variant.=0D
  acpi: move acpi_dsdt_add_power_button() to ged=0D
  microvm: make virtio irq base runtime configurable=0D
  microvm/acpi: add minimal acpi support=0D
  microvm/acpi: add acpi_dsdt_add_virtio() for x86=0D
  microvm/acpi: use GSI 16-23 for virtio=0D
  microvm/acpi: use seabios with acpi=3Don=0D
  microvm/acpi: disable virtio-mmio cmdline hack=0D
  x86: constify x86_machine_is_*_enabled=0D
  x86: move acpi_dev from pc/microvm=0D
  x86: move cpu hotplug from pc to x86=0D
  microvm: wire up hotplug=0D
  tests/acpi: allow microvm test data updates.=0D
  tests/acpi: allow override blkdev=0D
  tests/acpi: add microvm test=0D
  tests/acpi: update expected data files for microvm=0D
  microvm: enable ramfb=0D
=0D
 hw/i386/acpi-microvm.h                 |   8 +=0D
 include/hw/acpi/generic_event_device.h |  17 ++=0D
 include/hw/i386/microvm.h              |  10 +-=0D
 include/hw/i386/pc.h                   |   1 -=0D
 include/hw/i386/x86.h                  |  15 +-=0D
 hw/acpi/generic_event_device.c         |  52 +++++=0D
 hw/arm/virt-acpi-build.c               |   8 -=0D
 hw/i386/acpi-build.c                   |   2 +-=0D
 hw/i386/acpi-microvm.c                 | 240 ++++++++++++++++++++=0D
 hw/i386/generic_event_device_x86.c     |  36 +++=0D
 hw/i386/microvm.c                      | 108 ++++++++-=0D
 hw/i386/pc.c                           | 297 ++-----------------------=0D
 hw/i386/pc_piix.c                      |   2 +-=0D
 hw/i386/pc_q35.c                       |   2 +-=0D
 hw/i386/x86.c                          | 275 ++++++++++++++++++++++-=0D
 tests/qtest/bios-tables-test.c         |  21 +-=0D
 hw/i386/Kconfig                        |   1 +=0D
 hw/i386/meson.build                    |   3 +-=0D
 pc-bios/bios-microvm.bin               | Bin 65536 -> 131072 bytes=0D
 pc-bios/meson.build                    |   1 +=0D
 pc-bios/qboot.rom                      | Bin 0 -> 65536 bytes=0D
 roms/Makefile                          |  11 +-=0D
 roms/config.seabios-microvm            |  26 +++=0D
 tests/data/acpi/microvm/APIC           | Bin 0 -> 70 bytes=0D
 tests/data/acpi/microvm/DSDT           | Bin 0 -> 365 bytes=0D
 tests/data/acpi/microvm/FACP           | Bin 0 -> 268 bytes=0D
 26 files changed, 823 insertions(+), 313 deletions(-)=0D
 create mode 100644 hw/i386/acpi-microvm.h=0D
 create mode 100644 hw/i386/acpi-microvm.c=0D
 create mode 100644 hw/i386/generic_event_device_x86.c=0D
 create mode 100644 pc-bios/qboot.rom=0D
 create mode 100644 roms/config.seabios-microvm=0D
 create mode 100644 tests/data/acpi/microvm/APIC=0D
 create mode 100644 tests/data/acpi/microvm/DSDT=0D
 create mode 100644 tests/data/acpi/microvm/FACP=0D
=0D
--=20=0D
2.27.0=0D
=0D


