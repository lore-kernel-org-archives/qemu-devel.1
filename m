Received: from eggs.gnu.org ([209.51.188.92]:54862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1guMOU-0002JZ-7Y
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:09:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1guMOS-0006eA-NN
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:09:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1guMOS-0006dg-CZ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:09:56 -0500
Date: Thu, 14 Feb 2019 14:09:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190214140613-mutt-send-email-mst@kernel.org>
References: <20190214180216.246707-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214180216.246707-1-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/i386/pc: run the multiboot loader
 before the PVH loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Liam Merwick <liam.merwick@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, George Kennedy <George.Kennedy@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Feb 14, 2019 at 07:02:16PM +0100, Stefano Garzarella wrote:
> Some multiboot images could be in the ELF format. In the current
> implementation QEMU fails because we try to load these images
> as a PVH image.
> 
> In order to fix this issue, we should try multiboot first (we
> already check the multiboot magic header before to load it).
> If it is not a multiboot image, we can try the PVH loader.
> 
> Fixes: ab969087da6 ("pvh: Boot uncompressed kernel using direct boot ABI", 2019-01-15)
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Paolo can you pls merge since you did the pvh things?

> ---
>  hw/i386/pc.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 3889eccdc3..207c267093 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1209,6 +1209,17 @@ static void load_linux(PCMachineState *pcms,
>      if (ldl_p(header+0x202) == 0x53726448) {
>          protocol = lduw_p(header+0x206);
>      } else {
> +        /*
> +         * This could be a multiboot kernel. If it is, let's stop treating it
> +         * like a Linux kernel.
> +         * Note: some multiboot images could be in the ELF format (the same of
> +         * PVH), so we try multiboot first since we check the multiboot magic
> +         * header before to load it.
> +         */
> +        if (load_multiboot(fw_cfg, f, kernel_filename, initrd_filename,
> +                           kernel_cmdline, kernel_size, header)) {
> +            return;
> +        }
>          /*
>           * Check if the file is an uncompressed kernel file (ELF) and load it,
>           * saving the PVH entry point used by the x86/HVM direct boot ABI.
> @@ -1262,12 +1273,6 @@ static void load_linux(PCMachineState *pcms,
>  
>              return;
>          }
> -        /* This looks like a multiboot kernel. If it is, let's stop
> -           treating it like a Linux kernel. */
> -        if (load_multiboot(fw_cfg, f, kernel_filename, initrd_filename,
> -                           kernel_cmdline, kernel_size, header)) {
> -            return;
> -        }
>          protocol = 0;
>      }
>  
> -- 
> 2.20.1
