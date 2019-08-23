Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D82C3A5A4
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D9D20850
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bM8p8Dej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D9D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Jbs-0002Yd-3r
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 20:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCL-00015k-J9
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCK-0000IB-Kx
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38474)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCK-0000HJ-9p; Fri, 23 Aug 2019 19:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603745; x=1598139745;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=U9unKfj1ZfdPhA1mnGNX5+UqynVjiqRiftLGR7cQg+I=;
 b=bM8p8DejREqeiKGJRqUqqUJ6WUSd4lV2XJjU6jjd+9o2DkwWTvM164yY
 Q4/i4BygDnwqQp8PyMFSa2HY6QNUf1cOOOxRIc6TB0LSAnPwFkYtIQ/Iu
 Svro8r9o/K1NuQbE+wIjcvghFHwNtZl2f/6l8ElGwnswn34Q4BbPa6XGd
 jPjov+N1LWkQxzr0lnoazKdvALTuJXw0NaJkEHKBaGyGXa+s6aDxx4VbS
 KiVvG39NjLJ/9zmbKwNVVP7MBhBXXLPs5MQpS6OUejKvGUayDQVRdF5m8
 NV6dZu1QjnsPuUa/8tetVtxI1T7crvdxp83hG35AOV9SwFrdMLqvGEpcY Q==;
IronPort-SDR: IuvwMd2oTPuHTTnKyb4MSPtPdeqfjkBdQMMt2QExQ1ZRKAXjxZGTUtiTTeYWwG6EPkxP/74/TB
 iUQSuS/EIUBarb6lsCRyCmJA0vrXdMKSf/+Z7mmvdaeOWHGafvsSOq0twMIJvp8aJxjXeHtxAQ
 IFnZVzOM7OF5wF0JHugrdGFWJ4IJazaF+B49f+96ZXSvSHh6yvA+4NTIM0ClxoAs2HFRjmuRey
 QNhxcfwX57Z4eG0p3kb+za69TTKxdp82BE+bSvftjtDxGFmShv96P1YCQ4jF3AfoXqdDnsPrGj
 70c=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="117486905"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:23 +0800
IronPort-SDR: DZt9xMX1nxex6O641zNajEFYECaJeDZ/+fWHU9QrIPZbyo3fclVzZe+2SuWpXqZIPVDF2KVv0e
 E6JGGnZyK534uF9F7y3tXU+Cm6wC1WV4gW7lrrBeXcrCaXUTNThIPLLb/QUObWnFJbJ6d3D+GF
 sIROzR/Smqn5EoAokAiLVC8bxdn49y3GNhgtOpytCwLs7rn6nBracfjt4z7+VduhHe02U5m7O7
 3PIXf/6kntjVnD4sIWauODHN0IvDkneWomR1NFcBAox7j7w+Q2V43HqrSnISzD7GFQlaDjRHSz
 WGemBtmU+4vL7QvKBNbJbSME
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:40 -0700
IronPort-SDR: OdJriZI0HIhs3MtkHJsgTo/+T3ktPsjikzs+PzdRQJVZBXcdoiMuPMRb42bFwk2qe51JRqH5Bp
 W7Lj93oo+04rSAqQ0IOYurgZzuIePKrWQkuJLGypPdHo451EvBFrpHdZwC4W8chOq7MU92ZrCf
 hXAA9DL/LjHZfWRios2SZPqB72cT35sVS7n6VTmiHQ+oNYgkXQsKbiI+cbrsXmMZKluCVzbvuN
 FLpFp4VEToSg27MNfcGiLCch8hp6y1FC9yVb2lMOyLq1empFGx2/ASXFtGJWoTQRXMXm94PV0w
 Dgc=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 16:42:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:42 -0700
Message-Id: <035e50d6438660130233c472de56b883e369f6d4.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 20/28] target/riscv: Mark both sstatus and
 vsstatus as dirty
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark both sstatus and vsstatus as dirty (3).

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 8ac72c6470..19771904f4 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -44,6 +44,7 @@ typedef struct DisasContext {
     /* pc_succ_insn points to the instruction following base.pc_next */
     target_ulong pc_succ_insn;
     target_ulong priv_ver;
+    bool virt_enabled;
     uint32_t opcode;
     uint32_t mstatus_fs;
     uint32_t misa;
@@ -398,6 +399,12 @@ static void mark_fs_dirty(DisasContext *ctx)
     tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
     tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
     tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
+
+    if (ctx->virt_enabled) {
+        tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, vsstatus));
+        tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
+        tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, vsstatus));
+    }
     tcg_temp_free(tmp);
 }
 #else
@@ -742,6 +749,11 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
     ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
     ctx->priv_ver = env->priv_ver;
+#if !defined(CONFIG_USER_ONLY)
+    ctx->virt_enabled = riscv_cpu_virt_enabled(env);
+#else
+    ctx->virt_enabled = false;
+#endif
     ctx->misa = env->misa;
     ctx->frm = -1;  /* unknown rounding mode */
     ctx->ext_ifencei = cpu->cfg.ext_ifencei;
-- 
2.22.0


