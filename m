Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7277C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:35:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732E620769
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DA0PBymC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732E620769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMb5A-0000Lj-Jz
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jMb4Q-0008LG-Uo
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jMb4P-0000cN-Mk
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:34:30 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:33159)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jMb4P-0000bk-GB
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:34:29 -0400
Received: by mail-io1-xd44.google.com with SMTP id o127so434281iof.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hxXLScf4ZxxDDpPsIkUVUGtYfs4PtuvwlW9XD3T4Yrc=;
 b=DA0PBymCQjy8cf6lvM9xgCDkS4bSwZFhOPXqi4m+HFc1MUhMTuOeLBI/TABmFftxZ0
 mpj9aPvL5OVIWJgrgbBQW/Yz2FqiWvMyM4U/Vd0qUAyTrsiWz9pxtxfuOAgkiObsPNgP
 4xUSnkGE+77eIMBiNhmjthLFM5pMhwQYIPW4VfzjLbZy5Nl4qiWTK2P3EVjb6VDY+/nb
 I36dgJncMtz/WXxijIb0QT08j7YdjCDLs2eCCYQf2MlpCEoDrac8TYLx/LmWPuIezc8+
 2u1tNL3THFfRY7Pc+irE6An0r1SZnMij2DGrE9hZnrEqt1N3CEefhNCCqnbbeyiqy/pn
 z9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hxXLScf4ZxxDDpPsIkUVUGtYfs4PtuvwlW9XD3T4Yrc=;
 b=g/RP7nw21ZG3HDmsJRtQ4If7kHpMIIQDscFdi52KCORpEqW7F2fKqgjqU0+WcpUK/6
 g85Wk9QESgdClXOnSzwmdtGdszPK+fkY3T7oYh5Dh006sWt10HZ4Or7qvEqj5mIMfDMa
 Ykgs8ammVjjDOEFkoF/RYS5+KjAW4Q3SyUl0Z+3I9xXJtstPhNiWsMuPGvqjotuOC+Yk
 Brl9QBeGgv+UrMlwPwgl8BNuJI8mCZaB+juZ6nES0IdUJ2jXzFhbNmIgXpDWRyz0p5Y4
 OyJYKrHxuHiOKZviSLBpyjwtP0JnrIX5EFlwjUr3G37uquegDDNKvrcDOYDdyGIZEr4y
 7BAA==
X-Gm-Message-State: AGi0PuaBtasbxD2UDKNWgcnfm8KhhZ172lZTThXU5vnEJXRFQdGXEpmf
 NQYNeYoaqpm2QdZzFVzeAtSbC+irM48LEL+F+CY=
X-Google-Smtp-Source: APiQypKGlZT5V0M70aL5+RYsYKqOx8UeQeez1bnjQC1divMSUNkvQafMUZAnot8kYUJ2e10i98CkgF4eyi20T1Qiwgs=
X-Received: by 2002:a02:cce2:: with SMTP id l2mr516484jaq.83.1586453668120;
 Thu, 09 Apr 2020 10:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200408225302.18764.209.stgit@localhost.localdomain>
 <20200408225529.18764.44086.stgit@localhost.localdomain>
 <06ac44b9-77ae-7686-8a65-7edff2cbf1b7@redhat.com>
In-Reply-To: <06ac44b9-77ae-7686-8a65-7edff2cbf1b7@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 9 Apr 2020 10:34:17 -0700
Message-ID: <CAKgT0UdLRKyc47izJO-rukHmj4cWP1xOzrxBv1ZX4yF92nH8Kg@mail.gmail.com>
Subject: Re: [PATCH v18 QEMU 3/3] virtio-balloon: Provide a interface for free
 page reporting
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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

On Thu, Apr 9, 2020 at 12:44 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 09.04.20 00:55, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Add support for what I am referring to as "free page reporting".
>
> "Add support for "free page reporting".
>
> > Basically the idea is to function very similar to how the balloon works
> > in that we basically end up madvising the page as not being used. However
>
> I'd get rid of one "basically".
>
> > we don't really need to bother with any deflate type logic since the page
> > will be faulted back into the guest when it is read or written to.
> >
> > This is meant to be a simplification of the existing balloon interface
> > to use for providing hints to what memory needs to be freed. I am assuming
>
> It's not really a simplification, it's something new. It's a new way of
> letting the guest automatically report free pages to the hypervisor, so
> the hypervisor can reuse them. In contrast to inflate/deflate, that's
> triggered via the hypervisor explicitly.
>
> > this is safe to do as the deflate logic does not actually appear to do very
> > much other than tracking what subpages have been released and which ones
> > haven't.
>
> "I assume this is safe" does not sound very confident. Can we just drop
> the last sentence?

Agreed. I will make the requested changes to the patch description.

>
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  hw/virtio/virtio-balloon.c         |   48 +++++++++++++++++++++++++++++++++++-
> >  include/hw/virtio/virtio-balloon.h |    2 +-
> >  2 files changed, 47 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index 1c6d36a29a04..297b267198ac 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -321,6 +321,42 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
> >      balloon_stats_change_timer(s, 0);
> >  }
> >
> > +static void virtio_balloon_handle_report(VirtIODevice *vdev, VirtQueue *vq)
> > +{
> > +    VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
> > +    VirtQueueElement *elem;
> > +
> > +    while ((elem = virtqueue_pop(vq, sizeof(VirtQueueElement)))) {
> > +        unsigned int i;
> > +
> > +        for (i = 0; i < elem->in_num; i++) {
> > +            void *addr = elem->in_sg[i].iov_base;
> > +            size_t size = elem->in_sg[i].iov_len;
> > +            ram_addr_t ram_offset;
> > +            size_t rb_page_size;
> > +            RAMBlock *rb;
> > +
> > +            if (qemu_balloon_is_inhibited() || dev->poison_val) {
> > +                continue;
> > +            }
>
> These checks are not sufficient. See virtio_balloon_handle_output(),
> where we e.g., check that somebody doesn't try to discard the bios.
>
> Maybe we can factor our/unify the handling in both code paths.

I am going to have to look at this further. If I understand correctly
you are asking me to add all of the memory section checks that are in
virtio_balloon_handle_output correct?

I'm not sure it makes sense with the scatterlist approach I have taken
here. All of the mappings were created as a scatterlist of writable
DMA mappings unlike the regular balloon which is just stuffing PFN
numbers into an array and then sending the array across. As such I
would think there are already such protections in place. For instance,
you wouldn't want to let virtio-net map the BIOS and request data be
written into that either, correct? So I am assuming there is something
there to prevent that already isn't there?

> > +
> > +            rb = qemu_ram_block_from_host(addr, false, &ram_offset);
> > +            rb_page_size = qemu_ram_pagesize(rb);
> > +
> > +            /* For now we will simply ignore unaligned memory regions */
> > +            if ((ram_offset | size) & (rb_page_size - 1)) {
>
> "!QEMU_IS_ALIGNED()" please to make this easier to read.

done.

> > +                continue;
> > +            }
> > +
> > +            ram_block_discard_range(rb, ram_offset, size);
> > +        }
> > +
> > +        virtqueue_push(vq, elem, 0);
> > +        virtio_notify(vdev, vq);
> > +        g_free(elem);
> > +    }
> > +}
> > +
>
> [...]
>
> >      if (virtio_has_feature(s->host_features,
> >                             VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> >          s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
> > @@ -940,6 +982,8 @@ static Property virtio_balloon_properties[] = {
> >       */
> >      DEFINE_PROP_BOOL("qemu-4-0-config-size", VirtIOBalloon,
> >                       qemu_4_0_config_size, false),
> > +    DEFINE_PROP_BIT("unused-page-reporting", VirtIOBalloon, host_features,
>
> "free-page-reporting"

Thanks for catching that. It has been a while since that was renamed
and I must have let it slip through the cracks.

- Alex

