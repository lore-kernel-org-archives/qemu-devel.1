Received: from eggs.gnu.org ([2001:4830:134:3::10]:57745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqoPE-0004vU-Gy
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 19:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqoBj-0003Hh-Ow
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 19:29:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45909)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fqoBj-0003H6-Hl
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 19:29:51 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 17 Aug 2018 19:29:20 -0400
Message-Id: <20180817232923.28899-4-cota@braap.org>
In-Reply-To: <20180817232923.28899-1-cota@braap.org>
References: <20180817232923.28899-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 3/6] test-qht: test qht_iter_remove
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

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/test-qht.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/tests/test-qht.c b/tests/test-qht.c
index dda6a067be..283fb3db39 100644
--- a/tests/test-qht.c
+++ b/tests/test-qht.c
@@ -108,6 +108,49 @@ static void iter_check(unsigned int count)
     g_assert_cmpuint(curr, ==, count);
 }
 
+static void sum_func(struct qht *ht, void *p, uint32_t hash, void *userp)
+{
+    uint32_t *sum = userp;
+    uint32_t a = *(uint32_t *)p;
+
+    *sum += a;
+}
+
+static void iter_sum_check(unsigned int expected)
+{
+    unsigned int sum = 0;
+
+    qht_iter(&ht, sum_func, &sum);
+    g_assert_cmpuint(sum, ==, expected);
+}
+
+static bool rm_mod_func(struct qht *ht, void *p, uint32_t hash, void *userp)
+{
+    uint32_t a = *(uint32_t *)p;
+    unsigned int mod = *(unsigned int *)userp;
+
+    return a % mod == 0;
+}
+
+static void iter_rm_mod(unsigned int mod)
+{
+    qht_iter_remove(&ht, rm_mod_func, &mod);
+}
+
+static void iter_rm_mod_check(unsigned int mod)
+{
+    unsigned int expected = 0;
+    unsigned int i;
+
+    for (i = 0; i < N; i++) {
+        if (i % mod == 0) {
+            continue;
+        }
+        expected += i;
+    }
+    iter_sum_check(expected);
+}
+
 static void qht_do_test(unsigned int mode, size_t init_entries)
 {
     /* under KVM we might fetch stats from an uninitialized qht */
@@ -138,8 +181,11 @@ static void qht_do_test(unsigned int mode, size_t init_entries)
     insert(10, 150);
     check_n(N);
 
-    rm(1, 2);
-    check_n(N - 1);
+    qht_reset(&ht);
+    insert(0, N);
+    iter_rm_mod(10);
+    iter_rm_mod_check(10);
+    check_n(N * 9 / 10);
     qht_reset_size(&ht, 0);
     check_n(0);
     check(0, N, false);
-- 
2.17.1
