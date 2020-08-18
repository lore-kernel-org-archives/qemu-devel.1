Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97440C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6628920709
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMxOakTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6628920709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k89ak-0002n3-Iw
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 17:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1k89ZU-00018U-2h
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 17:55:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25959
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1k89ZR-0007fV-UW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 17:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597787703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qLLQXtaXRbT1qps1CfEUDptEEVRC30jtIOlMpqJninM=;
 b=eMxOakTq/dtrw2ADKfSZG7g1Glf280zPeYqPuJ46itFYWDmENnKi9y3Fqa+IAuVo38fZFy
 Dkw+DzBj3gCuLIg/uAz24QEaiqmFxVDbG0eKQAc0F579GSMlRupteT2IEnkNKoSQHbEbbl
 hoHO9iq0QEr+FXRCO+AWanrENivyTIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-Kj4yYr5jM52vSxQUmQNJeQ-1; Tue, 18 Aug 2020 17:54:59 -0400
X-MC-Unique: Kj4yYr5jM52vSxQUmQNJeQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F4229425CC;
 Tue, 18 Aug 2020 21:54:58 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.2.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B73A10027AB;
 Tue, 18 Aug 2020 21:54:48 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 0/4] Use ACPI PCI hot-plug for q35
Date: Tue, 18 Aug 2020 23:52:23 +0200
Message-Id: <20200818215227.181654-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jusual@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jusual@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 17:55:03
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
Cc: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PCIe native hot-plug has numerous problems with racing events and unpredictable
guest behaviour (Windows). Switching to ACPI hot-plug for now.

Tested on RHEL 8 and Windows 2019.
pxb-pcie is not yet supported.

v2:
    * new ioport range for acpiphp [Gerd]
    * drop find_pci_host() [Igor]
    * explain magic numbers in _OSC [Igor]
    * drop build_q35_pci_hotplug() wrapper [Igor]

Julia Suvorova (4):
  hw/acpi/ich9: Trace ich9_gpe_readb()/writeb()
  hw/i386/acpi-build: Add ACPI PCI hot-plug methods to q35
  hw/i386/acpi-build: Turn off support of PCIe native hot-plug and SHPC
    in _OSC
  hw/acpi/ich9: Enable ACPI PCI hot-plug

 hw/i386/acpi-build.h    | 12 ++++++++++
 include/hw/acpi/ich9.h  |  3 +++
 include/hw/acpi/pcihp.h |  3 ++-
 hw/acpi/ich9.c          | 52 ++++++++++++++++++++++++++++++++++++++++-
 hw/acpi/pcihp.c         | 15 ++++++++----
 hw/acpi/piix4.c         |  2 +-
 hw/i386/acpi-build.c    | 48 +++++++++++++++++++++++--------------
 hw/i386/pc.c            |  1 +
 hw/acpi/trace-events    |  4 ++++
 9 files changed, 114 insertions(+), 26 deletions(-)

-- 
2.25.4


