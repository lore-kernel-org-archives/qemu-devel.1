Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ED3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D82C722CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlVVfaA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82C722CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BS1-0006av-FL
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMp-00013C-WA
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMo-0003hd-Ot
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:15 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMo-0003gK-IL
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:14 -0400
Received: by mail-pg1-x542.google.com with SMTP id p3so9387372pgb.9
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kAhciq3n7FNXsC9Uw/vvM8E58dLHruQP1ECC6wNwlOw=;
 b=UlVVfaA6/BkVsIavZ5j+LRDxjD1YD5gONKILYeC82lW2p2aL/7IMU2P0D4yOevWmdQ
 Ts1oVAHLRdGQ4o8rScpOfWQqqwp0fRcTfjXeWexy+03WWsHhI4mzIbmzU0ipW6CKUnMI
 vTJOD4lMjUVcL2EHTl8Ma0fUWK8kvSnE9PuIa0l0nEg1/UajkGkNs7nx/soUsOqpML/i
 I649z9OnBl7J1WAPKYEzIzwigOrMPsXKf+EpmSVIwPS9g7zV5JfADMnI1n9rehHtkrb5
 KgUI5+WVmp8oBv8MyrtcPTsA6odyY7+GdZlegdV5wOBhVLYFVCSqmNGnCPJdwgjTKBJu
 7Y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kAhciq3n7FNXsC9Uw/vvM8E58dLHruQP1ECC6wNwlOw=;
 b=d/GEOXCRQgrNpH9WSTUj2OnTnsWNCPAxHJhVePHIg9dsQ0JVbj2f3tKPEEjXT7lrMH
 ed4JcqJ9ft4KlISaJvTKIKa5zYCiHfnc4uaXd4ApRreonydT5i6wJ9of8QKQBX7fCr7N
 FQW1gkEKwWo9zCWqwNGaVOu27dRhIlRTbXv37h/Q6M9x9GDScv5AafkGHR0wkvAyWq0G
 PccM8GQ8/dVnIqsgcxGKD3R9b+6NF0bfDNV8eJmCmpz6bRLqnlGMqVvPI0PXM5lZPINM
 fOpaOaeg+j77+EMLHUC/XxPdVUfTGjKC2RuMKNY3t8+wFtN71z5k7jlWuTiq1ViGj8Xl
 XDeQ==
X-Gm-Message-State: APjAAAXXlK/HGqx+GfvZTgOKglKI/BmtJLhNXWKMQhvfHdZkmSyQaOeF
 84/Z3qoAGNvHgKsRVsJBOpH2wYHhbEM=
X-Google-Smtp-Source: APXvYqwYFP8pU8SUCHxWHtwi2s0wo0E5vBuM885ODjOk6gxpv9s2HvFzYkldjhn60jpwmNse1PlhaA==
X-Received: by 2002:a17:90a:33e7:: with SMTP id n94mr35016pjb.15.1567526951793; 
 Tue, 03 Sep 2019 09:09:11 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:31 -0700
Message-Id: <20190903160858.5296-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH 09/36] cputlb: Access MemoryRegion with MemOp
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
Cc: peter.maydell@linaro.org, Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tony Nguyen <tony.nguyen@bt.com>

The memory_region_dispatch_{read|write} operand "unsigned size" is
being converted into a "MemOp op".

Convert interfaces by using no-op size_memop.

After all interfaces are converted, size_memop will be implemented
and the memory_region_dispatch_{read|write} operand "unsigned size"
will be converted into a "MemOp op".

As size_memop is a no-op, this patch does not change any behaviour.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <c4571c76467ade83660970f7ef9d7292297f1908.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 523be4c848..6c83878f73 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -906,8 +906,8 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         qemu_mutex_lock_iothread();
         locked = true;
     }
-    r = memory_region_dispatch_read(mr, mr_offset,
-                                    &val, size, iotlbentry->attrs);
+    r = memory_region_dispatch_read(mr, mr_offset, &val, size_memop(size),
+                                    iotlbentry->attrs);
     if (r != MEMTX_OK) {
         hwaddr physaddr = mr_offset +
             section->offset_within_address_space -
@@ -947,8 +947,8 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         qemu_mutex_lock_iothread();
         locked = true;
     }
-    r = memory_region_dispatch_write(mr, mr_offset,
-                                     val, size, iotlbentry->attrs);
+    r = memory_region_dispatch_write(mr, mr_offset, val, size_memop(size),
+                                     iotlbentry->attrs);
     if (r != MEMTX_OK) {
         hwaddr physaddr = mr_offset +
             section->offset_within_address_space -
-- 
2.17.1


