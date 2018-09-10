Received: from eggs.gnu.org ([2001:4830:134:3::10]:49208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPS-0001JP-Ic
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPQ-0001Ej-7S
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:42 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36299)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzRPP-00013L-KI
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:39 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 14:58:52 -0400
Message-Id: <20180910185859.27917-6-cota@braap.org>
In-Reply-To: <20180910185859.27917-1-cota@braap.org>
References: <20180910185859.27917-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 05/12] test-qht: test deletion of the last
 entry in a bucket
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

This improves coverage by one (!) LoC in qht.c, bringing the
coverage rate up from 90.00% to 90.28%.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/test-qht.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tests/test-qht.c b/tests/test-qht.c
index 05b1d6807a..77666e8c5f 100644
--- a/tests/test-qht.c
+++ b/tests/test-qht.c
@@ -172,9 +172,20 @@ static void qht_do_test(unsigned int mode, size_t init_entries)
 
     qht_init(&ht, is_equal, 0, mode);
     rm_nonexist(0, 4);
+    /*
+     * Test that we successfully delete the last element in a bucket.
+     * This is a hard-to-reach code path when resizing is on, but without
+     * resizing we can easily hit it if init_entries <= 1.
+     * Given that the number of elements per bucket can be 4 or 6 depending on
+     * the host's pointer size, test the removal of the 4th and 6th elements.
+     */
     insert(0, 4);
     rm_nonexist(5, 6);
-    insert(4, 6);
+    rm(3, 4);
+    check_n(3);
+    insert(3, 6);
+    rm(5, 6);
+    check_n(5);
     rm_nonexist(7, 8);
     iter_rm_mod(1);
 
-- 
2.17.1
