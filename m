Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29405C4741F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F462076E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCnCkIVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F462076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1hp-0007gn-QH
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 06:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL1bq-0008Hm-D5
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:02:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL1bn-0001KO-G5
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600855362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cT9d0kWx7W8f1InGcBfK9ss0HD7cg0vYKo4xIiLm6K4=;
 b=eCnCkIVMZXW6S9EMXMsEidLnTeB/tg6fkZyqU15iGNoseKjArTy5YR37ob5PGVo0EZHSQS
 lbWSDeZzCLGiTpGeSGB9mHMHPljNdcGTVE+EjNdFoVM3obJucJIj1YfYKT5+uOd/ZQ+4iU
 VBNgS//EIVOOAcnGsgFjV9WdqKEdx8w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-oBVDluYIM5GXa9zahNPKEw-1; Wed, 23 Sep 2020 06:02:38 -0400
X-MC-Unique: oBVDluYIM5GXa9zahNPKEw-1
Received: by mail-wm1-f70.google.com with SMTP id m25so2042441wmi.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 03:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cT9d0kWx7W8f1InGcBfK9ss0HD7cg0vYKo4xIiLm6K4=;
 b=GixeiOlPm1m9LdzA6EkpIe4TLKyeZIImOI7Mv3kMsbHBkn2Iy/KwxxO3l606a3PnRR
 jUtpPAavr70x4tQ6SgUPZVpTzJmx4vAUMqM7skR0beHHFodrTZCdHs33o9Gc2TjscW1B
 IqcSC6RlIIiYxkGPg8dp7xaa3T6bsjipglxsG5hKX6A/GWb+/gMDDGN1el0X7QtTbRyt
 eL64IqRXdR++AgUIbf2k9847A5+xi4RbgW4bKTow0TUOWGDRArXvEZM73djBPVMB7op1
 1bJtyn1vrGnmWHVTmVwlXSDlShqmehuJLGoBJEVfuM0gYBAwJIhp8ryHg0TVhPDSgIfw
 70yQ==
X-Gm-Message-State: AOAM530ZrK2KcmNTbO0cmc6Zp/DdYxLEBLKEWR5rHpQtDOaTUv2Q6lsi
 yK+CEFlUBYnjFwWj0bBabyjIYGt3A/DT00Ad2KQmE8yBBvk1BwABVmlPaL2f+MD1YueprzVPDvi
 C1UjkCYq2ckn76Yc=
X-Received: by 2002:adf:f190:: with SMTP id h16mr10400416wro.202.1600855357018; 
 Wed, 23 Sep 2020 03:02:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzFZSKv5EkW28efsDBlQa2LLR+DlXPzMU4i/rk6WMmnnTBcKYYiz4tEyCUpKgO4gTder7z4A==
X-Received: by 2002:adf:f190:: with SMTP id h16mr10400388wro.202.1600855356754; 
 Wed, 23 Sep 2020 03:02:36 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id n4sm29581314wrp.61.2020.09.23.03.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 03:02:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] qemu/bswap: Replace bswapXXs() by compiler
 __builtin_bswap()
Date: Wed, 23 Sep 2020 12:02:19 +0200
Message-Id: <20200923100220.674903-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923100220.674903-1-philmd@redhat.com>
References: <20200923100220.674903-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/bswap.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index d1a2f700f2a..6875e48d617 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -35,29 +35,31 @@ static inline uint64_t bswap64(uint64_t x)
 
 static inline void bswap16s(uint16_t *s)
 {
-    *s = bswap16(*s);
+    *s = __builtin_bswap16(*s);
 }
 
 static inline void bswap32s(uint32_t *s)
 {
-    *s = bswap32(*s);
+    *s = __builtin_bswap32(*s);
 }
 
 static inline void bswap64s(uint64_t *s)
 {
-    *s = bswap64(*s);
+    *s = __builtin_bswap64(*s);
 }
 
 #if defined(HOST_WORDS_BIGENDIAN)
 #define be_bswap(v, size) (v)
-#define le_bswap(v, size) glue(bswap, size)(v)
+#define le_bswap(v, size) glue(__builtin_bswap, size)(v)
 #define be_bswaps(v, size)
-#define le_bswaps(p, size) do { *p = glue(bswap, size)(*p); } while(0)
+#define le_bswaps(p, size) \
+            do { *p = glue(__builtin_bswap, size)(*p); } while (0)
 #else
 #define le_bswap(v, size) (v)
-#define be_bswap(v, size) glue(bswap, size)(v)
+#define be_bswap(v, size) glue(__builtin_bswap, size)(v)
 #define le_bswaps(v, size)
-#define be_bswaps(p, size) do { *p = glue(bswap, size)(*p); } while(0)
+#define be_bswaps(p, size) \
+            do { *p = glue(__builtin_bswap, size)(*p); } while (0)
 #endif
 
 /**
-- 
2.26.2


