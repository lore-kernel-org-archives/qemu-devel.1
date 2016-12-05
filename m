Received: from eggs.gnu.org ([2001:4830:134:3::10]:60630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDvbl-00026S-6K
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDvbg-00048E-D2
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:55:13 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cDvbg-00047k-9D
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:55:08 -0500
Received: by mail-qk0-x243.google.com with SMTP id h201so39909765qke.3
	for <qemu-devel@nongnu.org>; Mon, 05 Dec 2016 07:55:08 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1480600329-16272-1-git-send-email-jinguojie@loongson.cn>
	<7b7aaab8-f27e-4d0f-8864-302ac0ab4722@twiddle.net>
	<tencent_5403D2430F3FB2F62D8E902C@qq.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0ba48409-fdff-9df2-422a-662650da7c99@twiddle.net>
Date: Mon, 5 Dec 2016 07:55:04 -0800
MIME-Version: 1.0
In-Reply-To: <tencent_5403D2430F3FB2F62D8E902C@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/10] tcg mips64 and mips r6
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jin Guojie <jinguojie@loongson.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, James Hogan <james.hogan@imgtec.com>, YunQiang Su <wzssyqa@gmail.com>

On 12/05/2016 01:41 AM, Jin Guojie wrote:
> ------------------ Original ------------------
> From:  "Richard Henderson";<rth@twiddle.net>;
> Send time: Thursday, Dec 1, 2016 11:52 PM
> To: "Jin Guojie"<jinguojie@loongson.cn>; "qemu-devel"<qemu-devel@nongnu.org>;
> Cc: "Aurelien Jarno"<aurelien@aurel32.net>; "James Hogan"<james.hogan@imgtec.com>;
> Subject:  Re: [PATCH v5 00/10] tcg mips64 and mips r6 improvements
> 
> Thanks a lot for Richard's careful review.
> I have some different opinions for discussion:
> 
>>  @@ -1233,7 +1235,8 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg base,
>>  -    mask = (target_ulong)TARGET_PAGE_MASK | ((1 << a_bits) - 1);
>>  +    mask = TARGET_PAGE_MASK | ((1 << a_bits) - 1);
>> You need the target_ulong cast here for mips64.
>> See patch ebb90a005da67147245cd38fb04a965a87a961b7.
> 
> Since mask is defined as a C type "target_ulong" at the beginning of the function, 
> I guess an implicit type cast should be already done by the compiler.
> So your change is functionally the same with v5 patch. 
> To test my idea, I wrote a small case and compiled it on an x86_64 host:
> 
> main()
> {
>   int a_bits = 2;
>   int page_mask = 0xfffff000;    /* X86 4KB page*/
>   unsigned int mask = page_mask | ((1 << a_bits) - 1);
>   unsigned long m = mask;
>   printf("mask=%lx\n", m);
> }
> 
> $ gcc a.c
> $ file a.out 
> a.out: Mach-O 64-bit executable x86_64
> $ ./a.out
> mask=fffff003

You misunderstand.  For a 64-bit guest, the result we're looking for is
0xfffffffffffff003.

(1) the type of a_bits is unsigned int, not int,
(2) which means the expression "page_mask | ((1 << a_bits) - 1)"
    becomes unsigned int,
(3) which means that the assignment to mask gets truncated.

> The output is exactly an unsigned 32-bit quantity.
> I didn't see a wrong result generated. 
> Could you teach me where is my mistake?

For a 64-bit guest we need a 64-bit quantity.  For a 32-bit guest... we need to
match the load that we issue from cmp_off.  If use use LWU, then we need an
unsigned 32-bit quantity; if we use LW, then we need a signed 32-bit quantity.


r~
