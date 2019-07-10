Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F78C74A35
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93922064B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgoObZlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93922064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlInI-0001XI-2m
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50401)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlIk5-0003l0-Ac
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlIk3-0003G6-C9
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:59:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hlIk2-00038f-CN
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 15:59:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id g17so3749464wrr.5
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 12:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gDDpEpey4sAkhttwGTcvfE+cB6UpxJ1NwcQkwHTBCJU=;
 b=LgoObZlb7vcIcUwM+I+Uw8gjFHEcc5HPbQnZrKTUtBOoo5bgWVza46020vvRUoNMAL
 VhCHxFXB+keo6n5b2WPajgBWZ6yLMeZ3uw5ti6cItxdQfB8pi55ztPyhe0zstODfR7IE
 1ljJijsnEqwDtFP9CX8IoGzNxgNN7vJkHeXbC7Mj2nSqb2tX0QLBEz+njcfRQEF00rEC
 NbnlMex8S6rMRQmlV5gkjwc4XFdJskPVyRosoHbNGTOKQuxIQMlWZs+Pdb1zOxRWXiUK
 7i1rDJCTbpztcmZLHqWQMTiIa8edmHdz8rZ8s70GerI3j8HE6cNQ3raGbxeVm6iaMLC8
 f08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gDDpEpey4sAkhttwGTcvfE+cB6UpxJ1NwcQkwHTBCJU=;
 b=r7Wc8GZIXswajy7EEtfkABQi8lWHAjDbp7kV4LDp0A3GEyVUo4KLrel/L+b4Y/2g7I
 aGiz6KnI37vi5E7/3WEPUL7S5WyeZANhMTPBd2lOtYIbDrIEmVsVKTs0jWhDPhnWALIy
 cn9qP6t1pJGyBtqhqVjRxVebdsS2tYtAUnQiJD4Q5tyBq1qtMjEzNkYeHTqdHR0TK+k9
 qRaZIg+qFvImttosJrWYlH0ptETLgMhLkrkSVZXTdNbT78eJkkRoe1XsW0daMxH6KB7w
 rTb5wnaDZP+vKpr368kZMfFpSB8UB7tjVPVY5Wco8yjOuWKV8392MeXXmltZd2Y4KFXB
 ByPQ==
X-Gm-Message-State: APjAAAXl0DTb2OyI+Nhqnf1Mj6pNSoGZ9LsSIEpMjHMXCMZRuwaimbls
 //kwxBVCPN6/Q30fh47AQPx1Ki0fi0rEJKkoT+egM0jF
X-Google-Smtp-Source: APXvYqyt+3/lm6dJ+4eQm3QFjf8OfsJDfI2ZPo7X1qGpb9gpXoOfVrKa+2cUHswQGzI/JvYsEi+6jZS69NVu7Ie2kOs=
X-Received: by 2002:adf:c70e:: with SMTP id k14mr684307wrg.201.1562788738699; 
 Wed, 10 Jul 2019 12:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
 <4f1ee2a0876bca759311c0efb31fbe7a6850fbad.1562695780.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <4f1ee2a0876bca759311c0efb31fbe7a6850fbad.1562695780.git.DirtY.iCE.hu@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 10 Jul 2019 23:58:46 +0400
Message-ID: <CAJ+F1CJyQX2fv51xe+5BzX1pnq=HqxG-0F5_LJJhyqXT6XrYtg@mail.gmail.com>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 03/11] audio: add audiodev properties to
 frontends
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 9, 2019 at 10:58 PM K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.i=
ce.hu@gmail.com> wrote:
>
> Finally add audiodev=3D options to audio frontends so users can specify
> which backend to use when multiple backends exist.  Not specifying an
> audiodev=3D option currently causes the first audiodev to be used, this i=
s
> fixed in the next commit.
>
> Example usage: -audiodev pa,id=3Dfoo -device AC97,audiodev=3Dfoo
>
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  audio/audio.h                    |  3 ++
>  include/hw/qdev-properties.h     |  3 ++
>  hw/audio/ac97.c                  |  1 +
>  hw/audio/adlib.c                 |  1 +
>  hw/audio/cs4231a.c               |  1 +
>  hw/audio/es1370.c                |  7 +++-
>  hw/audio/gus.c                   |  1 +
>  hw/audio/hda-codec.c             |  1 +
>  hw/audio/milkymist-ac97.c        |  6 ++++
>  hw/audio/pcspk.c                 |  1 +
>  hw/audio/pl041.c                 |  1 +
>  hw/audio/sb16.c                  |  1 +
>  hw/audio/wm8750.c                |  6 ++++
>  hw/core/qdev-properties-system.c | 57 ++++++++++++++++++++++++++++++++
>  hw/usb/dev-audio.c               |  1 +
>  15 files changed, 90 insertions(+), 1 deletion(-)
>
> diff --git a/audio/audio.h b/audio/audio.h
> index ad2457f4de..c0722a5cda 100644
> --- a/audio/audio.h
> +++ b/audio/audio.h
> @@ -181,4 +181,7 @@ void audio_legacy_help(void);
>  AudioState *audio_state_by_name(const char *name);
>  const char *audio_get_id(QEMUSoundCard *card);
>
> +#define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
> +    DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
> +
>  #endif /* QEMU_AUDIO_H */
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 1eae5ab056..de0b2c8423 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -35,6 +35,7 @@ extern const PropertyInfo qdev_prop_blocksize;
>  extern const PropertyInfo qdev_prop_pci_host_devaddr;
>  extern const PropertyInfo qdev_prop_uuid;
>  extern const PropertyInfo qdev_prop_arraylen;
> +extern const PropertyInfo qdev_prop_audiodev;
>  extern const PropertyInfo qdev_prop_link;
>  extern const PropertyInfo qdev_prop_off_auto_pcibar;
>  extern const PropertyInfo qdev_prop_pcie_link_speed;
> @@ -236,6 +237,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
>              + type_check(QemuUUID, typeof_field(_state, _field)),  \
>          .set_default =3D true,                                       \
>          }
> +#define DEFINE_PROP_AUDIODEV(_n, _s, _f) \
> +    DEFINE_PROP(_n, _s, _f, qdev_prop_audiodev, QEMUSoundCard)
>
>  #define DEFINE_PROP_END_OF_LIST()               \
>      {}
> diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
> index fb98da2678..0d8e524233 100644
> --- a/hw/audio/ac97.c
> +++ b/hw/audio/ac97.c
> @@ -1409,6 +1409,7 @@ static int ac97_init (PCIBus *bus)
>  }
>
>  static Property ac97_properties[] =3D {
> +    DEFINE_AUDIO_PROPERTIES(AC97LinkState, card),
>      DEFINE_PROP_UINT32 ("use_broken_id", AC97LinkState, use_broken_id, 0=
),
>      DEFINE_PROP_END_OF_LIST (),
>  };
> diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
> index 7dd9a89b89..df2e781788 100644
> --- a/hw/audio/adlib.c
> +++ b/hw/audio/adlib.c
> @@ -299,6 +299,7 @@ static void adlib_realizefn (DeviceState *dev, Error =
**errp)
>  }
>
>  static Property adlib_properties[] =3D {
> +    DEFINE_AUDIO_PROPERTIES(AdlibState, card),
>      DEFINE_PROP_UINT32 ("iobase",  AdlibState, port, 0x220),
>      DEFINE_PROP_UINT32 ("freq",    AdlibState, freq,  44100),
>      DEFINE_PROP_END_OF_LIST (),
> diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
> index 7216b41cc1..e3ea830b47 100644
> --- a/hw/audio/cs4231a.c
> +++ b/hw/audio/cs4231a.c
> @@ -689,6 +689,7 @@ static int cs4231a_init (ISABus *bus)
>  }
>
>  static Property cs4231a_properties[] =3D {
> +    DEFINE_AUDIO_PROPERTIES(CSState, card),
>      DEFINE_PROP_UINT32 ("iobase",  CSState, port, 0x534),
>      DEFINE_PROP_UINT32 ("irq",     CSState, irq,  9),
>      DEFINE_PROP_UINT32 ("dma",     CSState, dma,  3),
> diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
> index 260c142b70..7589671d20 100644
> --- a/hw/audio/es1370.c
> +++ b/hw/audio/es1370.c
> @@ -887,6 +887,11 @@ static int es1370_init (PCIBus *bus)
>      return 0;
>  }
>
> +static Property es1370_properties[] =3D {
> +    DEFINE_AUDIO_PROPERTIES(ES1370State, card),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void es1370_class_init (ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS (klass);
> @@ -903,6 +908,7 @@ static void es1370_class_init (ObjectClass *klass, vo=
id *data)
>      dc->desc =3D "ENSONIQ AudioPCI ES1370";
>      dc->vmsd =3D &vmstate_es1370;
>      dc->reset =3D es1370_on_reset;
> +    dc->props =3D es1370_properties;
>  }
>
>  static const TypeInfo es1370_info =3D {
> @@ -923,4 +929,3 @@ static void es1370_register_types (void)
>  }
>
>  type_init (es1370_register_types)
> -
> diff --git a/hw/audio/gus.c b/hw/audio/gus.c
> index 9ab51631d9..566864bc9e 100644
> --- a/hw/audio/gus.c
> +++ b/hw/audio/gus.c
> @@ -297,6 +297,7 @@ static int GUS_init (ISABus *bus)
>  }
>
>  static Property gus_properties[] =3D {
> +    DEFINE_AUDIO_PROPERTIES(GUSState, card),
>      DEFINE_PROP_UINT32 ("freq",    GUSState, freq,        44100),
>      DEFINE_PROP_UINT32 ("iobase",  GUSState, port,        0x240),
>      DEFINE_PROP_UINT32 ("irq",     GUSState, emu.gusirq,  7),
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index 84639b5424..967a10f189 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -840,6 +840,7 @@ static const VMStateDescription vmstate_hda_audio =3D=
 {
>  };
>
>  static Property hda_audio_properties[] =3D {
> +    DEFINE_AUDIO_PROPERTIES(HDAAudioState, card),
>      DEFINE_PROP_UINT32("debug", HDAAudioState, debug,   0),
>      DEFINE_PROP_BOOL("mixer", HDAAudioState, mixer,  true),
>      DEFINE_PROP_BOOL("use-timer", HDAAudioState, use_timer,  true),
> diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
> index bf6a5a6b96..4835229326 100644
> --- a/hw/audio/milkymist-ac97.c
> +++ b/hw/audio/milkymist-ac97.c
> @@ -329,6 +329,11 @@ static const VMStateDescription vmstate_milkymist_ac=
97 =3D {
>      }
>  };
>
> +static Property milkymist_ac97_properties[] =3D {
> +    DEFINE_AUDIO_PROPERTIES(MilkymistAC97State, card),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void milkymist_ac97_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -336,6 +341,7 @@ static void milkymist_ac97_class_init(ObjectClass *kl=
ass, void *data)
>      dc->realize =3D milkymist_ac97_realize;
>      dc->reset =3D milkymist_ac97_reset;
>      dc->vmsd =3D &vmstate_milkymist_ac97;
> +    dc->props =3D milkymist_ac97_properties;
>  }
>
>  static const TypeInfo milkymist_ac97_info =3D {
> diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
> index a7b3ab0c2b..01127304c2 100644
> --- a/hw/audio/pcspk.c
> +++ b/hw/audio/pcspk.c
> @@ -209,6 +209,7 @@ static const VMStateDescription vmstate_spk =3D {
>  };
>
>  static Property pcspk_properties[] =3D {
> +    DEFINE_AUDIO_PROPERTIES(PCSpkState, card),
>      DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  -1),
>      DEFINE_PROP_BOOL("migrate", PCSpkState, migrate,  true),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
> index 59c6ce1f2e..ce430a7821 100644
> --- a/hw/audio/pl041.c
> +++ b/hw/audio/pl041.c
> @@ -622,6 +622,7 @@ static const VMStateDescription vmstate_pl041 =3D {
>  };
>
>  static Property pl041_device_properties[] =3D {
> +    DEFINE_AUDIO_PROPERTIES(PL041State, codec.card),
>      /* Non-compact FIFO depth property */
>      DEFINE_PROP_UINT32("nc_fifo_depth", PL041State, fifo_depth,
>                         DEFAULT_FIFO_DEPTH),
> diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
> index a2db06a2bb..6b604979cf 100644
> --- a/hw/audio/sb16.c
> +++ b/hw/audio/sb16.c
> @@ -1421,6 +1421,7 @@ static int SB16_init (ISABus *bus)
>  }
>
>  static Property sb16_properties[] =3D {
> +    DEFINE_AUDIO_PROPERTIES(SB16State, card),
>      DEFINE_PROP_UINT32 ("version", SB16State, ver,  0x0405), /* 4.5 */
>      DEFINE_PROP_UINT32 ("iobase",  SB16State, port, 0x220),
>      DEFINE_PROP_UINT32 ("irq",     SB16State, irq,  5),
> diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
> index 81f83eea88..dfb4156ff4 100644
> --- a/hw/audio/wm8750.c
> +++ b/hw/audio/wm8750.c
> @@ -701,6 +701,11 @@ void wm8750_set_bclk_in(void *opaque, int new_hz)
>      wm8750_clk_update(s, 1);
>  }
>
> +static Property wm8750_properties[] =3D {
> +    DEFINE_AUDIO_PROPERTIES(WM8750State, card),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void wm8750_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -711,6 +716,7 @@ static void wm8750_class_init(ObjectClass *klass, voi=
d *data)
>      sc->recv =3D wm8750_rx;
>      sc->send =3D wm8750_tx;
>      dc->vmsd =3D &vmstate_wm8750;
> +    dc->props =3D wm8750_properties;
>  }
>
>  static const TypeInfo wm8750_info =3D {
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-s=
ystem.c
> index ba412dd2ca..bf9974370c 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -11,6 +11,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "audio/audio.h"
>  #include "net/net.h"
>  #include "hw/qdev.h"
>  #include "qapi/error.h"
> @@ -353,6 +354,62 @@ const PropertyInfo qdev_prop_netdev =3D {
>  };
>
>
> +/* --- audiodev --- */
> +static void get_audiodev(Object *obj, Visitor *v, const char* name,
> +                         void *opaque, Error **errp)
> +{
> +    DeviceState *dev =3D DEVICE(obj);
> +    Property *prop =3D opaque;
> +    QEMUSoundCard *card =3D qdev_get_prop_ptr(dev, prop);
> +    char *p =3D g_strdup(audio_get_id(card));
> +
> +    visit_type_str(v, name, &p, errp);
> +    g_free(p);
> +}
> +
> +static void set_audiodev(Object *obj, Visitor *v, const char* name,
> +                         void *opaque, Error **errp)
> +{
> +    DeviceState *dev =3D DEVICE(obj);
> +    Property *prop =3D opaque;
> +    QEMUSoundCard *card =3D qdev_get_prop_ptr(dev, prop);
> +    AudioState *state;
> +    Error *local_err =3D NULL;
> +    int err =3D 0;
> +    char *str;
> +
> +    if (dev->realized) {
> +        qdev_prop_set_after_realize(dev, name, errp);
> +        return;
> +    }
> +
> +    visit_type_str(v, name, &str, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    state =3D audio_state_by_name(str);
> +
> +    if (!state) {
> +        err =3D -ENOENT;
> +        goto out;
> +    }
> +    card->state =3D state;
> +
> +out:
> +    error_set_from_qdev_prop_error(errp, err, dev, prop, str);
> +    g_free(str);
> +}
> +
> +const PropertyInfo qdev_prop_audiodev =3D {
> +    .name =3D "str",
> +    .description =3D "ID of an audiodev to use as a backend",
> +    /* release done on shutdown */
> +    .get =3D get_audiodev,
> +    .set =3D set_audiodev,
> +};
> +
>  void qdev_prop_set_drive(DeviceState *dev, const char *name,
>                           BlockBackend *value, Error **errp)
>  {
> diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
> index 718ab53cbb..1b1cf91132 100644
> --- a/hw/usb/dev-audio.c
> +++ b/hw/usb/dev-audio.c
> @@ -666,6 +666,7 @@ static const VMStateDescription vmstate_usb_audio =3D=
 {
>  };
>
>  static Property usb_audio_properties[] =3D {
> +    DEFINE_AUDIO_PROPERTIES(USBAudioState, card),
>      DEFINE_PROP_UINT32("debug", USBAudioState, debug, 0),
>      DEFINE_PROP_UINT32("buffer", USBAudioState, buffer,
>                         32 * USBAUDIO_PACKET_SIZE),
> --
> 2.22.0
>
>


--
Marc-Andr=C3=A9 Lureau

