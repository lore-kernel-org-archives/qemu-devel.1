Received: from eggs.gnu.org ([2001:4830:134:3::10]:44358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRXOX-00013T-FT
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 23:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cRXOU-0004yz-Co
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 23:53:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48397
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cRXOU-0004th-7m
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 23:53:46 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0C4mZEj051495
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 23:53:45 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27x1rcjhbp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 23:53:44 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 10:23:41 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170112024743.GD14026@umbus.fritz.box>
References: <1484038243-30314-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1484038243-30314-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170112024743.GD14026@umbus.fritz.box>
Date: Thu, 12 Jan 2017 10:23:22 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760lkvpz1.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 03/11] target-ppc: Add xsiexpdp instruction
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
> On Tue, Jan 10, 2017 at 02:20:35PM +0530, Nikunj A Dadhania wrote:
>> xsiexpdp: VSX Scalar Insert Exponent Double Precision
>> 
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> ---
>>  target/ppc/translate/vsx-impl.inc.c | 20 ++++++++++++++++++++
>>  target/ppc/translate/vsx-ops.inc.c  |  1 +
>>  2 files changed, 21 insertions(+)
>> 
>> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
>> index 2d9fe50..2d09225 100644
>> --- a/target/ppc/translate/vsx-impl.inc.c
>> +++ b/target/ppc/translate/vsx-impl.inc.c
>> @@ -1243,6 +1243,26 @@ static void gen_xsxexpqp(DisasContext *ctx)
>>      tcg_gen_movi_i64(xtl, 0);
>>  }
>>  
>> +static void gen_xsiexpdp(DisasContext *ctx)
>> +{
>> +    TCGv_i64 xth = cpu_vsrh(xT(ctx->opcode));
>> +    TCGv ra = cpu_gpr[rA(ctx->opcode)];
>> +    TCGv rb = cpu_gpr[rB(ctx->opcode)];
>> +    TCGv_i64 t0;
>> +
>> +    if (unlikely(!ctx->vsx_enabled)) {
>> +        gen_exception(ctx, POWERPC_EXCP_VSXU);
>> +        return;
>> +    }
>> +    t0 = tcg_temp_new_i64();
>> +    tcg_gen_andi_i64(xth, ra, 0x800FFFFFFFFFFFFF);
>> +    tcg_gen_andi_i64(t0, rb, 0x7FF);
>> +    tcg_gen_shli_i64(t0, t0, 52);
>> +    tcg_gen_or_i64(xth, xth, t0);
>> +    /* dword[1] is undefined */
>
> According to the ISA doc I have, dword[1] is set to 0 rather than
> being undefined.

Referring to xsiexpdp on page 570:

"The contents of doubleword element 1 of VSR[XT] are
undefined."

The revision that I have is dated November 30, 2015

Regards,
Nikunj
