Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09867C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87640214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fw3T342b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87640214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwqs-0002AQ-KB
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIwoa-0000Pt-7v
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIwoY-0000ug-C9
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600360276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUx+wxXE+REYjw2JhAsBHYVliaS15koys54VhdQ8whA=;
 b=fw3T342bUgpxT3i4dfiOHKmyClmNjM/ZlerwLCsletl5COjS336Tz6eACzr89PlalvRlu6
 nWt/GfoUpERgXbGNxnSWNzQb7xMab0o0b7LmV4voI+uCFajO9c7JdyM6ns+kCX/qjGEwls
 I6ymrpVUou+XBmzhH799cGrX6J8ciWI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-Mz6pEmXfOP2hVhhBpqo0qA-1; Thu, 17 Sep 2020 12:31:14 -0400
X-MC-Unique: Mz6pEmXfOP2hVhhBpqo0qA-1
Received: by mail-wr1-f72.google.com with SMTP id x15so1083552wrm.7
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 09:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XUx+wxXE+REYjw2JhAsBHYVliaS15koys54VhdQ8whA=;
 b=ev7o4DIkpZG5GwwgcECNKo9MMJm56YPXXbe+6JGmBXD6oxI8lUwKQ3WqSR05NvWTXO
 m3PpOSBesnedWyvyo8cAycz40Js7shu0WcyElyP212q/iT+EfvpJnSytfUSSs2o9pNVv
 iMw18M5xy2Tli1RSF1PPh1mpKv8X5JQN/Dbzgb9oj2aKtAxjrCdKyJA+M2PxTKXsz06l
 iGiCQx/0Z3PMccB6mIY4JCXHHk+yT0aFp8By3p5atFczM4iuLdOCtpAMy9U3UIRy/I4g
 MIIl4dnp0mODtpA06nrBU7yqFj3dXNLCt/qRJpOPer/n3gCKkjXgXpLBCHnzKIFbHgC7
 vh+w==
X-Gm-Message-State: AOAM531HXDENxYFFh6nWbCraSTyeu4WV5EFbD7YJjs0yMOobH8RjHaeZ
 WoWeiWMBopn7b5xCMfKLokSDHE0Cy8wHQ7ehOrwHclr4aN4I5Obk6MtbwINfwI1ScCrn9yYoLjT
 R2OKLHS2U3chpTdY=
X-Received: by 2002:a1c:7418:: with SMTP id p24mr10866680wmc.123.1600360273214; 
 Thu, 17 Sep 2020 09:31:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzor+7GYLXEZMyW5/heb19MinyS2qVs6aaYDwSzOhSs7jtOt1BnNonG6FCWL8PMHDRpRd7i0Q==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr10866656wmc.123.1600360273030; 
 Thu, 17 Sep 2020 09:31:13 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t15sm161221wrp.20.2020.09.17.09.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 09:31:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] qemu/bswap: Move const_le() definitions around
Date: Thu, 17 Sep 2020 18:31:03 +0200
Message-Id: <20200917163106.49351-2-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we want the cpu_to_endian() macros use the
const_le() macros, move them earlier, so they
are defined when we use them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/bswap.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 1d3e4c24e41..c3b4277342b 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -82,6 +82,25 @@ static inline void bswap64s(uint64_t *s)
 #define be_bswaps(p, size) do { *p = glue(bswap, size)(*p); } while(0)
 #endif
 
+/*
+ * Same as cpu_to_le{16,32} described below, except that gcc will
+ * figure the result is a compile-time constant if you pass in a constant.
+ * So this can be used to initialize static variables.
+ */
+#if defined(HOST_WORDS_BIGENDIAN)
+# define const_le32(_x)                          \
+    ((((_x) & 0x000000ffU) << 24) |              \
+     (((_x) & 0x0000ff00U) <<  8) |              \
+     (((_x) & 0x00ff0000U) >>  8) |              \
+     (((_x) & 0xff000000U) >> 24))
+# define const_le16(_x)                          \
+    ((((_x) & 0x00ff) << 8) |                    \
+     (((_x) & 0xff00) >> 8))
+#else
+# define const_le32(_x) (_x)
+# define const_le16(_x) (_x)
+#endif
+
 /**
  * Endianness conversion functions between host cpu and specified endianness.
  * (We list the complete set of prototypes produced by the macros below
@@ -175,25 +194,6 @@ static inline uint32_t qemu_bswap_len(uint32_t value, int len)
     return bswap32(value) >> (32 - 8 * len);
 }
 
-/*
- * Same as cpu_to_le{16,32}, except that gcc will figure the result is
- * a compile-time constant if you pass in a constant.  So this can be
- * used to initialize static variables.
- */
-#if defined(HOST_WORDS_BIGENDIAN)
-# define const_le32(_x)                          \
-    ((((_x) & 0x000000ffU) << 24) |              \
-     (((_x) & 0x0000ff00U) <<  8) |              \
-     (((_x) & 0x00ff0000U) >>  8) |              \
-     (((_x) & 0xff000000U) >> 24))
-# define const_le16(_x)                          \
-    ((((_x) & 0x00ff) << 8) |                    \
-     (((_x) & 0xff00) >> 8))
-#else
-# define const_le32(_x) (_x)
-# define const_le16(_x) (_x)
-#endif
-
 /* Unions for reinterpreting between floats and integers.  */
 
 typedef union {
-- 
2.26.2


