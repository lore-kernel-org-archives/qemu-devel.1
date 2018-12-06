Received: from eggs.gnu.org ([2001:4830:134:3::10]:57313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gV2eL-0002ZQ-CI
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 18:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gV2eH-0000ld-JS
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 18:01:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45804
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gV2eF-0000js-Bw
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 18:01:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB6MwYRE126980
	for <qemu-devel@nongnu.org>; Thu, 6 Dec 2018 18:01:32 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p7cwa8fr0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 18:01:31 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Thu, 6 Dec 2018 23:01:30 -0000
References: <20181205145131.28467-1-cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 6 Dec 2018 18:01:24 -0500
MIME-Version: 1.0
In-Reply-To: <20181205145131.28467-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <72ca111b-d1e8-2b18-9f3e-153a0a7a16d1@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC] vfio-ap: flag as compatible with
 balloon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 12/5/18 9:51 AM, Cornelia Huck wrote:
> vfio-ap devices do not pin any pages in the host. Therefore, they
> are belived to be compatible with memory ballooning.
> 
> Flag them as compatible, so both vfio-ap and a balloon can be
> used simultaneously.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> As briefly discussed on IRC. RFC as I do not have easy access to
> hardware I can test this with.
> 
> ---
>   hw/vfio/ap.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 65de952f44..3bf48eed28 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -104,6 +104,14 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>       vapdev->vdev.name = g_strdup_printf("%s", mdevid);
>       vapdev->vdev.dev = dev;
>   
> +    /*
> +     * vfio-ap devices are believed to operate in a way compatible with
> +     * memory ballooning, as no pages are pinned in the host.
> +     * This needs to be set before vfio_get_device() for vfio common to
> +     * handle the balloon inhibitor.
> +     */
> +    vapdev->vdev.balloon_allowed = true;
> +
>       ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_err);
>       if (ret) {
>           goto out_get_dev_err;

Tested-by: Tony Krowiak <akrowiak@linux.ibm.com>

> 
