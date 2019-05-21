Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1591DC04AAC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 03:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0BE2081C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 03:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0BE2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45843 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSvYs-0006rK-ST
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 23:35:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSvXA-0005qT-Vg
	for qemu-devel@nongnu.org; Mon, 20 May 2019 23:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSvX9-0004JT-AS
	for qemu-devel@nongnu.org; Mon, 20 May 2019 23:33:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:10740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hSvX6-0004IZ-6X; Mon, 20 May 2019 23:33:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	20 May 2019 20:33:42 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga005.fm.intel.com with ESMTP; 20 May 2019 20:33:40 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Tue, 21 May 2019 11:32:47 +0800
Message-Id: <20190521033249.1960-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.120
Subject: [Qemu-devel] [PATCH v5 0/2] Extract build_mcfg Part 2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, thuth@redhat.com,
	mst@redhat.com, shannon.zhaosl@gmail.com,
	Wei Yang <richardw.yang@linux.intel.com>, imammedo@redhat.com,
	philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch set tries to generalize MCFG table build process. Several patches
are already merged and these two are left for the following reasons:

  * conflict with latest upstream
  * ACPI_PCI dependency fix
  * missed reserved[8] in MCFG

v4->v5:
    * ACPI_PCI depends on both ACPI and PCI
    * rebase on latest master, adjust arm Kconfig
    * miss the reserved[8] of MCFG, add it back
    * make sure bios-tables-test all OK

Wei Yang (2):
  hw/acpi: Consolidate build_mcfg to pci.c
  acpi: pci: use build_append_foo() API to construct MCFG

 default-configs/i386-softmmu.mak |  1 +
 hw/acpi/Kconfig                  |  4 +++
 hw/acpi/Makefile.objs            |  1 +
 hw/acpi/pci.c                    | 57 ++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                   |  1 +
 hw/arm/virt-acpi-build.c         | 17 ----------
 hw/i386/acpi-build.c             | 18 +---------
 include/hw/acpi/acpi-defs.h      | 18 ----------
 include/hw/acpi/pci.h            |  1 +
 9 files changed, 66 insertions(+), 52 deletions(-)
 create mode 100644 hw/acpi/pci.c

-- 
2.19.1


