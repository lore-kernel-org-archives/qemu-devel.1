Received: from eggs.gnu.org ([2001:4830:134:3::10]:40354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fG3Xl-0002xB-7C
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fG3Xf-0003yP-Jf
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:24:41 -0400
References: <20180508141506.56480-1-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f7b7d1ca-de00-7c01-0fa2-44dcaf56af03@redhat.com>
Date: Tue, 8 May 2018 16:24:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180508141506.56480-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/ipl: Try to detect Linux vs non
 Linux for initial IPL PSW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 08.05.2018 16:15, Christian Borntraeger wrote:
> Right now the IPL device always starts from address 0x10000 (the usual
> Linux entry point). To run other guests (e.g. test programs) it is
> useful to use the IPL PSW from address 0. We can use the Linux magic
> at 0x10008 to decide.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  hw/s390x/ipl.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 150f6c0582..c0fed26f03 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -104,7 +104,9 @@ static uint64_t bios_translate_addr(void *opaque, uint64_t srcaddr)
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
> @@ -156,6 +158,17 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
>                                 NULL, 1, EM_S390, 0, 0);
>          if (kernel_size < 0) {
>              kernel_size = load_image_targphys(ipl->kernel, 0, ram_size);
> +            /* if this is Linux use KERN_IMAGE_START */
> +            magic = rom_ptr(0x10008);
> +            if (magic && !memcmp(magic, "S390EP", 6)) {
> +                pentry = KERN_IMAGE_START;
> +            } else {
> +                /* if not Linux use the IPL PSW */
> +                iplpsw = rom_ptr(0);
> +                if (iplpsw) {
> +                    pentry = *iplpsw & 0x7fffffffUL;
> +                }

else {
    error_report("Failed to determine entry point");
    exit(1);
}

?

Otherwise some version of GCC might complain that pentry is used
uninitialized later.

Alternatively, use "assert(iplpsw)" instead of the "if (iplpws)" ?

> +            }
>          }
>          if (kernel_size < 0) {
>              error_setg(&err, "could not load kernel '%s'", ipl->kernel);
> 

 Thomas
