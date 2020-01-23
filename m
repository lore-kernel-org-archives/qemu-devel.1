Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FA9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E0F2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="XPCxl8DO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E0F2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiYh-0004BX-HY
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iuiXo-0002Tx-HF
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iuiXn-0000ph-Gv
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:53:36 -0500
Received: from rs224.mailgun.us ([209.61.151.224]:18895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iuiXn-0000lC-Bn
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:53:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
 s=pic; 
 t=1579809209; h=Content-Transfer-Encoding: MIME-Version: Message-Id:
 Date: Subject: Cc: To: From: Sender;
 bh=8t+fDncYfgnFj/SFRiDptoWecMF8tAS/UKt2nRHgxxQ=;
 b=XPCxl8DOP04VubHDUT+Pl5xqKqfVdI02jiyZev/xNzdrEZF189YdyjpHGaX6e158PE+0D0i0
 BOT5vJ4rtXT+b5Of6/b5GMT2xXketMQWMCoI8BBS8KZoRMjUiJdTb4eA/9qjBRyANwbvlQTd
 G6OerZZlXjULEdqTFeQlip83yH3lOPJEu9lWKqkspvP5HIsGo+fS93PW/i16EEZsuAG/QPkn
 TNTxBNynI0ZeBr1GyouPvuQP/uz48IhMCrLSejaBjvayM1gt1iRLiAf9K4olWqKPHNKgBobY
 zQBeVaKHyJlm7zZ+oxyeMmkU+fzh40OtA3/P+f6I2lROHQ1RsVd3pw==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from jonathan-ThinkPad-X1-Carbon.pdos.lcs.mit.edu
 (26-5-211.dynamic.csail.mit.edu [18.26.5.211])
 by mxa.mailgun.org with ESMTP id 5e29f9b7.7fca702fc818-smtp-out-n03;
 Thu, 23 Jan 2020 19:53:27 -0000 (UTC)
From: Jonathan Behrens <jonathan@fintelia.io>
To: 
Subject: [PATCH] target/riscv: Disallow WFI instruction from U-mode
Date: Thu, 23 Jan 2020 14:52:00 -0500
Message-Id: <20200123195200.206355-1-jonathan@fintelia.io>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.61.151.224
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Jonathan Behrens <jonathan@fintelia.io>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From the RISC-V Priviliged Specification:

"When S-mode is implemented, then executing WFI in U-mode causes an illegal
instruction exception, unless it completes within an implementation-specific,
bounded time limit. A future revision of this specification might add a feature
that allows S-mode to selectively permit WFI in U-mode."

Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 331cc36232..2e5a980192 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -129,10 +129,10 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
-
-    if (env->priv == PRV_S &&
-        env->priv_ver >= PRIV_VERSION_1_10_0 &&
-        get_field(env->mstatus, MSTATUS_TW)) {
+    if (!(env->priv >= PRV_S) ||
+        (env->priv == PRV_S &&
+         env->priv_ver >= PRIV_VERSION_1_10_0 &&
+         get_field(env->mstatus, MSTATUS_TW))) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
         cs->halted = 1;
-- 
2.25.0

