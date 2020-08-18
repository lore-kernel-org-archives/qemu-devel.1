Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE44C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 12:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226892076D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 12:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWYk4p8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226892076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k80eu-0007sS-8I
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 08:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k80dA-0005EN-Fd
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 08:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k80d6-0001tF-Gg
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 08:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597753335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wuo+w9HLZnUfF0Vri857GODNHkMpKFttpZOAmECtliM=;
 b=ZWYk4p8fVp6Jg1RjxrH3sFWFaWu/2e5vG0LI9GfnbY3Zddwulw2WiH3pwKFOYB2GTbMgaN
 the7P22Cy0OM9idbrqkNKRzuD6w5B3Wx1qUjGclNgA20x9Kscsg8PtK20jALbrOUT9xNMQ
 JivdG7cd1jK6C170cVVnJLJnKE5m9JY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-C1UTmB4uMI-rTHNDCLaTlQ-1; Tue, 18 Aug 2020 08:22:13 -0400
X-MC-Unique: C1UTmB4uMI-rTHNDCLaTlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B8BD80732F;
 Tue, 18 Aug 2020 12:22:12 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 075025C641;
 Tue, 18 Aug 2020 12:22:10 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] x86: fix cpu hotplug with secure boot
Date: Tue, 18 Aug 2020 08:22:01 -0400
Message-Id: <20200818122208.1243901-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


Igor Mammedov (7):
  x86: lpc9: let firmware negotiate 'CPU hotplug with SMI' features
  x86: cphp: prevent guest crash on CPU hotplug when broadcast SMI is in
    use
  x86: cpuhp: refuse cpu hot-unplug request earlier if not supported
  acpi: add aml_land() and aml_break() primitives
  tests: acpi: mark to be changed tables in
    bios-tables-test-allowed-diff
  x68: acpi: trigger SMI before sending hotplug Notify event to OSPM
  tests: acpi: update acpi blobs with new AML

 include/hw/acpi/aml-build.h       |   2 +
 include/hw/acpi/cpu.h             |   1 +
 include/hw/i386/ich9.h            |   4 ++
 include/hw/i386/pc.h              |   3 ++
 hw/acpi/aml-build.c               |  16 ++++++
 hw/acpi/cpu.c                     |  80 ++++++++++++++++++++++++++++--
 hw/acpi/ich9.c                    |  24 ++++++++-
 hw/i386/acpi-build.c              |  35 ++++++++++++-
 hw/i386/pc.c                      |  17 ++++++-
 hw/i386/pc_piix.c                 |   1 +
 hw/i386/pc_q35.c                  |   1 +
 hw/isa/lpc_ich9.c                 |  16 ++++++
 tests/data/acpi/pc/DSDT           | Bin 4934 -> 5009 bytes
 tests/data/acpi/pc/DSDT.acpihmat  | Bin 6258 -> 6334 bytes
 tests/data/acpi/pc/DSDT.bridge    | Bin 6793 -> 6868 bytes
 tests/data/acpi/pc/DSDT.cphp      | Bin 5397 -> 5473 bytes
 tests/data/acpi/pc/DSDT.dimmpxm   | Bin 6587 -> 6663 bytes
 tests/data/acpi/pc/DSDT.ipmikcs   | Bin 5006 -> 5081 bytes
 tests/data/acpi/pc/DSDT.memhp     | Bin 6293 -> 6368 bytes
 tests/data/acpi/pc/DSDT.numamem   | Bin 4940 -> 5015 bytes
 tests/data/acpi/q35/DSDT          | Bin 7678 -> 7753 bytes
 tests/data/acpi/q35/DSDT.acpihmat | Bin 9002 -> 9078 bytes
 tests/data/acpi/q35/DSDT.bridge   | Bin 7695 -> 7770 bytes
 tests/data/acpi/q35/DSDT.cphp     | Bin 8141 -> 8217 bytes
 tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9331 -> 9407 bytes
 tests/data/acpi/q35/DSDT.ipmibt   | Bin 7753 -> 7828 bytes
 tests/data/acpi/q35/DSDT.memhp    | Bin 9037 -> 9112 bytes
 tests/data/acpi/q35/DSDT.mmio64   | Bin 8808 -> 8883 bytes
 tests/data/acpi/q35/DSDT.numamem  | Bin 7684 -> 7759 bytes
 tests/data/acpi/q35/DSDT.tis      | Bin 8283 -> 8358 bytes
 30 files changed, 192 insertions(+), 8 deletions(-)

-- 
2.26.2


