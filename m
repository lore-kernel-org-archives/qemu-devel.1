Received: from eggs.gnu.org ([2001:4830:134:3::10]:41003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fMDNA-0001iI-RK
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fMDN5-0002gM-1I
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:07:12 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fMDN4-0002ew-Os
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:07:06 -0400
Received: by mail-wm0-x241.google.com with SMTP id q4-v6so13565583wmq.1
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:07:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180423162523.6392-1-f4bug@amsat.org>
	<20180423162523.6392-3-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41c1c574-da5c-654a-f993-4b87e089380e@redhat.com>
Date: Fri, 25 May 2018 16:07:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180423162523.6392-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] loader: Fix 64-bit misaligned
 member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paul Burton <paul.burton@mips.com>, qemu-devel@nongnu.org

On 23/04/2018 18:25, Philippe Mathieu-Daudé wrote:
> The libfdt does not guarantee than fdt_getprop() returns a pointer
> aligned to the property size.
> 
> Assuming the base of the fdt is aligned, a 32-bit property returns
> a 32-bit aligned pointer. This is however not guaranteed for 64-bit
> properties, where 64-bit loads might trigger unaligned access.
> 
> Fix this issue by using the ldst (host) API, which does a local copy
> on the stack, thus guaranteeing a safe aligned access.
> 
> This fixes the following ASan warning:
> 
>   $ mips64el-softmmu/qemu-system-mips64el -M boston -kernel vmlinux.gz.itb -nographic
>   hw/core/loader-fit.c:108:17: runtime error: load of misaligned address 0x7f95cd7e4264 for type 'fdt64_t', which requires 8 byte alignment
>   0x7f95cd7e4264: note: pointer points here
>     00 00 00 3e ff ff ff ff  80 7d 2a c0 00 00 00 01  68 61 73 68 40 30 00 00  00 00 00 03 00 00 00 14
>                 ^
> 
> Reported-by: AddressSanitizer
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/core/loader-fit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
> index 0c4a7207f4..628f854636 100644
> --- a/hw/core/loader-fit.c
> +++ b/hw/core/loader-fit.c
> @@ -102,10 +102,10 @@ static int fit_image_addr(const void *itb, int img, const char *name,
>  
>      switch (len) {
>      case 4:
> -        *addr = fdt32_to_cpu(*(fdt32_t *)prop);
> +        *addr = fdt32_to_cpu(ldl_he_p(prop));
>          return 0;
>      case 8:
> -        *addr = fdt64_to_cpu(*(fdt64_t *)prop);
> +        *addr = fdt64_to_cpu(ldq_he_p(prop));
>          return 0;
>      default:
>          error_printf("invalid %s address length %d\n", name, len);
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
