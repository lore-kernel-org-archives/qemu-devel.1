Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4968C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D29F23787
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVIBtAhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D29F23787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIco-0001Ry-18
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kJILs-0000zY-T9
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:31:08 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kJILq-0004sI-R9
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:31:08 -0400
Received: by mail-oi1-x242.google.com with SMTP id t76so7462980oif.7
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R5bqaJ/iiMTLttQtgEOcouEBZilyiZGd4JsRAWfdhts=;
 b=AVIBtAhS5SnexqQTm+iUm+uyPY4YawWGOqCQ5Ys/lK/BkDEuA08lZw6QZ6mQ17f3Qq
 Dm0E7YjNg/UM2mwI9h53eiR7B1+CJnV7LhFdpnjQnL69ArRIwYRw+tesogsNDSjclxf0
 jASEV+SvT0YULwPrVpVJvdn2M9lVgCS9E26I+mlOTXucpZq/W0MCAHlE/zrISKb0W6a7
 z8CIVdbwUgnNPvRXo4lzHYs81FeUSHuzB7VbSa4mEUcySbJyMitZG+nwEtwKSgthxB1u
 oNfYVQT8Wvaba9GD2vq2gIe/lr9Is64UJJBvv0alDgtqH5d65ewItky125qNtow1OIi/
 FjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R5bqaJ/iiMTLttQtgEOcouEBZilyiZGd4JsRAWfdhts=;
 b=ZKi5fUcjqvIpOj52CzW0+AuKfACe84bfAHJYPGp8xWKBs/u3sTNuhFw7uSTcn4A7Yj
 Tsr85ji2YCky8sEhivqhJB0U2bI/gSG5K5PA82Qu+PIX2BaxkeBYo7VBejIQnjyKxDiE
 wjkgrcZK3z7nvh+pWRkKacPGTawoQbWtvopjpb7VIA2PpWWubgcsqCx08jlnXweRpFMw
 OhadOGp59IUgwkDpoMFXf8BPEG0ABx6INMH2bOndD1HHCOSgG283yjX4+uuml9TYtrN4
 6tk7illAQhA+npd8UI7q47uwDrh6qyN095vk/fAwRt6ewqfJPe9508yPS4lkibhMG7Jf
 6UfQ==
X-Gm-Message-State: AOAM531sw5mqF5ajjog0sSWNZ/I2B2Ggf5cJe5DkBUNW4lMtDRJZEaUj
 XAjvCci5bmTnhOhpHc5m9dg8c7z0880ekDJq+as=
X-Google-Smtp-Source: ABdhPJzILo1m9Vs0hZWuEa0tJsz+SRAZaukVFtb1gY2/mo2A5lw6ty4i/MOrE0Xjvy1TxC6G4Vhp9Rkc9YHrPU98TZQ=
X-Received: by 2002:aca:4894:: with SMTP id v142mr9971129oia.157.1600443064846; 
 Fri, 18 Sep 2020 08:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200918150506.286890-1-mst@redhat.com>
 <20200918150506.286890-8-mst@redhat.com>
In-Reply-To: <20200918150506.286890-8-mst@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Fri, 18 Sep 2020 11:30:53 -0400
Message-ID: <CAFubqFs_K3YbwqZ1Xes2_X3t9bhKrfLQnQzS2N2v8_2M0xm28Q@mail.gmail.com>
Subject: Re: [PULL 07/15] vhost: check queue state in the vhost_dev_set_log
 routine
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dima Stepanov <dimastep@yandex-team.ru>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi MST - I think you picked an earlier version of the change with a
bug. See my comment bellow:

On Fri, Sep 18, 2020 at 11:11 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Dima Stepanov <dimastep@yandex-team.ru>
>
> If the vhost-user-blk daemon provides only one virtqueue, but device was
> added with several queues, then QEMU will send more VHOST-USER command
> than expected by daemon side. The vhost_virtqueue_start() routine
> handles such case by checking the return value from the
> virtio_queue_get_desc_addr() function call. Add the same check to the
> vhost_dev_set_log() routine.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> Message-Id: <2da64fc45789094b6bd6f1c283cac9e47eeeb786.1598865610.git.dimastep@yandex-team.ru>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/virtio/vhost.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1b2d735b54..abe0fe3e67 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -835,12 +835,24 @@ out:
>  static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
>  {
>      int r, i, idx;
> +    hwaddr addr;
> +
>      r = vhost_dev_set_features(dev, enable_log);
>      if (r < 0) {
>          goto err_features;
>      }
>      for (i = 0; i < dev->nvqs; ++i) {
>          idx = dev->vhost_ops->vhost_get_vq_index(dev, dev->vq_index + i);
> +        addr = virtio_queue_get_desc_addr(dev->vdev, idx);
> +        if (!addr) {
> +            /*
> +             * The queue might not be ready for start. If this
> +             * is the case there is no reason to continue the process.
> +             * The similar logic is used by the vhost_virtqueue_start()
> +             * routine.
> +             */

This should be "continue" not "break" right?

ref: https://lore.kernel.org/qemu-devel/20200901083616.GA18268@dimastep-nix/

> +            break;
> +        }
>          r = vhost_virtqueue_set_addr(dev, dev->vqs + i, idx,
>                                       enable_log);
>          if (r < 0) {
> --
> MST
>
>

