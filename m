Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDFAC3B18B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF5320675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuWB6bXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF5320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Gf0-0005US-84
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2GeK-0004xi-D7
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2GeI-0004tr-U6
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:43:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58878
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2GeI-0004sM-QU
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581608610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l06h7PxW6k3OAGxJhWxkwGVQ6rF25l9heTBEJeN9ZNU=;
 b=QuWB6bXL59mm48t1W4XNZqU0XyhgqlwgMaFSBiGgNdUht2HHBR0psvAtx3UWS6aKnyiG8b
 YVtbeWUyWebZG2OuYG/nUhkwUxNf+NKmGOnrubN8mTLLUVL8yoVOGdvx5ypNJGTyeonsRx
 Hk15x1EjSmW1eAxeocsR+XuK6r/lfyk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-vpioJin-Or2l0YmigwVi9g-1; Thu, 13 Feb 2020 10:43:28 -0500
Received: by mail-wm1-f69.google.com with SMTP id p26so2164999wmg.5
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 07:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l06h7PxW6k3OAGxJhWxkwGVQ6rF25l9heTBEJeN9ZNU=;
 b=uPa7RDNJx+bT4JjY3KWqd4e5wczGpUUe6T6/bDYqTBZVNqPW5xIgrmxvPtLDbG5wD1
 2ofCMPjEdZLHgyIWhLcy6KYP4TW0IK5t6B4SWdO0U6st17ci4deVaIdJgH7YW3ABOFa5
 84aL39KmS3UXlYe+uP0mJiQP/f9V/Envpw+ind8VnA6dHjZJgVRzoEdLYKgYCTTl1pvS
 gv5EZDo3beObE4tdZ0wzfpeamvA8Zb10na2MhvzoOq6dB7cMBdTIUWMqTFIQYc+9dvx9
 LAQO1zS7SQS9OqklQlGk3UDUsy2vhctJeggSZOVUrLmspu3LtOfKVaKHoNF+CsVD0V8V
 lgdw==
X-Gm-Message-State: APjAAAUTP89wJsoROPEjZ0jkluDIU6DCs9U2KmQeSwLYlt8A3siMyj7t
 QBO49/nUuZSKkjtwt64/ZtpbHKDEdgR4pqqZB8RjtawFf/n00x4P8D1lni6Ir4YEc482c8asAkm
 weqXdf+eU4kiL740=
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr22846502wrv.144.1581608606470; 
 Thu, 13 Feb 2020 07:43:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqxQsoWKeVp4JeVjOQNCHumfqg9n5E6wc7UyHwHe7ItYO3WWXLYRaf7V1xXf6zIFVCqrGo5xgA==
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr22846476wrv.144.1581608606184; 
 Thu, 13 Feb 2020 07:43:26 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a9sm3585348wrn.3.2020.02.13.07.43.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 07:43:25 -0800 (PST)
Subject: Re: [PATCH v2] virtio: increase virtuqueue size for virtio-scsi and
 virtio-blk
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200213145927.7539-1-dplotnikov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c2e394b4-8dd6-f845-9b40-79a12441f676@redhat.com>
Date: Thu, 13 Feb 2020 16:43:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213145927.7539-1-dplotnikov@virtuozzo.com>
Content-Language: en-US
X-MC-Unique: vpioJin-Or2l0YmigwVi9g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Typo 'virtuqueue' in subject.

On 2/13/20 3:59 PM, Denis Plotnikov wrote:
> v1:
>    * seg_max default value changing removed
> 

^^^ This part ...

> ---
> The goal is to reduce the amount of requests issued by a guest on
> 1M reads/writes. This rises the performance up to 4% on that kind of
> disk access pattern.
> 
> The maximum chunk size to be used for the guest disk accessing is
> limited with seg_max parameter, which represents the max amount of
> pices in the scatter-geather list in one guest disk request.
> 
> Since seg_max is virqueue_size dependent, increasing the virtqueue
> size increases seg_max, which, in turn, increases the maximum size
> of data to be read/write from a guest disk.
> 
> More details in the original problem statment:
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
> 
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---

... goes here.

>   hw/block/virtio-blk.c | 2 +-
>   hw/core/machine.c     | 2 ++
>   hw/scsi/virtio-scsi.c | 2 +-
>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 09f46ed85f..142863a3b2 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1272,7 +1272,7 @@ static Property virtio_blk_properties[] = {
>       DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
>                       true),
>       DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
> -    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
> +    DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 256),
>       DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_adjust, true),
>       DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD,
>                        IOThread *),
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 2501b540ec..3427d6cf4c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -28,6 +28,8 @@
>   #include "hw/mem/nvdimm.h"
>   
>   GlobalProperty hw_compat_4_2[] = {
> +    { "virtio-blk-device", "queue-size", "128"},
> +    { "virtio-scsi-device", "virtqueue_size", "128"},
>       { "virtio-blk-device", "x-enable-wce-if-config-wce", "off" },
>       { "virtio-blk-device", "seg-max-adjust", "off"},
>       { "virtio-scsi-device", "seg_max_adjust", "off"},
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 3b61563609..472bbd233b 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -965,7 +965,7 @@ static void virtio_scsi_device_unrealize(DeviceState *dev, Error **errp)
>   static Property virtio_scsi_properties[] = {
>       DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queues, 1),
>       DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
> -                                         parent_obj.conf.virtqueue_size, 128),
> +                                         parent_obj.conf.virtqueue_size, 256),
>       DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
>                         parent_obj.conf.seg_max_adjust, true),
>       DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_sectors,
> 


