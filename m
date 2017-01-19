Received: from eggs.gnu.org ([2001:4830:134:3::10]:47645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPv-00012W-Ge
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPp-0005BK-TE
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:19 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPp-00051T-Il
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:13 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPf-00039e-Uk
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:03 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:36 +0000
Message-Id: <1484834995-26826-18-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 17/36] arm: virt: Fix segmentation fault when
 specifying an unsupported CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Using -cpu cortex-a9 (or any other unsupported CPU) with the virt
board will cause QEMU to segmentation fault.  This bug was introduced
in commit 9ac4ef77, which incorrectly added a NULL terminator when
converting the VirtBoardInfo array into a simple array of strings
defining the valid CPUs. The cpuname_valid() loop already has
a termination condition based on ARRAY_SIZE, so the NULL is
spurious and causes the strcmp() to segfault if we reach it.
Delete the NULL.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
Message-id: 1484619334-10488-1-git-send-email-zhaoshenglong@huawei.com
[PMM: expanded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7a03f84..95ac585 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -167,7 +167,6 @@ static const char *valid_cpus[] = {
     "cortex-a53",
     "cortex-a57",
     "host",
-    NULL
 };
 
 static bool cpuname_valid(const char *cpu)
-- 
2.7.4
