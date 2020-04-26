Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9E8C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480E620700
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iXiRGLOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480E620700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSkGp-0003mq-Dh
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 12:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk88-0004vG-Hh
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk87-0004fV-W0
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:44 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk87-0004Yo-9J; Sun, 26 Apr 2020 12:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587918464; x=1619454464;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=U9NW71QBtaBT2C/c8qX+ZhjOWiZi+R1r2IaxEavGYjI=;
 b=iXiRGLOUOn/icu0mtfvfCClOszUvwHPgVnvgA1HVFa3eIEJoG6Y3kzPL
 syjuwS/8DQp3p+7VvxojY5z4e/wHG2/+SqZ1S982GLvsC8sa1L/fHdOdl
 rNYEEOm7kgC07J/CGedvCZ/AKubQKgQIhB1xZzL2QxoPZPZDIWlpQRTh4
 EFmgwR5kfuZd+EgsgK3UTEoiREZ548Rs+Q13xgbenNNLPKJ2jRgn5qohj
 f3vWwOiQl/6JRKpnSH7eRqF18f81kur9N0WyMuxgudmw9J2ZODqswCu8R
 sv2ih+qTfdyI2ho4ImpvoIdGwSZZw+zIewaSU/qGHwu1BWYn4yMcsXDwo Q==;
IronPort-SDR: P9xBOjb6EUMnwgrrtfjTr73OhNOOGY3DPIpQf51aSqKgEqwLX61BYXqNnlVKmC2KOmjpSsmoUI
 0hmFsdu++DmmLXj39VTH2taXY2G1qZ+9whmpodU/jAo5ZaD4rondgcDfSfQLk4kUqphzJaZNiJ
 jOeag0bIriWPByXs7VlVFHK+BOOvEqzwJMkCSjLe5tkzYlmdP4mJFwota2GZqK4WVIBeKI8MGS
 t17zOAHDYnB+MjmM918F0d1KKrklPK8MEi5oiBjRoc7vOokFxyEJMNBns+xhxKqiCn8RQv6g4I
 bxc=
X-IronPort-AV: E=Sophos;i="5.73,320,1583164800"; d="scan'208";a="137626678"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 00:27:42 +0800
IronPort-SDR: h0ln9wSw3OvTdPsgM3d4FXT2n3w6rJi1XyRGi23AJxHgxyuCSQwwolWjuiPwcBEWd21J8oNsou
 jNXoyHBfrq8brH3CwEVXQ5OHCEb8HmNLk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 09:18:25 -0700
IronPort-SDR: 5gFv1QW0g9vV6pmVOgE2xBzPSx7ESy3gcvOaBROlG20RaxiPNoqT2jpCDdSHijiTpi5/gW8BCf
 Cn3pKhqj8NAg==
WDCIronportException: Internal
Received: from wdthnc17-0189.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.50])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Apr 2020 09:27:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 07/15] target/riscv: Do two-stage lookups on hlv/hlvx/hsv
 instructions
Date: Sun, 26 Apr 2020 09:19:31 -0700
Message-Id: <e2464f212b3eb821ec7fab00861d448de54fd2fb.1587917657.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1587917657.git.alistair.francis@wdc.com>
References: <cover.1587917657.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=378a396a1=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 12:27:33
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 54 +++++++++++++++------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 075675c59c..2ac599505f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -340,22 +340,13 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
      * was called. Background registers will be used if the guest has
      * forced a two stage translation to be on (in HS or M mode).
      */
+    if (riscv_cpu_two_stage_lookup(env) && access_type != MMU_INST_FETCH) {
+        use_background = true;
+    }
+
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(env->mstatus, MSTATUS_MPRV)) {
             mode = get_field(env->mstatus, MSTATUS_MPP);
-
-            if (riscv_has_ext(env, RVH) &&
-                MSTATUS_MPV_ISSET(env)) {
-                use_background = true;
-            }
-        }
-    }
-
-    if (mode == PRV_S && access_type != MMU_INST_FETCH &&
-        riscv_has_ext(env, RVH) && !riscv_cpu_virt_enabled(env)) {
-        if (get_field(env->hstatus, HSTATUS_SPRV)) {
-            mode = get_field(env->mstatus, SSTATUS_SPP);
-            use_background = true;
         }
     }
 
@@ -727,8 +718,6 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     hwaddr pa = 0;
     int prot, prot2;
     bool pmp_violation = false;
-    bool m_mode_two_stage = false;
-    bool hs_mode_two_stage = false;
     bool first_stage_error = true;
     int ret = TRANSLATE_FAIL;
     int mode = mmu_idx;
@@ -738,30 +727,21 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
-    /*
-     * Determine if we are in M mode and MPRV is set or in HS mode and SPRV is
-     * set and we want to access a virtulisation address.
-     */
-    if (riscv_has_ext(env, RVH)) {
-        m_mode_two_stage = env->priv == PRV_M &&
-                           access_type != MMU_INST_FETCH &&
-                           get_field(env->mstatus, MSTATUS_MPRV) &&
-                           MSTATUS_MPV_ISSET(env);
-
-        hs_mode_two_stage = env->priv == PRV_S &&
-                            !riscv_cpu_virt_enabled(env) &&
-                            access_type != MMU_INST_FETCH &&
-                            get_field(env->hstatus, HSTATUS_SPRV) &&
-                            get_field(env->hstatus, HSTATUS_SPV);
-    }
-
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
         if (get_field(env->mstatus, MSTATUS_MPRV)) {
             mode = get_field(env->mstatus, MSTATUS_MPP);
         }
     }
 
-    if (riscv_cpu_virt_enabled(env) || m_mode_two_stage || hs_mode_two_stage) {
+    if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
+        access_type != MMU_INST_FETCH &&
+        get_field(env->mstatus, MSTATUS_MPRV) &&
+        MSTATUS_MPV_ISSET(env)) {
+        riscv_cpu_set_two_stage_lookup(env, true);
+    }
+
+    if (riscv_cpu_virt_enabled(env) ||
+        (riscv_cpu_two_stage_lookup(env) && access_type != MMU_INST_FETCH)) {
         /* Two stage lookup */
         ret = get_physical_address(env, &pa, &prot, address, access_type,
                                    mmu_idx, true, true);
@@ -813,6 +793,14 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       __func__, address, ret, pa, prot);
     }
 
+    /* We did the two stage lookup based on MPRV, unset the lookup */
+    if (riscv_has_ext(env, RVH) && env->priv == PRV_M &&
+        access_type != MMU_INST_FETCH &&
+        get_field(env->mstatus, MSTATUS_MPRV) &&
+        MSTATUS_MPV_ISSET(env)) {
+        riscv_cpu_set_two_stage_lookup(env, false);
+    }
+
     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
         (ret == TRANSLATE_SUCCESS) &&
         !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
-- 
2.26.2


