Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189D4C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76202073B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JzIFYa+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76202073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxv1-0006Z2-Vx
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVxr3-0000MB-FM
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:43:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30795
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVxr1-0003UE-6Z
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588686202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iiDcpoOPpycpmnGxWEJTnsyvT5zsTLqx1JuKCZs1PJk=;
 b=JzIFYa+4/W0dLAuPmtHszNAYRDMSFv2apUAse0ZZGjlUTHJeIoujYdGGVuc4FFHDUXq+Kr
 S8elyngL7H9YcRbjD49YfzdK4FRFLL1O8rwOvKNMhZZho81rEPoB238Ql1q1GAe+1ZulKe
 F79SlGV1SxD5Zns95J0Jm0nMBU5Pquo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-L6gnmzt3Ox6Op5-pzHTqPQ-1; Tue, 05 May 2020 09:43:16 -0400
X-MC-Unique: L6gnmzt3Ox6Op5-pzHTqPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EBEB8014D9;
 Tue,  5 May 2020 13:43:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1DE462482;
 Tue,  5 May 2020 13:43:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B6CB617510; Tue,  5 May 2020 15:43:05 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/13] microvm: add acpi support
Date: Tue,  5 May 2020 15:42:52 +0200
Message-Id: <20200505134305.22666-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

cheers,
  Gerd

Gerd Hoffmann (13):
  acpi: make build_madt() more generic.
  acpi: create acpi-common.c and move madt code
  acpi: madt: skip pci override on pci-less systems (microvm)
  acpi: move acpi_build_facs to acpi-common.c
  acpi: move acpi_init_common_fadt_data to acpi-common.c
  acpi: move acpi_align_size to acpi-common.h
  acpi: fadt: add hw-reduced sleep register support
  acpi: generic event device for x86
  microvm: add minimal acpi support
  microvm: disable virtio-mmio cmdline hack
  microvm: add acpi_dsdt_add_virtio() for x86
  microvm: make virtio irq base runtime configurable
  microvm/acpi: use GSI 16-23 for virtio

 hw/i386/acpi-common.h                  |  38 ++++
 hw/i386/acpi-microvm.h                 |   6 +
 include/hw/acpi/acpi-defs.h            |   2 +
 include/hw/acpi/generic_event_device.h |  10 +
 include/hw/i386/microvm.h              |  10 +-
 hw/acpi/aml-build.c                    |   4 +-
 hw/i386/acpi-build.c                   | 198 +-------------------
 hw/i386/acpi-common.c                  | 206 ++++++++++++++++++++
 hw/i386/acpi-microvm.c                 | 249 +++++++++++++++++++++++++
 hw/i386/generic_event_device_x86.c     | 114 +++++++++++
 hw/i386/microvm.c                      |  36 +++-
 hw/i386/Kconfig                        |   1 +
 hw/i386/Makefile.objs                  |   3 +
 13 files changed, 676 insertions(+), 201 deletions(-)
 create mode 100644 hw/i386/acpi-common.h
 create mode 100644 hw/i386/acpi-microvm.h
 create mode 100644 hw/i386/acpi-common.c
 create mode 100644 hw/i386/acpi-microvm.c
 create mode 100644 hw/i386/generic_event_device_x86.c

-- 
2.18.4


