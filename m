Received: from eggs.gnu.org ([2001:4830:134:3::10]:49315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPc-0001Tk-Qa
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPb-0001Kw-3l
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35791)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzRPa-0001DR-Tn
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:50 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 14:58:59 -0400
Message-Id: <20180910185859.27917-13-cota@braap.org>
In-Reply-To: <20180910185859.27917-1-cota@braap.org>
References: <20180910185859.27917-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 12/12] qht-bench: add -p flag to precompute
 hash values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Precomputing the hash values allows us to perform more frequent
accesses to the hash table, thereby reaching higher throughputs.

We keep the old behaviour by default, since (1) we might confuse
users if they measured a speedup without changing anything in
the QHT implementation, and (2) benchmarking the hash function
"on line" is also valuable.

Before:
$ taskset -c 0 tests/qht-bench -n 1
 Throughput:        38.18 MT/s

After:
$ taskset -c 0 tests/qht-bench -n 1
 Throughput:        38.16 MT/s

After (with precomputing):
$ taskset -c 0 tests/qht-bench -n 1 -p
 Throughput:        50.87 MT/s

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/qht-bench.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index f492b3a20a..2089e2bed1 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -53,6 +53,7 @@ static unsigned long resize_delay = 1000;
 static double resize_rate; /* 0.0 to 1.0 */
 static unsigned int n_rz_threads = 1;
 static QemuThread *rz_threads;
+static bool precompute_hash;
 
 static double update_rate; /* 0.0 to 1.0 */
 static uint64_t update_threshold;
@@ -101,11 +102,18 @@ static bool is_equal(const void *ap, const void *bp)
     return *a == *b;
 }
 
-static inline uint32_t h(unsigned long v)
+static uint32_t h(unsigned long v)
 {
     return tb_hash_func7(v, 0, 0, 0, 0);
 }
 
+static uint32_t hval(unsigned long v)
+{
+    return v;
+}
+
+static uint32_t (*hfunc)(unsigned long v) = h;
+
 /*
  * From: https://en.wikipedia.org/wiki/Xorshift
  * This is faster than rand_r(), and gives us a wider range (RAND_MAX is only
@@ -149,7 +157,7 @@ static void do_rw(struct thread_info *info)
         bool read;
 
         p = &keys[info->r & (lookup_range - 1)];
-        hash = h(*p);
+        hash = hfunc(*p);
         read = qht_lookup(&ht, p, hash);
         if (read) {
             stats->rd++;
@@ -158,7 +166,7 @@ static void do_rw(struct thread_info *info)
         }
     } else {
         p = &keys[info->r & (update_range - 1)];
-        hash = h(*p);
+        hash = hfunc(*p);
         if (info->write_op) {
             bool written = false;
 
@@ -289,7 +297,9 @@ static void htable_init(void)
     /* avoid allocating memory later by allocating all the keys now */
     keys = g_malloc(sizeof(*keys) * n);
     for (i = 0; i < n; i++) {
-        keys[i] = populate_offset + i;
+        long val = populate_offset + i;
+
+        keys[i] = precompute_hash ? h(val) : hval(val);
     }
 
     /* some sanity checks */
@@ -321,7 +331,7 @@ static void htable_init(void)
 
             r = xorshift64star(r);
             p = &keys[r & (init_range - 1)];
-            hash = h(*p);
+            hash = hfunc(*p);
             if (qht_insert(&ht, p, hash, NULL)) {
                 break;
             }
@@ -412,7 +422,7 @@ static void parse_args(int argc, char *argv[])
     int c;
 
     for (;;) {
-        c = getopt(argc, argv, "d:D:g:k:K:l:hn:N:o:r:Rs:S:u:");
+        c = getopt(argc, argv, "d:D:g:k:K:l:hn:N:o:pr:Rs:S:u:");
         if (c < 0) {
             break;
         }
@@ -451,6 +461,10 @@ static void parse_args(int argc, char *argv[])
         case 'o':
             populate_offset = atol(optarg);
             break;
+        case 'p':
+            precompute_hash = true;
+            hfunc = hval;
+            break;
         case 'r':
             update_range = pow2ceil(atol(optarg));
             break;
-- 
2.17.1
