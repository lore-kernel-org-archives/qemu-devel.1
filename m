Received: from eggs.gnu.org ([2001:4830:134:3::10]:59055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drjeE-0004qS-08
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drjeA-000458-T6
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:46:34 -0400
References: <20170911200002.4511-1-n54@gmx.com>
	<20170911201610.15204-1-n54@gmx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8fbe987a-99cf-4213-486d-547db87cab55@redhat.com>
Date: Tue, 12 Sep 2017 13:46:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170911201610.15204-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] Replace round_page() with
 TARGET_PAGE_ALIGN()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 11.09.2017 22:16, Kamil Rytarowski wrote:
> This change fixes conflict with the DragonFly BSD headers.
> 
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  hw/ppc/mac_newworld.c | 11 +++--------
>  hw/ppc/mac_oldworld.c | 11 +++--------
>  2 files changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index d466634997..51bf83019b 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -124,11 +124,6 @@ static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
>      return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
>  }
>  
> -static hwaddr round_page(hwaddr addr)
> -{
> -    return (addr + TARGET_PAGE_SIZE - 1) & TARGET_PAGE_MASK;
> -}
> -
>  static void ppc_core99_reset(void *opaque)
>  {
>      PowerPCCPU *cpu = opaque;
> @@ -256,7 +251,7 @@ static void ppc_core99_init(MachineState *machine)
>          }
>          /* load initrd */
>          if (initrd_filename) {
> -            initrd_base = round_page(kernel_base + kernel_size + KERNEL_GAP);
> +            initrd_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
>              initrd_size = load_image_targphys(initrd_filename, initrd_base,
>                                                ram_size - initrd_base);
>              if (initrd_size < 0) {
> @@ -264,11 +259,11 @@ static void ppc_core99_init(MachineState *machine)
>                               initrd_filename);
>                  exit(1);
>              }
> -            cmdline_base = round_page(initrd_base + initrd_size);
> +            cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
>          } else {
>              initrd_base = 0;
>              initrd_size = 0;
> -            cmdline_base = round_page(kernel_base + kernel_size + KERNEL_GAP);
> +            cmdline_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
>          }
>          ppc_boot_device = 'm';
>      } else {
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index fcac399562..feb31911ca 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -66,11 +66,6 @@ static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
>      return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
>  }
>  
> -static hwaddr round_page(hwaddr addr)
> -{
> -    return (addr + TARGET_PAGE_SIZE - 1) & TARGET_PAGE_MASK;
> -}
> -
>  static void ppc_heathrow_reset(void *opaque)
>  {
>      PowerPCCPU *cpu = opaque;
> @@ -191,7 +186,7 @@ static void ppc_heathrow_init(MachineState *machine)
>          }
>          /* load initrd */
>          if (initrd_filename) {
> -            initrd_base = round_page(kernel_base + kernel_size + KERNEL_GAP);
> +            initrd_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
>              initrd_size = load_image_targphys(initrd_filename, initrd_base,
>                                                ram_size - initrd_base);
>              if (initrd_size < 0) {
> @@ -199,11 +194,11 @@ static void ppc_heathrow_init(MachineState *machine)
>                               initrd_filename);
>                  exit(1);
>              }
> -            cmdline_base = round_page(initrd_base + initrd_size);
> +            cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
>          } else {
>              initrd_base = 0;
>              initrd_size = 0;
> -            cmdline_base = round_page(kernel_base + kernel_size + KERNEL_GAP);
> +            cmdline_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
>          }
>          ppc_boot_device = 'm';
>      } else {
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

(and please make sure to CC: qemu-ppc@nongnu.org for ppc related changes)
