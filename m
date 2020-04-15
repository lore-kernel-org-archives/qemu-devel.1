Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E63C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1CB2076D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXyHksKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1CB2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOlg2-0001AC-1h
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 13:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jOlfF-0000iw-4X
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jOlfD-0001gO-JZ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:17:29 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:33375)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jOlfD-0001dy-Ce
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:17:27 -0400
Received: by mail-io1-xd41.google.com with SMTP id o127so17993845iof.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 10:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gSN0/qeENb5kKav2LlresTxjTBv1SDGkH/WoHklv6RI=;
 b=KXyHksKLWaRs47ks89Nl8bMxN/4uFSzuVPMnNmlaxgdPHC7XiSmHmKvuo4lGlZE8HI
 rF9s1Hr8G3nIamXtBSBYkVT0K8Zorrlm0J/4pKpOOFTbLFLWTVv3r7JD6ktRgGj4L4U9
 j1cXK2by8YIttZN7feUy44aeeBDXRNUeMW6/lh36sVKOFsvbciGtqqo+s/NnHHBBszZI
 WG3XlPPC+uQ9DSY75VgKByMw0C71MIRKG4/BKnoB0kcEa3f1k7gTo/DaZJJf8SlyCVYJ
 22w4RYPdLFy+1fUNi1q2YnKW6YYuK5SneoMZ+7V7fsDv07xIXyEPUlfsSuiLeTg5Y/TZ
 RtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gSN0/qeENb5kKav2LlresTxjTBv1SDGkH/WoHklv6RI=;
 b=lKFZqipkbTmxDIWcI1GUyc7ACLBqSr5K8z+dnFg5tYpr5bV6rIfR9ajLUfmijoYbtM
 9DmofhIGoHb6SyYH1+BJN3wqcE3OOtfByoQmPvD4imo5UyIDss9NUeWgEBTk/xNIJ8AH
 0Rqw/mDhyaI4salk1PN5E/9ymquHeQpwkL0sczjrAirRAAkfKfQPLB+ST25K3QYZZ4uL
 39XFZDUpKLeQMT4RF+TV28Q6aYCl0wEX+dWoO3aZRVztrkw5IQ1OKp0VxQRc634KGbnY
 HRT0XYeOd2j0fL/nG6TJF0ro3dZEKuGnRkaSTe4rNHPDMSYdLzNtKGBmbjaADIjQxCmq
 95BQ==
X-Gm-Message-State: AGi0PuaZPDX5mAIRaz8qO2dRRsuIa5X0q6SWqBWHN4JuZGgDGi8RL/LB
 YcVdVZcFZJytXhbQW8P0pFTv5Zg7OEAEyahdC8V5H8sb
X-Google-Smtp-Source: APiQypIogN+UMkNKxRSrUDxtcLM3GSJDlagNMbijQebEjESkWTsGN0FcxJKAsd3OO5pyJhSkAkHpFBgb6V58vCg2kGw=
X-Received: by 2002:a5e:870f:: with SMTP id y15mr23602872ioj.88.1586971046211; 
 Wed, 15 Apr 2020 10:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200410033729.24738.22879.stgit@localhost.localdomain>
 <20200410034129.24738.36022.stgit@localhost.localdomain>
 <b6f97131-89dc-064a-5b87-2bf68437176d@redhat.com>
In-Reply-To: <b6f97131-89dc-064a-5b87-2bf68437176d@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 15 Apr 2020 10:17:15 -0700
Message-ID: <CAKgT0UcgbhKASE3RahdVZR35HHcnMVFGvh=q3qewgL7Yxin27w@mail.gmail.com>
Subject: Re: [PATCH v19 QEMU 1/4] virtio-balloon: Implement support for page
 poison tracking feature
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 15, 2020 at 1:08 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 10.04.20 05:41, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > We need to make certain to advertise support for page poison tracking if
> > we want to actually get data on if the guest will be poisoning pages. So
> > if free page hinting is active we should add page poisoning support and
> > let the guest disable it if it isn't using it.
> >
> > Page poisoning will result in a page being dirtied on free. As such we
> > cannot really avoid having to copy the page at least one more time since
> > we will need to write the poison value to the destination. As such we can
> > just ignore free page hinting if page poisoning is enabled as it will
> > actually reduce the work we have to do.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  hw/virtio/virtio-balloon.c         |   26 ++++++++++++++++++++++----
> >  include/hw/virtio/virtio-balloon.h |    1 +
> >  2 files changed, 23 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index a4729f7fc930..1c6d36a29a04 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -531,6 +531,15 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
> >          return;
> >      }
> >
> > +    /*
> > +     * If page poisoning is enabled then we probably shouldn't bother with
> > +     * the hinting since the poisoning will dirty the page and invalidate
> > +     * the work we are doing anyway.
> > +     */
> > +    if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
>
> Why not check for the poison value instead? (as you do in patch #3) ?

So if I recall correctly the vdev has feature requires the host to
indicate that the feature is in use. If page poisoning is not enabled
on the host then it clears the flag on its end and we can proceed with
the feature.

The comment above explains the "why". Basically poisoning a page will
dirty it. So why hint a page as free when that will drop it back into
the guest and result in it being dirtied again. What you end up with
is all the pages that were temporarily placed in the balloon are dirty
after the hinting report is finished at which point you made things
worse instead of helping to improve them.

>
> > +        return;
> > +    }
> > +
> >      if (s->free_page_report_cmd_id == UINT_MAX) {
> >          s->free_page_report_cmd_id =
> >                         VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
>
> We should rename all "free_page_report" stuff we can to
> "free_page_hint"/"free_page_hinting" to avoid confusion (e.g., on my
> side :) ) before adding free page reporting .
>
> (looking at the virtio-balloon linux header, it's also confusing but
> we're stuck with that - maybe we should add better comments)

Are we stuck? Couldn't we just convert it to an anonymous union with
free_page_hint_cmd_id and then use that where needed?

> > @@ -618,12 +627,10 @@ static size_t virtio_balloon_config_size(VirtIOBalloon *s)
> >      if (s->qemu_4_0_config_size) {
> >          return sizeof(struct virtio_balloon_config);
> >      }
> > -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
> > +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON) ||
> > +        virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> >          return sizeof(struct virtio_balloon_config);
> >      }
> > -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> > -        return offsetof(struct virtio_balloon_config, poison_val);
> > -    }
>
> I am not sure this change is completely sane. Why is that necessary at all?

The poison_val is stored at the end of the structure and is required
in order to make free page hinting to work. What this change is doing
is forcing it so that we report the config size as the full size if
either poisoning or hinting are enabled since the poison val is the
last member of the config structure.

If the question is why bother reducing the size if free page hinting
is not present then I guess we could simplify this and just report
report the size of the config for all cases.

> >      return offsetof(struct virtio_balloon_config, free_page_report_cmd_id);
> >  }
> >
> > @@ -634,6 +641,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
> >
> >      config.num_pages = cpu_to_le32(dev->num_pages);
> >      config.actual = cpu_to_le32(dev->actual);
> > +    config.poison_val = cpu_to_le32(dev->poison_val);
> >
> >      if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED) {
> >          config.free_page_report_cmd_id =
> > @@ -697,6 +705,9 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
> >          qapi_event_send_balloon_change(vm_ram_size -
> >                          ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
> >      }
> > +    dev->poison_val = virtio_vdev_has_feature(vdev,
> > +                                              VIRTIO_BALLOON_F_PAGE_POISON) ?
> > +                      le32_to_cpu(config.poison_val) : 0;
>
> Can we just do a
>
>
> dev->poison_val = 0;
> if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
>         dev->poison_val = le32_to_cpu(config.poison_val);
> }
>
> instead?

I can change it to that if that is what is preferred.

> >      trace_virtio_balloon_set_config(dev->actual, oldactual);
> >  }
> >
> > @@ -706,6 +717,9 @@ static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f,
> >      VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
> >      f |= dev->host_features;
> >      virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
> > +    if (virtio_has_feature(f, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> > +        virtio_add_feature(&f, VIRTIO_BALLOON_F_PAGE_POISON);
> > +    }
> >
> >      return f;
> >  }
> > @@ -854,6 +868,8 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
> >          g_free(s->stats_vq_elem);
> >          s->stats_vq_elem = NULL;
> >      }
> > +
> > +    s->poison_val = 0;
> >  }
> >
> >  static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
> > @@ -916,6 +932,8 @@ static Property virtio_balloon_properties[] = {
> >                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
> >      DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
> >                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> > +    DEFINE_PROP_BIT("x-page-poison", VirtIOBalloon, host_features,
> > +                    VIRTIO_BALLOON_F_PAGE_POISON, false),
>
> Just curious, why an x- feature?

It was something I didn't expect the users to enable. It gets enabled
when either free page hinting or free page reporting is enabled. So if
you look you will see that in virtio_balloon_get_features the page
poison feature is added if free page hinting is present. The guest
will clear the feature bit if poisoning is not enabled in the guest.
That results in the vdev getting the bit cleared.

Part of it was also about making this work with the existing feature
code as it had been added to the upstream kernel.

