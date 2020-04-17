Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A76C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 06:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9EF20771
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 06:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKGJpOFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9EF20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPKg8-0006uu-LI
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 02:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jPKfK-0006Dt-Vy
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 02:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jPKfJ-00078d-Hh
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 02:39:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60443
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jPKfJ-00077v-EN
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 02:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587105592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUBVQPBPFdM7O8Ue/0lkR4HtTtJFO9rT0lI5kG1dp6A=;
 b=VKGJpOFGvnINIjspD3OjhoYmXR/V6zAPR1oRxQ8KSHfZfzRNEIoAbLDyYsygXPzGvfGggs
 K1mdUJ8d/6QtYycUdIqH8ReXhqOSDYDcVxYBD6JrchPJVl33fNbAg80asdEUYPcHXDiP6s
 S7edGn9+zGNAig86A8PRXo8/5XPz5uA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-Kd6Azl-KOvOkq5YWVt2FcQ-1; Fri, 17 Apr 2020 02:39:51 -0400
X-MC-Unique: Kd6Azl-KOvOkq5YWVt2FcQ-1
Received: by mail-wr1-f72.google.com with SMTP id o12so516958wra.14
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 23:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=s8pQoSM8B9SNpU47Rf2Vn7xWVBYdXT3UvqvSWwIi4Bk=;
 b=jK8XAYC2ueAPQT7KYYCKsGVMhieY/8usTvg4XYD7nu3Og3aydgn5ny4Hs8iLn27lg4
 Uqukd7R8sEvMb/Nh7wNc/YaoVcqsrXxPBwdpKebgrMARbHHGv0/Q4rv2gjVBVrzMJEj9
 61YeFzRE3uWcGAEaWwiVHYPNsXG5cqLl1We6Leaty4AbhomD2dHKPV/UQJnkY0hmusQQ
 hEe+/bhHHuPam/oou6O4KoHKxiK+pLQXaofq0p7m+YOPwAZXtscMHwHI+J7Aw6/pQ1qo
 9r9+9e4L8Yc9BVaKfpK9KjrUfNx396gUEHtcAY5aW3tW7VAnW8NC6Hs0wBN9BqAMFDc0
 qZUA==
X-Gm-Message-State: AGi0PuZkHmZ9VDNPwYAa+vKJ2TGv6c4+O0b9qORFSxJZBtAc3wuvJMwd
 CvyS1i7oJwrmVVkRDuNChgC9bR11ii0QJ7YvEbNpotbFxWM+jko7q3X6mDW55h5srwy2z1TyYrh
 yIVkCWpeDgg4wE38=
X-Received: by 2002:a5d:4388:: with SMTP id i8mr2093445wrq.186.1587105589750; 
 Thu, 16 Apr 2020 23:39:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypJBBPo6Nz+Hv9o45x6UcjLvxmf14qBPtDK/Bn1gEPYCTqU8DeFD9ONRf/O3RoPUFFrT4TD47w==
X-Received: by 2002:a5d:4388:: with SMTP id i8mr2093409wrq.186.1587105589461; 
 Thu, 16 Apr 2020 23:39:49 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
 by smtp.gmail.com with ESMTPSA id m14sm28673674wrs.76.2020.04.16.23.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 23:39:48 -0700 (PDT)
Date: Fri, 17 Apr 2020 02:39:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 05/12] vhost-user-gpu: Release memory returned by
 vu_queue_pop() with free()
Message-ID: <20200417023937-mutt-send-email-mst@kernel.org>
References: <20200414133052.13712-1-philmd@redhat.com>
 <20200414133052.13712-6-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200414133052.13712-6-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>, Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 14, 2020 at 03:30:45PM +0200, Philippe Mathieu-Daud=E9 wrote:
> vu_queue_pop() returns memory that must be freed with free().
>=20
> Cc: qemu-stable@nongnu.org
> Reported-by: Coverity (CID 1421887 ALLOC_FREE_MISMATCH)
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  contrib/vhost-user-gpu/vhost-user-gpu.c | 4 ++--
>  contrib/vhost-user-gpu/virgl.c          | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
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
> =20
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
> --=20
> 2.21.1


