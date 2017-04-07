Received: from eggs.gnu.org ([2001:4830:134:3::10]:54381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cwMEn-0003FD-Fg
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 01:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cwMEi-0000n0-FB
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 01:15:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39838
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cwMEi-0000mh-9j
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 01:15:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v375DrZf113824
	for <qemu-devel@nongnu.org>; Fri, 7 Apr 2017 01:15:03 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29p49t8e69-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 01:15:03 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 7 Apr 2017 15:15:00 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <ec5ca757-5f82-74db-72cf-af43db056f1b@twiddle.net>
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<20170406102249.20383-2-nikunj@linux.vnet.ibm.com>
	<ec5ca757-5f82-74db-72cf-af43db056f1b@twiddle.net>
Date: Fri, 07 Apr 2017 10:44:03 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8737dksstg.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH RFC v1 1/3] target/ppc: Emulate LL/SC using
 cmpxchg helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, programmingkidx@gmail.com, bharata@linux.vnet.ibm.com

Richard Henderson <rth@twiddle.net> writes:

> On 04/06/2017 03:22 AM, Nikunj A Dadhania wrote:
>>      tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
>>      l1 = gen_new_label();
>>      tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, l1);
>> -    tcg_gen_ori_i32(cpu_crf[0], cpu_crf[0], CRF_EQ);
>> -    tcg_gen_qemu_st_tl(cpu_gpr[reg], EA, ctx->mem_idx, memop);
>> +
>> +    t0 = tcg_temp_new();
>> +    tcg_gen_atomic_cmpxchg_tl(t0, EA, cpu_reserve_val, cpu_gpr[reg],
>> +                              ctx->mem_idx, DEF_MEMOP(memop));
>
> Actually, I noticed another, existing, problem.
>
> This code changes CRF[0] before the user memory write, which might fault.  This 
> needs to delay any changes to the architecture visible state until after any 
> exception may be triggered.

Sure, here you are mentioning cpu_so being moved to CRF.

Regards
Nikunj
