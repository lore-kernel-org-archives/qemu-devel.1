Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C95BC5519A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560F4214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GK9v93zR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560F4214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSyyn-0005bk-Cr
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jSyy3-0004ui-U8
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jSyy3-00019J-7N
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:18:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54150
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jSyy2-00018h-PO
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587975497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+tAA5LvevSXUteuE8fYHQEIUEudxqkCh8Ef80hQD2CI=;
 b=GK9v93zRsgcPl68ON0VOwR7fdNB+qDnHuLoPOQbViU5KK2LJLARi2cXX5pazIGJtJCacmb
 fOlHJyFg3tzGtcvR5jDYRapzDKdbVH4mU/CxR5SXiTQJuTaNapbVlAR50liN1TbFTy//rh
 5HvCJY2ve4rSTJKH6SSC7O6ubgGcqoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-ElYXZE_uNQqGtzTsrqlL9A-1; Mon, 27 Apr 2020 04:18:16 -0400
X-MC-Unique: ElYXZE_uNQqGtzTsrqlL9A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C72B800D24;
 Mon, 27 Apr 2020 08:18:14 +0000 (UTC)
Received: from [10.36.114.127] (ovpn-114-127.ams2.redhat.com [10.36.114.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8329960C84;
 Mon, 27 Apr 2020 08:18:10 +0000 (UTC)
Subject: Re: [PATCH v22 QEMU 4/5] virtio-balloon: Implement support for page
 poison reporting feature
To: Alexander Duyck <alexander.duyck@gmail.com>, mst@redhat.com
References: <20200424164239.10723.58352.stgit@localhost.localdomain>
 <20200424165028.10723.60530.stgit@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <042b01cf-8d46-4d47-01a5-eb09250ac435@redhat.com>
Date: Mon, 27 Apr 2020 10:18:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424165028.10723.60530.stgit@localhost.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 01:12:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
> We need to make certain to advertise support for page poison reporting if
> we want to actually get data on if the guest will be poisoning pages.
> 
> Add a value for reporting the poison value being used if page poisoning is
> enabled in the guest. With this we can determine if we will need to skip
> free page reporting when it is enabled in the future.
> 
> The value currently has no impact on existing balloon interfaces. In the
> case of existing balloon interfaces the onus is on the guest driver to
> reapply whatever poison is in place.
> 
> When we add free page reporting the poison value is used to determine if
> we can perform in-place page reporting. The expectation is that a reported
> page will already contain the value specified by the poison, and the
> reporting of the page should not change that value.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  hw/virtio/virtio-balloon.c         |   29 +++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-balloon.h |    1 +
>  2 files changed, 30 insertions(+)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a1d6fb52c876..c1c76ec09c95 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -634,6 +634,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>  
>      config.num_pages = cpu_to_le32(dev->num_pages);
>      config.actual = cpu_to_le32(dev->actual);
> +    config.poison_val = cpu_to_le32(dev->poison_val);
>  
>      if (dev->free_page_hint_status == FREE_PAGE_HINT_S_REQUESTED) {
>          config.free_page_hint_cmd_id =
> @@ -683,6 +684,14 @@ static ram_addr_t get_current_ram_size(void)
>      return size;
>  }
>  
> +static bool virtio_balloon_page_poison_support(void *opaque)
> +{
> +    VirtIOBalloon *s = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
> +
> +    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
> +}
> +
>  static void virtio_balloon_set_config(VirtIODevice *vdev,
>                                        const uint8_t *config_data)
>  {
> @@ -697,6 +706,10 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
>          qapi_event_send_balloon_change(vm_ram_size -
>                          ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
>      }
> +    dev->poison_val = 0;
> +    if (virtio_balloon_page_poison_support(dev)) {
> +        dev->poison_val = le32_to_cpu(config.poison_val);
> +    }
>      trace_virtio_balloon_set_config(dev->actual, oldactual);
>  }
>  
> @@ -755,6 +768,17 @@ static const VMStateDescription vmstate_virtio_balloon_free_page_hint = {
>      }
>  };
>  
> +static const VMStateDescription vmstate_virtio_balloon_page_poison = {
> +    .name = "vitio-balloon-device/page-poison",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = virtio_balloon_page_poison_support,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(poison_val, VirtIOBalloon),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_virtio_balloon_device = {
>      .name = "virtio-balloon-device",
>      .version_id = 1,
> @@ -767,6 +791,7 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
>      },
>      .subsections = (const VMStateDescription * []) {
>          &vmstate_virtio_balloon_free_page_hint,
> +        &vmstate_virtio_balloon_page_poison,
>          NULL
>      }
>  };
> @@ -854,6 +879,8 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
>          g_free(s->stats_vq_elem);
>          s->stats_vq_elem = NULL;
>      }
> +
> +    s->poison_val = 0;
>  }
>  
>  static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
> @@ -916,6 +943,8 @@ static Property virtio_balloon_properties[] = {
>                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
>      DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
>                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> +    DEFINE_PROP_BIT("page-poison", VirtIOBalloon, host_features,
> +                    VIRTIO_BALLOON_F_PAGE_POISON, true),
>      /* QEMU 4.0 accidentally changed the config size even when free-page-hint
>       * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
>       * property retains this quirk for QEMU 4.1 machine types.
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> index 108cff97e71a..3ca2a78e1aca 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -70,6 +70,7 @@ typedef struct VirtIOBalloon {
>      uint32_t host_features;
>  
>      bool qemu_4_0_config_size;
> +    uint32_t poison_val;
>  } VirtIOBalloon;
>  
>  #endif
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


