Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183B5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5532070C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vqNimJ0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5532070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYkB-00020P-9d
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 10:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itYiV-0000EV-6G
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:11:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itYiS-0008LS-U3
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:11:50 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56290)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itYiS-0008Ku-Nh
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:11:48 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so14836617wmj.5
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 07:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lFQzfIG2mcQ6kNeefaXxZhlvNs2iYmZJDouckBmIIpc=;
 b=vqNimJ0At+FFrlAxtDqqIOsPP3vVEClKiIK40Jh+f6gAl5NDmVGqOvgN+qJm2ahCJ8
 ywVW9YkfFdjCQ21/N7xCHxMWZfH4W62xDXNm9u2mdacnSkEisxZl+ucdFLwrfQYVEd7J
 wTRJPVTgKZDhi5xk8NgTdVkwjOXk26XNtcfXZtvvhQHE2VZWRsnjQ6mH/kvgSQmo5OQ/
 UsExVjcKUISYtKFlxLJpTOBYwiV7FP614X41DhWQ5/f4II87EV8kA6twFNHEKmEF/eMw
 ABZF6FMBUt2oFCPG+5f4g8oFXah12HgpvjTtm3ap4fcAS3f6phcdRD1L0Ega1dYVXNKG
 D9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lFQzfIG2mcQ6kNeefaXxZhlvNs2iYmZJDouckBmIIpc=;
 b=LyikOUtC6O4IRXOvwphWf3lstQ5MjfSEE5/TZ57QZlvPK0OTZaAVTPeA6/I1nGlzHx
 +jCr4YrVAIFntsmY4pZBMzWYePdk7I/KqGwzEAaD2sRlFedQabBilEMaNJ3TbK7FfHiz
 ry/1skpxVs7nDKVrQ0D/zHl8BS5kKRv9NWmKbyZYUlf6Q76kLxTDctMnIpAGTyUrDpcQ
 ECE620H90SWeKlNDROawEbaeXuExB2XIkWHAMUOtMFSftU3WgjReazTFPW7P/tvaN5YV
 4PnmABqf3UdSKROo4j8YHxm8Uh7qqJzHJQuAfvJ6PXeAuZuqd5kvntPPCtQiObZyyAgi
 B73A==
X-Gm-Message-State: APjAAAV+IMa3+EE5EbuCFBBhBr7x0JE/phK4osFSB2hNgEatTdMH0FEx
 3vdslm/ThykowLNlnTy5H9iXpak0za9VDA==
X-Google-Smtp-Source: APXvYqwJLCNFlH9TcBMEgbH1cVAa0YxainPc5CrQuDd7NwiWU2NzgfNcesUORoZpdqRAKfIsaWTB/w==
X-Received: by 2002:a05:600c:251:: with SMTP id
 17mr19314860wmj.88.1579533107363; 
 Mon, 20 Jan 2020 07:11:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f17sm817919wmc.8.2020.01.20.07.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 07:11:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] memory.c: Use trace_event_get_state_backends()
Date: Mon, 20 Jan 2020 15:11:41 +0000
Message-Id: <20200120151142.18954-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120151142.18954-1-peter.maydell@linaro.org>
References: <20200120151142.18954-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The preferred way to test whether a trace event is enabled is to
use trace_event_get_state_backends(), because this will give the
correct answer (allowing expensive computations to be skipped)
whether the trace event is compile-time or run-time disabled.
Convert the four old-style direct uses of TRACE_FOO_ENABLED in
memory.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 memory.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/memory.c b/memory.c
index d7b9bb6951f..0baafe1fa90 100644
--- a/memory.c
+++ b/memory.c
@@ -434,7 +434,7 @@ static MemTxResult  memory_region_read_accessor(MemoryRegion *mr,
     tmp = mr->ops->read(mr->opaque, addr, size);
     if (mr->subpage) {
         trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
-    } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
+    } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_READ)) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
     }
@@ -456,7 +456,7 @@ static MemTxResult memory_region_read_with_attrs_accessor(MemoryRegion *mr,
     r = mr->ops->read_with_attrs(mr->opaque, addr, &tmp, size, attrs);
     if (mr->subpage) {
         trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
-    } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
+    } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_READ)) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
     }
@@ -476,7 +476,7 @@ static MemTxResult memory_region_write_accessor(MemoryRegion *mr,
 
     if (mr->subpage) {
         trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, size);
-    } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
+    } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_WRITE)) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size);
     }
@@ -496,7 +496,7 @@ static MemTxResult memory_region_write_with_attrs_accessor(MemoryRegion *mr,
 
     if (mr->subpage) {
         trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, size);
-    } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
+    } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_WRITE)) {
         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, size);
     }
-- 
2.20.1


