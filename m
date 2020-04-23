Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417BBC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066DF2076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3a/9cuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066DF2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRg1K-0003rO-05
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jRfz7-0000Iu-Sl
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jRfz6-0000FU-UA
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:50:01 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:33622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jRfz6-0000FG-Fz
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:50:00 -0400
Received: by mail-il1-x142.google.com with SMTP id q10so6429881ile.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s2Ewaz6asd7+7glK5X4/YBm3DhRWS13vOYaciNuoT2U=;
 b=V3a/9cuKRmye+fNcF7aBzrsL2zvNcS8XG0ghL1kq4nGyPU2PGew1a3s3mQtlMeF+Mj
 biVZg0fF0OwMSJKcTBC5TrtJeQ3v3SSsPwSvAmAp7AcZzagYqmP9q2R5/xXjgGrp4YhY
 82Z7CiwGVtVFe9Luv6S7ZXMeqn442MDvcm4vKwmwWxsiM5jp7B+ZQIWX0/JmLo5S6dL8
 7ebk6w+qANLOe5ldnd6W2GzACqCzjm/mfkA8lgfaYY3VzgGWBGlONr6bNMK2qPhd4tFb
 dOve6xqN+wDP03ZPd/3p/oT8iDEFffcCrGpRNKe+bOS6SXtLRB4HBok+l+VMR+wXJ7Au
 j4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s2Ewaz6asd7+7glK5X4/YBm3DhRWS13vOYaciNuoT2U=;
 b=ZgbpixG4CWSVNADYQhoF5E3Fahn6/j10mlcAcX/wuWS6EfYytGeuHk6hpK/08/KS9a
 pxFy3HhzL7iJid1/jNYtzgk/f2M+5kH7gTBv/n9O+aFqAxTyLQWfMDGOFaJofnDunbtO
 2TfL+ERfkTE4BGSRNq8wkZ2VTTwMDZRDY6w1gPhYW7aJGwPAXBevcxLdeUfao1APAHuI
 +usQEre82n09V3TpZ+F66o+4icwwC65doXl/yRrsR0g4jlUN+ndQcKgGR3o4OL51vfS3
 zp1ZlDhTUOS8ZxxYDmL972yEl+RhRlOcdS6BYdRuZDu+1SSSADBs6wxuIpNVAGMDMGtM
 Yxmw==
X-Gm-Message-State: AGi0PuZuJK4ghIckMzAmUquGbt4TWjd0lChrSIosnhtqJSlzZr7kHLqx
 5RHsokS0p4PIH8RRBbtPunuXvIS7vN5kMQOk754=
X-Google-Smtp-Source: APiQypLRyMUUM68FtTauVW0pvxzEkVQaXFQL4Cjhcq2WN6xRvwo+y+FjctvoAIACrDSLTp/TvgLloMAmifXy0NgYs4Y=
X-Received: by 2002:a92:5f46:: with SMTP id t67mr4386641ilb.64.1587664199000; 
 Thu, 23 Apr 2020 10:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
 <20200422182120.12258.67417.stgit@localhost.localdomain>
 <2d335814-c7eb-970b-5973-13dcdc7e0f12@redhat.com>
 <CAKgT0UeiKxy8AjrfoKRA9tV-8+nRMfEKjp1qCVcRoLhGs-oLew@mail.gmail.com>
 <46fb7362-0ec7-d27d-a8bc-458e9ae0beea@redhat.com>
In-Reply-To: <46fb7362-0ec7-d27d-a8bc-458e9ae0beea@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 23 Apr 2020 10:49:47 -0700
Message-ID: <CAKgT0Ucczmk2nG-yP8_Dfh1vFc5W242Q3=cMOQrG8aHG_6KFfw@mail.gmail.com>
Subject: Re: [PATCH v21 QEMU 4/5] virtio-balloon: Implement support for page
 poison tracking feature
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alexander.duyck@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::142
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 9:02 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 23.04.20 16:46, Alexander Duyck wrote:
> > On Thu, Apr 23, 2020 at 1:11 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 22.04.20 20:21, Alexander Duyck wrote:
> >>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>
> >>> We need to make certain to advertise support for page poison tracking if
> >>> we want to actually get data on if the guest will be poisoning pages.
> >>>
> >>> Add a value for tracking the poison value being used if page poisoning is
> >>> enabled. With this we can determine if we will need to skip page reporting
> >>> when it is enabled in the future.
> >>
> >> Maybe add something about the semantics
> >>
> >> "VIRTIO_BALLOON_F_PAGE_POISON will not change the behavior of free page
> >> hinting or ordinary balloon inflation/deflation."
> >>
> >> I do wonder if we should just unconditionally enable
> >> VIRTIO_BALLOON_F_PAGE_POISON here, gluing it to the QEMU compat machine
> >> (via a property that is default-enabled, and disabled from compat machines).
> >>
> >> Because, as Michael said, knowing that the guest is using page poisoning
> >> might be interesting even if free page reporting is not around.
> >
> > I could do that. So if that is the case though would I disable page
> > reporting if it isn't enabled, or would I be enabling page poison if
> > page reporting is enabled?
>
>
> So, I would suggest this the following as a diff to this patch (the TODO part as a
> separate patch - we will have these compat properties briefly after the 5.0
> release)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c1a444cb75..2e96cba4ff 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -28,6 +28,12 @@
>  #include "hw/mem/nvdimm.h"
>  #include "migration/vmstate.h"
>
> +// TODO: After 5.0 release
> +GlobalProperty hw_compat_5_0[] = {
> +    { "virtio-balloon-device", "page-hint", "false"},
> +};
> +const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
> +
>  GlobalProperty hw_compat_4_2[] = {
>      { "virtio-blk-device", "queue-size", "128"},
>      { "virtio-scsi-device", "virtqueue_size", "128"},

Okay, so the bit above is for after 5_0 is released then? Is there a
way to queue up a reminder or something so we get to it when the time
comes, or I just need to watch for 5.0 to come out and submit a patch
then?

> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a4729f7fc9..5ff8a669cf 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -924,6 +924,8 @@ static Property virtio_balloon_properties[] = {
>                       qemu_4_0_config_size, false),
>      DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHREAD,
>                       IOThread *),
> +    DEFINE_PROP_BIT("page-poison", VirtIOBalloon, host_features,
> +                    VIRTIO_BALLOON_F_PAGE_POISON, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
>
> What to do with page reporting depends: I would not implicitly enable features.
> I think we are talking about
>
> -device virtio-balloon-pci,...,page-poison=false,free-page-reporting=true
>
> a) Valid scenario. Fix Linux guests as we discussed to not use reporting if they rely on page poisoning.

Okay I will probably go this route and resubmit the patch I had
submitted before that only allows us to do page reporting if poisoning
is disabled on the guest kernel, or the page-poison is enabled on the
hypervisor.

> b) Invalid scenario. E.g., bail out when trying to realize that device ("'free-page-reporting' requires 'page-poison'").
>
> With new QEMU machines, this should not happen with
>
> -device virtio-balloon-pci,...,free-page-reporting=true
>
> as page-poison=true is the new default.
>
> What's your opinion?

I will just clean up and resubmit my earlier kernel patch, this time
without it messing with free page hinting.

> >
> >>>
> >>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>> ---
> >>>  hw/virtio/virtio-balloon.c         |    7 +++++++
> >>>  include/hw/virtio/virtio-balloon.h |    1 +
> >>>  2 files changed, 8 insertions(+)
> >>>
> >>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> >>> index a1d6fb52c876..5effc8b4653b 100644
> >>> --- a/hw/virtio/virtio-balloon.c
> >>> +++ b/hw/virtio/virtio-balloon.c
> >>> @@ -634,6 +634,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
> >>>
> >>>      config.num_pages = cpu_to_le32(dev->num_pages);
> >>>      config.actual = cpu_to_le32(dev->actual);
> >>> +    config.poison_val = cpu_to_le32(dev->poison_val);
> >>>
> >>>      if (dev->free_page_hint_status == FREE_PAGE_HINT_S_REQUESTED) {
> >>>          config.free_page_hint_cmd_id =
> >>> @@ -697,6 +698,10 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
> >>>          qapi_event_send_balloon_change(vm_ram_size -
> >>>                          ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
> >>>      }
> >>> +    dev->poison_val = 0;
> >>> +    if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
> >>> +        dev->poison_val = le32_to_cpu(config.poison_val);
> >>> +    }
> >>>      trace_virtio_balloon_set_config(dev->actual, oldactual);
> >>>  }
> >>>
> >>> @@ -854,6 +859,8 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
> >>>          g_free(s->stats_vq_elem);
> >>>          s->stats_vq_elem = NULL;
> >>>      }
> >>> +
> >>> +    s->poison_val = 0;
> >>>  }
> >>>
> >>>  static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
> >>> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> >>> index 108cff97e71a..3ca2a78e1aca 100644
> >>> --- a/include/hw/virtio/virtio-balloon.h
> >>> +++ b/include/hw/virtio/virtio-balloon.h
> >>> @@ -70,6 +70,7 @@ typedef struct VirtIOBalloon {
> >>>      uint32_t host_features;
> >>>
> >>>      bool qemu_4_0_config_size;
> >>> +    uint32_t poison_val;
> >>>  } VirtIOBalloon;
> >>>
> >>>  #endif
> >>>
> >>
> >> You still have to migrate poison_val if I am not wrong, otherwise you
> >> would lose it during migration if I am not mistaking.
> >
> > So what are the requirements to migrate a value? Would I need to add a
> > property so it can be retrieved/set?
> >
>
> Something like this would do the trick:
>
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a4729f7fc9..ea0afec5f6 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -522,6 +522,13 @@ static bool virtio_balloon_free_page_support(void *opaque)
>      return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
>  }
>
> +static bool virtio_balloon_page_poison_support(void *opaque)
> +{
> +    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
> +
> +    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
> +}
> +
>  static void virtio_balloon_free_page_start(VirtIOBalloon *s)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(s);
> @@ -755,6 +762,17 @@ static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
>      }
>  };
>
> +static const VMStateDescription vmstate_virtio_balloon_page_poison = {
> +    .name = "vitio-balloon-device/page-poison",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = virtio_balloon_page_poison_support,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(poison_val, VirtIOBalloon),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_virtio_balloon_device = {
>      .name = "virtio-balloon-device",
>      .version_id = 1,
> @@ -767,6 +785,7 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
>      },
>      .subsections = (const VMStateDescription * []) {
>          &vmstate_virtio_balloon_free_page_report,
> +        &vmstate_virtio_balloon_page_poison,
>          NULL
>      }
>  };

So I will probably go this route. It looks like that is the way we
went for free page reporting so it is easy enough to just do some
cut/paste/replace and have something ready to go later today without
having to second guess things.

