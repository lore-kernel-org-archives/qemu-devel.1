Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3174DC2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 19:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB96621BE5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 19:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5OCfi7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB96621BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPAHr-0004Pi-Vp
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 15:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPAG5-0003Dx-Km
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPAG4-0004Su-Mv
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:33:09 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:45323)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jPAG4-0004S3-Fu
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:33:08 -0400
Received: by mail-lj1-x243.google.com with SMTP id v9so9071312ljk.12
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 12:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/lWXnmPg4SaRCku5rYB8kdcP6M/aKtEzuf5WJ9DGh30=;
 b=X5OCfi7snmIwqhVpGBn1kbNNK91l03shUC4/F6l048Gb9k1jrGcKnGKYC/VNUFD4O1
 xZ06zY3GtN4F8pizjVjhtd6axuloH3GOq7hHwkSx/mEGTl7zUPsS3coGbyKjZWVSqHV6
 Jm5vNrrovNlE/sLM+4Ztsfxsf8YJ8BoDYwHIUBNEqe/KJ7NcpJYVhr2WABBU8McU4fzY
 Q7x3MO+EZTHTT5vy5QHZhp27lGdveICc5hN76aQ1KTzLKf2kajXvrOpsc0D0G3dis/kH
 NFy5ak9fNYoecb8ZCxLjobk4Zf5MgtY2rtg/yHT6XuRuWRZb3WJdaisdsl17pVQk2L6N
 hLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/lWXnmPg4SaRCku5rYB8kdcP6M/aKtEzuf5WJ9DGh30=;
 b=AObxUT+3a6i9UfyYYpl9oLPM9j+kkABhlCqAuS22/O631yWl65qbZKlTmiskvztl+T
 teNm/NW8y8wouBxqqa39Bqa7j30PHNRPbZj7mk2WxweLc/cGRtF9WPtp28Y+ULHtZZ9Q
 A2HAPTdmjbMfaHXGCcon6syAV9mBO4Zzf+aKprKH1vrAKKrF2tILxCJYUN92lFfjl16/
 Cv0xJKdW2KMhRvkWb4r3C8tw+BsF+86J4H7fk/f9i2+5Zm8BV7WT34Fi+N32dwjIATyW
 uA9f8WkPiHCdtBgCtaXQurcJK/qBYirCGSqoMvRWJZ4C1kGY80YG0hfy2qn0ZfR23FjO
 bncQ==
X-Gm-Message-State: AGi0PuZSX8gIoQFVfOLSheNxYHNwHkAURrKrpK5sfSjms6MFVm15UKuU
 iLdKLfd/VS4olK/JOi6OUa2oQrRPXOlo4g==
X-Google-Smtp-Source: APiQypK4+V37nBe+Tu9I7CTPTb21huwm0kBA7HpJ3Z6m6SlsnBwn5urIQ+SnYQkw4lwRwITjurz9tw==
X-Received: by 2002:a2e:2201:: with SMTP id i1mr7352806lji.31.1587065586137;
 Thu, 16 Apr 2020 12:33:06 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id e16sm17535919ljh.18.2020.04.16.12.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 12:33:05 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 PATCH v1 1/1] tests: machine-none-test: Enable MicroBlaze
 testing
Date: Thu, 16 Apr 2020 21:33:03 +0200
Message-Id: <20200416193303.23674-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200416193303.23674-1-edgar.iglesias@gmail.com>
References: <20200416193303.23674-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Enable MicroBlaze testing.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 tests/qtest/machine-none-test.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 8bb54a6360..209d86eb57 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -33,8 +33,8 @@ static struct arch2cpu cpus_map[] = {
     { "cris", "crisv32" },
     { "lm32", "lm32-full" },
     { "m68k", "m5206" },
-    /* FIXME: { "microblaze", "any" }, doesn't work with -M none -cpu any */
-    /* FIXME: { "microblazeel", "any" }, doesn't work with -M none -cpu any */
+    { "microblaze", "any" },
+    { "microblazeel", "any" },
     { "mips", "4Kc" },
     { "mipsel", "I7200" },
     { "mips64", "20Kc" },
@@ -79,10 +79,8 @@ static void test_machine_cpu_cli(void)
     QTestState *qts;
 
     if (!cpu_model) {
-        if (!(!strcmp(arch, "microblaze") || !strcmp(arch, "microblazeel"))) {
-            fprintf(stderr, "WARNING: cpu name for target '%s' isn't defined,"
-                    " add it to cpus_map\n", arch);
-        }
+        fprintf(stderr, "WARNING: cpu name for target '%s' isn't defined,"
+                " add it to cpus_map\n", arch);
         return; /* TODO: die here to force all targets have a test */
     }
     qts = qtest_initf("-machine none -cpu '%s'", cpu_model);
-- 
2.20.1


