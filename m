Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821DFC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306A62145D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBK5gDSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306A62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1hp-0007d9-3w
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 06:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL1bm-0008Eb-2d
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL1bj-0001Jn-Bh
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600855355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/e6JgH5beo3D4jWhUD/I0gOipenUtz7n5NS7zMmoHHk=;
 b=OBK5gDSjMR71kt3G04EJPC8mm/WQ1NVZxDaGOsKqp99njtXcHw8Mvoa3XeOpi3grG7L5s/
 Q4orLxaoIkWbHjV0vdsLTbU+vDZ2D0Zwo1YGR2m2zHfiXjlaAPxMG85RkN7QB2LpoQ87OV
 DMEOq7GhSOhO4XAPu8rvWsMKizrT37Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-eIZFTD_4OR2N3uLDAOOe9A-1; Wed, 23 Sep 2020 06:02:34 -0400
X-MC-Unique: eIZFTD_4OR2N3uLDAOOe9A-1
Received: by mail-wm1-f72.google.com with SMTP id c200so2031232wmd.5
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 03:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/e6JgH5beo3D4jWhUD/I0gOipenUtz7n5NS7zMmoHHk=;
 b=r8ht9wrQH21KWFWsxMCTM7bEPbF6xBxkOOUEJgsKOPQBeRzylrjK7ipF/pXAI4UdMz
 wdWVhT3zqPTMXIUpgnOKHWIMEbPTyNlj9aJEq3Y+uaIKwf03naL+r35lmamjdO7dLsWi
 ht38k92/UnqFoyWqpiAVfpvz3NNzy9dmIxfoMXmvi/naDTd4k+10dyM2zeSnTjV/Kg0n
 +ewITsPO/0zM+OPZL0rIH5kkPSX9m5ZoNrHihewunu/eBRXD+n8OdL/qSO0gY9a6LNJJ
 h3NPZ1oPPT9XSgisAtViS/vKyefyAFX9RrgNwu2VKZqCZMiODyN6tibJxqyYwz+34YIl
 bDmg==
X-Gm-Message-State: AOAM532CfPZN5TpRm8jhcynqGbl1tM+pKnQ5pWwm5JRg18QNUqZKweUx
 oTBAgvdVkG+159XGA3DCrOF15jB8vaEpdaVfat4o+scKVwfyvbmjrWR7MEA77DnHWZ8aay5/TPz
 azr/q9N+QbUhURV8=
X-Received: by 2002:a7b:c151:: with SMTP id z17mr5888041wmi.53.1600855352231; 
 Wed, 23 Sep 2020 03:02:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6O0Qjf8oO9lpF3SbviWLdvjTkbe0E561qxviPht1e1wza+nbmlYbMMN1VHTGZHVXBxIqnsg==
X-Received: by 2002:a7b:c151:: with SMTP id z17mr5888021wmi.53.1600855352023; 
 Wed, 23 Sep 2020 03:02:32 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id v9sm31863826wrv.35.2020.09.23.03.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 03:02:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] qemu/bswap: Replace bswapXX() by compiler
 __builtin_bswap()
Date: Wed, 23 Sep 2020 12:02:18 +0200
Message-Id: <20200923100220.674903-3-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
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

Use the compiler built-in function to byte swap values,
as the compiler is clever and will fold constants.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/bswap.h | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 8b01c38040c..d1a2f700f2a 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -27,32 +27,10 @@ static inline uint64_t bswap64(uint64_t x)
 {
     return bswap_64(x);
 }
-# else
-static inline uint16_t bswap16(uint16_t x)
-{
-    return (((x & 0x00ff) << 8) |
-            ((x & 0xff00) >> 8));
-}
-
-static inline uint32_t bswap32(uint32_t x)
-{
-    return (((x & 0x000000ffU) << 24) |
-            ((x & 0x0000ff00U) <<  8) |
-            ((x & 0x00ff0000U) >>  8) |
-            ((x & 0xff000000U) >> 24));
-}
-
-static inline uint64_t bswap64(uint64_t x)
-{
-    return (((x & 0x00000000000000ffULL) << 56) |
-            ((x & 0x000000000000ff00ULL) << 40) |
-            ((x & 0x0000000000ff0000ULL) << 24) |
-            ((x & 0x00000000ff000000ULL) <<  8) |
-            ((x & 0x000000ff00000000ULL) >>  8) |
-            ((x & 0x0000ff0000000000ULL) >> 24) |
-            ((x & 0x00ff000000000000ULL) >> 40) |
-            ((x & 0xff00000000000000ULL) >> 56));
-}
+#else
+# define bswap16(_x) __builtin_bswap16(_x)
+# define bswap32(_x) __builtin_bswap32(_x)
+# define bswap64(_x) __builtin_bswap64(_x)
 #endif /* ! CONFIG_MACHINE_BSWAP_H */
 
 static inline void bswap16s(uint16_t *s)
-- 
2.26.2


