Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE5CC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A1E21783
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A1E21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDkEb-0002Re-IA
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 03:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iDjez-0007MJ-KO
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iDjer-000463-7e
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:23:21 -0400
Received: from mail01.asahi-net.or.jp ([202.224.55.13]:54370)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iDjeq-0003wh-Mq
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:23:13 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail01.asahi-net.or.jp (Postfix) with ESMTPA id 22FBB86EA0;
 Fri, 27 Sep 2019 15:23:11 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 8F0B8240085;
 Fri, 27 Sep 2019 15:23:10 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH v25 07/22] target/rx: RX disassembler
Date: Fri, 27 Sep 2019 15:22:47 +0900
Message-Id: <20190927062302.110144-8-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927062302.110144-1-ysato@users.sourceforge.jp>
References: <20190927062302.110144-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.13
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
Cc: peter.maydell@linaro.org, imammedo@redhat.com, richard.henderson@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190607091116.49044-5-ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/dis-asm.h |    5 +
 target/rx/disas.c       | 1480 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 1485 insertions(+)
 create mode 100644 target/rx/disas.c

diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index e9c7dd8eb4..a900bd0a27 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -226,6 +226,10 @@ enum bfd_architecture
 #define bfd_mach_nios2r2        2
   bfd_arch_lm32,       /* Lattice Mico32 */
 #define bfd_mach_lm32 1
+  bfd_arch_rx,       /* Renesas RX */
+#define bfd_mach_rx            0x75
+#define bfd_mach_rx_v2         0x76
+#define bfd_mach_rx_v3         0x77
   bfd_arch_last
   };
 #define bfd_mach_s390_31 31
@@ -433,6 +437,7 @@ int print_insn_little_nios2     (bfd_vma, disassemble=
_info*);
 int print_insn_xtensa           (bfd_vma, disassemble_info*);
 int print_insn_riscv32          (bfd_vma, disassemble_info*);
 int print_insn_riscv64          (bfd_vma, disassemble_info*);
+int print_insn_rx(bfd_vma, disassemble_info *);
=20
 #if 0
 /* Fetch the disassembler for a given BFD, if that support is available.=
  */
diff --git a/target/rx/disas.c b/target/rx/disas.c
new file mode 100644
index 0000000000..8cada4825d
--- /dev/null
+++ b/target/rx/disas.c
@@ -0,0 +1,1480 @@
+/*
+ * Renesas RX Disassembler
+ *
+ * Copyright (c) 2019 Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOU=
T
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "disas/dis-asm.h"
+#include "qemu/bitops.h"
+#include "cpu.h"
+
+typedef struct DisasContext {
+    disassemble_info *dis;
+    uint32_t addr;
+    uint32_t pc;
+} DisasContext;
+
+
+static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
+                           int i, int n)
+{
+    bfd_byte buf;
+    while (++i <=3D n) {
+        ctx->dis->read_memory_func(ctx->addr++, &buf, 1, ctx->dis);
+        insn |=3D buf << (32 - i * 8);
+    }
+    return insn;
+}
+
+static int32_t li(DisasContext *ctx, int sz)
+{
+    int32_t addr;
+    bfd_byte buf[4];
+    addr =3D ctx->addr;
+
+    switch (sz) {
+    case 1:
+        ctx->addr +=3D 1;
+        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
+        return (int8_t)buf[0];
+    case 2:
+        ctx->addr +=3D 2;
+        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
+        return ldsw_le_p(buf);
+    case 3:
+        ctx->addr +=3D 3;
+        ctx->dis->read_memory_func(addr, buf, 3, ctx->dis);
+        return (int8_t)buf[2] << 16 | lduw_le_p(buf);
+    case 0:
+        ctx->addr +=3D 4;
+        ctx->dis->read_memory_func(addr, buf, 4, ctx->dis);
+        return ldl_le_p(buf);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static int bdsp_s(DisasContext *ctx, int d)
+{
+    /*
+     * 0 -> 8
+     * 1 -> 9
+     * 2 -> 10
+     * 3 -> 3
+     * :
+     * 7 -> 7
+     */
+    if (d < 3) {
+        d +=3D 8;
+    }
+    return d;
+}
+
+/* Include the auto-generated decoder.  */
+#include "decode.inc.c"
+
+#define prt(...) (ctx->dis->fprintf_func)((ctx->dis->stream), __VA_ARGS_=
_)
+
+#define RX_MEMORY_BYTE 0
+#define RX_MEMORY_WORD 1
+#define RX_MEMORY_LONG 2
+
+#define RX_IM_BYTE 0
+#define RX_IM_WORD 1
+#define RX_IM_LONG 2
+#define RX_IM_UWORD 3
+
+static const char size[] =3D {'b', 'w', 'l'};
+static const char cond[][4] =3D {
+    "eq", "ne", "c", "nc", "gtu", "leu", "pz", "n",
+    "ge", "lt", "gt", "le", "o", "no", "ra", "f"
+};
+static const char psw[] =3D {
+    'c', 'z', 's', 'o', 0, 0, 0, 0,
+    'i', 'u', 0, 0, 0, 0, 0, 0,
+};
+
+static uint32_t rx_index_addr(int ld, int size, DisasContext *ctx)
+{
+    bfd_byte buf[2];
+    switch (ld) {
+    case 0:
+        return 0;
+    case 1:
+        ctx->dis->read_memory_func(ctx->addr, buf, 1, ctx->dis);
+        ctx->addr +=3D 1;
+        return ((uint8_t)buf[0]) << size;
+    case 2:
+        ctx->dis->read_memory_func(ctx->addr, buf, 2, ctx->dis);
+        ctx->addr +=3D 2;
+        return lduw_le_p(buf) << size;
+    }
+    g_assert_not_reached();
+}
+
+static void operand(DisasContext *ctx, int ld, int mi, int rs, int rd)
+{
+    int dsp;
+    static const char sizes[][4] =3D {".b", ".w", ".l", ".uw", ".ub"};
+    if (ld < 3) {
+        switch (mi) {
+        case 4:
+            /* dsp[rs].ub */
+            dsp =3D rx_index_addr(ld, RX_MEMORY_BYTE, ctx);
+            break;
+        case 3:
+            /* dsp[rs].uw */
+            dsp =3D rx_index_addr(ld, RX_MEMORY_WORD, ctx);
+            break;
+        default:
+            /* dsp[rs].b */
+            /* dsp[rs].w */
+            /* dsp[rs].l */
+            dsp =3D rx_index_addr(ld, mi, ctx);
+            break;
+        }
+        if (dsp > 0) {
+            prt("%d", dsp);
+        }
+        prt("[r%d]%s", rs, sizes[mi]);
+    } else {
+        prt("r%d", rs);
+    }
+    prt(", r%d", rd);
+}
+
+static void prt_ir(DisasContext *ctx, const char *insn, int imm, int rd)
+{
+    if (imm < 0x100) {
+        prt("%s\t#%d, r%d", insn, imm, rd);
+    } else {
+        prt("%s\t#0x%08x, r%d", insn, imm, rd);
+    }
+}
+
+/* mov.[bwl] rs,dsp:[rd] */
+static bool trans_MOV_rm(DisasContext *ctx, arg_MOV_rm *a)
+{
+    if (a->dsp > 0) {
+        prt("mov.%c\tr%d,%d[r%d]",
+            size[a->sz], a->rs, a->dsp << a->sz, a->rd);
+    } else {
+        prt("mov.%c\tr%d,[r%d]",
+            size[a->sz], a->rs, a->rd);
+    }
+    return true;
+}
+
+/* mov.[bwl] dsp:[rs],rd */
+static bool trans_MOV_mr(DisasContext *ctx, arg_MOV_mr *a)
+{
+    if (a->dsp > 0) {
+        prt("mov.%c\t%d[r%d], r%d",
+            size[a->sz], a->dsp << a->sz, a->rs, a->rd);
+    } else {
+        prt("mov.%c\t[r%d], r%d",
+            size[a->sz], a->rs, a->rd);
+    }
+    return true;
+}
+
+/* mov.l #uimm4,rd */
+/* mov.l #uimm8,rd */
+/* mov.l #imm,rd */
+static bool trans_MOV_ir(DisasContext *ctx, arg_MOV_ir *a)
+{
+    prt_ir(ctx, "mov.l", a->imm, a->rd);
+    return true;
+}
+
+/* mov.[bwl] #uimm8,dsp:[rd] */
+/* mov #imm, dsp:[rd] */
+static bool trans_MOV_im(DisasContext *ctx, arg_MOV_im *a)
+{
+    if (a->dsp > 0) {
+        prt("mov.%c\t#%d,%d[r%d]",
+            size[a->sz], a->imm, a->dsp << a->sz, a->rd);
+    } else {
+        prt("mov.%c\t#%d,[r%d]",
+            size[a->sz], a->imm, a->rd);
+    }
+    return true;
+}
+
+/* mov.[bwl] [ri,rb],rd */
+static bool trans_MOV_ar(DisasContext *ctx, arg_MOV_ar *a)
+{
+    prt("mov.%c\t[r%d,r%d], r%d", size[a->sz], a->ri, a->rb, a->rd);
+    return true;
+}
+
+/* mov.[bwl] rd,[ri,rb] */
+static bool trans_MOV_ra(DisasContext *ctx, arg_MOV_ra *a)
+{
+    prt("mov.%c\tr%d, [r%d, r%d]", size[a->sz], a->rs, a->ri, a->rb);
+    return true;
+}
+
+
+/* mov.[bwl] dsp:[rs],dsp:[rd] */
+/* mov.[bwl] rs,dsp:[rd] */
+/* mov.[bwl] dsp:[rs],rd */
+/* mov.[bwl] rs,rd */
+static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
+{
+    int dsp;
+
+    prt("mov.%c\t", size[a->sz]);
+    if (a->lds =3D=3D 3 && a->ldd =3D=3D 3) {
+        /* mov.[bwl] rs,rd */
+        prt("r%d, r%d", a->rs, a->rd);
+        return true;
+    }
+    if (a->lds =3D=3D 3) {
+        prt("r%d, ", a->rd);
+        dsp =3D rx_index_addr(a->ldd, a->sz, ctx);
+        if (dsp > 0) {
+            prt("%d", dsp);
+        }
+        prt("[r%d]", a->rs);
+    } else if (a->ldd =3D=3D 3) {
+        dsp =3D rx_index_addr(a->lds, a->sz, ctx);
+        if (dsp > 0) {
+            prt("%d", dsp);
+        }
+        prt("[r%d], r%d", a->rs, a->rd);
+    } else {
+        dsp =3D rx_index_addr(a->lds, a->sz, ctx);
+        if (dsp > 0) {
+            prt("%d", dsp);
+        }
+        prt("[r%d], ", a->rs);
+        dsp =3D rx_index_addr(a->ldd, a->sz, ctx);
+        if (dsp > 0) {
+            prt("%d", dsp);
+        }
+        prt("[r%d]", a->rd);
+    }
+    return true;
+}
+
+/* mov.[bwl] rs,[rd+] */
+/* mov.[bwl] rs,[-rd] */
+static bool trans_MOV_rp(DisasContext *ctx, arg_MOV_rp *a)
+{
+    prt("mov.%c\tr%d, ", size[a->sz], a->rs);
+    prt((a->ad =3D=3D 0) ? "[r%d+]" : "[-r%d]", a->rd);
+    return true;
+}
+
+/* mov.[bwl] [rd+],rs */
+/* mov.[bwl] [-rd],rs */
+static bool trans_MOV_pr(DisasContext *ctx, arg_MOV_pr *a)
+{
+    prt("mov.%c\t", size[a->sz]);
+    prt((a->ad =3D=3D 0) ? "[r%d+]" : "[-r%d]", a->rd);
+    prt(", r%d", a->rs);
+    return true;
+}
+
+/* movu.[bw] dsp5:[rs],rd */
+static bool trans_MOVU_mr(DisasContext *ctx, arg_MOVU_mr *a)
+{
+    if (a->dsp > 0) {
+        prt("movu.%c\t%d[r%d], r%d", size[a->sz],
+            a->dsp << a->sz, a->rs, a->rd);
+    } else {
+        prt("movu.%c\t[r%d], r%d", size[a->sz], a->rs, a->rd);
+    }
+    return true;
+}
+
+/* movu.[bw] rs,rd */
+static bool trans_MOVU_rr(DisasContext *ctx, arg_MOVU_rr *a)
+{
+    prt("movu.%c\tr%d, r%d", size[a->sz], a->rs, a->rd);
+    return true;
+}
+
+/* movu.[bw] [ri,rb],rd */
+static bool trans_MOVU_ar(DisasContext *ctx, arg_MOVU_ar *a)
+{
+    prt("mov.%c\t[r%d,r%d], r%d", size[a->sz], a->ri, a->rb, a->rd);
+    return true;
+}
+
+/* movu.[bw] [rs+],rd */
+/* movu.[bw] [-rs],rd */
+static bool trans_MOVU_pr(DisasContext *ctx, arg_MOVU_pr *a)
+{
+    prt("movu.%c\t", size[a->sz]);
+    prt((a->ad =3D=3D 0) ? "[r%d+]" : "[-r%d]", a->rd);
+    prt(", r%d", a->rs);
+    return true;
+}
+
+/* pop rd */
+static bool trans_POP(DisasContext *ctx, arg_POP *a)
+{
+    prt("pop\tr%d", a->rd);
+    return true;
+}
+
+/* popc rx */
+static bool trans_POPC(DisasContext *ctx, arg_POPC *a)
+{
+    prt("pop\tr%s", rx_crname[a->cr]);
+    return true;
+}
+
+/* popm rd-rd2 */
+static bool trans_POPM(DisasContext *ctx, arg_POPM *a)
+{
+    prt("popm\tr%d-r%d", a->rd, a->rd2);
+    return true;
+}
+
+/* push rs */
+static bool trans_PUSH_r(DisasContext *ctx, arg_PUSH_r *a)
+{
+    prt("push\tr%d", a->rs);
+    return true;
+}
+
+/* push dsp[rs] */
+static bool trans_PUSH_m(DisasContext *ctx, arg_PUSH_m *a)
+{
+    prt("push\t");
+    int dsp =3D rx_index_addr(a->ld, a->sz, ctx);
+    if (dsp > 0) {
+        prt("%d", dsp);
+    }
+    prt("[r%d]", a->rs);
+    return true;
+}
+
+/* pushc rx */
+static bool trans_PUSHC(DisasContext *ctx, arg_PUSHC *a)
+{
+    prt("push\t%s", rx_crname[a->cr]);
+    return true;
+}
+
+/* pushm rs-rs2*/
+static bool trans_PUSHM(DisasContext *ctx, arg_PUSHM *a)
+{
+    prt("pushm\tr%d-r%d", a->rs, a->rs2);
+    return true;
+}
+
+/* xchg rs,rd */
+static bool trans_XCHG_rr(DisasContext *ctx, arg_XCHG_rr *a)
+{
+    prt("xchg\tr%d, r%d", a->rs, a->rd);
+    return true;
+}
+/* xchg dsp[rs].<mi>,rd */
+static bool trans_XCHG_mr(DisasContext *ctx, arg_XCHG_mr *a)
+{
+    int dsp;
+    static const char msize[][4] =3D {
+        "b", "w", "l", "ub", "uw",
+    };
+
+    prt("xchg\t");
+    dsp =3D rx_index_addr(a->ld, a->mi, ctx);
+    if (dsp > 0) {
+        prt("%d", dsp);
+    }
+    prt("[r%d].%s, r%d", a->rs, msize[a->mi], a->rd);
+    return true;
+}
+
+/* stz #imm,rd */
+static bool trans_STZ(DisasContext *ctx, arg_STZ *a)
+{
+    prt_ir(ctx, "stz", a->imm, a->rd);
+    return true;
+}
+
+/* stnz #imm,rd */
+static bool trans_STNZ(DisasContext *ctx, arg_STNZ *a)
+{
+    prt_ir(ctx, "stnz", a->imm, a->rd);
+    return true;
+}
+
+/* rtsd #imm */
+static bool trans_RTSD_i(DisasContext *ctx, arg_RTSD_i *a)
+{
+    prt("rtsd\t#%d", a->imm << 2);
+    return true;
+}
+
+/* rtsd #imm, rd-rd2 */
+static bool trans_RTSD_irr(DisasContext *ctx, arg_RTSD_irr *a)
+{
+    prt("rtsd\t#%d, r%d - r%d", a->imm << 2, a->rd, a->rd2);
+    return true;
+}
+
+/* and #uimm:4, rd */
+/* and #imm, rd */
+static bool trans_AND_ir(DisasContext *ctx, arg_AND_ir *a)
+{
+    prt_ir(ctx, "and", a->imm, a->rd);
+    return true;
+}
+
+/* and dsp[rs], rd */
+/* and rs,rd */
+static bool trans_AND_mr(DisasContext *ctx, arg_AND_mr *a)
+{
+    prt("and\t");
+    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    return true;
+}
+
+/* and rs,rs2,rd */
+static bool trans_AND_rrr(DisasContext *ctx, arg_AND_rrr *a)
+{
+    prt("and\tr%d,r%d, r%d", a->rs, a->rs2, a->rd);
+    return true;
+}
+
+/* or #uimm:4, rd */
+/* or #imm, rd */
+static bool trans_OR_ir(DisasContext *ctx, arg_OR_ir *a)
+{
+    prt_ir(ctx, "or", a->imm, a->rd);
+    return true;
+}
+
+/* or dsp[rs], rd */
+/* or rs,rd */
+static bool trans_OR_mr(DisasContext *ctx, arg_OR_mr *a)
+{
+    prt("or\t");
+    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    return true;
+}
+
+/* or rs,rs2,rd */
+static bool trans_OR_rrr(DisasContext *ctx, arg_OR_rrr *a)
+{
+    prt("or\tr%d, r%d, r%d", a->rs, a->rs2, a->rd);
+    return true;
+}
+
+/* xor #imm, rd */
+static bool trans_XOR_ir(DisasContext *ctx, arg_XOR_ir *a)
+{
+    prt_ir(ctx, "xor", a->imm, a->rd);
+    return true;
+}
+
+/* xor dsp[rs], rd */
+/* xor rs,rd */
+static bool trans_XOR_mr(DisasContext *ctx, arg_XOR_mr *a)
+{
+    prt("xor\t");
+    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    return true;
+}
+
+/* tst #imm, rd */
+static bool trans_TST_ir(DisasContext *ctx, arg_TST_ir *a)
+{
+    prt_ir(ctx, "tst", a->imm, a->rd);
+    return true;
+}
+
+/* tst dsp[rs], rd */
+/* tst rs, rd */
+static bool trans_TST_mr(DisasContext *ctx, arg_TST_mr *a)
+{
+    prt("tst\t");
+    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    return true;
+}
+
+/* not rd */
+/* not rs, rd */
+static bool trans_NOT_rr(DisasContext *ctx, arg_NOT_rr *a)
+{
+    prt("not\t");
+    if (a->rs !=3D a->rd) {
+        prt("r%d, ", a->rs);
+    }
+    prt("r%d", a->rd);
+    return true;
+}
+
+/* neg rd */
+/* neg rs, rd */
+static bool trans_NEG_rr(DisasContext *ctx, arg_NEG_rr *a)
+{
+    prt("neg\t");
+    if (a->rs !=3D a->rd) {
+        prt("r%d, ", a->rs);
+    }
+    prt("r%d", a->rd);
+    return true;
+}
+
+/* adc #imm, rd */
+static bool trans_ADC_ir(DisasContext *ctx, arg_ADC_ir *a)
+{
+    prt_ir(ctx, "adc", a->imm, a->rd);
+    return true;
+}
+
+/* adc rs, rd */
+static bool trans_ADC_rr(DisasContext *ctx, arg_ADC_rr *a)
+{
+    prt("adc\tr%d, r%d", a->rs, a->rd);
+    return true;
+}
+
+/* adc dsp[rs], rd */
+static bool trans_ADC_mr(DisasContext *ctx, arg_ADC_mr *a)
+{
+    int dsp;
+    prt("adc\t");
+    dsp =3D rx_index_addr(a->ld, 2, ctx);
+    if (dsp > 0) {
+        prt("%d", dsp);
+    }
+    prt("[r%d], r%d", a->rs, a->rd);
+    return true;
+}
+
+/* add #uimm4, rd */
+/* add #imm, rs, rd */
+static bool trans_ADD_irr(DisasContext *ctx, arg_ADD_irr *a)
+{
+    if (a->imm < 0x10 && a->rs2 =3D=3D a->rd) {
+        prt("add\t#%d, r%d", a->imm, a->rd);
+    } else {
+        prt("add\t#0x%08x, r%d, r%d", a->imm, a->rs2, a->rd);
+    }
+    return true;
+}
+
+/* add rs, rd */
+/* add dsp[rs], rd */
+static bool trans_ADD_mr(DisasContext *ctx, arg_ADD_mr *a)
+{
+    prt("add\t");
+    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    return true;
+}
+
+/* add rs, rs2, rd */
+static bool trans_ADD_rrr(DisasContext *ctx, arg_ADD_rrr *a)
+{
+    prt("add\tr%d, r%d, r%d", a->rs, a->rs2, a->rd);
+    return true;
+}
+
+/* cmp #imm4, rd */
+/* cmp #imm8, rd */
+/* cmp #imm, rs2 */
+static bool trans_CMP_ir(DisasContext *ctx, arg_CMP_ir *a)
+{
+    prt_ir(ctx, "cmp", a->imm, a->rs2);
+    return true;
+}
+
+/* cmp rs, rs2 */
+/* cmp dsp[rs], rs2 */
+static bool trans_CMP_mr(DisasContext *ctx, arg_CMP_mr *a)
+{
+    prt("cmp\t");
+    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    return true;
+}
+
+/* sub #imm4, rd */
+static bool trans_SUB_ir(DisasContext *ctx, arg_SUB_ir *a)
+{
+    prt("sub\t#%d, r%d", a->imm, a->rd);
+    return true;
+}
+
+/* sub rs, rd */
+/* sub dsp[rs], rd */
+static bool trans_SUB_mr(DisasContext *ctx, arg_SUB_mr *a)
+{
+    prt("sub\t");
+    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    return true;
+}
+
+/* sub rs, rs2, rd */
+static bool trans_SUB_rrr(DisasContext *ctx, arg_SUB_rrr *a)
+{
+    prt("sub\tr%d, r%d, r%d", a->rs, a->rs2, a->rd);
+    return true;
+}
+
+/* sbb rs, rd */
+static bool trans_SBB_rr(DisasContext *ctx, arg_SBB_rr *a)
+{
+    prt("sbb\tr%d, r%d", a->rs, a->rd);
+    return true;
+}
+
+/* sbb dsp[rs], rd */
+static bool trans_SBB_mr(DisasContext *ctx, arg_SBB_mr *a)
+{
+    prt("sbb\t");
+    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    return true;
+}
+
+/* abs rd */
+/* abs rs, rd */
+static bool trans_ABS_rr(DisasContext *ctx, arg_ABS_rr *a)
+{
+    prt("abs\t");
+    if (a->rs =3D=3D a->rd) {
+        prt("r%d", a->rd);
+    } else {
+        prt("r%d, r%d", a->rs, a->rd);
+    }
+    return true;
+}
+
+/* max #imm, rd */
+static bool trans_MAX_ir(DisasContext *ctx, arg_MAX_ir *a)
+{
+    prt_ir(ctx, "max", a->imm, a->rd);
+    return true;
+}
+
+/* max rs, rd */
+/* max dsp[rs], rd */
+static bool trans_MAX_mr(DisasContext *ctx, arg_MAX_mr *a)
+{
+    prt("max\t");
+    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    return true;
+}
+
+/* min #imm, rd */
+static bool trans_MIN_ir(DisasContext *ctx, arg_MIN_ir *a)
+{
+    prt_ir(ctx, "min", a->imm, a->rd);
+    return true;
+}
+
+/* min rs, rd */
+/* min dsp[rs], rd */
+static bool trans_MIN_mr(DisasContext *ctx, arg_MIN_mr *a)
+{
+    prt("max\t");
+    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    return true;
+}
+
+/* mul #uimm4, rd */
+/* mul #imm, rd */
+static bool trans_MUL_ir(DisasContext *ctx, arg_MUL_ir *a)
+{
+    prt_ir(ctx, "mul", a->imm, a->rd);
+    return true;
+}
+
+/* mul rs, rd */
+/* mul dsp[rs], rd */
+static bool trans_MUL_mr(DisasContext *ctx, arg_MUL_mr *a)
+{
+    prt("mul\t");
+    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    return true;
+}
+
+/* mul rs, rs2, rd */
+static bool trans_MUL_rrr(DisasContext *ctx, arg_MUL_rrr *a)
+{
+    prt("mul\tr%d,r%d,r%d", a->rs, a->rs2, a->rd);
+    return true;
+}
+
+/* emul #imm, rd */
+static bool trans_EMUL_ir(DisasContext *ctx, arg_EMUL_ir *a)
+{
+    prt_ir(ctx, "emul", a->imm, a->rd);
+    return true;
+}
+
+/* emul rs, rd */
+/* emul dsp[rs], rd */
+static bool trans_EMUL_mr(DisasContext *ctx, arg_EMUL_mr *a)
+{
+    prt("emul\t");
+    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    return true;
+}
+
+/* emulu #imm, rd */
+static bool trans_EMULU_ir(DisasContext *ctx, arg_EMULU_ir *a)
+{
+    prt_ir(ctx, "emulu", a->imm, a->rd);
+    return true;
+}
+
+/* emulu rs, rd */
+/* emulu dsp[rs], rd */
+static bool trans_EMULU_mr(DisasContext *ctx, arg_EMULU_mr *a)
+{
+    prt("emulu\t");
+    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    return true;
+}
+
+/* div #imm, rd */
+static bool trans_DIV_ir(DisasContext *ctx, arg_DIV_ir *a)
+{
+    prt_ir(ctx, "div", a->imm, a->rd);
+    return true;
+}
+
+/* div rs, rd */
+/* div dsp[rs], rd */
+static bool trans_DIV_mr(DisasContext *ctx, arg_DIV_mr *a)
+{
+    prt("div\t");
+    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    return true;
+}
+
+/* divu #imm, rd */
+static bool trans_DIVU_ir(DisasContext *ctx, arg_DIVU_ir *a)
+{
+    prt_ir(ctx, "divu", a->imm, a->rd);
+    return true;
+}
+
+/* divu rs, rd */
+/* divu dsp[rs], rd */
+static bool trans_DIVU_mr(DisasContext *ctx, arg_DIVU_mr *a)
+{
+    prt("divu\t");
+    operand(ctx, a->ld, a->mi, a->rs, a->rd);
+    return true;
+}
+
+
+/* shll #imm:5, rd */
+/* shll #imm:5, rs, rd */
+static bool trans_SHLL_irr(DisasContext *ctx, arg_SHLL_irr *a)
+{
+    prt("shll\t#%d, ", a->imm);
+    if (a->rs2 !=3D a->rd) {
+        prt("r%d, ", a->rs2);
+    }
+    prt("r%d", a->rd);
+    return true;
+}
+
+/* shll rs, rd */
+static bool trans_SHLL_rr(DisasContext *ctx, arg_SHLL_rr *a)
+{
+    prt("shll\tr%d, r%d", a->rs, a->rd);
+    return true;
+}
+
+/* shar #imm:5, rd */
+/* shar #imm:5, rs, rd */
+static bool trans_SHAR_irr(DisasContext *ctx, arg_SHAR_irr *a)
+{
+    prt("shar\t#%d,", a->imm);
+    if (a->rs2 !=3D a->rd) {
+        prt("r%d, ", a->rs2);
+    }
+    prt("r%d", a->rd);
+    return true;
+}
+
+/* shar rs, rd */
+static bool trans_SHAR_rr(DisasContext *ctx, arg_SHAR_rr *a)
+{
+    prt("shar\tr%d, r%d", a->rs, a->rd);
+    return true;
+}
+
+/* shlr #imm:5, rd */
+/* shlr #imm:5, rs, rd */
+static bool trans_SHLR_irr(DisasContext *ctx, arg_SHLR_irr *a)
+{
+    prt("shlr\t#%d, ", a->imm);
+    if (a->rs2 !=3D a->rd) {
+        prt("r%d, ", a->rs2);
+    }
+    prt("r%d", a->rd);
+    return true;
+}
+
+/* shlr rs, rd */
+static bool trans_SHLR_rr(DisasContext *ctx, arg_SHLR_rr *a)
+{
+    prt("shlr\tr%d, r%d", a->rs, a->rd);
+    return true;
+}
+
+/* rolc rd */
+static bool trans_ROLC(DisasContext *ctx, arg_ROLC *a)
+{
+    prt("rorc\tr%d", a->rd);
+    return true;
+}
+
+/* rorc rd */
+static bool trans_RORC(DisasContext *ctx, arg_RORC *a)
+{
+    prt("rorc\tr%d", a->rd);
+    return true;
+}
+
+/* rotl #imm, rd */
+static bool trans_ROTL_ir(DisasContext *ctx, arg_ROTL_ir *a)
+{
+    prt("rotl\t#%d, r%d", a->imm, a->rd);
+    return true;
+}
+
+/* rotl rs, rd */
+static bool trans_ROTL_rr(DisasContext *ctx, arg_ROTL_rr *a)
+{
+    prt("rotl\tr%d, r%d", a->rs, a->rd);
+    return true;
+}
+
+/* rotr #imm, rd */
+static bool trans_ROTR_ir(DisasContext *ctx, arg_ROTR_ir *a)
+{
+    prt("rotr\t#%d, r%d", a->imm, a->rd);
+    return true;
+}
+
+/* rotr rs, rd */
+static bool trans_ROTR_rr(DisasContext *ctx, arg_ROTR_rr *a)
+{
+    prt("rotr\tr%d, r%d", a->rs, a->rd);
+    return true;
+}
+
+/* revl rs, rd */
+static bool trans_REVL(DisasContext *ctx, arg_REVL *a)
+{
+    prt("revl\tr%d, r%d", a->rs, a->rd);
+    return true;
+}
+
+/* revw rs, rd */
+static bool trans_REVW(DisasContext *ctx, arg_REVW *a)
+{
+    prt("revw\tr%d, r%d", a->rs, a->rd);
+    return true;
+}
+
+/* conditional branch helper */
+static void rx_bcnd_main(DisasContext *ctx, int cd, int len, int dst)
+{
+    static const char sz[] =3D {'s', 'b', 'w', 'a'};
+    prt("b%s.%c\t%08x", cond[cd], sz[len - 1], ctx->pc + dst);
+}
+
+/* beq dsp:3 / bne dsp:3 */
+/* beq dsp:8 / bne dsp:8 */
+/* bc dsp:8 / bnc dsp:8 */
+/* bgtu dsp:8 / bleu dsp:8 */
+/* bpz dsp:8 / bn dsp:8 */
+/* bge dsp:8 / blt dsp:8 */
+/* bgt dsp:8 / ble dsp:8 */
+/* bo dsp:8 / bno dsp:8 */
+/* beq dsp:16 / bne dsp:16 */
+static bool trans_BCnd(DisasContext *ctx, arg_BCnd *a)
+{
+    rx_bcnd_main(ctx, a->cd, a->sz, a->dsp);
+    return true;
+}
+
+/* bra dsp:3 */
+/* bra dsp:8 */
+/* bra dsp:16 */
+/* bra dsp:24 */
+static bool trans_BRA(DisasContext *ctx, arg_BRA *a)
+{
+    rx_bcnd_main(ctx, 14, a->sz, a->dsp);
+    return true;
+}
+
+/* bra rs */
+static bool trans_BRA_l(DisasContext *ctx, arg_BRA_l *a)
+{
+    prt("bra.l\tr%d", a->rd);
+    return true;
+}
+
+/* jmp rs */
+static bool trans_JMP(DisasContext *ctx, arg_JMP *a)
+{
+    prt("jmp\tr%d", a->rs);
+    return true;
+}
+
+/* jsr rs */
+static bool trans_JSR(DisasContext *ctx, arg_JSR *a)
+{
+    prt("jsr\tr%d", a->rs);
+    return true;
+}
+
+/* bsr dsp:16 */
+/* bsr dsp:24 */
+static bool trans_BSR(DisasContext *ctx, arg_BSR *a)
+{
+    static const char sz[] =3D {'w', 'a'};
+    prt("bsr.%c\t%08x", sz[a->sz - 3], ctx->pc + a->dsp);
+    return true;
+}
+
+/* bsr rs */
+static bool trans_BSR_l(DisasContext *ctx, arg_BSR_l *a)
+{
+    prt("bsr.l\tr%d", a->rd);
+    return true;
+}
+
+/* rts */
+static bool trans_RTS(DisasContext *ctx, arg_RTS *a)
+{
+    prt("rts");
+    return true;
+}
+
+/* nop */
+static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
+{
+    prt("nop");
+    return true;
+}
+
+/* scmpu */
+static bool trans_SCMPU(DisasContext *ctx, arg_SCMPU *a)
+{
+    prt("scmpu");
+    return true;
+}
+
+/* smovu */
+static bool trans_SMOVU(DisasContext *ctx, arg_SMOVU *a)
+{
+    prt("smovu");
+    return true;
+}
+
+/* smovf */
+static bool trans_SMOVF(DisasContext *ctx, arg_SMOVF *a)
+{
+    prt("smovf");
+    return true;
+}
+
+/* smovb */
+static bool trans_SMOVB(DisasContext *ctx, arg_SMOVB *a)
+{
+    prt("smovb");
+    return true;
+}
+
+/* suntile */
+static bool trans_SUNTIL(DisasContext *ctx, arg_SUNTIL *a)
+{
+    prt("suntil.%c", size[a->sz]);
+    return true;
+}
+
+/* swhile */
+static bool trans_SWHILE(DisasContext *ctx, arg_SWHILE *a)
+{
+    prt("swhile.%c", size[a->sz]);
+    return true;
+}
+/* sstr */
+static bool trans_SSTR(DisasContext *ctx, arg_SSTR *a)
+{
+    prt("sstr.%c", size[a->sz]);
+    return true;
+}
+
+/* rmpa */
+static bool trans_RMPA(DisasContext *ctx, arg_RMPA *a)
+{
+    prt("rmpa.%c", size[a->sz]);
+    return true;
+}
+
+/* mulhi rs,rs2 */
+static bool trans_MULHI(DisasContext *ctx, arg_MULHI *a)
+{
+    prt("mulhi\tr%d,r%d", a->rs, a->rs2);
+    return true;
+}
+
+/* mullo rs,rs2 */
+static bool trans_MULLO(DisasContext *ctx, arg_MULLO *a)
+{
+    prt("mullo\tr%d, r%d", a->rs, a->rs2);
+    return true;
+}
+
+/* machi rs,rs2 */
+static bool trans_MACHI(DisasContext *ctx, arg_MACHI *a)
+{
+    prt("machi\tr%d, r%d", a->rs, a->rs2);
+    return true;
+}
+
+/* maclo rs,rs2 */
+static bool trans_MACLO(DisasContext *ctx, arg_MACLO *a)
+{
+    prt("maclo\tr%d, r%d", a->rs, a->rs2);
+    return true;
+}
+
+/* mvfachi rd */
+static bool trans_MVFACHI(DisasContext *ctx, arg_MVFACHI *a)
+{
+    prt("mvfachi\tr%d", a->rd);
+    return true;
+}
+
+/* mvfacmi rd */
+static bool trans_MVFACMI(DisasContext *ctx, arg_MVFACMI *a)
+{
+    prt("mvfacmi\tr%d", a->rd);
+    return true;
+}
+
+/* mvtachi rs */
+static bool trans_MVTACHI(DisasContext *ctx, arg_MVTACHI *a)
+{
+    prt("mvtachi\tr%d", a->rs);
+    return true;
+}
+
+/* mvtaclo rs */
+static bool trans_MVTACLO(DisasContext *ctx, arg_MVTACLO *a)
+{
+    prt("mvtaclo\tr%d", a->rs);
+    return true;
+}
+
+/* racw #imm */
+static bool trans_RACW(DisasContext *ctx, arg_RACW *a)
+{
+    prt("racw\t#%d", a->imm + 1);
+    return true;
+}
+
+/* sat rd */
+static bool trans_SAT(DisasContext *ctx, arg_SAT *a)
+{
+    prt("sat\tr%d", a->rd);
+    return true;
+}
+
+/* satr */
+static bool trans_SATR(DisasContext *ctx, arg_SATR *a)
+{
+    prt("satr");
+    return true;
+}
+
+/* fadd #imm, rd */
+static bool trans_FADD_ir(DisasContext *ctx, arg_FADD_ir *a)
+{
+    prt("fadd\t#%d,r%d", li(ctx, 0), a->rd);
+    return true;
+}
+
+/* fadd dsp[rs], rd */
+/* fadd rs, rd */
+static bool trans_FADD_mr(DisasContext *ctx, arg_FADD_mr *a)
+{
+    prt("fadd\t");
+    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    return true;
+}
+
+/* fcmp #imm, rd */
+static bool trans_FCMP_ir(DisasContext *ctx, arg_FCMP_ir *a)
+{
+    prt("fadd\t#%d,r%d", li(ctx, 0), a->rd);
+    return true;
+}
+
+/* fcmp dsp[rs], rd */
+/* fcmp rs, rd */
+static bool trans_FCMP_mr(DisasContext *ctx, arg_FCMP_mr *a)
+{
+    prt("fcmp\t");
+    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    return true;
+}
+
+/* fsub #imm, rd */
+static bool trans_FSUB_ir(DisasContext *ctx, arg_FSUB_ir *a)
+{
+    prt("fsub\t#%d,r%d", li(ctx, 0), a->rd);
+    return true;
+}
+
+/* fsub dsp[rs], rd */
+/* fsub rs, rd */
+static bool trans_FSUB_mr(DisasContext *ctx, arg_FSUB_mr *a)
+{
+    prt("fsub\t");
+    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    return true;
+}
+
+/* ftoi dsp[rs], rd */
+/* ftoi rs, rd */
+static bool trans_FTOI(DisasContext *ctx, arg_FTOI *a)
+{
+    prt("ftoi\t");
+    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    return true;
+}
+
+/* fmul #imm, rd */
+static bool trans_FMUL_ir(DisasContext *ctx, arg_FMUL_ir *a)
+{
+    prt("fmul\t#%d,r%d", li(ctx, 0), a->rd);
+    return true;
+}
+
+/* fmul dsp[rs], rd */
+/* fmul rs, rd */
+static bool trans_FMUL_mr(DisasContext *ctx, arg_FMUL_mr *a)
+{
+    prt("fmul\t");
+    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    return true;
+}
+
+/* fdiv #imm, rd */
+static bool trans_FDIV_ir(DisasContext *ctx, arg_FDIV_ir *a)
+{
+    prt("fdiv\t#%d,r%d", li(ctx, 0), a->rd);
+    return true;
+}
+
+/* fdiv dsp[rs], rd */
+/* fdiv rs, rd */
+static bool trans_FDIV_mr(DisasContext *ctx, arg_FDIV_mr *a)
+{
+    prt("fdiv\t");
+    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    return true;
+}
+
+/* round dsp[rs], rd */
+/* round rs, rd */
+static bool trans_ROUND(DisasContext *ctx, arg_ROUND *a)
+{
+    prt("round\t");
+    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    return true;
+}
+
+/* itof rs, rd */
+/* itof dsp[rs], rd */
+static bool trans_ITOF(DisasContext *ctx, arg_ITOF *a)
+{
+    prt("itof\t");
+    operand(ctx, a->ld, RX_IM_LONG, a->rs, a->rd);
+    return true;
+}
+
+#define BOP_IM(name, reg)                                       \
+    do {                                                        \
+        int dsp;                                                \
+        prt("b%s\t#%d, ", #name, a->imm);                       \
+        dsp =3D rx_index_addr(a->ld, RX_MEMORY_BYTE, ctx);        \
+        if (dsp > 0) {                                          \
+            prt("%d", dsp);                                     \
+        }                                                       \
+        prt("[r%d]", reg);                                      \
+        return true;                                            \
+    } while (0)
+
+#define BOP_RM(name)                                            \
+    do {                                                        \
+        int dsp;                                                \
+        prt("b%s\tr%d, ", #name, a->rd);                        \
+        dsp =3D rx_index_addr(a->ld, RX_MEMORY_BYTE, ctx);        \
+        if (dsp > 0) {                                          \
+            prt("%d", dsp);                                     \
+        }                                                       \
+        prt("[r%d]", a->rs);                                    \
+        return true;                                            \
+    } while (0)
+
+/* bset #imm, dsp[rd] */
+static bool trans_BSET_im(DisasContext *ctx, arg_BSET_im *a)
+{
+    BOP_IM(bset, a->rs);
+}
+
+/* bset rs, dsp[rd] */
+static bool trans_BSET_rm(DisasContext *ctx, arg_BSET_rm *a)
+{
+    BOP_RM(set);
+}
+
+/* bset rs, rd */
+static bool trans_BSET_rr(DisasContext *ctx, arg_BSET_rr *a)
+{
+    prt("bset\tr%d,r%d", a->rs, a->rd);
+    return true;
+}
+
+/* bset #imm, rd */
+static bool trans_BSET_ir(DisasContext *ctx, arg_BSET_ir *a)
+{
+    prt("bset\t#%d, r%d", a->imm, a->rd);
+    return true;
+}
+
+/* bclr #imm, dsp[rd] */
+static bool trans_BCLR_im(DisasContext *ctx, arg_BCLR_im *a)
+{
+    BOP_IM(clr, a->rs);
+}
+
+/* bclr rs, dsp[rd] */
+static bool trans_BCLR_rm(DisasContext *ctx, arg_BCLR_rm *a)
+{
+    BOP_RM(clr);
+}
+
+/* bclr rs, rd */
+static bool trans_BCLR_rr(DisasContext *ctx, arg_BCLR_rr *a)
+{
+    prt("bclr\tr%d, r%d", a->rs, a->rd);
+    return true;
+}
+
+/* bclr #imm, rd */
+static bool trans_BCLR_ir(DisasContext *ctx, arg_BCLR_ir *a)
+{
+    prt("bclr\t#%d,r%d", a->imm, a->rd);
+    return true;
+}
+
+/* btst #imm, dsp[rd] */
+static bool trans_BTST_im(DisasContext *ctx, arg_BTST_im *a)
+{
+    BOP_IM(tst, a->rs);
+}
+
+/* btst rs, dsp[rd] */
+static bool trans_BTST_rm(DisasContext *ctx, arg_BTST_rm *a)
+{
+    BOP_RM(tst);
+}
+
+/* btst rs, rd */
+static bool trans_BTST_rr(DisasContext *ctx, arg_BTST_rr *a)
+{
+    prt("btst\tr%d, r%d", a->rs, a->rd);
+    return true;
+}
+
+/* btst #imm, rd */
+static bool trans_BTST_ir(DisasContext *ctx, arg_BTST_ir *a)
+{
+    prt("btst\t#%d, r%d", a->imm, a->rd);
+    return true;
+}
+
+/* bnot rs, dsp[rd] */
+static bool trans_BNOT_rm(DisasContext *ctx, arg_BNOT_rm *a)
+{
+    BOP_RM(not);
+}
+
+/* bnot rs, rd */
+static bool trans_BNOT_rr(DisasContext *ctx, arg_BNOT_rr *a)
+{
+    prt("bnot\tr%d, r%d", a->rs, a->rd);
+    return true;
+}
+
+/* bnot #imm, dsp[rd] */
+static bool trans_BNOT_im(DisasContext *ctx, arg_BNOT_im *a)
+{
+    BOP_IM(not, a->rs);
+}
+
+/* bnot #imm, rd */
+static bool trans_BNOT_ir(DisasContext *ctx, arg_BNOT_ir *a)
+{
+    prt("bnot\t#%d, r%d", a->imm, a->rd);
+    return true;
+}
+
+/* bmcond #imm, dsp[rd] */
+static bool trans_BMCnd_im(DisasContext *ctx, arg_BMCnd_im *a)
+{
+    int dsp =3D rx_index_addr(a->ld, RX_MEMORY_BYTE, ctx);
+    prt("bm%s\t#%d, ", cond[a->cd], a->imm);
+    if (dsp > 0) {
+        prt("%d", dsp);
+    }
+    prt("[%d]", a->rd);
+    return true;
+}
+
+/* bmcond #imm, rd */
+static bool trans_BMCnd_ir(DisasContext *ctx, arg_BMCnd_ir *a)
+{
+    prt("bm%s\t#%d, r%d", cond[a->cd], a->imm, a->rd);
+    return true;
+}
+
+/* clrpsw psw */
+static bool trans_CLRPSW(DisasContext *ctx, arg_CLRPSW *a)
+{
+    prt("clrpsw\t%c", psw[a->cb]);
+    return true;
+}
+
+/* setpsw psw */
+static bool trans_SETPSW(DisasContext *ctx, arg_SETPSW *a)
+{
+    prt("setpsw\t%c", psw[a->cb]);
+    return true;
+}
+
+/* mvtipl #imm */
+static bool trans_MVTIPL(DisasContext *ctx, arg_MVTIPL *a)
+{
+    prt("movtipl\t#%d", a->imm);
+    return true;
+}
+
+/* mvtc #imm, rd */
+static bool trans_MVTC_i(DisasContext *ctx, arg_MVTC_i *a)
+{
+    prt("mvtc\t#0x%08x, %s", a->imm, rx_crname[a->cr]);
+    return true;
+}
+
+/* mvtc rs, rd */
+static bool trans_MVTC_r(DisasContext *ctx, arg_MVTC_r *a)
+{
+    prt("mvtc\tr%d, %s", a->rs, rx_crname[a->cr]);
+    return true;
+}
+
+/* mvfc rs, rd */
+static bool trans_MVFC(DisasContext *ctx, arg_MVFC *a)
+{
+    prt("mvfc\t%s, r%d", rx_crname[a->cr], a->rd);
+    return true;
+}
+
+/* rtfi */
+static bool trans_RTFI(DisasContext *ctx, arg_RTFI *a)
+{
+    prt("rtfi");
+    return true;
+}
+
+/* rte */
+static bool trans_RTE(DisasContext *ctx, arg_RTE *a)
+{
+    prt("rte");
+    return true;
+}
+
+/* brk */
+static bool trans_BRK(DisasContext *ctx, arg_BRK *a)
+{
+    prt("brk");
+    return true;
+}
+
+/* int #imm */
+static bool trans_INT(DisasContext *ctx, arg_INT *a)
+{
+    prt("int\t#%d", a->imm);
+    return true;
+}
+
+/* wait */
+static bool trans_WAIT(DisasContext *ctx, arg_WAIT *a)
+{
+    prt("wait");
+    return true;
+}
+
+/* sccnd.[bwl] rd */
+/* sccnd.[bwl] dsp:[rd] */
+static bool trans_SCCnd(DisasContext *ctx, arg_SCCnd *a)
+{
+    int dsp;
+    prt("sc%s.%c\t", cond[a->cd], size[a->sz]);
+    if (a->ld < 3) {
+        dsp =3D rx_index_addr(a->sz, a->ld, ctx);
+        if (dsp > 0) {
+            prt("%d", dsp);
+        }
+        prt("[r%d]", a->rd);
+    } else {
+        prt("r%d", a->rd);
+    }
+    return true;
+}
+
+int print_insn_rx(bfd_vma addr, disassemble_info *dis)
+{
+    DisasContext ctx;
+    uint32_t insn;
+    int i;
+    ctx.dis =3D dis;
+    ctx.pc =3D ctx.addr =3D addr;
+
+    insn =3D decode_load(&ctx);
+    if (!decode(&ctx, insn)) {
+        ctx.dis->fprintf_func(ctx.dis->stream, ".byte\t");
+        for (i =3D 0; i < ctx.addr - addr; i++) {
+            if (i > 0) {
+                ctx.dis->fprintf_func(ctx.dis->stream, ",");
+            }
+            ctx.dis->fprintf_func(ctx.dis->stream, "0x%02x", insn >> 24)=
;
+            insn <<=3D 8;
+        }
+    }
+    return ctx.addr - addr;
+}
--=20
2.20.1


