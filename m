Received: from eggs.gnu.org ([2001:4830:134:3::10]:51874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jy-0007Yj-B6
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9ju-0003y5-67
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:26 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:07 +1100
Message-Id: <20170202051445.5735-70-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 069/107] softfloat: Fix the default qNAN for
 target-ppc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Bharata B Rao <bharata@linux.vnet.ibm.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

Currently float128_default_nan() returns 0xFFFF800000000000 in the
higher double word, but it should return 0x7FFF800000000000 which
is the correct higher double word for default qNAN on PowerPC.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 fpu/softfloat-specialize.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index f05c865..100c8a9 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -185,7 +185,7 @@ float128 float128_default_nan(float_status *status)
         r.high = LIT64(0x7FFF7FFFFFFFFFFF);
     } else {
         r.low = LIT64(0x0000000000000000);
-#if defined(TARGET_S390X)
+#if defined(TARGET_S390X) || defined(TARGET_PPC)
         r.high = LIT64(0x7FFF800000000000);
 #else
         r.high = LIT64(0xFFFF800000000000);
-- 
2.9.3
