Received: from eggs.gnu.org ([2001:4830:134:3::10]:59362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cbGMp-0005BY-QO
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cbGMm-0004wP-Nk
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:44:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cbGMm-0004wA-E7
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:44:12 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v180hY3t091441
	for <qemu-devel@nongnu.org>; Tue, 7 Feb 2017 19:44:11 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28faw8qk5m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 19:44:11 -0500
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 8 Feb 2017 06:14:08 +0530
Date: Wed, 8 Feb 2017 06:14:03 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1486454676-29112-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1486454676-29112-3-git-send-email-bharata@linux.vnet.ibm.com>
	<6dac1bb1-bb4c-9dc5-ff6e-020db8a4bcd5@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dac1bb1-bb4c-9dc5-ff6e-020db8a4bcd5@twiddle.net>
Message-Id: <20170208004403.GI12744@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 2/2] softfloat: Add
 float128_to_uint32_round_to_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com, peter.maydell@linaro.org

On Tue, Feb 07, 2017 at 02:10:04PM -0800, Richard Henderson wrote:
> On 02/07/2017 12:04 AM, Bharata B Rao wrote:
> > +    int64_t v;
> > +    uint32_t res;
> > +    int old_exc_flags = get_float_exception_flags(status);
> > +
> > +    v = float128_to_uint64_round_to_zero(a, status);
> > +    if (v > 0xffffffff) {
> 
> v should be uint64_t.

Right, here is the updated patch...

Peter/David - If you want both the patches to be posted afresh, let me know.
(These patches apply on David's ppc-for-2.9 branch)

>From 24afd78beb5f5742f9da76cf5330ea465697be7b Mon Sep 17 00:00:00 2001
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Mon, 30 Jan 2017 15:23:04 +0530
Subject: [PATCH v2 2/2] softfloat: Add float128_to_uint32_round_to_zero()

float128_to_uint32_round_to_zero() is needed by xscvqpuwz instruction
of PowerPC ISA 3.0.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat.c         | 28 ++++++++++++++++++++++++++++
 include/fpu/softfloat.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 4a4b50b..c2f0de0 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -6169,6 +6169,34 @@ uint64_t float128_to_uint64_round_to_zero(float128 a, float_status *status)
 
 /*----------------------------------------------------------------------------
 | Returns the result of converting the quadruple-precision floating-point
+| value `a' to the 32-bit unsigned integer format.  The conversion
+| is performed according to the IEC/IEEE Standard for Binary Floating-Point
+| Arithmetic except that the conversion is always rounded toward zero.
+| If `a' is a NaN, the largest positive integer is returned.  Otherwise,
+| if the conversion overflows, the largest unsigned integer is returned.
+| If 'a' is negative, the value is rounded and zero is returned; negative
+| values that do not round to zero will raise the inexact exception.
+*----------------------------------------------------------------------------*/
+
+uint32_t float128_to_uint32_round_to_zero(float128 a, float_status *status)
+{
+    uint64_t v;
+    uint32_t res;
+    int old_exc_flags = get_float_exception_flags(status);
+
+    v = float128_to_uint64_round_to_zero(a, status);
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
+/*----------------------------------------------------------------------------
+| Returns the result of converting the quadruple-precision floating-point
 | value `a' to the single-precision floating-point format.  The conversion
 | is performed according to the IEC/IEEE Standard for Binary Floating-Point
 | Arithmetic.
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 4e99253..9eb5a6b 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -714,6 +714,7 @@ int64_t float128_to_int64(float128, float_status *status);
 int64_t float128_to_int64_round_to_zero(float128, float_status *status);
 uint64_t float128_to_uint64(float128, float_status *status);
 uint64_t float128_to_uint64_round_to_zero(float128, float_status *status);
+uint32_t float128_to_uint32_round_to_zero(float128, float_status *status);
 float32 float128_to_float32(float128, float_status *status);
 float64 float128_to_float64(float128, float_status *status);
 floatx80 float128_to_floatx80(float128, float_status *status);
-- 
2.7.4
