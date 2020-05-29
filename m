Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F59C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F05D207D4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRTyc8Zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F05D207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jelLs-0001t1-Ia
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jelL1-0000oo-Ub
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:10:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48106
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jelL0-0005Sp-EN
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590783040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8lIej6VSOoq8hAaT8ca5/RfBODpgRUVdQh8Tm7Xt6VY=;
 b=aRTyc8ZcYUjWQVaY9uVxJ3QId+GdN1fdLakDS2RFovnYNGIvOLfX6XeAzPvl+xCktdqwjf
 XW3e7JM/xlm5FvIGIReIx0WhCT+J+TmMh/TxQb0q9peObrLL22+IqUWxPOmrw50ayynw6J
 hJ+oP85eE0TOgeU5Bkq2Z7jYEpQwhE4=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-irfWI7NXNzO8oQZpfnvDJQ-1; Fri, 29 May 2020 16:10:38 -0400
X-MC-Unique: irfWI7NXNzO8oQZpfnvDJQ-1
Received: by mail-il1-f197.google.com with SMTP id p11so3206679iln.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8lIej6VSOoq8hAaT8ca5/RfBODpgRUVdQh8Tm7Xt6VY=;
 b=tSBcIU/UQRLzzcEZLLC4yRjNZjqVhTxz07zai2SAydykXFsCZN/RICHr/YgFaQLfmK
 htptVs6qzTWfA/HImPVBg2jkajAAf2MVAcRU6IsihewTUBGWdZKxjLE0xx2Hk4VC+Wcb
 WT8qw+QP+/c/4Ws3V1GdH5Ky6HloYBUS3LBVToJZELXsm+rhqhoJRb9Py8+TyKvSuSW5
 XfX/f3guXCyKvLXJu1gCprf3f8tKoSlyePLsCIn7mim2vFhfAZkRmKh2imDlVKa5wCqu
 3AZt9fVGzJm0UlBmgeNdUdsKDHa1ULfQm2oAcrYxqksC0jtkSdb2agbzYhxYlohu6xqB
 eFvA==
X-Gm-Message-State: AOAM533hNOhUtBwbgAY+Jc69ZLSpdxMkGo/E80/95XC7W/0XA2Imuyn8
 FJ6bu4zR7u3akMw8iBRI3tLV9oeiPKI6AoAuR1BrLjVlMtIluN9p1Q8hwqB9cu5iteIhtsKKD97
 ibtlVTi3kFfK1eDLR15iMKmzG5pnGJAQ=
X-Received: by 2002:a92:bad0:: with SMTP id t77mr9736139ill.82.1590783038324; 
 Fri, 29 May 2020 13:10:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFfKjSiqZ4VftdXhw4iRskymRyFShV9iFN1iE++xv9BGaJzkS0tkMksh2u+M+GyT7m0TxWfvYd6i9k2HvIMJU=
X-Received: by 2002:a92:bad0:: with SMTP id t77mr9736116ill.82.1590783038081; 
 Fri, 29 May 2020 13:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200529161338.456017-1-stefanha@redhat.com>
In-Reply-To: <20200529161338.456017-1-stefanha@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2020 22:10:26 +0200
Message-ID: <CAMxuvayP6D5D39r8qh2_1arqQ6ybG4EDO6BrfLZ=tGTijR==KA@mail.gmail.com>
Subject: Re: [PATCH] libvhost-user: advertise vring features
To: Stefan Hajnoczi <stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, May 29, 2020 at 6:13 PM Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
>
> libvhost-user implements several vring features without advertising
> them. There is no way for the vhost-user master to detect support for
> these features.
>
> Things more or less work today because QEMU assumes the vhost-user
> backend always implements certain feature bits like
> VIRTIO_RING_F_EVENT_IDX. This is not documented anywhere.
>
> This patch explicitly advertises features implemented in libvhost-user
> so that the vhost-user master does not need to make undocumented
> assumptions.
>
> Feature bits that libvhost-user now advertises can be removed from
> vhost-user-blk.c. Devices should not be responsible for advertising
> vring feature bits, that is libvhost-user's job.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> I have tested make check and virtiofsd.
> ---
>  contrib/libvhost-user/libvhost-user.c   | 10 ++++++++++
>  contrib/vhost-user-blk/vhost-user-blk.c |  4 +---
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index 3bca996c62..b43874ba12 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -495,6 +495,16 @@ static bool
>  vu_get_features_exec(VuDev *dev, VhostUserMsg *vmsg)
>  {
>      vmsg->payload.u64 =3D
> +        /*
> +         * The following VIRTIO feature bits are supported by our virtqu=
eue
> +         * implementation:
> +         */
> +        1ULL << VIRTIO_F_NOTIFY_ON_EMPTY |
> +        1ULL << VIRTIO_RING_F_INDIRECT_DESC |
> +        1ULL << VIRTIO_RING_F_EVENT_IDX |
> +        1ULL << VIRTIO_F_VERSION_1 |
> +
> +        /* vhost-user feature bits */
>          1ULL << VHOST_F_LOG_ALL |
>          1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
>
> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user=
-blk/vhost-user-blk.c
> index 6fd91c7e99..25eccd02b5 100644
> --- a/contrib/vhost-user-blk/vhost-user-blk.c
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -382,9 +382,7 @@ vub_get_features(VuDev *dev)
>                 1ull << VIRTIO_BLK_F_DISCARD |
>                 1ull << VIRTIO_BLK_F_WRITE_ZEROES |
>                 #endif
> -               1ull << VIRTIO_BLK_F_CONFIG_WCE |
> -               1ull << VIRTIO_F_VERSION_1 |
> -               1ull << VHOST_USER_F_PROTOCOL_FEATURES;
> +               1ull << VIRTIO_BLK_F_CONFIG_WCE;
>
>      if (vdev_blk->enable_ro) {
>          features |=3D 1ull << VIRTIO_BLK_F_RO;
> --
> 2.25.4
>


