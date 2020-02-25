Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87795C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D4020726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF5PoHm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D4020726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aBt-0007kQ-Ip
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0T-0003xA-1Z
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0R-0003fc-Ui
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:08 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:53396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0R-0003eb-Lm
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:07 -0500
Received: by mail-wm1-x32d.google.com with SMTP id t79so1238192wmt.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=V5wH7aHM1S33hAp9O25CXZ9ZRApLVbQXaWr8cTEbif8=;
 b=IF5PoHm8PEv9CvRZccY387IlD9nq5mN0wrTrGiLDWgBRlg7zX5+arQWWRKj8DV39OX
 Dv8z3ckhXQ/j6vEW4VWwyCsK38+/OLo4q08f0cPBjbeoLeSqdh5/OkrG3n4xLHivnDJb
 KZruasgdysTIcjEJPeH/mo8K9Plpi+qagVpNlLFkCQy2wx1B5PjzUHrWwR8931bCCRZt
 gZtLxct9DQe5ynm16EmGRRAZiOE0LGa7F3tVGz7wA5VExUChpJpCTXsRhtWFZlRqsIzJ
 r7wRfsX/MJYrYWcKM+AZ+zrfUX9Yo79KM+Qck9R+PVXlJR0m2GcOoeeYjMFhhUL+rS01
 jk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=V5wH7aHM1S33hAp9O25CXZ9ZRApLVbQXaWr8cTEbif8=;
 b=sy3wG3Emo6LDeMREM8GUf41d/VWdk0OzxPHsMBC836H+1/ymTk8/Knac3rmGGu6PNl
 3+XjaNbECrLJgTAld75lp/DOUp4ajk08ot4xBbzS/SwzeRwg2ulcCQk9FaSbuvOfFd41
 xLT2HU7S98YgIcx5jbYAptT2Fxl3/ZQLM1RNNF8/y6CEsyIxnG6aQeILEdZ8Mp9S/voz
 YwysmofU3eS99L5C5HWOUycfwoOE7HTCViPGTlXxx+C1+9hf9SkgasbGT6JaOYpOAHkp
 bcf8cBKNHjGkfzz5b9no+UXLPPa0WnkKbc4DNmuBFi6WmpjXXkvmJZT9l4GYni5siS2C
 /l2g==
X-Gm-Message-State: APjAAAXhhVLgyyNi5aGLcycw2JYHH9FsjTqs5nHFPM/KLZm+nlSOorH7
 S+eMJRQaXN4hMLl+soI2eyGNwYaq
X-Google-Smtp-Source: APXvYqzbsr5DeuRJa36pmzOB/IrHyHvBKIxlGYOP9tn+R4Q5ZzvwfPs00R9ZUhPH/OrwMe3Y/HMt/g==
X-Received: by 2002:a7b:c750:: with SMTP id w16mr4932277wmk.46.1582632484264; 
 Tue, 25 Feb 2020 04:08:04 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.08.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:08:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 131/136] memory: batch allocate ioeventfds[] in
 address_space_update_ioeventfds()
Date: Tue, 25 Feb 2020 13:07:29 +0100
Message-Id: <1582632454-16491-29-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Reallocing the ioeventfds[] array each time an element is added is very
expensive as the number of ioeventfds increases.  Batch allocate instead
to amortize the cost of realloc.

This patch reduces Linux guest boot times from 362s to 140s when there
are 2 virtio-blk devices with 1 virtqueue and 99 virtio-blk devices with
32 virtqueues.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200218182226.913977-1-stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/memory.c b/memory.c
index aeaa8dc..09be40e 100644
--- a/memory.c
+++ b/memory.c
@@ -794,10 +794,19 @@ static void address_space_update_ioeventfds(AddressSpace *as)
     FlatView *view;
     FlatRange *fr;
     unsigned ioeventfd_nb = 0;
-    MemoryRegionIoeventfd *ioeventfds = NULL;
+    unsigned ioeventfd_max;
+    MemoryRegionIoeventfd *ioeventfds;
     AddrRange tmp;
     unsigned i;
 
+    /*
+     * It is likely that the number of ioeventfds hasn't changed much, so use
+     * the previous size as the starting value, with some headroom to avoid
+     * gratuitous reallocations.
+     */
+    ioeventfd_max = QEMU_ALIGN_UP(as->ioeventfd_nb, 4);
+    ioeventfds = g_new(MemoryRegionIoeventfd, ioeventfd_max);
+
     view = address_space_get_flatview(as);
     FOR_EACH_FLAT_RANGE(fr, view) {
         for (i = 0; i < fr->mr->ioeventfd_nb; ++i) {
@@ -806,8 +815,11 @@ static void address_space_update_ioeventfds(AddressSpace *as)
                                              int128_make64(fr->offset_in_region)));
             if (addrrange_intersects(fr->addr, tmp)) {
                 ++ioeventfd_nb;
-                ioeventfds = g_realloc(ioeventfds,
-                                          ioeventfd_nb * sizeof(*ioeventfds));
+                if (ioeventfd_nb > ioeventfd_max) {
+                    ioeventfd_max = MAX(ioeventfd_max * 2, 4);
+                    ioeventfds = g_realloc(ioeventfds,
+                            ioeventfd_max * sizeof(*ioeventfds));
+                }
                 ioeventfds[ioeventfd_nb-1] = fr->mr->ioeventfds[i];
                 ioeventfds[ioeventfd_nb-1].addr = tmp;
             }
-- 
1.8.3.1



