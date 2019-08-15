Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132DBC32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEDB5208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPigVSIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDB5208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5f5-0007pk-Dt
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1hy5Mi-00012G-Um
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hy5Mh-0001xU-VT
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:19:48 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:42814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hy5Mh-0001wf-RY
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:19:47 -0400
Received: by mail-qt1-x841.google.com with SMTP id t12so904592qtp.9
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xH2u0/l2SqxJvZU8OkINvq+WEc2i5lm3OL3evVav5e8=;
 b=PPigVSIvqqoUz+yKwIcmJpybQ2D2IxQ+eyIAXlsxj0q7rtVrAWBIH8wPb+ffMpJYoG
 2MbR7TXa4CyKQ3Oq9Nu4W2VGpxWx0o4vQRJkfknW2Q8UoKhNv2FBDwBvApu4j1RZYikX
 XYOiHj37u5KRZlTVTPN/uLQFtIkfwy/pnEjrkjhcW67WrllSPqgyatCa2XghRAMDzO9m
 XQeXIoGNZDHs+oGFcw7TRSGW8q6SnhCUoDPack8E6YVD16XNONq0+aGttdc2bAj3eupz
 3y7nEzA2aWDaHrzLYSAXqtNZmnMFA9SzEEvJ3E1FQibONWBZUozi2EVY8JjSw9rVHBgR
 BneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xH2u0/l2SqxJvZU8OkINvq+WEc2i5lm3OL3evVav5e8=;
 b=sjAiJ5IOPk9NDqxHMIKwXuuY8Vi/uwd9xcbj+joQls2fazD6TWqjaS945v+Y7Rrl+r
 9wTDCsQmdHXfKcgcNqoYiP7B9YRddrO7kYyvicB3g33+FzJbgjyxgT4ip3BH0ve2t2nR
 U6EAB1NDGLLTY1RDP5r7jA4o97WhOCOwK4vBadgJP0E59g00iBhwpsyYm63xqbladwlK
 HPN+8ZCaEjKCNCOs24eg43QYCsRaErAWZwdQfh8aRQw6d8pBePOFcRCqXuERHnvRTHtx
 1Fj4wMG936pRxkZtl3QJ1S0jqL03eBGr8xJ6st15/H8oTr62DgC8PxStnCyyRoUt7az5
 G69A==
X-Gm-Message-State: APjAAAVOEbdAVTGb2dA32l/4DEEIDFKFmZTB4GsObgYZqzmJaPE5Ezih
 WrftW7y332+ZgkfCyD8nJXgkIR1NDqZVXg==
X-Google-Smtp-Source: APXvYqzgokjF3SKSmsltzGEtxbxu7xkGLnYJd8upYJ7hbd9lCH/KDpn1KI7Zg6AlHKawBfmqNHV0bg==
X-Received: by 2002:aed:2e02:: with SMTP id j2mr1966540qtd.89.1565835587177;
 Wed, 14 Aug 2019 19:19:47 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:121::1])
 by smtp.googlemail.com with ESMTPSA id o5sm757943qkf.10.2019.08.14.19.19.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:19:46 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 23:18:57 -0300
Message-Id: <20190815021857.19526-11-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815021857.19526-1-vandersonmr2@gmail.com>
References: <20190815021857.19526-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH v5 10/10] linux-user: dumping hot TBs at the
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


