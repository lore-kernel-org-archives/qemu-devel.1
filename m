Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69A9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8099720643
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="La9vTYhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8099720643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jabwJ-0002JN-Ij
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jabvK-0001hq-9V
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:19:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25750
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jabvI-0000u1-Sp
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589793539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mryntO6Z+uP+Xk2M9yDUHtv3sC5SF7dqtlzLXNBKT0w=;
 b=La9vTYhhfy1KfRUAKRAKUMUbIudYz67wNmSRMz37REr9sbMXm+nnv+MBJE03PkJ+GxzcmY
 zKfo4Q+m3nk7JvRS7maQbZvRK8Sk7ovOl2penTgvHSUOnthX6meJhmrnDHlIolyjfo9pYu
 3vsSzHHbnjWfmScS9SN+1Oyif9ljW9k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-CdDf0meiNZqPXgf6D4X4Cg-1; Mon, 18 May 2020 05:18:58 -0400
X-MC-Unique: CdDf0meiNZqPXgf6D4X4Cg-1
Received: by mail-wr1-f71.google.com with SMTP id e14so5365035wrv.11
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 02:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mryntO6Z+uP+Xk2M9yDUHtv3sC5SF7dqtlzLXNBKT0w=;
 b=PMCgLqxBrL2TqDNc1rCyTzrzVwKB2+x8/lAk/YR3fpROWFfnDEhZDgFGUG6/u7jER+
 aqR8zB4UvbiWFM8Ym/NM9PaS7gj9YyfHzw0e0oeThHV5xc/CIQIoE5YgDEt/aYJ8VG0T
 qOxTPk3FvyoyzPGqy7dx8YriQo+6vm9BGnLmZsUhJALq1itvD1kT3mApmiq6u5sJYpeD
 T3qacNJx/GLSEHDcrACXE//Ojy60mr+XKYA9eMQ5Zqa3q2YOJOkGiMT35taqX/4et7tn
 XIAaT9GWFdkV4KxLIkaVrfhSuPOSRf7jtSjKM9gvl0zN7DwVB/yZBFz1nzAPKmhbb1Ps
 Iu/g==
X-Gm-Message-State: AOAM533UFlSGNNbIP1Md5f2ABRRyKRLUbNgVQpu+2hfgihxubDwK+Rmm
 L+TYmmaD5GcHdHJmXMM2IXMHNxhg8NkMadF/jcuftVheDgbtKFP2sG9KIxnWQXWII/piTp68rw7
 PDfZCWm7OYqW5gZQ=
X-Received: by 2002:a5d:550c:: with SMTP id b12mr19979664wrv.152.1589793537003; 
 Mon, 18 May 2020 02:18:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9RaqHzewOKFd5d8ebzCfPb77NDvogh+U0U4U3Fe+fb+6v/aEzhQLQadYz1+NDVvramE6YgQ==
X-Received: by 2002:a5d:550c:: with SMTP id b12mr19979638wrv.152.1589793536745; 
 Mon, 18 May 2020 02:18:56 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id e21sm15205392wme.34.2020.05.18.02.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 02:18:56 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] virtio-balloon: fix free page hinting without an
 iothread
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200518083704.52646-1-david@redhat.com>
 <20200518083704.52646-2-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <45026d92-04e9-b654-f05a-3996fd9fa09d@redhat.com>
Date: Mon, 18 May 2020 11:18:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518083704.52646-2-david@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Wei Wang <wei.w.wang@intel.com>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 10:37 AM, David Hildenbrand wrote:
> In case we don't have an iothread, we mark the feature as abscent but
> still add the queue. 'free_page_bh' remains set to NULL.
> 
> qemu-system-i386 \
>          -M microvm \
>          -nographic \
>          -device virtio-balloon-device,free-page-hint=true \
>          -nographic \
>          -display none \
>          -monitor none \
>          -serial none \
>          -qtest stdio
> 
> Doing a "write 0xc0000e30 0x24
> 0x030000000300000003000000030000000300000003000000030000000300000003000000"
> 
> We will trigger a SEGFAULT. Let's move the check and bail out.
> 
> While at it, move the static initializations to instance_initialize().
> 
> Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Cc: Wei Wang <wei.w.wang@intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/virtio/virtio-balloon.c | 35 ++++++++++++++++++-----------------
>   1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 065cd450f1..dc3b1067ab 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -789,6 +789,13 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    if (virtio_has_feature(s->host_features,
> +        VIRTIO_BALLOON_F_FREE_PAGE_HINT) && !s->iothread) {
> +        error_setg(errp, "'free-page-hint' requires 'iothread' to be set");
> +        virtio_cleanup(vdev);
> +        return;

This is exactly what I had in mind!

> +    }
> +
>       s->ivq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>       s->dvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>       s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
> @@ -797,24 +804,11 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>                              VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>           s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
>                                              virtio_balloon_handle_free_page_vq);
> -        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
> -        s->free_page_report_cmd_id =
> -                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
> -        s->free_page_report_notify.notify =
> -                                       virtio_balloon_free_page_report_notify;
>           precopy_add_notifier(&s->free_page_report_notify);
> -        if (s->iothread) {
> -            object_ref(OBJECT(s->iothread));
> -            s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
> -                                       virtio_ballloon_get_free_page_hints, s);
> -            qemu_mutex_init(&s->free_page_lock);
> -            qemu_cond_init(&s->free_page_cond);
> -            s->block_iothread = false;
> -        } else {
> -            /* Simply disable this feature if the iothread wasn't created. */
> -            s->host_features &= ~(1 << VIRTIO_BALLOON_F_FREE_PAGE_HINT);
> -            virtio_error(vdev, "iothread is missing");
> -        }
> +
> +        object_ref(OBJECT(s->iothread));
> +        s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
> +                                     virtio_ballloon_get_free_page_hints, s);
>       }
>       reset_stats(s);
>   }
> @@ -892,6 +886,13 @@ static void virtio_balloon_instance_init(Object *obj)
>   {
>       VirtIOBalloon *s = VIRTIO_BALLOON(obj);
>   
> +    qemu_mutex_init(&s->free_page_lock);
> +    qemu_cond_init(&s->free_page_cond);
> +    s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
> +    s->free_page_report_cmd_id = VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
> +    s->free_page_report_notify.notify = virtio_balloon_free_page_report_notify;
> +    s->block_iothread = false;

This part is even cleaner.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
>       object_property_add(obj, "guest-stats", "guest statistics",
>                           balloon_stats_get_all, NULL, NULL, s);
>   
> 


