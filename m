Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1FEC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C1120705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="go5yC9nS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C1120705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2wf-00032A-CK
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:27:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2ss-0007nI-M7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2sr-0003bZ-Jn
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:23:54 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:34959)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2sr-0003aW-Dd
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 23:23:53 -0500
Received: by mail-pl1-x632.google.com with SMTP id g6so585029plt.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 20:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gn2qUm60pHFb0jINIBzLmU8PxWdzwQ1RyRD8IbxWKSM=;
 b=go5yC9nSc2YPTfUtpb7zjpFW6r+UHpsC+DzJ5B3bw1XW7yC2b0Y38mB4K2z82yizMK
 7cytF57P9sRW8CUABi5v08Vnfm8nJZIPz+Q5/QZpxpZiyPR8P+On2SqSVcwtaFrLZ5mU
 okz71GrXpUKfnjVSAZxi0kmTE1E4UuJRcu/axF/EvF3z7ak6Vm/yeMtY/92g5dRlHD2r
 0YiqAbZpnUhl5QFWj8P6jNqfExzTZxsKrs8OszO5r2ky9urmd5qX1N8YvidnJgRT7DPQ
 ZjgTp3TWhEzBM1u7u3ff14mrDU18ZK/QN04ffENWgSLhjeSUaZB64rZOm3f63IWEp+ZZ
 SZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gn2qUm60pHFb0jINIBzLmU8PxWdzwQ1RyRD8IbxWKSM=;
 b=Xyqtdv0C2wmpv9JeELIdmAmdZghje0H5uwG1snS5iaV9YP1iKhVOSwTyPQwvHuhF1m
 9Oc7QTQQSRTi3K+qrB42TD1pNMtdfRvHDw87mQxyD48tAdq2nl+64lnsNIaiawi3F+1G
 a+TlxaVDTn/+4Sexeo1i3BeIwOhjlmHsr9ZY/YMbT0Xjy9/orIIYfezv6koVZUDd85+k
 jMakkOApGtsWp0S5iK6nM1ZiqvTLd6+QedZtJp/X2MbX4NSj+zy/P68kSkMMjucYhg+f
 4eqGdpapE6gt6RyQ6yDUz1YBNxb1CEtyB7iknSGwo+YuL9OVmWF0R/8rB2aCmz8DfDIx
 3/SQ==
X-Gm-Message-State: APjAAAUbFCLHHtbjuGsopO7dciR6ttXL6ZQ5UxWTsT8bIW1yYd/+6Rbq
 dKj/379PoqjPridVc/20TFDqfs9G9KKf0g==
X-Google-Smtp-Source: APXvYqwH8FYieKNbIS8BmVeRbiHpN5JCf8+KjP/fsfGgRzYBCkeUbSGggwj6yPVLHGuWGllvjuX2Hg==
X-Received: by 2002:a17:902:265:: with SMTP id
 92mr3144519plc.188.1578457432063; 
 Tue, 07 Jan 2020 20:23:52 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f9sm1192702pfd.141.2020.01.07.20.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 20:23:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] capstone: Add skipdata hook for s390x
Date: Wed,  8 Jan 2020 15:23:38 +1100
Message-Id: <20200108042338.9082-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108042338.9082-1-richard.henderson@linaro.org>
References: <20200108042338.9082-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::632
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Capstone assumes any s390x unknown instruction is 2 bytes.
Instead, use the ilen field in the first two bits of
the instruction to stay in sync with the insn stream.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/disas.c b/disas.c
index 845c40fca8..1095bad049 100644
--- a/disas.c
+++ b/disas.c
@@ -178,6 +178,39 @@ static int print_insn_od_target(bfd_vma pc, disassemble_info *info)
    to share this across calls and across host vs target disassembly.  */
 static __thread cs_insn *cap_insn;
 
+/*
+ * The capstone library always skips 2 bytes for S390X.
+ * This is less than ideal, since we can tell from the first two bits
+ * the size of the insn and thus stay in sync with the insn stream.
+ */
+static size_t CAPSTONE_API
+cap_skipdata_s390x_cb(const uint8_t *code, size_t code_size,
+                      size_t offset, void *user_data)
+{
+    size_t ilen;
+
+    /* See get_ilen() in target/s390x/internal.h.  */
+    switch (code[offset] >> 6) {
+    case 0:
+        ilen = 2;
+        break;
+    case 1:
+    case 2:
+        ilen = 4;
+        break;
+    default:
+        ilen = 6;
+        break;
+    }
+
+    return ilen;
+}
+
+static const cs_opt_skipdata cap_skipdata_s390x = {
+    .mnemonic = ".byte",
+    .callback = cap_skipdata_s390x_cb
+};
+
 /* Initialize the Capstone library.  */
 /* ??? It would be nice to cache this.  We would need one handle for the
    host and one for the target.  For most targets we can reset specific
@@ -208,6 +241,10 @@ static cs_err cap_disas_start(disassemble_info *info, csh *handle)
 
     /* "Disassemble" unknown insns as ".byte W,X,Y,Z".  */
     cs_option(*handle, CS_OPT_SKIPDATA, CS_OPT_ON);
+    if (info->cap_arch == CS_ARCH_SYSZ) {
+        cs_option(*handle, CS_OPT_SKIPDATA_SETUP,
+                  (uintptr_t)&cap_skipdata_s390x);
+    }
 
     /* Allocate temp space for cs_disasm_iter.  */
     if (cap_insn == NULL) {
-- 
2.20.1


