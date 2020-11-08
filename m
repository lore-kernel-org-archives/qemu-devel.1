Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40942C388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 00:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A3C20637
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 00:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H556+yaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A3C20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbueQ-0005mv-0v
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 19:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuao-0002R3-IL
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:59:32 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:36677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbuam-0003kW-3P
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:59:29 -0500
Received: by mail-wm1-x32b.google.com with SMTP id a65so6394947wme.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 15:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4BDK1OdVhkHxYI4RuGD+bZ9/TQAVxFpBI14wvUGciOI=;
 b=H556+yaCCOXc4pskGuonLR6REogaUV3KaipzB3UQmBMhAXGv3+TksSpqIHmGfJRBfM
 f+pJX7XR8HSy89kkH112V2EO7w+bWSrwpdvq/+YbP5aYmv5kpUGrlOCtpRIA2UNiqyQq
 VZZD3h0yuHZjhUg2KTr09OIFMfk2+jPKy7Qc3jrpAQbIBwg8ynprb4Akmx5N1GI/ZurG
 r1cVgnhPQOw7Biqax8pkwpn1m5D00zWQ6SPgHaAEfW9aieuu/zo4S+CK7NdM0d2BkL2Y
 nG8UqCdVJLMfnzqbI5fqmO+aILF06Bhx15fL5AikmRCpkHNMrizGdLh4xm+AZp7f0l7K
 F2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4BDK1OdVhkHxYI4RuGD+bZ9/TQAVxFpBI14wvUGciOI=;
 b=J/LUv+3oUBOe2lC/DRwvV9K3P22I9EaKlQUMqdZB8jpOC+ZCpdQErq+0OyJXB2SaTE
 qyRg/bUdBJYP9x90baZn7749rBGcahnqYd7UP8zrUVfDGlJErXex/v2WHnJSypNi+ZeC
 mHZmox9m+k2XS0aAwwB/IGcReTdj9TAm4wcqg+RjQw7e5B5lONyTPzSYkzBdyR0emzxF
 uclO45GBGvOWPyLcgMOLsiP7M0Z9SMC1S0cThFLdpqgURbW8e1LxTk2sB2PGa9GMTEEH
 WxIpqaK+PxBF0UIdZ+wrf+R3/ix9xVOAXgnySKHQGlxkVKpK/3SjFthj3FVG2AM9omSQ
 9K4w==
X-Gm-Message-State: AOAM533PONpOv+g2aXdfQLGD8Z1a+v0sgemGtsjll3K9rp1RrR+uQZFH
 iRdew+kIk0mxoI7kr3MAaoaGSDFP0ro=
X-Google-Smtp-Source: ABdhPJx0qnLPryISIT9lcv3/iXTeB8tbx63iY20lWUHiJNKFfB9N3HT8NV2FnKmss1DDgO0Fd0PEKA==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr10974537wmj.109.1604879966661; 
 Sun, 08 Nov 2020 15:59:26 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v8sm10874688wmg.28.2020.11.08.15.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 15:59:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] hw/rx/rx-gdbsim: Fix memory leak (CID 1432307)
Date: Mon,  9 Nov 2020 00:59:15 +0100
Message-Id: <20201108235915.2396150-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108235915.2396150-1-f4bug@amsat.org>
References: <20201108235915.2396150-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As load_device_tree() returns allocated memory,
we need to free it.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Fixes: bda19d7bb56 ("hw/rx: Add RX GDB simulator")
Reported-by: Coverity (CID 1432307: RESOURCE_LEAK)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201102104542.2064745-1-f4bug@amsat.org>
---
 hw/rx/rx-gdbsim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 417ec0564b3..285549c79b5 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -122,9 +122,8 @@ static void rx_gdbsim_init(MachineState *machine)
         if (dtb_filename) {
             ram_addr_t dtb_offset;
             int dtb_size;
-            void *dtb;
+            g_autofree void *dtb = load_device_tree(dtb_filename, &dtb_size);
 
-            dtb = load_device_tree(dtb_filename, &dtb_size);
             if (dtb == NULL) {
                 error_report("Couldn't open dtb file %s", dtb_filename);
                 exit(1);
-- 
2.26.2


