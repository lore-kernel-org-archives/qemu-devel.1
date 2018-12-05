Received: from eggs.gnu.org ([2001:4830:134:3::10]:43486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gUZgq-0007e0-3E
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gUZgh-0005gj-En
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:06:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gUZgg-0005UN-Ul
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:06:11 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB5G4YpH035644
	for <qemu-devel@nongnu.org>; Wed, 5 Dec 2018 11:06:05 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p6hmgh30g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 11:06:05 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 5 Dec 2018 16:06:02 -0000
References: <20181205145131.28467-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 5 Dec 2018 17:05:56 +0100
MIME-Version: 1.0
In-Reply-To: <20181205145131.28467-1-cohuck@redhat.com>
Content-Language: en-US
Message-Id: <995ca12b-be6a-9d00-c7b7-690c46bfeeeb@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 05.12.2018 15:51, Cornelia Huck wrote:
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

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

vfio-ap is based on the SIE support for AP, which transparently handles host paging.
S390_AP_IOMMU has an empty iommu_ops set and the hardware can tolerate invalid page
table entries.

So this makes sense to me.

> 
> ---
>  hw/vfio/ap.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 65de952f44..3bf48eed28 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -104,6 +104,14 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>      vapdev->vdev.name = g_strdup_printf("%s", mdevid);
>      vapdev->vdev.dev = dev;
>  
> +    /*
> +     * vfio-ap devices are believed to operate in a way compatible with
> +     * memory ballooning, as no pages are pinned in the host.
> +     * This needs to be set before vfio_get_device() for vfio common to
> +     * handle the balloon inhibitor.
> +     */
> +    vapdev->vdev.balloon_allowed = true;
> +
>      ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_err);
>      if (ret) {
>          goto out_get_dev_err;
> 
