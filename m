Received: from eggs.gnu.org ([2001:4830:134:3::10]:57651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqoPA-0004rh-Js
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 19:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqoBk-0003I6-7C
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 19:29:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36437)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fqoBk-0003Ht-1i
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 19:29:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 17 Aug 2018 19:29:23 -0400
Message-Id: <20180817232923.28899-7-cota@braap.org>
In-Reply-To: <20180817232923.28899-1-cota@braap.org>
References: <20180817232923.28899-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 6/6] test-qht: speed up + test qht_resize
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

Perform first the tests that exercise code paths that are
easier to hit at small table sizes, and then resize the table
to speed up subsequent tests. If this resize is not too large,
we can make the test faster with no code coverage loss.

- With gcov enabled:

Before: 20.568s, 90.28% qht.c coverage
After:   5.168s, 93.06% qht.c coverage

The coverage increase is entirely due to calling qht_resize,
which we weren't calling before. Note that the code paths
that remain to be tested are either error handling or
can only occur when several threads are accessing the
hash table concurrently (e.g. seqlock retry, trylock fail).

- Without gcov:

Before: 1.987s
After:  0.528s

The speedup is almost the same as with gcov, although the
"before" run is a lot faster.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/test-qht.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/test-qht.c b/tests/test-qht.c
index 77666e8c5f..1ec039d636 100644
--- a/tests/test-qht.c
+++ b/tests/test-qht.c
@@ -189,6 +189,10 @@ static void qht_do_test(unsigned int mode, size_t init_entries)
     rm_nonexist(7, 8);
     iter_rm_mod(1);
 
+    if (!(mode & QHT_MODE_AUTO_RESIZE)) {
+        qht_resize(&ht, init_entries * 4 + 4);
+    }
+
     check_n(0);
     rm_nonexist(0, 10);
     insert(0, N);
-- 
2.17.1
