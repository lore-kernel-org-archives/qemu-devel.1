Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D3DC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A0F21E73
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nCqkdfOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A0F21E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNie-0007TB-Ja
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51781)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNi5-0006c9-UF
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNi3-0006vj-Rc
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:18:41 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvNi3-0006uw-K3
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:18:39 -0400
Received: by mail-ot1-x342.google.com with SMTP id r21so99757385otq.6
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/3goy7jwv3jhlXZ6iqzuJ6FnnNayKsh8Ov6Om64DEbg=;
 b=nCqkdfOWUSOOHrh/49bO5iS9y/BXGIvciLlidMa440NRoTvpMTNF6LP81UvSv7rPZP
 WWcQEJwemwJujGsgcQPDMrAFVt4TOIfJZ3E6XUrCIMKmFAX7LZMrS05e+dgDzHHkQfI0
 lNqTgcRfT2dgrP3GHDij+jDKXr1ffb6hDE3UvvFSBViHeFfWNtRjj43rGMk08Hzk1W96
 G+6pYtO+HGfXGExrHrcX6oebeDUwuH4nNOWP/I3rD8++iRBgeN8aGyxajWO3N8MHtp4e
 VWoQLYCnAMuuQFDMuCRyL6iYsbQxFM/VWl6EA3Kal5gGFxHmoD6xTUSD1YGeK0ya5BfR
 u02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/3goy7jwv3jhlXZ6iqzuJ6FnnNayKsh8Ov6Om64DEbg=;
 b=IEH9Qvy5+9iZdIQDQ0KkuVhufbCYHnfgB9eUR8stxQhUTbeYPjnFkVXLA2tVvGX2mp
 WGqsB+oJa83GrL6BYsmpPjoWP1iU9DgXtFmce5LDFW12pQA5ztqOu7CrmOT12Xyntw2J
 qKtcxBFeQ99npPxi3+A2tUDLoLmeP1Q2p+s9CzzS2I1aj5rIWHxDhDq1m3GDyzecx2rc
 gBexRjydIpnFK71zuzhLE5PUozq5K2UpdEvmXRy+eSp2SYZlgmmSG5xZgwWqjSvc68jc
 Zm6jpVSsWuwPGJBjQtXt34b93uY1JHMDDg/cTswb2bWh8zyVjSN9rHS3J+xU7P5h0RoF
 CgTQ==
X-Gm-Message-State: APjAAAW+aG7q1mBXAb6QtfXqEqCTW1fnkoSQp0QygEiVK0XgMP4UFUll
 sEtd7HHgmh++ucuIuDHD4fqy2wDJk3RYYzY3MmonbA==
X-Google-Smtp-Source: APXvYqwhcfmFi6B5Hhzl/GHr6l1KAeN3HdoL9N2iDfwBYEG6IKA9KPaAHlBRwVj8tf8Jr1dr9O7Lt/jx98fmr4xXBaI=
X-Received: by 2002:a5e:9319:: with SMTP id k25mr10419005iom.137.1565191118479; 
 Wed, 07 Aug 2019 08:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-9-damien.hedde@greensocs.com>
In-Reply-To: <20190729145654.14644-9-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 16:18:27 +0100
Message-ID: <CAFEAcA_M5fOoQ8yN_1QhJ-WOLxra6B-Ltwh2DHtq6erz4V0a2A@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 08/33] Add function to control reset
 with gpio inputs
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

On Mon, 29 Jul 2019 at 15:59, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> It adds the possibility to add 2 gpios to control the warm and cold reset.
> With theses ios, the reset can be maintained during some time.
> Each io is associated with a state to detect level changes.
>
> Vmstate subsections are also added to the existsing device_reset
> subsection.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  hw/core/qdev-vmstate.c | 15 ++++++++++
>  hw/core/qdev.c         | 65 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/qdev-core.h | 57 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 137 insertions(+)
>
> diff --git a/hw/core/qdev-vmstate.c b/hw/core/qdev-vmstate.c
> index 24f8465c61..72f84c6cee 100644
> --- a/hw/core/qdev-vmstate.c
> +++ b/hw/core/qdev-vmstate.c
> @@ -24,10 +24,23 @@ static int device_vmstate_reset_post_load(void *opaque, int version_id)
>  {
>      DeviceState *dev = (DeviceState *) opaque;
>      BusState *bus;
> +    uint32_t io_count = 0;
> +
>      QLIST_FOREACH(bus, &dev->child_bus, sibling) {
>          bus->resetting = dev->resetting;
>          bus->reset_is_cold = dev->reset_is_cold;
>      }
> +
> +    if (dev->cold_reset_input.state) {
> +        io_count += 1;
> +    }
> +    if (dev->warm_reset_input.state) {
> +        io_count += 1;
> +    }
> +    /* ensure resetting count is coherent with io states */
> +    if (dev->resetting < io_count) {
> +        return -1;
> +    }
>      return 0;
>  }
>
> @@ -40,6 +53,8 @@ const struct VMStateDescription device_vmstate_reset = {
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32(resetting, DeviceState),
>          VMSTATE_BOOL(reset_is_cold, DeviceState),
> +        VMSTATE_BOOL(cold_reset_input.state, DeviceState),
> +        VMSTATE_BOOL(warm_reset_input.state, DeviceState),

If we're just adding these fields to this VMStateDescription
then this patch should come earlier in the series than the
patch where we create and start using the fields. Otherwise
there's a migration compat break between a QEMU just
before this patch and a QEMU with it. I think the simplest
fix is to put this patch before patches 6/7 and have a note
in the commit message that this functionality can't be used
until after the patch which adds the migration support.

>          VMSTATE_END_OF_LIST()
>      },
>  };
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 88387d3743..11a4de55ea 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -450,6 +450,67 @@ void qdev_init_gpio_in(DeviceState *dev, qemu_irq_handler handler, int n)
>      qdev_init_gpio_in_named(dev, handler, NULL, n);
>  }
>
> +static DeviceResetInputState *device_get_reset_input_state(DeviceState *dev,
> +                                                            bool cold)
> +{
> +    return cold ? &dev->cold_reset_input : &dev->warm_reset_input;
> +}
> +
> +static void device_reset_handler(DeviceState *dev, bool cold, bool level)
> +{
> +    DeviceResetInputState *dris = device_get_reset_input_state(dev, cold);
> +
> +    if (dris->type == DEVICE_RESET_ACTIVE_LOW) {
> +        level = !level;
> +    }
> +
> +    if (dris->state == level) {
> +        /* io state has not changed */
> +        return;
> +    }
> +
> +    dris->state = level;
> +
> +    if (level) {
> +        resettable_assert_reset(OBJECT(dev), cold);
> +    } else {
> +        resettable_deassert_reset(OBJECT(dev));
> +    }
> +}
> +
> +static void device_cold_reset_handler(void *opaque, int n, int level)
> +{
> +    device_reset_handler((DeviceState *) opaque, true, level);
> +}
> +
> +static void device_warm_reset_handler(void *opaque, int n, int level)
> +{
> +    device_reset_handler((DeviceState *) opaque, false, level);
> +}
> +
> +void qdev_init_reset_gpio_in_named(DeviceState *dev, const char *name,
> +                                   bool cold, DeviceResetActiveType type)
> +{
> +    DeviceResetInputState *dris = device_get_reset_input_state(dev, cold);
> +    qemu_irq_handler handler;
> +
> +    switch (type) {
> +    case DEVICE_RESET_ACTIVE_LOW:
> +    case DEVICE_RESET_ACTIVE_HIGH:
> +        break;
> +    default:
> +        assert(false);
> +        break;

The usual way to write this is
    g_assert_not_reached();
(and no following 'break').


But the whole switch statement seems to be a complicated way
of writing
   assert(type == DEVICE_RESET_ACTIVE_LOW || type == DEVICE_RESET_ACTIVE_HIGH);

> +    }
> +
> +    assert(!dris->exists);
> +    dris->exists = true;
> +    dris->type = type;
> +
> +    handler = cold ? device_cold_reset_handler : device_warm_reset_handler;
> +    qdev_init_gpio_in_named(dev, handler, name, 1);
> +}

thanks
-- PMM

