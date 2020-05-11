Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F407C54E8E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 08:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB442080C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 08:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMpqRCtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB442080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY3fT-00078Q-I3
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 04:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY3d2-0002zh-8X
 for qemu-devel@nongnu.org; Mon, 11 May 2020 04:17:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54001
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY3d1-0002nH-7w
 for qemu-devel@nongnu.org; Mon, 11 May 2020 04:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589185054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8Kgyc/BsfqlAUuKAX2iSr9cLPvOmA/twzAvloj+tAk=;
 b=MMpqRCtw05XaYIud2avoFP6oNkhcAJYsAQ34woSmETJ9+6jb9cd8RMb8zlE361uI+OxWGw
 w26Zxwl8GRcRfb5g/4HKF1zfnP/HE/G9zwzVhKNKmg38F99cynpUrHsEm99MmAdc7DgxgY
 7v/RLK9Xd0K4MoYW4i3w6SdO3rQOuTM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-GaY_mNsFNXuwV-BNqvG0uw-1; Mon, 11 May 2020 04:17:32 -0400
X-MC-Unique: GaY_mNsFNXuwV-BNqvG0uw-1
Received: by mail-wm1-f72.google.com with SMTP id g10so1001100wme.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 01:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l8Kgyc/BsfqlAUuKAX2iSr9cLPvOmA/twzAvloj+tAk=;
 b=qPyncWo7UafWJM+EmyovO7hytwlJRGe//iTK1sSNctOricPqkYM+fKN2qohtkbbLzD
 CwJhfdxz1+S5O9nSLQVh/DysaFKd1NZzseM8ukC0voctpwRBku6kR/bw6JMpm2m350Jb
 jrEQs9edKig1GXGDwAfYbMNHSqwuqUORnDrt3WPC27K6V61/nRa3fYbUaFRdw2KjHkcq
 1vjxHcN2/qXWdnlr8EfjyulkKGp157Z72PUnwlSZdikbZRSfgeHvuVTKqBkY707g2gVF
 EH2Tm7v7Ou83tA2fLu6PDRLwM1d1ek1FQM66cxdtpV7LoApa/5Tprj34qfaON4LwHqLK
 v1Pg==
X-Gm-Message-State: AGi0PubFouSCAmSmGBAUCBkYwLjYQbDUxRiU2YQ/Do+N/7xg56b3fo28
 fe9vdAVrYXWJl+c4Ru3IdZKQoeHoMRlxTCh8lLdIAFL14LJ4lPf7yXn4QhTBwL6XJhj+yUp/oUP
 Tk7Z8UUSn6Y83V2U=
X-Received: by 2002:a7b:c38b:: with SMTP id s11mr30234407wmj.55.1589185051371; 
 Mon, 11 May 2020 01:17:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypLOtobW+2rmDeuexY+i3NwOfjNt9c/EqSVlRq+EWmcLSLTlrX6i/8xKmcck5cjM2smYJpATuw==
X-Received: by 2002:a7b:c38b:: with SMTP id s11mr30234388wmj.55.1589185051202; 
 Mon, 11 May 2020 01:17:31 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id y10sm13269382wrd.95.2020.05.11.01.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 01:17:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] memory: Rename memory_region_do_writeback() ->
 memory_region_sync()
Date: Mon, 11 May 2020 10:17:17 +0200
Message-Id: <20200511081719.31641-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200511081719.31641-1-philmd@redhat.com>
References: <20200511081719.31641-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 01:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We usually use '_do_' for internal functions. Rename
memory_region_do_writeback() as memory_region_sync()
to better reflect what it does.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/exec/memory.h | 13 +++++++------
 memory.c              |  2 +-
 target/arm/helper.c   |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e000bd2f97..4fc1d85b99 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1474,14 +1474,15 @@ void *memory_region_get_ram_ptr(MemoryRegion *mr);
 void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize,
                               Error **errp);
 /**
- * memory_region_do_writeback: Trigger cache writeback or msync for
- * selected address range
+ * memory_region_sync: Synchronize selected address range
  *
- * @mr: the memory region to be updated
- * @addr: the initial address of the range to be written back
- * @size: the size of the range to be written back
+ * It is only meaningful for RAM regions, otherwise it is no-op.
+ *
+ * @mr: the memory region to be synchronized
+ * @addr: the initial address of the range to be sync
+ * @size: the size of the range to be sync
  */
-void memory_region_do_writeback(MemoryRegion *mr, hwaddr addr, hwaddr size);
+void memory_region_sync(MemoryRegion *mr, hwaddr addr, hwaddr size);
 
 /**
  * memory_region_set_log: Turn dirty logging on or off for a region.
diff --git a/memory.c b/memory.c
index fd5c3af535..73534b26f4 100644
--- a/memory.c
+++ b/memory.c
@@ -2198,7 +2198,7 @@ void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize, Error **errp
 }
 
 
-void memory_region_do_writeback(MemoryRegion *mr, hwaddr addr, hwaddr size)
+void memory_region_sync(MemoryRegion *mr, hwaddr addr, hwaddr size)
 {
     /*
      * Might be extended case needed to cover
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a94f650795..c2697ed7c0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6829,7 +6829,7 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
         mr = memory_region_from_host(haddr, &offset);
 
         if (mr) {
-            memory_region_do_writeback(mr, offset, dline_size);
+            memory_region_sync(mr, offset, dline_size);
         }
     }
 }
-- 
2.21.3


