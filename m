Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78D5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5A52075B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5A52075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAtM-00009B-1d
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoi-0008G9-6V
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:20 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:44295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoh-0006kl-0J
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:19 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MyKU6-1il4vM2d1I-00yiyJ; Fri, 05 Jun 2020 13:47:12 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 13/19] target/riscv/cpu: Restrict CPU migration to system-mode
Date: Fri,  5 Jun 2020 13:46:54 +0200
Message-Id: <20200605114700.1052050-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
References: <20200605114700.1052050-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+yuIL3rhe4m+tkgeYdCUZrkxqjcEDHc1NgD4xZtPGgte7ja/V/8
 1+4Ahe1ZfL8kPv98x+UxWrGoTbykYqzIa5DUFTalRCU10KUGg2BzTSgBqclfxOKM/eNmyiY
 QMplvPYTK76LwosG9FHv+isrUS23NcdIyrSCX8JZ5L7gdZFMCj7hTSSA0HP+rMMOZmgwRA1
 7tju7/asfefgDNv7zv+ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5Hl/0fjJGIA=:9e9bUGouSWDBnaoCqRgATh
 SADTfpTp6FFUYDlFcR034zbmK/VfYCr+FItCiChnmAnjSAgaXxGVKBv62p4dfBaLEwPgLSpCe
 qf15Ucnpm4tw8LpOsTqbT+dSmdJjDFKaEryolS17h/d5biV9gbD6eyUMy4w4rTrK8lneExT2I
 cjleKb1WFuMLB0e2I6XBzXYBM3arxa+pY3AVWluejo76UQpLv4I7CXTbc0HkrIiQsXh7GQxw9
 es7+1PYh/S+ZZ2fJn2fjzqHAZcyLb4JLlSlDASUY8PghiTa4dPxvgTJjeBQWH0eIbgzquChin
 7yqg5DKNVzw4O+8KGMtyAJCoAdp/FnUwwfdyms39c33Ng98NUjJD7d06elh71jCOF58bfDxaQ
 yBiZ3rVxmecMoRli0b7mhWzvEgKcDBNtXyqYJ8npjmiZ1RTtBigYqGzNkaeIHxbL0HAGXqBYp
 iWeUlvaDtGIOtKDcEo/BKw1FLbbEaGzgux/2oFosybVbZsr3A0cU0c6hlp7f/u3b07E44IRCt
 abDjVKlar+pib5rbwQtI9txqWhcPwNKzwpuz3P2P9QFUb3sqpFFZS7ZZr2dyi5FyAHontIVdV
 e14dShxCFmC5FL3QYYbfKC40CKN27LSu51UqJucVG66FQRxkTCVNb+Ej1Crz/jx3f9dvWWRnE
 kriot8F0sDR0rGb6DpL7zzKSoT9aPJ5TrE+T3VVenMRdZ8dXnwz0sEq5Y8A48q+5NuW9RPJY3
 71LGwRLFNwzGjs1hJIGluY6uX0ozVnmjWq/XPF5NMar7zcnww0s3TaF+h02xlJ9BiC5YUqXTw
 upSUF3f3TZ678GkUvxg10KX+wWQMEFIkVIrLDaXfbnlUVfQccQFU29E06KRKFIdACyRJ1ul
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200522172510.25784-8-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/riscv/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 059d71f2c715..6c78337858ad 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -485,10 +485,12 @@ static void riscv_cpu_init(Object *obj)
     cpu_set_cpustate_pointers(cpu);
 }
 
+#ifndef CONFIG_USER_ONLY
 static const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .unmigratable = 1,
 };
+#endif
 
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("i", RISCVCPU, cfg.ext_i, true),
@@ -544,13 +546,13 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->do_transaction_failed = riscv_cpu_do_transaction_failed;
     cc->do_unaligned_access = riscv_cpu_do_unaligned_access;
     cc->get_phys_page_debug = riscv_cpu_get_phys_page_debug;
+    /* For now, mark unmigratable: */
+    cc->vmsd = &vmstate_riscv_cpu;
 #endif
 #ifdef CONFIG_TCG
     cc->tcg_initialize = riscv_translate_init;
     cc->tlb_fill = riscv_cpu_tlb_fill;
 #endif
-    /* For now, mark unmigratable: */
-    cc->vmsd = &vmstate_riscv_cpu;
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
-- 
2.26.2


