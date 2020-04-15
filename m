Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DB8C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0123D20767
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPJjDBtT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0123D20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOk2X-0004kK-4t
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 11:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jOk1C-0004AJ-Kb
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jOk1B-0006CQ-EW
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:32:02 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:46153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jOk1B-0006Bq-A6
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:32:01 -0400
Received: by mail-il1-x144.google.com with SMTP id i75so3662823ild.13
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8jFqyVMuOl5dtDPLx8c0ylbN6fKtzArmLPib3LYOgBs=;
 b=NPJjDBtT1ybR+e37Sv6ZMvZgRFSGCBo65a6oIODlGkpZuRmzulscvTwG6f54Odpxzy
 Xfk2kijGERUlbpGTSYkdzvKMuBpXkmQ77X2FfXJX5VqNu23m0yNtqwXiBdNDRi0axIq4
 2Irahn55MR+gSN7pOGyoozmwYDangBhMPGEFz2Pz+a9jJB+a31pFn/ULTQEwznf8z+ij
 QIXnp0qIfMcTgnyYbZ9bd0XlJlzvQKycEitRyn/N+g69n3LS2Fqtopf3EDvf4UZNbnW3
 KcD3c/atfgFDuHvMrOk/9CJGTmhAUKrLH5/Uzs5dGopKBZCo3AWGqwypAx2EjEDOAzNh
 OhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8jFqyVMuOl5dtDPLx8c0ylbN6fKtzArmLPib3LYOgBs=;
 b=ewBXxQh10NmM4fiafPHU+YUQ6MJabhoCikBMSQE+EPEqhMjbDRD909Xh+P0M4mgtJD
 bMXRU548xKESH8N5MjcK+jVXxh6Xk0ILLcsLf77/YTpfl67ZWGpsJDMLyGRuM/jg0C64
 ahcn4a9jUacsZXEqAtNLwa0x3nnrWXd63b2kQghhXvQR0OheFftThwQL9klYkE5cxd9T
 zTsORL23xudJRfgETfBMptPRnIKVvN2IrZbgq0/fyYsUhJYtK3TIyGQ98ZzkWeVwQOyI
 W89xneQsuP7Lv/E85S6qYfU5+X22hMVh1ZJ3uELMJLgZLG+Ogqk2ZGnfI7vCzv1TWJMY
 2uYQ==
X-Gm-Message-State: AGi0PuYvNTXFr6r+RRjEQRa5NIynYDL16R2h5C8Z5xTriYslULvF2SfX
 HgV2tOp6VYgPC4YFrW+uAmTsBSs4V76gMRI1kw0=
X-Google-Smtp-Source: APiQypJXF7Q8rFVnxdGYbiL0mr2MCnA2JMkrKgeAbp6AWSYn5O6wl9NNWTJmjmu42v8CBA39s+0lQhnyMSyy6MZRyWc=
X-Received: by 2002:a05:6e02:672:: with SMTP id
 l18mr6230753ilt.237.1586964718810; 
 Wed, 15 Apr 2020 08:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200410033729.24738.22879.stgit@localhost.localdomain>
 <20200410034143.24738.78852.stgit@localhost.localdomain>
 <4f26ec52-5520-1bfb-a1e5-fe6492f7af60@redhat.com>
In-Reply-To: <4f26ec52-5520-1bfb-a1e5-fe6492f7af60@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 15 Apr 2020 08:31:47 -0700
Message-ID: <CAKgT0UeHwrj+RSb3o8ZPAnzA3+_M0eW4q36c-OU5ntL9W5i2jw@mail.gmail.com>
Subject: Re: [PATCH v19 QEMU 3/4] virtio-balloon: Provide an interface for
 free page reporting
To: David Hildenbrand <david@redhat.com>
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

On Wed, Apr 15, 2020 at 1:17 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 10.04.20 05:41, Alexander Duyck wrote:
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
>
> Much better, thanks!
>
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  hw/virtio/virtio-balloon.c         |   63 +++++++++++++++++++++++++++++++++++-
> >  include/hw/virtio/virtio-balloon.h |    2 +
> >  2 files changed, 62 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index 1c6d36a29a04..86d8b48a8e3a 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -321,6 +321,57 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
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
>
> actually, you want to do that in the outer loop, no?

I'll move that. Odds are compiler was doing that anyway.

> > +            }
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
> > +            /* For now we will simply ignore unaligned memory regions */
> > +            rb_page_size = qemu_ram_pagesize(rb);
> > +            if (!QEMU_IS_ALIGNED(ram_offset | size, rb_page_size)) {
>
> /me thinks you can drop rb_page_size

You mean just fold it into the statement? I guess I can do that.

> I *think* there is still one remaining case to handle: Crossing RAM blocks.
>
> Most probably you should check
>
> /* For now, ignore crossing RAM blocks. */
> if (ram_offset + size >= qemu_ram_get_used_length()) {
>         continue;
> }
>
> otherwise ram_block_discard_range() will report an error.

Makes sense. I can add that into the QEMU_IS_ALIGNED check.

