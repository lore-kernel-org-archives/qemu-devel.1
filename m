Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F7FC3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA47E24677
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZ4DxnZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA47E24677
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vpI-0002g5-Vi
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkO-0001LX-NA
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkN-0004GY-Lb
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:20 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:44955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vkN-0004GB-Fy
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:19 -0500
Received: by mail-pf1-x42e.google.com with SMTP id y5so545090pfb.11
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=ANagWVKLvizSaKchqMWjcdMKh5oBJiAUyVPoiA3+eHk=;
 b=CZ4DxnZWJrIgKj01EvAlv80BBB3viLK/oA8TslcfgcaY6YR8308kV7kUa/inGvua4P
 t0B1wnIiTc0A0ha06wPO+TfLAUoTIeIrhxJn9sk91v4zhFAs2NTlcL9Z5fKNxMFO/Wc3
 mDfjcVHTmujZwd7DmSB46VzBDzBj3cxEwlDubmpXAhh6R9qNs6A43TTsTtybNeo4/Snw
 /PiDVkQyaG++1geTJ3c0jeo0H2PLSIve3O/EmEFUNdj4kXow9e71J5a8q9kSPxbqYhjV
 na8e6RGZz0Wl3kBHOZ9viybIJaGm0Bu9oiF9V9DELaU9TYR0r6YD3xmX4QpP/FiQVv3x
 5Hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=ANagWVKLvizSaKchqMWjcdMKh5oBJiAUyVPoiA3+eHk=;
 b=qe5eaLbnb6CAqF00Thf96FrxRUWuCaBmpvF8z8Avy0kL+mrRFsEeNoXne/h5QZ8R45
 CojgcVNyjM1cQXCA5NH3/bANtunbBnCtWnWjSRflzwiFHeEXW8VOjMmmJO7Byy7WT1IH
 uGcNyjVnbKmiEg1TN3b/sfyzwi5MFXvVfYVM1P94pqAEk6LRg5twv7yOJKnCxSZyqALX
 eqkOVgkaKD9arsVoTBUIQWT96Ka9EcsDmFUF/UD2FjqB3SzvevmDRtn8CFE0sDq5eoMG
 +BdgnODFF8pbuhgfB5GZM6NacHE+BVWyZKNhGb9S1mxkFn/TIuC2LvRz4By9CrGB3J0v
 qi6Q==
X-Gm-Message-State: ANhLgQ1qQIhLJlp6hpA7QzpLZ3H47zqnwStf/QyUxrHA8kA1GCT0Qz64
 959pyGpzZTlvO3Ok8vUv5MDX2hjlQGPpug==
X-Google-Smtp-Source: ADFU+vvlXYcn0/i7j/5tbb29kKUjSUhG+xmlXIjJ3/vsn2B7Dhqx8Sr5W6nbvLON/YJ0kmahFQ6Khw==
X-Received: by 2002:a63:1e57:: with SMTP id p23mr1578180pgm.316.1583196558485; 
 Mon, 02 Mar 2020 16:49:18 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id k3sm22320070pgh.34.2020.03.02.16.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:18 -0800 (PST)
Subject: [PULL 13/38] target/riscv: Add Hypervisor machine CSRs accesses
Date: Mon,  2 Mar 2020 16:48:23 -0800
Message-Id: <20200303004848.136788-14-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42e
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/csr.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 3fa8d2cfda..f7333286bd 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -984,6 +984,30 @@ static int write_vsatp(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+static int read_mtval2(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mtval2;
+    return 0;
+}
+
+static int write_mtval2(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mtval2 = val;
+    return 0;
+}
+
+static int read_mtinst(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mtinst;
+    return 0;
+}
+
+static int write_mtinst(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mtinst = val;
+    return 0;
+}
+
 /* Physical Memory Protection */
 static int read_pmpcfg(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -1207,6 +1231,9 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_VSTVAL] =              { hmode,   read_vstval,      write_vstval     },
     [CSR_VSATP] =               { hmode,   read_vsatp,       write_vsatp      },
 
+    [CSR_MTVAL2] =              { hmode,   read_mtval2,      write_mtval2     },
+    [CSR_MTINST] =              { hmode,   read_mtinst,      write_mtinst     },
+
     /* Physical Memory Protection */
     [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
-- 
2.25.0.265.gbab2e86ba0-goog


