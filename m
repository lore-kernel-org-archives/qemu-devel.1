Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34138C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D1C21D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hr5pn5ao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D1C21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vnP-0007Wh-6F
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkL-0001FY-Lx
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vkK-0004EH-DD
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:17 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:45930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vkK-0004Dw-6n
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:49:16 -0500
Received: by mail-pl1-x62a.google.com with SMTP id b22so491724pls.12
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=r94jo/gvFTBMX3LV/UZyM02c2n9qhiKPnxWyNzazeBQ=;
 b=Hr5pn5aox/5slECRkqgv2hmOKkz3IM/lv3BJgMfHfZbu/hiZ9oYZIBZj7fMnOi8Z8v
 sR49gXjvl8aCaNMnb3JJhOe7fJoR9ufiIBrVR9YY7+LDKAqU91sIDI40hQcwLEcFTOzp
 hQgMUnh6lU070TmRnaYrScDgs7p2npncXbA8tlX3hL8WgD1AySuEoKlhG76BhXPFDYYs
 aoIz+TbfQEdyzUeOTr6bmoKfYqKURnXhkROk55sI4sLGBxLZOa379Gbpk5qcYacE8VsR
 SllNQ0CWcIg2XUANP6Y3/HZfyjiAugjUNpINLxyN8CJudR437P+6Lp4PoRYtVIjQTcv2
 Cu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=r94jo/gvFTBMX3LV/UZyM02c2n9qhiKPnxWyNzazeBQ=;
 b=oGGqP+iP172HUgEGDD5n7R/VJQetQWuacfdu7E1k38VMyxByYKMtiuLqFldv7kUGv8
 cJXX3uSeeqg7M/Xn2+xSBW9GnZNIgV3Cl1IXcdQ6DzXPFANCNb0qTWc/kAjRg603P775
 GzN200V6Yem9BoVoCUGIRId3+SMG1phmwYj/6CYl70LTlh/PtOVJNKaR1Mfk/aszkQfO
 9Fe6AkCFjTMuItTUK9X1t0rlTP+PmjmdbEXJj5hWv/LFliO9G6RX6XuOhsLs1spxKeJK
 BFcgtADi41UfPMkgvfNB40ivljK82iNjak4sQ5Nyhgm7hUdKSYMInm8PziypxEvpMuea
 o1bw==
X-Gm-Message-State: ANhLgQ1WszlKWQN+0gjWMJZb7kSurD5q8/PARJxFznJD1cUPhJywB9/i
 aRvRKGIdqzwibHRw/5/r2FyTBQ==
X-Google-Smtp-Source: ADFU+vuwdRS1X28QYWrgt+eKKjSMvqA7fDFrycH5D7MBKKdni4A/EoXkYJyzwPZc68Otv32SUsWFdA==
X-Received: by 2002:a17:90a:35ad:: with SMTP id
 r42mr1240469pjb.178.1583196555055; 
 Mon, 02 Mar 2020 16:49:15 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id h16sm339673pje.43.2020.03.02.16.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:14 -0800 (PST)
Subject: [PULL 11/38] target/riscv: Add Hypervisor CSR access functions
Date: Mon,  2 Mar 2020 16:48:21 -0800
Message-Id: <20200303004848.136788-12-palmerdabbelt@google.com>
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
X-Received-From: 2607:f8b0:4864:20::62a
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
 target/riscv/csr.c | 136 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c63b2f980c..bee639e92e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -98,6 +98,20 @@ static int smode(CPURISCVState *env, int csrno)
     return -!riscv_has_ext(env, RVS);
 }
 
+static int hmode(CPURISCVState *env, int csrno)
+{
+    if (riscv_has_ext(env, RVS) &&
+        riscv_has_ext(env, RVH)) {
+        /* Hypervisor extension is supported */
+        if ((env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
+            env->priv == PRV_M) {
+            return 0;
+        }
+    }
+
+    return -1;
+}
+
 static int pmp(CPURISCVState *env, int csrno)
 {
     return -!riscv_feature(env, RISCV_FEATURE_PMP);
@@ -226,8 +240,9 @@ static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
 
 /* Machine constants */
 
-#define M_MODE_INTERRUPTS (MIP_MSIP | MIP_MTIP | MIP_MEIP)
-#define S_MODE_INTERRUPTS (MIP_SSIP | MIP_STIP | MIP_SEIP)
+#define M_MODE_INTERRUPTS  (MIP_MSIP | MIP_MTIP | MIP_MEIP)
+#define S_MODE_INTERRUPTS  (MIP_SSIP | MIP_STIP | MIP_SEIP)
+#define VS_MODE_INTERRUPTS (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP)
 
 static const target_ulong delegable_ints = S_MODE_INTERRUPTS;
 static const target_ulong all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS;
@@ -257,6 +272,7 @@ static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
     SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
 static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP | MIP_UEIP;
+static const target_ulong hip_writable_mask = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP;
 
 #if defined(TARGET_RISCV32)
 static const char valid_vm_1_09[16] = {
@@ -756,6 +772,112 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+/* Hypervisor Extensions */
+static int read_hstatus(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hstatus;
+    return 0;
+}
+
+static int write_hstatus(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hstatus = val;
+    return 0;
+}
+
+static int read_hedeleg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hedeleg;
+    return 0;
+}
+
+static int write_hedeleg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hedeleg = val;
+    return 0;
+}
+
+static int read_hideleg(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hideleg;
+    return 0;
+}
+
+static int write_hideleg(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hideleg = val;
+    return 0;
+}
+
+static int rmw_hip(CPURISCVState *env, int csrno, target_ulong *ret_value,
+                   target_ulong new_value, target_ulong write_mask)
+{
+    int ret = rmw_mip(env, 0, ret_value, new_value,
+                      write_mask & hip_writable_mask);
+
+    return ret;
+}
+
+static int read_hie(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mie & VS_MODE_INTERRUPTS;
+    return 0;
+}
+
+static int write_hie(CPURISCVState *env, int csrno, target_ulong val)
+{
+    target_ulong newval = (env->mie & ~VS_MODE_INTERRUPTS) | (val & VS_MODE_INTERRUPTS);
+    return write_mie(env, CSR_MIE, newval);
+}
+
+static int read_hcounteren(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hcounteren;
+    return 0;
+}
+
+static int write_hcounteren(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hcounteren = val;
+    return 0;
+}
+
+static int read_htval(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->htval;
+    return 0;
+}
+
+static int write_htval(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->htval = val;
+    return 0;
+}
+
+static int read_htinst(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->htinst;
+    return 0;
+}
+
+static int write_htinst(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->htinst = val;
+    return 0;
+}
+
+static int read_hgatp(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->hgatp;
+    return 0;
+}
+
+static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->hgatp = val;
+    return 0;
+}
+
 /* Physical Memory Protection */
 static int read_pmpcfg(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -959,6 +1081,16 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* Supervisor Protection and Translation */
     [CSR_SATP] =                { smode, read_satp,        write_satp        },
 
+    [CSR_HSTATUS] =             { hmode,   read_hstatus,     write_hstatus    },
+    [CSR_HEDELEG] =             { hmode,   read_hedeleg,     write_hedeleg    },
+    [CSR_HIDELEG] =             { hmode,   read_hideleg,     write_hideleg    },
+    [CSR_HIP] =                 { hmode,   NULL,     NULL,     rmw_hip        },
+    [CSR_HIE] =                 { hmode,   read_hie,         write_hie        },
+    [CSR_HCOUNTEREN] =          { hmode,   read_hcounteren,  write_hcounteren },
+    [CSR_HTVAL] =               { hmode,   read_htval,       write_htval      },
+    [CSR_HTINST] =              { hmode,   read_htinst,      write_htinst     },
+    [CSR_HGATP] =               { hmode,   read_hgatp,       write_hgatp      },
+
     /* Physical Memory Protection */
     [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
-- 
2.25.0.265.gbab2e86ba0-goog


