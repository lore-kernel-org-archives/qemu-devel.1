Received: from eggs.gnu.org ([2001:4830:134:3::10]:57504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eb9Iu-0003GE-UJ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eb9Ir-0006Eq-RE
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:16:16 -0500
Received: from mail-pl0-x234.google.com ([2607:f8b0:400e:c01::234]:44092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eb9Ir-0006EI-KB
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:16:13 -0500
Received: by mail-pl0-x234.google.com with SMTP id f8so2237835plk.11
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 10:16:13 -0800 (PST)
References: <20180113004338.16867-1-laurent@vivier.eu>
	<20180113004338.16867-3-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a9064bda-71c3-5ddf-ac42-76012a9d5248@linaro.org>
Date: Mon, 15 Jan 2018 10:16:09 -0800
MIME-Version: 1.0
In-Reply-To: <20180113004338.16867-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/7] target/m68k: add MC68040 MMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/12/2018 04:43 PM, Laurent Vivier wrote:
> +    ret = get_physical_address(&cpu->env, &physical, &prot,
> +                               address, access_type, &page_size);
> +    if (ret == 0) {
> +        tlb_set_page(cs, address & -page_size,
> +                     physical & -page_size,
> +                     prot, mmu_idx, page_size);
> +        return 0;
> +    }

Having raised TARGET_PAGE_BITS to 12 hasn't eliminated the tlb_add_large_page
path, merely reduced it to when the OS uses 8K pages.

What you'd do to eliminate it is

  if (ret == 0) {
    address &= TARGET_PAGE_MASK;
    physical += address & (page_size - 1);
    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
    return 0;
  }

Note that physical is always already aligned, because we pulled it out of the
page tables that way.


r~
