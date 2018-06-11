Received: from eggs.gnu.org ([2001:4830:134:3::10]:59071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSPUQ-0007v9-0D
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fSPUP-0002Bd-1C
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:16:17 -0400
References: <20180611135223.81865-1-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c5ec6c27-42cb-e354-b861-8485e72cf1e3@redhat.com>
Date: Mon, 11 Jun 2018 18:16:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180611135223.81865-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] s390x/ipl: Try to detect Linux vs
 non Linux for initial IPL PSW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 11.06.2018 15:52, Christian Borntraeger wrote:
> Right now the IPL device always starts from address 0x10000 (the usual
> Linux entry point). To run other guests (e.g. test programs) it is
> useful to use the IPL PSW from address 0. We can use the Linux magic
> at 0x10008 to decide.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
> v1->v2:
> 	- use LINUX_MAGIC_ADDR define
> 	- use assert for valid iplpsw pointer
> 	- add endianess conversion
>  hw/s390x/ipl.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 04245b5258..3790153fa9 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -29,6 +29,7 @@
>  #include "exec/exec-all.h"
>  
>  #define KERN_IMAGE_START                0x010000UL
> +#define LINUX_MAGIC_ADDR                0x010008UL
>  #define KERN_PARM_AREA                  0x010480UL
>  #define INITRD_START                    0x800000UL
>  #define INITRD_PARM_START               0x010408UL
> @@ -105,7 +106,9 @@ static uint64_t bios_translate_addr(void *opaque, uint64_t srcaddr)
>  static void s390_ipl_realize(DeviceState *dev, Error **errp)
>  {
>      S390IPLState *ipl = S390_IPL(dev);
> -    uint64_t pentry = KERN_IMAGE_START;
> +    uint64_t *iplpsw;
> +    uint64_t pentry;
> +    char *magic;
>      int kernel_size;
>      Error *err = NULL;
>  
> @@ -157,6 +160,16 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
>                                 NULL, 1, EM_S390, 0, 0);
>          if (kernel_size < 0) {
>              kernel_size = load_image_targphys(ipl->kernel, 0, ram_size);
> +            /* if this is Linux use KERN_IMAGE_START */
> +            magic = rom_ptr(LINUX_MAGIC_ADDR);
> +            if (magic && !memcmp(magic, "S390EP", 6)) {
> +                pentry = KERN_IMAGE_START;
> +            } else {
> +                /* if not Linux use the IPL PSW */
> +                iplpsw = rom_ptr(0);
> +                assert(iplpsw);

Hmm, wait, what if load_image_targphys() failed and returned a
kernel_size < 0 ... won't we hit that assert() in that case? I think you
might want to check for kernel_size > 0 (or even > 8) here first.

> +                pentry = be64_to_cpu(*iplpsw) & 0x7fffffffUL;
> +            }
>          }
>          if (kernel_size < 0) {
>              error_setg(&err, "could not load kernel '%s'", ipl->kernel);
> 

 Thomas
