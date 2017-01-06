Received: from eggs.gnu.org ([2001:4830:134:3::10]:41150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPN8A-0005Ce-7r
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 00:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cPN87-0001jh-4X
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 00:31:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38419
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cPN87-0001ja-0K
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 00:31:55 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v065TAIE073969
	for <qemu-devel@nongnu.org>; Fri, 6 Jan 2017 00:31:54 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27skxwk8nd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 00:31:53 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 6 Jan 2017 11:01:50 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170105220117.GE13763@umbus.fritz.box>
References: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1483615579-17618-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170105220117.GE13763@umbus.fritz.box>
Date: Fri, 06 Jan 2017 11:01:40 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mvf4n48z.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 03/14] target-ppc: Use float64 arg in
 helper_compute_fprf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

David Gibson <david@gibson.dropbear.id.au> writes:

> [ Unknown signature status ]
> On Thu, Jan 05, 2017 at 04:56:08PM +0530, Nikunj A Dadhania wrote:
>> From: Bharata B Rao <bharata@linux.vnet.ibm.com>
>> 
>> Use float64 argument instead of unit64_t in helper_compute_fprf()
>> This allows code in helper_compute_fprf() to be reused later to
>> work with float128 argument too.
>> 
>> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>
> Uh.. how can this possibly be correct, without updating the callers of
> helper_compute_fprf()?

Before the patch

   1791 #define VSX_ADD_SUB(name, op, nels, tp, fld, sfprf, r2sp)                    \
   1792 void helper_##name(CPUPPCState *env, uint32_t opcode)                        \
   1793 {                                                                            \

[SNIP]

   1816                                                                              \
   1817         if (r2sp) {                                                          \
   1818             xt.fld = helper_frsp(env, xt.fld);                               \
   1819         }                                                                    \
   1820                                                                              \
   1821         if (sfprf) {                                                         \
   1822             helper_compute_fprf(env, xt.fld);                                \

[SNIP]

   1829 VSX_ADD_SUB(xsadddp, add, 1, float64, VsrD(0), 1, 0)
   1830 VSX_ADD_SUB(xsaddsp, add, 1, float64, VsrD(0), 1, 1)
   1831 VSX_ADD_SUB(xvadddp, add, 2, float64, VsrD(i), 0, 0)
   1832 VSX_ADD_SUB(xvaddsp, add, 4, float32, VsrW(i), 0, 0)
   1833 VSX_ADD_SUB(xssubdp, sub, 1, float64, VsrD(0), 1, 0)


So we use xt.fld, which in turn will be xt.float64/xt.float32 etc. I
have seen all the other path, should be fine.
target/ppc/fpu_helper.c:1877:            helper_compute_fprf(env, xt.fld);                                \
target/ppc/fpu_helper.c:1931:            helper_compute_fprf(env, xt.fld);                                 \
target/ppc/fpu_helper.c:1972:            helper_compute_fprf(env, xt.fld);                                 \
target/ppc/fpu_helper.c:2021:            helper_compute_fprf(env, xt.fld);                                \
target/ppc/fpu_helper.c:2071:            helper_compute_fprf(env, xt.fld);                                \
target/ppc/fpu_helper.c:2271:            helper_compute_fprf(env, xt_out.fld);                             \
target/ppc/fpu_helper.c:2661:            helper_compute_fprf(env, ttp##_to_float64(xt.tfld,     \
target/ppc/fpu_helper.c:2772:            helper_compute_fprf(env, xt.tfld);                          \
target/ppc/fpu_helper.c:2828:            helper_compute_fprf(env, xt.fld);                          \


Except the below one, the register that we pass comes as i64 via the
helper:

target/ppc/helper.h:64:DEF_HELPER_2(compute_fprf, void, env, i64)

Regards
Nikunj
