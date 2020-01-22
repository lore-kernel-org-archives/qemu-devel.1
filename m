Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C42C2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21AE24656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nu9i+kDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21AE24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu69Y-00026A-9s
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65b-0005N6-5u
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu65a-0002hP-6O
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:49:55 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:54232)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu65a-0002h6-1C
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:49:54 -0500
Received: by mail-pj1-x102e.google.com with SMTP id n96so2388271pjc.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z7pbnhcun0cxDNFbutIi0zQ3uYITFRp+E+8VBAtnKcc=;
 b=nu9i+kDv2Ob4EV3nm4q66/93566r+ZfeJioCD6juZhUcRzQNCrLB3cYESSxk8ej4mX
 PrdusaPijQvrZq9DfT+Xk9owEEPTgcKM+nUbY4JpP2iTTxd9q1ISQYbdmWSly6/9hwzm
 e4Q7BhC8+QnbR7sN5b+LtRKbOV1ApQ7gxGHhk63rTmcEuaQdZLhrR76D7u2CBq9ZauaM
 F31eINm6OUuZALIdRHqyNcBuqQTmsv0WJxxdnM0VVbZN88p3r6SgNnIxEffEE8rayJ6s
 SzTtQNI4MW+0WYyQaNW5XJdNu/VSAcZS1+nPjnJt2BbPNUY/XMsntp0VgeqZrjDXOI1r
 usxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z7pbnhcun0cxDNFbutIi0zQ3uYITFRp+E+8VBAtnKcc=;
 b=GnbK+sDA45a8xm+cIkM23lQY9fWWsaS3h+EccExuDZbJf4YYQGLn995J/YD2vUIVKg
 t+VJ3nqQsCclqLxVKWiRt12dU0y2olwViyUhGcMX75XTX+LnQ65IISY2v3YLiLknY5rf
 8OmwAJqQlNbfqEj835hQ9+tj2ErWPVyQ+jVWU4rzJcYFrP4rryIfRgVfokoyUu76pdtC
 9tXsde/JdWtjxQ6NzWeU1AxeUDtDmI4yKaMvvijvJoH5nn2Tws/s3N4UK2D9XEzOAxRo
 RWpPc+Mdzq5cVYFwJskVhiRSqm9K7nJm/fbBAQ/WnIXhuvMm4covNMcmlgLAHc6zEuvD
 XdCg==
X-Gm-Message-State: APjAAAXnSfU77m9nDflfhyGJjN1vI6U4F5V34mI4+vljrOXcKCKOTbO+
 uA2KR4/uCJkhJq4krpKnx96jtQYSRwo=
X-Google-Smtp-Source: APXvYqxylTNRUiEwEnGZ26mfTWG9pKHdwGuuo2GZ3kjs6ysuDO0SgyHghAG3g0bczBJ8MvCZkh59tw==
X-Received: by 2002:a17:90a:d807:: with SMTP id a7mr432288pjv.15.1579661392834; 
 Tue, 21 Jan 2020 18:49:52 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id c22sm44149883pfo.50.2020.01.21.18.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:49:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/16] util/cacheinfo: fix crash when compiling with uClibc
Date: Tue, 21 Jan 2020 16:49:32 -1000
Message-Id: <20200122024946.28484-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122024946.28484-1-richard.henderson@linaro.org>
References: <20200122024946.28484-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102e
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
Cc: peter.maydell@linaro.org, Carlos Santos <casantos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Carlos Santos <casantos@redhat.com>

uClibc defines _SC_LEVEL1_ICACHE_LINESIZE and _SC_LEVEL1_DCACHE_LINESIZE
but the corresponding sysconf calls returns -1, which is a valid result,
meaning that the limit is indeterminate.

Handle this situation using the fallback values instead of crashing due
to an assertion failure.

Signed-off-by: Carlos Santos <casantos@redhat.com>
Message-Id: <20191017123713.30192-1-casantos@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/cacheinfo.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/util/cacheinfo.c b/util/cacheinfo.c
index ea6f3e99bf..d94dc6adc8 100644
--- a/util/cacheinfo.c
+++ b/util/cacheinfo.c
@@ -93,10 +93,16 @@ static void sys_cache_info(int *isize, int *dsize)
 static void sys_cache_info(int *isize, int *dsize)
 {
 # ifdef _SC_LEVEL1_ICACHE_LINESIZE
-    *isize = sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
+    int tmp_isize = (int) sysconf(_SC_LEVEL1_ICACHE_LINESIZE);
+    if (tmp_isize > 0) {
+        *isize = tmp_isize;
+    }
 # endif
 # ifdef _SC_LEVEL1_DCACHE_LINESIZE
-    *dsize = sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
+    int tmp_dsize = (int) sysconf(_SC_LEVEL1_DCACHE_LINESIZE);
+    if (tmp_dsize > 0) {
+        *dsize = tmp_dsize;
+    }
 # endif
 }
 #endif /* sys_cache_info */
-- 
2.20.1


