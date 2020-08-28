Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57971C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 01:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D0E2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 01:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrbKFnnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D0E2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBTU0-0003nU-DZ
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 21:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kBTT7-0003CI-Si; Thu, 27 Aug 2020 21:46:17 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kBTT6-0002b8-4X; Thu, 27 Aug 2020 21:46:17 -0400
Received: by mail-ot1-x344.google.com with SMTP id v16so3022691otp.10;
 Thu, 27 Aug 2020 18:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CUO5ZwHSA9a7yE6mR1+0DMc2aW2TFUkS1GyAFzJx3Vc=;
 b=XrbKFnnvjhnGVeHWvin0wIux2TA3c5+3KjIng/aTZRr1AIxW5+1rnwwmnQFBpN9uEp
 r4RIfsisk8VdsYFGhHZ67dgKFT88PKXddJMZaAUHwDbHXccx3rluXIW5Zuuu7Zv/ld59
 Wug/eofIcpHL+ARN+Tg9SYcbfGn7M7E7ygGkbT/Yp4n6EB0H4+buBbra1R0aAN/GU+Hs
 HLpo7jzbwhmLMZir4uxwQL3Id2S6ibmbWlNVud/3UhVe/+GhCaniPDaFEPJtBsaVovI1
 U7Ie2Py3JJr9hy4/0GDV7zxpz2DkFjILsMtn1Oq1D56UnbBXiPMtzZlYDxmTC6zKXIF0
 bwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CUO5ZwHSA9a7yE6mR1+0DMc2aW2TFUkS1GyAFzJx3Vc=;
 b=oj/C7SHv+6oevEcof/XgvnVRb5rvy/a/9avNaPCbBn9HbTVR1wZrzPKbHzuKZe7cof
 rcWSDar4WuOJ+3300CTdtF8LmjczfBtYaFkApCv0M88EZv58SIbDU96ooGcyg5XhU75A
 vbizqEYRM6uxc4+FeOGZ7+bbLr9gr0y6xFAVuI8XRBl48g0KlT5rniRiuKq5oKsN+AvZ
 XhqV5T6mYJ4YTmQvXRmytEasEiLLfTvVhMSqYaaEfPcPZ6FO+tgg0k3Y9khbwN2/6L1m
 LhkFfP/QfW8aZsND1hX7LEhBr85yTpL4jDnbZO+dPJJp6ordUSitNpgLCsOxufNmzG3W
 matA==
X-Gm-Message-State: AOAM532+A/QHeOBOCgV4SKQ7mDqxuMDgRiM7AmhTSUGNBOuYbdZxze++
 BhoYGwmQDEhQ7kG1gri17XOk6m7kgy1iU/OZR4o=
X-Google-Smtp-Source: ABdhPJw4RczrmbmUm+PNiV5FvPKaWIQ4KTj9HbcpXh9XNwx3Gdb3Pg/cMzHvZPWkfWmTOOaEIE+j+/6e3jDFZWYhXlY=
X-Received: by 2002:a9d:5c06:: with SMTP id o6mr15427363otk.262.1598579174620; 
 Thu, 27 Aug 2020 18:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598257838.git.dimastep@yandex-team.ru>
 <a2eca26b79e1fcc30128a266bfa416237366c533.1598257838.git.dimastep@yandex-team.ru>
In-Reply-To: <a2eca26b79e1fcc30128a266bfa416237366c533.1598257838.git.dimastep@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 27 Aug 2020 21:46:03 -0400
Message-ID: <CAFubqFsnc3VjkYB-CqgeQ6Knwtvgb0Zyw-nOHD1CugLzTBe9Ew@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] vhost: check queue state in the vhost_dev_set_log
 routine
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-ot1-x344.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, fengli@smartx.com,
 yc-core@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 24, 2020 at 4:41 AM Dima Stepanov <dimastep@yandex-team.ru> wro=
te:
>
> If the vhost-user-blk daemon provides only one virtqueue, but device was
> added with several queues, then QEMU will send more VHOST-USER command
> than expected by daemon side. The vhost_virtqueue_start() routine
> handles such case by checking the return value from the
> virtio_queue_get_desc_addr() function call. Add the same check to the
> vhost_dev_set_log() routine.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index ffef7ab..a33ffd4 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -825,12 +825,24 @@ static int vhost_dev_set_features(struct vhost_dev =
*dev,
>  static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
>  {
>      int r, i, idx;
> +    hwaddr addr;
> +
>      r =3D vhost_dev_set_features(dev, enable_log);
>      if (r < 0) {
>          goto err_features;
>      }
>      for (i =3D 0; i < dev->nvqs; ++i) {
>          idx =3D dev->vhost_ops->vhost_get_vq_index(dev, dev->vq_index + =
i);
> +        addr =3D virtio_queue_get_desc_addr(dev->vdev, idx);
> +        if (!addr) {
> +            /*
> +             * The queue might not be ready for start. If this
> +             * is the case there is no reason to continue the process.
> +             * The similar logic is used by the vhost_virtqueue_start()
> +             * routine.
> +             */

Shouldn=E2=80=99t we goto err_vq here to reset the logging state of any vqs
which have already been set?

> +            break;
> +        }
>          r =3D vhost_virtqueue_set_addr(dev, dev->vqs + i, idx,
>                                       enable_log);
>          if (r < 0) {
> --
> 2.7.4
>
>

