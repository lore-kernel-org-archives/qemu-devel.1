Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA44AC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58FA21BF2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCLEwwbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58FA21BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNYW-0002fH-Ur
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49321)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNXm-0001Kz-2s
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNXk-0001tF-Jm
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:08:01 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvNXk-0001se-Bt
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:08:00 -0400
Received: by mail-ot1-x342.google.com with SMTP id s20so40087990otp.4
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h5na1YqadXDFBRFP9m9NOGDLGc+2pkzDG9ETypEMJvg=;
 b=XCLEwwbwiDnKwLmkG8o3eRnOoERzguUFVtB6pWVBd7s17pv1c/mdcnyvz7tsykyT9o
 HfQ+sKL6xweJrYtaxI9TXh+HTnvFC9QQdESyH0+kIA6hdlMeTkULLGt2Vd27ULzPZfke
 CIQ9FHmP0y+KVyKX1iszhKIAOVCus7dYGLaRYZqLTuJjuauzupm+fjN61OP/yMpE9WQ7
 5rrNfH62+iP4XzEKFYLjdjMjY/4N8ox8p0/hCg+welZiTLkgCySRw1M3LYjM3XyAvBbL
 QDPq8p6boeQE17JYvwRUDDwNWRuGjxfaz/4RQ+vRzXHLg4S+IkIMoHWGH7hQinWww/iY
 J9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h5na1YqadXDFBRFP9m9NOGDLGc+2pkzDG9ETypEMJvg=;
 b=UhdyUC2OMb1rM9hg0Dev1zBaux6L2TJl2+lnwAU3aGtZLNNVTDn+0cN2I4SiabHDtz
 MOH+ndjIoUjZ8IUGkN46zIESrrtVw9AWt9L+tL2TvJIzIsZBucXPSn1pB0pCcD8LuFm3
 GMDMk578pi9T5Bt5sbZgRFrUtUbr+KR2bYmaVFzHjW0/Yh7V+htuC6kuILpA/Ea9warq
 V8T5an7FLQmr1CW4PPoYjLO2+liqdN8eLTtZyATYK0yqQRXYUxfQsFA+Vo+hkPXlEBtu
 Gx73HY7rG/X3dcpnxnw/D6TZDIORcQxK0Swew+F1nJ/5k3BwAz5AihyKV05XLtyJQgpi
 p8Yg==
X-Gm-Message-State: APjAAAWimP1t7Jw9FHGbrvF+sE3RFKh8Ia3pbBYQXkMFmDeSyeqcKUkr
 dTByktx+xyf/0B9nEt6yD1cJnDpyoFJhz1XaLKqPPw==
X-Google-Smtp-Source: APXvYqy5biMHiNZljCJP5duG7y3jLY33KzwQBJqgBpqwl9EdE90ShqJ4LkaokAdXBTTOYA9MtzkzTbJMwGDPzMtRWBM=
X-Received: by 2002:a5d:948f:: with SMTP id v15mr9171463ioj.93.1565190479332; 
 Wed, 07 Aug 2019 08:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-8-damien.hedde@greensocs.com>
In-Reply-To: <20190729145654.14644-8-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 16:07:47 +0100
Message-ID: <CAFEAcA-W0SaaGbUnGZ0b61ngxKY8R9xjwGXeN+=MaUi4bMDgNg@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 07/33] automatically add vmstate for
 reset support in devices
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 at 15:59, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> This add the reset related sections for every QOM
> device.

A bit more detail in the commit message would help, I think --
this is adding extra machinery which has to copy and modify
the VMStateDescription passed in by the device in order to
add the subsection that handles reset.

I've added Dave Gilbert to the already long cc list since this
is migration related.

> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  hw/core/qdev-vmstate.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  hw/core/qdev.c         | 12 +++++++++++-
>  include/hw/qdev-core.h |  3 +++
>  stubs/Makefile.objs    |  1 +
>  stubs/device.c         |  7 +++++++
>  5 files changed, 63 insertions(+), 1 deletion(-)
>  create mode 100644 stubs/device.c
>
> diff --git a/hw/core/qdev-vmstate.c b/hw/core/qdev-vmstate.c
> index 07b010811f..24f8465c61 100644
> --- a/hw/core/qdev-vmstate.c
> +++ b/hw/core/qdev-vmstate.c
> @@ -43,3 +43,44 @@ const struct VMStateDescription device_vmstate_reset = {
>          VMSTATE_END_OF_LIST()
>      },
>  };
> +
> +static VMStateDescription *vmsd_duplicate_and_append(
> +        const VMStateDescription *old_vmsd,
> +        const VMStateDescription *new_subsection)
> +{
> +    VMStateDescription *vmsd;
> +    int n = 0;
> +
> +    assert(old_vmsd && new_subsection);
> +
> +    vmsd = (VMStateDescription *) g_memdup(old_vmsd, sizeof(*vmsd));
> +
> +    if (old_vmsd->subsections) {
> +        while (old_vmsd->subsections[n]) {
> +            n += 1;
> +        }
> +    }
> +    vmsd->subsections = g_new(const VMStateDescription *, n + 2);
> +
> +    if (old_vmsd->subsections) {
> +        memcpy(vmsd->subsections, old_vmsd->subsections,
> +               sizeof(VMStateDescription *) * n);
> +    }
> +    vmsd->subsections[n] = new_subsection;
> +    vmsd->subsections[n + 1] = NULL;
> +
> +    return vmsd;
> +}
> +
> +void device_class_build_extended_vmsd(DeviceClass *dc)
> +{
> +    assert(dc->vmsd);
> +    assert(!dc->vmsd_ext);
> +
> +    /* forge a subsection with proper name */
> +    VMStateDescription *reset;
> +    reset = g_memdup(&device_vmstate_reset, sizeof(*reset));
> +    reset->name = g_strdup_printf("%s/device_reset", dc->vmsd->name);
> +
> +    dc->vmsd_ext = vmsd_duplicate_and_append(dc->vmsd, reset);
> +}

This will allocate memory, but there is no corresponding
code which frees it. This means you'll have a memory leak
across device realize->unrealize for hotplug devices.

> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index e9e5f2d5f9..88387d3743 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -45,7 +45,17 @@ bool qdev_hot_removed = false;
>  const VMStateDescription *qdev_get_vmsd(DeviceState *dev)
>  {
>      DeviceClass *dc = DEVICE_GET_CLASS(dev);
> -    return dc->vmsd;
> +
> +    if (!dc->vmsd) {
> +        return NULL;
> +    }
> +
> +    if (!dc->vmsd_ext) {
> +        /* build it first time we need it */
> +        device_class_build_extended_vmsd(dc);
> +    }
> +
> +    return dc->vmsd_ext;
>  }

Unfortunately not everything that wants the VMSD calls
this function. migration/savevm.c:dump_vmstate_json_to_file()
does a direct access to dc->vmsd, so we need to fix that first.

Devices which don't use dc->vmsd won't get this and so
their reset state won't be migrated. That's OK for anything
that's still not yet a QOM device, I guess -- it's not possible
for them to be in a 'held in reset' state anyway, so the
extra subsection would never be needed.

The one I'm less sure about is the 'virtio' devices, which
have to do something odd with migration state for backwards
compat reasons. At the moment they can't be in a situation
where they're being held in reset when we do a migration,
but since they're PCI devices they might in future be possible
to put into new boards/pci controllers that would let them
be in that situation.

>  static void bus_remove_child(BusState *bus, DeviceState *child)
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 1670ae41bb..926d4bbcb1 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -120,6 +120,7 @@ typedef struct DeviceClass {
>
>      /* device state */
>      const struct VMStateDescription *vmsd;
> +    const struct VMStateDescription *vmsd_ext;
>
>      /* Private to qdev / bus.  */
>      const char *bus_type;
> @@ -520,6 +521,8 @@ void device_class_set_parent_unrealize(DeviceClass *dc,
>
>  const struct VMStateDescription *qdev_get_vmsd(DeviceState *dev);
>
> +void device_class_build_extended_vmsd(DeviceClass *dc);
> +
>  const char *qdev_fw_name(DeviceState *dev);
>
>  Object *qdev_get_machine(void);
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 9c7393b08c..432b56f290 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -40,4 +40,5 @@ stub-obj-y += pci-host-piix.o
>  stub-obj-y += ram-block.o
>  stub-obj-y += ramfb.o
>  stub-obj-y += fw_cfg.o
> +stub-obj-y += device.o
>  stub-obj-$(CONFIG_SOFTMMU) += semihost.o
> diff --git a/stubs/device.c b/stubs/device.c
> new file mode 100644
> index 0000000000..e9b4f57e5f
> --- /dev/null
> +++ b/stubs/device.c
> @@ -0,0 +1,7 @@
> +#include "qemu/osdep.h"
> +#include "hw/qdev-core.h"
> +
> +void device_class_build_extended_vmsd(DeviceClass *dc)
> +{
> +    return;
> +}
> --
> 2.22.0


thanks
-- PMM

