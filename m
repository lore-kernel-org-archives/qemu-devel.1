Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80617C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E69207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoaSTZdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E69207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeInX-0004PT-HQ
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeImF-000362-7p
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:40:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28486
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeImD-0007xS-1c
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590673251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEpeW4hSXWUgbGj7HHo1jY8yfFQRooPvNkXyo34CA7s=;
 b=PoaSTZdU4y0BLOi7fPkhkCXWemDDF36uemiUraRrpz3N8msOvWSmp/OJkpJdOqjI1fcQb8
 RhOuUVvvS1CNGkXY8vCEi6QrZPRW1Pwjtdt5LY6GE/CCw1jLixvZMfIes0tpdIWh6FHXgp
 e4RpO4Ej5FtpgDew8vPnxEr0EtSOIlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-RkA-Gq6_NPeBzhBrYcFsdg-1; Thu, 28 May 2020 09:40:50 -0400
X-MC-Unique: RkA-Gq6_NPeBzhBrYcFsdg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 067021855A10;
 Thu, 28 May 2020 13:40:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFED710013C0;
 Thu, 28 May 2020 13:40:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 866F89DAD; Thu, 28 May 2020 15:40:35 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] microvm: use 3G split unconditionally
Date: Thu, 28 May 2020 15:40:32 +0200
Message-Id: <20200528134035.32025-2-kraxel@redhat.com>
In-Reply-To: <20200528134035.32025-1-kraxel@redhat.com>
References: <20200528134035.32025-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, imammedo@redhat.com, philmd@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looks like the logic was copied over from q35.

q35 does this for backward compatibility, there is no reason to do this
on microvm though.  Also microvm doesn't need much mmio space, 1G is
more than enough.  Using an mmio window smaller than 1G is bad for
gigabyte alignment and hugepages though.  So split @ 3G unconditionally.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/microvm.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 937db10ae6a5..44f940813b07 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -170,23 +170,9 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     MemoryRegion *ram_below_4g, *ram_above_4g;
     MemoryRegion *system_memory = get_system_memory();
     FWCfgState *fw_cfg;
-    ram_addr_t lowmem;
+    ram_addr_t lowmem = 0xc0000000; /* 3G */
     int i;
 
-    /*
-     * Check whether RAM fits below 4G (leaving 1/2 GByte for IO memory
-     * and 256 Mbytes for PCI Express Enhanced Configuration Access Mapping
-     * also known as MMCFG).
-     * If it doesn't, we need to split it in chunks below and above 4G.
-     * In any case, try to make sure that guest addresses aligned at
-     * 1G boundaries get mapped to host addresses aligned at 1G boundaries.
-     */
-    if (machine->ram_size >= 0xb0000000) {
-        lowmem = 0x80000000;
-    } else {
-        lowmem = 0xb0000000;
-    }
-
     /*
      * Handle the machine opt max-ram-below-4g.  It is basically doing
      * min(qemu limit, user limit).
-- 
2.18.4


