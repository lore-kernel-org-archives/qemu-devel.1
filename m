Received: from eggs.gnu.org ([2001:4830:134:3::10]:33557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eXvRN-0000Zz-1b
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 15:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eXvRJ-0001qh-4t
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 15:51:41 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:54529)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eXvRI-0001pd-OI
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 15:51:37 -0500
References: <1515258013-85745-1-git-send-email-riemensberger@cadami.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0ab16158-74fa-3db1-1e62-2dba5fc9659a@vivier.eu>
Date: Sat, 6 Jan 2018 21:51:22 +0100
MIME-Version: 1.0
In-Reply-To: <1515258013-85745-1-git-send-email-riemensberger@cadami.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user/mmap.c: Avoid choosing NULL as
 start address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maximilian Riemensberger <riemensberger@cadami.net>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>

Le 06/01/2018 à 18:00, Maximilian Riemensberger a écrit :
> mmap() is required by the linux kernel ABI and POSIX to return a
> non-NULL address when the implementation chooses a start address for the
> mapping.
> 
> The current implementation of mmap_find_vma_reserved() can return NULL
> as start address of a mapping which leads to subsequent crashes inside
> the guests glibc, e.g. output of qemu-arm-static --strace executing a
> test binary stx_test:
> 
>     1879 mmap2(NULL,8388608,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|0x20000,-1,0) = 0x00000000
>     1879 write(2,0xf6fd39d0,79) stx_test: allocatestack.c:514: allocate_stack: Assertion `mem != NULL' failed.
> 
> This patch fixes mmap_find_vma_reserved() by skipping NULL as start
> address while searching for a suitable mapping start address.
> 
> CC: Riku Voipio <riku.voipio@iki.fi>
> CC: Laurent Vivier <laurent@vivier.eu>
> CC: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Maximilian Riemensberger <riemensberger@cadami.net>
> ---
>  linux-user/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 4888f53..20cc5a7 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -221,7 +221,7 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size)
>      addr = end_addr - qemu_host_page_size;
>  
>      while (1) {
> -        if (addr > end_addr) {
> +        if (!addr || addr > end_addr) {
>              if (looped) {
>                  return (abi_ulong)-1;
>              }

I think this is correct, but it would be clearer to not exit the loop if
addr is NULL, something like:

@@ -234,7 +234,7 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong
start, abi_ulong size)
         if (prot) {
             end_addr = addr;
         }
-        if (addr + size == end_addr) {
+        if (addr && addr + size == end_addr) {
             break;
         }
         addr -= qemu_host_page_size;

The result is the same because with the "addr -= qemu_host_page_size"
addr becomes greater than end_addr on the next loop.

Thanks,
Laurent
