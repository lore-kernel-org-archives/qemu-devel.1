Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E18ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415DD20578
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aTL6mmAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415DD20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO98h-000635-Pc
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91D-0005Dw-E8
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91C-0004a9-6z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:19 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91B-0004Yx-U4; Fri, 25 Oct 2019 19:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046158; x=1603582158;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Lvx9EFzt7D2eyEPDFxq/tAplhRU6Edal/BZ9pVFsLkw=;
 b=aTL6mmAvlKPon4M47CK7BjVrPWtreKSFxQoTrdmkds9FjZDWkhD0UlmB
 DgdKgDDgSx8JJW2bPah9SpSMGrqyKkZIjXP7ScfpzkjfDmgOB8v+1ED2Q
 rHiAPfjqkFs0GIkgcoG3EBdp4eW/gfNh1ADuo6DC08xepkn6nniRRNY4V
 eAn1btf/XxzOANkXuddjUj6sASChtszkVzVMZSuHuWFd+jb8BTzMghH4q
 OJpvsQaSo8OTpakxR5ljoXe0At/t4bNfWEfKTZhHAHrhfUm01cvKerLVf
 qtoP/2615SxHOKODFoHb2jSElKuoR1cDuJrGN+TAcKPKnVV5qtV+kgtp6 w==;
IronPort-SDR: ug/ibafVvzl2MLzy+JFqgCrZg2ds+MEpnthNvKNNUvFUgzNqQj1IUs14fVlEyNic5EdggeTTia
 2UZnDZmfVf92MtkLxyZ+SFw3u9Qv6oZaaGqC1887Ci2JWi4E/ktbHauaEDFhapsK9jlw3LHtno
 XYl/4T8+9ngWMDNpBS6AprUFBLAbL7JnjBGV71GShAMTtH9CSsiFDPnrGcGtuo61mdi37SGU1d
 DTaddsn9M4FHEFyC+upDXJpF2S/izDr3vk6/AMX8ssHdkA9TF9GyDnHvldsnSLDAopDIYOaMH4
 O10=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="122956693"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:29:17 +0800
IronPort-SDR: 2tLYbkB03UX1I5ADEoc5UmZO5TWbGWWxWp4DrDxPxpXAHs56h6h/YJAssoQvRrl4lZ/NKfIbtK
 LKBWdYaFV/QqnjGPu187fNh6kAfMUNDJA3JXavSGZzJzGHwfgiTO2TG1SW9MzPQb9/9wKl3KhR
 ZlAzX2ECvTtxqUqQZTYP67OORvIVLDXZVbnnMp/o1lYoe6PYthd0+Gzssr+ksZl04BT0OCMuUx
 PqyHbGvX3aGQpxMk/6yI7ceVugAot5ZlQnjIXNKZ6YcRKutJZcBsyM2PFsFQtxwEJnIzngT4oR
 EXigKPcNm2Ay18F5HSNpIS9h
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:24:42 -0700
IronPort-SDR: diXSoMDvpi/YP4ck1u0CTzQmqkFlayyWMGCkHonQVGBNqviWF6oUD95RnA5OStiNmcy4YgSxjA
 /tr0gxYSg739iMyKtTnUNNFlJMmzVS5Qymlm8TflhhweaYkIXQx44BgGnS3nw7+sc8qi4BnUtm
 Pq/GZkNJqZeymsoq0YRR5bi4zvc6+SBrgIOmT458d6OVrh85VsAMuqCzv57Xa42+QZoB8Iy6up
 67DpDm358V/pxGH+C2/KarDfS5rSjWl3GMbIA5CozltR2cBtQe/V/w4KsgGlzh+1qBdAegNKdb
 sG8=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2019 16:29:17 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 21/27] target/riscv: Mark both sstatus and vsstatus as dirty
Date: Fri, 25 Oct 2019 16:24:21 -0700
Message-Id: <052da23621682c72a81bc0c4203fd817cd493987.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.45
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark both sstatus and vsstatus as dirty (3).

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
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
2.23.0


