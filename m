Received: from eggs.gnu.org ([2001:4830:134:3::10]:41355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTkcJ-0006Ke-8w
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTkcI-0000ya-CV
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:01:59 -0400
From: Thomas Huth <thuth@redhat.com>
References: <1529052300-23093-1-git-send-email-thuth@redhat.com>
Message-ID: <124f3592-df59-071c-08a0-aafdfc7e33f9@redhat.com>
Date: Fri, 15 Jun 2018 11:01:46 +0200
MIME-Version: 1.0
In-Reply-To: <1529052300-23093-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] loader: Check access size when calling
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

On 15.06.2018 10:45, Thomas Huth wrote:
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
> $ echo -n HdrS > /tmp/hdr.txt
> $ sparc64-softmmu/qemu-system-sparc64 -kernel /tmp/hdr.txt -initrd /tmp/hdr.txt
> Segmentation fault (core dumped)
> 
> We need a possibility to check the size of the ROM area that we want
> to access, thus let's add a size parameter to the rom_ptr() function
> to avoid these problems.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Add sparc64 crash to the patch description
>  - Added Cornelia's Rb from v1
>  - NULL pointer check in the sparc machines
> 
>  hw/core/loader.c     | 10 +++++-----
>  hw/mips/mips_malta.c |  6 ++++--
>  hw/s390x/ipl.c       | 13 ++++++++++---
>  hw/sparc/sun4m.c     |  4 ++--
>  hw/sparc64/sun4u.c   |  4 ++--
>  include/hw/loader.h  |  2 +-
>  target/arm/cpu.c     |  2 +-
>  7 files changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 06bdbca..54be522 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -191,7 +191,7 @@ void pstrcpy_targphys(const char *name, hwaddr dest, int buf_size,
>          rom_add_blob_fixed(name, source, (nulp - source) + 1, dest);
>      } else {
>          rom_add_blob_fixed(name, source, buf_size, dest);
> -        ptr = rom_ptr(dest + buf_size - 1);
> +        ptr = rom_ptr(dest + buf_size - 1, sizeof(*ptr));
>          *ptr = 0;
>      }
>  }
> @@ -1165,7 +1165,7 @@ void rom_reset_order_override(void)
>      fw_cfg_reset_order_override(fw_cfg);
>  }
>  
> -static Rom *find_rom(hwaddr addr)
> +static Rom *find_rom(hwaddr addr, size_t size)
>  {
>      Rom *rom;
>  
> @@ -1176,7 +1176,7 @@ static Rom *find_rom(hwaddr addr)
>          if (rom->mr) {
>              continue;
>          }
> -        if (rom->addr > addr) {
> +        if (rom->addr > addr + size) {

Uh, not my day today, this check is wrong, I still get bad accesses in
the sparc32 code with valgrind. I'll sent a v3...

 Thomas
