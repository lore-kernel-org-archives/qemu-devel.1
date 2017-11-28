Received: from eggs.gnu.org ([2001:4830:134:3::10]:47938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJdgp-0004MF-WC
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJdgk-0005Ae-Ae
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:04:35 -0500
Date: Tue, 28 Nov 2017 12:04:25 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171128120425.6fa912c1.cohuck@redhat.com>
In-Reply-To: <1511816136-30068-4-git-send-email-walling@linux.vnet.ibm.com>
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<1511816136-30068-4-git-send-email-walling@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/5] s390-ccw: parse and set boot menu
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Mon, 27 Nov 2017 15:55:34 -0500
"Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:

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
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  hw/s390x/ipl.c          | 23 +++++++++++++++++++++++
>  hw/s390x/ipl.h          |  8 ++++++--
>  pc-bios/s390-ccw/iplb.h |  8 ++++++--
>  3 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 0d06fc1..0ca9e37 100644
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
> @@ -219,6 +221,23 @@ static Property s390_ipl_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> +static void s390_ipl_set_boot_menu(uint8_t *boot_menu_enabled,
> +                                   uint16_t *boot_menu_timeout)
> +{
> +    QemuOptsList *plist = qemu_find_opts("boot-opts");
> +    QemuOpts *opts = QTAILQ_FIRST(&plist->head);
> +    const char *p;
> +    long result = 0;
> +
> +    *boot_menu_enabled = qemu_opt_get_bool(opts, "menu", false);

This is already parsed in vl.c, isn't it? Can you simply check
boot_menu?

> +
> +    if (*boot_menu_enabled) {
> +        p = qemu_opt_get(opts, "splash-time");

hw/nvram/fw_cfg.c parses splash-time as well, but I'm not sure if it is
worth parsing it in vl.c as well.

> +        qemu_strtol(p, NULL, 10, &result);
> +        *boot_menu_timeout = result;
> +    }
> +}
> +
>  static bool s390_gen_initial_iplb(S390IPLState *ipl)
>  {
>      DeviceState *dev_st;
