Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10792C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFA52064B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0MpMGi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFA52064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxsrw-00030j-5S
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jxsr9-0001kz-59
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:02:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40608
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jxsr7-0008S3-GK
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595340172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Tvv259nl6Wb3MOWCMuYj/NBbGmBLRDaD8BYDWIbo9U=;
 b=f0MpMGi1HVq9+etiUPG6NJ8WKeHx1DZ8hAb0ceh4LckZOXWDnni/J5SyUlRuipkyfmGwql
 SMv64kKWZWnNse/2oENhU/tC4Vhp4UDyLj/ngTTdr3AtYtvWq/yibFeFErG7KTgHBV5qJ6
 TUqsmHhrJ06RYurIj2KrzLmJH3fMf9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-rhCv3QOENKm-OsTMkg0Ruw-1; Tue, 21 Jul 2020 10:02:50 -0400
X-MC-Unique: rhCv3QOENKm-OsTMkg0Ruw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D95091902EB6
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 14:02:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC92A7268D;
 Tue, 21 Jul 2020 14:02:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E60D79DA0; Tue, 21 Jul 2020 16:02:45 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] xhci: fix valid.max_access_size to access address registers
Date: Tue, 21 Jul 2020 16:02:43 +0200
Message-Id: <20200721140245.14634-2-kraxel@redhat.com>
In-Reply-To: <20200721140245.14634-1-kraxel@redhat.com>
References: <20200721140245.14634-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 03:39:19
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
Cc: Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

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
Message-id: 20200721083322.90651-1-lvivier@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
2.18.4


