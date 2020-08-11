Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55299C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DA02075D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZFqCUTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DA02075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Si2-0001pf-6s
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 07:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1k5ShG-0000qi-Os
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 07:44:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51578
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1k5ShD-0008GX-RB
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 07:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597146238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5uz2gYR+ZjhCwSBG2btx3/PoRpLKwa9fy3oUhJjbpq4=;
 b=QZFqCUTi8Ih1UL1l0CMgvbMoGWO8GdtBL5ekiZI+pjTuZqGX+DAXOlr4uDjVDzO/Oj9M5W
 CeVZslhcrgP73xO6JE8ibNN0x0OSKuAWYooyJDjspQw8uPw4h6DhuhyUyONpXu7t7YgqxZ
 2HdaBtdrmE1f9s5ocP9j9aA6Ysb2ZtE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-fWp5YmqqOAGF-vRn8GpU8Q-1; Tue, 11 Aug 2020 07:43:46 -0400
X-MC-Unique: fWp5YmqqOAGF-vRn8GpU8Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C23B71005510;
 Tue, 11 Aug 2020 11:43:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.74.8.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4DCB5F9DB;
 Tue, 11 Aug 2020 11:43:36 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 0/9] memory: assert and define MemoryRegionOps callbacks
Date: Tue, 11 Aug 2020 17:11:24 +0530
Message-Id: <20200811114133.672647-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 04:41:55
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Hello,

* This series asserts that MemoryRegionOps objects define read/write
  callback methods. Thus avoids potential NULL pointer dereference.
  ex. -> https://git.qemu.org/?p=qemu.git;a=commit;h=bb15013ef34617eb1344f5276292cadd326c21b2

* Also adds various undefined MemoryRegionOps read/write functions
  to avoid potential assert failure.

Thank you.
--
Prasad J Pandit (9):
  hw/pci-host: add pci-intack write method
  pci-host: designware: add pcie-msi read method
  vfio: add quirk device write method
  prep: add ppc-parity write method
  nvram: add nrf51_soc flash read method
  spapr_pci: add spapr msi read method
  tz-ppc: add dummy read/write methods
  imx7-ccm: add digprog mmio write method
  memory: assert MemoryRegionOps callbacks are defined

 hw/misc/imx7_ccm.c       |  8 ++++++++
 hw/misc/tz-ppc.c         | 14 ++++++++++++++
 hw/nvram/nrf51_nvm.c     | 10 ++++++++++
 hw/pci-host/designware.c | 19 +++++++++++++++++++
 hw/pci-host/prep.c       |  8 ++++++++
 hw/ppc/prep_systemio.c   |  8 ++++++++
 hw/ppc/spapr_pci.c       | 14 ++++++++++++--
 hw/vfio/pci-quirks.c     |  8 ++++++++
 softmmu/memory.c         | 10 +++++++++-
 9 files changed, 96 insertions(+), 3 deletions(-)

--
2.26.2


