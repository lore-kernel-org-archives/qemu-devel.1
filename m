Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF366C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 910FE21726
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inmkQyMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910FE21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3No6-0003v4-KR
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3NbA-0006Yt-UK
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3Nb9-0006U0-S2
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:36 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:42319)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i3Nb9-0006SK-N8
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:35 -0400
Received: by mail-qk1-x741.google.com with SMTP id f13so3478335qkm.9
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eIyOQ+zPZUw8zXyJxqloCxuHMSH9TDYN6ZH48z46XB8=;
 b=inmkQyMx73qSOv+Rs2r1RyzHITGmva3wn6EO9qZ6wMHYwu1Ok0Z1b6g7ZxW7RF58Ig
 G348yf1BePgQKirsPd6F4TtCk8xDm0QSohZzUuU2ziprgv1AbCIPReaj4JXVCOARZC9f
 DGo7pNHNCminY0hF+R/VsOxtuwKeR/DSuFTr5OmN/4yins6hT0E92NJNRTfOc+Ew5CfB
 edh5xwBaiiH/Mq2j/UjzW3uBuLMXP8vt8/xNHEEPO+GnpSWoQpIazXK1l8uJ/8DoTpbq
 /W6Ir8v4twCcmXAApP9YZb0hSSHdccuwaNnybG2woP0pXOAzLZEAsEgUdWEHySsfQRNj
 whKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eIyOQ+zPZUw8zXyJxqloCxuHMSH9TDYN6ZH48z46XB8=;
 b=gwi5+fZjcSKStAULj4XPNS5zI59Bj70pQtZwa3pxGuV1snI8+Rae/4UhpbTG3Ozu9P
 Gcxd0LiPZ5Hjxa1YCxqIYuOIPiu85qAkXcWqDdmHzjBZO6HguvQwQ6JH12vLeWo3fy9q
 Z9U6mIX0BDmMVZO/ibGPzUG+AOmItcNBUkXYjStctV3auahcpvWB9IzFVF+S+Yb8aqoL
 K22uaGBePr/By2s8wueQJIUb8BEj4k/I5JZprIYiDCgCLBSALFnZIyQnh6QxP6blCw38
 8XG5ivHY5hr1L63l+1s/TFGZGTsZg68VD7TUgHYOZOOshns1gcLWmZxljutD3NPu6lQJ
 QrAQ==
X-Gm-Message-State: APjAAAVOU22ZLpLj0eNWDaZzejLYoUoUZsGjueDiFG7mqtjoxlSzO06L
 2lvXeD9ZzoyRgkVE2q91nf/V46K5v2JSpA==
X-Google-Smtp-Source: APXvYqzEsMAAoqtYc4JkxrBCp6zUMOLiOXygyvD8ZssExeCX98XJDioVrQOa4qj2g1lQVERylHxf5w==
X-Received: by 2002:a37:92c6:: with SMTP id u189mr10028790qkd.69.1567097313685; 
 Thu, 29 Aug 2019 09:48:33 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166])
 by smtp.googlemail.com with ESMTPSA id g25sm1441024qkk.87.2019.08.29.09.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 09:48:33 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 13:47:54 -0300
Message-Id: <20190829164754.3906-11-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829164754.3906-1-vandersonmr2@gmail.com>
References: <20190829164754.3906-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: [Qemu-devel] [PATCH v7 10/10] linux-user: dumping hot TBs at the
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

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
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


