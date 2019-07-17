Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A81C76188
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8341B20818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/51wm0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8341B20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZmO-00056f-Cz
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52997)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlG-0000d2-Mp
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlF-00069C-MZ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:42 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shirley17fei@gmail.com>)
 id 1hnZlF-00068T-GV
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:41 -0400
Received: by mail-pg1-x544.google.com with SMTP id u17so10369559pgi.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 19:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=giSB4Ucoh3BMg4F8CjK3a1ECxOO/Z7JkMiX8m5yVGtE=;
 b=f/51wm0oZoms9b5O0WaTRS+Qc26r2WG3ixLaYATK/V1p6jQ7zpo3WseP43RiQZlopp
 /zzFmmtM9XDpwncklTOdIzf9Hm07nHv4aAwpoDst0bExRMvJkOYr4gkD5hIBtIoY8w+d
 otdc5Dx9eNXzSw4aVmkg4gIRhd6ByJqCT/SheWQrNV8ttz0AzCEiZ1FZ1eUH9yADu21/
 xC4CNBWLnO81K3YKkScd58Doq2t3VePflUXWwYU6yqB11hUzcssxHG1aXoIxyCsGVjs/
 BWp08hUN1zCRXe5Nc9yDWt7PwD0gxzbXnN/oaaH0VUi8P2mf2OW7r1L7deoHRjIshIpc
 J9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=giSB4Ucoh3BMg4F8CjK3a1ECxOO/Z7JkMiX8m5yVGtE=;
 b=R7bQsfSheT/kv3zkO9QK3q9eUv5H2x8aU2EVhfsVWsdfdw+q7qt/bsIxLeNvP3NR7C
 XeRZoO0Umi7HsqLZIp0zwphUt8sfgQho2KPM9QgznoJ+jD5GpQ9E23TP14m5/rQWMk6O
 9Yg8J5oVxY2JX8M2uxlzjkOjIyhpA29sADaE/smepZLDZsOA4DnKcdKXZdv7P1y4+KMb
 bPhOIMeyUuVAYs3nKIzIS8d2nYLnsgmAxmFKrSIgpZRDjBW7uZ2r8nz8JE0Fq1lZ4FfK
 FyLlKTDCFtsNLI1bONb6WId1kv5mRaJUy/BnTOQDjWCflL/oau8cveixE6iV2OcsjNtZ
 j+4g==
X-Gm-Message-State: APjAAAX2lqeaLLynTwLHl8qlIXshTSdz72vU+HZ2SvzblL+na/ivkP8b
 rK2C3xfcX9EOLP8pMKd1FcaEtchk
X-Google-Smtp-Source: APXvYqzIhrdHKgfc9k/0hF/BuyPWMa4K+iO50xdokyULC/oxqCZxariiNn7TCVaHAk/Vy6CtT/hG1A==
X-Received: by 2002:a17:90a:30e4:: with SMTP id
 h91mr39036719pjb.37.1563330820297; 
 Tue, 16 Jul 2019 19:33:40 -0700 (PDT)
Received: from n3-021-211.byted.org ([49.7.44.72])
 by smtp.gmail.com with ESMTPSA id b1sm20986530pfi.91.2019.07.16.19.33.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 19:33:39 -0700 (PDT)
From: Fei Li <shirley17fei@gmail.com>
To: qemu-devel@nongnu.org,
	shirley17fei@gmail.com
Date: Wed, 17 Jul 2019 10:33:03 +0800
Message-Id: <20190717023310.197246-5-shirley17fei@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190717023310.197246-1-shirley17fei@gmail.com>
References: <20190717023310.197246-1-shirley17fei@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v14 04/11] qemu_thread: supplement error
 handling for pci_edu_realize
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
Cc: Jiri Slaby <jslaby@suse.cz>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Fei Li <fli@suse.com>, Gerd Hoffmann <kraxel@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fei Li <fli@suse.com>

Utilize the existed errp to propagate the error and do the
corresponding cleanup to replace the temporary &error_abort.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hw/misc/edu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 1edc66955a..632b56f64c 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -371,9 +371,14 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
 
     qemu_mutex_init(&edu->thr_mutex);
     qemu_cond_init(&edu->thr_cond);
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
-                       edu, QEMU_THREAD_JOINABLE, &error_abort);
+    if (qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
+                           edu, QEMU_THREAD_JOINABLE, errp) < 0) {
+        qemu_cond_destroy(&edu->thr_cond);
+        qemu_mutex_destroy(&edu->thr_mutex);
+        timer_del(&edu->dma_timer);
+        msi_uninit(pdev);
+        return;
+    }
 
     memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
                     "edu-mmio", 1 * MiB);
-- 
2.11.0


