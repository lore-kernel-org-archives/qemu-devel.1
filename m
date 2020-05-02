Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D7CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 19:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B932E206F1
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 19:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMPzcQo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B932E206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUxgU-00074k-Pa
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 15:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jUxf0-0005NI-Ie
 for qemu-devel@nongnu.org; Sat, 02 May 2020 15:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jUxez-00075n-OQ
 for qemu-devel@nongnu.org; Sat, 02 May 2020 15:18:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:50764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jUxez-00074W-C0
 for qemu-devel@nongnu.org; Sat, 02 May 2020 15:18:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id x25so3796131wmc.0
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 12:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7NBvj3io5bIDUt11G/p8i3F8zoH+A/C8brb6miv4isc=;
 b=qMPzcQo/8jJCxfSj5qn1crXUJF3MnvFavWAT6dWQyQp4Xjqs4xsElFQPQOnSZEV49V
 wBIy0AwWTobba8RXZoG1bxvKpaBcgIxQeK2lvGCosxGOLnoqiZkycY5m+gwi/CKvIf0r
 qY+WxJLAuahTzrozVdUqpNvGwie97EekpZdrzFOgQRc/qPpGb6GD58VSEWgAX22SZ/rt
 +3EMMY2BatjN/7KXjIMEwqfsPtobnxuQJd9aAEcu5tnEx8B7pbJdg4CjcHuBQFxPcftG
 E7cVQUHdlNRAw022BhTRgbbAUF+N2rYp6GfvtGl21uQvWIeFWNZWW5KsxSfCam54WoYA
 j+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7NBvj3io5bIDUt11G/p8i3F8zoH+A/C8brb6miv4isc=;
 b=H/LW0Mips/FTYc9RwwTdjxmsJEsU9MeFLBKd6V0FGd0qhGka2TePf6tgyyt6QHRuQm
 XIyIdemD+GU+i3grNaRHt1HPCXJpmfeiNCy5L/th/pmvPI/GFR6OtYJSCDwBmTqbPVvJ
 xFU3rvAvm+XfrbjpZeko5L7pqqcO7gs2mqfcKm9AoKQgQOI27FpF71E937JP+982Sdau
 d0UAsxt/PkXqaf+AbX1jpZgP4NJ7T3yLUAyn+IeCAxQvm608fsW+S+cwlCjjapyp7jKK
 2zKXZRVu8GTmgiYLn8F9APr7Y7SkujaRVv3fp6eCMsbqxnABPxgI9nBXLEfHDRzvl6gC
 A8cw==
X-Gm-Message-State: AGi0PuaAPi5XRmpH5qxHbKU0vMZAKZbuIn0ol4hAogzcCQ0TOiTuFTFe
 2EwQ8+8VpGHW0qKbTUxHk5xQO4QesXM=
X-Google-Smtp-Source: APiQypJPD+Wf5YXZ8Fu3h3TX+4TjOfiBThYwGT4SPC7QbnBTlSIiHNA8t6+WVSKPwaI0J3x+GgBciw==
X-Received: by 2002:a05:600c:2941:: with SMTP id
 n1mr6037221wmd.25.1588447127151; 
 Sat, 02 May 2020 12:18:47 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id k23sm5378441wmi.46.2020.05.02.12.18.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 02 May 2020 12:18:46 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [Qemu-devel] [PULL 1/1] hw/rdma: Destroy list mutex when list is
 destroyed
Date: Sat,  2 May 2020 22:18:42 +0300
Message-Id: <20200502191842.27250-2-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200502191842.27250-1-marcel.apfelbaum@gmail.com>
References: <20200502191842.27250-1-marcel.apfelbaum@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=marcel.apfelbaum@gmail.com; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::336
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
Cc: yuval.shaia.ml@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuval Shaia <yuval.shaia.ml@gmail.com>

List mutex should be destroyed when gs list gets destroyed.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
Message-Id: <20200413085738.11145-1-yuval.shaia.ml@gmail.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
index 73f279104c..698ed4716c 100644
--- a/hw/rdma/rdma_utils.c
+++ b/hw/rdma/rdma_utils.c
@@ -100,6 +100,7 @@ void rdma_protected_gslist_destroy(RdmaProtectedGSList *list)
 {
     if (list->list) {
         g_slist_free(list->list);
+        qemu_mutex_destroy(&list->lock);
         list->list = NULL;
     }
 }
-- 
2.17.2


