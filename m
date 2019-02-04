Received: from eggs.gnu.org ([209.51.188.92]:35491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqbXE-0004ar-Um
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqbX7-00064r-AC
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:31:24 -0500
Date: Mon, 4 Feb 2019 11:31:08 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190204113108.0ee0371e.cohuck@redhat.com>
In-Reply-To: <1548768562-20007-4-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-4-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/15] s390-bios: decouple common boot
 logic from virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Tue, 29 Jan 2019 08:29:10 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Create a boot_setup function to handle getting boot information from
> the machine/hypervisor. This decouples common boot logic from the
> virtio code path and allows us to make use of it for the real dasd boot
> scenario.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/main.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index e82fe2c..67df421 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -14,16 +14,17 @@
>  
>  char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
>  static SubChannelId blk_schid = { .one = 1 };
> -IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>  static char loadparm_str[LOADPARM_LEN + 1] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
>  QemuIplParameters qipl;
> +IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
> +static bool have_iplb;
>  
>  #define LOADPARM_PROMPT "PROMPT  "
>  #define LOADPARM_EMPTY  "        "
>  #define BOOT_MENU_FLAG_MASK (QIPL_FLAG_BM_OPTS_CMD | QIPL_FLAG_BM_OPTS_ZIPL)
>  
>  /*
> - * Priniciples of Operations (SA22-7832-09) chapter 17 requires that
> + * Principles of Operations (SA22-7832-09) chapter 17 requires that
>   * a subsystem-identification is at 184-187 and bytes 188-191 are zero
>   * after list-directed-IPL and ccw-IPL.
>   */

Some unrelated change :) But it really does not make sense to split
this out.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
