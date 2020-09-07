Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD35C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7F221481
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXZqanpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7F221481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFYf-0002K1-7f
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kFFFf-00053l-3M
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:23:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45605
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kFFFd-0001Me-7z
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=02KBZaTJacBSG0oS7wzq+DaGaWd93uGEBZparbsDlng=;
 b=iXZqanpzJSptYRwKPlT/MtkHaXh6xrlMHykSNo9F9HzJpJ/9txJcH1ErtiabOFA6r9yR9s
 JlSlWxP3wo/ZWZE1Z3sSyLkfHt4hLIO7Vtgy0SBaNRLrjS3sKZhd9o3OPmTy9QiqV5Swyj
 mPWIC1Z9L80NGXKNSmdh1Nu3qLWNlIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-FizcrLZLMTOe2ToHKsrlbQ-1; Mon, 07 Sep 2020 07:23:52 -0400
X-MC-Unique: FizcrLZLMTOe2ToHKsrlbQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DC2F1084D67;
 Mon,  7 Sep 2020 11:23:51 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 230265D9D2;
 Mon,  7 Sep 2020 11:23:49 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/10] x86: fix cpu hotplug with secure boot
Date: Mon,  7 Sep 2020 07:23:38 -0400
Message-Id: <20200907112348.530921-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: boris.ostrovsky@oracle.com, lersek@redhat.com, aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v5:
  - fix hotplug on Windows when there is more than 256 possible CPUs
    (Windows isn't able to handle VarPackage over 255 elements
     so process CPUs in batches)
  - fix off-by-one in package length (Laszlo)
  - fix not selecting CPU before clearing insert event (Laszlo)
  - use aml_lgreater() instead of aml_lnot(aml_equal(num_added_cpus, zero) (Laszlo)
  - split 'x68: acpi: trigger SMI before sending hotplug Notify event to OSPM'
    in samller chunks (Laszlo)
  - fix comment to match spec (Laszlo)
  - reorder aml_lor() and aml_land() in header (Laszlo)
v4:
  - fix 5.2 machine types so they won't apply pc_compat_5_1 (Laszlo)
v3:
  - rebase on top of "[PATCH v2] hw: add compat machines for 5.2"
    so apply that before this patch
v2:
  - AML: clean is_inserted flag only after SMI callback
  - make x-smi-cpu-hotunplug false by default
  - massage error hint on not supported unplug
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

Igor Mammedov (10):
  x86: lpc9: let firmware negotiate 'CPU hotplug with SMI' features
  x86: cpuhp: prevent guest crash on CPU hotplug when broadcast SMI is
    in use
  x86: cpuhp: refuse cpu hot-unplug request earlier if not supported
  acpi: add aml_land() and aml_break() primitives
  tests: acpi: mark to be changed tables in
    bios-tables-test-allowed-diff
  x86: ich9: expose "smi_negotiated_features" as a QOM property
  x86: acpi: introduce AcpiPmInfo::smi_on_cpuhp
  x86: acpi: introduce the PCI0.SMI0 ACPI device
  x68: acpi: trigger SMI before sending hotplug Notify event to OSPM
  tests: acpi: update acpi blobs with new AML

 include/hw/acpi/aml-build.h       |   2 +
 include/hw/acpi/cpu.h             |   1 +
 include/hw/i386/ich9.h            |   4 +
 hw/acpi/aml-build.c               |  16 +++
 hw/acpi/cpu.c                     | 156 ++++++++++++++++++++++++------
 hw/acpi/ich9.c                    |  24 ++++-
 hw/i386/acpi-build.c              |  35 ++++++-
 hw/i386/pc.c                      |  15 ++-
 hw/isa/lpc_ich9.c                 |  16 +++
 tests/data/acpi/pc/DSDT           | Bin 4934 -> 5060 bytes
 tests/data/acpi/pc/DSDT.acpihmat  | Bin 6258 -> 6385 bytes
 tests/data/acpi/pc/DSDT.bridge    | Bin 6793 -> 6919 bytes
 tests/data/acpi/pc/DSDT.cphp      | Bin 5397 -> 5524 bytes
 tests/data/acpi/pc/DSDT.dimmpxm   | Bin 6587 -> 6714 bytes
 tests/data/acpi/pc/DSDT.ipmikcs   | Bin 5006 -> 5132 bytes
 tests/data/acpi/pc/DSDT.memhp     | Bin 6293 -> 6419 bytes
 tests/data/acpi/pc/DSDT.numamem   | Bin 4940 -> 5066 bytes
 tests/data/acpi/q35/DSDT          | Bin 7678 -> 7804 bytes
 tests/data/acpi/q35/DSDT.acpihmat | Bin 9002 -> 9129 bytes
 tests/data/acpi/q35/DSDT.bridge   | Bin 7695 -> 7821 bytes
 tests/data/acpi/q35/DSDT.cphp     | Bin 8141 -> 8268 bytes
 tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9331 -> 9458 bytes
 tests/data/acpi/q35/DSDT.ipmibt   | Bin 7753 -> 7879 bytes
 tests/data/acpi/q35/DSDT.memhp    | Bin 9037 -> 9163 bytes
 tests/data/acpi/q35/DSDT.mmio64   | Bin 8808 -> 8934 bytes
 tests/data/acpi/q35/DSDT.numamem  | Bin 7684 -> 7810 bytes
 tests/data/acpi/q35/DSDT.tis      | Bin 8283 -> 8409 bytes
 27 files changed, 239 insertions(+), 30 deletions(-)

-- 
2.27.0


