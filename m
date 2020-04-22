Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C0DC54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08401206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nBy7+FcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08401206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR447-0006hA-3o
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41A-0001EK-Pf
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41A-0001T0-6E
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:36 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:41537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR419-0001QO-O0
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:17:35 -0400
Received: by mail-pg1-x529.google.com with SMTP id h69so248095pgc.8
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NV6lL8g5TLJgWVXBQ3cW0c77O/M78yXELJw+3HhuoJg=;
 b=nBy7+FcRzgMRoTxKgdfaIZHCF1SI8fiXB7VxHNAuFh1eBlF5E1H5nmRBHqd/QiRP0m
 R+kDS5bkJa47cGt57QKpt2qkKDGGt1GPYjoC3+8jXswL8Xv5i3m+i/HBfcKY+Zdb45ZJ
 8jGTai1iic5OSIm1c0HAgtOIXqIFR0TTzhHFYOdGyWbScRgcOwSpYTG2HtVXoGjfK8wc
 yhwOqIVkOGA8/os4p/DwWTEWOja0tYRbU6+i1OGnFbcpzWXe5SR0nDKSUDSES3QT8yuq
 W2xpzZUIMgHVkJ1t9b+ChPSMVG6+k8M11XGnarP1znAE/z1t/MorcWj8JEeH+PB9Ljzd
 eRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NV6lL8g5TLJgWVXBQ3cW0c77O/M78yXELJw+3HhuoJg=;
 b=i+as9VmeiQZ+60gFgWV1+MrjCAWkCNzhqa2CweczsjIxYHY3px8vkaXmRi9pGE81mC
 zwNP0HSL/bGPv7DR9BmK40wVoL5M965AoWD7iIP5RhN3U7soy5xKmytww+6cVpoycWIL
 5kEr59u6ayOx5AFpgtZBFCWLrq+ezVH54WaLm36VYH4NwzyiuUmaFZV7Yszc56dpRvbF
 xdsV0o/voRtFzdNJJk6NrB5ihG7XSTlcqtq3Hq+hhWl5ZW3sVTNSeQtDGacB9xpZTWXU
 ltWnImzPY87MEQft/slJsJ6hg6RpnQbGaKnv/w2cHlSiYBKW573W1+17IUfHVZ/U3O4e
 5e8g==
X-Gm-Message-State: AGi0PubuNffszlYOPQoug5fJrXUv34/oUG+3YeUxN4vj9XcA/dUCTQ21
 mnMQpZcU/wonBEUV3nH4CwJ9LC8LATo=
X-Google-Smtp-Source: APiQypIuDdKF59vtjKbckrAfT0VZZWEZ3yz0T5nV9CEVRioTFaH/JxsMh2b4KFozkn5AdKWCwi80iA==
X-Received: by 2002:a63:2e03:: with SMTP id u3mr24561951pgu.121.1587518253576; 
 Tue, 21 Apr 2020 18:17:33 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/36] tcg: Add tcg_gen_gvec_dup_tl
Date: Tue, 21 Apr 2020 18:16:53 -0700
Message-Id: <20200422011722.13287-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::529
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
Cc: alex.bennee@linaro.org, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For use when a target needs to pass a configure-specific
target_ulong value to duplicate.

Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index fa8a0c8d03..d89f91f40e 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -320,6 +320,12 @@ void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
 void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
                           uint32_t m, TCGv_i64);
 
+#if TARGET_LONG_BITS == 64
+# define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i64
+#else
+# define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i32
+#endif
+
 void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
-- 
2.20.1


