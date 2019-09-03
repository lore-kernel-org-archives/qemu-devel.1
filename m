Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B51C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB79B23431
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXk05Aoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB79B23431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BjY-0001Yt-V8
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMs-00016s-Ah
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMr-0003jU-A0
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:18 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33807)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMr-0003j6-4C
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:17 -0400
Received: by mail-pf1-x444.google.com with SMTP id b24so11104478pfp.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MLPNZqiX+QrjMBnFEqgBOvGUopZ4Z5WeJtCGkzuh14A=;
 b=HXk05AoybBUpieEAeoL90kbqAvSO0aRFNKk/bzeW+6BUk4aW3UjJhCB9i066r4CFsw
 41EDBIUqcTOzASP4rp1o702e5PUEsuKmhgWPdwCZbve6BhPDL/mjjTBhrGL4VQsquGps
 h9g/mslmzKDDqMVc5hwp44pOjt/12U7Viz8Ge59WGJoLB5+RIQcz5GcOWEJ2mOJvnvc6
 kkkWKrfH5CzbCh4QIas49VaADFUfBP9/raVC6f2e8oqVHUhaCLp1flLjoEMKlMV07AG2
 eMQm7o5cahUnIY4AFiZp5MopujjeZkfeTp4gSNnKPlkxcHxKsCceMjpmBOyOwpu5DHlK
 Qskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=MLPNZqiX+QrjMBnFEqgBOvGUopZ4Z5WeJtCGkzuh14A=;
 b=Jt31LW3C1roSZFxiBDrVH6XBywkGzSe2qjzVb2rqoFTDrcGEfHZQkGH5HdEW+9EU8u
 IejUYPyM55E7eFXNayPxqjfhaWvg4Ec+9eMx79U2pHDhvww3nrAeeTyO4pmkAdu3BAE5
 o07toKA9rRWLMzcDQOKUfo8jK3MdQMyQGBb3QOcE32LoICESVyfAuFr3TueaQPXDIFjV
 HCn2jghnthIrfwCIYaKScW6yR+1d2fPk7eWUCsQGUODzV0SxlOXUnmh+jsU62f8erf1V
 1LaAHqBYj/eDxCVPBGliIoIgGBX+z72d/K1n/1yFY7ONCMxo86CeWIsudhhtDC4M8NYE
 siiw==
X-Gm-Message-State: APjAAAWDsiTGwwPhDMMxpzgtYQiWrgeydT72r7XLVIXxmjDhBtGBHcZQ
 zixudcyuSA0A7tR4SUrHSMEHQLUEo8E=
X-Google-Smtp-Source: APXvYqyGFZaD6NoP1zZytWz9MMHXLNj+BT3sgrR0ygQRehA9010BowFxo9/+YfPqkyuTNLIg0oi1bA==
X-Received: by 2002:a17:90a:f0c7:: with SMTP id fa7mr785pjb.115.1567526955918; 
 Tue, 03 Sep 2019 09:09:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:34 -0700
Message-Id: <20190903160858.5296-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 12/36] target/mips: Hard code size with
 MO_{8|16|32|64}
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

Temporarily no-op size_memop was introduced to aid the conversion of
memory_region_dispatch_{read|write} operand "unsigned size" into
"MemOp op".

Now size_memop is implemented, again hard coded size but with
MO_{8|16|32|64}. This is more expressive and avoids size_memop calls.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <99c4459d5c1dc9013820be3dbda9798165c15b99.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 1f0e88364a..34bcc8d884 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -4742,11 +4742,11 @@ void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
     if (op == 9) {
         /* Index Store Tag */
         memory_region_dispatch_write(env->itc_tag, index, env->CP0_TagLo,
-                                     size_memop(8), MEMTXATTRS_UNSPECIFIED);
+                                     MO_64, MEMTXATTRS_UNSPECIFIED);
     } else if (op == 5) {
         /* Index Load Tag */
         memory_region_dispatch_read(env->itc_tag, index, &env->CP0_TagLo,
-                                    size_memop(8), MEMTXATTRS_UNSPECIFIED);
+                                    MO_64, MEMTXATTRS_UNSPECIFIED);
     }
 #endif
 }
-- 
2.17.1


