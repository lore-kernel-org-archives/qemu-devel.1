Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE6DC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF2A21E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ui33b5Gn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF2A21E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNKE-0005Gz-DG
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45709)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNJn-0004b7-DB
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNJm-0001rP-64
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:53:35 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45345)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvNJl-0001qp-VE
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:53:34 -0400
Received: by mail-ot1-x344.google.com with SMTP id x21so12085805otq.12
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 07:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o4YAZdlZGHTYqTNb1MVuymX+rEuuIehN8yuCA4wcFOk=;
 b=Ui33b5GnMVWOX3+cLzhijVULDAi8R2EYRcn0u898iE9V13IVpas4MCY5ikMdRjkyFP
 fVVCtumv+b3k5GtVD03mund+LAuCH6cuPSPT+qlPSh4qo+BJOuP2nG0uUGVJGbqb8113
 hGBhthJSjOd3kZjaZDZqIksUP0GHll0ejZAtdnjGgJF+i6ThUIHPHcfRlKWwPvEx/WDZ
 8gyEKj9z7tHh6ccgRvdEaGrcXQu7KycO+949CmwwqwY99GfzQNFF8VBL62nbQATG783X
 8yLmzxV9EquvnGphu7ShSkIXFdDiRPlGkc0OVOBLj6eTTasaXdkQpO6pHcnQFGjy0Uce
 vnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o4YAZdlZGHTYqTNb1MVuymX+rEuuIehN8yuCA4wcFOk=;
 b=pFxbb6oeq05bSyioRIQVK9nJgiUBo6CcWW/YNZA7ZydSLIZO3UiKa17QvGWGD5z2je
 6LWKP+kcRhbNZuvkOnljzRCZZNhpWLuMlDLm2LxPD/dSmZAXPMyj5yb2JeQRiyTeqgrk
 FRZdz+7+zoRVOPxTQA7+Q5ZqvOisbrpki0b2yu37WGNEm4/bHHWWrCkiTnc63yHsqHcS
 Kc3AZEnbXIenowDeF6r+5ceq0lD5TLX3Wid7KvQLMY4/xtZUNbGxNrnACW5rF82JGNz9
 Xm3qPiuY4KrpDiG4Ek2tqjzmTSldLGUz7l60cWjg9ivPVfA7NIgGazS88JxLR79lvhBD
 BWtA==
X-Gm-Message-State: APjAAAXaqQbuvouGml7gP+EBKVmtG2xdJRFSaqmRjplnkhj2jcfgc/KY
 L/vj8pYyEnRo1ymvRmmzHol44MmwE6K2U5p1RBbqZQ==
X-Google-Smtp-Source: APXvYqwDPiJD1SvZ/LWYk9E4hSPWe35DYidNyKtqUr4lb2ofC7qNDVk75yJLfVgwjFnqkqo/OTOMgQXnosrYGfyZ9eE=
X-Received: by 2002:a05:6808:8c2:: with SMTP id k2mr250210oij.98.1565189612881; 
 Wed, 07 Aug 2019 07:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-7-damien.hedde@greensocs.com>
In-Reply-To: <20190729145654.14644-7-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 15:53:22 +0100
Message-ID: <CAFEAcA8xPTm3g7bg8wEY=ZwpeJOnEXGbhmCt+VvrRDf8tCRRpw@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v3 06/33] add the vmstate description for
 device reset state
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
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 at 15:58, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> It contains the resetting counter and cold flag status.
>
> At this point, migration of bus reset related state (counter and cold/warm
> flag) is handled by parent device. This done using the post_load

"is done"

> function in the vmsd subsection.
>
> This is last point allow to add an initial support of migration with part of
> qdev/qbus tree in reset state under the following condition:
> + time-lasting reset are asserted on Device only
>
> Note that if this condition is not respected, migration will succeed and
> no failure will occurs. The only impact is that the resetting counter
> of a bus may lower afer a migration.

We should just migrate the bus state correctly -- see below.

> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  hw/core/Makefile.objs  |  1 +
>  hw/core/qdev-vmstate.c | 45 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 hw/core/qdev-vmstate.c
>
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index d9234aa98a..49e9be0228 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -4,6 +4,7 @@ common-obj-y += bus.o reset.o
>  common-obj-y += resettable.o
>  common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
>  common-obj-$(CONFIG_SOFTMMU) += fw-path-provider.o
> +common-obj-$(CONFIG_SOFTMMU) += qdev-vmstate.o
>  # irq.o needed for qdev GPIO handling:
>  common-obj-y += irq.o
>  common-obj-y += hotplug.o
> diff --git a/hw/core/qdev-vmstate.c b/hw/core/qdev-vmstate.c
> new file mode 100644
> index 0000000000..07b010811f
> --- /dev/null
> +++ b/hw/core/qdev-vmstate.c
> @@ -0,0 +1,45 @@
> +/*
> + * Device vmstate
> + *
> + * Copyright (c) 2019 GreenSocs
> + *
> + * Authors:
> + *   Damien Hedde
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/qdev.h"
> +#include "migration/vmstate.h"
> +
> +static bool device_vmstate_reset_needed(void *opaque)
> +{
> +    DeviceState *dev = (DeviceState *) opaque;
> +    return dev->resetting != 0;
> +}
> +
> +static int device_vmstate_reset_post_load(void *opaque, int version_id)
> +{
> +    DeviceState *dev = (DeviceState *) opaque;
> +    BusState *bus;
> +    QLIST_FOREACH(bus, &dev->child_bus, sibling) {
> +        bus->resetting = dev->resetting;
> +        bus->reset_is_cold = dev->reset_is_cold;
> +    }

Bus reset state might not be the same as the parent device's
reset state, so we need to migrate them both separately.

The way to do this is that in a pre-save hook we iterate
through the child buses and capture their state into
an array. Then we can migrate the array. In the post-load
hook we can set the bus state fields from the array contents.
VMSTATE_WITH_TMP is useful for this kind of situation.

One thing I'm slightly wary of here is that this will mean
that the ordering of child buses within the child_bus
array becomes significant to avoid migration compat breaks.
I think this is OK, though.

> +    return 0;
> +}
> +
> +const struct VMStateDescription device_vmstate_reset = {
> +    .name = "device_reset",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .needed = device_vmstate_reset_needed,
> +    .post_load = device_vmstate_reset_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(resetting, DeviceState),
> +        VMSTATE_BOOL(reset_is_cold, DeviceState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};

This isn't used -- I think you should squash patch 7 in
with this one.

thanks
-- PMM

