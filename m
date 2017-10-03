Received: from eggs.gnu.org ([2001:4830:134:3::10]:36934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dzPwN-0001VV-Nm
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dzPwM-00017i-TF
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:21:03 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dzPwM-0000yV-MK
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:21:02 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  3 Oct 2017 17:21:43 +0100
Message-Id: <1507047703-10774-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] linux-user: Allow -R values up to 0xffff0000
 for 32-bit ARM guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

The 32-bit ARM validate_guest_space() check tests whether the
specified -R value leaves enough space for us to put the
commpage in at 0xffff0f00. However it was incorrectly doing
a <= check for the check against (guest_base + guest_size),
which meant that it wasn't permitting the guest space to
butt right up against the commpage.

Fix the comparison, so that -R values all the way up to 0xffff0000
work correctly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7906288..3b857fb 100644
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
2.7.4
