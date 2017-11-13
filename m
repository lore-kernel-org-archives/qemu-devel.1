Received: from eggs.gnu.org ([2001:4830:134:3::10]:47477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFSO-0004CQ-5o
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFSI-0007kj-H1
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:24 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eEFSI-0007Yd-A7
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:18 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFS3-00021y-0W
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:11:03 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 14:11:36 +0000
Message-Id: <1510582304-27058-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
References: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/9] arm/translate-a64: mark path as unreachable
 to eliminate warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Emilio G. Cota" <cota@braap.org>

Fixes the following warning when compiling with gcc 5.4.0 with -O1
optimizations and --enable-debug:

target/arm/translate-a64.c: In function ‘aarch64_tr_translate_insn’:
target/arm/translate-a64.c:2361:8: error: ‘post_index’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     if (!post_index) {
        ^
target/arm/translate-a64.c:2307:10: note: ‘post_index’ was declared here
     bool post_index;
          ^
target/arm/translate-a64.c:2386:8: error: ‘writeback’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     if (writeback) {
        ^
target/arm/translate-a64.c:2308:10: note: ‘writeback’ was declared here
     bool writeback;
          ^

Note that idx comes from selecting 2 bits, and therefore its value
can be at most 3.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1510087611-1851-1-git-send-email-cota@braap.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index caca05a..625ef2d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2351,6 +2351,8 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
         post_index = false;
         writeback = true;
         break;
+    default:
+        g_assert_not_reached();
     }
 
     if (rn == 31) {
-- 
2.7.4
