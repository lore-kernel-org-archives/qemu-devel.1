Received: from eggs.gnu.org ([2001:4830:134:3::10]:44006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ewgfO-0007Z7-PD
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 00:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ewgfK-0007FQ-Ok
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 00:08:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46812
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ewgfK-0007EN-IG
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 00:08:26 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2G44luS051390
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 00:08:24 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gr66p0rtf-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 00:08:23 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 04:08:22 -0000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <b8642b07-307a-6109-6350-e7830a1b7842@linaro.org>
References: <871sgwmcc3.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<b8642b07-307a-6109-6350-e7830a1b7842@linaro.org>
Date: Fri, 16 Mar 2018 09:38:14 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87bmfor7bl.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] Using new TCG Vector infrastructure in PowerPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Richard Henderson <richard.henderson@linaro.org> writes:

> On 03/07/2018 06:03 PM, Nikunj A Dadhania wrote:
>> Hi Richard,
>> 
>> I was working to get TCG vector support for PowerPC[1]. Started with
>> converting logical operations like vector AND/OR/XOR and compare
>> instructions. Found some inconsistency during my testing on x86 laptop
>> emulating PowerPC:
>
> Great.
>
> Well, the problem is that you cannot use TCG generic vectors and TCG global
> variables to access the same memory.

Interesting, wasn't aware of this.

> Thus your first step must be to remove all references to cpu_avrh and cpu_avrl.
>  These can be replaced by translator helpers that perform an explicit
> tcg_gen_ld_i64 or tcg_gen_st_i64 to the proper memory locations.
>
> Only after that's done can you begin converting other references to use the
> host vectors.  Otherwise, the tcg optimizer will do Bad and Unpredictable
> Things, which may well have produced the incorrect results that you saw.
>
> I'll note that it's probably worth rearranging all of {fpr,vsr,avr} to the more
> logical configuration presented by Power7 (?) such that it's one array of 64 x
> 128-bit registers.

I have following for taking care of making VSRs contiguous 128bits. This
has touched lot of code even out of tcg directory. So I currently have
32 AVRs (128bits) and 32 VSRs (128 bits).

@@ -1026,8 +1027,8 @@ struct CPUPPCState {
 
     /* Floating point execution context */
     float_status fp_status;
-    /* floating point registers */
-    float64 fpr[32];
+    /* floating point registers multiplexed with vsr */
+
     /* floating point status and control register */
     target_ulong fpscr;
 
@@ -1078,8 +1079,8 @@ struct CPUPPCState {
     /* Altivec registers */
     ppc_avr_t avr[32];
     uint32_t vscr;
-    /* VSX registers */
-    uint64_t vsr[32];
+    /* 32 (128bit)- VSX registers */
+    ppc_avr_t vsr[32];
     /* SPE registers */
     uint64_t spe_acc;
     uint32_t spe_fscr;

Regards,
Nikunj
