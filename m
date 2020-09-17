Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F90C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF182078D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASeobSNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF182078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwuo-0007Gn-F0
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIwon-0000ef-Hz
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:31:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47135
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIwoi-0000wD-HL
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600360287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ZmkCbrQPhSlo4AKl7/h3xZk9pphOh2PK1eFykfuhSU=;
 b=ASeobSNEYMPjAa0/wUEcMUB2FYIqjfn+RDOlKR0eUZgPj1z756PATQEtHncXkM07NdTfoF
 EuipU2UpSXfj6uEtrzA1m81qLDtVEaNxqjjKjO3KHFHEhpTffBH42Eb+9V2s8XOlgRenvE
 Fw9d9BD6tlK5lPCdlTXtZA6iWHgbtx4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-aeB4kjj1OCaVURN_tsjCjw-1; Thu, 17 Sep 2020 12:31:24 -0400
X-MC-Unique: aeB4kjj1OCaVURN_tsjCjw-1
Received: by mail-wr1-f70.google.com with SMTP id a10so1075880wrw.22
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 09:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6ZmkCbrQPhSlo4AKl7/h3xZk9pphOh2PK1eFykfuhSU=;
 b=S+jgpwdI38eMyg3eOXKJM274tssTJ8mEmEFa7gYSOQ9Agsr2ZTdmg+XwIxSxAbPprK
 PF8W2GcP0kq7IBIGXf88QjJ8SY2u7Vj1uk83TqDyOBeXwb1UHm24rS3i39/LMJJwcfzF
 JuTaW0Sovo/OjZNnDWWM1qj1+75a2EXXmKwVJZucOtBVSlY0/v9PfL6tpSYAB9hZKdqf
 kUhNRo/8uScW+sHByfUo3hugDiG4wwhwSRpP7Sk9U8Ao+yrJxvtA0/jvNGPJ83WwDqR7
 yoFMx5CucnZ+clNKwTtHnCUGVSHNut1i9acoF+/bqv57WLnS8B7sL+bJu7il7M4BsoZu
 cJSg==
X-Gm-Message-State: AOAM533GHmEan68wISmaAlmRzHdoHwqHivXPpLkU+FMWi0dXyVnv0XO6
 WVbZM4hexkm0U5FA/DnPc7t1/yCf7hnTspXyLw4YxDYmM4tnPzDlo2yi2T6mrFEq/Hp4Ku2HzrG
 UX6hahF7ur4P+WoY=
X-Received: by 2002:a5d:4710:: with SMTP id y16mr34235502wrq.203.1600360282852; 
 Thu, 17 Sep 2020 09:31:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwapxxBJVC5uenbUEU+ecvr+hoB+fQfG/HnlNuPjZ/ihRa69d9gvA21veTVXB0QNXjsmzqkwg==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr34235487wrq.203.1600360282668; 
 Thu, 17 Sep 2020 09:31:22 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id s80sm38921wme.41.2020.09.17.09.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 09:31:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] qemu/bswap: Add const_le64() and const_be64()
Date: Thu, 17 Sep 2020 18:31:05 +0200
Message-Id: <20200917163106.49351-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917163106.49351-1-philmd@redhat.com>
References: <20200917163106.49351-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 09:24:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We already have the const_endian() macros for 16-bit and
32-bit values. Implement the 64-bit equivalent macros.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/bswap.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 6885984e00c..de256cea3ab 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -83,11 +83,20 @@ static inline void bswap64s(uint64_t *s)
 #endif
 
 /*
- * Same as cpu_to_{be,le}{16,32} described below, except that gcc will
+ * Same as cpu_to_{be,le}{16,32,64} described below, except that gcc will
  * figure the result is a compile-time constant if you pass in a constant.
  * So this can be used to initialize static variables.
  */
 #if defined(HOST_WORDS_BIGENDIAN)
+# define const_le64(_x)                          \
+    ((((_x) & 0x00000000000000ffU) << 56) |      \
+     (((_x) & 0x000000000000ff00U) << 40) |      \
+     (((_x) & 0x0000000000ff0000U) << 24) |      \
+     (((_x) & 0x00000000ff000000U) <<  8) |      \
+     (((_x) & 0x000000ff00000000U) >>  8) |      \
+     (((_x) & 0x0000ff0000000000U) >> 24) |      \
+     (((_x) & 0x00ff000000000000U) >> 40) |      \
+     (((_x) & 0xff00000000000000U) >> 56))
 # define const_le32(_x)                          \
     ((((_x) & 0x000000ffU) << 24) |              \
      (((_x) & 0x0000ff00U) <<  8) |              \
@@ -96,11 +105,22 @@ static inline void bswap64s(uint64_t *s)
 # define const_le16(_x)                          \
     ((((_x) & 0x00ff) << 8) |                    \
      (((_x) & 0xff00) >> 8))
+# define const_be64(_x) (_x)
 # define const_be32(_x) (_x)
 # define const_be16(_x) (_x)
 #else
+# define const_le64(_x) (_x)
 # define const_le32(_x) (_x)
 # define const_le16(_x) (_x)
+# define const_be64(_x)                          \
+    ((((_x) & 0x00000000000000ffU) << 56) |      \
+     (((_x) & 0x000000000000ff00U) << 40) |      \
+     (((_x) & 0x0000000000ff0000U) << 24) |      \
+     (((_x) & 0x00000000ff000000U) <<  8) |      \
+     (((_x) & 0x000000ff00000000U) >>  8) |      \
+     (((_x) & 0x0000ff0000000000U) >> 24) |      \
+     (((_x) & 0x00ff000000000000U) >> 40) |      \
+     (((_x) & 0xff00000000000000U) >> 56))
 # define const_be32(_x)                          \
     ((((_x) & 0x000000ffU) << 24) |              \
      (((_x) & 0x0000ff00U) <<  8) |              \
-- 
2.26.2


