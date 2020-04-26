Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36634C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0075520700
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f003imRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0075520700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSkEX-0008DJ-VJ
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 12:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk8H-0005JM-Vq
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk8H-0004pq-FA
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk8G-0004hK-Sb; Sun, 26 Apr 2020 12:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587918472; x=1619454472;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UkQ8NUev/k/AlnUkXpZj+rX7oYGCYUShPbguTwLEfK8=;
 b=f003imRJnHLU997KRBQDU4zWPj3z96eWMMdx2jJbZbPzWwo1fPY5bRb6
 D3H1YFAsAiM/PqYZZrgGVggZUCHz6aTHu4+atJfP4Z68H23WXmtWoWdVP
 z5/7cFsb1schk81Rpi1D8kA4TaO+hwo/hEbMWWdXw53F0IPLnx7k34FeG
 Xi4P88+K21bGVqH3cwLwvlPZNfWQFYrrcnOScVPuyeqIiGdbZ375+Iow8
 2PEsG5Ls8+uJHwVorRqhUO3ba67nt+9/5jhvp/5X+71EAfkGGoU9RL/8A
 s+pkz+CCf5xIM363ulLcJ8sSu7ZyxveI7VPAIuePXLO4IelezwmkOflqT A==;
IronPort-SDR: QPU8xHMKFPhAS/pQ++rBIYLuExO4Xo6QnXIFsGwTceFD3fzQdaNzwCWpMmMtRUgYoUZqHBPUb9
 iPbkct0Y+llmdcLjKkVFIkSNa3bLSfNJ5tgfDtCkojZE9kPsPOLnpbwVlQYb1PSSwUF4ixZCX7
 mxl8UoYBD8Kfep5wNmoUVutNAQ8AYeqL1PoNbmtdtygdbMUUIMj1yiO33dalHmK5LBRyxR9+FN
 ALQbRqffLhvICv9PpbTrzg6q4LqeVsgVTE2jEvfc2ilsnkb5Lp2aLOMeCY7pLEBmuSLHE3gmTL
 Yeg=
X-IronPort-AV: E=Sophos;i="5.73,320,1583164800"; d="scan'208";a="136193251"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 00:27:50 +0800
IronPort-SDR: H/cTgOQmL6JUxgaTupXXuZ4RSkmLdclbpgydzA6GvdDWOITGYkFSiaKo4HVnaA/5CpOV4lg0sI
 WMQYmDs4kHP+fB96I4pdZE+QERIssRBqU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 09:18:00 -0700
IronPort-SDR: XcfAmeVNywNSdqqv6cjX04wsNOKlz91syYphokrPg4qEAEuHZ2Ws1t7WuuYWa4fc6zBmXeryn+
 suXkyOSRvbrw==
WDCIronportException: Internal
Received: from wdthnc17-0189.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.50])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Apr 2020 09:27:50 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 10/15] target/riscv: Fix the interrupt cause code
Date: Sun, 26 Apr 2020 09:19:39 -0700
Message-Id: <d78f2856babe15498e5503aef6b89a997ce24bee.1587917657.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1587917657.git.alistair.francis@wdc.com>
References: <cover.1587917657.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=378a396a1=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 12:27:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.42
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
 target/riscv/cpu_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 93df7a896d..f7ada23861 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -925,14 +925,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
             if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
                 !force_hs_execp) {
+                /* Trap to VS mode */
                 /*
                  * See if we need to adjust cause. Yes if its VS mode interrupt
                  * no if hypervisor has delegated one of hs mode's interrupt
                  */
                 if (cause == IRQ_VS_TIMER || cause == IRQ_VS_SOFT ||
-                    cause == IRQ_VS_EXT)
+                    cause == IRQ_VS_EXT) {
                     cause = cause - 1;
-                /* Trap to VS mode */
+                }
                 env->hstatus = set_field(env->hstatus, HSTATUS_GVA, 0);
             } else if (riscv_cpu_virt_enabled(env)) {
                 /* Trap into HS mode, from virt */
-- 
2.26.2


