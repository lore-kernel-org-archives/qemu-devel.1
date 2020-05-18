Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5A4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9EC82065F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBhz/epd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EC82065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahHw-0006tC-3k
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jahGj-0005dc-HU
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:01:29 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:41912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jahGh-0002Ke-Td
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:01:28 -0400
Received: by mail-il1-x144.google.com with SMTP id b71so10101436ilg.8
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 08:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0rXR/WFlvTIR36uV3kr0RHz/If7N/W/Nf360qRIZLv0=;
 b=bBhz/epdQ8T4TpkT4e5QuiHRPpV6cuIbaUMVeuKcqXZCYKZ1fZypxnHQxJy8ZzXHrH
 BFBBviIVoxXPWcU5kLI+mjehb/7tlzVxdSWiF+y8iNVn/EXh716OOGmcgb/5GfV5ocmb
 V/iqRsXQQeECuk3MQYciYEaT45PCBV/Z+m3v2s1wbqlPsTPMGj7+dak+zc0ZY1+pRb55
 9ICwwfspktRkoXlqk8/7Kd0gKNzeEb56rJIfCA1M9b5DkLYjsLKMHB8FPDkAO/sZjGHZ
 Q03z4HzfAkT+4MfysaEO/CfLvAqUT2JwdU2VWkWqVAiorXJcM7tyMAkvoNZk+l1DEhow
 j8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0rXR/WFlvTIR36uV3kr0RHz/If7N/W/Nf360qRIZLv0=;
 b=YoSYjJXmCUQSA+Ahey1Kqs+MUAd4MMfYvkQMuUBuCY8NuS1vBt6FM2z0Ym9WeieIXc
 tCscFHFvVIGsx0AHocBuE1p7XAL5dMJr2DIc0YqtfpwpAEBxGaoUDtnPugzo/NIMAgxw
 +2bpUCvnVZHAm+y9p78X0VLmUKBpKj11gk6RHS+5C2N3ZG+M0vrou5P00X8q8sPVVBJa
 9VQ5tvA8pZ8TcrFyClh/nXsyavbmTjBZY65gTy9oxkRln/r3kYUEJjjRZYZ5zQ0AkFcX
 f2JGwAgJLULOvHTcSX6swWUIPMDr9unqTJ2z6H7fslgTKdP/54Z4b6V3B3Pzf5cf3wpM
 ZzWQ==
X-Gm-Message-State: AOAM532T27Gp2snIhWDLiuipHg+U5vSs+i3qqCHG4eeCcEmoo7kSsW41
 0AMGE8n3rUdlVKbmVwvlyrQm8UwP6Igv+DLQ4PU=
X-Google-Smtp-Source: ABdhPJyy4I0bYE8gJUISnrDj8iU+5VXimEvUewsMDgjdbp1t6BifLsdyhTGZssCQBCFg4Twf1V232l7f+WgIaGaARJU=
X-Received: by 2002:a92:d40f:: with SMTP id q15mr15242714ilm.97.1589814084062; 
 Mon, 18 May 2020 08:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200518083704.52646-1-david@redhat.com>
 <20200518083704.52646-2-david@redhat.com>
In-Reply-To: <20200518083704.52646-2-david@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 18 May 2020 08:01:13 -0700
Message-ID: <CAKgT0UfBHTxUm7Ka_8NQgT_4P0McsPGqpSTcquN7_ZLJ+i=uRA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] virtio-balloon: fix free page hinting without an
 iothread
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alexander.duyck@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 1:37 AM David Hildenbrand <david@redhat.com> wrote:
>
> In case we don't have an iothread, we mark the feature as abscent but
> still add the queue. 'free_page_bh' remains set to NULL.
>
> qemu-system-i386 \
>         -M microvm \
>         -nographic \
>         -device virtio-balloon-device,free-page-hint=3Dtrue \
>         -nographic \
>         -display none \
>         -monitor none \
>         -serial none \
>         -qtest stdio
>
> Doing a "write 0xc0000e30 0x24
> 0x03000000030000000300000003000000030000000300000003000000030000000300000=
0"
>
> We will trigger a SEGFAULT. Let's move the check and bail out.
>
> While at it, move the static initializations to instance_initialize().
>
> Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Cc: Wei Wang <wei.w.wang@intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/virtio-balloon.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 065cd450f1..dc3b1067ab 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -789,6 +789,13 @@ static void virtio_balloon_device_realize(DeviceStat=
e *dev, Error **errp)
>          return;
>      }
>
> +    if (virtio_has_feature(s->host_features,
> +        VIRTIO_BALLOON_F_FREE_PAGE_HINT) && !s->iothread) {
> +        error_setg(errp, "'free-page-hint' requires 'iothread' to be set=
");
> +        virtio_cleanup(vdev);
> +        return;
> +    }
> +
>      s->ivq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_output)=
;
>      s->dvq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_output)=
;
>      s->svq =3D virtio_add_queue(vdev, 128, virtio_balloon_receive_stats)=
;
> @@ -797,24 +804,11 @@ static void virtio_balloon_device_realize(DeviceSta=
te *dev, Error **errp)
>                             VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>          s->free_page_vq =3D virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
>                                             virtio_balloon_handle_free_pa=
ge_vq);
> -        s->free_page_report_status =3D FREE_PAGE_REPORT_S_STOP;
> -        s->free_page_report_cmd_id =3D
> -                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
> -        s->free_page_report_notify.notify =3D
> -                                       virtio_balloon_free_page_report_n=
otify;
>          precopy_add_notifier(&s->free_page_report_notify);
> -        if (s->iothread) {
> -            object_ref(OBJECT(s->iothread));
> -            s->free_page_bh =3D aio_bh_new(iothread_get_aio_context(s->i=
othread),
> -                                       virtio_ballloon_get_free_page_hin=
ts, s);
> -            qemu_mutex_init(&s->free_page_lock);
> -            qemu_cond_init(&s->free_page_cond);
> -            s->block_iothread =3D false;
> -        } else {
> -            /* Simply disable this feature if the iothread wasn't create=
d. */
> -            s->host_features &=3D ~(1 << VIRTIO_BALLOON_F_FREE_PAGE_HINT=
);
> -            virtio_error(vdev, "iothread is missing");
> -        }
> +
> +        object_ref(OBJECT(s->iothread));
> +        s->free_page_bh =3D aio_bh_new(iothread_get_aio_context(s->iothr=
ead),
> +                                     virtio_ballloon_get_free_page_hints=
, s);
>      }
>      reset_stats(s);
>  }
> @@ -892,6 +886,13 @@ static void virtio_balloon_instance_init(Object *obj=
)
>  {
>      VirtIOBalloon *s =3D VIRTIO_BALLOON(obj);
>
> +    qemu_mutex_init(&s->free_page_lock);
> +    qemu_cond_init(&s->free_page_cond);
> +    s->free_page_report_status =3D FREE_PAGE_REPORT_S_STOP;
> +    s->free_page_report_cmd_id =3D VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_I=
D_MIN;
> +    s->free_page_report_notify.notify =3D virtio_balloon_free_page_repor=
t_notify;
> +    s->block_iothread =3D false;
> +
>      object_property_add(obj, "guest-stats", "guest statistics",
>                          balloon_stats_get_all, NULL, NULL, s);
>

So the one nit I have is that I am not sure you need to bother with
initializing block_iothread since it should already be initialized to
false/0 shouldn't it? Otherwise this all looks good to me.

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

