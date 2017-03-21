Received: from eggs.gnu.org ([2001:4830:134:3::10]:35698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cqF9m-0003Jq-4U
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 04:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cqF9h-000547-5m
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 04:28:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53818
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cqF9g-00053P-VU
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 04:28:37 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2L8NX0u037026
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 04:28:36 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29amb2xuuu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 04:28:35 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 21 Mar 2017 08:28:32 -0000
Date: Tue, 21 Mar 2017 09:28:27 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170320180024.23432-1-arvolkov@inbox.ru>
References: <20170320180024.23432-1-arvolkov@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170321092827.20bca461.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw: dead code removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Volkov <arvolkov@inbox.ru>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, kraxel@redhat.com, agraf@suse.de

On Mon, 20 Mar 2017 21:00:24 +0300
Anton Volkov <arvolkov@inbox.ru> wrote:

> Made functions *_exit in hw/ return void instead of int (they returned 0 all the time)
> and removed related return value checks

Makes sense, I guess. Better make the title "hw: make exit callbacks
void" or so, though.

> 
> Signed-off-by: Anton Volkov <arvolkov@inbox.ru>
> ---
>  hw/audio/hda-codec.c              | 3 +--
>  hw/audio/intel-hda.c              | 3 +--
>  hw/audio/intel-hda.h              | 2 +-
>  hw/char/sclpconsole-lm.c          | 4 ++--
>  hw/char/sclpconsole.c             | 4 ++--
>  hw/core/qdev.c                    | 6 +-----
>  hw/s390x/event-facility.c         | 6 +-----
>  hw/s390x/virtio-ccw.c             | 7 +++----
>  hw/s390x/virtio-ccw.h             | 2 +-
>  hw/usb/dev-smartcard-reader.c     | 3 +--
>  include/hw/qdev-core.h            | 2 +-
>  include/hw/s390x/event-facility.h | 2 +-
>  12 files changed, 16 insertions(+), 28 deletions(-)
> 

> diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
> index 07d6ebd..fbe5b42 100644
> --- a/hw/char/sclpconsole-lm.c
> +++ b/hw/char/sclpconsole-lm.c
> @@ -318,9 +318,9 @@ static int console_init(SCLPEvent *event)
>      return 0;
>  }
>  
> -static int console_exit(SCLPEvent *event)
> +static void console_exit(SCLPEvent *event)
>  {
> -    return 0;
> +    return;
>  }
>  
>  static void console_reset(DeviceState *dev)
> diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
> index b78f240..644f7cd 100644
> --- a/hw/char/sclpconsole.c
> +++ b/hw/char/sclpconsole.c
> @@ -246,9 +246,9 @@ static void console_reset(DeviceState *dev)
>     scon->notify = false;
>  }
>  
> -static int console_exit(SCLPEvent *event)
> +static void console_exit(SCLPEvent *event)
>  {
> -    return 0;
> +    return;
>  }
>  

The two sclp callbacks are not very useful in any case...

>  static Property console_properties[] = {

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

...and this makes much more sense than stopping midway with an error.

>      }
>  }
>  
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 00b3bde..d1c4ff6 100644
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
> @@ -1616,12 +1615,12 @@ static void virtio_ccw_busdev_realize(DeviceState *dev, Error **errp)
>      virtio_ccw_device_realize(_dev, errp);
>  }
>  
> -static int virtio_ccw_busdev_exit(DeviceState *dev)
> +static void virtio_ccw_busdev_exit(DeviceState *dev)
>  {
>      VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
>      VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
>  
> -    return _info->exit(_dev);
> +    _info->exit(_dev);
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

> diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
> index def1bb0..1a32f3a 100644
> --- a/include/hw/s390x/event-facility.h
> +++ b/include/hw/s390x/event-facility.h
> @@ -162,7 +162,7 @@ typedef struct SCLPEvent {
>  typedef struct SCLPEventClass {
>      DeviceClass parent_class;
>      int (*init)(SCLPEvent *event);
> -    int (*exit)(SCLPEvent *event);
> +    void (*exit)(SCLPEvent *event);
>  
>      /* get SCLP's send mask */
>      unsigned int (*get_send_mask)(void);

I'd take a factored-out s390x patch through my tree. In any case,

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>

for the s390x parts.
