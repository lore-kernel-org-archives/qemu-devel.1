Received: from eggs.gnu.org ([209.51.188.92]:53825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnAux-0004RL-Go
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnAuv-0002u7-JW
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:29:46 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnAuu-0002lv-R1
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:29:45 -0500
Received: by mail-pl1-x641.google.com with SMTP id w4so5245881plz.1
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 15:29:31 -0800 (PST)
References: <1648289.tQCHxfjYn9@basile.remlab.net>
	<20190125214926.3204-1-remi@remlab.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <02a680e1-c20c-2ecb-2926-6250fddf9e76@linaro.org>
Date: Fri, 25 Jan 2019 15:29:27 -0800
MIME-Version: 1.0
In-Reply-To: <20190125214926.3204-1-remi@remlab.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] target/arm: fix AArch64 virtual
 address space size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?R=c3=a9mi_Denis-Courmont?= <remi@remlab.net>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org

On 1/25/19 1:49 PM, Rémi Denis-Courmont wrote:
> From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> Since QEMU does not support the ARMv8.2-LVA, Large Virtual Address,
> extension (yet), the VA address space is signed 48-bits. User mode can
> only handle the positive half of the address space, so that makes a
> limit of 47 bits.
> 
> (With LVA, it would be 52 and 51 bits respectively.)
> 
> The incorrectly large address space conflicts with PAuth instructions,
> which bits 48-54 and 56-63 for the pointer authentication code. This
> also conflicts with (as yet unsupported by QEMU) data tagging and with
> the ARMv8.5-MTE extension.
> 
> Signed-off-by: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index ff81db420d..2ccd04b8f7 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2503,7 +2503,7 @@ bool write_cpustate_to_list(ARMCPU *cpu);
>  
>  #if defined(TARGET_AARCH64)
>  #  define TARGET_PHYS_ADDR_SPACE_BITS 48
> -#  define TARGET_VIRT_ADDR_SPACE_BITS 64
> +#  define TARGET_VIRT_ADDR_SPACE_BITS 47
>  #else
>  #  define TARGET_PHYS_ADDR_SPACE_BITS 40
>  #  define TARGET_VIRT_ADDR_SPACE_BITS 32
> 


This doesn't really conflict, as this doesn't affect much besides the sizing of
the PageDesc for page_find.

It's true adjusting this is worthwhile.  The current setting requires 7 levels
(6 * 10 bits + 1 * 4 bits), whereas a 48-bit address space only requires 5
levels (4 * 10 bits + 8 bits).  Even for LVA it will be (4 * 10 + 1 * 12 bits).

This will both save memory and reduce the time required for TranlationBlock
maintenance.

Your choice of 47 is wrong.  This value is also used for system mode, and the
kernel does use the negative half of the address space, so we need to have all
48 bits here.


r~
