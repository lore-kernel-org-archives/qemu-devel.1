Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187CCC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 19:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6AEA218A4
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 19:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="2ShDdEJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AEA218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hikcZ-0003JK-UU
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 15:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39478)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1hikba-0002Y8-QV
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 15:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1hikbY-0007SS-0Z
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 15:07:46 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:56434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1hikbX-0007Rh-Ks
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 15:07:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
 s=pic; 
 t=1562180862; h=Content-Transfer-Encoding: MIME-Version: Message-Id:
 Date: Subject: Cc: To: From: Sender;
 bh=bhPgRYbSneY4s1bR3e/dhpZYjODq0ldO7IJvZCUOrog=;
 b=2ShDdEJvVVukQQVZpAFOIhRqArhP6dCGRQZioKxVDAllXuYuxfRmThE15vDguhp4mwkEdqXN
 bDGwfU9Y+Zo0RwEXdOqKyvdKSVAS8VDU/0oLhyfvzhJcEdbASHKxrimBuFfF0I5p3wGgocx/
 +Lyf87pg+Yq6h+sX3Ghyn3AsVdsIVsGp4IrRkk8trRcdhDzE89teGuErK+5wNIalEjZqnId/
 3TYiDA0GQOFMmYy9eD08oxrfn9urcvOwGjE9Y0p8bSNtbBC46rsv9IbYMa2LBrL8vtyZdZVx
 F2VZk42+HABD/c21etus17h62uIwQDiGCv4C7qVGVwMRZMD4rD01/Q==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from jonathan-ThinkPad-X1-Carbon.csail.mit.edu
 (30-9-3.wireless.csail.mit.edu [128.30.9.3])
 by mxa.mailgun.org with ESMTP id 5d1cfcfc.7f5bee2bd210-smtp-out-n01;
 Wed, 03 Jul 2019 19:07:40 -0000 (UTC)
From: Jonathan Behrens <jonathan@fintelia.io>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 15:07:14 -0400
Message-Id: <20190703190715.5328-1-jonathan@fintelia.io>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.61.151.224
Subject: [Qemu-devel] [PATCH] target/riscv: Disallow WFI instruction from
 U-mode
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Jonathan Behrens <jonathan@fintelia.io>, Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
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
2.22.0

