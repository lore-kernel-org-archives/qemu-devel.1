Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B9DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:46:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF072073E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0ID5kUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF072073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsNhH-0000AZ-Ay
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 05:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsNgY-0007uR-10
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 05:45:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47312
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsNgV-0000wM-8q
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 05:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594028710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6gqVOFZTw7pRfSNtUry2rc6LuUavMTAG9nbeXETn+80=;
 b=P0ID5kUKot/WMYCNBfIQwrZMYerJ74Ah9vz3r8wzURcHBTNlIbvSZLS1a9QL2DI8/im1NK
 aL5/bV+5R2ZA5lkve/VzZ+IzwzwakOowdv2FIIclzwChoI7OmKFR+pyehr+hUbpqhPKpwW
 BvC+S4TgDGJYDAQEpwrejVlHrX7VYsY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-2tjw8avaP4SVknxdF-XG5g-1; Mon, 06 Jul 2020 05:45:08 -0400
X-MC-Unique: 2tjw8avaP4SVknxdF-XG5g-1
Received: by mail-wm1-f72.google.com with SMTP id y204so34204355wmd.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 02:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=6gqVOFZTw7pRfSNtUry2rc6LuUavMTAG9nbeXETn+80=;
 b=rVRIR767ypV/i4DmhZUDlY2Jm1Qu+Fu0KHbJHdEfM7GE6w/S2paZggNZzhK5+GkYmy
 OtVTzLpLrDI1cgQjJ3EZrJRZSaJyMXASP3iSfEg/6UC0lSMhyP/TIhB1VLFjc+hUHFmz
 /vHHuiQeaqr8gRerm8UyAbAyUbK3yZzT2MQnRlnf8NJJg6D4Z8aaxC8le5aBnDu4xaQP
 MlGZPWnSspNmsQr61RqjDk2XrMO6uB2oA/F8RvsVAKOc4/6APTrZ7kahARR5LChqUgR6
 sNwj719pGWkW5pRQszFAB8h6N/dfHV570Nc9fZb1ZCpKgzUONY6JILTGuAPhMhHCR8CL
 p9uA==
X-Gm-Message-State: AOAM533JBAvz4LVSqCdKDI95icjLuKLvOWgrZABaNgkU7Y+fi/xSvEaW
 cxLYaEwQszC0cS4ED/9MA9fldLbnRhI/VpgsSKOMXWDeL1pO0TeIuAUNOIUVuMajFxHArIcpU7M
 f8JF23YNVqPQDf1M=
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr45256616wrw.28.1594028707049; 
 Mon, 06 Jul 2020 02:45:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWJnuOJsd/vMYNUDhL0ZjXN3yz+diXPHn5xzT160qtfhHmbWWVAJE8X/3uHlW0yqdIWamg3w==
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr45256590wrw.28.1594028706738; 
 Mon, 06 Jul 2020 02:45:06 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u186sm23382009wmu.10.2020.07.06.02.45.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 02:45:06 -0700 (PDT)
Subject: Re: [PATCH v3 16/16] block/nvme: Use per-queuepair IRQ notifier and
 AIO context
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20200704213051.19749-1-philmd@redhat.com>
 <20200704213051.19749-17-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <930d16cd-41c5-0d2c-4c73-d6da804244f4@redhat.com>
Date: Mon, 6 Jul 2020 11:45:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200704213051.19749-17-philmd@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/4/20 11:30 PM, Philippe Mathieu-Daudé wrote:
> To be able to use multiple queues on the same hardware,
> we need to have each queuepair able to receive IRQ
> notifications in the correct AIO context.
> 
> The AIO context and the notification handler have to be proper
> to each queue, not to the block driver. Move aio_context and
> irq_notifier from BDRVNVMeState to NVMeQueuePair.
> 
> Before this patch, only the admin queuepair had an EventNotifier
> and was checking all queues when notified by IRQ.
> After this patch, each queuepair (admin or io) is hooked with its
> own IRQ notifier up to VFIO.

Hmm I should also add a note that we currently only use a single IO
queuepair: nvme_add_io_queue() is called once in nvme_init().

Now after this patch, we should be able to call it twice...

> 
> AioContexts must be identical across all queuepairs and
> BlockDriverStates. Although they all have their own AioContext
> pointer there is no true support for different AioContexts yet.
> (For example, nvme_cmd_sync() is called with a bs argument but
> AIO_WAIT_WHILE(q->aio_context, ...) uses the queuepair
> aio_context so the assumption is that they match.)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v3:
> - Add notifier to IO queuepairs
> - Reword with Stefan help
> 
> I'd like to split this into smaller changes, but I'm not sure
> if it is possible...
> Maybe move EventNotifier first (keeping aio_context shared),
> then move AioContext per queuepair?
> ---
>  block/nvme.c | 102 +++++++++++++++++++++++++--------------------------
>  1 file changed, 51 insertions(+), 51 deletions(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 42c0d5284f..fcf8d93fb2 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -60,6 +60,8 @@ typedef struct {
>  
>  typedef struct {
>      QemuMutex   lock;
> +    AioContext *aio_context;
> +    EventNotifier irq_notifier;
>  
>      /* Read from I/O code path, initialized under BQL */
>      BDRVNVMeState   *s;
> @@ -107,7 +109,6 @@ QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) != 0x1000);
>  #define QUEUE_INDEX_IO(n)   (1 + n)
>  
>  struct BDRVNVMeState {
> -    AioContext *aio_context;
>      QEMUVFIOState *vfio;
>      NVMeRegs *regs;
>      /* The submission/completion queue pairs.
> @@ -120,7 +121,6 @@ struct BDRVNVMeState {
>      /* How many uint32_t elements does each doorbell entry take. */
>      size_t doorbell_scale;
>      bool write_cache_supported;
> -    EventNotifier irq_notifier;
>  
>      uint64_t nsze; /* Namespace size reported by identify command */
>      int nsid;      /* The namespace id to read/write data. */
> @@ -227,11 +227,17 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
>      if (!q->prp_list_pages) {
>          goto fail;
>      }
> +    r = event_notifier_init(&q->irq_notifier, 0);
> +    if (r) {
> +        error_setg(errp, "Failed to init event notifier");
> +        goto fail;
> +    }
>      memset(q->prp_list_pages, 0, s->page_size * NVME_QUEUE_SIZE);
>      qemu_mutex_init(&q->lock);
>      q->s = s;
>      q->index = idx;
>      qemu_co_queue_init(&q->free_req_queue);
> +    q->aio_context = aio_context;
>      q->completion_bh = aio_bh_new(aio_context, nvme_process_completion_bh, q);
>      r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
>                            s->page_size * NVME_NUM_REQS,
> @@ -325,7 +331,7 @@ static void nvme_put_free_req_locked(NVMeQueuePair *q, NVMeRequest *req)
>  static void nvme_wake_free_req_locked(NVMeQueuePair *q)
>  {
>      if (!qemu_co_queue_empty(&q->free_req_queue)) {
> -        replay_bh_schedule_oneshot_event(q->s->aio_context,
> +        replay_bh_schedule_oneshot_event(q->aio_context,
>                  nvme_free_req_queue_cb, q);
>      }
>  }
> @@ -492,7 +498,6 @@ static void nvme_cmd_sync_cb(void *opaque, int ret)
>  static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
>                           NvmeCmd *cmd)
>  {
> -    AioContext *aio_context = bdrv_get_aio_context(bs);
>      NVMeRequest *req;
>      int ret = -EINPROGRESS;
>      req = nvme_get_free_req(q);
> @@ -501,7 +506,7 @@ static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
>      }
>      nvme_submit_command(q, req, cmd, nvme_cmd_sync_cb, &ret);
>  
> -    AIO_WAIT_WHILE(aio_context, ret == -EINPROGRESS);
> +    AIO_WAIT_WHILE(q->aio_context, ret == -EINPROGRESS);
>      return ret;
>  }
>  
> @@ -616,47 +621,35 @@ static bool nvme_poll_queue(NVMeQueuePair *q)
>      return progress;
>  }
>  
> -static bool nvme_poll_queues(BDRVNVMeState *s)
> -{
> -    bool progress = false;
> -    int i;
> -
> -    for (i = 0; i < s->nr_queues; i++) {
> -        if (nvme_poll_queue(s->queues[i])) {
> -            progress = true;
> -        }
> -    }
> -    return progress;
> -}
> -
>  static void nvme_handle_event(EventNotifier *n)
>  {
> -    BDRVNVMeState *s = container_of(n, BDRVNVMeState, irq_notifier);
> +    NVMeQueuePair *q = container_of(n, NVMeQueuePair, irq_notifier);
>  
> -    trace_nvme_handle_event(s);
> +    trace_nvme_handle_event(q);
>      event_notifier_test_and_clear(n);
> -    nvme_poll_queues(s);
> +    nvme_poll_queue(q);
>  }
>  
>  static bool nvme_poll_cb(void *opaque)
>  {
>      EventNotifier *e = opaque;
> -    BDRVNVMeState *s = container_of(e, BDRVNVMeState, irq_notifier);
> +    NVMeQueuePair *q = container_of(e, NVMeQueuePair, irq_notifier);
>  
> -    trace_nvme_poll_cb(s);
> -    return nvme_poll_queues(s);
> +    trace_nvme_poll_cb(q);
> +    return nvme_poll_queue(q);
>  }
>  
> -static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
> +static bool nvme_add_io_queue(BlockDriverState *bs,
> +                              AioContext *aio_context, Error **errp)
>  {
>      BDRVNVMeState *s = bs->opaque;
>      int n = s->nr_queues;
>      NVMeQueuePair *q;
>      NvmeCmd cmd;
>      int queue_size = NVME_QUEUE_SIZE;
> +    int ret;
>  
> -    q = nvme_create_queue_pair(s, bdrv_get_aio_context(bs),
> -                               n, queue_size, errp);
> +    q = nvme_create_queue_pair(s, aio_context, n, queue_size, errp);
>      if (!q) {
>          return false;
>      }
> @@ -683,6 +676,17 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
>      s->queues = g_renew(NVMeQueuePair *, s->queues, n + 1);
>      s->queues[n] = q;
>      s->nr_queues++;
> +
> +    ret = qemu_vfio_pci_init_irq(s->vfio,
> +                                 &s->queues[n]->irq_notifier,
> +                                 VFIO_PCI_MSIX_IRQ_INDEX, errp);
> +    if (ret) {
> +        goto out_error;
> +    }
> +    aio_set_event_notifier(aio_context,
> +                           &s->queues[n]->irq_notifier,
> +                           false, nvme_handle_event, nvme_poll_cb);
> +
>      return true;
>  out_error:
>      nvme_free_queue_pair(q);
> @@ -704,12 +708,6 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>      qemu_co_queue_init(&s->dma_flush_queue);
>      s->device = g_strdup(device);
>      s->nsid = namespace;
> -    s->aio_context = bdrv_get_aio_context(bs);
> -    ret = event_notifier_init(&s->irq_notifier, 0);
> -    if (ret) {
> -        error_setg(errp, "Failed to init event notifier");
> -        return ret;
> -    }
>  
>      s->vfio = qemu_vfio_open_pci(device, errp);
>      if (!s->vfio) {
> @@ -784,12 +782,14 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>          }
>      }
>  
> -    ret = qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier,
> +    ret = qemu_vfio_pci_init_irq(s->vfio,
> +                                 &s->queues[QUEUE_INDEX_ADMIN]->irq_notifier,
>                                   VFIO_PCI_MSIX_IRQ_INDEX, errp);
>      if (ret) {
>          goto out;
>      }
> -    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
> +    aio_set_event_notifier(aio_context,
> +                           &s->queues[QUEUE_INDEX_ADMIN]->irq_notifier,
>                             false, nvme_handle_event, nvme_poll_cb);
>  
>      nvme_identify(bs, namespace, &local_err);
> @@ -800,7 +800,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>      }
>  
>      /* Set up command queues. */
> -    if (!nvme_add_io_queue(bs, errp)) {
> +    if (!nvme_add_io_queue(bs, aio_context, errp)) {
>          ret = -EIO;
>      }
>  out:
> @@ -869,12 +869,14 @@ static void nvme_close(BlockDriverState *bs)
>      BDRVNVMeState *s = bs->opaque;
>  
>      for (i = 0; i < s->nr_queues; ++i) {
> -        nvme_free_queue_pair(s->queues[i]);
> +        NVMeQueuePair *q = s->queues[i];
> +
> +        aio_set_event_notifier(q->aio_context,
> +                               &q->irq_notifier, false, NULL, NULL);
> +        event_notifier_cleanup(&q->irq_notifier);
> +        nvme_free_queue_pair(q);
>      }
>      g_free(s->queues);
> -    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
> -                           false, NULL, NULL);
> -    event_notifier_cleanup(&s->irq_notifier);
>      qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
>      qemu_vfio_close(s->vfio);
>  
> @@ -1086,7 +1088,7 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
>          .cdw12 = cpu_to_le32(cdw12),
>      };
>      NVMeCoData data = {
> -        .ctx = bdrv_get_aio_context(bs),
> +        .ctx = ioq->aio_context,
>          .ret = -EINPROGRESS,
>      };
>  
> @@ -1195,7 +1197,7 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
>          .nsid = cpu_to_le32(s->nsid),
>      };
>      NVMeCoData data = {
> -        .ctx = bdrv_get_aio_context(bs),
> +        .ctx = ioq->aio_context,
>          .ret = -EINPROGRESS,
>      };
>  
> @@ -1236,7 +1238,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
>      };
>  
>      NVMeCoData data = {
> -        .ctx = bdrv_get_aio_context(bs),
> +        .ctx = ioq->aio_context,
>          .ret = -EINPROGRESS,
>      };
>  
> @@ -1286,7 +1288,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
>      };
>  
>      NVMeCoData data = {
> -        .ctx = bdrv_get_aio_context(bs),
> +        .ctx = ioq->aio_context,
>          .ret = -EINPROGRESS,
>      };
>  
> @@ -1379,10 +1381,10 @@ static void nvme_detach_aio_context(BlockDriverState *bs)
>  
>          qemu_bh_delete(q->completion_bh);
>          q->completion_bh = NULL;
> -    }
>  
> -    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
> -                           false, NULL, NULL);
> +        aio_set_event_notifier(bdrv_get_aio_context(bs), &q->irq_notifier,
> +                               false, NULL, NULL);
> +    }
>  }
>  
>  static void nvme_attach_aio_context(BlockDriverState *bs,
> @@ -1390,13 +1392,11 @@ static void nvme_attach_aio_context(BlockDriverState *bs,
>  {
>      BDRVNVMeState *s = bs->opaque;
>  
> -    s->aio_context = new_context;
> -    aio_set_event_notifier(new_context, &s->irq_notifier,
> -                           false, nvme_handle_event, nvme_poll_cb);
> -
>      for (int i = 0; i < s->nr_queues; i++) {
>          NVMeQueuePair *q = s->queues[i];
>  
> +        aio_set_event_notifier(new_context, &q->irq_notifier,
> +                               false, nvme_handle_event, nvme_poll_cb);
>          q->completion_bh =
>              aio_bh_new(new_context, nvme_process_completion_bh, q);
>      }
> 


