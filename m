Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5CBC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9A320663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbO/ja+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9A320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDocS-00006o-1T
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 08:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDnn2-0006QS-I7
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDnn1-0002gF-5H
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:20:12 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:43466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDnn0-0002NY-Nx
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:20:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id b2so14445765wrj.10
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 04:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e90s5GDKqF71kjDAM6KX7htm2byTtpgfT/7m3PaplCY=;
 b=fbO/ja+/0dTZk/p1OPkanWOwknUvvPsB8ZvfTdth3VJzomGE5GOC5OL5XvtvAeWm7C
 9VP4C8ofRqF/rObX0xH2cM8Vg3/S6m4QuTxCeG6Kow5tr+Zrm3Lc9x8Xf00Boh78dyJa
 VqF+WNiwQgi2tpjtjZ6dVe+kjR7/91m5OsgHR+0wFTPV8/3BwaM2p591d9PGfYoSSewS
 MaMhQq0snnOv0ta48DPVHLxUPn3TvhpJKqWpfkNUqpjvq4LvdSnJczSjf0TkwptMqjOK
 Dd5y95iq3+34ICpv6+a3s59psj3coSEXAceXL9MyJgTpCXCF7dL53c2JkGdaMKn/jzff
 +NUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e90s5GDKqF71kjDAM6KX7htm2byTtpgfT/7m3PaplCY=;
 b=oRzV1IXi9C6egyr1o819DATpJpztDeX3VzPoEaMJBg3a+9mJ3w2qVzrrqsc3NRyEYs
 ivcdQ80y2GMOpND+YHj9wNgrWp/tdCJFfoHj8hQYAgT5bej+Jn1FY7UQSZEYychvbR+C
 OsqgEYlXtbI9zMdfUzz9OFBejolHAQo9RvJNl+lQwn6U6xEOC5sSlP3n75x89j6XiemJ
 nPLZZD/mQ8hOVRUJsPJRaxflMKWKsbt4OekdtHGMeT2vQ6EWvlhgyI/O8Q2pQhmtXz91
 BeGKaBhZEJJur9yqceaEq18T33vUv/BfKRGn4fDTkr1usIUBqQYWBAydj2sSAx4s8zFr
 KOBQ==
X-Gm-Message-State: ANhLgQ0Is6uDGkVDHo+8cK8IeICbiksXhVzcyecog9sIIuYmr0JfQwK6
 3mzz3u5N1jWvm49wlaO0YnXQiZQQ4OgzBQ==
X-Google-Smtp-Source: ADFU+vtaaloOppJKIJRdFnj530OT9zBbONplkXFi8WZmA16hGZaM/grqL9Kd93FyGsjmchogrJS5zQ==
X-Received: by 2002:adf:df07:: with SMTP id y7mr1665646wrl.355.1584357608819; 
 Mon, 16 Mar 2020 04:20:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r9sm23178099wma.47.2020.03.16.04.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 04:20:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] Update copyright date for user-facing copyright strings
Date: Mon, 16 Mar 2020 11:20:06 +0000
Message-Id: <20200316112006.19107-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: John Arbuckle <programmingkidx@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the copyright date to 2020 for the copyright strings which are
user-facing and represent overall copyright info for all of QEMU.

Reported-by: John Arbuckle <programmingkidx@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu-common.h | 2 +-
 docs/conf.py          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index 082da59e852..d0142f29ac1 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -13,7 +13,7 @@
 #define TFR(expr) do { if ((expr) != -1) break; } while (errno == EINTR)
 
 /* Copyright string for -version arguments, About dialogs, etc */
-#define QEMU_COPYRIGHT "Copyright (c) 2003-2019 " \
+#define QEMU_COPYRIGHT "Copyright (c) 2003-2020 " \
     "Fabrice Bellard and the QEMU Project developers"
 
 /* Bug reporting information for --help arguments, About dialogs, etc */
diff --git a/docs/conf.py b/docs/conf.py
index 960043cb860..af55f506d5d 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -80,7 +80,7 @@ master_doc = 'index'
 
 # General information about the project.
 project = u'QEMU'
-copyright = u'2019, The QEMU Project Developers'
+copyright = u'2020, The QEMU Project Developers'
 author = u'The QEMU Project Developers'
 
 # The version info for the project you're documenting, acts as replacement for
-- 
2.20.1


