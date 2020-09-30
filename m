Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C374C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7A22071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 20:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvWlTks2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7A22071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNj3C-0006Lq-7i
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 16:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNizv-0003LQ-6F
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:46:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNizl-0006Sn-Qu
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:46:46 -0400
Received: by mail-wm1-x342.google.com with SMTP id y15so871862wmi.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=buS0UiDWAHgtkN7uoBPP41ehpPrnoj5TzAhRXm7R+7E=;
 b=XvWlTks2PvcT2cCyqb76JToY1qkSmBPk39EoxZR4tt5bDkezaH685iERlm7VZy5/Yd
 8q8IkHKQj8SbVZw1ZtWrm0oMy1+soYXwgSud+Q7PQGNBS0pv4ptf0SzHLTUp0CoA+f56
 clzCEcQCstxUr9CX2NTKBkjxAgWlFWlc6sJfqA/P9Q33dfgPTxtG/w96GtHRp3Hf5Kib
 zI8ddYUfRJocPY2IcJKnUdzP+0HFJdcudSv8lnlH+8gckE6A9b1Tb4OPCfG0o3DhOiVM
 3Wq6DdOb8GXu6UyQOTY5E99L+PRgMBwiLXAl+lcOgJt0yJKic3h/YWKKlIJu4dUkUlnT
 kqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=buS0UiDWAHgtkN7uoBPP41ehpPrnoj5TzAhRXm7R+7E=;
 b=sATs5eUn2JoKr66AVjE/SP+TyOkKOsOOFuoYTlJpcKZjS2pcT8yFAf2KLDillInTKs
 SLh/jeeL3iI6oy0wgjm664BKTnXw/MUfFdUAmPXf2PeIgfBuCvNChlgRjXFmlY1i6mTJ
 fDai8dYedJyGRTSEl3EqFSGQTx6P/iA/2nGk1TCf1VaducmoAsvkFz7nrb+24ee1pY4d
 XtIUFSZ4SSziB0Gs/ymGhUa/QjiRl0KEUgglCoWW3/iQsYU/thhzURDv6pQreIfsgC+v
 dKie1gyfjQDxM/IvwqwbVSeq7YYB6De0SnePPLFcq6UHOfcv8/K1BXNRUYAsM0zao/E4
 8QUw==
X-Gm-Message-State: AOAM533r2P/1sg1xsdMR6AbR30Mg+V02/G1kvFwsBN7b+fZ/0g+JFNRm
 OgO6s9JFo72fnuWFatvnPCHBwFNeu9ugiA==
X-Google-Smtp-Source: ABdhPJwcfuU3JnwGgH7xVYYBSfmI620loF61t3P/YClPBePYsF10JaH5jm382zCPE4cDBFvng/JwJg==
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr5054151wmc.165.1601498794459; 
 Wed, 30 Sep 2020 13:46:34 -0700 (PDT)
Received: from cmiranda-laptop.localdomain ([188.251.240.167])
 by smtp.gmail.com with ESMTPSA id v204sm5310764wmg.20.2020.09.30.13.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 13:46:33 -0700 (PDT)
From: cupertinomiranda@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 02/14] arc: Decoder code
Date: Wed, 30 Sep 2020 21:45:52 +0100
Message-Id: <20200930204604.20663-3-cupertinomiranda@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930204604.20663-1-cupertinomiranda@gmail.com>
References: <20200930204604.20663-1-cupertinomiranda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=cupertinomiranda@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Claudiu Zissulescu <claziss@gmail.com>,
 Cupertino Miranda <cupertinomiranda@gmail.com>,
 Shahab Vahedi <shahab.vahedi@gmail.com>, Shahab Vahedi <shahab@synopsys.com>,
 Cupertino Miranda <cmiranda@synopsys.com>, linux-snps-arc@lists.infradead.org,
 Claudiu Zissulescu <claziss@synopsys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudiu Zissulescu <claziss@synopsys.com>

The decoder and the disassembler inspired by ARC GNU binutils.

Signed-off-by: Claudiu Zissulescu <claziss@synopsys.com>
---
 disas/arc.c             |  460 ++++++++++++++
 target/arc/decoder.c    | 1276 +++++++++++++++++++++++++++++++++++++++
 target/arc/decoder.h    |  350 +++++++++++
 target/arc/flags.def    |   85 +++
 target/arc/operands.def |  123 ++++
 5 files changed, 2294 insertions(+)
 create mode 100644 disas/arc.c
 create mode 100644 target/arc/decoder.c
 create mode 100644 target/arc/decoder.h
 create mode 100644 target/arc/flags.def
 create mode 100644 target/arc/operands.def

diff --git a/disas/arc.c b/disas/arc.c
new file mode 100644
index 0000000000..1041b5a5b5
--- /dev/null
+++ b/disas/arc.c
@@ -0,0 +1,460 @@
+/*
+ * Disassembler code for ARC.
+ * Copyright 2020 Free Software Foundation, Inc.
+ * Written by Claudiu Zissulescu.
+ *
+ * QEMU ARCv2 Disassembler.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "disas/dis-asm.h"
+#include "target/arc/arc-common.h"
+#include "target/arc/decoder.h"
+#include "target/arc/regs.h"
+
+/* Register names. */
+
+static const char * const regnames[64] = {
+    "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
+    "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
+    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
+    "r24", "r25", "r26", "fp", "sp", "ilink", "r30", "blink",
+
+    "r32", "r33", "r34", "r35", "r36", "r37", "r38", "r39",
+    "r40", "r41", "r42", "r43", "r44", "r45", "r46", "r47",
+    "r48", "r49", "r50", "r51", "r52", "r53", "r54", "r55",
+    "r56", "r57", "r58", "r59", "lp_count", "rezerved", "LIMM", "pcl"
+};
+
+#define ARRANGE_ENDIAN(info, buf)                                       \
+    (info->endian == BFD_ENDIAN_LITTLE ? bfd_getm32(bfd_getl32(buf))    \
+     : bfd_getb32(buf))
+
+/*
+ * Helper function to convert middle-endian data to something more
+ * meaningful.
+ */
+
+static bfd_vma bfd_getm32(unsigned int data)
+{
+    bfd_vma value = 0;
+
+    value  = (data & 0x0000ffff) << 16;
+    value |= (data & 0xffff0000) >> 16;
+    return value;
+}
+
+/* Helper for printing instruction flags. */
+
+static bfd_boolean special_flag_p(const char *opname, const char *flgname)
+{
+    const struct arc_flag_special *flg_spec;
+    unsigned i, j, flgidx;
+
+    for (i = 0; i < arc_num_flag_special; ++i) {
+        flg_spec = &arc_flag_special_cases[i];
+
+        if (strcmp(opname, flg_spec->name) != 0) {
+            continue;
+        }
+
+        /* Found potential special case instruction. */
+        for (j = 0; ; ++j) {
+            flgidx = flg_spec->flags[j];
+            if (flgidx == 0) {
+                break; /* End of the array. */
+            }
+
+            if (strcmp(flgname, arc_flag_operands[flgidx].name) == 0) {
+                return TRUE;
+            }
+        }
+    }
+    return FALSE;
+}
+
+/* Print instruction flags. */
+
+static void print_flags(const struct arc_opcode *opcode,
+                        uint64_t insn,
+                        struct disassemble_info *info)
+{
+    const unsigned char *flgidx;
+    unsigned int value;
+
+    /* Now extract and print the flags. */
+    for (flgidx = opcode->flags; *flgidx; flgidx++) {
+        /* Get a valid flag class. */
+        const struct arc_flag_class *cl_flags = &arc_flag_classes[*flgidx];
+        const unsigned *flgopridx;
+
+        /* Check first the extensions. Not supported yet. */
+        if (cl_flags->flag_class & F_CLASS_EXTEND) {
+            value = insn & 0x1F;
+        }
+
+        for (flgopridx = cl_flags->flags; *flgopridx; ++flgopridx) {
+            const struct arc_flag_operand *flg_operand =
+                &arc_flag_operands[*flgopridx];
+
+            /* Implicit flags are only used for the insn decoder. */
+            if (cl_flags->flag_class & F_CLASS_IMPLICIT) {
+                continue;
+            }
+
+            if (!flg_operand->favail) {
+                continue;
+            }
+
+            value = (insn >> flg_operand->shift) &
+                    ((1 << flg_operand->bits) - 1);
+            if (value == flg_operand->code) {
+                /* FIXME!: print correctly nt/t flag. */
+                if (!special_flag_p(opcode->name, flg_operand->name)) {
+                    (*info->fprintf_func)(info->stream, ".");
+                }
+                (*info->fprintf_func)(info->stream, "%s", flg_operand->name);
+            }
+        }
+    }
+}
+
+/*
+ * When dealing with auxiliary registers, output the proper name if we
+ * have it.
+ */
+
+static const char *get_auxreg(const struct arc_opcode *opcode,
+                              int value,
+                              unsigned isa_mask)
+{
+    unsigned int i;
+    const struct arc_aux_reg_detail *auxr = &arc_aux_regs_detail[0];
+
+    if (opcode->insn_class != AUXREG) {
+        return NULL;
+    }
+
+    for (i = 0; i < ARRAY_SIZE(arc_aux_regs); i++, auxr++) {
+        if (!(auxr->cpu & isa_mask)) {
+            continue;
+        }
+
+        if (auxr->subclass != NONE) {
+            return NULL;
+        }
+
+        if (auxr->address == value) {
+            return auxr->name;
+        }
+    }
+    return NULL;
+}
+
+/* Print the operands of an instruction. */
+
+static void print_operands(const struct arc_opcode *opcode,
+                           bfd_vma memaddr,
+                           uint64_t insn,
+                           uint32_t isa_mask,
+                           insn_t *pinsn,
+                           struct disassemble_info *info)
+{
+    bfd_boolean need_comma  = FALSE;
+    bfd_boolean open_braket = FALSE;
+    int value, vpcl = 0;
+    bfd_boolean rpcl = FALSE, rset = FALSE;
+    const unsigned char *opidx;
+    int i;
+
+    for (i = 0, opidx = opcode->operands; *opidx; opidx++) {
+        const struct arc_operand *operand = &arc_operands[*opidx];
+
+        if (open_braket && (operand->flags & ARC_OPERAND_BRAKET)) {
+            (*info->fprintf_func)(info->stream, "]");
+            open_braket = FALSE;
+            continue;
+        }
+
+        /* Only take input from real operands. */
+        if (ARC_OPERAND_IS_FAKE(operand)) {
+            continue;
+        }
+
+        if (need_comma) {
+            (*info->fprintf_func)(info->stream, ",");
+        }
+
+        if (!open_braket && (operand->flags & ARC_OPERAND_BRAKET)) {
+            (*info->fprintf_func)(info->stream, "[");
+            open_braket = TRUE;
+            need_comma  = FALSE;
+            continue;
+        }
+
+        need_comma = TRUE;
+
+        /* Get the decoded */
+        value = pinsn->operands[i++].value;
+
+        if ((operand->flags & ARC_OPERAND_IGNORE) &&
+            (operand->flags & ARC_OPERAND_IR) &&
+            value == -1) {
+            need_comma = FALSE;
+            continue;
+        }
+
+        if (operand->flags & ARC_OPERAND_PCREL) {
+            rpcl = TRUE;
+            vpcl = value;
+            rset = TRUE;
+
+            info->target = (bfd_vma) (memaddr & ~3) + value;
+        } else if (!(operand->flags & ARC_OPERAND_IR)) {
+            vpcl = value;
+            rset = TRUE;
+        }
+
+        /* Print the operand as directed by the flags. */
+        if (operand->flags & ARC_OPERAND_IR) {
+            const char *rname;
+
+            assert(value >= 0 && value < 64);
+            rname = regnames[value];
+            (*info->fprintf_func)(info->stream, "%s", rname);
+            if (operand->flags & ARC_OPERAND_TRUNCATE) {
+                /* Make sure we print only legal register pairs. */
+                if ((value & 0x01) == 0) {
+                    rname = regnames[value + 1];
+                }
+                (*info->fprintf_func)(info->stream, "%s", rname);
+            }
+            if (value == 63) {
+                rpcl = TRUE;
+            } else {
+                rpcl = FALSE;
+            }
+        } else if (operand->flags & ARC_OPERAND_LIMM) {
+            value = pinsn->limm;
+            const char *rname = get_auxreg(opcode, value, isa_mask);
+
+            if (rname && open_braket) {
+                (*info->fprintf_func)(info->stream, "%s", rname);
+            } else {
+                (*info->fprintf_func)(info->stream, "%#x", value);
+            }
+        } else if (operand->flags & ARC_OPERAND_SIGNED) {
+            const char *rname = get_auxreg(opcode, value, isa_mask);
+            if (rname && open_braket) {
+                (*info->fprintf_func)(info->stream, "%s", rname);
+            } else {
+                (*info->fprintf_func)(info->stream, "%d", value);
+            }
+        } else {
+            if (operand->flags & ARC_OPERAND_TRUNCATE   &&
+                !(operand->flags & ARC_OPERAND_ALIGNED32) &&
+                !(operand->flags & ARC_OPERAND_ALIGNED16) &&
+                 value >= 0 && value <= 14) {
+                /* Leave/Enter mnemonics. */
+                switch (value) {
+                case 0:
+                    need_comma = FALSE;
+                    break;
+                case 1:
+                    (*info->fprintf_func)(info->stream, "r13");
+                    break;
+                default:
+                    (*info->fprintf_func)(info->stream, "r13-%s",
+                            regnames[13 + value - 1]);
+                    break;
+                }
+                rpcl = FALSE;
+                rset = FALSE;
+            } else {
+                const char *rname = get_auxreg(opcode, value, isa_mask);
+                if (rname && open_braket) {
+                    (*info->fprintf_func)(info->stream, "%s", rname);
+                } else {
+                    (*info->fprintf_func)(info->stream, "%#x", value);
+                }
+            }
+        }
+    }
+
+    /* Pretty print extra info for pc-relative operands. */
+    if (rpcl && rset) {
+        if (info->flags & INSN_HAS_RELOC) {
+            /*
+             * If the instruction has a reloc associated with it, then
+             * the offset field in the instruction will actually be
+             * the addend for the reloc.  (We are using REL type
+             * relocs).  In such cases, we can ignore the pc when
+             * computing addresses, since the addend is not currently
+             * pc-relative.
+             */
+            memaddr = 0;
+        }
+
+        (*info->fprintf_func)(info->stream, "\t;");
+        (*info->print_address_func)((memaddr & ~3) + vpcl, info);
+    }
+}
+
+/* Select the proper instructions set for the given architecture. */
+
+static int arc_read_mem(bfd_vma memaddr,
+                        uint64_t *insn,
+                        uint32_t *isa_mask,
+                        struct disassemble_info *info)
+{
+    bfd_byte buffer[8];
+    unsigned int highbyte, lowbyte;
+    int status;
+    int insn_len = 0;
+
+    highbyte = ((info->endian == BFD_ENDIAN_LITTLE) ? 1 : 0);
+    lowbyte  = ((info->endian == BFD_ENDIAN_LITTLE) ? 0 : 1);
+
+    switch (info->mach) {
+    case bfd_mach_arc_arc700:
+        *isa_mask = ARC_OPCODE_ARC700;
+        break;
+
+    case bfd_mach_arc_arc601:
+    case bfd_mach_arc_arc600:
+        *isa_mask = ARC_OPCODE_ARC600;
+        break;
+
+    case bfd_mach_arc_arcv2em:
+    case bfd_mach_arc_arcv2:
+        *isa_mask = ARC_OPCODE_ARCv2EM;
+        break;
+    case bfd_mach_arc_arcv2hs:
+        *isa_mask = ARC_OPCODE_ARCv2HS;
+        break;
+    default:
+        *isa_mask = ARC_OPCODE_ARCv2EM;
+        break;
+    }
+
+    info->bytes_per_line  = 8;
+    info->bytes_per_chunk = 2;
+    info->display_endian = info->endian;
+
+    /* Read the insn into a host word. */
+    status = (*info->read_memory_func)(memaddr, buffer, 2, info);
+
+    if (status != 0) {
+        (*info->memory_error_func)(status, memaddr, info);
+        return -1;
+    }
+
+    insn_len = arc_insn_length((buffer[highbyte] << 8 |
+                buffer[lowbyte]), *isa_mask);
+
+    switch (insn_len) {
+    case 2:
+        *insn = (buffer[highbyte] << 8) | buffer[lowbyte];
+        break;
+
+    case 4:
+        /* This is a long instruction: Read the remaning 2 bytes. */
+        status = (*info->read_memory_func)(memaddr + 2, &buffer[2], 2, info);
+        if (status != 0) {
+            (*info->memory_error_func)(status, memaddr + 2, info);
+            return -1;
+        }
+        *insn = (uint64_t) ARRANGE_ENDIAN(info, buffer);
+        break;
+
+    case 6:
+        status = (*info->read_memory_func)(memaddr + 2, &buffer[2], 4, info);
+        if (status != 0) {
+            (*info->memory_error_func)(status, memaddr + 2, info);
+            return -1;
+        }
+        *insn  = (uint64_t) ARRANGE_ENDIAN(info, &buffer[2]);
+        *insn |= ((uint64_t) buffer[highbyte] << 40) |
+                 ((uint64_t) buffer[lowbyte]  << 32);
+        break;
+
+    case 8:
+        status = (*info->read_memory_func)(memaddr + 2, &buffer[2], 6, info);
+        if (status != 0) {
+            (*info->memory_error_func)(status, memaddr + 2, info);
+            return -1;
+        }
+        *insn = ((((uint64_t) ARRANGE_ENDIAN(info, buffer)) << 32) |
+                  ((uint64_t) ARRANGE_ENDIAN(info, &buffer[4])));
+        break;
+
+    default:
+        /* There is no instruction whose length is not 2, 4, 6, or 8. */
+        g_assert_not_reached();
+    }
+    return insn_len;
+}
+
+/* Disassembler main entry function. */
+
+int print_insn_arc(bfd_vma memaddr, struct disassemble_info *info)
+{
+    const struct arc_opcode *opcode = NULL;
+    int insn_len = -1;
+    uint64_t insn;
+    uint32_t isa_mask;
+    insn_t dis_insn;
+
+    insn_len = arc_read_mem(memaddr, &insn, &isa_mask, info);
+
+    if (insn_len < 2) {
+        return -1;
+    }
+
+    opcode = arc_find_format(&dis_insn, insn, insn_len, isa_mask);
+
+    /* If limm is required, read it. */
+    if (dis_insn.limm_p) {
+        bfd_byte buffer[4];
+        int status = (*info->read_memory_func)(memaddr + insn_len, buffer,
+                                               4, info);
+        if (status != 0) {
+            return -1;
+        }
+        dis_insn.limm = ARRANGE_ENDIAN(info, buffer);
+        insn_len += 4;
+    }
+
+    /* Print the mnemonic. */
+    (*info->fprintf_func)(info->stream, "%s", opcode->name);
+
+    print_flags(opcode, insn, info);
+
+    if (opcode->operands[0] != 0) {
+        (*info->fprintf_func)(info->stream, "\t");
+    }
+
+    /* Now extract and print the operands. */
+    print_operands(opcode, memaddr, insn, isa_mask, &dis_insn, info);
+
+    /* Say how many bytes we consumed */
+    return insn_len;
+}
+
+
+/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
+/* vim: set ts=4 sw=4 et: */
diff --git a/target/arc/decoder.c b/target/arc/decoder.c
new file mode 100644
index 0000000000..c3cf84d6ee
--- /dev/null
+++ b/target/arc/decoder.c
@@ -0,0 +1,1276 @@
+/*
+ * QEMU Decoder for the ARC.
+ * Copyright (C) 2020 Free Software Foundation, Inc.
+
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public License
+ * as published by the Free Software Foundation; either version 2.1 of
+ * the License, or (at your option) any later version.
+
+ * This library is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License
+ * along with GAS or GDB; see the file COPYING3. If not, write to
+ * the Free Software Foundation, 51 Franklin Street - Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ */
+
+#include "target/arc/decoder.h"
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "cpu.h"
+
+/* Extract functions. */
+static ATTRIBUTE_UNUSED int
+extract_limm(unsigned long long insn ATTRIBUTE_UNUSED,
+             bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  return value;
+}
+
+/* mask = 00000000000000000000111111000000. */
+static long long int
+extract_uimm6_20(unsigned long long insn ATTRIBUTE_UNUSED,
+                 bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 6) & 0x003f) << 0;
+
+  return value;
+}
+
+/* mask = 00000000000000000000111111222222. */
+static long long int
+extract_simm12_20(unsigned long long insn ATTRIBUTE_UNUSED,
+                  bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  int value = 0;
+
+  value |= ((insn >> 6) & 0x003f) << 0;
+  value |= ((insn >> 0) & 0x003f) << 6;
+
+  /* Extend the sign. */
+  int signbit = 1 << (12 - 1);
+  value = (value ^ signbit) - signbit;
+
+  return value;
+}
+
+/* mask = 0000011100000000. */
+static ATTRIBUTE_UNUSED int
+extract_simm3_5_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                  bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  int value = 0;
+
+  value |= ((insn >> 8) & 0x0007) << 0;
+
+  /* Extend the sign. */
+  int signbit = 1 << (3 - 1);
+  value = (value ^ signbit) - signbit;
+
+  return value;
+}
+
+static ATTRIBUTE_UNUSED int
+extract_limm_s(unsigned long long insn ATTRIBUTE_UNUSED,
+               bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  return value;
+}
+
+/* mask = 0000000000011111. */
+static long long int
+extract_uimm7_a32_11_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                       bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 0) & 0x001f) << 2;
+
+  return value;
+}
+
+/* mask = 0000000001111111. */
+static long long int
+extract_uimm7_9_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                  bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 0) & 0x007f) << 0;
+
+  return value;
+}
+
+/* mask = 0000000000000111. */
+static long long int
+extract_uimm3_13_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                   bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 0) & 0x0007) << 0;
+
+  return value;
+}
+
+/* mask = 0000000111111111. */
+static long long int
+extract_simm11_a32_7_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                       bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  int value = 0;
+
+  value |= ((insn >> 0) & 0x01ff) << 2;
+
+  /* Extend the sign. */
+  int signbit = 1 << (11 - 1);
+  value = (value ^ signbit) - signbit;
+
+  return value;
+}
+
+/* mask = 0000000002220111. */
+static long long int
+extract_uimm6_13_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                   bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 0) & 0x0007) << 0;
+  value |= ((insn >> 4) & 0x0007) << 3;
+
+  return value;
+}
+
+/* mask = 0000000000011111. */
+static long long int
+extract_uimm5_11_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                   bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 0) & 0x001f) << 0;
+
+  return value;
+}
+
+/* mask = 00000000111111102000000000000000. */
+static long long int
+extract_simm9_a16_8(unsigned long long insn ATTRIBUTE_UNUSED,
+                    bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  int value = 0;
+
+  value |= ((insn >> 17) & 0x007f) << 1;
+  value |= ((insn >> 15) & 0x0001) << 8;
+
+  /* Extend the sign. */
+  int signbit = 1 << (9 - 1);
+  value = (value ^ signbit) - signbit;
+
+  return value;
+}
+
+/* mask = 00000000000000000000111111000000. */
+static long long int
+extract_uimm6_8(unsigned long long insn ATTRIBUTE_UNUSED,
+                bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 6) & 0x003f) << 0;
+
+  return value;
+}
+
+/* mask = 00000111111111102222222222000000. */
+static long long int
+extract_simm21_a16_5(unsigned long long insn ATTRIBUTE_UNUSED,
+                     bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  int value = 0;
+
+  value |= ((insn >> 17) & 0x03ff) << 1;
+  value |= ((insn >> 6) & 0x03ff) << 11;
+
+  /* Extend the sign. */
+  int signbit = 1 << (21 - 1);
+  value = (value ^ signbit) - signbit;
+
+  return value;
+}
+
+/* mask = 00000111111111102222222222003333. */
+static long long int
+extract_simm25_a16_5(unsigned long long insn ATTRIBUTE_UNUSED,
+                     bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  int value = 0;
+
+  value |= ((insn >> 17) & 0x03ff) << 1;
+  value |= ((insn >> 6) & 0x03ff) << 11;
+  value |= ((insn >> 0) & 0x000f) << 21;
+
+  /* Extend the sign. */
+  int signbit = 1 << (25 - 1);
+  value = (value ^ signbit) - signbit;
+
+  return value;
+}
+
+/* mask = 0000000111111111. */
+static long long int
+extract_simm10_a16_7_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                       bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  int value = 0;
+
+  value |= ((insn >> 0) & 0x01ff) << 1;
+
+  /* Extend the sign. */
+  int signbit = 1 << (10 - 1);
+  value = (value ^ signbit) - signbit;
+
+  return value;
+}
+
+/* mask = 0000000000111111. */
+static long long int
+extract_simm7_a16_10_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                       bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  int value = 0;
+
+  value |= ((insn >> 0) & 0x003f) << 1;
+
+  /* Extend the sign. */
+  int signbit = 1 << (7 - 1);
+  value = (value ^ signbit) - signbit;
+
+  return value;
+}
+
+/* mask = 00000111111111002222222222000000. */
+static long long int
+extract_simm21_a32_5(unsigned long long insn ATTRIBUTE_UNUSED,
+                     bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  int value = 0;
+
+  value |= ((insn >> 18) & 0x01ff) << 2;
+  value |= ((insn >> 6) & 0x03ff) << 11;
+
+  /* Extend the sign. */
+  int signbit = 1 << (21 - 1);
+  value = (value ^ signbit) - signbit;
+
+  return value;
+}
+
+/* mask = 00000111111111002222222222003333. */
+static long long int
+extract_simm25_a32_5(unsigned long long insn ATTRIBUTE_UNUSED,
+                     bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  int value = 0;
+
+  value |= ((insn >> 18) & 0x01ff) << 2;
+  value |= ((insn >> 6) & 0x03ff) << 11;
+  value |= ((insn >> 0) & 0x000f) << 21;
+
+  /* Extend the sign. */
+  int signbit = 1 << (25 - 1);
+  value = (value ^ signbit) - signbit;
+
+  return value;
+}
+
+/* mask = 0000011111111111. */
+static long long int
+extract_simm13_a32_5_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                       bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  int value = 0;
+
+  value |= ((insn >> 0) & 0x07ff) << 2;
+
+  /* Extend the sign. */
+  int signbit = 1 << (13 - 1);
+  value = (value ^ signbit) - signbit;
+
+  return value;
+}
+
+/* mask = 0000000001111111. */
+static long long int
+extract_simm8_a16_9_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                      bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  int value = 0;
+
+  value |= ((insn >> 0) & 0x007f) << 1;
+
+  /* Extend the sign. */
+  int signbit = 1 << (8 - 1);
+  value = (value ^ signbit) - signbit;
+
+  return value;
+}
+
+/* mask = 00000000000000000000000111000000. */
+static long long int
+extract_uimm3_23(unsigned long long insn ATTRIBUTE_UNUSED,
+                 bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 6) & 0x0007) << 0;
+
+  return value;
+}
+
+/* mask = 0000001111111111. */
+static long long int
+extract_uimm10_6_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                   bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 0) & 0x03ff) << 0;
+
+  return value;
+}
+
+/* mask = 0000002200011110. */
+static long long int
+extract_uimm6_11_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                   bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 1) & 0x000f) << 0;
+  value |= ((insn >> 8) & 0x0003) << 4;
+
+  return value;
+}
+
+/* mask = 00000000111111112000000000000000. */
+static long long int
+extract_simm9_8(unsigned long long insn ATTRIBUTE_UNUSED,
+                bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  int value = 0;
+
+  value |= ((insn >> 16) & 0x00ff) << 0;
+  value |= ((insn >> 15) & 0x0001) << 8;
+
+  /* Extend the sign. */
+  int signbit = 1 << (9 - 1);
+  value = (value ^ signbit) - signbit;
+
+  return value;
+}
+
+/* mask = 0000000011111111. */
+static long long int
+extract_uimm10_a32_8_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                       bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 0) & 0x00ff) << 2;
+
+  return value;
+}
+
+/* mask = 0000000111111111. */
+static long long int
+extract_simm9_7_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                  bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  int value = 0;
+
+  value |= ((insn >> 0) & 0x01ff) << 0;
+
+  /* Extend the sign. */
+  int signbit = 1 << (9 - 1);
+  value = (value ^ signbit) - signbit;
+
+  return value;
+}
+
+/* mask = 0000000000011111. */
+static long long int
+extract_uimm6_a16_11_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                       bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 0) & 0x001f) << 1;
+
+  return value;
+}
+
+/* mask = 0000020000011000. */
+static long long int
+extract_uimm5_a32_11_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                       bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 3) & 0x0003) << 2;
+  value |= ((insn >> 10) & 0x0001) << 4;
+
+  return value;
+}
+
+/* mask = 0000022222200111. */
+static long long int
+extract_simm11_a32_13_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                        bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  int value = 0;
+
+  value |= ((insn >> 0) & 0x0007) << 2;
+  value |= ((insn >> 5) & 0x003f) << 5;
+
+  /* Extend the sign. */
+  int signbit = 1 << (11 - 1);
+  value = (value ^ signbit) - signbit;
+
+  return value;
+}
+
+/* mask = 0000000022220111. */
+static long long int
+extract_uimm7_13_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                   bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 0) & 0x0007) << 0;
+  value |= ((insn >> 4) & 0x000f) << 3;
+
+  return value;
+}
+
+/* mask = 00000000000000000000011111000000. */
+static long long int
+extract_uimm6_a16_21(unsigned long long insn ATTRIBUTE_UNUSED,
+                     bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 6) & 0x001f) << 1;
+
+  return value;
+}
+
+/* mask = 0000022200011110. */
+static long long int
+extract_uimm7_11_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                   bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 1) & 0x000f) << 0;
+  value |= ((insn >> 8) & 0x0007) << 4;
+
+  return value;
+}
+
+/* mask = 00000000000000000000111111000000. */
+static long long int
+extract_uimm7_a16_20(unsigned long long insn ATTRIBUTE_UNUSED,
+                     bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 6) & 0x003f) << 1;
+
+  return value;
+}
+
+/* mask = 00000000000000000000111111222222. */
+static long long int
+extract_simm13_a16_20(unsigned long long insn ATTRIBUTE_UNUSED,
+                      bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  int value = 0;
+
+  value |= ((insn >> 6) & 0x003f) << 1;
+  value |= ((insn >> 0) & 0x003f) << 7;
+
+  /* Extend the sign. */
+  int signbit = 1 << (13 - 1);
+  value = (value ^ signbit) - signbit;
+
+  return value;
+}
+
+/* mask = 0000000011111111. */
+static long long int
+extract_uimm8_8_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                  bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 0) & 0x00ff) << 0;
+
+  return value;
+}
+
+/* mask = 0000011111100000. */
+static long long int
+extract_uimm6_5_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                  bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  value |= ((insn >> 5) & 0x003f) << 0;
+
+  return value;
+}
+
+/* mask = 00000000000000000000000000000000. */
+static ATTRIBUTE_UNUSED int
+extract_uimm6_axx_(unsigned long long insn ATTRIBUTE_UNUSED,
+                   bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+  unsigned value = 0;
+
+  return value;
+}
+
+static long long int extract_rb(unsigned long long insn ATTRIBUTE_UNUSED,
+                                bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    int value = (((insn >> 12) & 0x07) << 3) | ((insn >> 24) & 0x07);
+
+    if (value == 0x3e && invalid) {
+        *invalid = TRUE;
+    }
+
+    return value;
+}
+
+static long long int extract_rhv1(unsigned long long insn ATTRIBUTE_UNUSED,
+                                  bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    int value = ((insn & 0x7) << 3) | ((insn >> 5) & 0x7);
+
+    return value;
+}
+
+static long long int extract_rhv2(unsigned long long insn ATTRIBUTE_UNUSED,
+                                  bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    int value = ((insn >> 5) & 0x07) | ((insn & 0x03) << 3);
+
+    return value;
+}
+
+static long long int extract_r0(unsigned long long insn ATTRIBUTE_UNUSED,
+                                bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    return 0;
+}
+
+static long long int extract_r1(unsigned long long insn ATTRIBUTE_UNUSED,
+                                bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    return 1;
+}
+
+static long long int extract_r2(unsigned long long insn ATTRIBUTE_UNUSED,
+                                bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    return 2;
+}
+
+static long long int extract_r3(unsigned long long insn ATTRIBUTE_UNUSED,
+                                bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    return 3;
+}
+
+static long long int extract_sp(unsigned long long insn ATTRIBUTE_UNUSED,
+                                bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    return 28;
+}
+
+static long long int extract_gp(unsigned long long insn ATTRIBUTE_UNUSED,
+                                bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    return 26;
+}
+
+static long long int extract_pcl(unsigned long long insn ATTRIBUTE_UNUSED,
+                                 bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    return 63;
+}
+
+static long long int extract_blink(unsigned long long insn ATTRIBUTE_UNUSED,
+                                   bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    return 31;
+}
+
+static long long int extract_ilink1(unsigned long long insn ATTRIBUTE_UNUSED,
+                                    bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    return 29;
+}
+
+static long long int extract_ilink2(unsigned long long insn ATTRIBUTE_UNUSED,
+                                    bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    return 30;
+}
+
+static long long int extract_ras(unsigned long long insn ATTRIBUTE_UNUSED,
+                                 bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    int value = insn & 0x07;
+    if (value > 3) {
+        return value + 8;
+    } else {
+        return value;
+    }
+}
+
+static long long int extract_rbs(unsigned long long insn ATTRIBUTE_UNUSED,
+                                 bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    int value = (insn >> 8) & 0x07;
+    if (value > 3) {
+        return value + 8;
+    } else {
+        return value;
+    }
+}
+
+static long long int extract_rcs(unsigned long long insn ATTRIBUTE_UNUSED,
+                                 bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    int value = (insn >> 5) & 0x07;
+    if (value > 3) {
+        return value + 8;
+    } else {
+        return value;
+    }
+}
+
+static long long int extract_simm3s(unsigned long long insn ATTRIBUTE_UNUSED,
+                                    bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    int value = (insn >> 8) & 0x07;
+    if (value == 7) {
+        return -1;
+    } else {
+        return value;
+    }
+}
+
+static long long int extract_rrange(unsigned long long insn  ATTRIBUTE_UNUSED,
+                                    bfd_boolean * invalid  ATTRIBUTE_UNUSED)
+{
+    return (insn >> 1) & 0x0F;
+}
+
+static long long int extract_fpel(unsigned long long insn  ATTRIBUTE_UNUSED,
+                                  bfd_boolean * invalid  ATTRIBUTE_UNUSED)
+{
+    return (insn & 0x0100) ? 27 : -1;
+}
+
+static long long int extract_blinkel(unsigned long long insn  ATTRIBUTE_UNUSED,
+                                     bfd_boolean * invalid  ATTRIBUTE_UNUSED)
+{
+    return (insn & 0x0200) ? 31 : -1;
+}
+
+static long long int extract_pclel(unsigned long long insn  ATTRIBUTE_UNUSED,
+                                   bfd_boolean * invalid  ATTRIBUTE_UNUSED)
+{
+    return (insn & 0x0400) ? 63 : -1;
+}
+
+static long long int extract_w6(unsigned long long insn ATTRIBUTE_UNUSED,
+                                bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    signed value = 0;
+
+    value |= ((insn >> 6) & 0x003f) << 0;
+
+    int signbit = 1 << 5;
+    value = (value ^ signbit) - signbit;
+
+    return value;
+}
+
+static long long int extract_g_s(unsigned long long insn ATTRIBUTE_UNUSED,
+                                 bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    int value = 0;
+
+    value |= ((insn >> 8) & 0x0007) << 0;
+    value |= ((insn >> 3) & 0x0003) << 3;
+
+    /* Extend the sign. */
+    int signbit = 1 << (6 - 1);
+    value = (value ^ signbit) - signbit;
+
+    return value;
+}
+
+static long long int extract_uimm12_20(unsigned long long insn ATTRIBUTE_UNUSED,
+                                       bfd_boolean *invalid ATTRIBUTE_UNUSED)
+{
+    int value = 0;
+
+    value |= ((insn >> 6) & 0x003f) << 0;
+    value |= ((insn >> 0) & 0x003f) << 6;
+
+    return value;
+}
+
+/*
+ * The operands table.
+ *
+ * The format of the operands table is:
+ *
+ * BITS SHIFT FLAGS EXTRACT_FUN.
+ */
+const struct arc_operand arc_operands[] = {
+    { 0, 0, 0, 0 },
+#define ARC_OPERAND(NAME, BITS, SHIFT, RELO, FLAGS, FUN)       \
+    { BITS, SHIFT, FLAGS, FUN },
+#include "target/arc/operands.def"
+#undef ARC_OPERAND
+    { 0, 0, 0, 0}
+};
+
+enum arc_operands_map {
+    OPERAND_UNUSED = 0,
+#define ARC_OPERAND(NAME, BITS, SHIFT, RELO, FLAGS, FUN) OPERAND_##NAME,
+#include "target/arc/operands.def"
+#undef ARC_OPERAND
+    OPERAND_LAST
+};
+
+/*
+ * The flag operands table.
+ *
+ * The format of the table is
+ * NAME CODE BITS SHIFT FAVAIL.
+ */
+const struct arc_flag_operand arc_flag_operands[] = {
+    { 0, 0, 0, 0, 0},
+#define ARC_FLAG(NAME, MNEMONIC, CODE, BITS, SHIFT, AVAIL)      \
+    { MNEMONIC, CODE, BITS, SHIFT, AVAIL },
+#include "target/arc/flags.def"
+#undef ARC_FLAG
+    { 0, 0, 0, 0, 0}
+};
+
+enum arc_flags_map {
+    F_NULL = 0,
+#define ARC_FLAG(NAME, MNEMONIC, CODE, BITS, SHIFT, AVAIL) F_##NAME,
+#include "target/arc/flags.def"
+#undef ARC_FLAG
+    F_LAST
+};
+
+/*
+ * Table of the flag classes.
+ *
+ * The format of the table is
+ * CLASS {FLAG_CODE}.
+ */
+const struct arc_flag_class arc_flag_classes[] = {
+#define C_EMPTY             0
+    { F_CLASS_NONE, { F_NULL } },
+
+#define C_CC_EQ             (C_EMPTY + 1)
+    {F_CLASS_IMPLICIT | F_CLASS_COND, {F_EQUAL, F_NULL} },
+
+#define C_CC_GE             (C_CC_EQ + 1)
+    {F_CLASS_IMPLICIT | F_CLASS_COND, {F_GE, F_NULL} },
+
+#define C_CC_GT             (C_CC_GE + 1)
+    {F_CLASS_IMPLICIT | F_CLASS_COND, {F_GT, F_NULL} },
+
+#define C_CC_HI             (C_CC_GT + 1)
+    {F_CLASS_IMPLICIT | F_CLASS_COND, {F_HI, F_NULL} },
+
+#define C_CC_HS             (C_CC_HI + 1)
+    {F_CLASS_IMPLICIT | F_CLASS_COND, {F_NOTCARRY, F_NULL} },
+
+#define C_CC_LE             (C_CC_HS + 1)
+    {F_CLASS_IMPLICIT | F_CLASS_COND, {F_LE, F_NULL} },
+
+#define C_CC_LO             (C_CC_LE + 1)
+    {F_CLASS_IMPLICIT | F_CLASS_COND, {F_CARRY, F_NULL} },
+
+#define C_CC_LS             (C_CC_LO + 1)
+    {F_CLASS_IMPLICIT | F_CLASS_COND, {F_LS, F_NULL} },
+
+#define C_CC_LT             (C_CC_LS + 1)
+    {F_CLASS_IMPLICIT | F_CLASS_COND, {F_LT, F_NULL} },
+
+#define C_CC_NE             (C_CC_LT + 1)
+    {F_CLASS_IMPLICIT | F_CLASS_COND, {F_NOTEQUAL, F_NULL} },
+
+#define C_AA_AB             (C_CC_NE + 1)
+    {F_CLASS_IMPLICIT | F_CLASS_WB, {F_AB3, F_NULL} },
+
+#define C_AA_AW             (C_AA_AB + 1)
+    {F_CLASS_IMPLICIT | F_CLASS_WB, {F_AW3, F_NULL} },
+
+#define C_ZZ_D              (C_AA_AW + 1)
+    {F_CLASS_IMPLICIT | F_CLASS_ZZ, {F_SIZED, F_NULL} },
+
+#define C_ZZ_H              (C_ZZ_D + 1)
+    {F_CLASS_IMPLICIT | F_CLASS_ZZ, {F_H1, F_NULL} },
+
+#define C_ZZ_B              (C_ZZ_H + 1)
+    {F_CLASS_IMPLICIT | F_CLASS_ZZ, {F_SIZEB1, F_NULL} },
+
+#define C_CC                (C_ZZ_B + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_EXTEND | F_CLASS_COND,
+        { F_ALWAYS, F_RA, F_EQUAL, F_ZERO, F_NOTEQUAL,
+          F_NOTZERO, F_POZITIVE, F_PL, F_NEGATIVE, F_MINUS,
+          F_CARRY, F_CARRYSET, F_LOWER, F_CARRYCLR,
+          F_NOTCARRY, F_HIGHER, F_OVERFLOWSET, F_OVERFLOW,
+          F_NOTOVERFLOW, F_OVERFLOWCLR, F_GT, F_GE, F_LT,
+          F_LE, F_HI, F_LS, F_PNZ, F_NULL
+        }
+    },
+
+#define C_AA_ADDR3          (C_CC + 1)
+#define C_AA27              (C_CC + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_WB, { F_A3, F_AW3, F_AB3, F_AS3, F_NULL } },
+#define C_AA_ADDR9          (C_AA_ADDR3 + 1)
+#define C_AA21              (C_AA_ADDR3 + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_WB, { F_A9, F_AW9, F_AB9, F_AS9, F_NULL } },
+#define C_AA_ADDR22         (C_AA_ADDR9 + 1)
+#define C_AA8               (C_AA_ADDR9 + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_WB,
+        { F_A22, F_AW22, F_AB22, F_AS22, F_NULL }
+    },
+
+#define C_F                 (C_AA_ADDR22 + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_F, { F_FLAG, F_NULL } },
+#define C_FHARD             (C_F + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_F, { F_FFAKE, F_NULL } },
+
+#define C_T                 (C_FHARD + 1)
+    { F_CLASS_OPTIONAL, { F_NT, F_T, F_NULL } },
+#define C_D                 (C_T + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_D, { F_ND, F_D, F_NULL } },
+#define C_DNZ_D             (C_D + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_D, { F_DNZ_ND, F_DNZ_D, F_NULL } },
+
+#define C_DHARD             (C_DNZ_D + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_D, { F_DFAKE, F_NULL } },
+
+#define C_DI20              (C_DHARD + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_DI, { F_DI11, F_NULL } },
+#define C_DI14              (C_DI20 + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_DI, { F_DI14, F_NULL } },
+#define C_DI16              (C_DI14 + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_DI, { F_DI15, F_NULL } },
+#define C_DI26              (C_DI16 + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_DI, { F_DI5, F_NULL } },
+
+#define C_X25               (C_DI26 + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_X, { F_SIGN6, F_NULL } },
+#define C_X15               (C_X25 + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_X, { F_SIGN16, F_NULL } },
+#define C_XHARD             (C_X15 + 1)
+#define C_X                 (C_X15 + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_X, { F_SIGNX, F_NULL } },
+
+#define C_ZZ13              (C_X + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_ZZ, { F_SIZEB17, F_SIZEW17, F_H17, F_NULL} },
+#define C_ZZ23              (C_ZZ13 + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_ZZ, { F_SIZEB7, F_SIZEW7, F_H7, F_NULL} },
+#define C_ZZ29              (C_ZZ23 + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_ZZ, { F_SIZEB1, F_SIZEW1, F_H1, F_NULL} },
+
+#define C_AS                (C_ZZ29 + 1)
+    { F_CLASS_IMPLICIT | F_CLASS_OPTIONAL | F_CLASS_WB, { F_ASFAKE, F_NULL} },
+
+#define C_NE                (C_AS + 1)
+    { F_CLASS_OPTIONAL | F_CLASS_COND, { F_NE, F_NULL} },
+};
+
+/* List with special cases instructions and the applicable flags. */
+const struct arc_flag_special arc_flag_special_cases[] = {
+    { "b",  { F_ALWAYS, F_RA, F_EQUAL, F_ZERO, F_NOTEQUAL, F_NOTZERO,
+              F_POZITIVE, F_PL, F_NEGATIVE, F_MINUS, F_CARRY, F_CARRYSET,
+              F_LOWER, F_CARRYCLR, F_NOTCARRY, F_HIGHER, F_OVERFLOWSET,
+              F_OVERFLOW, F_NOTOVERFLOW, F_OVERFLOWCLR, F_GT, F_GE, F_LT,
+              F_LE, F_HI, F_LS, F_PNZ, F_NULL
+            }
+    },
+    { "bl", { F_ALWAYS, F_RA, F_EQUAL, F_ZERO, F_NOTEQUAL, F_NOTZERO,
+              F_POZITIVE, F_PL, F_NEGATIVE, F_MINUS, F_CARRY, F_CARRYSET,
+              F_LOWER, F_CARRYCLR, F_NOTCARRY, F_HIGHER, F_OVERFLOWSET,
+              F_OVERFLOW, F_NOTOVERFLOW, F_OVERFLOWCLR, F_GT, F_GE, F_LT,
+              F_LE, F_HI, F_LS, F_PNZ, F_NULL
+            }
+    },
+    { "br", { F_ALWAYS, F_RA, F_EQUAL, F_ZERO, F_NOTEQUAL, F_NOTZERO,
+              F_POZITIVE, F_PL, F_NEGATIVE, F_MINUS, F_CARRY, F_CARRYSET,
+              F_LOWER, F_CARRYCLR, F_NOTCARRY, F_HIGHER, F_OVERFLOWSET,
+              F_OVERFLOW, F_NOTOVERFLOW, F_OVERFLOWCLR, F_GT, F_GE, F_LT,
+              F_LE, F_HI, F_LS, F_PNZ, F_NULL
+            }
+    },
+    { "j",  { F_ALWAYS, F_RA, F_EQUAL, F_ZERO, F_NOTEQUAL, F_NOTZERO,
+              F_POZITIVE, F_PL, F_NEGATIVE, F_MINUS, F_CARRY, F_CARRYSET,
+              F_LOWER, F_CARRYCLR, F_NOTCARRY, F_HIGHER, F_OVERFLOWSET,
+              F_OVERFLOW, F_NOTOVERFLOW, F_OVERFLOWCLR, F_GT, F_GE, F_LT,
+              F_LE, F_HI, F_LS, F_PNZ, F_NULL
+            }
+    },
+    { "jl", { F_ALWAYS, F_RA, F_EQUAL, F_ZERO, F_NOTEQUAL, F_NOTZERO,
+              F_POZITIVE, F_PL, F_NEGATIVE, F_MINUS, F_CARRY, F_CARRYSET,
+              F_LOWER, F_CARRYCLR, F_NOTCARRY, F_HIGHER, F_OVERFLOWSET,
+              F_OVERFLOW, F_NOTOVERFLOW, F_OVERFLOWCLR, F_GT, F_GE, F_LT,
+              F_LE, F_HI, F_LS, F_PNZ, F_NULL
+            }
+    },
+    { "lp", { F_ALWAYS, F_RA, F_EQUAL, F_ZERO, F_NOTEQUAL, F_NOTZERO,
+              F_POZITIVE, F_PL, F_NEGATIVE, F_MINUS, F_CARRY, F_CARRYSET,
+              F_LOWER, F_CARRYCLR, F_NOTCARRY, F_HIGHER, F_OVERFLOWSET,
+              F_OVERFLOW, F_NOTOVERFLOW, F_OVERFLOWCLR, F_GT, F_GE, F_LT,
+              F_LE, F_HI, F_LS, F_PNZ, F_NULL
+            }
+    },
+    { "set", { F_ALWAYS, F_RA, F_EQUAL, F_ZERO, F_NOTEQUAL, F_NOTZERO,
+               F_POZITIVE, F_PL, F_NEGATIVE, F_MINUS, F_CARRY, F_CARRYSET,
+               F_LOWER, F_CARRYCLR, F_NOTCARRY, F_HIGHER, F_OVERFLOWSET,
+               F_OVERFLOW, F_NOTOVERFLOW, F_OVERFLOWCLR, F_GT, F_GE, F_LT,
+               F_LE, F_HI, F_LS, F_PNZ, F_NULL
+             }
+    },
+    { "ld", { F_SIZEB17, F_SIZEW17, F_H17, F_NULL } },
+    { "st", { F_SIZEB1, F_SIZEW1, F_H1, F_NULL } }
+};
+
+const unsigned arc_num_flag_special = ARRAY_SIZE(arc_flag_special_cases);
+
+/*
+ * The opcode table.
+ *
+ * The format of the opcode table is:
+ *
+ * NAME OPCODE MASK CPU CLASS SUBCLASS { OPERANDS } { FLAGS }.
+ *
+ * The table is organised such that, where possible, all instructions with
+ * the same mnemonic are together in a block. When the assembler searches
+ * for a suitable instruction the entries are checked in table order, so
+ * more specific, or specialised cases should appear earlier in the table.
+ *
+ * As an example, consider two instructions 'add a,b,u6' and 'add
+ * a,b,limm'. The first takes a 6-bit immediate that is encoded within the
+ * 32-bit instruction, while the second takes a 32-bit immediate that is
+ * encoded in a follow-on 32-bit, making the total instruction length
+ * 64-bits. In this case the u6 variant must appear first in the table, as
+ * all u6 immediates could also be encoded using the 'limm' extension,
+ * however, we want to use the shorter instruction wherever possible.
+ *
+ * It is possible though to split instructions with the same mnemonic into
+ * multiple groups. However, the instructions are still checked in table
+ * order, even across groups. The only time that instructions with the
+ * same mnemonic should be split into different groups is when different
+ * variants of the instruction appear in different architectures, in which
+ * case, grouping all instructions from a particular architecture together
+ * might be preferable to merging the instruction into the main instruction
+ * table.
+ *
+ * An example of this split instruction groups can be found with the 'sync'
+ * instruction. The core arc architecture provides a 'sync' instruction,
+ * while the nps instruction set extension provides 'sync.rd' and
+ * 'sync.wr'. The rd/wr flags are instruction flags, not part of the
+ * mnemonic, so we end up with two groups for the sync instruction, the
+ * first within the core arc instruction table, and the second within the
+ * nps extension instructions.
+ */
+static const struct arc_opcode arc_opcodes[] = {
+#include "target/arc/opcodes.def"
+    { NULL, 0, 0, 0, 0, 0, { 0 }, { 0 } }
+};
+
+/* Return length of an opcode in bytes. */
+static uint8_t arc_opcode_len(const struct arc_opcode *opcode)
+{
+    if (opcode->mask < 0x10000ull) {
+        return 2;
+    }
+
+    if (opcode->mask < 0x100000000ull) {
+        return 4;
+    }
+
+    if (opcode->mask < 0x1000000000000ull) {
+        return 6;
+    }
+
+    return 8;
+}
+
+/*Helper for arc_find_format. */
+static const struct arc_opcode *find_format(insn_t *pinsn,
+                                            uint64_t insn,
+                                            uint8_t insn_len,
+                                            uint32_t isa_mask)
+{
+    uint32_t i = 0;
+    const struct arc_opcode *opcode = NULL;
+    const uint8_t *opidx;
+    const uint8_t *flgidx;
+    bool has_limm = false;
+
+    do {
+        bool invalid = false;
+        uint32_t noperands = 0;
+
+        opcode = &arc_opcodes[i++];
+        memset(pinsn, 0, sizeof(*pinsn));
+
+        if (!(opcode->cpu & isa_mask)) {
+            continue;
+        }
+
+        if (arc_opcode_len(opcode) != (int) insn_len) {
+            continue;
+        }
+
+        if ((insn & opcode->mask) != opcode->opcode) {
+            continue;
+        }
+
+        has_limm = false;
+
+        /* Possible candidate, check the operands. */
+        for (opidx = opcode->operands; *opidx; ++opidx) {
+            int value, limmind;
+            const struct arc_operand *operand = &arc_operands[*opidx];
+
+            if (operand->flags & ARC_OPERAND_FAKE) {
+                continue;
+            }
+
+            if (operand->extract) {
+                value = (*operand->extract)(insn, &invalid);
+            } else {
+                value = (insn >> operand->shift) & ((1 << operand->bits) - 1);
+            }
+
+            /*
+             * Check for LIMM indicator. If it is there, then make sure
+             * we pick the right format.
+             */
+            limmind = (isa_mask & ARC_OPCODE_ARCV2) ? 0x1E : 0x3E;
+            if (operand->flags & ARC_OPERAND_IR &&
+                !(operand->flags & ARC_OPERAND_LIMM)) {
+                if ((value == 0x3E && insn_len == 4) ||
+                    (value == limmind && insn_len == 2)) {
+                    invalid = TRUE;
+                    break;
+                }
+            }
+
+            if (operand->flags & ARC_OPERAND_LIMM &&
+                !(operand->flags & ARC_OPERAND_DUPLICATE)) {
+                has_limm = true;
+            }
+
+            pinsn->operands[noperands].value = value;
+            pinsn->operands[noperands].type = operand->flags;
+            noperands += 1;
+            pinsn->n_ops = noperands;
+        }
+
+        /* Check the flags. */
+        for (flgidx = opcode->flags; *flgidx; ++flgidx) {
+            /* Get a valid flag class. */
+            const struct arc_flag_class *cl_flags = &arc_flag_classes[*flgidx];
+            const unsigned *flgopridx;
+            bool foundA = false, foundB = false;
+            unsigned int value;
+
+            /* FIXME! Add check for EXTENSION flags. */
+
+            for (flgopridx = cl_flags->flags; *flgopridx; ++flgopridx) {
+                const struct arc_flag_operand *flg_operand =
+                &arc_flag_operands[*flgopridx];
+
+                /* Check for the implicit flags. */
+                if (cl_flags->flag_class & F_CLASS_IMPLICIT) {
+                    if (cl_flags->flag_class & F_CLASS_COND) {
+                        pinsn->cc = flg_operand->code;
+                    } else if (cl_flags->flag_class & F_CLASS_WB) {
+                        pinsn->aa = flg_operand->code;
+                    } else if (cl_flags->flag_class & F_CLASS_ZZ) {
+                        pinsn->zz = flg_operand->code;
+                    }
+                    continue;
+                }
+
+                value = (insn >> flg_operand->shift) &
+                        ((1 << flg_operand->bits) - 1);
+                if (value == flg_operand->code) {
+                    if (cl_flags->flag_class & F_CLASS_ZZ) {
+                        switch (flg_operand->name[0]) {
+                        case 'b':
+                            pinsn->zz = 1;
+                            break;
+                        case 'h':
+                        case 'w':
+                            pinsn->zz = 2;
+                            break;
+                        default:
+                            pinsn->zz = 4;
+                            break;
+                        }
+                    }
+
+                    /*
+                     * TODO: This has a problem: instruction "b label"
+                     * sets this to true.
+                     */
+                    if (cl_flags->flag_class & F_CLASS_D) {
+                        pinsn->d = value ? true : false;
+                        if (cl_flags->flags[0] == F_DFAKE) {
+                            pinsn->d = true;
+                        }
+                    }
+
+                    if (cl_flags->flag_class & F_CLASS_COND) {
+                        pinsn->cc = value;
+                    }
+
+                    if (cl_flags->flag_class & F_CLASS_WB) {
+                        pinsn->aa = value;
+                    }
+
+                    if (cl_flags->flag_class & F_CLASS_F) {
+                        pinsn->f = true;
+                    }
+
+                    if (cl_flags->flag_class & F_CLASS_DI) {
+                        pinsn->di = true;
+                    }
+
+                    if (cl_flags->flag_class & F_CLASS_X) {
+                        pinsn->x = true;
+                    }
+
+                    foundA = true;
+                }
+                if (value) {
+                    foundB = true;
+                }
+            }
+
+            if (!foundA && foundB) {
+                invalid = TRUE;
+                break;
+            }
+        }
+
+        if (invalid) {
+            continue;
+        }
+
+        /* The instruction is valid. */
+        pinsn->limm_p = has_limm;
+        pinsn->class = (uint32_t) opcode->insn_class;
+
+        /*
+         * FIXME: here add extra info about the instruction
+         * e.g. delay slot, data size, write back, etc.
+         */
+        return opcode;
+    } while (opcode->mask);
+
+    memset(pinsn, 0, sizeof(*pinsn));
+    return NULL;
+}
+
+/* Main entry point for this file. */
+const struct arc_opcode *arc_find_format(insn_t *insnd,
+                                         uint64_t insn,
+                                         uint8_t insn_len,
+                                         uint32_t isa_mask)
+{
+    memset(insnd, 0, sizeof(*insnd));
+    return find_format(insnd, insn, insn_len, isa_mask);
+}
+
+/*
+ * Calculate the instruction length for an instruction starting with
+ * MSB and LSB, the most and least significant byte. The ISA_MASK is
+ * used to filter the instructions considered to only those that are
+ * part of the current architecture.
+ *
+ * The instruction lengths are calculated from the ARC_OPCODE table,
+ * and cached for later use.
+ */
+unsigned int arc_insn_length(uint16_t insn, uint16_t cpu_type)
+{
+    uint8_t major_opcode;
+    uint8_t msb, lsb;
+
+    msb = (uint8_t)(insn >> 8);
+    lsb = (uint8_t)(insn & 0xFF);
+    major_opcode = msb >> 3;
+
+    switch (cpu_type) {
+    case ARC_OPCODE_ARC700:
+        if (major_opcode == 0xb) {
+            uint8_t minor_opcode = lsb & 0x1f;
+
+            if (minor_opcode < 4) {
+                return 6;
+            } else if (minor_opcode == 0x10 || minor_opcode == 0x11) {
+                return 8;
+            }
+        }
+        if (major_opcode == 0xa) {
+            return 8;
+        }
+        /* Fall through. */
+    case ARC_OPCODE_ARC600:
+        return (major_opcode > 0xb) ? 2 : 4;
+        break;
+
+    case ARC_OPCODE_ARCv2EM:
+    case ARC_OPCODE_ARCv2HS:
+        return (major_opcode > 0x7) ? 2 : 4;
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
+/* vim: set ts=4 sw=4 et: */
diff --git a/target/arc/decoder.h b/target/arc/decoder.h
new file mode 100644
index 0000000000..62fb1a57a1
--- /dev/null
+++ b/target/arc/decoder.h
@@ -0,0 +1,350 @@
+/*
+ * Decoder for the ARC.
+ * Copyright 2020 Free Software Foundation, Inc.
+ *
+ * QEMU ARCv2 Decoder.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef ARC_DECODER_H
+#define ARC_DECODER_H
+
+#include "qemu/osdep.h"
+#include "arc-common.h"
+
+#ifndef MAX_INSN_ARGS
+#define MAX_INSN_ARGS     16
+#endif
+
+#ifndef MAX_INSN_FLGS
+#define MAX_INSN_FLGS     4
+#endif
+
+/* Instruction Class. */
+typedef enum {
+    NADA = 0,
+    ARC_ACL,
+    ARITH,
+    AUXREG,
+    BBIT0,
+    BBIT1,
+    BI,
+    BIH,
+    BITOP,
+    BITSTREAM,
+    BMU,
+    BRANCH,
+    BRCC,
+    CONTROL,
+    DIVREM,
+    DPI,
+    DSP,
+    EI,
+    ENTER,
+    ARC_FLOAT,
+    INVALID,
+    JLI,
+    JUMP,
+    KERNEL,
+    LEAVE,
+    LOAD,
+    LOGICAL,
+    LOOP,
+    MEMORY,
+    MOVE,
+    MPY,
+    NET,
+    PROTOCOL_DECODE,
+    PMU,
+    POP,
+    PUSH,
+    SJLI,
+    STORE,
+    SUB,
+    XY
+} insn_class_t;
+
+/* Instruction Subclass. */
+typedef enum {
+    NONE     = 0,
+    CVT      = (1U << 1),
+    BTSCN    = (1U << 2),
+    CD       = (1U << 3),
+    CD1      = CD,
+    CD2      = CD,
+    COND     = (1U << 4),
+    DIV      = (1U << 5),
+    DP       = (1U << 6),
+    DPA      = (1U << 7),
+    DPX      = (1U << 8),
+    MPY1E    = (1U << 9),
+    MPY6E    = (1U << 10),
+    MPY7E    = (1U << 11),
+    MPY8E    = (1U << 12),
+    MPY9E    = (1U << 13),
+    QUARKSE1 = (1U << 15),
+    QUARKSE2 = (1U << 16),
+    SHFT1    = (1U << 17),
+    SHFT2    = (1U << 18),
+    SWAP     = (1U << 19),
+    SP       = (1U << 20),
+    SPX      = (1U << 21)
+} insn_subclass_t;
+
+/* Flags class. */
+typedef enum {
+    F_CLASS_NONE = 0,
+
+    /*
+     * At most one flag from the set of flags can appear in the
+     * instruction.
+     */
+    F_CLASS_OPTIONAL = (1 << 0),
+
+    /*
+     * Exactly one from from the set of flags must appear in the
+     * instruction.
+     */
+    F_CLASS_REQUIRED = (1 << 1),
+
+    /*
+     * The conditional code can be extended over the standard variants
+     * via .extCondCode pseudo-op.
+     */
+    F_CLASS_EXTEND = (1 << 2),
+
+    /* Condition code flag. */
+    F_CLASS_COND = (1 << 3),
+
+    /* Write back mode. */
+    F_CLASS_WB = (1 << 4),
+
+    /* Data size. */
+    F_CLASS_ZZ = (1 << 5),
+
+    /* Implicit flag. */
+    F_CLASS_IMPLICIT = (1 << 6),
+
+    F_CLASS_F = (1 << 7),
+
+    F_CLASS_DI = (1 << 8),
+
+    F_CLASS_X = (1 << 9),
+    F_CLASS_D = (1 << 10),
+
+} flag_class_t;
+
+/* The opcode table is an array of struct arc_opcode. */
+struct arc_opcode {
+    /* The opcode name. */
+    const char *name;
+
+    /*
+     * The opcode itself. Those bits which will be filled in with
+     * operands are zeroes.
+     */
+    unsigned long long opcode;
+
+    /*
+     * The opcode mask. This is used by the disassembler. This is a
+     * mask containing ones indicating those bits which must match the
+     * opcode field, and zeroes indicating those bits which need not
+     * match (and are presumably filled in by operands).
+     */
+    unsigned long long mask;
+
+    /*
+     * One bit flags for the opcode. These are primarily used to
+     * indicate specific processors and environments support the
+     * instructions. The defined values are listed below.
+     */
+    unsigned cpu;
+
+    /* The instruction class. */
+    insn_class_t insn_class;
+
+    /* The instruction subclass. */
+    insn_subclass_t subclass;
+
+    /*
+     * An array of operand codes. Each code is an index into the
+     * operand table. They appear in the order which the operands must
+     * appear in assembly code, and are terminated by a zero.
+     */
+    unsigned char operands[MAX_INSN_ARGS + 1];
+
+    /*
+     * An array of flag codes. Each code is an index into the flag
+     * table. They appear in the order which the flags must appear in
+     * assembly code, and are terminated by a zero.
+     */
+    unsigned char flags[MAX_INSN_FLGS + 1];
+};
+
+/* The operands table is an array of struct arc_operand. */
+struct arc_operand {
+    /* The number of bits in the operand. */
+    unsigned int bits;
+
+    /* How far the operand is left shifted in the instruction. */
+    unsigned int shift;
+
+    /* One bit syntax flags. */
+    unsigned int flags;
+
+    /*
+     * Extraction function. This is used by the disassembler. To
+     * extract this operand type from an instruction, check this
+     * field.
+     *
+     * If it is NULL, compute
+     * op = ((i) >> o->shift) & ((1 << o->bits) - 1);
+     * if ((o->flags & ARC_OPERAND_SIGNED) != 0
+     * && (op & (1 << (o->bits - 1))) != 0)
+     * op -= 1 << o->bits;
+     * (i is the instruction, o is a pointer to this structure, and op
+     * is the result; this assumes twos complement arithmetic).
+     *
+     * If this field is not NULL, then simply call it with the
+     * instruction value. It will return the value of the operand.
+     * If the INVALID argument is not NULL, *INVALID will be set to
+     * TRUE if this operand type can not actually be extracted from
+     * this operand (i.e., the instruction does not match). If the
+     * operand is valid, *INVALID will not be changed.
+     */
+    long long int (*extract) (unsigned long long instruction,
+                              bool *invalid);
+};
+
+extern const struct arc_operand arc_operands[];
+
+/* Values defined for the flags field of a struct arc_operand. */
+
+/*
+ * This operand does not actually exist in the assembler input. This
+ * is used to support extended mnemonics, for which two operands
+ * fields are identical. The assembler should call the insert
+ * function with any op value. The disassembler should call the
+ * extract function, ignore the return value, and check the value
+ * placed in the invalid argument.
+ */
+#define ARC_OPERAND_FAKE        0x0001
+
+/* This operand names an integer register. */
+#define ARC_OPERAND_IR          0x0002
+
+/* This operand takes signed values. */
+#define ARC_OPERAND_SIGNED      0x0004
+
+/*
+ * This operand takes unsigned values. This exists primarily so that
+ * a flags value of 0 can be treated as end-of-arguments.
+ */
+#define ARC_OPERAND_UNSIGNED    0x0008
+
+/* This operand takes short immediate values. */
+#define ARC_OPERAND_SHIMM   (ARC_OPERAND_SIGNED | ARC_OPERAND_UNSIGNED)
+
+/* This operand takes long immediate values. */
+#define ARC_OPERAND_LIMM        0x0010
+
+/* This operand is identical like the previous one. */
+#define ARC_OPERAND_DUPLICATE   0x0020
+
+/* This operand is PC relative. Used for internal relocs. */
+#define ARC_OPERAND_PCREL       0x0040
+
+/*
+ * This operand is truncated. The truncation is done accordingly to
+ * operand alignment attribute.
+ */
+#define ARC_OPERAND_TRUNCATE    0x0080
+
+/* This operand is 16bit aligned. */
+#define ARC_OPERAND_ALIGNED16   0x0100
+
+/* This operand is 32bit aligned. */
+#define ARC_OPERAND_ALIGNED32   0x0200
+
+/*
+ * This operand can be ignored by matching process if it is not
+ * present.
+ */
+#define ARC_OPERAND_IGNORE      0x0400
+
+/* Don't check the range when matching. */
+#define ARC_OPERAND_NCHK        0x0800
+
+/* Mark the braket possition. */
+#define ARC_OPERAND_BRAKET      0x1000
+
+/* Mask for selecting the type for typecheck purposes. */
+#define ARC_OPERAND_TYPECHECK_MASK               \
+    (ARC_OPERAND_IR                              \
+     | ARC_OPERAND_LIMM     | ARC_OPERAND_SIGNED \
+     | ARC_OPERAND_UNSIGNED | ARC_OPERAND_BRAKET)
+
+/* Macro to determine if an operand is a fake operand. */
+#define ARC_OPERAND_IS_FAKE(op)                     \
+    ((operand->flags & ARC_OPERAND_FAKE)            \
+     && !(operand->flags & ARC_OPERAND_BRAKET))
+
+/* The flags structure. */
+struct arc_flag_operand {
+    /* The flag name. */
+    const char *name;
+
+    /* The flag code. */
+    unsigned code;
+
+    /* The number of bits in the operand. */
+    unsigned int bits;
+
+    /* How far the operand is left shifted in the instruction. */
+    unsigned int shift;
+
+    /* Available for disassembler. */
+    unsigned char favail;
+};
+
+extern const struct arc_flag_operand arc_flag_operands[];
+
+/* The flag's class structure. */
+struct arc_flag_class {
+    /* Flag class. */
+    flag_class_t flag_class;
+
+    /* List of valid flags (codes). */
+    unsigned flags[256];
+};
+
+extern const struct arc_flag_class arc_flag_classes[];
+
+/* Structure for special cases. */
+struct arc_flag_special {
+    /* Name of special case instruction. */
+    const char *name;
+
+    /* List of flags applicable for special case instruction. */
+    unsigned flags[32];
+};
+
+extern const struct arc_flag_special arc_flag_special_cases[];
+extern const unsigned arc_num_flag_special;
+
+const struct arc_opcode *arc_find_format(insn_t*, uint64_t, uint8_t, uint32_t);
+unsigned int arc_insn_length(uint16_t, uint16_t);
+
+#endif
diff --git a/target/arc/flags.def b/target/arc/flags.def
new file mode 100644
index 0000000000..b6c3898698
--- /dev/null
+++ b/target/arc/flags.def
@@ -0,0 +1,85 @@
+/*
+ * QEMU ARC operands
+ *
+ * Copyright (c) 2020 Synopsys, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+ARC_FLAG(ALWAYS, "al", 0, 0, 0, 0)
+ARC_FLAG(RA, "ra", 0, 0, 0, 0)
+ARC_FLAG(EQUAL, "eq", 1, 5, 0, 1)
+ARC_FLAG(ZERO, "z", 1, 5, 0, 0)
+ARC_FLAG(NOTEQUAL, "ne", 2, 5, 0, 1)
+ARC_FLAG(NOTZERO, "nz", 2, 5, 0, 0)
+ARC_FLAG(POZITIVE, "p", 3, 5, 0, 1)
+ARC_FLAG(PL, "pl", 3, 5, 0, 0)
+ARC_FLAG(NEGATIVE, "n", 4, 5, 0, 1)
+ARC_FLAG(MINUS, "mi", 4, 5, 0, 0)
+ARC_FLAG(CARRY, "c", 5, 5, 0, 1)
+ARC_FLAG(CARRYSET, "cs", 5, 5, 0, 0)
+ARC_FLAG(LOWER, "lo", 5, 5, 0, 0)
+ARC_FLAG(CARRYCLR, "cc", 6, 5, 0, 0)
+ARC_FLAG(NOTCARRY, "nc", 6, 5, 0, 1)
+ARC_FLAG(HIGHER, "hs", 6, 5, 0, 0)
+ARC_FLAG(OVERFLOWSET, "vs", 7, 5, 0, 0)
+ARC_FLAG(OVERFLOW, "v", 7, 5, 0, 1)
+ARC_FLAG(NOTOVERFLOW, "nv", 8, 5, 0, 1)
+ARC_FLAG(OVERFLOWCLR, "vc", 8, 5, 0, 0)
+ARC_FLAG(GT, "gt", 9, 5, 0, 1)
+ARC_FLAG(GE, "ge", 10, 5, 0, 1)
+ARC_FLAG(LT, "lt", 11, 5, 0, 1)
+ARC_FLAG(LE, "le", 12, 5, 0, 1)
+ARC_FLAG(HI, "hi", 13, 5, 0, 1)
+ARC_FLAG(LS, "ls", 14, 5, 0, 1)
+ARC_FLAG(PNZ, "pnz", 15, 5, 0, 1)
+ARC_FLAG(FLAG, "f", 1, 1, 15, 1)
+ARC_FLAG(FFAKE, "f", 0, 0, 0, 1)
+ARC_FLAG(ND, "nd", 0, 1, 5, 0)
+ARC_FLAG(D, "d", 1, 1, 5, 1)
+ARC_FLAG(DFAKE, "d", 0, 0, 0, 1)
+ARC_FLAG(DNZ_ND, "nd", 0, 1, 16, 0)
+ARC_FLAG(DNZ_D, "d", 1, 1, 16, 1)
+ARC_FLAG(SIZEB1, "b", 1, 2, 1, 1)
+ARC_FLAG(SIZEB7, "b", 1, 2, 7, 1)
+ARC_FLAG(SIZEB17, "b", 1, 2, 17, 1)
+ARC_FLAG(SIZEW1, "w", 2, 2, 1, 0)
+ARC_FLAG(SIZEW7, "w", 2, 2, 7, 0)
+ARC_FLAG(SIZEW17, "w", 2, 2, 17, 0)
+ARC_FLAG(SIGN6, "x", 1, 1, 6, 1)
+ARC_FLAG(SIGN16, "x", 1, 1, 16, 1)
+ARC_FLAG(SIGNX, "x", 0, 0, 0, 1)
+ARC_FLAG(A3, "a", 1, 2, 3, 0)
+ARC_FLAG(A9, "a", 1, 2, 9, 0)
+ARC_FLAG(A22, "a", 1, 2, 22, 0)
+ARC_FLAG(AW3, "aw", 1, 2, 3, 1)
+ARC_FLAG(AW9, "aw", 1, 2, 9, 1)
+ARC_FLAG(AW22, "aw", 1, 2, 22, 1)
+ARC_FLAG(AB3, "ab", 2, 2, 3, 1)
+ARC_FLAG(AB9, "ab", 2, 2, 9, 1)
+ARC_FLAG(AB22, "ab", 2, 2, 22, 1)
+ARC_FLAG(AS3, "as", 3, 2, 3, 1)
+ARC_FLAG(AS9, "as", 3, 2, 9, 1)
+ARC_FLAG(AS22, "as", 3, 2, 22, 1)
+ARC_FLAG(ASFAKE, "as", 3, 0, 0, 1)
+ARC_FLAG(DI5, "di", 1, 1, 5, 1)
+ARC_FLAG(DI11, "di", 1, 1, 11, 1)
+ARC_FLAG(DI14, "di", 1, 1, 14, 1)
+ARC_FLAG(DI15, "di", 1, 1, 15, 1)
+ARC_FLAG(NT, "nt", 0, 1, 3, 1)
+ARC_FLAG(T, "t", 1, 1, 3, 1)
+ARC_FLAG(H1, "h", 2, 2, 1, 1)
+ARC_FLAG(H7, "h", 2, 2, 7, 1)
+ARC_FLAG(H17, "h", 2, 2, 17, 1)
+ARC_FLAG(SIZED, "dd", 3, 0, 0, 0)
+ARC_FLAG(NE, "ne", 0, 0, 0, 1)
diff --git a/target/arc/operands.def b/target/arc/operands.def
new file mode 100644
index 0000000000..34b15e0ec2
--- /dev/null
+++ b/target/arc/operands.def
@@ -0,0 +1,123 @@
+/*
+ * QEMU ARC operands
+ *
+ * Copyright (c) 2020 Synopsys, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+ARC_OPERAND(IGNORED, 0, 0, 0, ARC_OPERAND_IGNORE | ARC_OPERAND_UNSIGNED | ARC_OPERAND_NCHK, 0)
+ARC_OPERAND(RA, 6, 0, 0, ARC_OPERAND_IR, 0)
+ARC_OPERAND(RA_CHK, 6, 0, 0, ARC_OPERAND_IR, 0)
+ARC_OPERAND(RB, 6, 12, 0, ARC_OPERAND_IR, extract_rb)
+ARC_OPERAND(RB_CHK, 6, 12, 0, ARC_OPERAND_IR, extract_rb)
+ARC_OPERAND(RC, 6, 6, 0, ARC_OPERAND_IR, 0)
+ARC_OPERAND(RBdup, 6, 12, 0, ARC_OPERAND_IR | ARC_OPERAND_DUPLICATE, extract_rb)
+ARC_OPERAND(RAD, 6, 0, 0, ARC_OPERAND_IR | ARC_OPERAND_TRUNCATE, 0)
+ARC_OPERAND(RCD, 6, 6, 0, ARC_OPERAND_IR | ARC_OPERAND_TRUNCATE, 0)
+ARC_OPERAND(RA16, 4, 0, 0, ARC_OPERAND_IR, extract_ras)
+ARC_OPERAND(RA_S, 4, 0, 0, ARC_OPERAND_IR, extract_ras)
+ARC_OPERAND(RB16, 4, 8, 0, ARC_OPERAND_IR, extract_rbs)
+ARC_OPERAND(RB_S, 4, 8, 0, ARC_OPERAND_IR, extract_rbs)
+ARC_OPERAND(RB16dup, 4, 8, 0, ARC_OPERAND_IR | ARC_OPERAND_DUPLICATE, extract_rbs)
+ARC_OPERAND(RB_Sdup, 4, 8, 0, ARC_OPERAND_IR | ARC_OPERAND_DUPLICATE, extract_rbs)
+ARC_OPERAND(RC16, 4, 5, 0, ARC_OPERAND_IR, extract_rcs)
+ARC_OPERAND(RC_S, 4, 5, 0, ARC_OPERAND_IR, extract_rcs)
+ARC_OPERAND(R6H, 6, 5, 0, ARC_OPERAND_IR, extract_rhv1)
+ARC_OPERAND(R5H, 5, 5, 0, ARC_OPERAND_IR, extract_rhv2)
+ARC_OPERAND(RH_S, 5, 5, 0, ARC_OPERAND_IR, extract_rhv2)
+ARC_OPERAND(R5Hdup, 5, 5, 0, ARC_OPERAND_IR | ARC_OPERAND_DUPLICATE, extract_rhv2)
+ARC_OPERAND(RH_Sdup, 5, 5, 0, ARC_OPERAND_IR | ARC_OPERAND_DUPLICATE, extract_rhv2)
+ARC_OPERAND(RG, 5, 5, 0, ARC_OPERAND_IR, extract_g_s)
+ARC_OPERAND(G_S, 5, 5, 0, ARC_OPERAND_IR, extract_g_s)
+ARC_OPERAND(R0, 0, 0, 0, ARC_OPERAND_IR, extract_r0)
+ARC_OPERAND(R0_S, 0, 0, 0, ARC_OPERAND_IR, extract_r0)
+ARC_OPERAND(R1, 1, 0, 0, ARC_OPERAND_IR, extract_r1)
+ARC_OPERAND(R1_S, 1, 0, 0, ARC_OPERAND_IR, extract_r1)
+ARC_OPERAND(R2, 2, 0, 0, ARC_OPERAND_IR, extract_r2)
+ARC_OPERAND(R2_S, 2, 0, 0, ARC_OPERAND_IR, extract_r2)
+ARC_OPERAND(R3, 2, 0, 0, ARC_OPERAND_IR, extract_r3)
+ARC_OPERAND(R3_S, 2, 0, 0, ARC_OPERAND_IR, extract_r3)
+ARC_OPERAND(RSP, 5, 0, 0, ARC_OPERAND_IR, extract_sp)
+ARC_OPERAND(SP_S, 5, 0, 0, ARC_OPERAND_IR, extract_sp)
+ARC_OPERAND(SPdup, 5, 0, 0, ARC_OPERAND_IR | ARC_OPERAND_DUPLICATE, extract_sp)
+ARC_OPERAND(SP_Sdup, 5, 0, 0, ARC_OPERAND_IR | ARC_OPERAND_DUPLICATE, extract_sp)
+ARC_OPERAND(GP, 5, 0, 0, ARC_OPERAND_IR, extract_gp)
+ARC_OPERAND(GP_S, 5, 0, 0, ARC_OPERAND_IR, extract_gp)
+ARC_OPERAND(PCL_S, 1, 0, 0, ARC_OPERAND_IR | ARC_OPERAND_NCHK, extract_pcl)
+ARC_OPERAND(BLINK, 5, 0, 0, ARC_OPERAND_IR, extract_blink)
+ARC_OPERAND(BLINK_S, 5, 0, 0, ARC_OPERAND_IR, extract_blink)
+ARC_OPERAND(ILINK1, 5, 0, 0, ARC_OPERAND_IR, extract_ilink1)
+ARC_OPERAND(ILINK2, 5, 0, 0, ARC_OPERAND_IR, extract_ilink2)
+ARC_OPERAND(LIMM, 32, 0, 0, ARC_OPERAND_LIMM, 0)
+ARC_OPERAND(LIMM_S, 32, 0, 0, ARC_OPERAND_LIMM, 0)
+ARC_OPERAND(LIMMdup, 32, 0, 0, ARC_OPERAND_LIMM | ARC_OPERAND_DUPLICATE, 0)
+ARC_OPERAND(ZA, 0, 0, 0, ARC_OPERAND_UNSIGNED, 0)
+ARC_OPERAND(ZB, 0, 0, 0, ARC_OPERAND_UNSIGNED, 0)
+ARC_OPERAND(ZA_S, 0, 0, 0, ARC_OPERAND_UNSIGNED, 0)
+ARC_OPERAND(ZB_S, 0, 0, 0, ARC_OPERAND_UNSIGNED, 0)
+ARC_OPERAND(ZC_S, 0, 0, 0, ARC_OPERAND_UNSIGNED, 0)
+ARC_OPERAND(RRANGE_EL, 4, 0, 0, ARC_OPERAND_UNSIGNED | ARC_OPERAND_NCHK | ARC_OPERAND_TRUNCATE, extract_rrange)
+ARC_OPERAND(R13_EL, 1, 0, 0, ARC_OPERAND_IR | ARC_OPERAND_IGNORE | ARC_OPERAND_NCHK, extract_rrange)
+ARC_OPERAND(FP_EL, 1, 0, 0, ARC_OPERAND_IR | ARC_OPERAND_IGNORE | ARC_OPERAND_NCHK, extract_fpel)
+ARC_OPERAND(BLINK_EL, 1, 0, 0, ARC_OPERAND_IR | ARC_OPERAND_IGNORE | ARC_OPERAND_NCHK, extract_blinkel)
+ARC_OPERAND(PCL_EL, 1, 0, 0, ARC_OPERAND_IR | ARC_OPERAND_IGNORE | ARC_OPERAND_NCHK, extract_pclel)
+ARC_OPERAND(BRAKET, 0, 0, 0, ARC_OPERAND_FAKE | ARC_OPERAND_BRAKET, 0)
+ARC_OPERAND(BRAKETdup, 0, 0, 0, ARC_OPERAND_FAKE | ARC_OPERAND_BRAKET, 0)
+ARC_OPERAND(FKT_T, 1, 3, 0, ARC_OPERAND_FAKE, 0)
+ARC_OPERAND(FKT_NT, 1, 3, 0, ARC_OPERAND_FAKE, 0)
+ARC_OPERAND(UIMM6_20, 6, 0, 0, ARC_OPERAND_UNSIGNED, extract_uimm6_20)
+ARC_OPERAND(UIMM6_20R, 6, 0, 0, ARC_OPERAND_UNSIGNED | ARC_OPERAND_PCREL, extract_uimm6_20)
+ARC_OPERAND(SIMM12_20, 12, 0, 0, ARC_OPERAND_SIGNED, extract_simm12_20)
+ARC_OPERAND(SIMM12_20R, 12, 0, 0, ARC_OPERAND_SIGNED | ARC_OPERAND_PCREL, extract_simm12_20)
+ARC_OPERAND(UIMM12_20, 12, 0, 0, ARC_OPERAND_UNSIGNED, extract_uimm12_20)
+ARC_OPERAND(SIMM3_5_S, 3, 0, 0, ARC_OPERAND_SIGNED | ARC_OPERAND_NCHK, extract_simm3s)
+ARC_OPERAND(UIMM7_A32_11_S, 7, 0, 0, ARC_OPERAND_UNSIGNED | ARC_OPERAND_ALIGNED32 | ARC_OPERAND_TRUNCATE | ARC_OPERAND_IGNORE, extract_uimm7_a32_11_s)
+ARC_OPERAND(UIMM7_A32_11R_S, 7, 0, 0, ARC_OPERAND_UNSIGNED | ARC_OPERAND_ALIGNED32 | ARC_OPERAND_TRUNCATE | ARC_OPERAND_IGNORE | ARC_OPERAND_PCREL, extract_uimm7_a32_11_s)
+ARC_OPERAND(UIMM7_9_S, 7, 0, 0, ARC_OPERAND_UNSIGNED, extract_uimm7_9_s)
+ARC_OPERAND(UIMM3_13_S, 3, 0, 0, ARC_OPERAND_UNSIGNED, extract_uimm3_13_s)
+ARC_OPERAND(UIMM3_13R_S, 3, 0, -UIMM3_13R_S, ARC_OPERAND_UNSIGNED | ARC_OPERAND_PCREL, extract_uimm3_13_s)
+ARC_OPERAND(SIMM11_A32_7_S, 11, 0, 0, ARC_OPERAND_SIGNED | ARC_OPERAND_ALIGNED32 | ARC_OPERAND_TRUNCATE, extract_simm11_a32_7_s)
+ARC_OPERAND(UIMM6_13_S, 6, 0, 0, ARC_OPERAND_UNSIGNED, extract_uimm6_13_s)
+ARC_OPERAND(UIMM5_11_S, 5, 0, 0, ARC_OPERAND_UNSIGNED | ARC_OPERAND_IGNORE, extract_uimm5_11_s)
+ARC_OPERAND(SIMM9_A16_8, 9, 0, -SIMM9_A16_8, ARC_OPERAND_SIGNED | ARC_OPERAND_ALIGNED16 | ARC_OPERAND_PCREL | ARC_OPERAND_TRUNCATE, extract_simm9_a16_8)
+ARC_OPERAND(UIMM6_8, 6, 0, 0, ARC_OPERAND_UNSIGNED, extract_uimm6_8)
+ARC_OPERAND(SIMM21_A16_5, 21, 0, 0, ARC_OPERAND_SIGNED | ARC_OPERAND_ALIGNED16 | ARC_OPERAND_TRUNCATE | ARC_OPERAND_PCREL, extract_simm21_a16_5)
+ARC_OPERAND(SIMM25_A16_5, 25, 0, 0, ARC_OPERAND_SIGNED | ARC_OPERAND_ALIGNED16 | ARC_OPERAND_TRUNCATE | ARC_OPERAND_PCREL, extract_simm25_a16_5)
+ARC_OPERAND(SIMM10_A16_7_S, 10, 0, 0, ARC_OPERAND_SIGNED | ARC_OPERAND_ALIGNED16 | ARC_OPERAND_TRUNCATE | ARC_OPERAND_PCREL, extract_simm10_a16_7_s)
+ARC_OPERAND(SIMM10_A16_7_Sbis, 10, 0, 0, ARC_OPERAND_SIGNED | ARC_OPERAND_ALIGNED16 | ARC_OPERAND_TRUNCATE, extract_simm10_a16_7_s)
+ARC_OPERAND(SIMM7_A16_10_S, 7, 0, 0, ARC_OPERAND_SIGNED | ARC_OPERAND_ALIGNED16 | ARC_OPERAND_TRUNCATE | ARC_OPERAND_PCREL, extract_simm7_a16_10_s)
+ARC_OPERAND(SIMM21_A32_5, 21, 0, 0, ARC_OPERAND_SIGNED | ARC_OPERAND_ALIGNED32 | ARC_OPERAND_TRUNCATE | ARC_OPERAND_PCREL, extract_simm21_a32_5)
+ARC_OPERAND(SIMM25_A32_5, 25, 0, 0, ARC_OPERAND_SIGNED | ARC_OPERAND_ALIGNED32 | ARC_OPERAND_TRUNCATE | ARC_OPERAND_PCREL, extract_simm25_a32_5)
+ARC_OPERAND(SIMM13_A32_5_S, 13, 0, 0, ARC_OPERAND_SIGNED | ARC_OPERAND_ALIGNED32 | ARC_OPERAND_TRUNCATE | ARC_OPERAND_PCREL, extract_simm13_a32_5_s)
+ARC_OPERAND(SIMM8_A16_9_S, 8, 0, 0, ARC_OPERAND_SIGNED | ARC_OPERAND_ALIGNED16 | ARC_OPERAND_TRUNCATE | ARC_OPERAND_PCREL, extract_simm8_a16_9_s)
+ARC_OPERAND(UIMM10_6_S_JLIOFF, 12, 0, 0, ARC_OPERAND_UNSIGNED | ARC_OPERAND_ALIGNED32 | ARC_OPERAND_TRUNCATE, extract_uimm10_6_s)
+ARC_OPERAND(UIMM3_23, 3, 0, 0, ARC_OPERAND_UNSIGNED, extract_uimm3_23)
+ARC_OPERAND(UIMM10_6_S, 10, 0, 0, ARC_OPERAND_UNSIGNED, extract_uimm10_6_s)
+ARC_OPERAND(UIMM6_11_S, 6, 0, 0, ARC_OPERAND_UNSIGNED, extract_uimm6_11_s)
+ARC_OPERAND(SIMM9_8, 9, 0, 0, ARC_OPERAND_SIGNED | ARC_OPERAND_IGNORE, extract_simm9_8)
+ARC_OPERAND(SIMM9_8R, 9, 0, -SIMM9_8R, ARC_OPERAND_SIGNED | ARC_OPERAND_IGNORE | ARC_OPERAND_PCREL, extract_simm9_8)
+ARC_OPERAND(UIMM10_A32_8_S, 10, 0, -UIMM10_A32_8_S, ARC_OPERAND_UNSIGNED | ARC_OPERAND_ALIGNED32 | ARC_OPERAND_TRUNCATE | ARC_OPERAND_PCREL, extract_uimm10_a32_8_s)
+ARC_OPERAND(SIMM9_7_S, 9, 0, 0, ARC_OPERAND_SIGNED, extract_simm9_7_s)
+ARC_OPERAND(UIMM6_A16_11_S, 6, 0, 0, ARC_OPERAND_UNSIGNED | ARC_OPERAND_ALIGNED16 | ARC_OPERAND_TRUNCATE | ARC_OPERAND_IGNORE, extract_uimm6_a16_11_s)
+ARC_OPERAND(UIMM5_A32_11_S, 5, 0, 0, ARC_OPERAND_UNSIGNED | ARC_OPERAND_ALIGNED32 | ARC_OPERAND_TRUNCATE | ARC_OPERAND_IGNORE, extract_uimm5_a32_11_s)
+ARC_OPERAND(SIMM11_A32_13_S, 11, 0, 0, ARC_OPERAND_SIGNED | ARC_OPERAND_ALIGNED32 | ARC_OPERAND_TRUNCATE, extract_simm11_a32_13_s)
+ARC_OPERAND(UIMM7_13_S, 7, 0, 0, ARC_OPERAND_UNSIGNED, extract_uimm7_13_s)
+ARC_OPERAND(UIMM6_A16_21, 6, 0, 0, ARC_OPERAND_UNSIGNED | ARC_OPERAND_ALIGNED16 | ARC_OPERAND_TRUNCATE, extract_uimm6_a16_21)
+ARC_OPERAND(UIMM7_11_S, 7, 0, 0, ARC_OPERAND_UNSIGNED, extract_uimm7_11_s)
+ARC_OPERAND(UIMM7_A16_20, 7, 0, -UIMM7_A16_20, ARC_OPERAND_UNSIGNED | ARC_OPERAND_ALIGNED16 | ARC_OPERAND_TRUNCATE | ARC_OPERAND_PCREL, extract_uimm7_a16_20)
+ARC_OPERAND(SIMM13_A16_20, 13, 0, -SIMM13_A16_20, ARC_OPERAND_SIGNED | ARC_OPERAND_ALIGNED16 | ARC_OPERAND_TRUNCATE | ARC_OPERAND_PCREL, extract_simm13_a16_20)
+ARC_OPERAND(UIMM8_8_S, 8, 0, 0, ARC_OPERAND_UNSIGNED, extract_uimm8_8_s)
+ARC_OPERAND(UIMM8_8R_S, 8, 0, 0, ARC_OPERAND_UNSIGNED | ARC_OPERAND_PCREL, extract_uimm8_8_s)
+ARC_OPERAND(W6, 6, 0, 0, ARC_OPERAND_SIGNED, extract_w6)
+ARC_OPERAND(UIMM6_5_S, 6, 0, 0, ARC_OPERAND_UNSIGNED, extract_uimm6_5_s)
-- 
2.20.1


