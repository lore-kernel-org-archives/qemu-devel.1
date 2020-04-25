Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED92C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 17:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29A120706
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 17:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="L+YEJbTV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L56BvZTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29A120706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSl26-0003Hf-Ub
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 13:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1jSl1E-0002es-Qt
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 13:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1jSl1D-0004ZT-Fi
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 13:24:40 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:44229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1jSl1C-0004ZI-Nz; Sun, 26 Apr 2020 13:24:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id DA2C448F;
 Sun, 26 Apr 2020 13:24:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Sun, 26 Apr 2020 13:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=hwtx02kkvPK5B
 V7M6kav5ZTdZRn0A1eYTzwE3O+v0ss=; b=L+YEJbTV0jO0Jb49SWJJxIUNulhGv
 h3nwAAyQnWWkllty8a9p9j2t6Ywi1QaLrmJO3wuwVZO2BQcK00jGE3Cjzqi+5Yoe
 0BTkg+PNH2LK3WjdZhhbWLFG9TCkn10psHNHyrLpWq6+VdxAEUbjsRwQjtR4AlN2
 XnjsORj70cJHexN1fBiTKIYb4Dx2HTSR12px50QElVt3HYTYY3cXARPiou2V0sEi
 ImXI8+pbx2cXJSeIjJ6PRKvBMaKN6zjuUZKjfF9yk8PXlxP4Lf4kzXUCHPclrq/H
 s4kvgvLsTQ2Pyt0DsXpd8yAYor73/roTiUXHchVNOpILz+RObhV0mp0wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=hwtx02kkvPK5BV7M6kav5ZTdZRn0A1eYTzwE3O+v0ss=; b=L56BvZTh
 avDSt/hO8B/r9eGHQDX5s9BRBDOWLJ2y1CEYXo27xydc8xdybLco410UxfJ8/HY0
 eVVYmuipC8f2C7ZNupc2Ai4y86fi1cI/Ol5lZYhoKeNFRZ1NsObfwWuCdjw0tFo+
 B1uj1hsmsxTi5OTQGaWpDANrcIoiZWmb4z/9vdyDsObrBT0JPB2jDz2hP3f7cUIF
 X8wLjNWWkXRJqJGhBl83n8JV6XXa+vaLXtCUVTbbpupOKapr0CkFPTo47cvlwo3C
 oUUB/n5SedkXIZ1HhHaGvoZWit3juua1o/mlWHEfWlX7yA6UV0RNjVOjBzibFkw2
 xxTLqxSb9o9WzA==
X-ME-Sender: <xms:0cOlXtSENYYoBAXGEVnp-yS4zpeR_TQPTSudew-GiThJWvFYso8vsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrheejgdduudefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
 ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucfkphepjeefrdelfedrkeegrddvtdekne
 cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhs
 thgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:0cOlXnW6QJgztDHZ_I5NGJSTuTZiXTKywBzba0SK11qOmqdTTzHVpQ>
 <xmx:0cOlXuOUAsCjFdP59I1Vjoxwt16vrfrMVcglb2kTNEDBNTurFTDwqA>
 <xmx:0cOlXnpju243zG2XUnCkMOf8RSmvH2Uz276wxMMkynOkOXAlw68YEQ>
 <xmx:0sOlXtmvdu2y9htjjWZ_9yAyhq_ayCPsKX0qKdlFlbvSAxSDHofdWQ>
Received: from ThinkpadX1Yoga3.localdomain (c-73-93-84-208.hsd1.ca.comcast.net
 [73.93.84.208])
 by mail.messagingengine.com (Postfix) with ESMTPA id 25C4A3065E2B;
 Sun, 26 Apr 2020 13:24:33 -0400 (EDT)
From: Alistair Francis <alistair@alistair23.me>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 15/15] target/riscv: Support the v0.6 Hypervisor extension
 CRSs
Date: Sat, 25 Apr 2020 03:50:52 -0700
Message-Id: <9ff1ce7ccc2b257bec95152fea3ebf1d66e2e43f.1587918096.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1587918096.git.alistair.francis@wdc.com>
References: <cover.1587918096.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=64.147.123.20;
 envelope-from=alistair@alistair23.me; helo=wout4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 13:24:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 64.147.123.20
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h |  3 +++
 target/riscv/csr.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 8a145e0a32..690f327828 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -182,9 +182,12 @@
 #define CSR_HIDELEG         0x603
 #define CSR_HIE             0x604
 #define CSR_HCOUNTEREN      0x606
+#define CSR_HGEIE           0x607
 #define CSR_HTVAL           0x643
+#define CSR_HVIP            0x645
 #define CSR_HIP             0x644
 #define CSR_HTINST          0x64A
+#define CSR_HGEIP           0xE12
 #define CSR_HGATP           0x680
 #define CSR_HTIMEDELTA      0x605
 #define CSR_HTIMEDELTAH     0x615
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 04f3471f2e..3eb6ddd061 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -901,12 +901,25 @@ static int write_hideleg(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+static int rmw_hvip(CPURISCVState *env, int csrno, target_ulong *ret_value,
+                   target_ulong new_value, target_ulong write_mask)
+{
+    int ret = rmw_mip(env, 0, ret_value, new_value,
+                      write_mask & hip_writable_mask);
+
+    *ret_value &= hip_writable_mask;
+
+    return ret;
+}
+
 static int rmw_hip(CPURISCVState *env, int csrno, target_ulong *ret_value,
                    target_ulong new_value, target_ulong write_mask)
 {
     int ret = rmw_mip(env, 0, ret_value, new_value,
                       write_mask & hip_writable_mask);
 
+    *ret_value &= hip_writable_mask;
+
     return ret;
 }
 
@@ -934,6 +947,18 @@ static int write_hcounteren(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+static int read_hgeie(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    qemu_log_mask(LOG_UNIMP, "No support for a non-zero GEILEN.");
+    return 0;
+}
+
+static int write_hgeie(CPURISCVState *env, int csrno, target_ulong val)
+{
+    qemu_log_mask(LOG_UNIMP, "No support for a non-zero GEILEN.");
+    return 0;
+}
+
 static int read_htval(CPURISCVState *env, int csrno, target_ulong *val)
 {
     *val = env->htval;
@@ -957,6 +982,18 @@ static int write_htinst(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+static int read_hgeip(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    qemu_log_mask(LOG_UNIMP, "No support for a non-zero GEILEN.");
+    return 0;
+}
+
+static int write_hgeip(CPURISCVState *env, int csrno, target_ulong val)
+{
+    qemu_log_mask(LOG_UNIMP, "No support for a non-zero GEILEN.");
+    return 0;
+}
+
 static int read_hgatp(CPURISCVState *env, int csrno, target_ulong *val)
 {
     *val = env->hgatp;
@@ -1356,11 +1393,14 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_HSTATUS] =             { hmode,   read_hstatus,     write_hstatus    },
     [CSR_HEDELEG] =             { hmode,   read_hedeleg,     write_hedeleg    },
     [CSR_HIDELEG] =             { hmode,   read_hideleg,     write_hideleg    },
+    [CSR_HVIP] =                { hmode,   NULL,     NULL,     rmw_hvip       },
     [CSR_HIP] =                 { hmode,   NULL,     NULL,     rmw_hip        },
     [CSR_HIE] =                 { hmode,   read_hie,         write_hie        },
     [CSR_HCOUNTEREN] =          { hmode,   read_hcounteren,  write_hcounteren },
+    [CSR_HGEIE] =               { hmode,   read_hgeie,       write_hgeie      },
     [CSR_HTVAL] =               { hmode,   read_htval,       write_htval      },
     [CSR_HTINST] =              { hmode,   read_htinst,      write_htinst     },
+    [CSR_HGEIP] =               { hmode,   read_hgeip,       write_hgeip      },
     [CSR_HGATP] =               { hmode,   read_hgatp,       write_hgatp      },
     [CSR_HTIMEDELTA] =          { hmode,   read_htimedelta,  write_htimedelta },
 #if defined(TARGET_RISCV32)
-- 
2.26.2


