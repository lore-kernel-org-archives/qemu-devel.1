Received: from eggs.gnu.org ([2001:4830:134:3::10]:47158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1du9Lz-00037t-Au
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 23:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1du9Lu-0000mW-E4
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 23:37:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1du9Lu-0000lr-48
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 23:37:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8J3Xb77047789
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 23:37:35 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d2u401d3t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 23:37:35 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 18 Sep 2017 21:37:34 -0600
Date: Tue, 19 Sep 2017 11:37:30 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-4-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913115029.47626-4-pasic@linux.vnet.ibm.com>
Message-Id: <20170919033730.GD5274@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] virtio-ccw: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-13 13:50:28 +0200]:

> Replace direct access which implicitly assumes no IDA
> or MIDA with the new ccw data stream interface which should
> cope with these transparently in the future.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> 
> ---
> 
> v1 --> v2:
> Removed todo comments on possible errno change as with
> https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg02441.html
> applied it does not matter any more.
> 
> Error handling: At the moment we ignore errors reported
> by stream ops to keep the change minimal. An add-on
> patch improving on this is to be expected later.
Add a TODO somewhere around the code as a reminder?

> ---
>  hw/s390x/virtio-ccw.c | 156 +++++++++++++++-----------------------------------
>  1 file changed, 46 insertions(+), 110 deletions(-)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index b1976fdd19..a9baf6f7ab 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
[...]

> @@ -394,11 +362,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>          } else {
>              VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
> 
> -            features.index = address_space_ldub(&address_space_memory,
> -                                                ccw.cda
> -                                                + sizeof(features.features),
> -                                                MEMTXATTRS_UNSPECIFIED,
> -                                                NULL);
> +            ccw_dstream_advance(&sch->cds, sizeof(features.features));
How about:
ccw_dstream_advance(&sch->cds, offsetof(VirtioFeatDesc, index));

> +            ccw_dstream_read(&sch->cds, features.index);
>              if (features.index == 0) {
>                  if (dev->revision >= 1) {
>                      /* Don't offer legacy features for modern devices. */
> @@ -417,9 +382,9 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>                  /* Return zeroes if the guest supports more feature bits. */
>                  features.features = 0;
>              }
> -            address_space_stl_le(&address_space_memory, ccw.cda,
> -                                 features.features, MEMTXATTRS_UNSPECIFIED,
> -                                 NULL);
> +            ccw_dstream_rewind(&sch->cds);
> +            cpu_to_le32s(&features.features);
> +            ccw_dstream_write(&sch->cds, features.features);
>              sch->curr_status.scsw.count = ccw.count - sizeof(features);
How about:
sch->curr_status.scsw.count = ccw_dstream_residual_count(&sch->cds);

This also applies to other places.

>              ret = 0;
>          }
[...]

> @@ -501,21 +459,13 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>              }
>          }
>          len = MIN(ccw.count, vdev->config_len);
> -        hw_len = len;
>          if (!ccw.cda) {
>              ret = -EFAULT;
>          } else {
> -            config = cpu_physical_memory_map(ccw.cda, &hw_len, 0);
> -            if (!config) {
> -                ret = -EFAULT;
> -            } else {
> -                len = hw_len;
> -                /* XXX config space endianness */
> -                memcpy(vdev->config, config, len);
> -                cpu_physical_memory_unmap(config, hw_len, 0, hw_len);
> +            ret = ccw_dstream_read_buf(&sch->cds, vdev->config, len);
> +            if (!ret) {
Add a TODO here, and:

if (ccw_dstream_read_buf(&sch->cds, vdev->config, len)) {
    ret = -EFAULT;
} else {
    ....
}

>                  virtio_bus_set_vdev_config(&dev->bus, vdev->config);
>                  sch->curr_status.scsw.count = ccw.count - len;
> -                ret = 0;
>              }
>          }
>          break;
[...]

> @@ -714,13 +654,9 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>              ret = -EFAULT;
>              break;
>          }
> -        revinfo.revision =
> -            address_space_lduw_be(&address_space_memory, ccw.cda,
> -                                  MEMTXATTRS_UNSPECIFIED, NULL);
> -        revinfo.length =
> -            address_space_lduw_be(&address_space_memory,
> -                                  ccw.cda + sizeof(revinfo.revision),
> -                                  MEMTXATTRS_UNSPECIFIED, NULL);
> +        ccw_dstream_read_buf(&sch->cds, &revinfo, 4);
                                                     ^
A magic number? O:)

> +        be16_to_cpus(&revinfo.revision);
> +        be16_to_cpus(&revinfo.length);
>          if (ccw.count < len + revinfo.length ||
>              (check_len && ccw.count > len + revinfo.length)) {
>              ret = -EINVAL;
> -- 
> 2.13.5
> 

Otherwise, looks good.

-- 
Dong Jia Shi
