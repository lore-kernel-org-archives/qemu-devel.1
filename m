Received: from eggs.gnu.org ([2001:4830:134:3::10]:53887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gaQvd-00040X-7w
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 14:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gaQva-0002Kx-17
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 14:57:49 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38697)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gaQvZ-0002JD-Pc
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 14:57:45 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 21 Dec 2018 14:51:59 -0500
Message-Id: <20181221195200.6544-2-cota@braap.org>
In-Reply-To: <20181221195200.6544-1-cota@braap.org>
References: <20181221195200.6544-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 1/2] fp-bench: fix update_random_ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The second test in the branches is wrong; fix while converting
to a switch statement, which is easier to get right.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/fp/fp-bench.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
index f5bc5edebf..546bac9c9c 100644
--- a/tests/fp/fp-bench.c
+++ b/tests/fp/fp-bench.c
@@ -143,15 +143,20 @@ static void update_random_ops(int n_ops, enum precision prec)
     for (i = 0; i < n_ops; i++) {
         uint64_t r = random_ops[i];
 
-        if (prec == PREC_SINGLE || PREC_FLOAT32) {
+        switch (prec) {
+        case PREC_SINGLE:
+        case PREC_FLOAT32:
             do {
                 r = xorshift64star(r);
             } while (!float32_is_normal(r));
-        } else if (prec == PREC_DOUBLE || PREC_FLOAT64) {
+            break;
+        case PREC_DOUBLE:
+        case PREC_FLOAT64:
             do {
                 r = xorshift64star(r);
             } while (!float64_is_normal(r));
-        } else {
+            break;
+        default:
             g_assert_not_reached();
         }
         random_ops[i] = r;
-- 
2.17.1
