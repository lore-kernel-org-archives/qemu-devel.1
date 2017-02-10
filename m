Received: from eggs.gnu.org ([2001:4830:134:3::10]:60235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cc5ZI-0007OR-Sm
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cc5ZF-0000Oc-P1
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59371
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cc5ZF-0000OT-JO
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 02:24:29 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1A7JBnT107468
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 02:24:29 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28h75g3r7p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 02:24:28 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 10 Feb 2017 17:24:26 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Fri, 10 Feb 2017 12:53:10 +0530
In-Reply-To: <1486711391-12247-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1486711391-12247-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1486711391-12247-7-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 6/7] softfloat: Add float128_to_uint32()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, nikunj@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

float128_to_uint32() is needed by target/s390.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 fpu/softfloat.c         | 17 +++++++++++++++++
 include/fpu/softfloat.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 485a006..ef6f2d0 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -6186,6 +6186,23 @@ uint64_t float128_to_uint64_round_to_zero(float128 a, float_status *status)
     return v;
 }
 
+uint32_t float128_to_uint32(float128 a, float_status *status)
+{
+    uint64_t v;
+    uint32_t res;
+    int old_exc_flags = get_float_exception_flags(status);
+
+    v = float128_to_uint64(a, status);
+    if (v > 0xffffffff) {
+        res = 0xffffffff;
+    } else {
+        return v;
+    }
+    set_float_exception_flags(old_exc_flags, status);
+    float_raise(float_flag_invalid, status);
+    return res;
+}
+
 /*----------------------------------------------------------------------------
 | Returns the result of converting the quadruple-precision floating-point
 | value `a' to the 32-bit unsigned integer format.  The conversion
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index f1288ef..a57a027 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -716,6 +716,7 @@ int64_t float128_to_int64(float128, float_status *status);
 int64_t float128_to_int64_round_to_zero(float128, float_status *status);
 uint64_t float128_to_uint64(float128, float_status *status);
 uint64_t float128_to_uint64_round_to_zero(float128, float_status *status);
+uint32_t float128_to_uint32(float128, float_status *status);
 uint32_t float128_to_uint32_round_to_zero(float128, float_status *status);
 float32 float128_to_float32(float128, float_status *status);
 float64 float128_to_float64(float128, float_status *status);
-- 
2.7.4
