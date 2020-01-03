Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155BAC00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861B621D7D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 08:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861B621D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inHvD-0003eu-KT
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 03:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Yiting.Wang@windriver.com>) id 1inEBn-00063D-Sh
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 23:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Yiting.Wang@windriver.com>) id 1inEBl-0003GR-RT
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 23:03:54 -0500
Received: from mail1.windriver.com ([147.11.146.13]:34826)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Yiting.Wang@windriver.com>)
 id 1inEBl-00035n-FE; Thu, 02 Jan 2020 23:03:53 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 0033rlmD027404
 (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
 Thu, 2 Jan 2020 19:53:47 -0800 (PST)
Received: from pek-vx-bsp3.wrs.com (128.224.156.141) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Thu, 2 Jan 2020 19:53:46 -0800
From: Yiting Wang <yiting.wang@windriver.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, <qemu-devel@nongnu.org>,
 <qemu-riscv@nongnu.org>
Subject: [PATCH] riscv: Set xPIE to 1 after xRET
Date: Fri, 3 Jan 2020 11:53:42 +0800
Message-ID: <1578023622-49180-1-git-send-email-yiting.wang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [128.224.156.141]
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 147.11.146.13
X-Mailman-Approved-At: Fri, 03 Jan 2020 03:01:32 -0500
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

When executing an xRET instruction, supposing xPP holds the
value y, xIE is set to xPIE; the privilege mode is changed to y;
xPIE is set to 1. But QEMU sets xPIE to 0 incorrectly.

Signed-off-by: Yiting Wang <yiting.wang@windriver.com>
---
 target/riscv/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 331cc36..e87c911 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -93,7 +93,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
         env->priv_ver >= PRIV_VERSION_1_10_0 ?
         MSTATUS_SIE : MSTATUS_UIE << prev_priv,
         get_field(mstatus, MSTATUS_SPIE));
-    mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
+    mstatus = set_field(mstatus, MSTATUS_SPIE, 1);
     mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
     riscv_cpu_set_mode(env, prev_priv);
     env->mstatus = mstatus;
@@ -118,7 +118,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
         env->priv_ver >= PRIV_VERSION_1_10_0 ?
         MSTATUS_MIE : MSTATUS_UIE << prev_priv,
         get_field(mstatus, MSTATUS_MPIE));
-    mstatus = set_field(mstatus, MSTATUS_MPIE, 0);
+    mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
     mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
     riscv_cpu_set_mode(env, prev_priv);
     env->mstatus = mstatus;
-- 
2.7.4


