Received: from eggs.gnu.org ([2001:4830:134:3::10]:49894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebQbY-0008DR-8j
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:44:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebQbU-0000SB-8O
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:44:40 -0500
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-4-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <00a32f3a-0665-56ae-7f35-6da83e2ccdc3@redhat.com>
Date: Tue, 16 Jan 2018 13:44:25 +0100
MIME-Version: 1.0
In-Reply-To: <1516034665-27606-4-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/8] s390-ccw: parse and set boot menu
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

On 15.01.2018 17:44, Collin L. Walling wrote:
> Set boot menu options for an s390 guest and store them in
> the iplb. These options are set via the QEMU command line
> option:
> 
>     -boot menu=on|off[,splash-time=X]
> 
> or via the libvirt domain xml:
> 
>     <os>
>       <bootmenu enable='yes|no' timeout='X'/>
>     </os>
> 
> Where X represents some positive integer representing
> milliseconds.
> 
> A loadparm other than 'prompt' will disable the menu and
> just boot the specified entry.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  hw/s390x/ipl.c          | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/ipl.h          | 11 ++++++++--
>  pc-bios/s390-ccw/iplb.h |  8 ++++++--
>  3 files changed, 69 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 0d06fc1..81ba9ed 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -23,6 +23,8 @@
>  #include "hw/s390x/ebcdic.h"
>  #include "ipl.h"
>  #include "qemu/error-report.h"
> +#include "qemu/config-file.h"
> +#include "qemu/cutils.h"
>  
>  #define KERN_IMAGE_START                0x010000UL
>  #define KERN_PARM_AREA                  0x010480UL
> @@ -219,6 +221,55 @@ static Property s390_ipl_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> +static void s390_ipl_set_boot_menu(IplParameterBlock *iplb)
> +{
> +    QemuOptsList *plist = qemu_find_opts("boot-opts");
> +    QemuOpts *opts = QTAILQ_FIRST(&plist->head);
> +    uint8_t *flags;
> +    uint16_t *timeout;
> +    const char *tmp;
> +    unsigned long result = 0;
> +
> +    switch (iplb->pbt) {
> +    case S390_IPL_TYPE_CCW:
> +        flags = &iplb->ccw.boot_menu_flags;
> +        timeout = &iplb->ccw.boot_menu_timeout;
> +        break;
> +    case S390_IPL_TYPE_QEMU_SCSI:
> +        flags = &iplb->scsi.boot_menu_flags;
> +        timeout = &iplb->scsi.boot_menu_timeout;
> +        break;
> +    default:
> +        error_report("boot menu is not supported for this device type.");
> +        return;
> +    }
> +
> +    /* In the absence of -boot menu, use zipl parameters */
> +    if (!qemu_opt_get(opts, "menu")) {
> +        *flags = BOOT_MENU_FLAG_ZIPL_OPTS;
> +    } else if (boot_menu) {
> +        *flags = BOOT_MENU_FLAG_BOOT_OPTS;
> +
> +        tmp = qemu_opt_get(opts, "splash-time");
> +
> +        if (tmp && qemu_strtoul(tmp, NULL, 10, &result)) {
> +            error_report("splash-time value is invalid, forcing it to 0.");

It's likely not needed, but an explicit "*timeout = 0" would be fine
here, I think.

> +            return;
> +        }
> +
> +        result /= 1000; /* Store timeout value as seconds */

Maybe rather do proper rounding:

    result = (result + 500) / 1000;

?

> +        if (result > 0xffff) {
> +            error_report("splash-time value is greater than 65535000,"
> +                         " forcing it to 65535000.");
> +            *timeout = 0xffff;
> +            return;
> +        }
> +
> +        *timeout = cpu_to_be16(result);
> +    }
> +}
> +

I've found just some nits ... patch looks fine in general, so feel free
to add:

Reviewed-by: Thomas Huth <thuth@redhat.com>
