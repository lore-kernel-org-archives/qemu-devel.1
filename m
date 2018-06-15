Received: from eggs.gnu.org ([2001:4830:134:3::10]:60551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTkB7-00022g-5n
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTkB6-00047g-7p
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:33:53 -0400
From: Thomas Huth <thuth@redhat.com>
References: <1529045897-25260-1-git-send-email-thuth@redhat.com>
Message-ID: <5ab4dd7b-b717-5e58-41d8-1d996c515a10@redhat.com>
Date: Fri, 15 Jun 2018 10:33:42 +0200
MIME-Version: 1.0
In-Reply-To: <1529045897-25260-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] loader: Check access size when calling
 rom_ptr() to avoid crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>

On 15.06.2018 08:58, Thomas Huth wrote:
> The rom_ptr() function allows direct access to the ROM blobs that we
> load during startup. However, there are currently no checks for the
> size of the accesses, so it's currently possible to crash QEMU for
> example with:
> 
> $ echo "Insane in the mainframe" > /tmp/test.txt
> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -append xyz
> Segmentation fault (core dumped)
> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -initrd /tmp/test.txt
> Segmentation fault (core dumped)
> 
> We need a possibility to check the size of the ROM area that we want
> to access, thus let's add a size parameter to the rom_ptr() function
> to avoid these problems.
[...]
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 0ee779f..2375cb2 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -272,7 +272,7 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
>          }
>          if (initrd_size > 0) {
>              for (i = 0; i < 64 * TARGET_PAGE_SIZE; i += TARGET_PAGE_SIZE) {
> -                ptr = rom_ptr(KERNEL_LOAD_ADDR + i);
> +                ptr = rom_ptr(KERNEL_LOAD_ADDR + i, 24);
>                  if (ldl_p(ptr) == 0x48647253) { // HdrS

Darn, that should check for ptr != NULL ...

>                      stl_p(ptr + 16, INITRD_LOAD_ADDR);
>                      stl_p(ptr + 20, initrd_size);
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 1bede85..8b09090 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -186,7 +186,7 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
>          }
>          if (*initrd_size > 0) {
>              for (i = 0; i < 64 * TARGET_PAGE_SIZE; i += TARGET_PAGE_SIZE) {
> -                ptr = rom_ptr(*kernel_addr + i);
> +                ptr = rom_ptr(*kernel_addr + i, 32);
>                  if (ldl_p(ptr + 8) == 0x48647253) { /* HdrS */

... dito ...

I'll send a v2.

 Thomas
