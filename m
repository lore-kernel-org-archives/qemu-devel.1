Received: from eggs.gnu.org ([2001:4830:134:3::10]:37669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1et7jD-0005ui-WB
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1et7jA-000248-TX
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:13:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44046
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1et7jA-00023k-OM
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:13:40 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2688uq4027076
	for <qemu-devel@nongnu.org>; Tue, 6 Mar 2018 03:13:40 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ghq4j8cx9-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 03:13:39 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 6 Mar 2018 08:13:37 -0000
References: <20180305174914.25931-1-nia.alarie@gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 6 Mar 2018 09:13:33 +0100
MIME-Version: 1.0
In-Reply-To: <20180305174914.25931-1-nia.alarie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <14338610-c556-9e3d-ab4e-fc7658217c76@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] s390x/sclpconsole: Remove dead code -
 delete error handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nia Alarie <nia.alarie@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au



On 03/05/2018 06:49 PM, Nia Alarie wrote:
> The other event handlers (quiesce and cpu) do not define these
> handlers, and this one does nothing, so it can be removed.
> 
> virtio_ccw_exit always returns 0, so change its return type to
> void.
> 
> Signed-off-by: Nia Alarie <nia.alarie@gmail.com>


I would like to have 2 patches to make the subject non-misleading.

patch1: sclp/event
patch2: virtio-ccw

With that
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  hw/char/sclpconsole-lm.c          |  6 ------
>  hw/char/sclpconsole.c             |  6 ------
>  hw/s390x/event-facility.c         | 14 --------------
>  hw/s390x/virtio-ccw.c             |  6 +++---
>  hw/s390x/virtio-ccw.h             |  2 +-
>  include/hw/s390x/event-facility.h |  1 -
>  6 files changed, 4 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
> index c500bdaf29..84efd8df73 100644
> --- a/hw/char/sclpconsole-lm.c
> +++ b/hw/char/sclpconsole-lm.c
> @@ -318,11 +318,6 @@ static int console_init(SCLPEvent *event)
>      return 0;
>  }
> 
> -static int console_exit(SCLPEvent *event)
> -{
> -    return 0;
> -}
> -
>  static void console_reset(DeviceState *dev)
>  {
>     SCLPEvent *event = SCLP_EVENT(dev);
> @@ -349,7 +344,6 @@ static void console_class_init(ObjectClass *klass, void *data)
>      dc->reset = console_reset;
>      dc->vmsd = &vmstate_sclplmconsole;
>      ec->init = console_init;
> -    ec->exit = console_exit;
>      ec->get_send_mask = send_mask;
>      ec->get_receive_mask = receive_mask;
>      ec->can_handle_event = can_handle_event;
> diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
> index d0265dfa7a..e6ba0a46bd 100644
> --- a/hw/char/sclpconsole.c
> +++ b/hw/char/sclpconsole.c
> @@ -246,11 +246,6 @@ static void console_reset(DeviceState *dev)
>     scon->notify = false;
>  }
> 
> -static int console_exit(SCLPEvent *event)
> -{
> -    return 0;
> -}
> -
>  static Property console_properties[] = {
>      DEFINE_PROP_CHR("chardev", SCLPConsole, chr),
>      DEFINE_PROP_END_OF_LIST(),
> @@ -265,7 +260,6 @@ static void console_class_init(ObjectClass *klass, void *data)
>      dc->reset = console_reset;
>      dc->vmsd = &vmstate_sclpconsole;
>      ec->init = console_init;
> -    ec->exit = console_exit;
>      ec->get_send_mask = send_mask;
>      ec->get_receive_mask = receive_mask;
>      ec->can_handle_event = can_handle_event;
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index 155a69467b..79de3c738f 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -431,26 +431,12 @@ static void event_realize(DeviceState *qdev, Error **errp)
>      }
>  }
> 
> -static void event_unrealize(DeviceState *qdev, Error **errp)
> -{
> -    SCLPEvent *event = SCLP_EVENT(qdev);
> -    SCLPEventClass *child = SCLP_EVENT_GET_CLASS(event);
> -    if (child->exit) {
> -        int rc = child->exit(event);
> -        if (rc < 0) {
> -            error_setg(errp, "SCLP event exit failed.");
> -            return;
> -        }
> -    }
> -}
> -
>  static void event_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> 
>      dc->bus_type = TYPE_SCLP_EVENTS_BUS;
>      dc->realize = event_realize;
> -    dc->unrealize = event_unrealize;
>  }
> 
>  static const TypeInfo sclp_event_type_info = {
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 8f7fbc2ab7..0773818a82 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -752,7 +752,7 @@ out_err:
>      g_free(sch);
>  }
> 
> -static int virtio_ccw_exit(VirtioCcwDevice *dev)
> +static void virtio_ccw_exit(VirtioCcwDevice *dev)
>  {
>      CcwDevice *ccw_dev = CCW_DEVICE(dev);
>      SubchDev *sch = ccw_dev->sch;
> @@ -765,7 +765,6 @@ static int virtio_ccw_exit(VirtioCcwDevice *dev)
>          release_indicator(&dev->routes.adapter, dev->indicators);
>          dev->indicators = NULL;
>      }
> -    return 0;
>  }
> 
>  static void virtio_ccw_net_realize(VirtioCcwDevice *ccw_dev, Error **errp)
> @@ -1710,7 +1709,8 @@ static int virtio_ccw_busdev_exit(DeviceState *dev)
>      VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
>      VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
> 
> -    return _info->exit(_dev);
> +    _info->exit(_dev);
> +    return 0;
>  }
> 
>  static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_dev,
> diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
> index 3905f3a3d6..8ffe7fe095 100644
> --- a/hw/s390x/virtio-ccw.h
> +++ b/hw/s390x/virtio-ccw.h
> @@ -76,7 +76,7 @@ typedef struct VirtioCcwDevice VirtioCcwDevice;
>  typedef struct VirtIOCCWDeviceClass {
>      CCWDeviceClass parent_class;
>      void (*realize)(VirtioCcwDevice *dev, Error **errp);
> -    int (*exit)(VirtioCcwDevice *dev);
> +    void (*exit)(VirtioCcwDevice *dev);
>  } VirtIOCCWDeviceClass;
> 
>  /* Performance improves when virtqueue kick processing is decoupled from the
> diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
> index 5119b9b7f0..b913f85edc 100644
> --- a/include/hw/s390x/event-facility.h
> +++ b/include/hw/s390x/event-facility.h
> @@ -174,7 +174,6 @@ typedef struct SCLPEvent {
>  typedef struct SCLPEventClass {
>      DeviceClass parent_class;
>      int (*init)(SCLPEvent *event);
> -    int (*exit)(SCLPEvent *event);
> 
>      /* get SCLP's send mask */
>      unsigned int (*get_send_mask)(void);
> 
