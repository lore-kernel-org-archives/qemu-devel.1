Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A32CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B8121906
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3Y/xAHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B8121906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJq2-0002qb-3M
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNIp1-0004cO-3T
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNIoz-0005RH-33
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:14 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f]:46766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNIox-0005Ki-2p
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:11 -0400
Received: by mail-qt1-x82f.google.com with SMTP id u22so32898232qtq.13
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VdwoVOQvGjyK5xwO9CwTmTvaoS1oPRDJG2i202FKHeA=;
 b=K3Y/xAHulnNNkqoZ/f937AsEOym8U2bSpJC+sPBBbW+dYInTBLMUarGjWz/8pd3Fto
 BqzAZleXOIMYOnW79c2Kk5xoEdMp79nwd9yBk7M5YciIH5SyoviOKAJhyGjmlhUB9hjy
 g775Gf07wETmxgEuzSCy0j37hpPqANcbYLNQ6fF0QDwV2lyVmcdg8Af2xgR59TphVPSV
 YAsjidGwfzRGvQ0a7fG/Nbhoic2TMgTpOR530Jhxh3yM6Dbhpq8PsqYnvT8C0us86r4J
 Pt6akoAzwDHrURwgNGVjt2nRXB5CAwde8XHmjWHl3HIOxiaugQtjBsaV+FY2OsZr/J2T
 k8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VdwoVOQvGjyK5xwO9CwTmTvaoS1oPRDJG2i202FKHeA=;
 b=Y1xfFbPY/5QHUH0170WOqpJ3joNow5+xINe/2gbhqokSLzX+pligL4MI1LaX7l/E8T
 3nJ0rFYV0fTddCtHWyFswMyY8l9S4ckqSMf/+7kKBagoRkYfUaNkcfPoUGBTbUhaTtII
 7p+TMrcAaRSCZHeLyStbZuG78w+J5xqGD8GrmPDLhuHG4mPzd+Bnrxq52RUnXYmKW7W6
 btHV4gqEnmEgXDf59yT6vXeZ6D5cUu6CL1NvoLfH/03EZNZ++zSIJVAMV89oJyTt/wbs
 fAxdxvwZ91lVfNvn8e+gbDjhFxuN4LkjY4pcR9gZlqXMP6p0fpeVZsKKZVATlV7MVBTh
 XPuQ==
X-Gm-Message-State: APjAAAWHlA2xL4YtKegi7uuJ8tVcE54euWajZLkOoqTTgt4lpYVtwY72
 EreyKb1c+d89ovLEh/Qq1nKcViiiwVY=
X-Google-Smtp-Source: APXvYqzRWKfHdcLWb0b285JXTRO/5Zi7ypt4kW927Gpob4oTKwjRFeyOkes6JX1ttBU5zswG6e1uGA==
X-Received: by 2002:a05:6214:1ca:: with SMTP id
 c10mr5266708qvt.233.1571845508689; 
 Wed, 23 Oct 2019 08:45:08 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id o1sm2456272qtb.82.2019.10.23.08.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:45:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/7] cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
Date: Wed, 23 Oct 2019 11:44:59 -0400
Message-Id: <20191023154505.30521-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023154505.30521-1-richard.henderson@linaro.org>
References: <20191023154505.30521-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82f
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org,
 Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

Use ROUND_UP() to define, which is a little bit easy to read.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20191013021145.16011-2-richardw.yang@linux.intel.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index ad9ab85eb3..255bb186ac 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -220,7 +220,7 @@ extern int target_page_bits;
 
 #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
 #define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
-#define TARGET_PAGE_ALIGN(addr) (((addr) + TARGET_PAGE_SIZE - 1) & TARGET_PAGE_MASK)
+#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
 /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
  * when intptr_t is 32-bit and we are aligning a long long.
@@ -228,9 +228,8 @@ extern int target_page_bits;
 extern uintptr_t qemu_host_page_size;
 extern intptr_t qemu_host_page_mask;
 
-#define HOST_PAGE_ALIGN(addr) (((addr) + qemu_host_page_size - 1) & qemu_host_page_mask)
-#define REAL_HOST_PAGE_ALIGN(addr) (((addr) + qemu_real_host_page_size - 1) & \
-                                    qemu_real_host_page_mask)
+#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
+#define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_real_host_page_size)
 
 /* same as PROT_xxx */
 #define PAGE_READ      0x0001
-- 
2.17.1


