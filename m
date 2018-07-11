Received: from eggs.gnu.org ([2001:4830:134:3::10]:49562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdCYz-0007fm-HH
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 06:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fdCYy-0008FG-K4
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 06:41:37 -0400
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-4-git-send-email-jjherne@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5b78fa23-4ca4-5c85-edeb-4715ea1ae551@redhat.com>
Date: Wed, 11 Jul 2018 12:41:32 +0200
MIME-Version: 1.0
In-Reply-To: <1530811543-6881-4-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC 03/15] s390-bios: decouple
 common boot logic from virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On 05.07.2018 19:25, Jason J. Herne wrote:
> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

git commit --amend --reset-author ?

> Create a boot_setup function to handle getting boot information from
> the machine/hypervisor. This decouples common boot logic from the
> virtio code path and allows us to make use of it for the real dasd boot
> scenario.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 63117d1..8ecab93 100644
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
> @@ -111,23 +112,33 @@ static void cio_setup(void)
>      enable_mss_facility();
>  }
>  
> +/*
> + * Collect various pieces of information from the hypervisor/hardware that
> + * we'll use to determine exactly how we'll boot.
> + */
> +static void boot_setup(void)
> +{
> +    char lpmsg[] = "LOADPARM=[________]\n";
> +
> +    sclp_get_loadparm_ascii(loadparm_str);
> +    memcpy(lpmsg + 10, loadparm_str, 8);
> +    sclp_print(lpmsg);
> +
> +    have_iplb = store_iplb(&iplb);
> +}
> +
>  static void virtio_setup(void)
>  {
>      Schib schib;
>      int ssid;
>      bool found = false;
>      uint16_t dev_no;
> -    char ldp[] = "LOADPARM=[________]\n";
>      VDev *vdev = virtio_get_device();
>      QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
>  
> -    sclp_get_loadparm_ascii(loadparm_str);
> -    memcpy(ldp + 10, loadparm_str, LOADPARM_LEN);
> -    sclp_print(ldp);
> -
>      memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
>  
> -    if (store_iplb(&iplb)) {
> +    if (have_iplb) {
>          switch (iplb.pbt) {
>          case S390_IPL_TYPE_CCW:
>              dev_no = iplb.ccw.devno;
> @@ -174,6 +185,7 @@ int main(void)
>  {
>      sclp_setup();
>      cio_setup();
> +    boot_setup();

Maybe rather name it bootparm_setup? Just "boot" is IMHO a little bit
too generic... Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
