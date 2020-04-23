Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ADEC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE192074F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh4lP7uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE192074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRd8s-0006Rr-DI
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 10:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jRd7c-0005BA-Kk
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jRd7b-0007At-T1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:46:36 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:41807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jRd7b-00079U-Fd
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 10:46:35 -0400
Received: by mail-io1-xd41.google.com with SMTP id b12so6610715ion.8
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ACmT1dAhAFtsZJMvQrmV1lwJ68GDBiCklFT0+DhV3h4=;
 b=dh4lP7uyvCc7yoReP6stXBQDVdZJOo3D3pVmnymXIYApbgDHu3UZEL+NetSUOh78Eo
 DRQq4R3r2wzAYiHO0XMl2Rt/WbBFsarkiRzvJzt/Y1HoaZ2p+bvCQgk/37vPQ9n6GY/s
 12etBQhQ6rHf3/yWyagqlZeWqH3Nj0xMKL+LFjonhLV36o2/XrPUh3KYnIZHkELfaZP8
 kQcy2CEUD+m9FI4f/o/qQaXYow3Br/YJirqNblJ7G3ErWrFJYRPW6kHx+MXthwMPiJ7Q
 fuMZSgRh+rjzQgwXtZo+Vi2ml3PhUOkLSPZSQpVgIi4pOJ4Md4rt3OG/cIa5wnererKq
 CdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ACmT1dAhAFtsZJMvQrmV1lwJ68GDBiCklFT0+DhV3h4=;
 b=f7AQJidyfgpJzL6UIMzs6FC7PGNd1A2zWgpTlGZXRRixPWHJoX0YpPQ5kLv9sdo6Ma
 7/DDpPjO9jKiugf9jcJB1n66Umx3XdEqB5IpoE3yIQh9JthzvZBjZphfrrUBtoE9iD2Z
 HP3v5rVnybFWh+6SJ/r/mZdbDvd/nzOUeugHiZnRfY2E4uEb0SuAyNBciUuo49RhSeqA
 gxUQiD1Dzq6A00iTlfdnOYdvFCP7S9V3NIQe+6URZ7+cQaq1rXGmXuc3T6M79AINMDfv
 CPIHzbYlSIjpV+oMFFKxpsd+Nuuruolf9DSXOt50bK+D33PI3wxglHoAjt9qm8sd57Af
 tDFQ==
X-Gm-Message-State: AGi0PuaXEuhS7mLIzJlrtO/Qtu4DeSMPOQVXM+VuSm62d+zrM83jxizk
 8fNKuzUb42f9NN1tiDIkAdvFOgUsccaj+/1EbYpfRyUd
X-Google-Smtp-Source: APiQypJ/MiDXbeL+d+83PPMME22kxztD/Om0UUlOfybBWg9RbS0lAN4yBqz0bFrT5BJH6LycRSPBk1j/g7zhrkq0/Dw=
X-Received: by 2002:a02:c84e:: with SMTP id r14mr3516342jao.96.1587653194284; 
 Thu, 23 Apr 2020 07:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
 <20200422182120.12258.67417.stgit@localhost.localdomain>
 <2d335814-c7eb-970b-5973-13dcdc7e0f12@redhat.com>
In-Reply-To: <2d335814-c7eb-970b-5973-13dcdc7e0f12@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 23 Apr 2020 07:46:22 -0700
Message-ID: <CAKgT0UeiKxy8AjrfoKRA9tV-8+nRMfEKjp1qCVcRoLhGs-oLew@mail.gmail.com>
Subject: Re: [PATCH v21 QEMU 4/5] virtio-balloon: Implement support for page
 poison tracking feature
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alexander.duyck@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d41
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

On Thu, Apr 23, 2020 at 1:11 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 22.04.20 20:21, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > We need to make certain to advertise support for page poison tracking if
> > we want to actually get data on if the guest will be poisoning pages.
> >
> > Add a value for tracking the poison value being used if page poisoning is
> > enabled. With this we can determine if we will need to skip page reporting
> > when it is enabled in the future.
>
> Maybe add something about the semantics
>
> "VIRTIO_BALLOON_F_PAGE_POISON will not change the behavior of free page
> hinting or ordinary balloon inflation/deflation."
>
> I do wonder if we should just unconditionally enable
> VIRTIO_BALLOON_F_PAGE_POISON here, gluing it to the QEMU compat machine
> (via a property that is default-enabled, and disabled from compat machines).
>
> Because, as Michael said, knowing that the guest is using page poisoning
> might be interesting even if free page reporting is not around.

I could do that. So if that is the case though would I disable page
reporting if it isn't enabled, or would I be enabling page poison if
page reporting is enabled?

> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  hw/virtio/virtio-balloon.c         |    7 +++++++
> >  include/hw/virtio/virtio-balloon.h |    1 +
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index a1d6fb52c876..5effc8b4653b 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -634,6 +634,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
> >
> >      config.num_pages = cpu_to_le32(dev->num_pages);
> >      config.actual = cpu_to_le32(dev->actual);
> > +    config.poison_val = cpu_to_le32(dev->poison_val);
> >
> >      if (dev->free_page_hint_status == FREE_PAGE_HINT_S_REQUESTED) {
> >          config.free_page_hint_cmd_id =
> > @@ -697,6 +698,10 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
> >          qapi_event_send_balloon_change(vm_ram_size -
> >                          ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
> >      }
> > +    dev->poison_val = 0;
> > +    if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
> > +        dev->poison_val = le32_to_cpu(config.poison_val);
> > +    }
> >      trace_virtio_balloon_set_config(dev->actual, oldactual);
> >  }
> >
> > @@ -854,6 +859,8 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
> >          g_free(s->stats_vq_elem);
> >          s->stats_vq_elem = NULL;
> >      }
> > +
> > +    s->poison_val = 0;
> >  }
> >
> >  static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
> > diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> > index 108cff97e71a..3ca2a78e1aca 100644
> > --- a/include/hw/virtio/virtio-balloon.h
> > +++ b/include/hw/virtio/virtio-balloon.h
> > @@ -70,6 +70,7 @@ typedef struct VirtIOBalloon {
> >      uint32_t host_features;
> >
> >      bool qemu_4_0_config_size;
> > +    uint32_t poison_val;
> >  } VirtIOBalloon;
> >
> >  #endif
> >
>
> You still have to migrate poison_val if I am not wrong, otherwise you
> would lose it during migration if I am not mistaking.

So what are the requirements to migrate a value? Would I need to add a
property so it can be retrieved/set?

