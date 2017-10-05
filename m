Received: from eggs.gnu.org ([2001:4830:134:3::10]:40730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e07G0-0002Gv-MC
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e07Fv-0001sx-W4
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:36:12 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:56424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e07Fv-0001sK-RY
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:36:07 -0400
Received: by mail-qt0-x232.google.com with SMTP id 34so8618267qtb.13
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 07:36:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  5 Oct 2017 10:35:58 -0400
Message-Id: <20171005143601.21584-2-richard.henderson@linaro.org>
In-Reply-To: <20171005143601.21584-1-richard.henderson@linaro.org>
References: <20171005143601.21584-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 1/4] linux-user: Allow -R values up to
 0xffff0000 for 32-bit ARM guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, peter.maydell@linaro.org

From: Peter Maydell <peter.maydell@linaro.org>

The 32-bit ARM validate_guest_space() check tests whether the
specified -R value leaves enough space for us to put the
commpage in at 0xffff0f00. However it was incorrectly doing
a <= check for the check against (guest_base + guest_size),
which meant that it wasn't permitting the guest space to
butt right up against the commpage.

Fix the comparison, so that -R values all the way up to 0xffff0000
work correctly.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <1507047703-10774-1-git-send-email-peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 79062882ba..3b857fbc9c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -377,7 +377,7 @@ static int validate_guest_space(unsigned long guest_base,
      * then there is no way we can allocate it.
      */
     if (test_page_addr >= guest_base
-        && test_page_addr <= (guest_base + guest_size)) {
+        && test_page_addr < (guest_base + guest_size)) {
         return -1;
     }
 
-- 
2.13.6
