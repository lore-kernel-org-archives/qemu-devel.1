Received: from eggs.gnu.org ([2001:4830:134:3::10]:33257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gXQpM-0007ST-LY
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gXQpJ-0000XV-BY
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:14:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54190
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gXQpJ-0000UY-1m
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:14:53 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBDDEDch126093
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 08:14:49 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pbquvgyh4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 08:14:49 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Thu, 13 Dec 2018 13:14:48 -0000
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<1544623878-11248-3-git-send-email-jjherne@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 13 Dec 2018 08:14:37 -0500
MIME-Version: 1.0
In-Reply-To: <1544623878-11248-3-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1e022a58-46be-5dd2-80ba-8d02732c2c30@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 02/15] s390-bios: decouple cio setup from
 virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com



On 12/12/2018 09:11 AM, Jason J. Herne wrote:
> Move channel i/o setup code out to a separate function. This decouples cio
> setup from the virtio code path and allows us to make use of it for booting
> dasd devices.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/main.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 544851d..e82fe2c 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -99,6 +99,18 @@ static void menu_setup(void)
>       }
>   }
> 
> +/*
> + * Initialize the channel I/O subsystem so we can talk to our ipl/boot device.
> + */
> +static void css_setup(void)
> +{
> +    /*
> +     * Unconditionally enable mss support. In every sane configuration this
> +     * will succeed; and even if it doesn't, stsch_err() can handle it.
> +     */
> +    enable_mss_facility();
> +}
> +
>   static void virtio_setup(void)
>   {
>       Schib schib;
> @@ -109,13 +121,6 @@ static void virtio_setup(void)
>       VDev *vdev = virtio_get_device();
>       QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
> 
> -    /*
> -     * We unconditionally enable mss support. In every sane configuration,
> -     * this will succeed; and even if it doesn't, stsch_err() can deal
> -     * with the consequences.
> -     */
> -    enable_mss_facility();
> -
>       sclp_get_loadparm_ascii(loadparm_str);
>       memcpy(ldp + 10, loadparm_str, LOADPARM_LEN);
>       sclp_print(ldp);
> @@ -168,6 +173,7 @@ static void virtio_setup(void)
>   int main(void)
>   {
>       sclp_setup();
> +    css_setup();
>       virtio_setup();
> 
>       zipl_load(); /* no return */
> 

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
