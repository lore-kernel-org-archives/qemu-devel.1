Received: from eggs.gnu.org ([2001:4830:134:3::10]:55593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cQs9G-0000Xd-Nr
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cQs9E-0000q2-Dd
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cQs9E-0000pK-3U
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 03:51:16 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0A8n9ZH114767
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:51:15 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27vn5fp37k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:51:14 -0500
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 10 Jan 2017 14:21:11 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Tue, 10 Jan 2017 14:20:34 +0530
In-Reply-To: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1484038243-30314-3-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 02/11] softfloat: Fix the default qNAN for
 target-ppc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

Currently float128_default_nan() returns 0xFFFF800000000000 in the
higher double word, but it should return 0x7FFF800000000000 which
is the correct higher double word for default qNAN on PowerPC.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 fpu/softfloat-specialize.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index f5aed72..7228b30 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -181,7 +181,7 @@ float128 float128_default_nan(float_status *status)
         r.high = LIT64(0x7FFF7FFFFFFFFFFF);
     } else {
         r.low = LIT64(0x0000000000000000);
-#if defined(TARGET_S390X)
+#if defined(TARGET_S390X) || defined(TARGET_PPC)
         r.high = LIT64(0x7FFF800000000000);
 #else
         r.high = LIT64(0xFFFF800000000000);
-- 
2.7.4
