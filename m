Received: from eggs.gnu.org ([2001:4830:134:3::10]:43731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eg6TD-0002iN-Lc
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:15:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eg6T8-0001rm-M1
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:15:23 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-9-git-send-email-walling@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cc08c79e-a579-e833-c9a7-7476d7e5b328@redhat.com>
Date: Mon, 29 Jan 2018 11:15:15 +0100
MIME-Version: 1.0
In-Reply-To: <1516732013-18272-9-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 08/10] s390-ccw: print zipl
 boot menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com

On 23.01.2018 19:26, Collin L. Walling wrote:
> When the boot menu options are present and the guest's
> disk has been configured by the zipl tool, then the user
> will be presented with an interactive boot menu with
> labeled entries. An example of what the menu might look
> like:
> 
> zIPL v1.37.1-build-20170714 interactive boot menu.
> 
>   0. default (linux-4.13.0)
> 
>   1. linux-4.13.0
>   2. performance
>   3. kvm
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/menu.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> index de12c73..174285e 100644
> --- a/pc-bios/s390-ccw/menu.c
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -10,13 +10,62 @@
>   */
>  
>  #include "menu.h"
> +#include "s390-ccw.h"
>  
>  static uint8_t flags;
>  static uint64_t timeout;
>  
> +/* Offsets from zipl fields to zipl banner start */
> +#define ZIPL_TIMEOUT_OFFSET 138
> +#define ZIPL_FLAG_OFFSET    140
> +
> +static int get_boot_index(int entries)
> +{
> +    return 0; /* Implemented next patch */
> +}
> +
> +static void zipl_println(const char *data, size_t len)
> +{
> +    char buf[len + 2];
> +
> +    ebcdic_to_ascii(data, buf, len);
> +    buf[len] = '\n';
> +    buf[len + 1] = '\0';
> +
> +    sclp_print(buf);
> +}
> +
>  int menu_get_zipl_boot_index(const void *stage2, int offset)
>  {
> -    return 0; /* implemented next patch */
> +    const char *data = stage2 + offset;
> +    uint16_t flag;
> +    size_t len;
> +    int ct;
> +
> +    flag = *(uint16_t *)(data - ZIPL_FLAG_OFFSET);

You could initialize this directly above or after you verified (flags &
BOOT_MENU_FLAG_ZIPL_OPTS)

> +
> +    if (flags & BOOT_MENU_FLAG_ZIPL_OPTS) {
> +        if (flag) {
> +            timeout = *(uint16_t *)(data - ZIPL_TIMEOUT_OFFSET);
> +        } else {

You can drop the else and return directly.

> +            return 0; /* Boot default */
> +        }
> +    }
> +
> +    /* Print and count all menu items, including the banner */
> +    for (ct = 0; *data; ct++) {
> +        len = strlen(data);
> +        zipl_println(data, len);
> +        data += len + 1;
> +
> +        if (ct < 2) {
> +            sclp_print("\n");
> +        }
> +    }
> +
> +    sclp_print("\n");
> +
> +    return get_boot_index(ct - 1);
>  }
>  
>  void menu_set_parms(uint8_t boot_menu_flag, uint16_t boot_menu_timeout)
> 

Looks good to me!

-- 

Thanks,

David / dhildenb
