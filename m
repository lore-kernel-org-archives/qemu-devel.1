Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F46C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32312388A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OulCNFy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32312388A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLLGf-0001gh-Ip
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1kLLF3-0000Sk-VU
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1kLLF0-0005Fs-Sy
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600930829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OePFhgP2Mcl7EMBnbjpU5wk7SybG4r5geBIxT4JRBzQ=;
 b=OulCNFy7h2b9v9DSRdjfHaymQ7aFcUAYlaDXsYx0c7MQYPvIlT/2cJ641MGhViTqk4qs77
 8Noz5rIwmdtZtiU34ROlLD2tFRlHK3Rp6O7zDJr6SZocjjX0lgmWu1F+emflTtg64Cb/xP
 qV6cXuZe88vK7P9ytCCY1PkEOcpZ1hc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-tFHpSZYWOLGxHwyJjE_wPA-1; Thu, 24 Sep 2020 03:00:26 -0400
X-MC-Unique: tFHpSZYWOLGxHwyJjE_wPA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A785281F002;
 Thu, 24 Sep 2020 07:00:25 +0000 (UTC)
Received: from pc-72.home.com (unknown [10.40.194.10])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74D8373694;
 Thu, 24 Sep 2020 07:00:17 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 0/7] Use ACPI PCI hot-plug for Q35
Date: Thu, 24 Sep 2020 09:00:06 +0200
Message-Id: <20200924070013.165026-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jusual@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jusual@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch set consists of two parts:
patches 1-4: introduce new feature
             'acpi-pci-hotplug-with-bridge-support' on Q35
patches 5-7: make the feature default along with changes in ACPI tables

This way maintainers can decide which way to choose without breaking
the patch set.

With the feature disabled Q35 falls back to the native hot-plug.

Pros
    * no racy behavior during boot (see 110c477c2ed)
    * eject is possible - according to PCIe spec, attention button
      press should lead to power off, and then the adapter should be
      removed manually. As there is no power down state exists in QEMU,
      we cannot distinguish between an eject and a power down
      request.
    * no delay during deleting - after the actual power off software
      must wait at least 1 second before indicating about it. This case
      is quite important for users, it even has its own bug:
          https://bugzilla.redhat.com/show_bug.cgi?id=1594168
    * no timer-based behavior - in addition to the previous example,
      the attention button has a 5-second waiting period, during which
      the operation can be canceled with a second press. While this
      looks fine for manual button control, automation will result in
      the need to queue or drop events, and the software receiving
      events in all sort of unspecified combinations of attention/power
      indicator states, which is racy and uppredictable.
    * fixes:
        * https://bugzilla.redhat.com/show_bug.cgi?id=1752465
        * https://bugzilla.redhat.com/show_bug.cgi?id=1690256

Cons:
    * lose per-port control over hot-plug (can be resolved)
    * no access to possible features presented in slot capabilities
      (this is only surprise removal AFAIK)

v3:
    * drop change of _OSC to allow SHPC on hotplugged bridges
    * use 'acpi-root-pci-hotplug'
    * add migration states [Igor]
    * minor style changes

v2:
    * new ioport range for acpiphp [Gerd]
    * drop find_pci_host() [Igor]
    * explain magic numbers in _OSC [Igor]
    * drop build_q35_pci_hotplug() wrapper [Igor]

Julia Suvorova (7):
  hw/acpi/pcihp: Enhance acpi_pcihp_disable_root_bus() to support Q35
  hw/i386/acpi-build: Add ACPI PCI hot-plug methods to Q35
  hw/pci/pcie: Do not initialize slot capability if acpihp is used
  hw/acpi/ich9: Enable ACPI PCI hot-plug
  bios-tables-test: Allow changes in DSDT ACPI tables
  hw/acpi/ich9: Set ACPI PCI hot-plug as default
  bios-tables-test: Update golden binaries

 hw/i386/acpi-build.h              |   7 ++++
 include/hw/acpi/ich9.h            |   5 +++
 include/hw/acpi/pcihp.h           |   3 +-
 hw/acpi/ich9.c                    |  67 ++++++++++++++++++++++++++++++
 hw/acpi/pcihp.c                   |  16 ++++---
 hw/acpi/piix4.c                   |   4 +-
 hw/i386/acpi-build.c              |  31 ++++++++------
 hw/i386/pc.c                      |   1 +
 hw/pci/pcie.c                     |  16 +++++++
 tests/data/acpi/q35/DSDT          | Bin 7678 -> 7950 bytes
 tests/data/acpi/q35/DSDT.acpihmat | Bin 9002 -> 9274 bytes
 tests/data/acpi/q35/DSDT.bridge   | Bin 7695 -> 9865 bytes
 tests/data/acpi/q35/DSDT.cphp     | Bin 8141 -> 8413 bytes
 tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9331 -> 9603 bytes
 tests/data/acpi/q35/DSDT.ipmibt   | Bin 7753 -> 8025 bytes
 tests/data/acpi/q35/DSDT.memhp    | Bin 9037 -> 9309 bytes
 tests/data/acpi/q35/DSDT.mmio64   | Bin 8808 -> 9080 bytes
 tests/data/acpi/q35/DSDT.numamem  | Bin 7684 -> 7956 bytes
 tests/data/acpi/q35/DSDT.tis      | Bin 8283 -> 8555 bytes
 19 files changed, 129 insertions(+), 21 deletions(-)

-- 
2.25.4


