Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3FAC2BB84
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE0F206E7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpA0arOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE0F206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDx6-0007Sq-KV
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDto-0001Fw-Ua
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:45:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27449
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDtl-0007TK-JX
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599234308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVJoRP2NryT9xCjnhEGS3UrNwkpOFjKsKUG8gUNW5dU=;
 b=WpA0arODEM/VFWX68JI6yWsg4tEDrbkbFhZeqF4wlUxelxU68ZFDfT8llB0csPbBJV0r4b
 A5q3UeMPtK3pCM0mvpm0q4hDdMhW3zixuBXRjzcAfDNZk1OpbasQ8yDlPp1+7ZMsKf9sVD
 zFCuPYPPsWPjvLiDSFsQUvaN9v9Yjog=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-A96q8_G7OU2xNs3rYP7uQw-1; Fri, 04 Sep 2020 11:45:06 -0400
X-MC-Unique: A96q8_G7OU2xNs3rYP7uQw-1
Received: by mail-wr1-f72.google.com with SMTP id l9so319071wrq.20
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 08:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oVJoRP2NryT9xCjnhEGS3UrNwkpOFjKsKUG8gUNW5dU=;
 b=F/2wK51xwcbRQbdoRDrL1TV9yk+XsiQIchwHiISTWJ/uyiykHUw7dtug3Olbi3o3wA
 URQSzuEcd9RkaM1kwB45bUEYotgpbMfFqdeldDGcV+/pRXbCDDvJqV9rW+6a+ky8EsHH
 IQxV1ed6NIC1Qxrg7aAVkr1Kk8vX1pu8CNw4CpTApMc7fD8k67MmQY/60DE8PoHdRICa
 b4VL8rJJnBP0dG2I8sDcgQa+oD0mzRWI8Ntxw+oMRF8h5FNCHtm0TYdAqoHbGxwVGnMq
 OpH7reAdHQwkVyn3b+hCd36ZcC1mf1RocOfDdN+NyhcRRW/sH8p8QBbQs3LUvqkMVfuT
 8hZg==
X-Gm-Message-State: AOAM532OAUfiiXbldJ9xbY+fAE0XZ2e45LQkISWSb7JzDsuGSP/CZtpX
 e4kB0h8pkt5SHH7pkNbrAHSUHvlSLVC/1yWkGSTSaylMdlC5/sdB8RmFdKkNswBs11dU0/vv9Ky
 b3JdX79AquW+VxRI=
X-Received: by 2002:a5d:680b:: with SMTP id w11mr8800600wru.73.1599234305473; 
 Fri, 04 Sep 2020 08:45:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyufkRwrrAmfJTcRurpOYpfOULXd8fYcWxWkpXQQWEklre41SAuhWofKbB563eMWvXpi4NCjA==
X-Received: by 2002:a5d:680b:: with SMTP id w11mr8800576wru.73.1599234305213; 
 Fri, 04 Sep 2020 08:45:05 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id h186sm12219587wmf.24.2020.09.04.08.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:45:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 04/13] dma: Let dma_memory_set() propagate MemTxResult
Date: Fri,  4 Sep 2020 17:44:30 +0200
Message-Id: <20200904154439.643272-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904154439.643272-1-philmd@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

address_space_write() returns a MemTxResult type.
Do not discard it, return it to the caller.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/dma.h | 15 ++++++++++++++-
 dma-helpers.c        |  7 ++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 19bc9ad1b69..ad8a3f82f47 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -123,7 +123,20 @@ static inline int dma_memory_write(AddressSpace *as, dma_addr_t addr,
                          DMA_DIRECTION_FROM_DEVICE);
 }
 
-int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len);
+/**
+ * dma_memory_set: Fill memory with a constant byte from DMA controller.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @c: constant byte to fill the memory
+ * @len: the number of bytes to fill with the constant byte
+ */
+MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
+                           uint8_t c, dma_addr_t len);
 
 /**
  * address_space_map: Map a physical memory region into a DMA controller
diff --git a/dma-helpers.c b/dma-helpers.c
index 41ef24a63b6..4a9e37d6d06 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -1,7 +1,7 @@
 /*
  * DMA helper functions
  *
- * Copyright (c) 2009 Red Hat
+ * Copyright (c) 2009,2020 Red Hat
  *
  * This work is licensed under the terms of the GNU General Public License
  * (GNU GPL), version 2 or later.
@@ -18,14 +18,15 @@
 
 /* #define DEBUG_IOMMU */
 
-int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len)
+MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
+                           uint8_t c, dma_addr_t len)
 {
     dma_barrier(as, DMA_DIRECTION_FROM_DEVICE);
 
 #define FILLBUF_SIZE 512
     uint8_t fillbuf[FILLBUF_SIZE];
     int l;
-    bool error = false;
+    MemTxResult error = MEMTX_OK;
 
     memset(fillbuf, c, FILLBUF_SIZE);
     while (len > 0) {
-- 
2.26.2


