Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F8DC55181
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0242120656
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BP6HrcMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0242120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQyRl-0000ri-LE
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 15:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jQyQZ-0007h7-Ag
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jQyQY-0007gV-8y
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:27 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:40326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmerdabbelt@google.com>)
 id 1jQyQX-0007dt-Nx
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:25 -0400
Received: by mail-pj1-x1030.google.com with SMTP id a22so1815499pjk.5
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 12:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=BbK4N9sLahlO51Mgo2mcAZi2nlNHOPi2T0wGJXMXDaM=;
 b=BP6HrcMbpOlN+yaS+74o5Ot0RAWCQ7pQGbDt83XmI9+ayd6LJpyTNHVJlpTMVc22X8
 P5QMSZ8K9yE92pIg0Qh4cWtKY0guKLYHqcxY0jT7b/CvSHxWtVXZzQTS6oMmVUwmo6UM
 CtkOu8LbNwRN9uhvfClfL6sCKViIdZTe/sVCmiasz1qunuR8OfN5G22jw2b9TjC/UwFv
 Xy8r1k/HKwH6qU3iOPEo7Vd9CibE7Z/N4o/0DShFhI5FaAbuGVWUx22Rg8rNEJmQ7nmo
 /rmnzSih58sNjygZVVcfpMCBCKRFZoUXNmMF2Y4/Z/omXGctmiNiWq2tdLMHGEq/rfB4
 mf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=BbK4N9sLahlO51Mgo2mcAZi2nlNHOPi2T0wGJXMXDaM=;
 b=cCmILgAcnRO5t1ZQTetTxRn3x4BxbMFMLuHplsE77KyqPsn+EZ1BPLBGzOtdVOD/9E
 t3wTnyYnk6qJfVqhAX90upU6DY2FuoPQrXrpIjw3uD+A87W+sHSxidQdyt/9WGWSKgAn
 CfgmtS2Wbmo2ZyRSku8TGPKGvJf57AmCV1wh28jwQSxvxVGLxtUw1Rj88uD0k3naSMDb
 pZZrpnADDXEFHuE1bedO86BHrhRA1zjUpWXGPIHw/nC64JX7waC1CJwX2/EceSb0o6ui
 1WDERF8j25TVLlfsYpCLUODDk6aYV5qljsNrflso7bncttGJtxQgGOfbn7I648Y0pwPL
 eIkQ==
X-Gm-Message-State: AGi0Pua9Eh4f7ibnfLgE55oB46ClMpa++00RyVxpRJRA8o1iYhvUyHSf
 hNt8AvSe/qoHkr13tKYUH5T1RA==
X-Google-Smtp-Source: APiQypIzTiDBeHoAdJWi/KobMJYe++LprBBpDZIRQvFvxrp6Wue7bah+j6pdDL+b/UjzBRjsUMgF4g==
X-Received: by 2002:a17:902:7b95:: with SMTP id
 w21mr5096217pll.25.1587496763218; 
 Tue, 21 Apr 2020 12:19:23 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id e29sm2884850pgn.57.2020.04.21.12.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 12:19:22 -0700 (PDT)
Subject: [PULL 1/6] target/riscv: Don't set write permissions on dirty PTEs
Date: Tue, 21 Apr 2020 12:09:56 -0700
Message-Id: <20200421191001.92644-2-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421191001.92644-1-palmerdabbelt@google.com>
References: <20200421191001.92644-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=palmerdabbelt@google.com; helo=mail-pj1-x1030.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1030
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

The RISC-V spec specifies that when a write happens and the D bit is
clear the implementation will set the bit in the PTE. It does not
describe that the PTE being dirty means that we should provide write
access. This patch removes the write access granted to pages when the
dirty bit is set.

Following the prot variable we can see that it affects all of these
functions:
 riscv_cpu_tlb_fill()
   tlb_set_page()
     tlb_set_page_with_attrs()
       address_space_translate_for_iotlb()

Looking at the cputlb code (tlb_set_page_with_attrs() and
address_space_translate_for_iotlb()) it looks like the main affect of
setting write permissions is that the page can be marked as TLB_NOTDIRTY.

I don't see any other impacts (related to the dirty bit) for giving a
page write permissions.

Setting write permission on dirty PTEs results in userspace inside a
Hypervisor guest (VU) becoming corrupted. This appears to be because it
ends up with write permission in the second stage translation in cases
where we aren't doing a store.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu_helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d3ba9efb02..e2da2a4787 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -572,10 +572,8 @@ restart:
             if ((pte & PTE_X)) {
                 *prot |= PAGE_EXEC;
             }
-            /* add write permission on stores or if the page is already dirty,
-               so that we TLB miss on later writes to update the dirty bit */
-            if ((pte & PTE_W) &&
-                    (access_type == MMU_DATA_STORE || (pte & PTE_D))) {
+            /* add write permission on stores */
+            if ((pte & PTE_W) && (access_type == MMU_DATA_STORE)) {
                 *prot |= PAGE_WRITE;
             }
             return TRANSLATE_SUCCESS;
-- 
2.26.1.301.g55bc3eb7cb9-goog


