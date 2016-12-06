Received: from eggs.gnu.org ([2001:4830:134:3::10]:39536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cE8ZE-0004Bp-An
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 00:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cE8ZB-0005eq-6f
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 00:45:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38477
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cE8ZB-0005cu-0A
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 00:45:25 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB65ihwB076499
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 00:45:23 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 275nrhejen-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 00:45:23 -0500
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 6 Dec 2016 15:45:18 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <3452cd65-6045-b93d-47cc-879174660849@twiddle.net>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-5-git-send-email-nikunj@linux.vnet.ibm.com>
	<3452cd65-6045-b93d-47cc-879174660849@twiddle.net>
Date: Tue, 06 Dec 2016 11:15:11 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a8c9ipaw.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 04/13] target-ppc: implement lxvll
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

Richard Henderson <rth@twiddle.net> writes:

> On 12/05/2016 03:25 AM, Nikunj A Dadhania wrote:
>> +void helper_lxvll(CPUPPCState *env, target_ulong addr,
>> +                  target_ulong xt_num, target_ulong rb)
>> +{
>> +    ppc_vsr_t xt;
>> +
>> +    getVSR(xt_num, &xt, env);
>> +    if (unlikely((rb & 0xFF) == 0)) {
>> +        xt.s128 = int128_make128(0, 0);
>
> Nit: int128_zero.

Sure.

>> +    } else {
>> +        target_ulong end = ((rb & 0xFF) * 8) - 1;
>> +        if (msr_le) {
>> +            xt.u64[LO_IDX] = cpu_ldq_data_ra(env, addr, GETPC());
>> +            addr = addr_add(env, addr, 8);
>> +            xt.u64[HI_IDX] = cpu_ldq_data_ra(env, addr, GETPC());
>> +            xt.s128 = int128_and(xt.s128, mask_u128(127 - end, 127));
>
> The ISA document says that this is a sequence of byte operations.  Which means
> that END < 127 will not access bytes outside of the length.  Which means that
> your code will trigger SIGSEGV near page boundaries when real hardware
> won't.

In that case, I can use I can use cpu_ldub_data_ra()

> I also don't see how this does the right thing for little-endian.

Needs to be in big-endian order - two things
1) LO/HI swapped
2) No byte swapping

AFAIU the example given in ISA, i see the right output in my test.

Regards
Nikunj
