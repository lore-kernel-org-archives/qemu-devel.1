Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AC3C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 08:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35FDB207DD
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 08:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgIqepew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FDB207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY3gl-0008WJ-CA
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 04:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY3dB-0003QJ-Bz
 for qemu-devel@nongnu.org; Mon, 11 May 2020 04:17:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59872
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY3dA-0002or-M1
 for qemu-devel@nongnu.org; Mon, 11 May 2020 04:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589185064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSfIOqlIt2t/ygoZKZ0BPDhjsEwlu4jVN7jfPQltXnc=;
 b=bgIqepewjKoKtB/l2ThdN0f9VKuExP1oZS0JaSyogxBAQQoHrhY62P4aWaxO9J4wlGQwbS
 Qujw8BC+JPIAKl5Ib1bQ7F1f7TlUbxDmRl8jqBS0q14KwOtpcfYQkSELy0X9Eyb1E9vUfj
 ikLtaiFCMhx1wyxwpmw/E6gWWR8Ls8I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-O3LEHLewMhmSy0bHXH57xg-1; Mon, 11 May 2020 04:17:42 -0400
X-MC-Unique: O3LEHLewMhmSy0bHXH57xg-1
Received: by mail-wm1-f71.google.com with SMTP id v23so5005554wmj.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 01:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tSfIOqlIt2t/ygoZKZ0BPDhjsEwlu4jVN7jfPQltXnc=;
 b=qrgfvR7Osz4I+OIcwxwAMVA4mWZ7V1ouRgu8Qi2UlpaDOQSlQU+J7sjlZj11q/b8RI
 oVYTO1K2hv1nhpBzKNwFRod15Cf9N/WK7IyAoPDSStwd6WLNhg6KESFDFFHuKa9A7kll
 TivMTRfHllhu03HAwB5bwUDtgzK2ooZbFqMjLT2A3tt+RNYyuB51tYVOxaeWMLQRGnfZ
 fwOAlRowu0bksbg4/8LAcuXONacEf9oOKfP6QqFePFpwV4Vn/i/kkZGCly+pU5/uBSjn
 oqP8qeyJPkwjrs01u1On7qqIUXDp+5eAg6ljJg2GKY9jnFB2mkb8rip1FiOxEovfxC/r
 OFTQ==
X-Gm-Message-State: AGi0PuaN/DNBgd3jVKQZsPVlqUXnsu954GJ0SiyEN0iiJ4Qqu3Lon/pU
 yYcoM5boXxn6++h+3/xNFp73i6Be53WUwIQBL8+JmU3mLqQZGLdGH7pYF2cfUc6LhP/sULQ2Zj7
 CMBhKjf0o3ZzPBVQ=
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr28919818wmh.47.1589185060982; 
 Mon, 11 May 2020 01:17:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypLvrSVcCxsl5UqPYYZ+FqM70FTTVIzUWz3eyvyepS6ativy6YX0/sHoR4uJdH1WXxMBye/fUA==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr28919798wmh.47.1589185060762; 
 Mon, 11 May 2020 01:17:40 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id o26sm14683656wro.83.2020.05.11.01.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 01:17:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] exec: Rename qemu_ram_writeback() as qemu_ram_msync()
Date: Mon, 11 May 2020 10:17:19 +0200
Message-Id: <20200511081719.31641-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200511081719.31641-1-philmd@redhat.com>
References: <20200511081719.31641-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename qemu_ram_writeback() as qemu_ram_msync() to better
match what it does.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/exec/ram_addr.h | 4 ++--
 exec.c                  | 2 +-
 memory.c                | 3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index a94809f89b..84817e19fa 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -136,12 +136,12 @@ void qemu_ram_free(RAMBlock *block);
 
 int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
 
-void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t length);
+void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length);
 
 /* Clear whole block of mem */
 static inline void qemu_ram_block_writeback(RAMBlock *block)
 {
-    qemu_ram_writeback(block, 0, block->used_length);
+    qemu_ram_msync(block, 0, block->used_length);
 }
 
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
diff --git a/exec.c b/exec.c
index 2874bb5088..f5a8cdf370 100644
--- a/exec.c
+++ b/exec.c
@@ -2127,7 +2127,7 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
  * Otherwise no-op.
  * @Note: this is supposed to be a synchronous op.
  */
-void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t length)
+void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length)
 {
     /* The requested range should fit in within the block range */
     g_assert((start + length) <= block->used_length);
diff --git a/memory.c b/memory.c
index 73534b26f4..5bfa1429df 100644
--- a/memory.c
+++ b/memory.c
@@ -2197,7 +2197,6 @@ void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize, Error **errp
     qemu_ram_resize(mr->ram_block, newsize, errp);
 }
 
-
 void memory_region_sync(MemoryRegion *mr, hwaddr addr, hwaddr size)
 {
     /*
@@ -2205,7 +2204,7 @@ void memory_region_sync(MemoryRegion *mr, hwaddr addr, hwaddr size)
      * different types of memory regions
      */
     if (mr->ram_block) {
-        qemu_ram_writeback(mr->ram_block, addr, size);
+        qemu_ram_msync(mr->ram_block, addr, size);
     }
 }
 
-- 
2.21.3


