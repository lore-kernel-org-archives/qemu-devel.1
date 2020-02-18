Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65675C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB2C2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 15:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB2C2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mborgerson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j44Op-0005yC-Ek
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 10:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mborgerson@gmail.com>) id 1j3zzX-0002T9-Qg
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mborgerson@gmail.com>) id 1j3zzW-0000mC-PF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:20:35 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mborgerson@gmail.com>)
 id 1j3zzW-0000k1-JX
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:20:34 -0500
Received: by mail-pj1-f67.google.com with SMTP id 12so799251pjb.5
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 02:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=/kJdEX6JpHUgQkYoa4ULaWLX5hXUFWrgslRjL9RlDbE=;
 b=Gr+u2UnkJiK+ykU8mlvL4+7h8SvLbH22zZao6gUAHOAC6aGyoxYZWJYPc7pHC6zHjO
 ortEf3st3Bw7s2VjsEsTDEhqQxN6wnsww8buJnnyFis1ezVk0lFiLdQ0KqCXOMYq8mMn
 vbfdLfWXmK6I+YXiyjjbn4LYYpBE5xFzMpiQEnTaoVMp4nXamlBBgiYc0srgBjBF3sLG
 NXbfQCebrrS5XwPD5ukdmTgQtWkvcynqzdOJeWdmacHj0d4WxxjkF3A4ZmeYT4bILmAX
 jkRelQXAPKspSK87HYrGx4xw0PTJkoDuZjsda2GkcCFEyqBP9o4M/wl6iSivUwJ8OEo8
 2FvQ==
X-Gm-Message-State: APjAAAUZFgZiUHefNvREki0j7MMvYBg06RVqEWU6O0LgRWxAmqD7NECu
 22sng3XaHR9fvddW/oyF5K7A3Q0No6w=
X-Google-Smtp-Source: APXvYqzF1/V4OAqduzMuh1LtqGqk9XF3C/CjSo1vLGHIC979Ssxm2FCZBV0Vqmn8K58/EWl44DnIxw==
X-Received: by 2002:a17:902:74c3:: with SMTP id
 f3mr20729357plt.0.1582021231649; 
 Tue, 18 Feb 2020 02:20:31 -0800 (PST)
Received: from localhost.localdomain (ip98-177-254-240.ph.ph.cox.net.
 [98.177.254.240])
 by smtp.gmail.com with ESMTPSA id b21sm3805369pfp.0.2020.02.18.02.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 02:20:30 -0800 (PST)
From: Matt Borgerson <contact@mborgerson.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] memory: Fix start offset for bitmap log_clear hook
Date: Tue, 18 Feb 2020 03:19:10 -0700
Message-Id: <20200218101910.6593-1-contact@mborgerson.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.216.67
X-Mailman-Approved-At: Tue, 18 Feb 2020 10:01:52 -0500
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
Cc: pbonzini@redhat.com, Matt Borgerson <contact@mborgerson.com>,
 peterx@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently only the final page offset is being passed to the `log_clear`
hook via `memory_region_clear_dirty_bitmap` after it is used as an
iterator in `cpu_physical_memory_test_and_clear_dirty`. This patch
corrects the start address and size of the region.

Signed-off-by: Matt Borgerson <contact@mborgerson.com>
---
 exec.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 8e9cc3b47c..f0f7d0be49 100644
--- a/exec.c
+++ b/exec.c
@@ -1314,7 +1314,7 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               unsigned client)
 {
     DirtyMemoryBlocks *blocks;
-    unsigned long end, page;
+    unsigned long end, page, start_page;
     bool dirty = false;
     RAMBlock *ramblock;
     uint64_t mr_offset, mr_size;
@@ -1324,7 +1324,8 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
     }
 
     end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
-    page = start >> TARGET_PAGE_BITS;
+    start_page = start >> TARGET_PAGE_BITS;
+    page = start_page;
 
     WITH_RCU_READ_LOCK_GUARD() {
         blocks = atomic_rcu_read(&ram_list.dirty_memory[client]);
@@ -1344,8 +1345,8 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
             page += num;
         }
 
-        mr_offset = (ram_addr_t)(page << TARGET_PAGE_BITS) - ramblock->offset;
-        mr_size = (end - page) << TARGET_PAGE_BITS;
+        mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - ramblock->offset;
+        mr_size = (end - start_page) << TARGET_PAGE_BITS;
         memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
     }
 
-- 
2.17.1


