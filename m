Received: from eggs.gnu.org ([2001:4830:134:3::10]:48015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d2Zum-0007mB-Vm
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d2Zuf-0000Ev-AP
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:04:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d2Zuf-0000Em-21
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:04:05 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3O941rY016278
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 05:04:02 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a0mmcck7f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 05:04:02 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 24 Apr 2017 10:03:41 +0100
Date: Mon, 24 Apr 2017 11:03:34 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1492626091-30531-2-git-send-email-tgnyang@gmail.com>
References: <1492626091-30531-1-git-send-email-tgnyang@gmail.com>
	<1492626091-30531-2-git-send-email-tgnyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170424110334.70c8286f.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/s390x: make virtio_ccw_exit
 function in virtio-ccw return void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <tgnyang@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, 20 Apr 2017 02:21:30 +0800
Zihan Yang <tgnyang@gmail.com> wrote:

>     Note that only the virtio_ccw_exit, which is the exit function
>     of VirtIOCCWDeviceClass, is modified to return void in this patch.
>     'virtio_ccw_busdev_exit' belongs to DeviceClass so it remains
>     unchanged for the moment to give a split-out patch, because
>     modifying it would involve some other folders like hw/audio.

Change the last sentence to "DeviceClass::exit will be converted to
void in another patch" or so.

Also, the same leading whitespace as in your previous patch.

> 
> Signed-off-by: Zihan Yang <tgnyang@gmail.com>
> ---
>  hw/s390x/event-facility.c | 6 +-----
>  hw/s390x/virtio-ccw.c     | 6 +++---
>  hw/s390x/virtio-ccw.h     | 2 +-
>  3 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index 34b2faf..f7c509c 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -413,11 +413,7 @@ static void event_unrealize(DeviceState *qdev, Error **errp)
>      SCLPEvent *event = SCLP_EVENT(qdev);
>      SCLPEventClass *child = SCLP_EVENT_GET_CLASS(event);
>      if (child->exit) {
> -        int rc = child->exit(event);
> -        if (rc < 0) {
> -            error_setg(errp, "SCLP event exit failed.");
> -            return;
> -        }
> +        child->exit(event);
>      }
>  }

Ah, here's the hunk that should have been in the previous patch.

> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 00b3bde..0dbd3ee 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -722,7 +722,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
>      }
>  }
> 
> -static int virtio_ccw_exit(VirtioCcwDevice *dev)
> +static void virtio_ccw_exit(VirtioCcwDevice *dev)
>  {
>      CcwDevice *ccw_dev = CCW_DEVICE(dev);
>      SubchDev *sch = ccw_dev->sch;
> @@ -735,7 +735,6 @@ static int virtio_ccw_exit(VirtioCcwDevice *dev)
>          release_indicator(&dev->routes.adapter, dev->indicators);
>          dev->indicators = NULL;
>      }
> -    return 0;
>  }
> 
>  static void virtio_ccw_net_realize(VirtioCcwDevice *ccw_dev, Error **errp)
> @@ -1621,7 +1620,8 @@ static int virtio_ccw_busdev_exit(DeviceState *dev)
>      VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
>      VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
> 
> -    return _info->exit(_dev);
> +    _info->exit(_dev);
> +    return 0; /* TODO workaround, should remove once converted to unrealize */

I find that comment a bit confusing - just omit it?

>  }
> 
>  static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_dev,
> diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
> index 41d4010..ce8baa3 100644
> --- a/hw/s390x/virtio-ccw.h
> +++ b/hw/s390x/virtio-ccw.h
> @@ -74,7 +74,7 @@ typedef struct VirtioCcwDevice VirtioCcwDevice;
>  typedef struct VirtIOCCWDeviceClass {
>      CCWDeviceClass parent_class;
>      void (*realize)(VirtioCcwDevice *dev, Error **errp);
> -    int (*exit)(VirtioCcwDevice *dev);
> +    void (*exit)(VirtioCcwDevice *dev);
>  } VirtIOCCWDeviceClass;
> 
>  /* Performance improves when virtqueue kick processing is decoupled from the
