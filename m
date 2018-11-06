Received: from eggs.gnu.org ([2001:4830:134:3::10]:60294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gJzh3-0008JE-Bq
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gJzh2-0004Pi-CY
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:38:49 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gJzh2-00049H-5p
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:38:48 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gJzgk-0007cb-Aq
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:38:30 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Nov 2018 11:38:22 +0000
Message-Id: <20181106113826.25810-2-peter.maydell@linaro.org>
In-Reply-To: <20181106113826.25810-1-peter.maydell@linaro.org>
References: <20181106113826.25810-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/5] target/arm: Remove can't-happen if() from
 handle_vec_simd_shli()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In handle_vec_simd_shli() we have a check:
     if (size > 3 && !is_q) {
         unallocated_encoding(s);
         return;
     }
However this can never be true, because we calculate
    int size = 32 - clz32(immh) - 1;
where immh is a 4 bit field which we know cannot be all-zeroes.
So the clz32() return must be in {28,29,30,31} and the resulting
size is in {0,1,2,3}, and "size > 3" is never true.

This unnecessary code confuses Coverity's analysis:
in CID 1396476 it thinks we might later index off the
end of an array because the condition implies that we
might have a size > 3.

Remove the code, and instead assert that the size is in [0..3],
since the decode that enforces that is somewhat distant from
this function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20181030162517.21816-1-peter.maydell@linaro.org
---
 target/arm/translate-a64.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 88195ab9490..fd36425f1ae 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9483,12 +9483,10 @@ static void handle_vec_simd_shli(DisasContext *s, bool is_q, bool insert,
     int immhb = immh << 3 | immb;
     int shift = immhb - (8 << size);
 
-    if (extract32(immh, 3, 1) && !is_q) {
-        unallocated_encoding(s);
-        return;
-    }
+    /* Range of size is limited by decode: immh is a non-zero 4 bit field */
+    assert(size >= 0 && size <= 3);
 
-    if (size > 3 && !is_q) {
+    if (extract32(immh, 3, 1) && !is_q) {
         unallocated_encoding(s);
         return;
     }
-- 
2.19.1
