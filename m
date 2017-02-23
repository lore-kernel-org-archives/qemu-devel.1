Received: from eggs.gnu.org ([2001:4830:134:3::10]:52738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgnRT-0006v7-OD
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 02:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgnRQ-0004Fh-ME
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 02:03:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58343
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgnRQ-0004EX-Gf
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 02:03:52 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1N6xKVk122533
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 02:03:51 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28sqc6f8q1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 02:03:50 -0500
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 23 Feb 2017 17:03:48 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170223032118.GD12577@umbus.fritz.box>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170223032118.GD12577@umbus.fritz.box>
Date: Thu, 23 Feb 2017 12:32:44 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760k1tmnf.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v3 03/10] target/ppc: support for 32-bit
 carry and overflow
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

> -static void gen_read_xer(TCGv dst)
>> +static void gen_read_xer(DisasContext *ctx, TCGv dst)
>>  {
>>      TCGv t0 = tcg_temp_new();
>>      TCGv t1 = tcg_temp_new();
>> @@ -3715,15 +3719,30 @@ static void gen_read_xer(TCGv dst)
>>      tcg_gen_or_tl(t0, t0, t1);
>>      tcg_gen_or_tl(dst, dst, t2);
>>      tcg_gen_or_tl(dst, dst, t0);
>> +    if (is_isa300(ctx)) {
>> +        tcg_gen_shli_tl(t0, cpu_ov32, XER_OV32);
>> +        tcg_gen_or_tl(dst, dst, t0);
>> +        tcg_gen_shli_tl(t0, cpu_ca32, XER_CA32);
>> +        tcg_gen_or_tl(dst, dst, t0);
>
> Could you use 2 deposits here, instead of 2 shifts and 2 ors?

I checked the implementation of tcg_gen_deposit_i64, resultant will have much
more than 2 shifts + 2 ors.

Regards,
Nikunj
