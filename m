Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB62C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D1D20774
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ekq1rM3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D1D20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH75i-0005Ik-RZ
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jH74l-0004UT-Sj
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jH74k-0004i5-Jk
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:32:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jH74j-0004gh-J7
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:32:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id w10so3400966wrm.4
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Nsg8WDrbNi4xpCnWuKjJ0AqqF8+6n6iqmk1lQfv2SEo=;
 b=Ekq1rM3HkYrrLjBu18UNJcDdodtWZ8TAC1pr991AOUiS5hbrCQQZFlqseKo86uoXWq
 DMmtU62SnuG0V0oGzKBRN0A8xX2onFKDcNnr8ztBILXv1XbJScTbKP+b9VOTbZRHW8Sm
 6OP4tGcMMBBLYrWj4e3/ywaYcruaMYutZH23OvOnNXPyJQK6bhSJ7ezXDUlvcrPVc8Mg
 5LR/a2lkwPr3C4mk04C9e5a+UpU5jwMR5JCfDbhaXyJjP9bG0MSsc+RpZvSMLpV6CTSH
 iQbptM/ZE8VZZf0aeHmI5y7KCllPMpOaQwC0XmVaLSvx02LNjQx+jWqvGd5ULpRWKk2H
 pOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Nsg8WDrbNi4xpCnWuKjJ0AqqF8+6n6iqmk1lQfv2SEo=;
 b=PDIV5MZcv2fO/mWSr+eO9QXGnU0bfCxgL3ssOQ/Spja6DtVPJlf9F81jEdvyLfrEe8
 qb9VEKDZLf7XcZ0YCwWEYPXBueVICcNpThw/lvPNLnOBau+hm8CLK2m3vXwVawBaPDOu
 Kv51gdXALhJmocolRjEBzjKVcYOGF6C9ErwxQSXtuwjeYKVOqBAnbXW7wGw5c5Z6Ria4
 glXyZRn/3HQhm6F2aHOQaoRRgVh8/nxVBilD2fvBDBP3eqAqnjOFtZ985yifxgUDpDo0
 6Unvt9yJIeBrLSVvXLgRipM388IvDzXttfHoN/wYEXaFJA5T1MjdVy4edK5DtH5BeNLp
 n8GQ==
X-Gm-Message-State: ANhLgQ1vKbNCtK5/6drCNUyIa0J0s0GRqb8dlK4cYu3SxnyuFiMtiJix
 uZp3+dHuBck/xZVPDVd32D4J21sRZ3Lc0DlOpkg=
X-Google-Smtp-Source: ADFU+vvpocNbifTzySpC+P2TE0gaC7ddTxpGC7r4kiTcm56+Ll8GbPREa3CfIkOb9yrTIVJBsM0jQDfPcY3C/9uYel0=
X-Received: by 2002:adf:fe4c:: with SMTP id m12mr3859143wrs.96.1585146728133; 
 Wed, 25 Mar 2020 07:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200323112943.12010-1-philmd@redhat.com>
 <20200323112943.12010-4-philmd@redhat.com>
In-Reply-To: <20200323112943.12010-4-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 25 Mar 2020 15:31:56 +0100
Message-ID: <CAJ+F1CKhsL8n=FGQfoqVprEgsKP=km0V04Va9OcgB2GOvBS1Og@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 3/3] virtio-gpu: Release memory returned by
 virtqueue_pop() with free()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Mar 23, 2020 at 12:31 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> As virtio_gpu_handle_ctrl() fills the cmdq calling virtqueue_pop(),
> we need to release it with free() in virtio_gpu_reset().
>
> virtio_gpu_handle_ctrl() allocates memory calling virtqueue_pop(),
> release it in virtio_gpu_process_cmdq() with free().
>
> virtio_gpu_process_cmdq() move commands from cmdq to fenceq, so
> we also have to release them with free().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

nack, hw/virtio/virtio.c uses gmalloc (or I am missing something)

> ---
>  hw/display/virtio-gpu-3d.c | 2 +-
>  hw/display/virtio-gpu.c    | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
> index 96621576c2..3a97d267e5 100644
> --- a/hw/display/virtio-gpu-3d.c
> +++ b/hw/display/virtio-gpu-3d.c
> @@ -506,7 +506,7 @@ static void virgl_write_fence(void *opaque, uint32_t =
fence)
>          trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
>          virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODAT=
A);
>          QTAILQ_REMOVE(&g->fenceq, cmd, next);
> -        g_free(cmd);
> +        free(cmd);
>          g->inflight--;
>          if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
>              fprintf(stderr, "inflight: %3d (-)\r", g->inflight);
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 5f0dd7c150..f5fbb722ee 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -835,7 +835,7 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
>                  fprintf(stderr, "inflight: %3d (+)\r", g->inflight);
>              }
>          } else {
> -            g_free(cmd);
> +            free(cmd);
>          }
>      }
>  }
> @@ -921,7 +921,7 @@ static void virtio_gpu_handle_cursor(VirtIODevice *vd=
ev, VirtQueue *vq)
>          }
>          virtqueue_push(vq, elem, 0);
>          virtio_notify(vdev, vq);
> -        g_free(elem);
> +        free(elem);
>      }
>  }
>
> @@ -1157,14 +1157,14 @@ static void virtio_gpu_reset(VirtIODevice *vdev)
>      while (!QTAILQ_EMPTY(&g->cmdq)) {
>          cmd =3D QTAILQ_FIRST(&g->cmdq);
>          QTAILQ_REMOVE(&g->cmdq, cmd, next);
> -        g_free(cmd);
> +        free(cmd);
>      }
>
>      while (!QTAILQ_EMPTY(&g->fenceq)) {
>          cmd =3D QTAILQ_FIRST(&g->fenceq);
>          QTAILQ_REMOVE(&g->fenceq, cmd, next);
>          g->inflight--;
> -        g_free(cmd);
> +        free(cmd);
>      }
>
>  #ifdef CONFIG_VIRGL
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

