Received: from eggs.gnu.org ([208.118.235.92]:58957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gfSXt-00081n-74
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gfSXp-0000Rb-Jj
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:42:05 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gfSXp-0000QS-F8
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:42:01 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so32558437oth.7
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 08:42:01 -0800 (PST)
MIME-Version: 1.0
References: <1544063533-10139-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1544063533-10139-4-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1544063533-10139-4-git-send-email-lizhijian@cn.fujitsu.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 4 Jan 2019 17:41:49 +0100
Message-ID: <CAGxU2F4c+xu-fadAEhumc9zt1bSW760D-1hg0foPikAXPQqwOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 3/4] i386: import & use
 bootparam.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>, peter.maydell@linaro.org, philip.li@intel.com, zhijianx.li@intel.com, Philippe Mathieu Daude <philmd@redhat.com>

Hi Li,

On Thu, Dec 6, 2018 at 3:24 AM Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>
> it's from v4.20-rc5.
>
> CC: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>
> ---
> V4: use scirpt to import bootparam.h (Michael S. Tsirkin)
> V3: new patch
>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  hw/i386/pc.c                                 |  8 +------
>  include/standard-headers/asm-x86/bootparam.h | 34 ++++++++++++++++++++++++++++
>  scripts/update-linux-headers.sh              |  4 ++++
>  3 files changed, 39 insertions(+), 7 deletions(-)
>  create mode 100644 include/standard-headers/asm-x86/bootparam.h
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 067d23a..3b10726 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -74,6 +74,7 @@
>  #include "hw/nmi.h"
>  #include "hw/i386/intel_iommu.h"
>  #include "hw/net/ne2000-isa.h"
> +#include "standard-headers/asm-x86/bootparam.h"
>
>  /* debug PC/ISA interrupts */
>  //#define DEBUG_IRQ
> @@ -820,13 +821,6 @@ static long get_file_size(FILE *f)
>      return size;
>  }
>
> -/* setup_data types */
> -#define SETUP_NONE     0
> -#define SETUP_E820_EXT 1
> -#define SETUP_DTB      2
> -#define SETUP_PCI      3
> -#define SETUP_EFI      4
> -
>  struct setup_data {
>      uint64_t next;
>      uint32_t type;
> diff --git a/include/standard-headers/asm-x86/bootparam.h b/include/standard-headers/asm-x86/bootparam.h
> new file mode 100644
> index 0000000..67d4f01
> --- /dev/null
> +++ b/include/standard-headers/asm-x86/bootparam.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _ASM_X86_BOOTPARAM_H
> +#define _ASM_X86_BOOTPARAM_H
> +
> +/* setup_data types */
> +#define SETUP_NONE                     0
> +#define SETUP_E820_EXT                 1
> +#define SETUP_DTB                      2
> +#define SETUP_PCI                      3
> +#define SETUP_EFI                      4
> +#define SETUP_APPLE_PROPERTIES         5
> +#define SETUP_JAILHOUSE                        6
> +
> +/* ram_size flags */
> +#define RAMDISK_IMAGE_START_MASK       0x07FF
> +#define RAMDISK_PROMPT_FLAG            0x8000
> +#define RAMDISK_LOAD_FLAG              0x4000
> +
> +/* loadflags */
> +#define LOADED_HIGH    (1<<0)
> +#define KASLR_FLAG     (1<<1)
> +#define QUIET_FLAG     (1<<5)
> +#define KEEP_SEGMENTS  (1<<6)
> +#define CAN_USE_HEAP   (1<<7)
> +
> +/* xloadflags */
> +#define XLF_KERNEL_64                  (1<<0)
> +#define XLF_CAN_BE_LOADED_ABOVE_4G     (1<<1)
> +#define XLF_EFI_HANDOVER_32            (1<<2)
> +#define XLF_EFI_HANDOVER_64            (1<<3)
> +#define XLF_EFI_KEXEC                  (1<<4)
> +
> +
> +#endif /* _ASM_X86_BOOTPARAM_H */
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 0a964fe..77ec108 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -120,6 +120,10 @@ for arch in $ARCHLIST; do
>          cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
>          cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
>          cp_portable "$tmpdir/include/asm/kvm_para.h" "$output/include/standard-headers/asm-$arch"
> +        # Remove everything except the macros from bootparam.h avoiding the
> +        # unnecessary import of several video/ist/etc headers
> +        sed -e '/__ASSEMBLY__/,/__ASSEMBLY__/d' $tmpdir/include/asm/bootparam.h > $tmpdir/bootparam.h
> +        cp_portable $tmpdir/bootparam.h "$output/include/standard-headers/asm-$arch"

Maybe is better to use the double quotes for all paths.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>      fi
>  done
>
> --
> 2.7.4
>
>
