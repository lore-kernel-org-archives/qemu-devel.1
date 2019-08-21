Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B16C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D829D22DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf4mS8n6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D829D22DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UXs-0001C1-Or
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i0ULC-0007vn-BR
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i0UL9-0000NC-9z
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:24:10 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:39297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i0UL9-0000Mv-6K
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:24:07 -0400
Received: by mail-qt1-x841.google.com with SMTP id l9so3981792qtu.6
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2vHSzjBBDOJZCdH5rqPViCfcareFW5HwMzJbdpbNj5s=;
 b=bf4mS8n65pIy3QcGxZGX6BJG6ljjC7XXxBCpVPKgCLzh73WJXFg2vqIdcF5pLM3OUS
 1IudgQUsWTazHmyIQdqTVhbso3IPVwSaGcPtq9B5Mfl7dJELu1G/Vj72Y8RBYUOYJ/ap
 dUe+GNC9jOw8K9pb17wNZJbayJ/6ihZNTFizIe96YQn8zvOK9+Hx+DtLhtOcRVi8xy2j
 G0XSaO4k9Rwf5QxGCJAhAtaWjrlEpAd4JVs2vS3TjTps+g4w/m9qGg5K+X3r/MVJI+W4
 6V92BXWZTwSFgfmNggfOGR2OiIl2I8otNjgXoQ9oUo/Vdxqvzc+tFc6H9BfKg+Mksn8M
 2wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2vHSzjBBDOJZCdH5rqPViCfcareFW5HwMzJbdpbNj5s=;
 b=TGa8a6iPQGqtf5j1O02h6VB/aAQ/sC4TKUkbUz3ojIjq+9Sk12GeBSG7Vjayedqd8s
 CettkIkW/EJH61LPzOYmrimGrV8/ma8VEAPYwgnx1xW5hx8D4uf7aou+t2MHuAGvpfx+
 +/f3iYQcUB5uz/TG1v2vM7QV/hMf0HR1omt2uM9eJvfuP4KKF9uP6DQwaDD1Q29KcH1L
 u58X+S2+prYJGsoludHFUYbTNN7RX0nganMRa3mXpYdnLKbbyCsjhx8BuTfSHy/uRLhJ
 PdJnn7n3eM9PEPcgxD1FwE5zzqJv2jK5ujQMq6RPlUYKGYf6Shc1cqMaiC3zCzVKTEgX
 3CxQ==
X-Gm-Message-State: APjAAAWVCLdikEYPJr8kCLQx/gocAI4T+b0sCOX7xF7Dsq+CRTqA+s9x
 VpFq7OV+EZE0W6kYDmllefvpOVnotxSqAA==
X-Google-Smtp-Source: APXvYqwVJE5va73RMTNg25hQrAG8Er6Rdsi39iEmCy0er9kWC+SBoDmVT5HCwJDMtvCigZIb0FHloA==
X-Received: by 2002:ac8:764f:: with SMTP id i15mr5061470qtr.194.1566408246520; 
 Wed, 21 Aug 2019 10:24:06 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166])
 by smtp.googlemail.com with ESMTPSA id a3sm9623998qtp.10.2019.08.21.10.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:24:06 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 14:23:29 -0300
Message-Id: <20190821172329.2062-11-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821172329.2062-1-vandersonmr2@gmail.com>
References: <20190821172329.2062-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH v6 10/10] linux-user: dumping hot TBs at the
 end of the execution
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
Cc: Riku Voipio <riku.voipio@iki.fi>, vandersonmr <vandersonmr2@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dumps, in linux-user mode, the hottest TBs if -d tb_stats is used.

Example of output for the 3 hottest TBs:

TB id:1 | phys:0x34d54 virt:0x0000000000034d54 flags:0x0000f0
        | exec:4828932/0 guest inst cov:16.38%
        | trans:1 ints: g:3 op:82 op_opt:34 spills:3
        | h/g (host bytes / guest insts): 90.666664
        | time to gen at 2.4GHz => code:3150.83(ns) IR:712.08(ns)
        | targets: 0x0000000000034d5e (id:11), 0x0000000000034d0d (id:2)

TB id:2 | phys:0x34d0d virt:0x0000000000034d0d flags:0x0000f0
        | exec:4825842/0 guest inst cov:21.82%
        | trans:1 ints: g:4 op:80 op_opt:38 spills:2
        | h/g (host bytes / guest insts): 84.000000
        | time to gen at 2.4GHz => code:3362.92(ns) IR:793.75(ns)
        | targets: 0x0000000000034d19 (id:12), 0x0000000000034d54 (id:1)

TB id:3 | phys:0xec1c1 virt:0x00000000000ec1c1 flags:0x0000b0
        | exec:872032/0 guest inst cov:1.97%
        | trans:1 ints: g:2 op:56 op_opt:26 spills:1
        | h/g (host bytes / guest insts): 68.000000
        | time to gen at 2.4GHz => code:1692.08(ns) IR:473.75(ns)
        | targets: 0x00000000000ec1c5 (id:4), 0x00000000000ec1cb (id:13)

Signed-off-by: vandersonmr <vandersonmr2@gmail.com>
---
 linux-user/exit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/exit.c b/linux-user/exit.c
index bdda720553..7226104959 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -28,6 +28,10 @@ extern void __gcov_dump(void);
 
 void preexit_cleanup(CPUArchState *env, int code)
 {
+    if (tb_stats_collection_enabled()) {
+        dump_tbs_info(max_num_hot_tbs_to_dump, SORT_BY_HOTNESS, false);
+    }
+
 #ifdef TARGET_GPROF
         _mcleanup();
 #endif
-- 
2.22.0


