Received: from eggs.gnu.org ([2001:4830:134:3::10]:58306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cglJe-0002E2-2N
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cglJa-0006lL-W7
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:47:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47882
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cglJa-0006lE-Pz
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:47:38 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1N4i8f8008727
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 23:47:37 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28sjf0d823-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 23:47:36 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 23 Feb 2017 14:47:33 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <945770e2-dff8-1344-d445-85deaa15e8f0@twiddle.net>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-7-git-send-email-nikunj@linux.vnet.ibm.com>
	<945770e2-dff8-1344-d445-85deaa15e8f0@twiddle.net>
Date: Thu, 23 Feb 2017 10:16:20 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87fuj5tsyr.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v3 06/10] target/ppc: update overflow flags
 for add/sub
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

> On 02/22/2017 10:44 PM, Nikunj A Dadhania wrote:
>> * SO and OV reflects overflow of the 64-bit result in 64-bit mode and
>>   overflow of the low-order 32-bit result in 32-bit mode
>>
>> * OV32 reflects overflow of the low-order 32-bit independent of the mode
>>
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> ---
>>  target/ppc/translate.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index f3f92aa..43366e7 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -809,10 +809,19 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
>>          tcg_gen_andc_tl(cpu_ov, cpu_ov, t0);
>>      }
>>      tcg_temp_free(t0);
>> -    if (NARROW_MODE(ctx)) {
>> -        tcg_gen_ext32s_tl(cpu_ov, cpu_ov);
>> +    if (is_isa300(ctx)) {
>> +        tcg_gen_extract_tl(cpu_ov32, cpu_ov, 31, 1);
>> +        if (NARROW_MODE(ctx)) {
>> +            tcg_gen_mov_tl(cpu_ov, cpu_ov32);
>> +        } else {
>> +            tcg_gen_extract_tl(cpu_ov, cpu_ov, 63, 1);
>> +        }
>> +    } else {
>> +        if (NARROW_MODE(ctx)) {
>> +            tcg_gen_ext32s_tl(cpu_ov, cpu_ov);
>> +        }
>> +        tcg_gen_shri_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1);
>>      }
>> -    tcg_gen_shri_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1);
>
> We're computing this two different ways for no reason.  How about
>
>    if (NARROW_MODE(ctx)) {
>      tcg_gen_extract_tl(cpu_ov, cpu_ov, 31, 1);
>      if (is_isa300(ctx)) {
>          tcg_gen_mov_tl(cpu_ov32, cpu_ov);
>      }
>    } else {
>      if (is_isa300(ctx)) {
>          tcg_gen_extract_tl(cpu_ov32, cpu_ov, 31, 1);
>      }
>      tcg_gen_extract_tl(cpu_ov, cpu_ov, 63, 1);
>    }

Yes, no need to extend-sign and shift. Will incorparate.

Regards
Nikunj
