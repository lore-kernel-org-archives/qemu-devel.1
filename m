Received: from eggs.gnu.org ([2001:4830:134:3::10]:60213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cizWs-0005Kd-8j
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 03:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cizWr-00067N-Dz
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 03:22:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42569
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cizWr-00066E-8Y
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 03:22:33 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v218KijB101160
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 03:22:32 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28wtkf8jks-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 03:22:31 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 1 Mar 2017 18:21:47 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170301075913.GC17196@in.ibm.com>
References: <1488354251-20802-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170301075913.GC17196@in.ibm.com>
Date: Wed, 01 Mar 2017 13:50:43 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87h93d5rxg.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: rewrite f[n]m[add,
 sub] using float64_muladd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bharata@linux.vnet.ibm.com
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, qemu-devel@nongnu.org

Bharata B Rao <bharata@linux.vnet.ibm.com> writes:

> On Wed, Mar 01, 2017 at 01:14:11PM +0530, Nikunj A Dadhania wrote:
>> Use the softfloat api for fused multiply-add. As we are using the fused
>> multiply-add, the intermediate result for setting VXISI is not
>> available.
>
> Isn't the behaviour of setting VXISI similar to vector muladd instructions ?
> If so refer to VSX_MADD() to see when VXISI is set.

                if ((float64_is_infinity(xa.fld) ||
                     float64_is_infinity(b->fld)) &&
                     float64_is_infinity(c->fld))) {
                   float_invalid_op_excp(env, POWERPC_EXCP_FP_VXISI, sfprf);
               }
               
AFAIU, VXISI is set when (infinity - infinity). The above doesn't take
into consideration about substraction.

>> +FPU_FMADD(fmadd, 0, 0)
>> +FPU_FMADD(fnmadd, 0, 1)
>> +FPU_FMADD(fmsub, float_muladd_negate_c, 0)
>> +FPU_FMADD(fnmsub, float_muladd_negate_c, 1)
>
> May be you could use MADD_FLGS, MSUB_FLGS, NMADD_FLGS and NMSUB_FLGS ?

Sure

Regards
Nikunj
