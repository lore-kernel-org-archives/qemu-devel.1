Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B8EC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A79205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="e6e8wz93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A79205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58158 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNfTV-0000ck-O1
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 11:24:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34776)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<4e8909855bf1e506509a0c7b05f43b9bff5a4b8b@lizzy.crudebyte.com>)
	id 1hNfRq-0007zt-Jz
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<4e8909855bf1e506509a0c7b05f43b9bff5a4b8b@lizzy.crudebyte.com>)
	id 1hNfRm-0004TF-Qq
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:22:34 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:48335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<4e8909855bf1e506509a0c7b05f43b9bff5a4b8b@lizzy.crudebyte.com>)
	id 1hNfRm-0003sY-B0
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=lizzy;
	h=Subject:Date:Cc:To:From:References:In-Reply-To:
	Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DgqYvtZ/ZocBTpxXmwLIg5LVGY0P+oxkrH7DqViKxvo=;
	b=e6e8wz935CF3Z98dpamP+Rc9c
	840u7XcsbVdR8qXKcZ6TeIAchCXB80Z1Ia6bzvD8u72n++7x8o38lWdy4fyiWV2aX6Wjf+xX3F/Oo
	gcg/Vjd2XtfJ0evrjKIrvPjAormC1pORUsrNx7l/LJNNEvWPO0hsn3PiT2fcpMbyUw5x4O85xAvJD
	De5EBiAFR3qpCyWm2+jjQDnh2G7xrGsqs8BKjGxPWOMibYi8mu6XTNO3I/Cle0FLuJDRjwMo0K/b6
	vCpXBs1nfonibqS8V23Jt3NYTPFclIif10+f1jXXPwGd9uX8RGTaj9S/yGh1D99IgJuBq+2SMsYJy
	Atuyl3OIw==;
Message-Id: <4e8909855bf1e506509a0c7b05f43b9bff5a4b8b.1557093245.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1557093245.git.qemu_oss@crudebyte.com>
References: <cover.1557093245.git.qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Date: Fri, 3 May 2019 16:51:20 +0200
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
Subject: [Qemu-devel] [PATCH v3 4/5] 9p: use variable length suffixes for
 inode mapping
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch introduces variable length suffixes for being used for inode mapping
instead of the fixed 16 bit size prefixes of patch 1. With this patch the inode
numbers on guest will typically be much smaller (e.g. around >2^1 .. >2^7
instead of >2^48 with patch 1).

I preserved both solutions in this patch though, so you can switch between
them by adjusting P9_VARI_LENGTH_INODE_SUFFIXES, which probably also makes
code comparison between the two more easy for now.

Motivation: with patch 1 the inode numbers were so high that some network
services had issues. Especially SMB seems to be a problem again due to varying
implementations regarding SMB file IDs. I don't bother you with the details.

Additionally this solution should be more efficient, since inode numbers in
practice can take almost their entire 64 bit range on guest as well. Which
might also be beneficial for nested virtualization.

The "Exponential Golomb" algorithm is used as basis for generating the
variable length suffixes. The algorithm has a paramter k which controls the
distribution of bits on increasing indeces (minimum bits at low index vs.
maximum bits at high index). With k=0 the generated suffixes look like:

Index Dec/Bin -> Generated Suffix Bin
1 [1] -> [1] (1 bits)
2 [10] -> [010] (3 bits)
3 [11] -> [110] (3 bits)
4 [100] -> [00100] (5 bits)
5 [101] -> [10100] (5 bits)
6 [110] -> [01100] (5 bits)
7 [111] -> [11100] (5 bits)
8 [1000] -> [0001000] (7 bits)
9 [1001] -> [1001000] (7 bits)
10 [1010] -> [0101000] (7 bits)
11 [1011] -> [1101000] (7 bits)
12 [1100] -> [0011000] (7 bits)
...
65533 [1111111111111101] ->  [1011111111111111000000000000000] (31 bits)
65534 [1111111111111110] ->  [0111111111111111000000000000000] (31 bits)
65535 [1111111111111111] ->  [1111111111111111000000000000000] (31 bits)
Hence minBits=1 maxBits=31

And with k=5 they would look like:

Index Dec/Bin -> Generated Suffix Bin
1 [1] -> [000001] (6 bits)
2 [10] -> [100001] (6 bits)
3 [11] -> [010001] (6 bits)
4 [100] -> [110001] (6 bits)
5 [101] -> [001001] (6 bits)
6 [110] -> [101001] (6 bits)
7 [111] -> [011001] (6 bits)
8 [1000] -> [111001] (6 bits)
9 [1001] -> [000101] (6 bits)
10 [1010] -> [100101] (6 bits)
11 [1011] -> [010101] (6 bits)
12 [1100] -> [110101] (6 bits)
...
65533 [1111111111111101] -> [0011100000000000100000000000] (28 bits)
65534 [1111111111111110] -> [1011100000000000100000000000] (28 bits)
65535 [1111111111111111] -> [0111100000000000100000000000] (28 bits)
Hence minBits=6 maxBits=28

If somebody wants to play around with the details of the suffix generation, let
me know and I will send you a small C source for you to play with.

Additionally this patch disables persistency of file IDs (that I introduced
with patch 3) at compile time by default for now. You can still enable it by
setting QPP_TABLE_PERSISTENCY_LIMIT to some reasonable high value (e.g. 127).
Reason: I am still unresolved what to do with this feature. The original
motivation was to avoid file ID collisions with network services if the machine
was interrupted for a short period. But what I did not consider was that
device IDs might change on host, so after loading the tables from fs the qp
tables would grow with irrelevant entries.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 744 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 hw/9pfs/9p.h | 121 +++++++++-
 2 files changed, 805 insertions(+), 60 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 29c6dfc68a..003901a1e0 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -30,6 +30,10 @@
 #if defined(__linux__) /* TODO: This should probably go into osdep.h instead */
 # include <linux/limits.h> /* for XATTR_SIZE_MAX */
 #endif
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <math.h>
 
 /*
  * How many bytes may we store to fs per extended attribute value?
@@ -585,6 +589,123 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
                                 P9_STAT_MODE_NAMED_PIPE |   \
                                 P9_STAT_MODE_SOCKET)
 
+/* Mirrors all bits of a byte. So e.g. binary 10100000 would become 00000101. */
+static inline uint8_t mirror8bit(uint8_t byte) {
+    return (byte * 0x0202020202ULL & 0x010884422010ULL) % 1023;
+}
+
+/* Same as mirror8bit() just for a 64 bit data type instead for a byte. */
+static inline uint64_t mirror64bit(uint64_t value) {
+    return ((uint64_t)mirror8bit( value        & 0xff) << 56) |
+           ((uint64_t)mirror8bit((value >> 8)  & 0xff) << 48) |
+           ((uint64_t)mirror8bit((value >> 16) & 0xff) << 40) |
+           ((uint64_t)mirror8bit((value >> 24) & 0xff) << 32) |
+           ((uint64_t)mirror8bit((value >> 32) & 0xff) << 24) |
+           ((uint64_t)mirror8bit((value >> 40) & 0xff) << 16) |
+           ((uint64_t)mirror8bit((value >> 48) & 0xff) << 8 ) |
+           ((uint64_t)mirror8bit((value >> 56) & 0xff)      ) ;
+}
+
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+
+/* Parameter k for the Exponential Golomb algorihm to be used.
+ *
+ * The smaller this value, the smaller the minimum bit count for the Exp.
+ * Golomb generated affixes will be (at lowest index) however for the
+ * price of having higher maximum bit count of generated affixes (at highest
+ * index). Likewise increasing this parameter yields in smaller maximum bit
+ * count for the price of having higher minimum bit count.
+ */
+#define EXP_GOLOMB_K    0
+
+# if !EXP_GOLOMB_K
+
+/** @brief Exponential Golomb algorithm limited to the case k=0.
+ * 
+ * See expGolombEncode() below for details.
+ * 
+ * @param n - natural number (or index) of the prefix to be generated
+ *            (1, 2, 3, ...)
+ */
+static VariLenAffix expGolombEncodeK0(uint64_t n) {
+    const int bits = (int) log2(n) + 1;
+    return (VariLenAffix) {
+        .type = AffixType_Prefix,
+        .value = n,
+        .bits = bits + bits - 1
+    };
+}
+
+# else
+
+/** @brief Exponential Golomb algorithm for arbitrary k (including k=0).
+ *
+ * The Exponential Golomb algorithm generates @b prefixes (@b not suffixes!)
+ * with growing length and with the mathematical property of being
+ * "prefix-free". The latter means the generated prefixes can be prepended
+ * in front of arbitrary numbers and the resulting concatenated numbers are
+ * guaranteed to be always unique.
+ *
+ * This is a minor adjustment to the original Exp. Golomb algorithm in the
+ * sense that lowest allowed index (@param n) starts with 1, not with zero.
+ *
+ * @param n - natural number (or index) of the prefix to be generated
+ *            (1, 2, 3, ...)
+ * @param k - parameter k of Exp. Golomb algorithm to be used
+ *            (see comment on EXP_GOLOMB_K macro for details about k)
+ */
+static VariLenAffix expGolombEncode(uint64_t n, int k) {
+    const uint64_t value = n + (1 << k) - 1;
+    const int bits = (int) log2(value) + 1;
+    return (VariLenAffix) {
+        .type = AffixType_Prefix,
+        .value = value,
+        .bits = bits + MAX((bits - 1 - k), 0)
+    };
+}
+
+# endif /* !EXP_GOLOMB_K */
+
+/** @brief Converts a suffix into a prefix, or a prefix into a suffix.
+ *
+ * What this function does is actually mirroring all bits of the affix value,
+ * with the purpose to preserve respectively the mathematical "prefix-free"
+ * or "suffix-free" property after the conversion.
+ *
+ * In other words: if a passed prefix is suitable to create unique numbers,
+ * then the returned suffix is suitable to create unique numbers as well
+ * (and vice versa).
+ */
+static VariLenAffix invertAffix(const VariLenAffix* affix) {
+    return (VariLenAffix) {
+        .type = (affix->type == AffixType_Suffix) ? AffixType_Prefix : AffixType_Suffix,
+        .value =  mirror64bit(affix->value) >> ((sizeof(affix->value) * 8) - affix->bits),
+        .bits = affix->bits
+    };
+}
+
+/** @brief Generates suffix numbers with "suffix-free" property.
+ *
+ * This is just a wrapper function on top of the Exp. Golomb algorithm.
+ *
+ * Since the Exp. Golomb algorithm generates prefixes, but we need suffixes,
+ * this function converts the Exp. Golomb prefixes into appropriate suffixes
+ * which are still suitable for generating unique numbers.
+ *
+ * @param n - natural number (or index) of the suffix to be generated
+ *            (1, 2, 3, ...)
+ */
+static VariLenAffix affixForIndex(uint64_t index) {
+    VariLenAffix prefix;
+    #if EXP_GOLOMB_K
+    prefix = expGolombEncode(index, EXP_GOLOMB_K);
+    #else
+    prefix = expGolombEncodeK0(index);
+    #endif
+    return invertAffix(&prefix); /* convert prefix to suffix */
+}
+
+#endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
 
 /* creative abuse of qemu_xxhash7, which is based on xxhash */
 static uint32_t qpp_hash(QppEntry e)
@@ -597,6 +718,16 @@ static uint32_t qpf_hash(QpfEntry e)
     return qemu_xxhash7(e.ino, e.dev, 0, 0, 0);
 }
 
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+
+static bool qpd_cmp_func(const void *obj, const void *userp)
+{
+    const QpdEntry *e1 = obj, *e2 = userp;
+    return e1->dev == e2->dev;
+}
+
+#endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
+
 static bool qpp_cmp_func(const void *obj, const void *userp)
 {
     const QppEntry *e1 = obj, *e2 = userp;
@@ -620,6 +751,72 @@ static void qp_table_destroy(struct qht *ht)
     qht_destroy(ht);
 }
 
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+
+# if (QPP_TABLE_PERSISTENCY_LIMIT > 0)
+static int v9fs_store_qpd_table(V9fsState *s);
+# endif /* (QPP_TABLE_PERSISTENCY_LIMIT > 0) */
+
+/*
+ * Returns how many (high end) bits of inode numbers of the passed fs
+ * device shall be used (in combination with the device number) to
+ * generate hash values for qpp_table entries.
+ *
+ * This function is required if variable length suffixes are used for inode
+ * number mapping on guest level. Since a device may end up having multiple
+ * entries in qpp_table, each entry most probably with a different suffix
+ * length, we thus need this function in conjunction with qpd_table to
+ * "agree" about a fix amount of bits (per device) to be always used for
+ * generating hash values for the purpose of accessing qpp_table in order
+ * get consistent behaviour when accessing qpp_table.
+ */
+static int qid_inode_prefix_hash_bits(V9fsPDU *pdu, dev_t dev)
+{
+    QpdEntry lookup = {
+        .dev = dev
+    }, *val;
+    uint32_t hash = dev;
+    VariLenAffix affix;
+
+    val = qht_lookup(&pdu->s->qpd_table, &lookup, hash);
+    if (!val) {
+        val = g_malloc0(sizeof(QpdEntry));
+        *val = lookup;
+        affix = affixForIndex(pdu->s->qp_affix_next);
+        val->prefix_bits = affix.bits;
+        qht_insert(&pdu->s->qpd_table, val, hash, NULL);
+        pdu->s->qp_ndevices++;
+
+        /*
+         * Store qpd_table as extended attribute(s) to file system.
+         * 
+         * TODO: This should better only be called from a guest shutdown and
+         * suspend handler.
+         */
+        #if (QPP_TABLE_PERSISTENCY_LIMIT > 0)
+        v9fs_store_qpd_table(pdu->s);
+        #endif
+    }
+    return val->prefix_bits;
+}
+
+#endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
+
+/** @brief Slow / full mapping host inode nr -> guest inode nr.
+ *
+ * This function performs a slower and much more costly remapping of an
+ * original file inode number on host to an appropriate different inode
+ * number on guest. For every (dev, inode) combination on host a new
+ * sequential number is generated, cached and exposed as inode number on
+ * guest.
+ *
+ * This is just a "last resort" fallback solution if the much faster/cheaper
+ * qid_path_prefixmap() failed. In practice this slow / full mapping is not
+ * expected ever to be used at all though.
+ *
+ * @see qid_path_prefixmap() for details
+ *
+ */
 static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
                             uint64_t *path)
 {
@@ -628,11 +825,9 @@ static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
         .ino = stbuf->st_ino
     }, *val;
     uint32_t hash = qpf_hash(lookup);
-
-    /* most users won't need the fullmap, so init the table lazily */
-    if (!pdu->s->qpf_table.map) {
-        qht_init(&pdu->s->qpf_table, qpf_cmp_func, 1 << 16, QHT_MODE_AUTO_RESIZE);
-    }
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    VariLenAffix affix;
+#endif
 
     val = qht_lookup(&pdu->s->qpf_table, &lookup, hash);
 
@@ -646,8 +841,16 @@ static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
         *val = lookup;
 
         /* new unique inode and device combo */
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+        affix = affixForIndex(
+            1ULL << (sizeof(pdu->s->qp_affix_next) * 8)
+        );
+        val->path = (pdu->s->qp_fullpath_next++ << affix.bits) | affix.value;
+        pdu->s->qp_fullpath_next &= ((1ULL << (64 - affix.bits)) - 1);
+#else
         val->path = pdu->s->qp_fullpath_next++;
         pdu->s->qp_fullpath_next &= QPATH_INO_MASK;
+#endif
         qht_insert(&pdu->s->qpf_table, val, hash, NULL);
     }
 
@@ -660,18 +863,17 @@ static inline bool is_ro_export(FsContext *ctx)
     return ctx->export_flags & V9FS_RDONLY;
 }
 
-/*
- * Once qpp_table size exceeds this value, we no longer save
- * the table persistently. See comment in v9fs_store_qpp_table()
- */
-#define QPP_TABLE_PERSISTENCY_LIMIT 32768
+#if (QPP_TABLE_PERSISTENCY_LIMIT > 0)
 
-/* Remove all user.virtfs.system.qidp.* xattrs from export root. */
-static void remove_qidp_xattr(FsContext *ctx)
+/* Remove all xattrs from export root matching the supplied xattr name_pattern. */
+static void remove_seq_xattr(FsContext *ctx, const char* name_pattern)
 {
     V9fsString name;
     int i;
 
+    if (is_ro_export(ctx))
+        return;
+
     /* just for a paranoid endless recursion sanity check */
     const ssize_t max_size =
         sizeof(QppSrlzHeader) +
@@ -679,83 +881,254 @@ static void remove_qidp_xattr(FsContext *ctx)
 
     v9fs_string_init(&name);
     for (i = 0; i * ATTR_MAX_SIZE < max_size; ++i) {
-        v9fs_string_sprintf(&name, "user.virtfs.system.qidp.%d", i);
+        v9fs_string_sprintf(&name, name_pattern, i);
         if (lremovexattr(ctx->fs_root, name.data) < 0)
             break;
     }
     v9fs_string_free(&name);
 }
 
+# if P9_VARI_LENGTH_INODE_SUFFIXES
+
+/* Remove all user.virtfs.system.qidd.* xattrs from export root. */
+static void remove_qidd_xattr(FsContext *ctx)
+{
+    remove_seq_xattr(ctx, "user.virtfs.system.qidd.%d");
+}
+
+# endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
+
+/* Remove all user.virtfs.system.qidp.* xattrs from export root. */
+static void remove_qidp_xattr(FsContext *ctx)
+{
+    remove_seq_xattr(ctx, "user.virtfs.system.qidp.%d");
+}
+
+static void remove_qp_tables_xattrs(FsContext *ctx) {
+    #if P9_VARI_LENGTH_INODE_SUFFIXES
+    remove_qidd_xattr(ctx);
+    #endif
+    remove_qidp_xattr(ctx);
+}
+
+# if P9_VARI_LENGTH_INODE_SUFFIXES
+
+/* Used to convert qpd hash table into continuous stream. */
+static void qpd_table_serialize(struct qht *ht, void *p, uint32_t h, void *up)
+{
+    const QpdEntry *entry = (const QpdEntry*) p;
+    QpdSerialize *ser = (QpdSerialize*) up;
+
+    /* NOTE: Due to the simple incremental index solution we use here, this
+     * means the entries might be serialized in the final data stream with
+     * different order than the devices were originally inserted into the
+     * qpd_table. However specifically for qpd_table this is irrelevant ATM.
+     */
+    const uint32_t index = ser->done;
+
+    if (ser->error)
+        return;
+
+    /* safety first */
+    if (index >= ser->count) {
+        ser->error = -1;
+        return;
+    }
+
+    ser->elements[index] = (QpdEntryS) {
+        .dev = entry->dev,
+        .prefix_bits = entry->prefix_bits
+    };
+    ser->done++;
+}
+
+# endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
+
 /* Used to convert qpp hash table into continuous stream. */
 static void qpp_table_serialize(void *p, uint32_t h, void *up)
 {
     const QppEntry *entry = (const QppEntry*) p;
     QppSerialize *ser = (QppSerialize*) up;
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    const uint32_t index = entry->qp_affix_index - 1;
+#else
+    const uint32_t index = entry->qp_affix - 1;
+#endif
 
     if (ser->error)
         return;
 
     /* safety first */
-    if (entry->qp_prefix - 1 >= ser->count) {
+    if (index >= ser->count) {
         ser->error = -1;
         return;
     }
 
-    ser->elements[entry->qp_prefix - 1] = (QppEntryS) {
+    ser->elements[index] = (QppEntryS) {
         .dev = entry->dev,
         .ino_prefix = entry->ino_prefix
     };
     ser->done++;
 }
 
+/** @brief Returns true if we should still save qpp_table (and qpd_table).
+ *
+ * Whenever we exceeded some certain (arbitrary) high qpp_table size we
+ * delete the stored table(s) from the file system to get rid of old device
+ * ids / inodes that might no longer exist with the goal to potentially
+ * yield in a smaller table size after next reboot and smaller inode
+ * numbers on guest.
+ */
+static bool shouldStoreQpTables(V9fsState *s) {
+    return s->qp_affix_next && s->qp_affix_next < QPP_TABLE_PERSISTENCY_LIMIT;
+}
+
+/* See shouldStoreQpTables() above */
+static bool shouldDeleteQpTables(V9fsState *s) {
+    return s->qp_affix_next == QPP_TABLE_PERSISTENCY_LIMIT;
+}
+
+# if P9_VARI_LENGTH_INODE_SUFFIXES
+
+/*
+ * Tries to store the current qpd_table as extended attribute(s) on the
+ * exported file system root with the goal to preserve identical qids
+ * beyond the scope of reboots / suspends.
+ *
+ * @returns 0 on success
+ */
+static int v9fs_store_qpd_table(V9fsState *s)
+{
+    FsContext *ctx = &s->ctx;
+    V9fsString name;
+    int i, res, err = 0;
+    size_t size;
+    QpdSrlzStream* stream;
+    QpdSerialize ser;
+
+    if (is_ro_export(ctx))
+        return 0;
+
+    if (!shouldStoreQpTables(s)) {
+        if (shouldDeleteQpTables(s)) {
+            remove_qp_tables_xattrs(ctx);
+        }
+        return 0;
+    }
+
+    /* Convert qpd hash table into continuous array. */
+    size = sizeof(QppSrlzHeader) +
+           ( s->qp_ndevices /* qpd_table entry count */ * sizeof(QpdEntryS) );
+    stream = g_malloc0(size);
+    ser = (QpdSerialize) {
+        .elements = &stream->elements[0],
+        .count = s->qp_ndevices,
+        .done  = 0,
+        .error = 0,
+    };
+    qht_iter(&s->qpd_table, qpd_table_serialize, &ser);
+    if (ser.error || ser.done != ser.count) {
+        err = -1;
+        goto out;
+    }
+
+    /* initialize header and calculate CRC32 checksum */
+    stream->header = (QppSrlzHeader) {
+        .version = 1,
+        .options = 0, /* not used for storing the qpd_table yet */
+        .crc32 = crc32c(
+            0xffffffff,
+            (const uint8_t*) &stream->elements[0],
+            (ser.count * sizeof(QpdEntryS))
+        ),
+    };
+
+    /*
+     * Actually just required if the qpd_table size decreased, or if the
+     * previous xattr size limit increased on OS (kernel/fs) level.
+     */
+    remove_qidd_xattr(ctx);
+
+    /*
+     * Subdivide (if required) the data stream into individual xattrs
+     * to cope with the system's max. supported xattr value size.
+     */
+    v9fs_string_init(&name);
+    for (i = 0; size > (i * ATTR_MAX_SIZE); ++i) {
+        v9fs_string_sprintf(&name, "user.virtfs.system.qidd.%d", i);
+        res = lsetxattr(
+            ctx->fs_root,
+            name.data,
+            ((const uint8_t*)stream) + i * ATTR_MAX_SIZE,
+            MIN(ATTR_MAX_SIZE, size - i * ATTR_MAX_SIZE),
+            0/*flags*/
+        );
+        if (res < 0) {
+            if (i > 0)
+                remove_qidd_xattr(ctx);
+            err = -1;
+            break;
+        }
+    }
+    v9fs_string_free(&name);
+out:
+    g_free(stream);
+
+    return err;
+}
+
+# endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
+
 /*
  * Tries to store the current qpp_table as extended attribute(s) on the
  * exported file system root with the goal to preserve identical qids
- * beyond the scope of reboots.
+ * beyond the scope of reboots / suspends.
+ *
+ * @returns 0 on success
  */
-static void v9fs_store_qpp_table(V9fsState *s)
+static int v9fs_store_qpp_table(V9fsState *s)
 {
     FsContext *ctx = &s->ctx;
     V9fsString name;
-    int i, res;
+    int i, res, err = 0;
     size_t size;
     QppSrlzStream* stream;
     QppSerialize ser;
 
     if (is_ro_export(ctx))
-        return;
+        return 0;
 
-    /*
-     * Whenever we exceeded some certain (arbitrary) high qpp_table size we
-     * delete the stored table from the file system to get rid of old device
-     * ids / inodes that might no longer exist with the goal to potentially
-     * yield in a smaller table size after next reboot.
-     */
-    if (!s->qp_prefix_next || s->qp_prefix_next >= QPP_TABLE_PERSISTENCY_LIMIT) {
-        if (s->qp_prefix_next == QPP_TABLE_PERSISTENCY_LIMIT) {
-            remove_qidp_xattr(ctx);
+    if (!shouldStoreQpTables(s)) {
+        if (shouldDeleteQpTables(s)) {
+            remove_qp_tables_xattrs(ctx);
         }
-        return;
+        return 0;
     }
 
     /* Convert qpp hash table into continuous array. */
     size = sizeof(QppSrlzHeader) +
-           ( (s->qp_prefix_next - 1) /* qpp_table entry count */ * sizeof(QppEntryS) );
+           ( (s->qp_affix_next - 1) /* qpp_table entry count */ * sizeof(QppEntryS) );
     stream = g_malloc0(size);
     ser = (QppSerialize) {
         .elements = &stream->elements[0],
-        .count = s->qp_prefix_next - 1,
+        .count = s->qp_affix_next - 1,
         .done  = 0,
         .error = 0,
     };
     qht_iter(&s->qpp_table, qpp_table_serialize, &ser);
-    if (ser.error || ser.done != ser.count)
+    if (ser.error || ser.done != ser.count) {
+        err = -1;
         goto out;
+    }
 
     /* initialize header and calculate CRC32 checksum */
     stream->header = (QppSrlzHeader) {
         .version = 1,
-        .reserved = 0,
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+        .options = EXP_GOLOMB_K + 1,
+#else
+        .options = 0,
+#endif
         .crc32 = crc32c(
             0xffffffff,
             (const uint8_t*) &stream->elements[0],
@@ -786,12 +1159,15 @@ static void v9fs_store_qpp_table(V9fsState *s)
         if (res < 0) {
             if (i > 0)
                 remove_qidp_xattr(ctx);
+            err = -1;
             break;
         }
     }
     v9fs_string_free(&name);
 out:
     g_free(stream);
+
+    return err;
 }
 
 /* Frees the entire chain of passed nodes from memory. */
@@ -809,6 +1185,55 @@ static void destroy_xattr_nodes(XAttrNode **first)
     }
 }
 
+# if P9_VARI_LENGTH_INODE_SUFFIXES
+
+/*
+ * Loads all user.virtfs.system.qidd.* xattrs from exported fs root and
+ * returns a linked list with one node per xattr.
+ */
+static XAttrNode* v9fs_load_qidd_xattr_nodes(V9fsState *s)
+{
+    FsContext *ctx = &s->ctx;
+    XAttrNode *first = NULL, *current = NULL;
+    V9fsString name;
+    ssize_t size;
+    int i;
+
+    const ssize_t max_size =
+        sizeof(QppSrlzHeader) +
+        QPP_TABLE_PERSISTENCY_LIMIT * sizeof(QpdEntryS);
+
+    v9fs_string_init(&name);
+
+    for (i = 0; i * ATTR_MAX_SIZE < max_size; ++i) {
+        v9fs_string_sprintf(&name, "user.virtfs.system.qidd.%d", i);
+        size = lgetxattr(ctx->fs_root, name.data, NULL, 0);
+        if (size <= 0)
+            break;
+        if (!first) {
+            first = current = g_malloc0(sizeof(XAttrNode));
+        } else {
+            current = current->next = g_malloc0(sizeof(XAttrNode));
+        }
+        current->value = g_malloc0(size);
+        current->length = lgetxattr(
+            ctx->fs_root, name.data, current->value, size
+        );
+        if (current->length <= 0) {
+            goto out_w_err;
+        }
+    }
+    goto out;
+
+out_w_err:
+    destroy_xattr_nodes(&first);
+out:
+    v9fs_string_free(&name);
+    return first;
+}
+
+# endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
+
 /*
  * Loads all user.virtfs.system.qidp.* xattrs from exported fs root and
  * returns a linked list with one node per xattr.
@@ -854,28 +1279,121 @@ out:
     return first;
 }
 
+# if P9_VARI_LENGTH_INODE_SUFFIXES
+
+/*
+ * Try to load previously stored qpd_table from file system. Calling this
+ * function assumes that qpd_table is yet empty.
+ *
+ * @returns number of entries loaded on success or negative number on error
+ * @see v9fs_store_qpd_table()
+ */
+static int v9fs_load_qpd_table(V9fsState *s)
+{
+    ssize_t size, count = 0;
+    XAttrNode *current, *first;
+    QpdSrlzStream* stream = NULL;
+    uint32_t crc32;
+    int i, err = 0;
+    QpdEntry *val;
+    uint32_t hash;
+
+    if (s->qp_ndevices != 0)
+        return -1;
+
+    first = v9fs_load_qidd_xattr_nodes(s);
+    if (!first)
+        return -1;
+
+    /* convert nodes into continuous stream */
+    size = 0;
+    for (current = first; current; current = current->next) {
+        size += current->length;
+    }
+    if (size <= 0) {
+        err = -1;
+        goto out;
+    }
+    stream = g_malloc0(size);
+    size = 0;
+    for (current = first; current; current = current->next) {
+        memcpy(((uint8_t*)stream) + size, current->value, current->length);
+        size += current->length;
+    }
+
+    if (stream->header.version != 1) {
+        err = -1;
+        goto out;
+    }
+
+    count = (size - sizeof(QppSrlzHeader)) / sizeof(QpdEntryS);
+    if (count <= 0) {
+        err = -1;
+        goto out;
+    }
+
+    /* verify CRC32 checksum of stream */
+    crc32 = crc32c(
+        0xffffffff,
+        (const uint8_t*) &stream->elements[0],
+        (count * sizeof(QpdEntryS))
+    );
+    if (crc32 != stream->header.crc32) {
+        err = -1;
+        goto out;
+    }
+
+    /* fill qpd_table with the retrieved elements */
+    for (i = 0; i < count; ++i) {
+        val = g_malloc0(sizeof(QpdEntry));
+        *val = (QpdEntry) {
+            .dev = stream->elements[i].dev,
+            .prefix_bits = stream->elements[i].prefix_bits,
+        };
+        hash = val->dev;
+        if (qht_lookup(&s->qpd_table, val, hash)) {
+            /* should never happen: duplicate entry detected */
+            g_free(val);
+            err = -1;
+            goto out;
+        }
+        qht_insert(&s->qpd_table, val, hash, NULL);
+        s->qp_ndevices++;
+    }
+
+out:
+    destroy_xattr_nodes(&first);
+    if (stream)
+        g_free(stream);
+
+    return err ? err : count;
+}
+
+# endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
+
 /*
  * Try to load previously stored qpp_table from file system. Calling this
  * function assumes that qpp_table is yet empty.
  *
+ * @returns number of entries loaded on success or negative number on error
  * @see v9fs_store_qpp_table()
  */
-static void v9fs_load_qpp_table(V9fsState *s)
+static int v9fs_load_qpp_table(V9fsState *s)
 {
-    ssize_t size, count;
+    ssize_t size, count = 0;
     XAttrNode *current, *first;
     QppSrlzStream* stream = NULL;
     uint32_t crc32;
-    int i;
+    int i, err = 0;
     QppEntry *val;
     uint32_t hash;
 
-    if (s->qp_prefix_next != 1)
-        return;
+    if (s->qp_affix_next != 1)
+        return -1;
 
     first = v9fs_load_qidp_xattr_nodes(s);
     if (!first)
-        return;
+        return -1;
 
     /* convert nodes into continuous stream */
     size = 0;
@@ -883,6 +1401,7 @@ static void v9fs_load_qpp_table(V9fsState *s)
         size += current->length;
     }
     if (size <= 0) {
+        err = -1;
         goto out;
     }
     stream = g_malloc0(size);
@@ -893,11 +1412,24 @@ static void v9fs_load_qpp_table(V9fsState *s)
     }
 
     if (stream->header.version != 1) {
+        err = -1;
+        goto out;
+    }
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    if ((stream->header.options - 1) != EXP_GOLOMB_K) {
+        err = -1;
         goto out;
     }
+#else
+    if (stream->header.options != 0) {
+        err = -1;
+        goto out;
+    }
+#endif
 
     count = (size - sizeof(QppSrlzHeader)) / sizeof(QppEntryS);
     if (count <= 0) {
+        err = -1;
         goto out;
     }
 
@@ -908,6 +1440,7 @@ static void v9fs_load_qpp_table(V9fsState *s)
         (count * sizeof(QppEntryS))
     );
     if (crc32 != stream->header.crc32) {
+        err = -1;
         goto out;
     }
 
@@ -922,9 +1455,15 @@ static void v9fs_load_qpp_table(V9fsState *s)
         if (qht_lookup(&s->qpp_table, val, hash)) {
             /* should never happen: duplicate entry detected */
             g_free(val);
+            err = -1;
             goto out;
         }
-        val->qp_prefix = s->qp_prefix_next++;
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+        val->qp_affix_index = s->qp_affix_next++;
+        val->qp_affix = affixForIndex(val->qp_affix_index);
+#else
+        val->qp_affix = s->qp_affix_next++;
+#endif
         qht_insert(&s->qpp_table, val, hash, NULL);
     }
 
@@ -932,40 +1471,109 @@ out:
     destroy_xattr_nodes(&first);
     if (stream)
         g_free(stream);
+
+    return err ? err : count;
+}
+
+/* Tries to load qpp_table (and qpd_table) from xattrs being saved on export root. */
+static void v9fs_load_qp_tables(V9fsState *s)
+{
+    int res;
+
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    res = v9fs_load_qpd_table(s);
+    if (res > 0) {
+        res = v9fs_load_qpp_table(s);
+    }
+#else
+    res = v9fs_load_qpp_table(s);
+#endif
+
+    /* if there was any error, remove the xattrs */
+    if (res < 0) {
+        remove_qp_tables_xattrs(&s->ctx);
+    }
 }
 
-/* stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
+/* Tries to store qpp_table (and qpd_table) as xattrs on export root. */
+static void v9fs_store_qp_tables(V9fsState *s)
+{
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    int res;
+
+    res = v9fs_store_qpd_table(s);
+    if (res >= 0) {
+        res = v9fs_store_qpp_table(s);
+    }
+
+    /* if there was any error, remove the xattrs immediately again */
+    if (res < 0) {
+        remove_qp_tables_xattrs(&s->ctx);
+    }
+#else
+    v9fs_store_qpp_table(s);
+#endif
+}
+
+#endif /* (QPP_TABLE_PERSISTENCY_LIMIT > 0) */
+
+/** @brief Quick mapping host inode nr -> guest inode nr.
+ *
+ * This function performs quick remapping of an original file inode number
+ * on host to an appropriate different inode number on guest. This remapping
+ * of inodes is required to avoid inode nr collisions on guest which would
+ * happen if the 9p export contains more than 1 exported file system (or
+ * more than 1 file system data set), because unlike on host level where the
+ * files would have different device nrs, all files exported by 9p would
+ * share the same device nr on guest (the device nr of the virtual 9p device
+ * that is).
+ *
+ * if P9_VARI_LENGTH_INODE_SUFFIXES == 0 :
+ * stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
  * to a unique QID path (64 bits). To avoid having to map and keep track
  * of up to 2^64 objects, we map only the 16 highest bits of the inode plus
  * the device id to the 16 highest bits of the QID path. The 48 lowest bits
  * of the QID path equal to the lowest bits of the inode number.
  *
- * This takes advantage of the fact that inode number are usually not
- * random but allocated sequentially, so we have fewer items to keep
- * track of.
+ * if P9_VARI_LENGTH_INODE_SUFFIXES == 1 :
+ * Instead of fixed size (16 bit) generated prefix, we use variable size
+ * suffixes instead. See comment on P9_VARI_LENGTH_INODE_SUFFIXES for
+ * details.
  */
 static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
                                 uint64_t *path)
 {
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    const int ino_hash_bits = qid_inode_prefix_hash_bits(pdu, stbuf->st_dev);
+#endif
     QppEntry lookup = {
         .dev = stbuf->st_dev,
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+        .ino_prefix = (uint16_t) (stbuf->st_ino >> (64-ino_hash_bits))
+#else
         .ino_prefix = (uint16_t) (stbuf->st_ino >> 48)
+#endif
     }, *val;
     uint32_t hash = qpp_hash(lookup);
 
     val = qht_lookup(&pdu->s->qpp_table, &lookup, hash);
 
     if (!val) {
-        if (pdu->s->qp_prefix_next == 0) {
-            /* we ran out of prefixes */
+        if (pdu->s->qp_affix_next == 0) {
+            /* we ran out of affixes */
             return -ENFILE;
         }
 
         val = g_malloc0(sizeof(QppEntry));
         *val = lookup;
 
-        /* new unique inode prefix and device combo */
-        val->qp_prefix = pdu->s->qp_prefix_next++;
+        /* new unique inode affix and device combo */
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+        val->qp_affix_index = pdu->s->qp_affix_next++;
+        val->qp_affix = affixForIndex(val->qp_affix_index);
+#else
+        val->qp_affix = pdu->s->qp_affix_next++;
+#endif
         qht_insert(&pdu->s->qpp_table, val, hash, NULL);
 
         /*
@@ -974,10 +1582,16 @@ static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
          * TODO: This should better only be called from a guest shutdown and
          * suspend handler.
          */
+        #if (QPP_TABLE_PERSISTENCY_LIMIT > 0)
         v9fs_store_qpp_table(pdu->s);
+        #endif
     }
-
-    *path = ((uint64_t)val->qp_prefix << 48) | (stbuf->st_ino & QPATH_INO_MASK);
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    /* assuming generated affix to be suffix type, not prefix */
+    *path = (stbuf->st_ino << val->qp_affix.bits) | val->qp_affix.value;
+#else
+    *path = ((uint64_t)val->qp_affix << 48) | (stbuf->st_ino & QPATH_INO_MASK);
+#endif
     return 0;
 }
 
@@ -988,7 +1602,7 @@ static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
     /* map inode+device to qid path (fast path) */
     err = qid_path_prefixmap(pdu, stbuf, &qidp->path);
     if (err == -ENFILE) {
-        /* fast path didn't work, fal back to full map */
+        /* fast path didn't work, fall back to full map */
         err = qid_path_fullmap(pdu, stbuf, &qidp->path);
     }
     if (err) {
@@ -4075,12 +4689,22 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
         goto out;
     }
 
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    qht_init(&s->qpd_table, qpd_cmp_func, 1, QHT_MODE_AUTO_RESIZE);
+#endif
+    /* most users won't need the fullmap, so init the table lazily */
+    qht_init(&s->qpf_table, qpf_cmp_func, 1 << 16, QHT_MODE_AUTO_RESIZE);
     /* QID path hash table. 1 entry ought to be enough for anybody ;) */
     qht_init(&s->qpp_table, qpp_cmp_func, 1, QHT_MODE_AUTO_RESIZE);
-    s->qp_prefix_next = 1; /* reserve 0 to detect overflow */
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    s->qp_ndevices = 0;
+#endif
+    s->qp_affix_next = 1; /* reserve 0 to detect overflow */
     s->qp_fullpath_next = 1;
-    /* try to load and restore previous qpp_table */
-    v9fs_load_qpp_table(s);
+    /* try to load and restore previous qpd_table and qpp_table */
+#if (QPP_TABLE_PERSISTENCY_LIMIT > 0)
+    v9fs_load_qp_tables(s);
+#endif
 
     s->ctx.fst = &fse->fst;
     fsdev_throttle_init(s->ctx.fst);
@@ -4095,6 +4719,9 @@ out:
         }
         g_free(s->tag);
         g_free(s->ctx.fs_root);
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+        qp_table_destroy(&s->qpd_table);
+#endif
         qp_table_destroy(&s->qpp_table);
         qp_table_destroy(&s->qpf_table);
         v9fs_path_free(&path);
@@ -4105,18 +4732,23 @@ out:
 void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
 {
     /*
-     * Store qpp_table as extended attribute(s) to file system.
+     * Store qpd_table and qpp_table as extended attribute(s) to file system.
      *
      * This was actually plan A, but unfortunately unserialize is not called
      * reliably on guest shutdowns and suspensions.
      */
-    v9fs_store_qpp_table(s);
+#if (QPP_TABLE_PERSISTENCY_LIMIT > 0)
+    v9fs_store_qp_tables(s);
+#endif
 
     if (s->ops->cleanup) {
         s->ops->cleanup(&s->ctx);
     }
     fsdev_throttle_cleanup(s->ctx.fst);
     g_free(s->tag);
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    qp_table_destroy(&s->qpd_table);
+#endif
     qp_table_destroy(&s->qpp_table);
     qp_table_destroy(&s->qpf_table);
     g_free(s->ctx.fs_root);
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 54ce039969..78c29fb916 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -236,15 +236,95 @@ struct V9fsFidState
     V9fsFidState *rclm_lst;
 };
 
-#define QPATH_INO_MASK        (((unsigned long)1 << 48) - 1)
+/*
+ * Defines how inode numbers from host shall be remapped on guest.
+ *
+ * When this compile time option is disabled then fixed length (16 bit)
+ * prefix values are used for all inode numbers on guest level. Accordingly
+ * guest's inode numbers will be quite large (>2^48).
+ *
+ * If this option is enabled then variable length suffixes will be used for
+ * guest's inode numbers instead which usually yields in much smaller inode
+ * numbers on guest level (typically around >2^1 .. >2^7).
+ */
+#define P9_VARI_LENGTH_INODE_SUFFIXES 1
+
+/*
+ * If this value is higher than 0 then file inode remapping is tried to be
+ * retained consistent beyond reboots/suspends.
+ *
+ * Once qpp_table size exceeds this value, we no longer save
+ * the table persistently. See comment in v9fs_store_qpp_table()
+ *
+ * By setting this to 0, persistency of file ids will (beyond the scope of
+ * reboots/suspends) will be disabled completely at compile time.
+ */
+#define QPP_TABLE_PERSISTENCY_LIMIT 0
+
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+
+typedef enum AffixType_t {
+    AffixType_Prefix,
+    AffixType_Suffix, /* A.k.a. postfix. */
+} AffixType_t;
+
+/** @brief Unique affix of variable length.
+ *
+ * An affix is (currently) either a suffix or a prefix, which is either
+ * going to be prepended (prefix) or appended (suffix) with some other
+ * number for the goal to generate unique numbers. Accordingly the
+ * suffixes (or prefixes) we generate @b must all have the mathematical
+ * property of being suffix-free (or prefix-free in case of prefixes)
+ * so that no matter what number we concatenate the affix with, that we
+ * always reliably get unique numbers as result after concatenation.
+ */
+typedef struct VariLenAffix {
+    AffixType_t type; /* Whether this affix is a suffix or a prefix. */
+    uint64_t value; /* Actual numerical value of this affix. */
+    int bits; /* Lenght of the affix, that is how many (of the lowest) bits of @c value must be used for appending/prepending this affix to its final resulting, unique number. */
+} VariLenAffix;
+
+#endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
+
+#if !P9_VARI_LENGTH_INODE_SUFFIXES
+# define QPATH_INO_MASK        (((unsigned long)1 << 48) - 1)
+#endif
+
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+
+/* See qid_inode_prefix_hash_bits(). */
+typedef struct {
+    dev_t dev; /* FS device on host. */
+    int prefix_bits; /* How many (high) bits of the original inode number shall be used for hashing. */
+} QpdEntry;
+
+# if (QPP_TABLE_PERSISTENCY_LIMIT > 0)
+
+/* Small version of QpdEntry for serialization as xattr. */
+struct QpdEntryS {
+    dev_t dev;
+    uint8_t prefix_bits;
+}  __attribute__((packed));
+typedef struct QpdEntryS QpdEntryS;
+
+# endif /* (QPP_TABLE_PERSISTENCY_LIMIT > 0) */
+
+#endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
 
 /* QID path prefix entry, see stat_to_qid */
 typedef struct {
     dev_t dev;
     uint16_t ino_prefix;
-    uint16_t qp_prefix;
+    #if P9_VARI_LENGTH_INODE_SUFFIXES
+    uint32_t qp_affix_index;
+    VariLenAffix qp_affix;
+    #else
+    uint16_t qp_affix;
+    #endif
 } QppEntry;
 
+#if (QPP_TABLE_PERSISTENCY_LIMIT > 0)
+
 /* Small version of QppEntry for serialization as xattr. */
 struct QppEntryS {
     dev_t dev;
@@ -252,6 +332,8 @@ struct QppEntryS {
 } __attribute__((packed));
 typedef struct QppEntryS QppEntryS;
 
+#endif /* (QPP_TABLE_PERSISTENCY_LIMIT > 0) */
+
 /* QID path full entry, as above */
 typedef struct {
     dev_t dev;
@@ -259,6 +341,19 @@ typedef struct {
     uint64_t path;
 } QpfEntry;
 
+#if (QPP_TABLE_PERSISTENCY_LIMIT > 0)
+
+# if P9_VARI_LENGTH_INODE_SUFFIXES
+
+typedef struct {
+    QpdEntryS *elements;
+    uint count; /* In: QpdEntryS count in @a elements */
+    uint done; /* Out: how many QpdEntryS did we actually fill in @a elements */
+    int error; /* Out: zero on success */
+} QpdSerialize;
+
+# endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
+
 typedef struct {
     QppEntryS *elements;
     uint count; /* In: QppEntryS count in @a elements */
@@ -268,7 +363,7 @@ typedef struct {
 
 struct QppSrlzHeader {
     uint16_t version;
-    uint16_t reserved; /* might be used e.g. for flags in future */
+    uint16_t options;
     uint32_t crc32;
 } __attribute__((packed));
 typedef struct QppSrlzHeader QppSrlzHeader;
@@ -279,12 +374,24 @@ struct QppSrlzStream {
 } __attribute__((packed));
 typedef struct QppSrlzStream QppSrlzStream;
 
+# if P9_VARI_LENGTH_INODE_SUFFIXES
+
+struct QpdSrlzStream {
+    QppSrlzHeader header;
+    QpdEntryS elements[0];
+} __attribute__((packed));
+typedef struct QpdSrlzStream QpdSrlzStream;
+
+# endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
+
 typedef struct XAttrNode {
     uint8_t* value;
     ssize_t length;
     struct XAttrNode* next;
 } XAttrNode;
 
+#endif /* (QPP_TABLE_PERSISTENCY_LIMIT > 0) */
+
 struct V9fsState
 {
     QLIST_HEAD(, V9fsPDU) free_list;
@@ -306,9 +413,15 @@ struct V9fsState
     Error *migration_blocker;
     V9fsConf fsconf;
     V9fsQID root_qid;
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    struct qht qpd_table;
+#endif
     struct qht qpp_table;
     struct qht qpf_table;
-    uint16_t qp_prefix_next;
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    uint64_t qp_ndevices; /* Amount of entries in qpd_table. */
+#endif
+    uint16_t qp_affix_next;
     uint64_t qp_fullpath_next;
 };
 
-- 
2.11.0


