Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F89C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9E1E206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="er/2k1JF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E1E206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwsu-0004uT-4U
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIwog-0000Zj-C9
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIwoe-0000w0-F8
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600360283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZF+OqmqmstlUkr/dM0RnSgA94FV+mHcH3wKBsCU4Fw8=;
 b=er/2k1JFAwfgKuKgKh0SFoyDO0lz8vUkjnNV6v9T+6bUBpO/dlFtz0vgGDQmH7sTWthgE/
 hQz8gzByWIY3dsXoHGzXCvCmSUq2CNV5c/LqOghhAgWrsV2cIsRzEroYIdrG6q3gML9B/r
 iPLmbfXheZl5GQc2Ny4pOIeSprcnJlw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-74xmJuILPaO6uvovxDHoPw-1; Thu, 17 Sep 2020 12:31:19 -0400
X-MC-Unique: 74xmJuILPaO6uvovxDHoPw-1
Received: by mail-wr1-f69.google.com with SMTP id x15so1083632wrm.7
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 09:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZF+OqmqmstlUkr/dM0RnSgA94FV+mHcH3wKBsCU4Fw8=;
 b=VLoZszw2vSoQanWERcQDtbPtv40vmrVfTeC8xMtpPPr67U7zBlbu2Em2lc+9JRYRw8
 sFmxBHkP3Fg41SsRoL7CfRVUgKxZue5ZSyVorE0ehH5KvuMrP3y2JJXa4XcL0sgVuFbw
 F7Io1gsxsujHPpWmcFAzLOSuBj6ZHGvCKxXgSGYXbI/sQFmGwLJ3Ik1TQtzVDjYr9nr5
 2xt6bwJC12bsbov3IOH1V2l2D1fMIhB0SsngyM7RNsyLZW8O61x+EzGy0s0agsK0hoJ8
 Mp/cHYUVaK59zpo1rGaJAR4KHmugfxTZNNQuADskHwXTeyhPJ4YzhZzXam7GTPVqUYMb
 TDTg==
X-Gm-Message-State: AOAM530TGgLFewzChEqPYZHNm2NvU2Sote6LKJv9w9su6GFhQ5DQqjBc
 WeOM/3MkQSfJZt7hhDTFSERZnVQN0RiwwbMBxK0ZQLaUyx3RCKvLaWZfrW3nsxoKoqTY8Oyo4dB
 jceVaRfNE1i7hBl8=
X-Received: by 2002:a5d:49d2:: with SMTP id t18mr31185233wrs.99.1600360278145; 
 Thu, 17 Sep 2020 09:31:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJk4OJfAAHKtjRC2q3Vdz8KiSyHcc881TPifcw7kwFeh6Gzk4LBfKN0go9mvWayUx4Ka9MpA==
X-Received: by 2002:a5d:49d2:: with SMTP id t18mr31185212wrs.99.1600360277883; 
 Thu, 17 Sep 2020 09:31:17 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id i26sm75223wmb.17.2020.09.17.09.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 09:31:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] qemu/bswap: add const_be16() and const_be32()
Date: Thu, 17 Sep 2020 18:31:04 +0200
Message-Id: <20200917163106.49351-3-philmd@redhat.com>
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We already have the const_le() macros for little endian.
Implement the big-endian equivalent.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/bswap.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index c3b4277342b..6885984e00c 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -83,7 +83,7 @@ static inline void bswap64s(uint64_t *s)
 #endif
 
 /*
- * Same as cpu_to_le{16,32} described below, except that gcc will
+ * Same as cpu_to_{be,le}{16,32} described below, except that gcc will
  * figure the result is a compile-time constant if you pass in a constant.
  * So this can be used to initialize static variables.
  */
@@ -96,11 +96,20 @@ static inline void bswap64s(uint64_t *s)
 # define const_le16(_x)                          \
     ((((_x) & 0x00ff) << 8) |                    \
      (((_x) & 0xff00) >> 8))
+# define const_be32(_x) (_x)
+# define const_be16(_x) (_x)
 #else
 # define const_le32(_x) (_x)
 # define const_le16(_x) (_x)
+# define const_be32(_x)                          \
+    ((((_x) & 0x000000ffU) << 24) |              \
+     (((_x) & 0x0000ff00U) <<  8) |              \
+     (((_x) & 0x00ff0000U) >>  8) |              \
+     (((_x) & 0xff000000U) >> 24))
+# define const_be16(_x)                          \
+    ((((_x) & 0x00ff) << 8) |                    \
+     (((_x) & 0xff00) >> 8))
 #endif
-
 /**
  * Endianness conversion functions between host cpu and specified endianness.
  * (We list the complete set of prototypes produced by the macros below
-- 
2.26.2


