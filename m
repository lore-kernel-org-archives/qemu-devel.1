Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A532FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D31207F5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gfnpt/rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D31207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGMU-0007SK-Jd
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLD-0005eL-SX
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:04:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21527
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLC-0006bp-Bs
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590663889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G9fnODXhIfkd1pBOx+tDzWkpNrAiAfpmOba5VmPE3Y0=;
 b=Gfnpt/rbo+LQJLZYINdkuiGyU2jQzRMV6EeJrolpsSQX7AlBGsR95lyk/LT08effK6sC/o
 VNF7bKmmJVoqQFkwoQvCj3SDr6BN1+iKpXUFQJiyLmd7pNvY0D5JDsS/YyeGeGVZzeHsiI
 6l6uCyh2wim7lCvhelRFu28VolRbM08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-JIC5BkpdMS2DVXK0Xm1PvA-1; Thu, 28 May 2020 07:04:47 -0400
X-MC-Unique: JIC5BkpdMS2DVXK0Xm1PvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EF22107ACCA
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 11:04:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E7F75D9F3;
 Thu, 28 May 2020 11:04:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B161D113864A; Thu, 28 May 2020 13:04:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/24] Fixes around device realization
Date: Thu, 28 May 2020 13:04:20 +0200
Message-Id: <20200528110444.20456-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes a bunch of bugs I ran into while reworking how qdevs plug
into buses.

I instrumented the code a bit to flush out instances of bug patterns.
I posted these hacks separately as '[PATCH not-for-merge 0/5]
Instrumentation for "Fixes around device realization"'.  PATCH 2/5
since became "[PATCH 0/2] qom: Make "info qom-tree" show children
sorted".  It should be applied first.

v2:
* Rebased
* PATCH 01: Also fix MMIO addresses, with Alistair's help
* PATCH 04+05: Replaced by better patches from Cédric
* PATCH 01-03+06+08-11+18: Commit messages improved [Peter, Paolo]
* PATCH 08+09+18: Avoid qdev_init_nofail() [Peter]
* PATCH 22: Assertion simplified

Based-on: Message-Id: <20200527084754.7531-1-armbru@redhat.com>

Cédric Le Goater (2):
  arm/aspeed: Compute the number of CPUs from the SoC definition
  arm/aspeed: Rework NIC attachment

Markus Armbruster (22):
  arm/stm32f405: Fix realization of "stm32f2xx-adc" devices
  display/xlnx_dp: Fix to realize "i2c-ddc" and "aux-to-i2c-bridge"
  sd/pxa2xx_mmci: Fix to realize "pxa2xx-mmci" device
  armv7m: Delete unused "ARM,bitband-memory" devices
  auxbus: Fix aux-to-i2c-bridge to be a subtype of aux-slave
  mac_via: Fix to realize "mos6522-q800-via*" devices
  macio: Fix to realize "mos6522-cuda" and "mos6522-pmu" devices
  macio: Delete unused "macio-gpio" devices
  pnv/phb4: Delete unused "pnv-phb4-pec-stack" devices
  MAINTAINERS: Make section PowerNV cover pci-host/pnv* as well
  ppc4xx: Drop redundant device realization
  macio: Put "macio-nvram" device on the macio bus
  macio: Fix macio-bus to be a subtype of System bus
  ppc/pnv: Put "*-pnv-chip" and "pnv-xive" on the main system bus
  pnv/psi: Correct the pnv-psi* devices not to be sysbus devices
  display/sm501 display/ati: Fix to realize "i2c-ddc"
  riscv: Fix to put "riscv.hart_array" devices on sysbus
  riscv: Fix type of SiFive[EU]SocState, member parent_obj
  sparc/leon3: Fix to put grlib,* devices on sysbus
  qdev: Assert devices are plugged into a bus that can take them
  sd: Hide the qdev-but-not-quite thing created by sd_init()
  qdev: Assert onboard devices all get realized properly

 include/hw/arm/aspeed.h     |  6 ++++++
 include/hw/arm/aspeed_soc.h |  1 -
 include/hw/ppc/pnv_psi.h    |  2 +-
 include/hw/riscv/sifive_e.h |  2 +-
 include/hw/riscv/sifive_u.h |  2 +-
 hw/arm/armv7m.c             |  6 ++++--
 hw/arm/aspeed.c             | 42 ++++++++++++++++++++++++++++++++-----
 hw/arm/aspeed_ast2600.c     | 23 +++++++-------------
 hw/arm/aspeed_soc.c         | 12 ++---------
 hw/arm/stm32f405_soc.c      | 23 +++++++++++---------
 hw/core/qdev.c              | 19 +++++++++++++++++
 hw/display/ati.c            |  2 ++
 hw/display/sm501.c          |  2 ++
 hw/display/xlnx_dp.c        |  4 ++++
 hw/misc/auxbus.c            |  2 +-
 hw/misc/mac_via.c           |  5 +++++
 hw/misc/macio/cuda.c        | 10 ++++-----
 hw/misc/macio/macio.c       |  7 +++++--
 hw/misc/macio/pmu.c         | 10 ++++-----
 hw/pci-host/pnv_phb4_pec.c  |  3 +++
 hw/ppc/pnv.c                |  6 +++---
 hw/ppc/pnv_psi.c            |  2 +-
 hw/ppc/ppc440_uc.c          |  2 --
 hw/riscv/sifive_e.c         |  5 ++---
 hw/riscv/sifive_u.c         | 14 ++++++-------
 hw/riscv/spike.c            | 12 +++++------
 hw/riscv/virt.c             |  4 ++--
 hw/sd/pxa2xx_mmci.c         |  1 +
 hw/sd/sd.c                  | 40 ++++++++++++++++++++++++-----------
 hw/sparc/leon3.c            |  4 ++--
 MAINTAINERS                 |  2 ++
 31 files changed, 177 insertions(+), 98 deletions(-)

-- 
2.21.3


