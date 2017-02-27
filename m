Received: from eggs.gnu.org ([2001:4830:134:3::10]:48600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ciR6W-0000H4-A4
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ciR6R-0001Zn-De
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:37:04 -0500
References: <1485377117-18105-1-git-send-email-thuth@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f524e29d-6e8c-19b0-e170-2a6876cbfe69@redhat.com>
Date: Mon, 27 Feb 2017 20:36:56 +0100
MIME-Version: 1.0
In-Reply-To: <1485377117-18105-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix crash when
 running without CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Trivial <qemu-trivial@nongnu.org>

On 25.01.2017 21:45, Thomas Huth wrote:
> When running QEMU with "-M none -device loader,file=kernel.elf", it
> currently crashes with a segmentation fault, because the "none"-machine
> does not have any CPU by default and the generic loader code tries
> to dereference s->cpu. Fix it by adding an appropriate check for a
> NULL pointer.
> 
> Reported-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/core/generic-loader.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index 58f1f02..4601267 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -137,20 +137,21 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
>  #endif
>  
>      if (s->file) {
> +        AddressSpace *as = s->cpu ? s->cpu->as :  NULL;
> +
>          if (!s->force_raw) {
>              size = load_elf_as(s->file, NULL, NULL, &entry, NULL, NULL,
> -                               big_endian, 0, 0, 0, s->cpu->as);
> +                               big_endian, 0, 0, 0, as);
>  
>              if (size < 0) {
>                  size = load_uimage_as(s->file, &entry, NULL, NULL, NULL, NULL,
> -                                      s->cpu->as);
> +                                      as);
>              }
>          }
>  
>          if (size < 0 || s->force_raw) {
>              /* Default to the maximum size being the machine's ram size */
> -            size = load_image_targphys_as(s->file, s->addr, ram_size,
> -                                          s->cpu->as);
> +            size = load_image_targphys_as(s->file, s->addr, ram_size, as);
>          } else {
>              s->addr = entry;
>          }

Ping?

 Thomas
