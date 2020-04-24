Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F40CC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA2B206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZthNqHo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA2B206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS071-0000wY-54
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 11:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jS05x-00009H-9i
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jS05w-0003Qs-Hc
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:18:25 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:35361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jS05r-00038z-2e
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:18:24 -0400
Received: by mail-io1-xd43.google.com with SMTP id y26so826934ioj.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BHBjQGZTiYhMmM4o670GLq7t++5l+BRKez49SYqN0kk=;
 b=ZthNqHo2y3pFbS5mZ/MtkQ3p7kk8KgrBEpa5zbeio3I5FjlwGL8KUNV4zTLtPogdc1
 J/gWji9THsTeVwL9LGSW8z0PQ10e3dsvJwCb6HX7WgH+PAcUet6WFk4u2r51F0f2wiWe
 Bhg01aU36qEqHogO+ruYKecyg0jUDY5cErZQKP+Jn8YJN0UhOPH/XTmwr3VxDSby17L6
 R+n60nPR1Z1lmGMnlXO/Zottv/Wa6nsS21Z5MgAIVNh3s7ZXR/QtFXA21HECtAbQMjCT
 /kfk3w7MAQ0yG/tn4ilXZbMGHMSOQAzsJNdN5YUblB+Ial6ufKJrz/Lk+VVDhHNu5fhz
 BTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BHBjQGZTiYhMmM4o670GLq7t++5l+BRKez49SYqN0kk=;
 b=jpsBNBoj/qeCS6CLYoFHvG47i+aEyNB29aI/LJPKYGf0JsteYdOBB6rGRGB1oEIFnn
 VfTLZqKnNUEJQ5AcyQCJ3jF524HE4G9YSJdryo2a8/+THlr2Tq0uatEGJs+B6NWsFO0h
 lymD+Fn1Kzl6wGkUvWBzv/s2DvENr5wkfXbVWL4xVuqJ6QFLnclNrUzZEIXABXt66jbO
 V0bDnK6f8WFR/ftB6kecs7R4Pxz7fqEEU75n/qRVCS3caSS7VrSdQSvMbjQn3v7YSry1
 pbrM4iiLsZG4eotnaUJhBlliGsTGMtO2c8QTiKaqdrKVloDFjNG80f0E45RPb6VfPZY5
 A0mQ==
X-Gm-Message-State: AGi0PuZ/x7DsyBuYF4YxzCC0EdP50L6jM91vX40tGof3wR7jy0x4BQUJ
 9HJVUtgMPJBC0yHvhQBK1FKRip6I2UA6ASZ8coM=
X-Google-Smtp-Source: APiQypKdCnRWrpYrw1K6pVi7UDY3R3ggfbV7FVPasnucmtK1ohgHj4rSqwRxHbP3+3DTNZQmO32giZhC7MHLaERBgvY=
X-Received: by 2002:a02:5249:: with SMTP id d70mr8844524jab.121.1587741496493; 
 Fri, 24 Apr 2020 08:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
 <20200422182127.12258.26300.stgit@localhost.localdomain>
 <a2183a2f-e10d-1e19-52d9-a9cd71fa2655@redhat.com>
In-Reply-To: <a2183a2f-e10d-1e19-52d9-a9cd71fa2655@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 24 Apr 2020 08:18:05 -0700
Message-ID: <CAKgT0Ud1WVUV5VNCCBqJtYPSLCZTq5oXGUyvqHmXdnTQUko6qQ@mail.gmail.com>
Subject: Re: [PATCH v21 QEMU 5/5] virtio-balloon: Provide an interface for
 free page reporting
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alexander.duyck@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d43
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

On Fri, Apr 24, 2020 at 4:20 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 22.04.20 20:21, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Add support for free page reporting. The idea is to function very similar
> > to how the balloon works in that we basically end up madvising the page as
> > not being used. However we don't really need to bother with any deflate
> > type logic since the page will be faulted back into the guest when it is
> > read or written to.
> >
> > This provides a new way of letting the guest proactively report free
> > pages to the hypervisor, so the hypervisor can reuse them. In contrast to
> > inflate/deflate that is triggered via the hypervisor explicitly.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  hw/virtio/virtio-balloon.c         |   70 ++++++++++++++++++++++++++++++++++++
> >  include/hw/virtio/virtio-balloon.h |    2 +
> >  2 files changed, 71 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index 5effc8b4653b..b473ff7f4b88 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -321,6 +321,60 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
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
>
> Maybe add a comment like
>
> /*
>  * As discarded pages will be zero when re-accessed, all pages either
>  * have the old value, or were zeroed out. In case the guest expects
>  * another value, make sure to never discard.
>  */
>
> Whatever you think is best.

Okay I will add the following comment:
        /*
         * When we discard the page it has the effect of removing the page
         * from the hypervisor itself and causing it to be zeroed when it
         * is returned to us. So we must not discard the page if it is
         * accessible by another device or process, or if the guest is
         * expecting it to retain a non-zero value.
         */


> > +        if (qemu_balloon_is_inhibited() || dev->poison_val) {
> > +            goto skip_element;
> > +        }
> > +
> > +        for (i = 0; i < elem->in_num; i++) {
> > +            void *addr = elem->in_sg[i].iov_base;
> > +            size_t size = elem->in_sg[i].iov_len;
> > +            ram_addr_t ram_offset;
> > +            RAMBlock *rb;
> > +
> > +            /*
> > +             * There is no need to check the memory section to see if
> > +             * it is ram/readonly/romd like there is for handle_output
> > +             * below. If the region is not meant to be written to then
> > +             * address_space_map will have allocated a bounce buffer
> > +             * and it will be freed in address_space_unmap and trigger
> > +             * and unassigned_mem_write before failing to copy over the
> > +             * buffer. If more than one bad descriptor is provided it
> > +             * will return NULL after the first bounce buffer and fail
> > +             * to map any resources.
> > +             */
> > +            rb = qemu_ram_block_from_host(addr, false, &ram_offset);
> > +            if (!rb) {
> > +                trace_virtio_balloon_bad_addr(elem->in_addr[i]);
> > +                continue;
> > +            }
> > +
> > +            /*
> > +             * For now we will simply ignore unaligned memory regions, or
> > +             * regions that overrun the end of the RAMBlock.
> > +             */
> > +            if (!QEMU_IS_ALIGNED(ram_offset | size, qemu_ram_pagesize(rb)) ||
> > +                (ram_offset + size) > qemu_ram_get_used_length(rb)) {
> > +                continue;
> > +            }
> > +
> > +            ram_block_discard_range(rb, ram_offset, size);
> > +        }
> > +
> > +skip_element:
> > +        virtqueue_push(vq, elem, 0);
> > +        virtio_notify(vdev, vq);
> > +        g_free(elem);
> > +    }
> > +}
> > +
> >  static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> >  {
> >      VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
> > @@ -782,6 +836,16 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
> >      VirtIOBalloon *s = VIRTIO_BALLOON(dev);
> >      int ret;
> >
> > +    /*
> > +     * Page reporting is dependant on page poison to make sure we can
> > +     * report a page without changing the state of the internal data.
> > +     * We need to set the flag before we call virtio_init as it will
> > +     * affect the config size of the vdev.
> > +     */
> > +    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
> > +        s->host_features |= 1 << VIRTIO_BALLOON_F_PAGE_POISON;
> > +    }
> > +
>
> As discussed, this hunk would go away. With that, this patch is really
> minimal, which is good :)

I have already removed it. :-)

> >      virtio_init(vdev, "virtio-balloon", VIRTIO_ID_BALLOON,
> >                  virtio_balloon_config_size(s));
> >
> > @@ -798,6 +862,10 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
> >      s->dvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
> >      s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
> >
> > +    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
> > +        s->rvq = virtio_add_queue(vdev, 32, virtio_balloon_handle_report);
> > +    }
> > +
> >      if (virtio_has_feature(s->host_features,
> >                             VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> >          s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
> > @@ -923,6 +991,8 @@ static Property virtio_balloon_properties[] = {
> >                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
> >      DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
> >                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> > +    DEFINE_PROP_BIT("free-page-reporting", VirtIOBalloon, host_features,
> > +                    VIRTIO_BALLOON_F_REPORTING, true),
>
> I think you'll have to similarly disable it via compat machines if you
> want to default enable. Otherwise, backward migration would be broken.

Yes, I realized that after you mentioned it for poison yesterday.

> Also, I do wonder if we want to default-enable it. It can still have a
> negative performance impact and some people might not want that.

The negative performance impact should be minimal. At this point the
hinting process ends up being very light since it only processes a
small chunk of the memory before it shuts down for a couple seconds.
In my original data the only time any significant performance
regression was seen was with page shuffling enabled, and that was
before I put limits on how many pages we could process per pass and
how frequently we would make a pass through memory. My thought is that
we are much better having it enabled by default rather than having it
disabled by default. In the worst case scenario we have a little bit
of extra thread noise from it popping up running for a few
milliseconds and then sleeping for about two seconds, but the benefit
side is that the VMs will do us a favor and restrict themselves to a
much smaller idle footprint until such time as the memory is actually
needed in the guest.

> Apart from that, looks good to me. Nothing else we have to migrate AFAIKs.

Thanks for the review.

- Alex

