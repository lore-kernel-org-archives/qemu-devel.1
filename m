Received: from eggs.gnu.org ([2001:4830:134:3::10]:52530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsPoK-0003Th-L7
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsPoH-0004m4-Gz
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:47:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dsPoH-0004lK-AT
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:47:45 -0400
Date: Thu, 14 Sep 2017 10:47:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170914104739.74ca3c70.cohuck@redhat.com>
In-Reply-To: <20170913115029.47626-4-pasic@linux.vnet.ibm.com>
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-4-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed, 13 Sep 2017 13:50:28 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Replace direct access which implicitly assumes no IDA
> or MIDA with the new ccw data stream interface which should
> cope with these transparently in the future.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>


> @@ -488,7 +446,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>          } else {
>              virtio_bus_get_vdev_config(&dev->bus, vdev->config);
>              /* XXX config space endianness */
> -            cpu_physical_memory_write(ccw.cda, vdev->config, len);
> +            ccw_dstream_write_buf(&sch->cds, vdev->config, len);
>              sch->curr_status.scsw.count = ccw.count - len;
>              ret = 0;
>          }
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
>                  virtio_bus_set_vdev_config(&dev->bus, vdev->config);
>                  sch->curr_status.scsw.count = ccw.count - len;
> -                ret = 0;
>              }
>          }
>          break;

It feels a bit odd that you remove the stale XXX comment only for one
direction. Care to post a patch that removes them separately? Else I
can do that as well.

[I'd queue that patch in front of this patchset, but no need to resend
for that.]
