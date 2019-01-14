Received: from eggs.gnu.org ([209.51.188.92]:56021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj6Qy-0001A5-FO
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 12:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj6Qx-0004X3-GF
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 12:54:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gj6Qx-0004VH-7i
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 12:53:59 -0500
Date: Mon, 14 Jan 2019 15:53:48 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190114175348.GY4500@habkost.net>
References: <1547197071-14504-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1547197071-14504-5-git-send-email-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547197071-14504-5-git-send-email-lizhijian@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v5 4/4] i386: allow to load initrd below 4G
 for recent linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com, zhijianx.li@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Fri, Jan 11, 2019 at 04:57:51PM +0800, Li Zhijian wrote:
> Since linux commit: cf8fa920cb42 ("i386: handle an initrd in highmem (version 2)")
> linux has supported initrd up to 4 GB, but the header field
> ramdisk_max is still set to 2 GB to avoid "possible bootloader bugs".
> 
> When use '-kernel vmlinux -initrd initrd.cgz' to launch a VM,
> the firmware(it could be linuxboot_dma.bin) helps to read initrd
> contents into guest memory(below ramdisk_max) and jump to kernel.
> that's similar with what bootloader does, like grub.
> 
> In addition, initrd_max is uint32_t simply because QEMU doesn't support
> the 64-bit boot protocol (specifically the ext_ramdisk_image field).
> 
> Therefore here just limit initrd_max to UINT32_MAX simply as well to
> allow initrd to be loaded below 4 GB.
> 
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> 
> ---
> V5: udpate comments and changelog
> V3: correct grammar and check XLF_CAN_BE_LOADED_ABOVE_4G first (Michael S. Tsirkin)
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  hw/i386/pc.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 89c25b2..ea7a3c7 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -904,7 +904,29 @@ static void load_linux(PCMachineState *pcms,
>  #endif
>  
>      /* highest address for loading the initrd */
> -    if (protocol >= 0x203) {
> +    if (protocol >= 0x20c &&
> +        lduw_p(header+0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
> +        /*
> +         * Linux has supported initrd up to 4 GB for a very long time (2007,
> +         * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2013),
> +         * though it only sets initrd_max to 2 GB to "work around bootloader
> +         * bugs". Luckily, QEMU firmware(which does something like bootloader)
> +         * has supported this.
> +         *
> +         * It's believed that if XLF_CAN_BE_LOADED_ABOVE_4G is set, initrd can
> +         * be loaded into any address.
> +         *
> +         * In addition, initrd_max is uint32_t simply because QEMU doesn't
> +         * support the 64-bit boot protocol (specifically the ext_ramdisk_image
> +         * field).
> +         *
> +         * Therefore here just limit initrd_max to UINT32_MAX simply as well.
> +         *
> +         * FIXME: it's possible that linux protocol within [0x208, 0x20c]
> +         * supports up to 4G initrd as well.

I don't understand what exactly this FIXME comment is
documenting.  What exactly needs to be fixed?


> +         */
> +        initrd_max = UINT32_MAX;
> +    } else if (protocol >= 0x203) {
>          initrd_max = ldl_p(header+0x22c);
>      } else {
>          initrd_max = 0x37ffffff;
> -- 
> 2.7.4
> 

-- 
Eduardo
