Received: from eggs.gnu.org ([209.51.188.92]:41256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1goyKp-0006RM-AR
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1goyKn-0000Km-8I
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:27:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44692
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1goyKj-000088-ES
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:27:51 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0UML452078358
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 17:27:35 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qbjtycxdb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 17:27:35 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Wed, 30 Jan 2019 22:27:34 -0000
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-4-git-send-email-jjherne@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 30 Jan 2019 17:27:27 -0500
MIME-Version: 1.0
In-Reply-To: <1548768562-20007-4-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4d5bd187-56d6-0f23-f9a5-698e8ccd819b@linux.ibm.com>
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
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com



On 01/29/2019 08:29 AM, Jason J. Herne wrote:
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
>   pc-bios/s390-ccw/main.c | 28 ++++++++++++++++++++--------
>   1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index e82fe2c..67df421 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -14,16 +14,17 @@
>   
>   char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
>   static SubChannelId blk_schid = { .one = 1 };
> -IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>   static char loadparm_str[LOADPARM_LEN + 1] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
>   QemuIplParameters qipl;
> +IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
> +static bool have_iplb;
>   
>   #define LOADPARM_PROMPT "PROMPT  "
>   #define LOADPARM_EMPTY  "        "
>   #define BOOT_MENU_FLAG_MASK (QIPL_FLAG_BM_OPTS_CMD | QIPL_FLAG_BM_OPTS_ZIPL)
>   
>   /*
> - * Priniciples of Operations (SA22-7832-09) chapter 17 requires that
> + * Principles of Operations (SA22-7832-09) chapter 17 requires that
>    * a subsystem-identification is at 184-187 and bytes 188-191 are zero
>    * after list-directed-IPL and ccw-IPL.
>    */
> @@ -111,23 +112,33 @@ static void css_setup(void)
>       enable_mss_facility();
>   }
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
>   static void virtio_setup(void)
>   {
>       Schib schib;
>       int ssid;
>       bool found = false;
>       uint16_t dev_no;
> -    char ldp[] = "LOADPARM=[________]\n";
>       VDev *vdev = virtio_get_device();
>       QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
>   
> -    sclp_get_loadparm_ascii(loadparm_str);
> -    memcpy(ldp + 10, loadparm_str, LOADPARM_LEN);
> -    sclp_print(ldp);
> -
>       memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
>   
> -    if (store_iplb(&iplb)) {
> +    if (have_iplb) {
>           switch (iplb.pbt) {
>           case S390_IPL_TYPE_CCW:
>               dev_no = iplb.ccw.devno;
> @@ -174,6 +185,7 @@ int main(void)
>   {
>       sclp_setup();
>       css_setup();
> +    boot_setup();
>       virtio_setup();
>   
>       zipl_load(); /* no return */
> 
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
