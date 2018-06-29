Received: from eggs.gnu.org ([2001:4830:134:3::10]:46269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fYxMU-0000Uv-5V
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fYxMR-0000uW-1x
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:39:10 -0400
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:40773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fYxMQ-0000rM-SS
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:39:06 -0400
Received: by mail-pl0-x230.google.com with SMTP id t6-v6so4787300plo.7
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 10:39:05 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180629162122.19376-1-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <72ef12b4-02b0-2a78-fc1f-18a8c8fd4b40@twiddle.net>
Date: Fri, 29 Jun 2018 10:39:01 -0700
MIME-Version: 1.0
In-Reply-To: <20180629162122.19376-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] tcg: fix TLB miss check in
 get_page_addr_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Vivier <laurent@vivier.eu>

On 06/29/2018 09:21 AM, Peter Maydell wrote:
> In commit 71b9a45330fe220d1 we changed the condition we use to
> determine whether we need to refill the TLB in get_page_addr_code() to
>         if (unlikely(env->tlb_table[mmu_idx][index].addr_code !=
>                      (addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK)))) {
> 
> This isn't the right check (it will falsely fail if the
> input addr happens to have the low bit corresponding to
> TLB_INVALID_MASK set, for instance).
> 
> This patchset first factors out the "check for a hit" logic
> into some new functions tlb_hit() and tlb_hit_page() (the
> latter is for when the address is known to be page-aligned),
> uses those functions in the various places that do TLB hit tests,
> and then uses tlb_hit() to replace the erroneous code in
> get_page_addr_code().
> 
> I noticed this while trying to debug Laurent's m68k test case:
> it meant that we would come into get_page_addr_code() for a
> TLB hit, falsely decide it was a miss, and then fish an
> older entry out of the TLB victim cache...
> 
> 
> Peter Maydell (2):
>   tcg: Define and use new tlb_hit() and tlb_hit_page() functions
>   accel/tcg: Correct "is this a TLB miss" check in get_page_addr_code()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Also, queued to tcg-next.


r~
