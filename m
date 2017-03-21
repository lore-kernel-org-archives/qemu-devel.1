Received: from eggs.gnu.org ([2001:4830:134:3::10]:40570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqGET-0002cH-LX
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqGEQ-0005KZ-EU
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:37:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqGEQ-0005K9-59
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:37:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170320180024.23432-1-arvolkov@inbox.ru>
Date: Tue, 21 Mar 2017 10:37:25 +0100
In-Reply-To: <20170320180024.23432-1-arvolkov@inbox.ru> (Anton Volkov's
	message of "Mon, 20 Mar 2017 21:00:24 +0300")
Message-ID: <87o9wvrmwa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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

First of all, subject "hw: dead code removal" is awfully vague.

Anton Volkov <arvolkov@inbox.ru> writes:

> Made functions *_exit in hw/ return void instead of int (they returned 0 all the time)
> and removed related return value checks
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
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index 52d4640..5402cd1 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -520,7 +520,7 @@ static int hda_audio_init(HDACodecDevice *hda, const struct desc_codec *desc)
>      return 0;
>  }
>  
> -static int hda_audio_exit(HDACodecDevice *hda)
> +static void hda_audio_exit(HDACodecDevice *hda)
>  {
>      HDAAudioState *a = HDA_AUDIO(hda);
>      HDAAudioStream *st;
> @@ -539,7 +539,6 @@ static int hda_audio_exit(HDACodecDevice *hda)
>          }
>      }
>      AUD_remove_card(&a->card);
> -    return 0;
>  }
>  
>  static int hda_audio_post_load(void *opaque, int version)
> diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
> index 537face..991c704 100644
> --- a/hw/audio/intel-hda.c
> +++ b/hw/audio/intel-hda.c
> @@ -70,7 +70,7 @@ static void hda_codec_dev_realize(DeviceState *qdev, Error **errp)
>      }
>  }
>  
> -static int hda_codec_dev_exit(DeviceState *qdev)
> +static void hda_codec_dev_exit(DeviceState *qdev)
>  {
>      HDACodecDevice *dev = HDA_CODEC_DEVICE(qdev);
>      HDACodecDeviceClass *cdc = HDA_CODEC_DEVICE_GET_CLASS(dev);
> @@ -78,7 +78,6 @@ static int hda_codec_dev_exit(DeviceState *qdev)
>      if (cdc->exit) {
>          cdc->exit(dev);
>      }
> -    return 0;
>  }
>  
>  HDACodecDevice *hda_codec_find(HDACodecBus *bus, uint32_t cad)
> diff --git a/hw/audio/intel-hda.h b/hw/audio/intel-hda.h
> index d784bcf..53b78da 100644
> --- a/hw/audio/intel-hda.h
> +++ b/hw/audio/intel-hda.h
> @@ -38,7 +38,7 @@ typedef struct HDACodecDeviceClass
>      DeviceClass parent_class;
>  
>      int (*init)(HDACodecDevice *dev);
> -    int (*exit)(HDACodecDevice *dev);
> +    void (*exit)(HDACodecDevice *dev);
>      void (*command)(HDACodecDevice *dev, uint32_t nid, uint32_t data);
>      void (*stream)(HDACodecDevice *dev, uint32_t stnr, bool running, bool output);
>  } HDACodecDeviceClass;
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
>  static Property console_properties[] = {
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 1e7fb33..5415843 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -238,11 +238,7 @@ static void device_unrealize(DeviceState *dev, Error **errp)
>      DeviceClass *dc = DEVICE_GET_CLASS(dev);
>  
>      if (dc->exit) {
> -        int rc = dc->exit(dev);
> -        if (rc < 0) {
> -            error_setg(errp, "Device exit failed.");
> -            return;
> -        }
> +        dc->exit(dev);
>      }
>  }
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
> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
> index 757b8b3..71e3667 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -1289,7 +1289,7 @@ void ccid_card_card_inserted(CCIDCardState *card)
>      ccid_on_slot_change(s, true);
>  }
>  
> -static int ccid_card_exit(DeviceState *qdev)
> +static void ccid_card_exit(DeviceState *qdev)
>  {
>      CCIDCardState *card = CCID_CARD(qdev);
>      USBDevice *dev = USB_DEVICE(qdev->parent_bus->parent);
> @@ -1300,7 +1300,6 @@ static int ccid_card_exit(DeviceState *qdev)
>      }
>      ccid_card_exitfn(card);
>      s->card = NULL;
> -    return 0;
>  }
>  
>  static int ccid_card_init(DeviceState *qdev)
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index b44b476..0efd9e9 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -31,7 +31,7 @@ typedef enum DeviceCategory {
>  } DeviceCategory;
>  
>  typedef int (*qdev_initfn)(DeviceState *dev);
> -typedef int (*qdev_event)(DeviceState *dev);
> +typedef void (*qdev_event)(DeviceState *dev);
>  typedef void (*qdev_resetfn)(DeviceState *dev);
>  typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
>  typedef void (*DeviceUnrealize)(DeviceState *dev, Error **errp);
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

Four related changes, really:

1. HDACodecDeviceClass method exit()
2. VirtIOCCWDeviceClass method exit()
3. DeviceClass method exit()
4. SCLPEventClass method exit()

Regarding 3: method exit() needs to go.  Your patch shows there are only
a few remaining users.  Please convert them to unrealize().

The other three can stay.

Splitting up the patch into four parts could make it easier to
understand.  Or harder, can't say without trying it.  I'm not asking you
to try.
