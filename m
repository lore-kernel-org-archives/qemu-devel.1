Received: from eggs.gnu.org ([2001:4830:134:3::10]:38107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ceEJz-0000dj-IV
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 00:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ceEJv-00083X-Ga
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 00:09:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43880
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ceEJv-00082h-A4
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 00:09:31 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1G594Hr080771
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 00:09:28 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28mygx4arc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 00:09:27 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 16 Feb 2017 15:09:24 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <2094c8e6-2b99-9c09-7eb2-c013dd07ec1e@twiddle.net>
References: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1486636445-24109-6-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170210001035.GJ27610@umbus.fritz.box>
	<87k28yekze.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170214024331.GD2169@umbus.fritz.box>
	<87o9y5eale.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<2094c8e6-2b99-9c09-7eb2-c013dd07ec1e@twiddle.net>
Date: Thu, 16 Feb 2017 10:38:22 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efyy7mex.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH 5/6] target-ppc: support for 32-bit carry
 and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>
Cc: bharata@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Richard Henderson <rth@twiddle.net> writes:

> On 02/14/2017 02:05 PM, Nikunj A Dadhania wrote:
>> Yes, you are right. I had a discussion with Paul Mackerras yesterday, he
>> explained to me in detail about the bits. I am working on the revised
>> implementation. Will detail it in the commit message.
>
> As you're working on this, consider changing the definition of cpu_ov such that 
> the MSB is OV and bit 31 is OV32.
>
> E.g.
>
>
>   static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
>                                              TCGv arg1, TCGv arg2, int sub)
>   {
>       TCGv t0 = tcg_temp_new();
>
>       tcg_gen_xor_tl(cpu_ov, arg0, arg2);
>       tcg_gen_xor_tl(t0, arg1, arg2);
>       if (sub) {
>           tcg_gen_and_tl(cpu_ov, cpu_ov, t0);
>       } else {
>           tcg_gen_andc_tl(cpu_ov, cpu_ov, t0);
>       }
>       tcg_temp_free(t0);
>       if (NARROW_MODE(ctx)) {
>           tcg_gen_ext32s_tl(cpu_ov, cpu_ov);
>       }
> -    tcg_gen_shri_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1);
>       tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
>   }
>
>
> is all that is required for arithmetic to compute OV and OV32 into those two bits.

How about the below?

@@ -809,10 +809,11 @@ static inline void gen_op_arith_compute_ov(DisasContext *ctx, TCGv arg0,
         tcg_gen_andc_tl(cpu_ov, cpu_ov, t0);
     }
     tcg_temp_free(t0);
+    tcg_gen_extract_tl(cpu_ov32, cpu_ov, 31, 1);
+    tcg_gen_extract_tl(cpu_ov, cpu_ov, 63, 1);
     if (NARROW_MODE(ctx)) {
-        tcg_gen_ext32s_tl(cpu_ov, cpu_ov);
+        tcg_gen_mov_tl(cpu_ov, cpu_ov32);
     }
-    tcg_gen_shri_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1);
     tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
 }

Regards
Nikunj
