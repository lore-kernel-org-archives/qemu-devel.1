Received: from eggs.gnu.org ([2001:4830:134:3::10]:52382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fTlVo-0001zB-Td
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fTlVn-0007tV-Fe
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:59:21 -0400
Date: Fri, 15 Jun 2018 11:59:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180615115909.1c7df252.cohuck@redhat.com>
In-Reply-To: <1529056145-6404-1-git-send-email-thuth@redhat.com>
References: <1529056145-6404-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] loader: Check access size when calling
 rom_ptr() to avoid crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org

On Fri, 15 Jun 2018 11:49:05 +0200
Thomas Huth <thuth@redhat.com> wrote:

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
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v3: Fix the check in find_rom()
> 
>  hw/core/loader.c     | 10 +++++-----
>  hw/mips/mips_malta.c |  6 ++++--
>  hw/s390x/ipl.c       | 13 ++++++++++---
>  hw/sparc/sun4m.c     |  4 ++--
>  hw/sparc64/sun4u.c   |  4 ++--
>  include/hw/loader.h  |  2 +-
>  target/arm/cpu.c     |  2 +-
>  7 files changed, 25 insertions(+), 16 deletions(-)

> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 04245b5..bcac204 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c

> @@ -195,8 +199,11 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
>               * we have to overwrite values in the kernel image,
>               * which are "rom"
>               */
> -            stq_p(rom_ptr(INITRD_PARM_START), initrd_offset);
> -            stq_p(rom_ptr(INITRD_PARM_SIZE), initrd_size);
> +            romptr = rom_ptr(INITRD_PARM_START, 16);
> +            if (romptr) {
> +                stq_p(romptr, initrd_offset);
> +                stq_p(romptr + 1, initrd_size);

INITRD_PARM_SIZE seems to be unused now. We can remove it in a separate
patch if you don't respin, though.

> +            }
>          }
>      }
>      /*

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
