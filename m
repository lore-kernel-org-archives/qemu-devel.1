Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4533FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE062078D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+SbTik3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE062078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97OU-0000gN-Bj
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k97Nj-00080J-AM
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:46:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50868
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k97Nh-0001dP-D9
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598017616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jeIFbeS4stKPzf6waSQddDcGxvZuRyxK7Xr5Z1+0Ovo=;
 b=R+SbTik3Kp1WDK8C3GxUKuBvzq1jv0Dn1faIDNI0RHb4Tkjke4uKshztoB/dm4kY4e+yh1
 0LqlhbRJ97+mWIkMK1MFc94xCYuu0M7vgjqOZb0X2yTXvIbJogZKsdI0h5oeibF9IoBrTE
 V8wBr/VfhKbXkHWsnZLDv60WAP5jVIc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-5cGAREAKMNCZ_i5DsdmXoQ-1; Fri, 21 Aug 2020 09:46:55 -0400
X-MC-Unique: 5cGAREAKMNCZ_i5DsdmXoQ-1
Received: by mail-wr1-f69.google.com with SMTP id g3so434588wrx.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 06:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=jeIFbeS4stKPzf6waSQddDcGxvZuRyxK7Xr5Z1+0Ovo=;
 b=TuLrLb6gfNQK050tJBU8C6zcQQNilw8D34sHK2jnGVqsawKRkvlETjHBZ9bn9xA9Sy
 pcq0SB3B2asdphqUsE641Y003AjbsBQpMpEa4iBj+OV6qADabIBwXVSTqtqMnRHkJ9jh
 39L9EXsqdVAQvzVbtVjkx037E+/Nrh4Q5UQ8bbub4CBvuFF46yIqKzR6fOWf6m6bxBEU
 S4kYOYbL1K/arDdKUdEH+cSuwEyuyJMCjt9mBwmJmwr8sbtfy4ydsl46O9hxzT/QBC6J
 fUyoQzk+JD2Lp0ICNXkJa09F5cZqYHS0GGpqaU1REA7h+bfsGDEAbF+r2Ru5HZszs8Av
 W8UQ==
X-Gm-Message-State: AOAM532cFkSEn/9v4M3g20VOU4qsKv8e+KcUgdunx8+KiGshiB8C1A1v
 S0inwmwh17kNITuuWwFJKCnScVVFgITkRkCN47YPr7jS4aH6vvc7zUrgf23Eyj75G085NIBjBPr
 vM8RJVbtKjBZ//7I=
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr2820823wru.19.1598017612823; 
 Fri, 21 Aug 2020 06:46:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybytaRAiFPOt7w9iwElZzj9WkDb3P9+mw0wLF9gR/9fFTNft3SRJw6/VvFeFkpAp6sraIN9w==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr2820801wru.19.1598017612537; 
 Fri, 21 Aug 2020 06:46:52 -0700 (PDT)
Received: from steredhat (host-79-33-191-244.retail.telecomitalia.it.
 [79.33.191.244])
 by smtp.gmail.com with ESMTPSA id l9sm3648066wrn.23.2020.08.21.06.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 06:46:51 -0700 (PDT)
Date: Fri, 21 Aug 2020 15:46:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v5 15/15] block/nvme: Use an array of EventNotifier
Message-ID: <20200821134649.afxc4whjvnixljme@steredhat>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-16-philmd@redhat.com>
 <20200821102937.bartqudtcfesdmzr@steredhat>
 <fd1386d6-7663-04a0-f641-c44a48f821d4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fd1386d6-7663-04a0-f641-c44a48f821d4@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 03:09:13PM +0200, Philippe Mathieu-Daudé wrote:
> On 8/21/20 12:29 PM, Stefano Garzarella wrote:
> > On Thu, Aug 20, 2020 at 06:59:01PM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
> >> In preparation of using multiple IRQ (thus multiple eventfds)
> >> make BDRVNVMeState::irq_notifier an array (for now of a single
> >> element, the admin queue notifier).
> >>
> >> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> Signed-off-by: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
> >> ---
> >>  block/nvme.c | 31 +++++++++++++++++++++----------
> >>  1 file changed, 21 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/block/nvme.c b/block/nvme.c
> >> index a61e86a83eb..fe8a40b7ede 100644
> >> --- a/block/nvme.c
> >> +++ b/block/nvme.c
> >> @@ -106,6 +106,12 @@ QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) != 0x1000);
> >>  #define INDEX_ADMIN     0
> >>  #define INDEX_IO(n)     (1 + n)
> >>  
> >> +/* This driver shares a single MSIX IRQ for the admin and I/O queues */
> >> +enum {
> >> +    MSIX_SHARED_IRQ_IDX = 0,
> >> +    MSIX_IRQ_COUNT = 1
> >> +};
> >> +
> >>  struct BDRVNVMeState {
> >>      AioContext *aio_context;
> >>      QEMUVFIOState *vfio;
> >> @@ -120,7 +126,7 @@ struct BDRVNVMeState {
> >>      /* How many uint32_t elements does each doorbell entry take. */
> >>      size_t doorbell_scale;
> >>      bool write_cache_supported;
> >> -    EventNotifier irq_notifier;
> >> +    EventNotifier irq_notifier[MSIX_IRQ_COUNT];
> >>  
> >>      uint64_t nsze; /* Namespace size reported by identify command */
> >>      int nsid;      /* The namespace id to read/write data. */
> >> @@ -631,7 +637,8 @@ static bool nvme_poll_queues(BDRVNVMeState *s)
> >>  
> >>  static void nvme_handle_event(EventNotifier *n)
> >>  {
> >> -    BDRVNVMeState *s = container_of(n, BDRVNVMeState, irq_notifier);
> >> +    BDRVNVMeState *s = container_of(n, BDRVNVMeState,
> >> +                                    irq_notifier[MSIX_SHARED_IRQ_IDX]);
> >>  
> >>      trace_nvme_handle_event(s);
> >>      event_notifier_test_and_clear(n);
> >> @@ -683,7 +690,8 @@ out_error:
> >>  static bool nvme_poll_cb(void *opaque)
> >>  {
> >>      EventNotifier *e = opaque;
> >> -    BDRVNVMeState *s = container_of(e, BDRVNVMeState, irq_notifier);
> >> +    BDRVNVMeState *s = container_of(e, BDRVNVMeState,
> >> +                                    irq_notifier[MSIX_SHARED_IRQ_IDX]);
> >>  
> >>      trace_nvme_poll_cb(s);
> >>      return nvme_poll_queues(s);
> >> @@ -705,7 +713,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
> >>      s->device = g_strdup(device);
> >>      s->nsid = namespace;
> >>      s->aio_context = bdrv_get_aio_context(bs);
> >> -    ret = event_notifier_init(&s->irq_notifier, 0);
> >> +    ret = event_notifier_init(&s->irq_notifier[MSIX_SHARED_IRQ_IDX], 0);
> >>      if (ret) {
> >>          error_setg(errp, "Failed to init event notifier");
> >>          return ret;
> >> @@ -784,12 +792,13 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
> >>          }
> >>      }
> >>  
> >> -    ret = qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier,
> >> +    ret = qemu_vfio_pci_init_irq(s->vfio, s->irq_notifier,
> > 
> > Maybe we can use '&s->irq_notifier[MSIX_SHARED_IRQ_IDX]' to match the other
> > changes.
> 
> This makes the following patch in the next series (using multiple
> queues) simpler, but if you prefer I don't mind using your suggestion
> here, then adding another patch to directly use the array address
> (instead of the address of the 1st element in that array). As you
> wish :)

If it simplifies the next patches, it's fine for me ;-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 
> > 
> >>                                   VFIO_PCI_MSIX_IRQ_INDEX, errp);
> >>      if (ret) {
> >>          goto out;
> >>      }
> >> -    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
> >> +    aio_set_event_notifier(bdrv_get_aio_context(bs),
> >> +                           &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
> >>                             false, nvme_handle_event, nvme_poll_cb);
> >>  
> >>      nvme_identify(bs, namespace, &local_err);
> >> @@ -872,9 +881,10 @@ static void nvme_close(BlockDriverState *bs)
> >>          nvme_free_queue_pair(s->queues[i]);
> >>      }
> >>      g_free(s->queues);
> >> -    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
> >> +    aio_set_event_notifier(bdrv_get_aio_context(bs),
> >> +                           &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
> >>                             false, NULL, NULL);
> >> -    event_notifier_cleanup(&s->irq_notifier);
> >> +    event_notifier_cleanup(&s->irq_notifier[MSIX_SHARED_IRQ_IDX]);
> >>      qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
> >>      qemu_vfio_close(s->vfio);
> >>  
> >> @@ -1381,7 +1391,8 @@ static void nvme_detach_aio_context(BlockDriverState *bs)
> >>          q->completion_bh = NULL;
> >>      }
> >>  
> >> -    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
> >> +    aio_set_event_notifier(bdrv_get_aio_context(bs),
> >> +                           &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
> >>                             false, NULL, NULL);
> >>  }
> >>  
> >> @@ -1391,7 +1402,7 @@ static void nvme_attach_aio_context(BlockDriverState *bs,
> >>      BDRVNVMeState *s = bs->opaque;
> >>  
> >>      s->aio_context = new_context;
> >> -    aio_set_event_notifier(new_context, &s->irq_notifier,
> >> +    aio_set_event_notifier(new_context, &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
> >>                             false, nvme_handle_event, nvme_poll_cb);
> >>  
> >>      for (int i = 0; i < s->nr_queues; i++) {
> >> -- 
> >> 2.26.2
> >>
> >>
> > 
> 


