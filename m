Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7824C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:35:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C14206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mja6lk5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C14206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnkb-0004Fj-VE
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jxniQ-0001Hq-QP
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:33:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31305
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1jxniP-00083P-2U
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595320411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IEOczykzlRZ1yY+2Ia8wT4rNNjNneGa6Jpqigyov/g4=;
 b=Mja6lk5MMTURpKohV+dnwC5V2ORFs4Q+OtKzBtPT40u5v6FgohD8KAOQPTdUkGWmY3DkDH
 xE5Rx93j7012mzHZB+MvqF7PtrEWKsSUzV5dHvLrMvX9VGKWUCVwEVMnFoMXyPR7gFh77g
 4xxoh1Ytr9WSzYc5Y+A07ACftCK88LM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-kIUQzQgGMcSnm3WY5q8wzA-1; Tue, 21 Jul 2020 04:33:30 -0400
X-MC-Unique: kIUQzQgGMcSnm3WY5q8wzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FBFA8014D4;
 Tue, 21 Jul 2020 08:33:28 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B99E73050;
 Tue, 21 Jul 2020 08:33:23 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1] xhci: fix valid.max_access_size to access address
 registers
Date: Tue, 21 Jul 2020 10:33:22 +0200
Message-Id: <20200721083322.90651-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@au1.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU XHCI advertises AC64 (64-bit addressing) but doesn't allow
64-bit mode access in "runtime" and "operational" MemoryRegionOps.

Set the max_access_size based on sizeof(dma_addr_t) as AC64 is set.

XHCI specs:
"If the xHC supports 64-bit addressing (AC64 = ‘1’), then software
should write 64-bit registers using only Qword accesses.  If a
system is incapable of issuing Qword accesses, then writes to the
64-bit address fields shall be performed using 2 Dword accesses;
low Dword-first, high-Dword second.  If the xHC supports 32-bit
addressing (AC64 = ‘0’), then the high Dword of registers containing
64-bit address fields are unused and software should write addresses
using only Dword accesses"

The problem has been detected with SLOF, as linux kernel always accesses
registers using 32-bit access even if AC64 is set and revealed by
5d971f9e6725 ("memory: Revert "memory: accept mismatching sizes in memory_region_access_valid"")

Suggested-by: Alexey Kardashevskiy <aik@au1.ibm.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/usb/hcd-xhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index b330e36fe6cc..67a18fe2b64c 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3184,7 +3184,7 @@ static const MemoryRegionOps xhci_oper_ops = {
     .read = xhci_oper_read,
     .write = xhci_oper_write,
     .valid.min_access_size = 4,
-    .valid.max_access_size = 4,
+    .valid.max_access_size = sizeof(dma_addr_t),
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
@@ -3200,7 +3200,7 @@ static const MemoryRegionOps xhci_runtime_ops = {
     .read = xhci_runtime_read,
     .write = xhci_runtime_write,
     .valid.min_access_size = 4,
-    .valid.max_access_size = 4,
+    .valid.max_access_size = sizeof(dma_addr_t),
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-- 
2.26.2


