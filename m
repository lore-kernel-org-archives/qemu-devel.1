Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1C4C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 21:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F524206CA
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 21:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ijMd150l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F524206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS53K-0003B8-Vy
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 17:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamensky@cisco.com>)
 id 1kS4Ya-0006LM-Qe
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:36:32 -0400
Received: from alln-iport-4.cisco.com ([173.37.142.91]:33673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamensky@cisco.com>)
 id 1kS4YW-00035y-Vj
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=5135; q=dns/txt; s=iport;
 t=1602534989; x=1603744589;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YuWmZB3z/ElnkoG6DNEe42TLpbP7hxfWefLRnwleHd4=;
 b=ijMd150l2tye4eclq8Th8XehxigWE0YzOaDPs5xGSWwG+ohCMcEu9enV
 4kCxj90M6vpD0l/9pDp+2+mFsWUZ67iAm0VJ09v3J8BC3G3VaKpdcbWSt
 yR45vwwigrXpt906oVgDWOepbNO4taz4fSNksXLL/hy9ndeuXvm59qd6E 4=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ByBADMvYRf/4sNJK1gHQEBAQEJARI?=
 =?us-ascii?q?BBQUBgg+BdTVwVQEyLLF9CwEBAQ0BASMMBAEBhEoCghYCJTgTAgMBAQsBAQU?=
 =?us-ascii?q?BAQECAQYEbYVcDIVzBjIBOQ0QUVcGARKDJgGCfA+mdoIoikMGgTiIN4R/G4I?=
 =?us-ascii?q?Ag2xzglwEF4c9BJMJAYdnAYFsmwKCcoMVhWyRWQ8ioTqTIopxlTQCBAYFAhW?=
 =?us-ascii?q?BayOBV00jFYMkUBkNlySFYiEDMAI1AgYKAQEDCY5IAQE?=
X-IronPort-AV: E=Sophos;i="5.77,367,1596499200"; d="scan'208";a="560737786"
Received: from alln-core-6.cisco.com ([173.36.13.139])
 by alln-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
 12 Oct 2020 20:36:25 +0000
Received: from kamensky-p53s.cisco.com ([10.24.37.191]) (authenticated bits=0)
 by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPSA id 09CKaGHQ032678
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 12 Oct 2020 20:36:24 GMT
From: Victor Kamensky <kamensky@cisco.com>
To: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Cc: qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Khem Raj <raj.khem@gmail.com>
Subject: [PATCH 1/1] mips: add 34Kf-64tlb fictitious cpu type like 34Kf but
 with 64 TLBs
Date: Mon, 12 Oct 2020 13:36:13 -0700
Message-Id: <20201012203613.85823-2-kamensky@cisco.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201012203613.85823-1-kamensky@cisco.com>
References: <20201012203613.85823-1-kamensky@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kamensky@cisco.com
X-Outbound-SMTP-Client: 10.24.37.191, [10.24.37.191]
X-Outbound-Node: alln-core-6.cisco.com
Received-SPF: pass client-ip=173.37.142.91; envelope-from=kamensky@cisco.com;
 helo=alln-iport-4.cisco.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 16:36:26
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -118
X-Spam_score: -11.9
X-Spam_bar: -----------
X-Spam_report: (-11.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

In Yocto Project CI runs it was observed that test run
of 32 bit mips image takes almost twice longer than 64 bit
mips image with the same logical load and CI execution
hits timeout.

See https://bugzilla.yoctoproject.org/show_bug.cgi?id=13992

Yocto project uses 34Kf cpu type to run 32 bit mips image,
and MIPS64R2-generic cpu type to run 64 bit mips64 image.

Upon qemu behavior differences investigation between mips
and mips64 two prominent observations came up: under
logically similar load (same definition and configuration
of user-land image) in case of mips get_physical_address
function is called almost twice more often, meaning
twice more memory accesses involved in this case. Also
number of tlbwr instruction executed (r4k_helper_tlbwr
qemu function) almost 16 time bigger in mips case than in
mips64.

It turns out that 34Kf cpu has 16 TLBs, but in case of
MIPS64R2-generic it is 64 TLBs. So that explains why
some many more tlbwr had to be execute by kernel TLB refill
handler in case of 32 bit misp.

The idea of the fix is to come up with new 34Kf-64tlb fictitious
cpu type, that would behave exactly as 34Kf but it would
contain 64 TLBs to reduce TLB trashing. After all, adding
more TLBs to soft mmu is easy.

Experiment with some significant non-trvial load in Yocto
environment by running do_testimage load shows that 34Kf-64tlb
cpu performs 40% or so better than original 34Kf cpu wrt test
execution real time.

It is not ideal to have cpu type that does not exist in the
wild but given performance gains it seems to be justified.

Signed-off-by: Victor Kamensky <kamensky@cisco.com>
---
 target/mips/translate_init.c.inc | 55 ++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/target/mips/translate_init.c.inc b/target/mips/translate_init.c.inc
index 637caccd89..b73ab48231 100644
--- a/target/mips/translate_init.c.inc
+++ b/target/mips/translate_init.c.inc
@@ -297,6 +297,61 @@ const mips_def_t mips_defs[] =
         .insn_flags = CPU_MIPS32R2 | ASE_MIPS16 | ASE_DSP | ASE_MT,
         .mmu_type = MMU_TYPE_R4000,
     },
+    /*
+     * Verbatim copy of "34Kf" cpu, only bumped up number of TLB entries
+     * from 16 to 64 (see CP0_Config0 value at CP0C1_MMU bits) to improve
+     * performance by reducing number of TLB refill exceptions and
+     * eliminating need to run all corresponding TLB refill handling
+     * instructions.
+     */
+    {
+        .name = "34Kf-64tlb",
+        .CP0_PRid = 0x00019500,
+        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) |
+                       (MMU_TYPE_R4000 << CP0C0_MT),
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_MMU) |
+                       (0 << CP0C1_IS) | (3 << CP0C1_IL) | (1 << CP0C1_IA) |
+                       (0 << CP0C1_DS) | (3 << CP0C1_DL) | (1 << CP0C1_DA) |
+                       (1 << CP0C1_CA),
+        .CP0_Config2 = MIPS_CONFIG2,
+        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_VInt) | (1 << CP0C3_MT) |
+                       (1 << CP0C3_DSPP),
+        .CP0_LLAddr_rw_bitmask = 0,
+        .CP0_LLAddr_shift = 0,
+        .SYNCI_Step = 32,
+        .CCRes = 2,
+        .CP0_Status_rw_bitmask = 0x3778FF1F,
+        .CP0_TCStatus_rw_bitmask = (0 << CP0TCSt_TCU3) | (0 << CP0TCSt_TCU2) |
+                    (1 << CP0TCSt_TCU1) | (1 << CP0TCSt_TCU0) |
+                    (0 << CP0TCSt_TMX) | (1 << CP0TCSt_DT) |
+                    (1 << CP0TCSt_DA) | (1 << CP0TCSt_A) |
+                    (0x3 << CP0TCSt_TKSU) | (1 << CP0TCSt_IXMT) |
+                    (0xff << CP0TCSt_TASID),
+        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_L) | (1 << FCR0_W) |
+                    (1 << FCR0_D) | (1 << FCR0_S) | (0x95 << FCR0_PRID),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
+        .CP0_SRSCtl = (0xf << CP0SRSCtl_HSS),
+        .CP0_SRSConf0_rw_bitmask = 0x3fffffff,
+        .CP0_SRSConf0 = (1U << CP0SRSC0_M) | (0x3fe << CP0SRSC0_SRS3) |
+                    (0x3fe << CP0SRSC0_SRS2) | (0x3fe << CP0SRSC0_SRS1),
+        .CP0_SRSConf1_rw_bitmask = 0x3fffffff,
+        .CP0_SRSConf1 = (1U << CP0SRSC1_M) | (0x3fe << CP0SRSC1_SRS6) |
+                    (0x3fe << CP0SRSC1_SRS5) | (0x3fe << CP0SRSC1_SRS4),
+        .CP0_SRSConf2_rw_bitmask = 0x3fffffff,
+        .CP0_SRSConf2 = (1U << CP0SRSC2_M) | (0x3fe << CP0SRSC2_SRS9) |
+                    (0x3fe << CP0SRSC2_SRS8) | (0x3fe << CP0SRSC2_SRS7),
+        .CP0_SRSConf3_rw_bitmask = 0x3fffffff,
+        .CP0_SRSConf3 = (1U << CP0SRSC3_M) | (0x3fe << CP0SRSC3_SRS12) |
+                    (0x3fe << CP0SRSC3_SRS11) | (0x3fe << CP0SRSC3_SRS10),
+        .CP0_SRSConf4_rw_bitmask = 0x3fffffff,
+        .CP0_SRSConf4 = (0x3fe << CP0SRSC4_SRS15) |
+                    (0x3fe << CP0SRSC4_SRS14) | (0x3fe << CP0SRSC4_SRS13),
+        .SEGBITS = 32,
+        .PABITS = 32,
+        .insn_flags = CPU_MIPS32R2 | ASE_MIPS16 | ASE_DSP | ASE_MT,
+        .mmu_type = MMU_TYPE_R4000,
+    },
     {
         .name = "74Kf",
         .CP0_PRid = 0x00019700,
-- 
2.25.4


