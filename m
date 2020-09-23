Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE350C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C8920725
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5C3fqS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C8920725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1Nw-0007un-2Y
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kL1Mf-0006W4-Ut
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:47:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kL1Me-0007Tj-0A
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600854423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j9zapMMKQlL5U5Lk6oXiZXFCrZHzBfJWubBAJlublpk=;
 b=K5C3fqS9ik+yBKku1uEqYZFJMwRotE1dQn1KusvNeRKXVUVvMzw3Z+VsnnFbQsK2JI8l/W
 bMaABIw+WGQbf4iInpoEmATWvWArCFfnIO4iON21NOFRH6vCuW5skicsuROA/ptWDcwBME
 ZuyFHGS8oQBxWx0rlusloZqp9WM5Vjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-dhsJ7qcWNxyK0QEqhqKCZQ-1; Wed, 23 Sep 2020 05:47:01 -0400
X-MC-Unique: dhsJ7qcWNxyK0QEqhqKCZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C3C32FD0A;
 Wed, 23 Sep 2020 09:47:00 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BEA655778;
 Wed, 23 Sep 2020 09:46:51 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 00/11] x86: fix cpu hotplug with secure boot
Date: Wed, 23 Sep 2020 05:46:39 -0400
Message-Id: <20200923094650.1301166-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: lersek@redhat.com, ankur.a.arora@oracle.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v6:
  - [9/10] Add comment explaining why while_ctx2 restarts from the last processed CPU.
  - rebase on top of current master, due to non trivial conflict
    caused by microvm series, which moved/renamed pc_cpu_pre_plug()
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

Igor Mammedov (11):
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
  smp: drop support for deprecated (invalid topologies)

 include/hw/acpi/aml-build.h       |   2 +
 include/hw/acpi/cpu.h             |   1 +
 include/hw/i386/ich9.h            |   4 +
 docs/system/deprecated.rst        |  26 ++---
 hw/acpi/aml-build.c               |  16 +++
 hw/acpi/cpu.c                     | 165 +++++++++++++++++++++++++-----
 hw/acpi/ich9.c                    |  24 ++++-
 hw/core/machine.c                 |  16 +--
 hw/i386/acpi-build.c              |  35 ++++++-
 hw/i386/pc.c                      |  20 ++--
 hw/i386/x86.c                     |  11 ++
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
 30 files changed, 269 insertions(+), 67 deletions(-)

-- 
2.27.0


