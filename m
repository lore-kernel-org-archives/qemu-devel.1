Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8217C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 805C5205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scAMYkAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805C5205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtUo-00008r-6N
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:45:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtF0-0004nW-2f
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEz-00077m-0P
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:01 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:40442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtEy-00075p-OG
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:00 -0500
Received: by mail-wm1-x332.google.com with SMTP id t14so7384320wmi.5
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aB/U/Tf7guynfrwJbWpfYI+QRcweDccxGqmzLn8iwE8=;
 b=scAMYkAdJXxiRlfDh0u5udZNzctVpxvA1sYs2ON/nEpP/Ot+1weZ4Ocs53II+ZPGhv
 yYxtme4eBWPdx8A2MEqBAenJf46C450guJRWXlgaecJ1yb48mvifwFlOpSrop4FbV+a5
 Z59/5wx+Yt83c1vhQ8KMC3ZSyQ7YcBr2lD+1H76FUEApSY9eVO14Sp1wtwVmvcK6dcYy
 pb9Rw0Qcl7CVy9tmgaiWsTYqCjpdrOwovetn1SyOPjly1+LYYbbEcOK7Izv4Ptix4BxK
 77WAr5WkCS9DW2/i/RxD25tMuZ4xd5KiqsDnFyZZUKhHy+AaiP5TWCpGrr8JCzaCeAjc
 Aj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aB/U/Tf7guynfrwJbWpfYI+QRcweDccxGqmzLn8iwE8=;
 b=O3WPqzxgzxF5gZ5s1iiblnYb21k5wizD7eCv0xKDVsieWcUMSMt8uMzyGw2GxhBfSC
 Ut5cAKMu91bQV2u8xCw86h6U1tCVE1BCd3jcVpGobyPkmPcNkQwVmwGCo6+riDnio5Ug
 NYtMRyLjDa7sTZnM9EfEaaFuVtRcvr29eQPVcczNyxw4T+y7UONjHOBMv2qs/6oGxrl6
 wd2vCjVReOPUXoH9EeLag5leHm6/d95mrBCcnJH8D4ImZpAQoFvemr2Cnyx0oVp+LXzM
 Ylc2eE8sX5vyqHOaZUGgWJoJLiMJsqYYUHTOYOKKDsBfnNc7SFSMoIULsi39dTrkmjrT
 EMvA==
X-Gm-Message-State: APjAAAVT3eB+TGwh4VPI2/S3f1zqdbSXLGNUmiG8NFuRC/a/8fHEYxnq
 7YPWZl/9mgxlGuSVi/qhUHkop2IT
X-Google-Smtp-Source: APXvYqwfzzFLEKUntLhHIG3Slg0P9gtg9WBEpb13U+wqrNUlfBm9KrHSdb5LPHeypPULt6dnO846yQ==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr29872958wmf.60.1576513739538; 
 Mon, 16 Dec 2019 08:28:59 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.28.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:28:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/62] memory: do not look at current_machine->accel
Date: Mon, 16 Dec 2019 17:27:56 +0100
Message-Id: <1576513726-53700-13-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"info mtree -f" prints the wrong accelerator name if used with for example
"-machine accel=kvm:tcg".  The right thing to do is to fetch the name
from the AccelClass, which will also work nicely once
current_machine->accel stops existing.

Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/memory.c b/memory.c
index 06484c2..6d79cf1 100644
--- a/memory.c
+++ b/memory.c
@@ -2979,7 +2979,6 @@ struct FlatViewInfo {
     bool dispatch_tree;
     bool owner;
     AccelClass *ac;
-    const char *ac_name;
 };
 
 static void mtree_print_flatview(gpointer key, gpointer value,
@@ -3049,7 +3048,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
                 if (fvi->ac->has_memory(current_machine, as,
                                         int128_get64(range->addr.start),
                                         MR_SIZE(range->addr.size) + 1)) {
-                    qemu_printf(" %s", fvi->ac_name);
+                    qemu_printf(" %s", fvi->ac->name);
                 }
             }
         }
@@ -3097,8 +3096,6 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner)
 
         if (ac->has_memory) {
             fvi.ac = ac;
-            fvi.ac_name = current_machine->accel ? current_machine->accel :
-                object_class_get_name(OBJECT_CLASS(ac));
         }
 
         /* Gather all FVs in one table */
-- 
1.8.3.1



