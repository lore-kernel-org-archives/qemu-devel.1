Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D331AC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9DC20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+zUnAvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9DC20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxWdU-000669-RZ
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jxWag-00014A-1i
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:16:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41343
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jxWad-0002lK-P3
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595254580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kWWO+U0Yl6qXOS0dWUgXX4dXP2t813TqnyG/SIMCbeg=;
 b=G+zUnAvEdSOWaN1rVKM+P8PlyeFEfWHxQIiryayHzXs1+lev7DTHltbRCR14/Zj9lsdSe/
 GyY6Q14pk6Z13c2GMrzOq0fF6C15c3df0gfP2trLnfHSCXAPhYvnF+jLKOASL/s+XbUHw1
 wvJ4rM8dLuUxXRjYD4odLEgpkhHLq3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-hUybhgO9Me-vVzTI3-fpag-1; Mon, 20 Jul 2020 10:16:17 -0400
X-MC-Unique: hUybhgO9Me-vVzTI3-fpag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 125D4106B1CA;
 Mon, 20 Jul 2020 14:16:13 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39C3E2E021;
 Mon, 20 Jul 2020 14:16:12 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] x86: fix cpu hotplug with secure boot
Date: Mon, 20 Jul 2020 10:16:04 -0400
Message-Id: <20200720141610.574308-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 21:45:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: boris.ostrovsky@oracle.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1:
  - fix typos and some phrases (Laszlo)
  - add unplug check (Laszlo)
  - redo AML scan logic to avoid race when adding multiple CPUs

CPU hotplug with Secure Boot was not really supported and firmware wasn't aware
of hotplugged CPUs (which might lead to guest crashes). During 4.2 we introduced
locked SMI handler RAM arrea to make sure that guest OS wasn't able to inject
its own SMI handler and OVMF added initial CPU hotplug support.

This series is QEMU part of that support which lets QMVF tell QEMU that
CPU hotplug with SMI broadcast enabled is supported so that QEMU would be able
to prevent hotplug in case it's not supported and trigger SMI on hotplug when
it's necessary. 


Igor Mammedov (6):
  x86: lpc9: let firmware negotiate 'CPU hotplug with SMI' features
  x86: cphp: prevent guest crash on CPU hotplug when broadcast SMI is in
    use
  x86: cpuhp: refuse cpu hot-unplug request earlier if not supported
  tests: acpi: mark to be changed tables in
    bios-tables-test-allowed-diff
  x68: acpi: trigger SMI before scanning for hotplugged CPUs
  tests: acpi: update acpi blobs with new AML

 include/hw/acpi/cpu.h             |   1 +
 include/hw/i386/ich9.h            |   4 +++
 hw/acpi/cpu.c                     |  50 ++++++++++++++++++++++++++++--
 hw/acpi/ich9.c                    |  23 +++++++++++++-
 hw/i386/acpi-build.c              |  35 ++++++++++++++++++++-
 hw/i386/pc.c                      |  16 +++++++++-
 hw/isa/lpc_ich9.c                 |  15 +++++++++
 tests/data/acpi/pc/DSDT           | Bin 4934 -> 4973 bytes
 tests/data/acpi/pc/DSDT.acpihmat  | Bin 6258 -> 6297 bytes
 tests/data/acpi/pc/DSDT.bridge    | Bin 6793 -> 6832 bytes
 tests/data/acpi/pc/DSDT.cphp      | Bin 5397 -> 5436 bytes
 tests/data/acpi/pc/DSDT.dimmpxm   | Bin 6587 -> 6626 bytes
 tests/data/acpi/pc/DSDT.ipmikcs   | Bin 5006 -> 5045 bytes
 tests/data/acpi/pc/DSDT.memhp     | Bin 6293 -> 6332 bytes
 tests/data/acpi/pc/DSDT.numamem   | Bin 4940 -> 4979 bytes
 tests/data/acpi/q35/DSDT          | Bin 7678 -> 7717 bytes
 tests/data/acpi/q35/DSDT.acpihmat | Bin 9002 -> 9041 bytes
 tests/data/acpi/q35/DSDT.bridge   | Bin 7695 -> 7734 bytes
 tests/data/acpi/q35/DSDT.cphp     | Bin 8141 -> 8180 bytes
 tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9331 -> 9370 bytes
 tests/data/acpi/q35/DSDT.ipmibt   | Bin 7753 -> 7792 bytes
 tests/data/acpi/q35/DSDT.memhp    | Bin 9037 -> 9076 bytes
 tests/data/acpi/q35/DSDT.mmio64   | Bin 8808 -> 8847 bytes
 tests/data/acpi/q35/DSDT.numamem  | Bin 7684 -> 7723 bytes
 tests/data/acpi/q35/DSDT.tis      | Bin 8283 -> 8322 bytes
 25 files changed, 139 insertions(+), 5 deletions(-)

-- 
2.26.2


