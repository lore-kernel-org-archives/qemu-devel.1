Received: from eggs.gnu.org ([2001:4830:134:3::10]:48663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgn4o-0007hh-Tc
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgn4l-0006gX-01
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:40:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgn4k-0006gH-LO
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:40:26 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1N6ca9E136164
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:40:23 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28sn43b9y0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 01:40:22 -0500
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 23 Feb 2017 12:10:19 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <913ec2bb-2fd4-3488-e142-75d3574dfaf1@twiddle.net>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<913ec2bb-2fd4-3488-e142-75d3574dfaf1@twiddle.net>
Date: Thu, 23 Feb 2017 12:10:14 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a89dtnox.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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
To: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

Richard Henderson <rth@twiddle.net> writes:

> Bah.  Hit return too soon...
>
> On 02/22/2017 10:44 PM, Nikunj A Dadhania wrote:
>> -static void gen_read_xer(TCGv dst)
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
>> +    }
>>      tcg_temp_free(t0);
>>      tcg_temp_free(t1);
>>      tcg_temp_free(t2);
>>  }
>>
>> -static void gen_write_xer(TCGv src)
>> +static void gen_write_xer(DisasContext *ctx, TCGv src)
>>  {
>> -    tcg_gen_andi_tl(cpu_xer, src,
>> -                    ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA)));
>> +    if (is_isa300(ctx)) {
>> +        tcg_gen_andi_tl(cpu_xer, src,
>> +                        ~((1u << XER_SO) |
>> +                          (1u << XER_OV) | (1u << XER_OV32) |
>> +                          (1u << XER_CA) | (1u << XER_CA32)));
>> +        tcg_gen_extract_tl(cpu_ov32, src, XER_OV32, 1);
>> +        tcg_gen_extract_tl(cpu_ca32, src, XER_CA32, 1);
>> +    } else {
>> +        tcg_gen_andi_tl(cpu_xer, src,
>> +                        ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA)));
>> +    }
>>      tcg_gen_extract_tl(cpu_so, src, XER_SO, 1);
>>      tcg_gen_extract_tl(cpu_ov, src, XER_OV, 1);
>>      tcg_gen_extract_tl(cpu_ca, src, XER_CA, 1);
>
> These functions are becoming quite large.  Are they performance critical enough 
> that they need to stay as inline code, or should they be moved to helpers and 
> share code with cpu_read/write_xer?

Just to boot to login prompt, these are the numbers for gen_read/write_xer:

helper_myprint - rd_count 231103, wr_count 68897

And it keeps on incrementing, maybe scope of optimization here.

Regards
Nikunj
