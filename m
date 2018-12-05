Received: from eggs.gnu.org ([2001:4830:134:3::10]:55623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gUaC3-0008Dm-HV
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:38:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gUaBz-0001JA-Ig
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:38:35 -0500
References: <20181205145131.28467-1-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0d97dcf5-de40-3f18-64fc-7b2eb1799a84@redhat.com>
Date: Wed, 5 Dec 2018 17:38:22 +0100
MIME-Version: 1.0
In-Reply-To: <20181205145131.28467-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 05.12.18 15:51, Cornelia Huck wrote:
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

What happens if this ever changes? Shouldn't we have an API to at least
check what the vfio device can guarantee?

"are believed to operate" doesn't sound like guarantees to me :)

-- 

Thanks,

David / dhildenb
