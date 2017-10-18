Received: from eggs.gnu.org ([2001:4830:134:3::10]:58607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXW-0005Do-TA
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXS-0003vp-UP
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:38 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:52727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1e4nXS-0003vB-N5
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:34 -0400
Received: by mail-lf0-x243.google.com with SMTP id b190so5601045lfg.9
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 05:33:34 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 18 Oct 2017 15:33:18 +0300
Message-Id: <e568f9df086965813a318ff0558782ba90e59c33.1508329282.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1508329282.git.riku.voipio@linaro.org>
References: <cover.1508329282.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 04/10] linux-user: Allow -R values up to
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
Cc: Peter Maydell <peter.maydell@linaro.org>

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
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
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
2.14.2
