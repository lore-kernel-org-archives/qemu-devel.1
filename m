Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BDFC47257
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D1E208D6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKIisuaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D1E208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWwWQ-0004k3-9G
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 02:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWwRg-0006SM-Mb
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:25:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58564
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWwRe-0001h9-QE
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588919114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGx/dTXfQHoDJmnNnl9rdEL+ySusKrZpYaooZdERTQg=;
 b=BKIisuaKYe0PYc+XvzEbVYiUqybncWaUOhKQh6zjPSScFnSb4xgzBrDofYuUIKzOzIWMiw
 zzfqv+zXY8mcNVtiP7ndsOocUb9pEz+I2pinM+IcYek+vhp49985J2l8W2bfo3ItCMs78W
 LHmAg6QzcBakMwaWmHBDALqAPwN0xww=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-NhC79XY4OyW93NE3AQnDKw-1; Fri, 08 May 2020 02:25:12 -0400
X-MC-Unique: NhC79XY4OyW93NE3AQnDKw-1
Received: by mail-wr1-f71.google.com with SMTP id f15so402643wrj.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 23:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s/X92jlC3Vu/v6alIjmmIBaqm0/vlTOTw1XjNVQ1CnQ=;
 b=m6riHbtLX/Z9+ujcHpFBtMpCB2tKvJR6xbsHrBgD75Dwm3jFV398jizAwc5R4FMyXe
 scoCkoroeJ7jEFQBR8KHlJXLJ8GsdXIY5ieEVa7FTP7VcpRu8KaIH3ZrbFPgHveUFZUK
 rR34sQtTI32GisIAFQVx6npUFCPinNPLqDLDeRxj+mpSlE7GXjzaNAxL1xiiuVkudms/
 BFuJFQRwmqRVXo6twdmC0Tl847sLFfuty4p+tyqcAI0RFhzn3BexFEo6EadGKLq0A2hv
 JvL2DLXJnAxN/3pWyIUYIdgw5KrLUlpyX40sMWCO7BRcm0INd8aWETPyWRfTKa3ygxV8
 FgnA==
X-Gm-Message-State: AGi0PubBHBedBAMznqsC97qoQOdLUuMiUVubRTwlsbk2vx+CE+7bI4l2
 KHPsDLljfPyBAik9DIalWSNU0R+SaeX30SMzZ2J34UEwUMJKFsA+gjFB9shBinZUL9ozDtB06vr
 3GVBrTyQIdThbjaU=
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr13518165wmc.114.1588919111425; 
 Thu, 07 May 2020 23:25:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypKG+jByhoJa2rNmgaiOzpS2j8i/K0jzYHYuLh89Xei6Bq3IR/j+HlAueJ3oIAVYd02tC9eSfA==
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr13518139wmc.114.1588919111241; 
 Thu, 07 May 2020 23:25:11 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d133sm12809537wmc.27.2020.05.07.23.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 23:25:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] memory: Extract memory_region_msync() from
 memory_region_writeback()
Date: Fri,  8 May 2020 08:24:54 +0200
Message-Id: <20200508062456.23344-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200508062456.23344-1-philmd@redhat.com>
References: <20200508062456.23344-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/memory.h | 13 ++++++++++++-
 memory.c              | 10 ++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1b7cfdd5b6..3e00cdbbfa 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1473,8 +1473,19 @@ void *memory_region_get_ram_ptr(MemoryRegion *mr);
  */
 void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize,
                               Error **errp);
+
 /**
- * memory_region_writeback: Trigger cache writeback or msync for
+ * memory_region_msync: Synchronize selected address range of
+ * a memory mapped region
+ *
+ * @mr: the memory region to be msync
+ * @addr: the initial address of the range to be sync
+ * @size: the size of the range to be sync
+ */
+void memory_region_msync(MemoryRegion *mr, hwaddr addr, hwaddr size);
+
+/**
+ * memory_region_writeback: Trigger cache writeback for
  * selected address range
  *
  * @mr: the memory region to be updated
diff --git a/memory.c b/memory.c
index aa1f807392..ed26514c89 100644
--- a/memory.c
+++ b/memory.c
@@ -2197,6 +2197,12 @@ void memory_region_ram_resize(MemoryRegion *mr, ram_=
addr_t newsize, Error **errp
     qemu_ram_resize(mr->ram_block, newsize, errp);
 }
=20
+void memory_region_msync(MemoryRegion *mr, hwaddr addr, hwaddr size)
+{
+    if (mr->ram_block) {
+        qemu_ram_writeback(mr->ram_block, addr, size);
+    }
+}
=20
 void memory_region_writeback(MemoryRegion *mr, hwaddr addr, hwaddr size)
 {
@@ -2204,8 +2210,8 @@ void memory_region_writeback(MemoryRegion *mr, hwaddr=
 addr, hwaddr size)
      * Might be extended case needed to cover
      * different types of memory regions
      */
-    if (mr->ram_block && mr->dirty_log_mask) {
-        qemu_ram_writeback(mr->ram_block, addr, size);
+    if (mr->dirty_log_mask) {
+        memory_region_msync(mr, addr, size);
     }
 }
=20
--=20
2.21.3


