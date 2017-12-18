Received: from eggs.gnu.org ([2001:4830:134:3::10]:34172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQvOg-0002Bd-C6
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQvOd-0006df-LN
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:23:58 -0500
References: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
	<1513030760-26245-4-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5dc1122f-610d-ed77-6ec8-bd470c1c194c@redhat.com>
Date: Mon, 18 Dec 2017 14:23:46 +0100
MIME-Version: 1.0
In-Reply-To: <1513030760-26245-4-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/5] s390-ccw: parse and set boot menu
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
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com

On 11.12.2017 23:19, Collin L. Walling wrote:
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
>  hw/s390x/ipl.c          | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/ipl.h          |  8 +++++--
>  pc-bios/s390-ccw/iplb.h |  8 +++++--
>  3 files changed, 67 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 0d06fc1..ed5e8d1 100644
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
> @@ -33,6 +35,9 @@
>  #define ZIPL_IMAGE_START                0x009000UL
>  #define IPL_PSW_MASK                    (PSW_MASK_32 | PSW_MASK_64)
>  
> +#define BOOT_MENU_FLAG_BOOT_OPTS 0x80
> +#define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
> +
>  static bool iplb_extended_needed(void *opaque)
>  {
>      S390IPLState *ipl = S390_IPL(object_resolve_path(TYPE_S390_IPL, NULL));
> @@ -219,6 +224,51 @@ static Property s390_ipl_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> +static void s390_ipl_set_boot_menu(uint8_t *boot_menu_flags,
> +                                   uint16_t *boot_menu_timeout)
> +{
> +    MachineState *machine = MACHINE(qdev_get_machine());
> +    char *lp = object_property_get_str(OBJECT(machine), "loadparm", NULL);
> +    QemuOptsList *plist = qemu_find_opts("boot-opts");
> +    QemuOpts *opts = QTAILQ_FIRST(&plist->head);
> +    const char *p = qemu_opt_get(opts, "menu");
> +    unsigned long timeout = 0;
> +
> +    if (memcmp(lp, "PROMPT  ", 8) == 0) {
> +        *boot_menu_flags = BOOT_MENU_FLAG_BOOT_OPTS;
> +
> +    } else if (*lp) {
> +        /* If loadparm is set to any value, then discard boot menu */
> +        return;
> +
> +    } else if (!p) {
> +        /* In the absence of -boot menu, use zipl loader parameters */
> +        *boot_menu_flags = BOOT_MENU_FLAG_ZIPL_OPTS;
> +
> +    } else if (strncmp(p, "on", 2) == 0) {
> +        *boot_menu_flags = BOOT_MENU_FLAG_BOOT_OPTS;
> +
> +        p = qemu_opt_get(opts, "splash-time");
> +
> +        if (p && qemu_strtoul(p, NULL, 10, &timeout)) {
> +            error_report("splash-time value is invalid, forcing it to 0.");
> +            return;
> +        }
> +
> +        /* Store timeout value as seconds */
> +        timeout /= 1000;
> +
> +        if (timeout > 0xffff) {
> +            error_report("splash-time value is greater than 65535000,"
> +                         " forcing it to 65535000.");
> +            *boot_menu_timeout = 0xffff;
> +            return;
> +        }
> +
> +        *boot_menu_timeout = timeout;

I guess we likely need a cpu_to_be16() here?

> +    }
> +}

 Thomas
