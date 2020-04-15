Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F9BC2BB85
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 19:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348D820732
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 19:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM/0K7ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348D820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOnjP-0007qG-7M
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 15:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jOnib-00079L-Mg
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 15:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jOnia-0007nA-1M
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 15:29:05 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:37757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jOniZ-0007ms-IE
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 15:29:03 -0400
Received: by mail-il1-x144.google.com with SMTP id e4so4534611ils.4
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kC5AHjmdYSf9XaeLQ0aw6mUKzZ6gI6jpxTemXY0dmPA=;
 b=hM/0K7ka1JpOFS3kqHjgsV2ifjj+NxLYY9AD4tegYk6WzLsZLatAoVcbXGS6VfTSO5
 Fzraa5PN3cUX76VpMl0jRx1vPxdMUO+45vGBsOHGebP3Jz4C9c9U5lED1ZpzKua/tjye
 wuDLekGbkckFVANYagNytLMKYz4ICIfT0RRSOYeYL9rReP+THWq/+REZ6bnBwqJmRXjJ
 /dtzN05GGlBWNbrnmi/ZjgE4nTmLA7NpxEQiRn5gNXwk7P2x7rwilumU2LkNhR6vZ9n2
 k4zq2V8vC0z2aazmQDagv8lLBY6Mi0MnV/vxmwl2VQM9JmUBAtOSCWlXIz7NeFTzCl+f
 SbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kC5AHjmdYSf9XaeLQ0aw6mUKzZ6gI6jpxTemXY0dmPA=;
 b=EndJAd7BKOS5Ct+7DXttknCHggT9/VHVk78/5bAtLcltlXJHB08MXsjAORS/TvacRH
 l452n587RSBEaHbOOx9c9Hdh5FqDhwFTKKQI/sTBHYNTABWicniAhTyX0tB0H1ewishz
 Gz05tqV6uZppQIH4kTciuctbrv2COcuvnFkrFUPWY3VoAvQZ0JY6hnnX4sPVd2nLaiyC
 f3nDJxwzDWCfhrt8MtapIFLpvPlurRHkf4KVy7tRnxcbE7ul8JRbJHn2vOZLJfWBcf1F
 ofJe8NXUzp3OJMd/qJtjSXE1gc7Bm+qcOflwa1NA4AEm2MdGu3qlMSCLt28CqqRA8sPh
 y47A==
X-Gm-Message-State: AGi0PuY2pc7L+l2DsiLFgIlzct7YmJgvXi6uz7+ab1o6hnUykcpPHG+9
 efwzpnz+zrNSmxjxPKeXmqTXczx6RZAeG6m1jzFTUkIW
X-Google-Smtp-Source: APiQypIaq3szamCKisyLYpmxFRFPFwNc2jeWSIFaqaqsOcCt6byO0jFG80PfTyRI+UbdOcvYUYL8rPKStst/zNvq3aE=
X-Received: by 2002:a05:6e02:c25:: with SMTP id
 q5mr6438090ilg.97.1586978942532; 
 Wed, 15 Apr 2020 12:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200410033729.24738.22879.stgit@localhost.localdomain>
 <20200410034129.24738.36022.stgit@localhost.localdomain>
 <b6f97131-89dc-064a-5b87-2bf68437176d@redhat.com>
 <CAKgT0UcgbhKASE3RahdVZR35HHcnMVFGvh=q3qewgL7Yxin27w@mail.gmail.com>
 <515a7bd8-8840-6534-e76d-6bc2d4edbb72@redhat.com>
In-Reply-To: <515a7bd8-8840-6534-e76d-6bc2d4edbb72@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 15 Apr 2020 12:28:51 -0700
Message-ID: <CAKgT0UcaBfyKdTPErOxxLJgShOaJNfo9Maqps0ufABMbAo0iuQ@mail.gmail.com>
Subject: Re: [PATCH v19 QEMU 1/4] virtio-balloon: Implement support for page
 poison tracking feature
To: David Hildenbrand <david@redhat.com>, "Wang, Wei W" <wei.w.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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

On Wed, Apr 15, 2020 at 11:17 AM David Hildenbrand <david@redhat.com> wrote:
>
> >
> > The comment above explains the "why". Basically poisoning a page will
> > dirty it. So why hint a page as free when that will drop it back into
> > the guest and result in it being dirtied again. What you end up with
> > is all the pages that were temporarily placed in the balloon are dirty
> > after the hinting report is finished at which point you made things
> > worse instead of helping to improve them.
>
> Let me think this through. What happens on free page hinting is that
>
> a) we tell the guest that migration starts
> b) it allocates pages (alloc_pages()), sends them to us and adds them to
>    a list
> b) we exclude these pages on migration
> c) we tell the guest that migration is over
> d) the guest frees all allocated pages
>
> The "issue" with VIRTIO_BALLOON_F_PAGE_POISON is, that in d), the guest
> will fill all pages again with a pattern (or zero).

They should have already been filled with the poison pattern before we
got to d). A bigger worry is that we at some point in the future
update the kernel so that d) doesn't trigger re-poisoning, in which
case the pages won't be marked as dirty, we will have skipped the
migration, and we have no idea what will be in the pages at the end.

> AFAIKs, it's either
>
> 1) Not performing free page hinting, migrating pages filled with a
> poison value (or zero).
> 2) Performing free page hinting, not migrating pages filled with a
> poison value (or zero), letting only the guest fill them again.
>
> I have the feeling, that 2) is still better for migration, because we
> don't migrate useless pages and let the guest reconstruct the content?
> (having a poison value of zero might be debatable)
>
> Can you tell me what I am missing? :)

The goal of the free page hinting was to reduce the number of pages
that have to be migrated, in the second case you point out is is
basically deferring it and will make the post-copy quite more
expensive since all of the free memory will be pushed to the post-copy
which I would think would be undesirable since it means the VM would
have to be down for a greater amount of time with the poisoning
enabled.

The worst case scenario would be one in which the VM was suspended for
migration while there were still pages in the balloon that needed to
be drained. In such a case you would have them in an indeterminate
state since the last page poisoning for them might have been ignored
since they were marked as "free", so they are just going to be
whatever value they were if they had been migrated at all.

> >
> >>
> >>> +        return;
> >>> +    }
> >>> +
> >>>      if (s->free_page_report_cmd_id == UINT_MAX) {
> >>>          s->free_page_report_cmd_id =
> >>>                         VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
> >>
> >> We should rename all "free_page_report" stuff we can to
> >> "free_page_hint"/"free_page_hinting" to avoid confusion (e.g., on my
> >> side :) ) before adding free page reporting .
> >>
> >> (looking at the virtio-balloon linux header, it's also confusing but
> >> we're stuck with that - maybe we should add better comments)
> >
> > Are we stuck? Couldn't we just convert it to an anonymous union with
> > free_page_hint_cmd_id and then use that where needed?
>
> Saw your patch already :)
>
> >
> >>> @@ -618,12 +627,10 @@ static size_t virtio_balloon_config_size(VirtIOBalloon *s)
> >>>      if (s->qemu_4_0_config_size) {
> >>>          return sizeof(struct virtio_balloon_config);
> >>>      }
> >>> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
> >>> +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON) ||
> >>> +        virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> >>>          return sizeof(struct virtio_balloon_config);
> >>>      }
> >>> -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> >>> -        return offsetof(struct virtio_balloon_config, poison_val);
> >>> -    }
> >>
> >> I am not sure this change is completely sane. Why is that necessary at all?
> >
> > The poison_val is stored at the end of the structure and is required
> > in order to make free page hinting to work. What this change is doing
>
> Required to make it work? In the kernel,
>
> commit 2e991629bcf55a43681aec1ee096eeb03cf81709
> Author: Wei Wang <wei.w.wang@intel.com>
> Date:   Mon Aug 27 09:32:19 2018 +0800
>
>     virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON
>
> was merged after
>
> commit 86a559787e6f5cf662c081363f64a20cad654195
> Author: Wei Wang <wei.w.wang@intel.com>
> Date:   Mon Aug 27 09:32:17 2018 +0800
>
>     virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
>
> So I assume it's perfectly fine to not have it.
>
> I'd say it's the responsibility of the guest to *not* use
> VIRTIO_BALLOON_F_FREE_PAGE_HINT in case it is using page poisoning
> without VIRTIO_BALLOON_F_PAGE_POISON. Otherwise it will shoot itself
> into the foot.

Based on the timing I am guessing the page poisoning was in the same
patch set as the free page hinting since there is only 2 seconds
between when the two are merged. If I recall the page poisoning logic
was added after the issue was pointed out that it needed to address
it.

I can probably make some changes to virtballoon_validate in the kernel
driver to address the fact that if we are poisoning pages we need to
either have the PAGE_POISON feature or we need to disable page
reporting and page hinting.

> > is forcing it so that we report the config size as the full size if
> > either poisoning or hinting are enabled since the poison val is the
> > last member of the config structure.
> >
> > If the question is why bother reducing the size if free page hinting
> > is not present then I guess we could simplify this and just report
> > report the size of the config for all cases.
>
> I guess the idea is that if you migrate from one QEMU to another, your
> config size will not suddenly change (fenced by a feature set that will
> not change during migration, observable by a running guest).
>
> My guess would be that we cannot simply change existing configurations
> (defined via feature bits) as you do here - see e.g., qemu-4-0-config-size.

Okay, I guess I can revert that bit.

> [...]
>
> >>>
> >>> @@ -706,6 +717,9 @@ static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f,
> >>>      VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
> >>>      f |= dev->host_features;
> >>>      virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
> >>> +    if (virtio_has_feature(f, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> >>> +        virtio_add_feature(&f, VIRTIO_BALLOON_F_PAGE_POISON);
> >>> +    }
> >>>
> >>>      return f;
> >>>  }
> >>> @@ -854,6 +868,8 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
> >>>          g_free(s->stats_vq_elem);
> >>>          s->stats_vq_elem = NULL;
> >>>      }
> >>> +
> >>> +    s->poison_val = 0;
> >>>  }
> >>>
> >>>  static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
> >>> @@ -916,6 +932,8 @@ static Property virtio_balloon_properties[] = {
> >>>                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
> >>>      DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
> >>>                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> >>> +    DEFINE_PROP_BIT("x-page-poison", VirtIOBalloon, host_features,
> >>> +                    VIRTIO_BALLOON_F_PAGE_POISON, false),
> >>
> >> Just curious, why an x- feature?
> >
> > It was something I didn't expect the users to enable. It gets enabled
> > when either free page hinting or free page reporting is enabled. So if
> > you look you will see that in virtio_balloon_get_features the page
> > poison feature is added if free page hinting is present. The guest
> > will clear the feature bit if poisoning is not enabled in the guest.
> > That results in the vdev getting the bit cleared.
>
> The weird thing is that setting it to "false" will still enable it
> automatically, depending on other features. Not sure how helpful that is.
>
> I'd prefer to simply always enable it, similar to
> VIRTIO_BALLOON_F_STATS_VQ - but it's late and I am confused how
> migration with compat machines will work. :)
>
> So, I wonder if we need this feature bit here at all.

I can drop it. I don't really recall why I added that piece.

