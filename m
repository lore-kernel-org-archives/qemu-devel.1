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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AA0C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31552077B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCSO46mq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31552077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Nfe-0003br-J9
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3Nb3-0006P8-EH
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3Nb2-0006LB-2R
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:29 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:40618)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i3Nb1-0006Kt-Ul
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:28 -0400
Received: by mail-qk1-x743.google.com with SMTP id f10so3549724qkg.7
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=trBE4Pt415G810pTzI+AXLcczqBsJRYpVn3faZnlzM8=;
 b=GCSO46mq6c15ABLizl3xQsHquZ5Ga1dApzRydZweXqbbKxhRQ0Az5n1IvRTWwse8yC
 gzRYq43ltBJbbd1XLcmTj5YYpXZedVy+dZiERtbzjtuYPZO6gvGNTaOUDpTGNxTvj2OH
 ERnbkKIHpKYOsCnCb6SyJvCg+tSJBv3wA8KNDoj5Jymg+52CFQ7KBMHX9slkplwSUYH1
 0Wtt6LpNat2L5P8umU1Bq3DAF2IOz+equgMOOXEhKqGt59ADkzbvnNEQYjo6muZLsmX9
 R7W4M9L9nCwb/KoJejIMYUQZzwDyju4QMtbCChIpbFAUIPbgiRVoSLQVfBRuJSHwuRUh
 /MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=trBE4Pt415G810pTzI+AXLcczqBsJRYpVn3faZnlzM8=;
 b=WmLByhZHh76Jj9PnqUTJHNYbxcqRnCOaYqG9dR7/yuo3qBnRBv5t5l1LzueZyI0zcV
 q7DqtkTBSLxYAXkRHBEC/WeK5yqod5ypEt0XKVw7GpbtyLo2I/WL4Rb3R0TNQQ+79JeG
 Qq0GmOWZWcm+Ih1R+PYOno6BoI0LFP2lDlKx4idS61BFFT1abkjzfguToVXDOUbuIK2L
 TeH6F/5efrSXzzEvON1uYqCyv3kNybGTelllOwsM7v2Kfus4BkHbvqnz7j20vjcANDwQ
 s5tl9qw0BGJl+9Fni3bTbV014yWfUQ2gD8pu31AtZRN1I7I1+3a0L4XY2NuSsrnYrmGa
 iM5g==
X-Gm-Message-State: APjAAAXNWWDY1udJ+U9TZryHGIEAGB8RjbB4xrpP6CrwSiGsmJBRPsHE
 9N8mgssSpPqn3zDeiUZwX75NB5151bV1/A==
X-Google-Smtp-Source: APXvYqy3MXTB1DoDAbzh3Fl0KWrzDlda0jzcoPivskf6UlkUaem1EpWsOQoYutsLbYOjcvEOX9A8hg==
X-Received: by 2002:a37:98f:: with SMTP id 137mr10623316qkj.188.1567097307093; 
 Thu, 29 Aug 2019 09:48:27 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166])
 by smtp.googlemail.com with ESMTPSA id g25sm1441024qkk.87.2019.08.29.09.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 09:48:26 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 13:47:51 -0300
Message-Id: <20190829164754.3906-8-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829164754.3906-1-vandersonmr2@gmail.com>
References: <20190829164754.3906-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: [Qemu-devel] [PATCH v7 07/10] Adding tb_stats
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


