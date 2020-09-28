Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04243C4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED8121548
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NymI8jyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED8121548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMte6-0006PJ-M0
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMt4W-0000ho-Hj
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMt4Q-0002no-92
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:20:01 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601299196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/GuNNoh6nkdsrmjKbQNZ/H8CBCcsX4tPVisO++gKbE0=;
 b=NymI8jyUMD9t3Z4oqWb/HWUJfPuJwtj3X6PJPKu5YAG3DUC+YVxuAAVblxZSs8A1sTd5vN
 EVOpDL2pORJZCiwUd2Z0Mnd5JmDZsBdLH2oFFqNOzRMKfKTyCUcVg9cSTbWkjNVkwQqRVQ
 DiaayKuKZbqQgVZUt75Uc8c9rWHAEGM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-MlqOGRoeMzyeJCfi71QOng-1; Mon, 28 Sep 2020 09:19:54 -0400
X-MC-Unique: MlqOGRoeMzyeJCfi71QOng-1
Received: by mail-wr1-f72.google.com with SMTP id d13so389425wrr.23
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 06:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/GuNNoh6nkdsrmjKbQNZ/H8CBCcsX4tPVisO++gKbE0=;
 b=qo7tW22pxSVOH81OETb74e6ySEyiU4XuRAZ+PLtwAlwiHXVUA5JtvG/Rw4RlwJjJ+Y
 HsUUv+UxxvVFcaJHx6SB/z9+647obDOqbib+RTIv2SkH/d8qfBVL1sHtI1lVRQ0T7QC+
 MJ+SOW+8KeUkZdg9S5/NyZ3ueaa78dwixswmZQOZhjJ+H/P2QKj6WZF+DE4gtsQ+SLZN
 vpNTPRMW38fXVFd1ZNgWiewejhRdTUgYJBK4kD0IIQA4XyMVmEhjHEucq3iPMlkhxOy7
 VAzvCengpC5NYM9rr4oYJ0jNewySMHqR0SSeBR/4cagNaRnKLGGTkPuHN2psniEh7yl7
 A1Zg==
X-Gm-Message-State: AOAM5330MnRkwhwnZ4Yv++WFHRk6j5e5vPcy41xfGuyJGdVi0+Xpg0wn
 3mKYCDNRYFOnZoRm2j0u5IwcipOEp+I6rIopT08oxz6hM4I4IBZ4SCdJvxbMDC+cmHsiktPyqeP
 jCKpixW8yyqacAi4=
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr1597334wml.139.1601299193214; 
 Mon, 28 Sep 2020 06:19:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyat1laQPxulibnFjOJctKDEtgKO4pKfyi/4oZgnhBrfdQVkb9kh6nVGm0ZFsSjsDUCiOH5sw==
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr1597319wml.139.1601299193024; 
 Mon, 28 Sep 2020 06:19:53 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z83sm1392284wmb.4.2020.09.28.06.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 06:19:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/8] qemu/bswap: Replace bswapXXs() by compiler
 __builtin_bswap()
Date: Mon, 28 Sep 2020 15:19:29 +0200
Message-Id: <20200928131934.739451-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928131934.739451-1-philmd@redhat.com>
References: <20200928131934.739451-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/bswap.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 41131d3d76e..fed96dddd7a 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -38,29 +38,31 @@ static inline uint64_t bswap64(uint64_t x)
 
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


