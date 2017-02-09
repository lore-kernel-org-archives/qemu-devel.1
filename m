Received: from eggs.gnu.org ([2001:4830:134:3::10]:40777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbgvj-00068M-D7
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbgvf-0003d4-Bc
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:06:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55753
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cbgvf-0003cc-6g
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:05:59 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1950T7i139752
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 00:05:58 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28gcrj9xy7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 00:05:58 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 9 Feb 2017 10:35:54 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170209012033.GM17644@umbus.fritz.box>
References: <1486377000-25701-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1486377000-25701-2-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170209012033.GM17644@umbus.fritz.box>
Date: Thu, 09 Feb 2017 10:35:48 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zihwdkcz.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 1/4] target-ppc: implement load atomic
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, Balamuruhan S <bala24@linux.vnet.ibm.com>, Harish S <harisrir@linux.vnet.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>

David Gibson <david@gibson.dropbear.id.au> writes:

> [ Unknown signature status ]
> On Mon, Feb 06, 2017 at 03:59:57PM +0530, Nikunj A Dadhania wrote:
>> From: Balamuruhan S <bala24@linux.vnet.ibm.com>
>> 
>> lwat: Load Word Atomic
>> ldat: Load Doubleword Atomic
>> 
>> The instruction includes as function code (5 bits) which gives a detail
>> on the operation to be performed. The patch implements five such
>> functions.
>> 
>> Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
>> Signed-off-by: Harish S <harisrir@linux.vnet.ibm.com>
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> [ combine both lwat/ldat implementation using macro ]
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> ---
>>  target/ppc/internal.h  |  2 ++
>>  target/ppc/translate.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 52 insertions(+)
>> 
>> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
>> index 5b5b180..1f441c6 100644
>> --- a/target/ppc/internal.h
>> +++ b/target/ppc/internal.h
>> @@ -133,6 +133,8 @@ EXTRACT_HELPER(UIMM4, 16, 4);
>>  EXTRACT_HELPER(NB, 11, 5);
>>  /* Shift count */
>>  EXTRACT_HELPER(SH, 11, 5);
>> +/* lwat/stwat/ldat/lwat */
>> +EXTRACT_HELPER(FC, 11, 5);
>>  /* Vector shift count */
>>  EXTRACT_HELPER(VSH, 6, 4);
>>  /* Mask start */
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index b48abae..f59184f 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -2976,6 +2976,54 @@ LARX(lbarx, DEF_MEMOP(MO_UB))
>>  LARX(lharx, DEF_MEMOP(MO_UW))
>>  LARX(lwarx, DEF_MEMOP(MO_UL))
>>  
>> +#define LD_ATOMIC(name, memop, tp, op, eop)                             \
>> +static void gen_##name(DisasContext *ctx)                               \
>> +{                                                                       \
>> +    int len = MEMOP_GET_SIZE(memop);                                    \
>> +    uint32_t gpr_FC = FC(ctx->opcode);                                  \
>> +    TCGv EA = tcg_temp_local_new();                                     \
>> +    TCGv_##tp t0, t1;                                                   \
>> +                                                                        \
>> +    gen_addr_register(ctx, EA);                                         \
>> +    if (len > 1) {                                                      \
>> +        gen_check_align(ctx, EA, len - 1);                              \
>> +    }                                                                   \
>> +    t0 = tcg_temp_new_##tp();                                           \
>> +    t1 = tcg_temp_new_##tp();                                           \
>> +    tcg_gen_##op(t0, cpu_gpr[rD(ctx->opcode) + 1]);                     \
>> +                                                                        \
>> +    switch (gpr_FC) {                                                   \
>> +    case 0: /* Fetch and add */                                         \
>> +        tcg_gen_atomic_fetch_add_##tp(t1, EA, t0, ctx->mem_idx, memop); \
>> +        break;                                                          \
>> +    case 1: /* Fetch and xor */                                         \
>> +        tcg_gen_atomic_fetch_xor_##tp(t1, EA, t0, ctx->mem_idx, memop); \
>> +        break;                                                          \
>> +    case 2: /* Fetch and or */                                          \
>> +        tcg_gen_atomic_fetch_or_##tp(t1, EA, t0, ctx->mem_idx, memop);  \
>> +        break;                                                          \
>> +    case 3: /* Fetch and 'and' */                                       \
>> +        tcg_gen_atomic_fetch_and_##tp(t1, EA, t0, ctx->mem_idx, memop); \
>> +        break;                                                          \
>> +    case 8: /* Swap */                                                  \
>> +        tcg_gen_atomic_xchg_##tp(t1, EA, t0, ctx->mem_idx, memop);      \
>> +        break;                                                          \
>> +    default:                                                            \
>> +        /* invoke data storage error handler */                         \
>> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);             \
>
> Both your comment and the ISA say that an invalid FC will result in a
> data storage (0x300) exception, but here you seem to be invoking an
> invalid instruction exception (0x700).  Which is correct?

Ah ok, as there are other FC that is not implemented yet in this
version, it was set as INVALID. Let me separate it out as:

case 4:
case 5:
[...]
        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
        break;
default:
        /* invoke data storage error handler */
        gen_exception_err(ctx, POWERPC_EXCP_DSI, 0);
}

Will send updated patch.

Regards
Nikunj
