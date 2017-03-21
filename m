Received: from eggs.gnu.org ([2001:4830:134:3::10]:45461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqIXx-00066m-1s
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqIXu-0005lH-Ad
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:05:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cqIXu-0005l8-1b
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:05:50 -0400
References: <20170320180024.23432-1-arvolkov@inbox.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <07b024e8-fb7e-ba14-19ce-7f82c4703460@redhat.com>
Date: Tue, 21 Mar 2017 13:05:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170320180024.23432-1-arvolkov@inbox.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw: dead code removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Volkov <arvolkov@inbox.ru>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, kraxel@redhat.com, agraf@suse.de, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Frederic Konrad <fred.konrad@greensocs.com>

On 20.03.2017 19:00, Anton Volkov wrote:
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

Please avoid a "return;" at the end of a void function, that's just
superfluous.
(But in this case, as it has been mentioned by others already, I'd also
recommend to rather remove the function completely instead of having an
empty function here)

 Thomas
