Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33A8C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13F521D41
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ky5Jvj+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13F521D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX9BP-0000ui-Na
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX8dE-0006mA-QQ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kX8dA-000576-BL
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603742291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQ2Zx6I6o6q4XWNDCasdjHlqlI1bwSHuy3OnZhdZZ0o=;
 b=Ky5Jvj+WazYzfzLlXwPi0+KHz2MBonOtGcj5iLr29/DpHHdvMzCVBFlEkdO5NrSdq7wu5G
 QHJGDSN0QyeIVMlh0sCEMMdjyWNZ0WrA9ZJzxczKhLkqEpkf3czuQ+lfNxpB0A9HtV1NEY
 HQWtzvIwEUlmI1COWtdO9jodQ9F/1RA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-lJqQfZdsNH2lcKFsTNMSlg-1; Mon, 26 Oct 2020 15:58:09 -0400
X-MC-Unique: lJqQfZdsNH2lcKFsTNMSlg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 592F181E235;
 Mon, 26 Oct 2020 19:58:08 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C4B26EF40;
 Mon, 26 Oct 2020 19:58:06 +0000 (UTC)
Subject: Re: [PATCH v2 11/19] util/vfio-helpers: Let qemu_vfio_dma_map()
 propagate Error
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201026105504.4023620-1-philmd@redhat.com>
 <20201026105504.4023620-12-philmd@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2cbd5471-4611-ae6b-d79f-db6ff19db5bf@redhat.com>
Date: Mon, 26 Oct 2020 20:58:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201026105504.4023620-12-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 10/26/20 11:54 AM, Philippe Mathieu-Daudé wrote:
> Currently qemu_vfio_dma_map() displays errors on stderr.
> When using management interface, this information is simply
> lost. Pass qemu_vfio_dma_map() an Error* argument so it can
Error** or simply error handle
> propagate the error to callers.
> 
> Reviewed-by: Fam Zheng <fam@euphon.net>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/qemu/vfio-helpers.h |  2 +-
>  block/nvme.c                | 14 +++++++-------
>  util/vfio-helpers.c         | 12 +++++++-----
>  3 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
> index 4491c8e1a6e..bde9495b254 100644
> --- a/include/qemu/vfio-helpers.h
> +++ b/include/qemu/vfio-helpers.h
> @@ -18,7 +18,7 @@ typedef struct QEMUVFIOState QEMUVFIOState;
>  QEMUVFIOState *qemu_vfio_open_pci(const char *device, Error **errp);
>  void qemu_vfio_close(QEMUVFIOState *s);
>  int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
> -                      bool temporary, uint64_t *iova_list);
> +                      bool temporary, uint64_t *iova_list, Error **errp);
>  int qemu_vfio_dma_reset_temporary(QEMUVFIOState *s);
>  void qemu_vfio_dma_unmap(QEMUVFIOState *s, void *host);
>  void *qemu_vfio_pci_map_bar(QEMUVFIOState *s, int index,
> diff --git a/block/nvme.c b/block/nvme.c
> index 3b6d3972ec2..6f1ebdf031f 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -167,9 +167,9 @@ static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
>          return;
>      }
>      memset(q->queue, 0, bytes);
> -    r = qemu_vfio_dma_map(s->vfio, q->queue, bytes, false, &q->iova);
> +    r = qemu_vfio_dma_map(s->vfio, q->queue, bytes, false, &q->iova, errp);
>      if (r) {
> -        error_setg(errp, "Cannot map queue");
> +        error_prepend(errp, "Cannot map queue: ");
>      }
>  }
>  
> @@ -223,7 +223,7 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
>      q->completion_bh = aio_bh_new(aio_context, nvme_process_completion_bh, q);
>      r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
>                            s->page_size * NVME_NUM_REQS,
> -                          false, &prp_list_iova);
> +                          false, &prp_list_iova, errp);
>      if (r) {
you may add an associated error_prepend(errp, "") here too to be consistent.
>          goto fail;
>      }
> @@ -514,9 +514,9 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>          error_setg(errp, "Cannot allocate buffer for identify response");
>          goto out;
>      }
> -    r = qemu_vfio_dma_map(s->vfio, id, sizeof(*id), true, &iova);
> +    r = qemu_vfio_dma_map(s->vfio, id, sizeof(*id), true, &iova, errp);
>      if (r) {
> -        error_setg(errp, "Cannot map buffer for DMA");
> +        error_prepend(errp, "Cannot map buffer for DMA: ");
>          goto out;
>      }
>  
> @@ -1003,7 +1003,7 @@ try_map:
>          r = qemu_vfio_dma_map(s->vfio,
>                                qiov->iov[i].iov_base,
>                                qiov->iov[i].iov_len,
> -                              true, &iova);
> +                              true, &iova, NULL);
>          if (r == -ENOMEM && retry) {
>              retry = false;
>              trace_nvme_dma_flush_queue_wait(s);
> @@ -1450,7 +1450,7 @@ static void nvme_register_buf(BlockDriverState *bs, void *host, size_t size)
>      int ret;
>      BDRVNVMeState *s = bs->opaque;
>  
> -    ret = qemu_vfio_dma_map(s->vfio, host, size, false, NULL);
> +    ret = qemu_vfio_dma_map(s->vfio, host, size, false, NULL, NULL);
>      if (ret) {
>          /* FIXME: we may run out of IOVA addresses after repeated
>           * bdrv_register_buf/bdrv_unregister_buf, because nvme_vfio_dma_unmap
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 73f7bfa7540..c03fe0b7156 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -462,7 +462,7 @@ static void qemu_vfio_ram_block_added(RAMBlockNotifier *n,
>  {
>      QEMUVFIOState *s = container_of(n, QEMUVFIOState, ram_notifier);
>      trace_qemu_vfio_ram_block_added(s, host, size);
> -    qemu_vfio_dma_map(s, host, size, false, NULL);
> +    qemu_vfio_dma_map(s, host, size, false, NULL, NULL);
>  }
>  
>  static void qemu_vfio_ram_block_removed(RAMBlockNotifier *n,
> @@ -477,6 +477,7 @@ static void qemu_vfio_ram_block_removed(RAMBlockNotifier *n,
>  
>  static int qemu_vfio_init_ramblock(RAMBlock *rb, void *opaque)
>  {
> +    Error *local_err = NULL;
>      void *host_addr = qemu_ram_get_host_addr(rb);
>      ram_addr_t length = qemu_ram_get_used_length(rb);
>      int ret;
> @@ -485,10 +486,11 @@ static int qemu_vfio_init_ramblock(RAMBlock *rb, void *opaque)
>      if (!host_addr) {
>          return 0;
>      }
> -    ret = qemu_vfio_dma_map(s, host_addr, length, false, NULL);
> +    ret = qemu_vfio_dma_map(s, host_addr, length, false, NULL, &local_err);
>      if (ret) {
> -        fprintf(stderr, "qemu_vfio_init_ramblock: failed %p %" PRId64 "\n",
> -                host_addr, (uint64_t)length);
> +        error_reportf_err(local_err,
> +                          "qemu_vfio_init_ramblock: failed %p %" PRId64 ":",
> +                          host_addr, (uint64_t)length);
>      }
>      return 0;
>  }
> @@ -724,7 +726,7 @@ qemu_vfio_find_temp_iova(QEMUVFIOState *s, size_t size, uint64_t *iova)
>   * mapping status within this area is not allowed).
>   */
>  int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
> -                      bool temporary, uint64_t *iova)
> +                      bool temporary, uint64_t *iova, Error **errp)
>  {
where do you set errp. You just add prepend messages above. If I am not
wrong errp must be non NULL to call error_prepend()

Thanks

Eric
>      int ret = 0;
>      int index;
> 


