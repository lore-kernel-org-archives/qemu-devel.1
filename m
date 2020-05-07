Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C084AC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DD120735
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0fESeVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DD120735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkWS-000658-MG
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkVJ-000428-Ps
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60268
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkVI-0001pp-UX
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588873211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HfPvUKlpTOVQLFy8BwTSc/DXLFLUF3kj7Agr3qTHJq8=;
 b=K0fESeVfYgPq10qfkJo+KGddCzZubOHjAkG+NG8+irVr/ECFDJoCfAhvx5lOuR2oxwUBYG
 aPBUgx1D1jInIcZFPgyfZHNvewqJqUZKS1eUW2L1m9evdoQlIiiICNXhNNSzUvrbyn/+kU
 zA4c/cFr7TUq26wMFPCpw2Fg7CeP/y8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-J646-Ki_MuqQG3feSsJ6uw-1; Thu, 07 May 2020 13:40:10 -0400
X-MC-Unique: J646-Ki_MuqQG3feSsJ6uw-1
Received: by mail-wm1-f70.google.com with SMTP id h6so3816541wmi.7
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kxvXFPE6UHybEFXPcbW7yUzdfwvwhz8UFSm+7XHIpoE=;
 b=Pm99cz+oC4SPnthII1gWlcCaGAF77xZAsg0scSkJfCJ6z72muN4mRGIzLvBPoTZjHQ
 3tF/3TyAA18YUNtmBaOitYq5LQ+DJcLH8M/Am+qCFB+pH6XneGzzrQT/y5pIV6yfz83J
 OMvRf0roJ9xKL9H6wN1+CMR1Z+zI3bUXY4H1TJN2ueI1iMXEXPyKvolAvD5HhTdFfemI
 V3Z+4fTHhDSSWvAqGW8ITmwEnDd/lQTtsDEUMHkhKRiBgtAuEQTFaZvFFZMhIBvfkDOd
 9ZzYiVTtPPe6w8esyVhYvlAlxaCyLXsQXvsnO1Dr0mDUfaBQRud0JoGIzNvkF65wnw2H
 Ds5A==
X-Gm-Message-State: AGi0PuYK5uMxZu9q3mWBY3C7kbPTUeMJbemYc94tgMmgxrEUInDrEZfA
 xGM6bSMoMa/5ZwFDfpRNzj1qr6WAl1x8DKvrKy1rRARzeFlWmy6ERaUl/tNrTokz0ZHSuILVDP0
 Z9DBy2IBGIBu080Y=
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr16056753wrn.209.1588873209110; 
 Thu, 07 May 2020 10:40:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypKlrGEn0Sc/1RPDvoGn3rAxgVJuKzc8w2GXUIsYM+I8hINTpoVRTGPr4A3JRU1Chjb4djvbRA==
X-Received: by 2002:adf:e8c4:: with SMTP id k4mr16056726wrn.209.1588873208935; 
 Thu, 07 May 2020 10:40:08 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id t16sm9133352wrm.26.2020.05.07.10.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 10:40:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 01/10] exec: Rename qemu_ram_writeback() as qemu_ram_msync()
Date: Thu,  7 May 2020 19:39:49 +0200
Message-Id: <20200507173958.25894-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200507173958.25894-1-philmd@redhat.com>
References: <20200507173958.25894-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename qemu_ram_writeback() as qemu_ram_msync() to better
match what it does.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/ram_addr.h | 4 ++--
 exec.c                  | 2 +-
 hw/block/nvme.c         | 3 +--
 memory.c                | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 4e05292f91..7b5c24e928 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -136,12 +136,12 @@ void qemu_ram_free(RAMBlock *block);
=20
 int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
=20
-void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t leng=
th);
+void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length);
=20
 /* Clear whole block of mem */
 static inline void qemu_ram_block_writeback(RAMBlock *block)
 {
-    qemu_ram_writeback(block, 0, block->used_length);
+    qemu_ram_msync(block, 0, block->used_length);
 }
=20
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
diff --git a/exec.c b/exec.c
index 2874bb5088..f5a8cdf370 100644
--- a/exec.c
+++ b/exec.c
@@ -2127,7 +2127,7 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsi=
ze, Error **errp)
  * Otherwise no-op.
  * @Note: this is supposed to be a synchronous op.
  */
-void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t leng=
th)
+void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length)
 {
     /* The requested range should fit in within the block range */
     g_assert((start + length) <=3D block->used_length);
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9b453423cf..21a199e53b 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1207,8 +1207,7 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr a=
ddr, unsigned size)
          */
         if (addr =3D=3D 0xE08 &&
             (NVME_PMRCAP_PMRWBM(n->bar.pmrcap) & 0x02)) {
-            qemu_ram_writeback(n->pmrdev->mr.ram_block,
-                               0, n->pmrdev->size);
+            qemu_ram_msync(n->pmrdev->mr.ram_block, 0, n->pmrdev->size);
         }
         memcpy(&val, ptr + addr, size);
     } else {
diff --git a/memory.c b/memory.c
index 601b749906..3e65e33ac4 100644
--- a/memory.c
+++ b/memory.c
@@ -2205,7 +2205,7 @@ void memory_region_do_writeback(MemoryRegion *mr, hwa=
ddr addr, hwaddr size)
      * different types of memory regions
      */
     if (mr->ram_block && mr->dirty_log_mask) {
-        qemu_ram_writeback(mr->ram_block, addr, size);
+        qemu_ram_msync(mr->ram_block, addr, size);
     }
 }
=20
--=20
2.21.3


