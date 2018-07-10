Received: from eggs.gnu.org ([2001:4830:134:3::10]:59502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fcpEo-0007sh-4j
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fcpEj-00088t-7A
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:47:14 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:43964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fcpEi-00088a-TS
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:47:09 -0400
References: <20180709191529.13080-1-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a964f8f3-b30d-b23e-d4d3-b3213943bead@vivier.eu>
Date: Tue, 10 Jul 2018 11:47:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180709191529.13080-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix shmat emulation by
 honoring host SHMLBA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le 09/07/2018 à 21:15, Richard Henderson a écrit :
> For those hosts with SHMLBA > getpagesize, we don't automatically
> select a guest address that is compatible with the host.  We can
> achieve this by boosting the alignment of guest_base and by adding
> an extra alignment argument to mmap_find_vma.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
...
> @@ -299,7 +303,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
>          if (h2g_valid(ptr + size - 1)) {
>              addr = h2g(ptr);
>  
> -            if ((addr & ~TARGET_PAGE_MASK) == 0) {
> +            if ((addr & (align - 1)) == 0) {

so ~TARGET_PAGE_MASK is (align - 1)...

>                  /* Success.  */
>                  if (start == mmap_next_start && addr >= TASK_UNMAPPED_BASE) {
>                      mmap_next_start = addr + size;
> @@ -313,12 +317,12 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
>                  /* Assume the result that the kernel gave us is the
>                     first with enough free space, so start again at the
>                     next higher target page.  */
> -                addr = TARGET_PAGE_ALIGN(addr);
> +                addr = ROUND_UP(addr, align);
>                  break;
>              case 1:
>                  /* Sometimes the kernel decides to perform the allocation
>                     at the top end of memory instead.  */
> -                addr &= TARGET_PAGE_MASK;
> +                addr &= align - 1;

and here TARGET_PAGE_MASK is also (align - 1)...

So I think it should be "addr &= -align".

Thanks,
Laurent
