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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D283C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:46:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AB72189D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQH0O6mO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AB72189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3OV0-00080A-05
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3OKP-0004yF-5k
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3OKK-0000KE-VM
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:35:19 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:35629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i3OKK-0000K0-Qp
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:35:16 -0400
Received: by mail-qt1-x842.google.com with SMTP id u34so4610947qte.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=trBE4Pt415G810pTzI+AXLcczqBsJRYpVn3faZnlzM8=;
 b=AQH0O6mOJlGI86cMKIb5DWjc2s9ZiCocSaidNM0oR70tD2kyltsqYT7KxQDy6zlpAp
 v0DfbLMOuYlX15L8iuHVSmk0+gqoax7kx8o1TXsaHagWD92tzekpapXpzUvUhnpYg+iL
 ir0EUjeyc5dXX21gLfaOY+4nMl+krT9A1zVnk+McC9zYeIr4/u4dRa/WW6EiBVu8OKNU
 UAHns7042df+zumoNrREpgo+tMvBJ0YEdIRB9udPzPjf+9hOoClVo0r/gVylPUi8D1fR
 dRgdUojjCdbhfuFnGv7aaxpkWMiggMxns9sBvkbrZStWohctOS1BLmOelNQraG0v6Qei
 JKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=trBE4Pt415G810pTzI+AXLcczqBsJRYpVn3faZnlzM8=;
 b=IeeRo3B9rIi22Q/khRfc3zvZUyss++bxLyynQeIzGkTugIf/wujv9ee2zBQPwqYO6l
 HJa8JjvFW43tzM6AgITASovb88K4kKUoixd/U1qElNYnzkV2nr5vu4xG/jg7wtLsSJXe
 7RqITHZu5gwTILXvb7BQjcx1MlzgdoLm1LSG91IeAyo+FZ89gRnQUXQmWT6pLzFvkwz7
 pv8NdFehod8sGDlACjCk6qd/KjsAu8ho24EeTrVQKXszUEeeH5XgbE6dRYZLjscmtHEa
 DWKZlYdADjFJgsbCciY1SfseJVbozjsy8fPwJQuk9905CeM6AIZxv2qVeQh26mt2qjNt
 SNIA==
X-Gm-Message-State: APjAAAXY/FA49QH6qGmrkz9vRWgzQ+OV0+unoEDVlB0DjBgqub3daAu9
 IygHrONIdLnvMM8sVUAoGJCrIPSTGz9DyA==
X-Google-Smtp-Source: APXvYqw3oHtG0Djhto+bkyvb06vgi9CX5agW5WQsts4TjIHbb9hhhYQOxg65+g4U8AqhK+/jTOYYJw==
X-Received: by 2002:ac8:180e:: with SMTP id q14mr11020483qtj.327.1567100116017; 
 Thu, 29 Aug 2019 10:35:16 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166])
 by smtp.googlemail.com with ESMTPSA id j50sm1721700qtj.30.2019.08.29.10.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 10:35:15 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 14:34:34 -0300
Message-Id: <20190829173437.5926-9-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829173437.5926-1-vandersonmr2@gmail.com>
References: <20190829173437.5926-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: [Qemu-devel] [PATCH v8 08/11] Adding tb_stats
 [start|pause|stop|filter] command to hmp.
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
Cc: vandersonmr <vandersonmr2@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows controlling the collection of statistics.
It is also possible to set the level of collection:
all, jit, or exec.

tb_stats filter allow to only collect statistics for the TB
in the last_search list.

The goal of this command is to allow the dynamic exploration
of the TCG behavior and quality. Therefore, for now, a
corresponding QMP command is not worthwhile.

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 monitor/misc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/monitor/misc.c b/monitor/misc.c
index b389ca09a1..218263d29a 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -74,6 +74,8 @@
 #include "sysemu/cpus.h"
 #include "qemu/cutils.h"
 #include "tcg/tcg.h"
+#include "exec/tb-stats.h"
+#include "qemu-common.h"
 
 #if defined(TARGET_S390X)
 #include "hw/s390x/storage-keys.h"
-- 
2.22.0


