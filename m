Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1B5C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:48:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A5820726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBUAHonE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A5820726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZdT-0006mG-8Y
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:48:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlG-0001ij-DV
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlF-0001C9-8B
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:50792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlF-0001Aa-1V
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:25 -0500
Received: by mail-wm1-x334.google.com with SMTP id a5so2686913wmb.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qxCNnvhQm4QTO+WUB1tGD71b23rx1E+hM+z8+CQDCao=;
 b=cBUAHonEWNdlQ2hCiwv+PTGiM17KRC7WnxCNHsC6TQNx26L5Y9m5uGt/pB21icAyDE
 sYOhfx+84DcL9UBv8Pmy8mP3yLph6dv0ERQGH932Ee7dk3pdGLbGGvYOPJrancA7vy3+
 xk/B4XMFBlZRabc2G4RWuKKzzBqVJD1sqaM3b+Z9Mkep/H0PqyjwgRexte1T/G5rgemO
 9Sfujw7UYT5TzCaB1IDonLcpvz8iekS7VBW5I2fM40scs1PDfmcViSjbSztMzRV9TbKe
 03Vp0wzGijs2ksCymC21rj/hhW5xTcFlbcYUzpBAMJJiAgfrBr/lFF10hcKDyYGt8zYk
 Fo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qxCNnvhQm4QTO+WUB1tGD71b23rx1E+hM+z8+CQDCao=;
 b=SKpbZhZTVpcgEtwtwkVUefCo7AcPJcw+S0BN2AgssZ+HMc9HoILPVy5cq1PJ1RNBn7
 WN4Zx+miUlnZAY5Ecgc/dBvtReVRqVptYB9l3Lj7ZA9gaICuVOkQWoUxVP1q6W+N9eB8
 9SIX+6pMmUdnmSUN/w/Hra9cDIB99MjVkqQjRgGHXqTNe+zYTJAsfE3XZNnFi5D2vGL3
 js16+IHoDcJTqgr4r28KMNyL3g1yH80xvUS/d8S7j3X/jtIhXi0eiRPqIeMqO7mg5TL2
 T6/qYS+qwh7H7TcE7UpFixtGrwypP79/UxWPm+3LNgUT8aS3YczhyCw+nGTmGrIgRjln
 jGmA==
X-Gm-Message-State: APjAAAXpFgJPyFAR+Qpjp3VSXDqXn+eCwqogZjKrud7XmdqiLfNlhuS7
 7THftSyQ0xF1G2618mU5uKsqq4Fy
X-Google-Smtp-Source: APXvYqwaJGFyo38oqDZqVeXdhKfg5F1wmpHA4VIvxmmaKFbylC3gmwcmWXY2JajnmZCPYtHRBcRjTQ==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr4893346wmh.35.1582631543831; 
 Tue, 25 Feb 2020 03:52:23 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 083/136] exec: Let flatview API take void pointer arguments
Date: Tue, 25 Feb 2020 12:50:13 +0100
Message-Id: <1582631466-13880-83-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Only flatview_[read/write]_continue use a byte pointer to increment
an offset. For the users, we are only dealing with a blob buffer.
Use a void pointer argument. This will let us simplify the
address_space API in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 exec.c                | 14 ++++++++------
 include/exec/memory.h |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/exec.c b/exec.c
index 08a30f6..17808e3 100644
--- a/exec.c
+++ b/exec.c
@@ -2780,9 +2780,9 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
 }
 
 static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
-                                 MemTxAttrs attrs, uint8_t *buf, hwaddr len);
+                                 MemTxAttrs attrs, void *buf, hwaddr len);
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
-                                  const uint8_t *buf, hwaddr len);
+                                  const void *buf, hwaddr len);
 static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
                                   bool is_write, MemTxAttrs attrs);
 
@@ -3147,7 +3147,7 @@ static bool prepare_mmio_access(MemoryRegion *mr)
 /* Called within RCU critical section.  */
 static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
                                            MemTxAttrs attrs,
-                                           const uint8_t *buf,
+                                           const void *ptr,
                                            hwaddr len, hwaddr addr1,
                                            hwaddr l, MemoryRegion *mr)
 {
@@ -3155,6 +3155,7 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
     uint64_t val;
     MemTxResult result = MEMTX_OK;
     bool release_lock = false;
+    const uint8_t *buf = ptr;
 
     for (;;) {
         if (!memory_access_is_direct(mr, true)) {
@@ -3194,7 +3195,7 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
 
 /* Called from RCU critical section.  */
 static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
-                                  const uint8_t *buf, hwaddr len)
+                                  const void *buf, hwaddr len)
 {
     hwaddr l;
     hwaddr addr1;
@@ -3211,7 +3212,7 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
 
 /* Called within RCU critical section.  */
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
-                                   MemTxAttrs attrs, uint8_t *buf,
+                                   MemTxAttrs attrs, void *ptr,
                                    hwaddr len, hwaddr addr1, hwaddr l,
                                    MemoryRegion *mr)
 {
@@ -3219,6 +3220,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
     uint64_t val;
     MemTxResult result = MEMTX_OK;
     bool release_lock = false;
+    uint8_t *buf = ptr;
 
     for (;;) {
         if (!memory_access_is_direct(mr, false)) {
@@ -3256,7 +3258,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
 
 /* Called from RCU critical section.  */
 static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
-                                 MemTxAttrs attrs, uint8_t *buf, hwaddr len)
+                                 MemTxAttrs attrs, void *buf, hwaddr len)
 {
     hwaddr l;
     hwaddr addr1;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e85b7de..6f8084f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2336,7 +2336,7 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs, uint8_t *buf, hwaddr len);
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
-                                   MemTxAttrs attrs, uint8_t *buf,
+                                   MemTxAttrs attrs, void *buf,
                                    hwaddr len, hwaddr addr1, hwaddr l,
                                    MemoryRegion *mr);
 void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
-- 
1.8.3.1



