Received: from eggs.gnu.org ([2001:4830:134:3::10]:46843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fp5Br-0001at-02
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 01:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fp5Bn-0002rJ-0o
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 01:14:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57608 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fp5Bm-0002qs-Q2
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 01:14:46 -0400
References: <20180810112323.25206-1-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <92216c85-ce28-9bc9-0736-f5d383139fb7@redhat.com>
Date: Mon, 13 Aug 2018 07:14:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180810112323.25206-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sun4u: ensure kernel_top is always
 initialised
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 08/10/2018 01:23 PM, Mark Cave-Ayland wrote:
> Valgrind reports that when loading a non-ELF kernel, kernel_top may be used
> uninitialised when checking for an initrd.
> 
> Since there are no known non-ELF kernels for SPARC64 then we can simply
> initialise kernel_top to 0 and then skip the initrd load process if it hasn't
> been set by load_elf().
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/sparc64/sun4u.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 74b748497e..d16843b30e 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -139,7 +139,7 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
>      unsigned int i;
>      long kernel_size;
>      uint8_t *ptr;
> -    uint64_t kernel_top;
> +    uint64_t kernel_top = 0;
>  
>      linux_boot = (kernel_filename != NULL);
>  
> @@ -172,7 +172,7 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
>          }
>          /* load initrd above kernel */
>          *initrd_size = 0;
> -        if (initrd_filename) {
> +        if (initrd_filename && kernel_top) {
>              *initrd_addr = TARGET_PAGE_ALIGN(kernel_top);
>  
>              *initrd_size = load_image_targphys(initrd_filename,
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
