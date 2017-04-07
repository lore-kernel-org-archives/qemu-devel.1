Received: from eggs.gnu.org ([2001:4830:134:3::10]:59175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cwMfB-0000kd-0N
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 01:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cwMf7-0003mh-Vr
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 01:42:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52301
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cwMf7-0003mM-Pe
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 01:42:21 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v375ce1Q103669
	for <qemu-devel@nongnu.org>; Fri, 7 Apr 2017 01:42:20 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29p3dc423q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 01:42:20 -0400
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 7 Apr 2017 11:12:17 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170407052348.GA27571@umbus>
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<20170406102249.20383-2-nikunj@linux.vnet.ibm.com>
	<20170407052348.GA27571@umbus>
Date: Fri, 07 Apr 2017 11:12:08 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3vcdb9r.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, alex.bennee@linaro.org, programmingkidx@gmail.com, bharata@linux.vnet.ibm.com

David Gibson <david@gibson.dropbear.id.au> writes:

> [ Unknown signature status ]
> On Thu, Apr 06, 2017 at 03:52:47PM +0530, Nikunj A Dadhania wrote:
>> Emulating LL/SC with cmpxchg is not correct, since it can suffer from
>> the ABA problem. However, portable parallel code is written assuming
>> only cmpxchg which means that in practice this is a viable alternative.
>> 
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> ---
>>  target/ppc/translate.c | 24 +++++++++++++++++++++---
>>  1 file changed, 21 insertions(+), 3 deletions(-)
>> 
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index b6abc60..a9c733d 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -73,6 +73,7 @@ static TCGv cpu_cfar;
>>  #endif
>>  static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca, cpu_ov32, cpu_ca32;
>>  static TCGv cpu_reserve;
>> +static TCGv cpu_reserve_val;
>>  static TCGv cpu_fpscr;
>>  static TCGv_i32 cpu_access_type;
>>  
>> @@ -181,6 +182,9 @@ void ppc_translate_init(void)
>>      cpu_reserve = tcg_global_mem_new(cpu_env,
>>                                       offsetof(CPUPPCState, reserve_addr),
>>                                       "reserve_addr");
>> +    cpu_reserve_val = tcg_global_mem_new(cpu_env,
>> +                                     offsetof(CPUPPCState, reserve_val),
>> +                                     "reserve_val");
>
> I notice that lqarx is not updated.  Does that matter?

Thats correct, I haven't touched that yet. Most of the locks are
implemented using lwarx/stwcx. 

Regards
Nikunj
