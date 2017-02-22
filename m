Received: from eggs.gnu.org ([2001:4830:134:3::10]:46561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgUdP-0001p0-U9
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgUdL-0007p7-K3
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:59:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgUdL-0007ol-As
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:58:55 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MArnv6140210
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 05:58:54 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28s7ww3ngx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 05:58:53 -0500
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 16:28:50 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <64842dbd-8b97-0ccd-28d8-89f73a625b44@twiddle.net>
References: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487755788-16415-6-git-send-email-nikunj@linux.vnet.ibm.com>
	<64842dbd-8b97-0ccd-28d8-89f73a625b44@twiddle.net>
Date: Wed, 22 Feb 2017 16:28:45 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <874lzmbifu.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v2 05/11] target/ppc: update ca32 in
 arithmetic substract
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

> On 02/22/2017 08:29 PM, Nikunj A Dadhania wrote:
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> ---
>>  target/ppc/translate.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index b589d09..184d10f 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -827,7 +827,15 @@ static inline void gen_op_arith_compute_ca32(DisasContext *ctx,
>>      }
>>
>>      t0 = tcg_temp_new();
>> -    tcg_gen_xor_tl(t0, arg0, arg1);
>> +    if (!add_ca && sub) {
>
> I think checking add_ca is wrong.  And note that it is otherwise unused.

Yes, as suggested below (making last parameter as 0), I can just check
on "sub"

>> +        /* Invert arg0 before xor as in the !add_ca case,
>> +         * we do not get inverse of arg0
>> +         */
>> +        tcg_gen_not_tl(t0, arg0);
>> +        tcg_gen_xor_tl(t0, t0, arg1);
>> +    } else {
>> +        tcg_gen_xor_tl(t0, arg0, arg1);
>> +    }
>>      tcg_gen_xor_tl(t0, t0, res);
>>      tcg_gen_extract_tl(cpu_ca32, t0, 32, 1);
>>      tcg_temp_free(t0);
>> @@ -1382,11 +1390,13 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
>>              zero = tcg_const_tl(0);
>>              tcg_gen_add2_tl(t0, cpu_ca, arg2, zero, cpu_ca, zero);
>>              tcg_gen_add2_tl(t0, cpu_ca, t0, cpu_ca, inv1, zero);
>> +            gen_op_arith_compute_ca32(ctx, t0, inv1, arg2, add_ca, 1);
>
> The last parameter here should be 0.

Sure.

Regards
Nikunj
