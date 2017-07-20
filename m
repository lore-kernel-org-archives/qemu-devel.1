Received: from eggs.gnu.org ([2001:4830:134:3::10]:57816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY6SF-0006D5-7S
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY6SA-00010e-5J
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:05:03 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:33450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dY6SA-00010U-1K
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:04:58 -0400
Received: by mail-qt0-x22f.google.com with SMTP id n42so16153068qtn.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 01:04:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-43-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8f18a24d-01f8-7b57-33ef-f89939acd3c6@twiddle.net>
Date: Wed, 19 Jul 2017 22:04:50 -1000
MIME-Version: 1.0
In-Reply-To: <1500520169-23367-43-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 42/43] tcg: introduce regions to split
 code_gen_buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/19/2017 05:09 PM, Emilio G. Cota wrote:
> +    /* We do not yet support multiple TCG contexts, so use one region for now */
> +    n_regions = 1;
> +
> +    /* start on a page-aligned address */
> +    buf = QEMU_ALIGN_PTR_UP(buf, qemu_real_host_page_size);
> +    g_assert(buf < tcg_init_ctx.code_gen_buffer + size);
> +
> +    /* discard that initial portion */
> +    size -= buf - tcg_init_ctx.code_gen_buffer;

It seems pointless wasting most of a page after the prologue when n_regions == 
1.  We don't really need to start on a page boundary in that case.

> +    /* make region_size a multiple of page_size */
> +    region_size = size / n_regions;
> +    region_size = QEMU_ALIGN_DOWN(region_size, qemu_real_host_page_size);

This division can result in a number of pages at the end of the region being 
unused.  Is it worthwhile freeing them?  Or marking them mprotect_none along 
with the last guard page?


r~
