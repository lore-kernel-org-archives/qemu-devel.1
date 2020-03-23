Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D119C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0699D2076A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzhkXW0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0699D2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGLfz-0008PW-3x
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1jGLfH-0007gS-PJ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1jGLfG-0007Al-Nl
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:54:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31171)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1jGLfG-0007AV-Kg
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584964482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKBLv5hrIQfASAmROd8gvaNOJ705AM65DBfbKWvDjC0=;
 b=gzhkXW0cBd3K8iDqAPmSls4fXAyPH3lakIaakh9O0RqoQabB/du3WfMdVFvwjT74r3VVIe
 6Bx70AEg/VM8ggDn1s9SzZmwhf8GRbDUY1Y1yTTMKbmdEFF+QsrAzzQFuCtwpzKpoMo6IH
 JSSjGR3KRfZwoBZguBVcAQkDiESWOp0=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-wixl5HJWMQOaFZEaMkYhDA-1; Mon, 23 Mar 2020 07:54:40 -0400
X-MC-Unique: wixl5HJWMQOaFZEaMkYhDA-1
Received: by mail-oi1-f198.google.com with SMTP id t12so10084815oih.4
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 04:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gKBLv5hrIQfASAmROd8gvaNOJ705AM65DBfbKWvDjC0=;
 b=TvmbPea8YuG8EpDgGu+vkCbV2zwvJSYU435AF3PXJJ9k9S55PZsi4GoZKhJ14ENvRF
 QIwrGOQjbjFrAa4JMwUiBTFM8iPzzDH1C8Bhh6QuFS5LgD3PawZaCA2ZiUuXZrD18C/m
 GOQfEQqb1iLwWjKPZ6gfNjXk3XRZ/PaaUD+GVde9TK5PiSRX4GxQbX4aaWAn7qahsqYy
 IhOK9L6aZCcuv6BWMJT1N730m8GLW0QTDRa/BC28B8hHI4wQO8WM9D/kJ2CfdRy/UPDm
 iSXURTacd/XcSPZ33TXO15pXp/raUhFEzGaT/VV7Wgnt5vpom0K9OcpKUFyaCbq4vGRG
 wBAA==
X-Gm-Message-State: ANhLgQ0MY2Fd3rR8SA385exrS+LS1fYwewtrHfdtJy38Da5r/wHw9tZ6
 eCeGm2pHM1o6ZW0hQWiklwcTgQsx8X/ULWayDIvilaN2WsfQ2NXnWWU1ceDy4FkWT0HZ3ItuKhS
 L/bd+E8gVMhsQl2RymdNCjwX+JnAnuQ4=
X-Received: by 2002:a05:6830:1d4f:: with SMTP id
 p15mr16649689oth.38.1584964479667; 
 Mon, 23 Mar 2020 04:54:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vua3klCde2YzKOay3xDWKiz6c/RDthBkTkVFJ0/wwOgP+bbORT6YfsqIsaNIo9cjeekvvZPLr45fkBbX2AfXrY=
X-Received: by 2002:a05:6830:1d4f:: with SMTP id
 p15mr16649673oth.38.1584964479448; 
 Mon, 23 Mar 2020 04:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200323112943.12010-1-philmd@redhat.com>
 <20200323112943.12010-2-philmd@redhat.com>
In-Reply-To: <20200323112943.12010-2-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 23 Mar 2020 12:54:28 +0100
Message-ID: <CAMxuvawOrkkiLZG4SPq-BdSmi6Ur9xt37AWgtPoVogpWPVuzrQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 1/3] vhost-user-gpu: Release memory returned by
 vu_queue_pop() with free()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 23, 2020 at 12:29 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> vu_queue_pop() returns memory that must be freed with free().
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Coverity (CID 1421887 ALLOC_FREE_MISMATCH)
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  contrib/vhost-user-gpu/vhost-user-gpu.c | 4 ++--
>  contrib/vhost-user-gpu/virgl.c          | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user=
-gpu/vhost-user-gpu.c
> index b45d2019b4..a019d0a9ac 100644
> --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
> +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
> @@ -848,7 +848,7 @@ vg_handle_ctrl(VuDev *dev, int qidx)
>              QTAILQ_INSERT_TAIL(&vg->fenceq, cmd, next);
>              vg->inflight++;
>          } else {
> -            g_free(cmd);
> +            free(cmd);
>          }
>      }
>  }
> @@ -939,7 +939,7 @@ vg_handle_cursor(VuDev *dev, int qidx)
>          }
>          vu_queue_push(dev, vq, elem, 0);
>          vu_queue_notify(dev, vq);
> -        g_free(elem);
> +        free(elem);
>      }
>  }
>
> diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virg=
l.c
> index 43413e29df..b0bc22c3c1 100644
> --- a/contrib/vhost-user-gpu/virgl.c
> +++ b/contrib/vhost-user-gpu/virgl.c
> @@ -519,7 +519,7 @@ virgl_write_fence(void *opaque, uint32_t fence)
>          g_debug("FENCE %" PRIu64, cmd->cmd_hdr.fence_id);
>          vg_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
>          QTAILQ_REMOVE(&g->fenceq, cmd, next);
> -        g_free(cmd);
> +        free(cmd);
>          g->inflight--;
>      }
>  }
> --
> 2.21.1
>


