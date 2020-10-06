Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B5FC4727D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D9020760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ot4E0Syw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D9020760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmkD-0001eG-1F
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 09:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1kPmYz-0007va-QR
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1kPmYx-0002Ae-Dq
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601989166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OpBudGKlhdmVAanuwsLQPvbMp6iZ3X8+sLXAxBQZbwo=;
 b=Ot4E0SywDcWCm1HDcqbQKo3WTddGyTphvfjvJCLYe+TO87XvvjPv/Q/xLH2Xd5v8IuyLeL
 8CyYdMfRMQosoPm1W3fuVqM4t+dW7yPWbUuAu99MJBFjcKQ/bpBZ4AAkrsgsEX+deQYck4
 owSzf6HrVuzYXRZ28IaEADSVB4jsbcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-EcrcTNp3PS-wlwlrmxprtA-1; Tue, 06 Oct 2020 08:59:23 -0400
X-MC-Unique: EcrcTNp3PS-wlwlrmxprtA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45406802B61;
 Tue,  6 Oct 2020 12:59:22 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.195.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A3DE5578C;
 Tue,  6 Oct 2020 12:59:13 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/pci/pci: Fix slot check for plugged devices
Date: Tue,  6 Oct 2020 14:59:08 +0200
Message-Id: <20201006125908.598388-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jusual@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jusual@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If devfn is assigned automatically, 'else' clauses will never be
executed. And if it does not matter for the reserved and available
devfn, because we have already checked it, the check for function0
needs to be done again.

Steps to reproduce:
1. Run QEMU with:
        -M q35 \
        -device pcie-root-port,id=rp,.. \
        -device pci-device,bus=rp
2. Add a new device to the same port:
        device_add pci-device,bus=rp

The last command will add the device to slot 1 instead of
failing with "PCI: slot 0 function 0 already occupied..."

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
v2:
    * add example to the commit message [Michael]

 hw/pci/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index de0fae10ab..ae132b0b52 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1034,8 +1034,9 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                    PCI_SLOT(devfn), PCI_FUNC(devfn), name,
                    bus->devices[devfn]->name);
         return NULL;
-    } else if (dev->hotplugged &&
-               pci_get_function_0(pci_dev)) {
+    };
+
+    if (dev->hotplugged && pci_get_function_0(pci_dev)) {
         error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
                    " new func %s cannot be exposed to guest.",
                    PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
-- 
2.25.4


