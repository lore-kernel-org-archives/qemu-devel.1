Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433A3C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E8E20661
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+JD/5ad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E8E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSz1Z-0007jh-3X
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jSz0p-00075u-W4
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jSz0p-0003Qa-8l
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:21:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53540
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jSz0o-0003QO-Rs
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587975669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=J7ndOchAuv8BwRiVBodGy7qHIbl98i8Jo4YQY554Awg=;
 b=T+JD/5adVjnLwxidpE140gL5w73gnJsLn7NDBTHzCk6F7KJgXJeY0fjMgtskubzGATZHSy
 8MZ1SvZ8kK8eBeXbxYmzSS7BERqkVhCiQiKITg69RkiXFlIp8V2SSKJF+GqmkVs4r/sriO
 pV4zTK1tMg7/4uxJlEMxjaLO/nHWG/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-BNFnpq5ONUWetzBS6gysIg-1; Mon, 27 Apr 2020 04:21:07 -0400
X-MC-Unique: BNFnpq5ONUWetzBS6gysIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B63C6468;
 Mon, 27 Apr 2020 08:21:06 +0000 (UTC)
Received: from [10.36.114.127] (ovpn-114-127.ams2.redhat.com [10.36.114.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D6235D715;
 Mon, 27 Apr 2020 08:21:01 +0000 (UTC)
Subject: Re: [PATCH v22 QEMU 5/5] virtio-balloon: Provide an interface for
 free page reporting
To: Alexander Duyck <alexander.duyck@gmail.com>, mst@redhat.com
References: <20200424164239.10723.58352.stgit@localhost.localdomain>
 <20200424165034.10723.77728.stgit@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <d473cfb6-0774-003c-88bd-10c5227e19a2@redhat.com>
Date: Mon, 27 Apr 2020 10:21:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424165034.10723.77728.stgit@localhost.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:33:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24.04.20 18:50, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Add support for free page reporting. The idea is to function very similar
> to how the balloon works in that we basically end up madvising the page as
> not being used. However we don't really need to bother with any deflate
> type logic since the page will be faulted back into the guest when it is
> read or written to.
> 
> This provides a new way of letting the guest proactively report free
> pages to the hypervisor, so the hypervisor can reuse them. In contrast to
> inflate/deflate that is triggered via the hypervisor explicitly.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  hw/virtio/virtio-balloon.c         |   67 ++++++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-balloon.h |    2 +
>  2 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index c1c76ec09c95..2ce56c6c0794 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -321,6 +321,67 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
>      balloon_stats_change_timer(s, 0);
>  }
>  
> +static void virtio_balloon_handle_report(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
> +    VirtQueueElement *elem;
> +
> +    while ((elem = virtqueue_pop(vq, sizeof(VirtQueueElement)))) {
> +        unsigned int i;
> +
> +        /*
> +         * When we discard the page it has the effect of removing the page
> +         * from the hypervisor itself and causing it to be zeroed when it
> +         * is returned to us. So we must not discard the page if it is
> +         * accessible by another device or process, or if the guest is
> +         * expecting it to retain a non-zero value.
> +         */
> +        if (qemu_balloon_is_inhibited() || dev->poison_val) {
> +            goto skip_element;
> +        }
> +
> +        for (i = 0; i < elem->in_num; i++) {
> +            void *addr = elem->in_sg[i].iov_base;
> +            size_t size = elem->in_sg[i].iov_len;
> +            ram_addr_t ram_offset;
> +            RAMBlock *rb;
> +
> +            /*
> +             * There is no need to check the memory section to see if
> +             * it is ram/readonly/romd like there is for handle_output
> +             * below. If the region is not meant to be written to then
> +             * address_space_map will have allocated a bounce buffer
> +             * and it will be freed in address_space_unmap and trigger
> +             * and unassigned_mem_write before failing to copy over the
> +             * buffer. If more than one bad descriptor is provided it
> +             * will return NULL after the first bounce buffer and fail
> +             * to map any resources.
> +             */
> +            rb = qemu_ram_block_from_host(addr, false, &ram_offset);
> +            if (!rb) {
> +                trace_virtio_balloon_bad_addr(elem->in_addr[i]);
> +                continue;
> +            }
> +
> +            /*
> +             * For now we will simply ignore unaligned memory regions, or
> +             * regions that overrun the end of the RAMBlock.
> +             */
> +            if (!QEMU_IS_ALIGNED(ram_offset | size, qemu_ram_pagesize(rb)) ||
> +                (ram_offset + size) > qemu_ram_get_used_length(rb)) {
> +                continue;
> +            }
> +
> +            ram_block_discard_range(rb, ram_offset, size);
> +        }
> +
> +skip_element:
> +        virtqueue_push(vq, elem, 0);
> +        virtio_notify(vdev, vq);
> +        g_free(elem);
> +    }
> +}
> +
>  static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  {
>      VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
> @@ -818,6 +879,10 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>      s->dvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>      s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
>  
> +    if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING)) {
> +        s->rvq = virtio_add_queue(vdev, 32, virtio_balloon_handle_report);
> +    }
> +
>      if (virtio_has_feature(s->host_features,
>                             VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>          s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
> @@ -945,6 +1010,8 @@ static Property virtio_balloon_properties[] = {
>                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
>      DEFINE_PROP_BIT("page-poison", VirtIOBalloon, host_features,
>                      VIRTIO_BALLOON_F_PAGE_POISON, true),
> +    DEFINE_PROP_BIT("free-page-reporting", VirtIOBalloon, host_features,
> +                    VIRTIO_BALLOON_F_REPORTING, false),
>      /* QEMU 4.0 accidentally changed the config size even when free-page-hint
>       * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
>       * property retains this quirk for QEMU 4.1 machine types.
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> index 3ca2a78e1aca..ac4013d51010 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -42,7 +42,7 @@ enum virtio_balloon_free_page_hint_status {
>  
>  typedef struct VirtIOBalloon {
>      VirtIODevice parent_obj;
> -    VirtQueue *ivq, *dvq, *svq, *free_page_vq;
> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *rvq;
>      uint32_t free_page_hint_status;
>      uint32_t num_pages;
>      uint32_t actual;
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


