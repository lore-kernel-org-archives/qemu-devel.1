Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456E9C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00CE20738
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cddz+sPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00CE20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBAJ-0004va-63
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kIB68-0000ku-NX
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:34:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46370
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kIB66-0002rr-3I
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600176852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=joNyanOsOrqa3ty/0Zba82Cm0lWL+3jrmLmh9Y6dipA=;
 b=cddz+sPk4zRhCCZgYUCAywZBweCJML2wqqANSOcgL9JeVBr9KXI55sHGLqXuPWp2RhzZnL
 CmpKzUePBz0FOT98RnagrfgX7ekHgatgyUN3i2IBH7Xc2hxbgKlS1p5X4cV7ooVSE/nn2M
 EcSmRDReNXYRThFjnU/gjdpZY/Lt3m4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-MCtmk2KbPcKGqXeoTRC1rg-1; Tue, 15 Sep 2020 09:34:06 -0400
X-MC-Unique: MCtmk2KbPcKGqXeoTRC1rg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2632425EA;
 Tue, 15 Sep 2020 13:34:04 +0000 (UTC)
Received: from kaapi (ovpn-116-229.sin2.redhat.com [10.67.116.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 498425F704;
 Tue, 15 Sep 2020 13:33:56 +0000 (UTC)
Date: Tue, 15 Sep 2020 19:03:54 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Peter Maydell <peter.maydell@linaro.org>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>
Subject: Re: [PATCH v4 0/9] memory: assert and define MemoryRegionOps callbacks
In-Reply-To: <20200811114133.672647-1-ppandit@redhat.com>
Message-ID: <nycvar.YSQ.7.78.906.2009151842200.10832@xnncv>
References: <20200811114133.672647-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:11:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Li Qiang <liq3ea@gmail.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Tue, 11 Aug 2020, P J P wrote --+
| * This series asserts that MemoryRegionOps objects define read/write
|   callback methods. Thus avoids potential NULL pointer dereference.
|   ex. -> https://git.qemu.org/?p=qemu.git;a=commit;h=bb15013ef34617eb1344f5276292cadd326c21b2
| 
| * Also adds various undefined MemoryRegionOps read/write functions
|   to avoid potential assert failure.
| 
| Thank you.
| --
| Prasad J Pandit (9):
|   hw/pci-host: add pci-intack write method
|   pci-host: designware: add pcie-msi read method
|   vfio: add quirk device write method
|   prep: add ppc-parity write method
|   nvram: add nrf51_soc flash read method
|   spapr_pci: add spapr msi read method
|   tz-ppc: add dummy read/write methods
|   imx7-ccm: add digprog mmio write method
|   memory: assert MemoryRegionOps callbacks are defined
| 
|  hw/misc/imx7_ccm.c       |  8 ++++++++
|  hw/misc/tz-ppc.c         | 14 ++++++++++++++
|  hw/nvram/nrf51_nvm.c     | 10 ++++++++++
|  hw/pci-host/designware.c | 19 +++++++++++++++++++
|  hw/pci-host/prep.c       |  8 ++++++++
|  hw/ppc/prep_systemio.c   |  8 ++++++++
|  hw/ppc/spapr_pci.c       | 14 ++++++++++++--
|  hw/vfio/pci-quirks.c     |  8 ++++++++
|  softmmu/memory.c         | 10 +++++++++-
|  9 files changed, 96 insertions(+), 3 deletions(-)

Ping...@Peter, @David, @Paolo, @Herve, @Alex,

* This patch series is not pulled/merged yet, could you please help with it?  
  (Pinging respective maintainers, as didn't get reply for last pings, not
   sure how to go about it.)


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


