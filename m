Received: from eggs.gnu.org ([2001:4830:134:3::10]:60787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfV-0001d2-Ny
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfU-0006EF-Au
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfU-0006Bk-1G
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfS-0003hA-ST
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:34 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:24:55 +0100
Message-Id: <20180615142521.19143-18-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 17/43] exec.c: Don't accidentally sign-extend
 4-byte loads in subpage_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In subpage_read() we perform a load of the data into a local buffer
which we then access using ldub_p(), lduw_p(), ldl_p() or ldq_p()
depending on its size, storing the result into the uint64_t *data.
Since ldl_p() returns an 'int', this means that for the 4-byte
case we will sign-extend the data, whereas for 1 and 2 byte
reads we zero-extend it.

This ought not to matter since the caller will likely ignore values in
the high bytes of the data, but add a cast so that we're consistent.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180611171007.4165-3-peter.maydell@linaro.org
---
 exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 9cbba6adcd3..90b47cde7b1 100644
--- a/exec.c
+++ b/exec.c
@@ -2747,7 +2747,7 @@ static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
         *data = lduw_p(buf);
         return MEMTX_OK;
     case 4:
-        *data = ldl_p(buf);
+        *data = (uint32_t)ldl_p(buf);
         return MEMTX_OK;
     case 8:
         *data = ldq_p(buf);
-- 
2.17.1
