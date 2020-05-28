Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3EAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC7720814
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtVO0tir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC7720814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeIpH-0007VU-RW
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeImG-00037i-0J
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:40:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49094
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeImF-0007vG-7x
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590673250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=e05g/is/lgsNSL/Pq60mo/ih+dnu1o1RQCp9fSYeJCw=;
 b=TtVO0tirPAiCstH30qJcyfPN4jRePoWfFuV3z841xOR95lakrvNWQeHcEaKkKUcnvAWFNY
 EmwVEbqDpdaLnoxzec53ttsOXl1P+tW6vggiLVB9/bJa2eM2+lvVl1dMd64C4jwoXCtCOo
 wFE68eSzdOACiVjrCVt9WojiXedLfzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-wQedq-9dOJikGgPN3La3fA-1; Thu, 28 May 2020 09:40:46 -0400
X-MC-Unique: wQedq-9dOJikGgPN3La3fA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16386107ACCA;
 Thu, 28 May 2020 13:40:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB9A15D9EF;
 Thu, 28 May 2020 13:40:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8FA189DAE; Thu, 28 May 2020 15:40:35 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] microvm: drop max-ram-below-4g support
Date: Thu, 28 May 2020 15:40:33 +0200
Message-Id: <20200528134035.32025-3-kraxel@redhat.com>
In-Reply-To: <20200528134035.32025-1-kraxel@redhat.com>
References: <20200528134035.32025-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, imammedo@redhat.com, philmd@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not useful for microvm and allows users to shoot themself
into the foot (make ram + mmio overlap).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/microvm.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 44f940813b07..5e931975a06d 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -173,25 +173,6 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     ram_addr_t lowmem = 0xc0000000; /* 3G */
     int i;
 
-    /*
-     * Handle the machine opt max-ram-below-4g.  It is basically doing
-     * min(qemu limit, user limit).
-     */
-    if (!x86ms->max_ram_below_4g) {
-        x86ms->max_ram_below_4g = 4 * GiB;
-    }
-    if (lowmem > x86ms->max_ram_below_4g) {
-        lowmem = x86ms->max_ram_below_4g;
-        if (machine->ram_size - lowmem > lowmem &&
-            lowmem & (1 * GiB - 1)) {
-            warn_report("There is possibly poor performance as the ram size "
-                        " (0x%" PRIx64 ") is more then twice the size of"
-                        " max-ram-below-4g (%"PRIu64") and"
-                        " max-ram-below-4g is not a multiple of 1G.",
-                        (uint64_t)machine->ram_size, x86ms->max_ram_below_4g);
-        }
-    }
-
     if (machine->ram_size > lowmem) {
         x86ms->above_4g_mem_size = machine->ram_size - lowmem;
         x86ms->below_4g_mem_size = lowmem;
-- 
2.18.4


