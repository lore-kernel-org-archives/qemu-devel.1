Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EF7C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 13:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2801E20645
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 13:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2801E20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kent.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56594 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMuc3-0003f2-2d
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 09:21:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <S.E.Harris@kent.ac.uk>) id 1hMqDQ-0007Xe-2H
	for qemu-devel@nongnu.org; Sat, 04 May 2019 04:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <S.E.Harris@kent.ac.uk>) id 1hMqDN-0002wU-12
	for qemu-devel@nongnu.org; Sat, 04 May 2019 04:40:16 -0400
Received: from mx0.kent.ac.uk ([129.12.21.32]:43691)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <S.E.Harris@kent.ac.uk>)
	id 1hMqDM-0002uX-NC
	for qemu-devel@nongnu.org; Sat, 04 May 2019 04:40:12 -0400
Received: from banach.kent.ac.uk ([129.12.41.70])
	by mx0.kent.ac.uk with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
	(envelope-from <S.E.Harris@kent.ac.uk>)
	id 1hMqDJ-000Jin-6v; Sat, 04 May 2019 09:40:09 +0100
From: Sarah Harris <S.E.Harris@kent.ac.uk>
To: qemu-devel@nongnu.org
Date: Sat,  4 May 2019 09:36:31 +0100
Message-Id: <20190504083638.13380-2-S.E.Harris@kent.ac.uk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504083638.13380-1-S.E.Harris@kent.ac.uk>
References: <20190504083638.13380-1-S.E.Harris@kent.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 129.12.21.32
X-Mailman-Approved-At: Sat, 04 May 2019 09:20:02 -0400
Subject: [Qemu-devel] [PATCH v1 1/8] target/avr: Add instruction decoder
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: S.E.Harris@kent.ac.uk, mrolnik@gmail.com, A.M.King@kent.ac.uk,
	E.J.C.Robbins@kent.ac.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504083631.QWRH5kKepUiTZpCw_WCkttPfmBuIXqx-JmfTIt0X-lI@z>

This utility module builds a decision tree to decode instructions, starting from a human readable list of instruction bit patterns.
Automatic tree generation will hopefully be more efficient and more maintainable than a hand-designed opcode parser.

Tree generation happens at startup because this seemed simpler to implement than adding a new build step.

Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
---
 target/avr/decode.c | 441 ++++++++++++++++++++++++++++++++++++++++++++
 target/avr/decode.h |  68 +++++++
 2 files changed, 509 insertions(+)
 create mode 100644 target/avr/decode.c
 create mode 100644 target/avr/decode.h

diff --git a/target/avr/decode.c b/target/avr/decode.c
new file mode 100644
index 0000000000..a984806d96
--- /dev/null
+++ b/target/avr/decode.c
@@ -0,0 +1,441 @@
+/*
+ * AVR instruction decoder.
+ *
+ * Copyright (c) 2019 University of Kent
+ * Author: Sarah Harris
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+/*
+ * # Why is this here?
+ * This decoder takes a list of human readable descriptions of instructions
+ * and uses it to build a binary decision tree used to choose translation
+ * functions for opcodes.
+ * It's built like this because figuring out the structure of AVR instructions
+ * was too hard and writing a Big Nested Switch by hand seemed too painful.
+ * This seems to be the simplest answer that doesn't use loads (>0.5MB) of RAM.
+ *
+ * # How does it work?
+ * This is based J. R. Quinlan's ID3 algorithm, tweaked to add weights to each
+ * instruction.
+ * Having a binary tree branch on opcode bits seems obvious, but the awkward
+ * part is deciding which order to test the bits.
+ * Getting the order right means that redundant bits can be ignored and fewer
+ * branches are needed; i.e. less memory and faster lookups.
+ * Here, the tests are ordered by an estimate of information gain based on
+ * Shannon Entropy.
+ * In short, we guess how much each bit tells us and pick the one that gives
+ * us most progress toward knowing which instruction we're seeing.
+ * The weights are currently only used to prioritise legal opcodes over
+ * illegal opcodes, which significantly reduces the tree size.
+ *
+ * # Why are you doing this at run time?
+ * It was easier than building and running a special purpose tool during
+ * QEMU's build process.
+ * The tree is only built once, during startup, and hopefully doesn't take long
+ * enough to be noticeable.
+ */
+
+#include <math.h>
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/error-report.h"
+#include "decode.h"
+
+/* #define DEBUG_DECODER */
+
+/* Wide enough for the largest AVR instruction. */
+#define OPCODE_T uint16_t
+#define OPCODE_SIZE 16
+
+/*
+ * Probability estimate for each instruction.
+ * Larger values mean higher priority.
+ */
+#define WEIGHT_T uint64_t
+#define WEIGHT_LEGAL (1 << 16)
+#define WEIGHT_ILLEGAL 1
+
+typedef union Tree Tree;
+
+typedef struct {
+    bool is_leaf;
+    /* Bit to test */
+    uint bit;
+    const Tree *zero;
+    const Tree *one;
+} Branch;
+
+typedef struct {
+    bool is_leaf;
+    TranslateFn decoder;
+    /* Instruction length in bits */
+    uint32_t length;
+    const char *name;
+} Leaf;
+
+union Tree {
+    bool is_leaf;
+    Branch branch;
+    Leaf leaf;
+};
+
+/* Additional (generated) instruction data */
+typedef struct {
+    const Instruction *instruction;
+    /* Instruction length in bits */
+    uint32_t length;
+    WEIGHT_T weight;
+    /*
+     * Bit pattern matched in opcodes.
+     * For each 1 in mask, the same bit in the opcode must match that from bits.
+     */
+    OPCODE_T bits;
+    OPCODE_T mask;
+} Pattern;
+
+/* Cached decoding tree */
+Tree *cache;
+
+/* Return calculated bit pattern and length for an instruction */
+static Pattern get_info(const Instruction *instruction)
+{
+    OPCODE_T bit = 1 << (OPCODE_SIZE - 1);
+    OPCODE_T bits = 0;
+    OPCODE_T mask = 0;
+    uint32_t length = 0;
+    const char *c = instruction->pattern;
+    while (*c != '\0') {
+        switch (*c) {
+        case '0':
+            mask |= bit;
+            bit >>= 1;
+            length++;
+            break;
+        case '1':
+            bits |= bit;
+            mask |= bit;
+            bit >>= 1;
+            length++;
+            break;
+        case '*':
+            bit >>= 1;
+            length++;
+            break;
+        case '_':
+            /* NOP */
+            break;
+        default:
+            assert(0);
+        }
+        c++;
+    }
+    const Pattern pattern = {
+        .instruction = instruction,
+        .length = length,
+        .weight = WEIGHT_LEGAL,
+        .bits = bits,
+        .mask = mask
+    };
+    return pattern;
+}
+
+/* Return true if an instruction matches a pattern of known/unknown bits */
+static bool matches(const Pattern *const pattern, const OPCODE_T bits,
+    const OPCODE_T mask)
+{
+    OPCODE_T overlap = pattern->mask & mask;
+    return (pattern->bits & overlap) == (bits & overlap);
+}
+
+/* Return number of instructions that match a pattern of known/unknown bits */
+static size_t count_legal(const Pattern *patterns, const size_t size,
+    const OPCODE_T bits, const OPCODE_T mask)
+{
+    size_t sum = 0;
+    size_t i;
+    for (i = 0; i < size; i++) {
+        if (matches(&patterns[i], bits, mask)) {
+            sum++;
+        }
+    }
+    return sum;
+}
+
+/* Return the number of opcodes that could match a bit pattern */
+static uint64_t count_opcodes(const OPCODE_T _bits, OPCODE_T mask)
+{
+    uint64_t matches = 1;
+    int i;
+    assert(sizeof(matches) * 8 > OPCODE_SIZE);
+    for (i = 0; i < OPCODE_SIZE; i++) {
+        if (!(mask & 1)) {
+            matches <<= 1;
+        }
+        mask >>= 1;
+    }
+    return matches;
+}
+
+/*
+ * Return a known/unknown bit pattern that only matches opcodes matched by both
+ * of the given patterns.
+ */
+static void intersection(const OPCODE_T a_bits, const OPCODE_T a_mask,
+    const OPCODE_T b_bits, const OPCODE_T b_mask,
+    OPCODE_T *const out_bits, OPCODE_T *const out_mask)
+{
+    const OPCODE_T overlap = a_mask & b_mask;
+    /* The two patterns mustn't have conflicting requirements */
+    assert((a_bits & overlap) == (b_bits & overlap));
+    *out_bits = (a_bits & a_mask) | (b_bits & b_mask);
+    *out_mask = a_mask | b_mask;
+}
+
+/*
+ * Return one if any opcode allowed by a pattern of known/unknown bits is
+ * illegal.
+ */
+static size_t count_illegal(const Pattern *patterns, const size_t size,
+    const OPCODE_T bits, const OPCODE_T mask)
+{
+    size_t i;
+    const uint64_t no_opcodes = count_opcodes(bits, mask);
+    uint64_t no_legal = 0;
+
+    /* Count opcodes that match instructions */
+    for (i = 0; i < size; i++) {
+        const Pattern *pattern = &patterns[i];
+        if (matches(pattern, bits, mask)) {
+            OPCODE_T both_bits, both_mask;
+            intersection(
+                bits, mask,
+                pattern->bits, pattern->mask,
+                &both_bits, &both_mask
+            );
+            no_legal += count_opcodes(both_bits, both_mask);
+        }
+    }
+
+    assert(no_legal <= no_opcodes);
+    if (no_legal == no_opcodes) {
+        return 0;
+    } else {
+        return 1;
+    }
+}
+
+/* Return the first matching instruction for a pattern of known/unknown bits */
+static const Pattern *find_match(const Pattern *patterns, const size_t size,
+    const OPCODE_T bits, const OPCODE_T mask)
+{
+    size_t i;
+    for (i = 0; i < size; i++) {
+        if (matches(&patterns[i], bits, mask)) {
+            return &patterns[i];
+        }
+    }
+    return NULL;
+}
+
+/* Return sum of weights of instructions that match a bit pattern */
+static WEIGHT_T weigh_matches(const Pattern *patterns, const size_t size,
+    const OPCODE_T bits, const OPCODE_T mask)
+{
+    size_t i;
+    WEIGHT_T illegal = (WEIGHT_T)count_illegal(patterns, size, bits, mask)
+        * WEIGHT_ILLEGAL;
+    WEIGHT_T legal = 0;
+    for (i = 0; i < size; i++) {
+        if (matches(&patterns[i], bits, mask)) {
+            legal += patterns[i].weight;
+        }
+    }
+    return legal + illegal;
+}
+
+/*
+ * Return "effort" (estimated information needed) to decide tree outcome.
+ * bits and mask give the opcode bits already decided by the parent tree.
+ * parent_weight gives the sum of the weights of instructions that the
+ * parent tree matches.
+ */
+static float subtree_effort(const Pattern *patterns, const size_t size,
+    const OPCODE_T bits, const OPCODE_T mask, const WEIGHT_T parent_weight)
+{
+    const WEIGHT_T weight = weigh_matches(patterns, size, bits, mask);
+    float entropy_legal, entropy_illegal, probability;
+    size_t i;
+
+    /* Sum information needed to decide legal instructions */
+    entropy_legal = 0.0;
+    for (i = 0; i < size; i++) {
+        const Pattern *const pattern = &patterns[i];
+        if (matches(pattern, bits, mask)) {
+            probability = (float)pattern->weight / (float)weight;
+            entropy_legal += -probability * log2(probability);
+        }
+    }
+
+    /* Sum information needed to decide illegal instructions */
+    probability = (float)WEIGHT_ILLEGAL / (float)weight;
+    entropy_illegal = -probability * log2(probability) *
+        (float)count_illegal(patterns, size, bits, mask);
+
+    return ((float)weight / (float)parent_weight) *
+        (entropy_legal + entropy_illegal);
+}
+
+/* Return recursively built binary tree for decoding an opcode to instruction */
+static Tree *build_tree(const Pattern *patterns, const size_t size,
+    OPCODE_T bits, OPCODE_T mask)
+{
+    /* Check if we've reached a leaf */
+    size_t matching_illegal = count_illegal(patterns, size, bits, mask);
+    size_t matching_legal = count_legal(patterns, size, bits, mask);
+    size_t matching = matching_illegal + matching_legal;
+    assert(matching > 0); /* At last an illegal instruction should match */
+    if (matching_legal == 0) {
+        /* Illegal instruction */
+        Leaf *leaf = g_new0(Leaf, 1);
+        leaf->is_leaf = true;
+        leaf->decoder = NULL;
+        leaf->length = 16;
+        leaf->name = "illegal";
+        return (Tree *)leaf;
+    }
+    if (matching_legal == 1 && matching_illegal == 0) {
+        /* Legal instruction */
+        const Pattern *pattern = find_match(patterns, size, bits, mask);
+        assert(pattern != NULL);
+        const Instruction *const instruction = pattern->instruction;
+        Leaf *leaf = g_new0(Leaf, 1);
+        leaf->is_leaf = true;
+        leaf->decoder = instruction->decoder;
+        leaf->length = pattern->length;
+        leaf->name = instruction->name;
+        return (Tree *)leaf;
+    }
+
+    /* Work out which bit to branch on */
+    const WEIGHT_T tree_weight = weigh_matches(patterns, size, bits, mask);
+    float min_effort = 0.0;
+    ssize_t min_bit = -1;
+    size_t i;
+    for (i = 0; i < OPCODE_SIZE; i++) {
+        float effort;
+        const OPCODE_T bit = 1 << i;
+        if (mask & bit) {
+            /* This bit already branched on, skip */
+            continue;
+        }
+        effort = subtree_effort(patterns, size, bits, mask | bit, tree_weight) +
+            subtree_effort(patterns, size, bits | bit, mask | bit, tree_weight);
+        if (min_bit < 0 || effort < min_effort) {
+            min_bit = i;
+            min_effort = effort;
+        }
+    }
+
+    /*
+     * Setup branch on bit that gives most information gain.
+     * (AKA minimum information/effort needed to decide remaining branches.
+     */
+    assert(min_bit >= 0); /* Probably multiple instructions match one opcode */
+    const OPCODE_T bit = 1 << min_bit;
+    const Tree *zero = build_tree(patterns, size, bits, mask | bit);
+    const Tree *one = build_tree(patterns, size, bits | bit, mask | bit);
+    Branch *branch = g_new0(Branch, 1);
+    branch->is_leaf = false;
+    branch->bit = min_bit;
+    branch->zero = zero;
+    branch->one = one;
+    return (Tree *)branch;
+}
+
+#ifdef DEBUG_DECODER
+static size_t depth(const Tree *const tree);
+static size_t depth(const Tree *const tree)
+{
+    if (tree->is_leaf) {
+        return 1;
+    }
+    size_t zero = depth(tree->branch.zero);
+    size_t one = depth(tree->branch.one);
+    if (zero > one) {
+        return zero + 1;
+    }
+    return one + 1;
+}
+static size_t count(const Tree *const tree);
+static size_t count(const Tree *const tree)
+{
+    if (tree->is_leaf) {
+        return 1;
+    }
+    return 1 + count(tree->branch.zero) + count(tree->branch.one);
+}
+#endif
+
+void avr_decoder_init(const Instruction instructions[], const size_t size)
+{
+    assert(cache == NULL); /* Shouldn't be initialised more than once */
+    Pattern *const patterns = g_new0(Pattern, size);
+    size_t i;
+    for (i = 0; i < size; i++) {
+        patterns[i] = get_info(&instructions[i]);
+    }
+    cache = build_tree(patterns, size, 0, 0);
+    g_free(patterns);
+#ifdef DEBUG_DECODER
+    printf("AVR decoder init, depth=%lu, size=%lu\n",
+        depth(cache), count(cache));
+#endif
+}
+
+TranslateFn avr_decode(const uint32_t opcode, uint32_t *const length_out)
+{
+    assert(cache != NULL); /* Must be initialised */
+    const Tree *node = cache;
+    while (1) {
+        assert(node != NULL);
+        if (node->is_leaf) {
+            const Leaf *const leaf = &node->leaf;
+            if (leaf->decoder == NULL) {
+                /* Illegal instruction */
+                error_report("Illegal AVR instruction");
+                exit(1);
+            }
+#ifdef DEBUG_DECODER
+            printf("AVR decoder: %s\n", leaf->name);
+#endif
+            *length_out = leaf->length;
+            return leaf->decoder;
+        } else {
+            const Branch *const branch = &node->branch;
+            const OPCODE_T mask = 1 << branch->bit;
+            if (opcode & mask) {
+                node = branch->one;
+            } else {
+                node = branch->zero;
+            }
+        }
+    }
+}
diff --git a/target/avr/decode.h b/target/avr/decode.h
new file mode 100644
index 0000000000..415406544a
--- /dev/null
+++ b/target/avr/decode.h
@@ -0,0 +1,68 @@
+/*
+ * AVR instruction decoder.
+ *
+ * Copyright (c) 2019 University of Kent
+ * Author: Sarah Harris
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef AVR_DECODER_H
+#define AVR_DECODER_H
+
+/* Pointer to functions used to do final decoding step from opcode to TCG. */
+typedef struct DisasContext DisasContext;
+typedef int (*TranslateFn)(DisasContext *ctx, uint32_t opcode);
+
+/*
+ * Human readable instruction descriptions used to generate decoder.
+ * Doing this at runtime avoids a complicated new build step.
+ */
+typedef struct {
+    /* Instruction mnemonic for debugging */
+    const char *name;
+    /*
+     * Bit pattern describing the instruction's opcode.
+     * Each character represents a bit:
+     * - '1' means bit must be set
+     * - '0' means bit must be cleared
+     * - '*' means don't care
+     * - '_' is ignored (i.e. whitespace), please use to aid readability
+     */
+    const char *pattern;
+    /* Function used to translate this instruction to TCG */
+    TranslateFn decoder;
+} Instruction;
+
+/*
+ * Converts a list of instruction descriptions to a decoding tree
+ * and caches it.
+ * Must only be called once.
+ * `size` is the number of instructions in the given list.
+ */
+void avr_decoder_init(const Instruction instructions[], const size_t size);
+
+/*
+ * Returns the translation function and length of an instruction, given
+ * the opcode.
+ * avr_decoder_init() must be called first to build the decoding tree.
+ */
+TranslateFn avr_decode(const uint32_t opcode, uint32_t *const length_out);
+
+#endif /* AVR_DECODER_H */
-- 
2.21.0


