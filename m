Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D91C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8865C21736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o13CjgqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8865C21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iahKh-0006mJ-1M
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 09:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iagqu-0002Bi-Gz
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iagqp-0003PQ-9x
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:32 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iagqo-0003Kz-4t
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:27 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so2333649wmi.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 06:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O5ALt6XeKJY7X9PuLNRV7urYrSvgNCwCrlCEcwFrxJI=;
 b=o13CjgqKpfljAKwquI/u7d0vnyH5XeD1OPrJYWKUaW9LqAG7QCjsbqA3RGve2Ut3yL
 XW8s3U1o8NBzlCJ5xKOJ9a97Qv2MIieKqwMGUuSLi2kMkIDMnTvnVlqlIVm+OlxInsP6
 D64yjFHs+8zP2GFn+2ktt2Rp7+zO55osnnMJHyCk0ylOcngGOn93VWRgBCTmOBVb/kAo
 hE1cccBZuRXv5LLsgPHZv/6mShfn6Kn1T81gxMdbESormEI/yKi1rQQ1aMttQ3zlBWYZ
 8YX4YzobftTojk0Mn/HtEQKZ94e6Pi34pI9v7CdAliGNkbMVuawUoBVV4dTb6iwhyUkh
 GqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=O5ALt6XeKJY7X9PuLNRV7urYrSvgNCwCrlCEcwFrxJI=;
 b=sxkXmfb9ISLfDQ0/6Nu7nxO/okxibGJ4gOK9HuZOC10LjILzSe73QBowsa9ZSc0mAn
 A7J5o9gR/Oglcy66flQV2eOrZvYa5uKAfyuAsj8TdngrtKF98NHL/aovF2LZFXlDWdev
 z5WGw6UrM+cUVKL46peBtPUV2QDw06O/yxespz7r9iabUHoN7FdZz5IUCFxreqo+yqlL
 OOYBmX6dZS5syCcTLiAK8MVvFCMwlSlv+zudfBBLpx9cYsxUaaEWyW8cWtW1sMFYs3t9
 sIH6uR85ff3qOERSEiYiVEBLPQuoEc2M6+pbTiQe7pTsu6Vb+O3M7u7sWWkm0Urptf4/
 18uA==
X-Gm-Message-State: APjAAAWNOr/7e4KcgfOSahywClkHgC13hN5XZCPciBTs5fQuQYeAE9Gx
 fwaqfy9Ngs59MaGJ68tsQxvrQLz2
X-Google-Smtp-Source: APXvYqyVx1rg3R6nnwC3nz3k+TekEGkovVi0Yqhn0nNDPeAE45wuUUfZyxru5Ynvu7XEfjIJo6D3Aw==
X-Received: by 2002:a7b:c449:: with SMTP id l9mr2223764wmi.150.1575036143775; 
 Fri, 29 Nov 2019 06:02:23 -0800 (PST)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
 by smtp.gmail.com with ESMTPSA id
 e7sm14190030wrp.43.2019.11.29.06.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2019 06:02:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/8] bitops.h: Silence kernel-doc complaints
Date: Fri, 29 Nov 2019 15:02:14 +0100
Message-Id: <20191129140217.17797-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129140217.17797-1-pbonzini@redhat.com>
References: <20191129140217.17797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Fix the problems with kernel-doc/sphinx syntax in the
doc comments for the shuffle and unshuffle functions:
 * mismatch between comment and prototype for argument name
 * the inline bit patterns need to be marked up so they
   are processed properly and rendered as monospace

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20190521122519.12573-6-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/bitops.h | 52 ++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index ee76552c06..02c1ce6a5d 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -424,13 +424,16 @@ static inline uint64_t deposit64(uint64_t value, int start, int length,
 
 /**
  * half_shuffle32:
- * @value: 32-bit value (of which only the bottom 16 bits are of interest)
+ * @x: 32-bit value (of which only the bottom 16 bits are of interest)
+ *
+ * Given an input value::
+ *
+ *   xxxx xxxx xxxx xxxx ABCD EFGH IJKL MNOP
  *
- * Given an input value:
- *  xxxx xxxx xxxx xxxx ABCD EFGH IJKL MNOP
  * return the value where the bottom 16 bits are spread out into
- * the odd bits in the word, and the even bits are zeroed:
- *  0A0B 0C0D 0E0F 0G0H 0I0J 0K0L 0M0N 0O0P
+ * the odd bits in the word, and the even bits are zeroed::
+ *
+ *   0A0B 0C0D 0E0F 0G0H 0I0J 0K0L 0M0N 0O0P
  *
  * Any bits set in the top half of the input are ignored.
  *
@@ -450,13 +453,16 @@ static inline uint32_t half_shuffle32(uint32_t x)
 
 /**
  * half_shuffle64:
- * @value: 64-bit value (of which only the bottom 32 bits are of interest)
+ * @x: 64-bit value (of which only the bottom 32 bits are of interest)
+ *
+ * Given an input value::
+ *
+ *   xxxx xxxx xxxx .... xxxx xxxx ABCD EFGH IJKL MNOP QRST UVWX YZab cdef
  *
- * Given an input value:
- *  xxxx xxxx xxxx .... xxxx xxxx ABCD EFGH IJKL MNOP QRST UVWX YZab cdef
  * return the value where the bottom 32 bits are spread out into
- * the odd bits in the word, and the even bits are zeroed:
- *  0A0B 0C0D 0E0F 0G0H 0I0J 0K0L 0M0N .... 0U0V 0W0X 0Y0Z 0a0b 0c0d 0e0f
+ * the odd bits in the word, and the even bits are zeroed::
+ *
+ *   0A0B 0C0D 0E0F 0G0H 0I0J 0K0L 0M0N .... 0U0V 0W0X 0Y0Z 0a0b 0c0d 0e0f
  *
  * Any bits set in the top half of the input are ignored.
  *
@@ -477,13 +483,16 @@ static inline uint64_t half_shuffle64(uint64_t x)
 
 /**
  * half_unshuffle32:
- * @value: 32-bit value (of which only the odd bits are of interest)
+ * @x: 32-bit value (of which only the odd bits are of interest)
+ *
+ * Given an input value::
+ *
+ *   xAxB xCxD xExF xGxH xIxJ xKxL xMxN xOxP
  *
- * Given an input value:
- *  xAxB xCxD xExF xGxH xIxJ xKxL xMxN xOxP
  * return the value where all the odd bits are compressed down
- * into the low half of the word, and the high half is zeroed:
- *  0000 0000 0000 0000 ABCD EFGH IJKL MNOP
+ * into the low half of the word, and the high half is zeroed::
+ *
+ *   0000 0000 0000 0000 ABCD EFGH IJKL MNOP
  *
  * Any even bits set in the input are ignored.
  *
@@ -504,13 +513,16 @@ static inline uint32_t half_unshuffle32(uint32_t x)
 
 /**
  * half_unshuffle64:
- * @value: 64-bit value (of which only the odd bits are of interest)
+ * @x: 64-bit value (of which only the odd bits are of interest)
+ *
+ * Given an input value::
+ *
+ *   xAxB xCxD xExF xGxH xIxJ xKxL xMxN .... xUxV xWxX xYxZ xaxb xcxd xexf
  *
- * Given an input value:
- *  xAxB xCxD xExF xGxH xIxJ xKxL xMxN .... xUxV xWxX xYxZ xaxb xcxd xexf
  * return the value where all the odd bits are compressed down
- * into the low half of the word, and the high half is zeroed:
- *  0000 0000 0000 .... 0000 0000 ABCD EFGH IJKL MNOP QRST UVWX YZab cdef
+ * into the low half of the word, and the high half is zeroed::
+ *
+ *   0000 0000 0000 .... 0000 0000 ABCD EFGH IJKL MNOP QRST UVWX YZab cdef
  *
  * Any even bits set in the input are ignored.
  *
-- 
2.21.0



