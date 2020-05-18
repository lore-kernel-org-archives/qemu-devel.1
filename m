Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A775C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D2820758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSlL20ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D2820758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahav-0002i6-Bv
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jahZd-00019x-Jh
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:21:01 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:39709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jahZX-0007Z9-OS
 for qemu-devel@nongnu.org; Mon, 18 May 2020 11:21:01 -0400
Received: by mail-io1-xd43.google.com with SMTP id x5so10992962ioh.6
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9q4LK0XRB0Ghx4ryV9qmNo+1EdRVWpIWprHfbttb5oc=;
 b=OSlL20ipClK+NCUMfqvVVr3/RWwRcFbE5vfOFnt9MNLUywVL5/AzYylkargw94ja0B
 eDZM3rLplEAvuqEXRoYJhoY4rj5V/alblHMoJs/8EQsfj5SZXNDMKArmp8H1r3d0ww7v
 z0cOouF72ZS6rlfAysciFjzbLEq7W+oDedqvlSsYACcOWXyIFvfPxQoaXO/yjEj8jAme
 XTaZyX1P4TY+D4w6LDQN3afXU1DjqLnSBtY0/zbWtSw1UFvzMYtpnscJd1WdGJitz/WP
 3gpeqpzTw+WskPgw+Q+7KZjPi/u7Pq/km/IVjfVu7oM7EeuwZkI8SUwd80rEutqcDqvb
 ffRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9q4LK0XRB0Ghx4ryV9qmNo+1EdRVWpIWprHfbttb5oc=;
 b=LW2xJ8TVUqiuwZM4Z+W6ErTKozlJt++5TTZn3X8OFHTxnSbsVlH4tF3nkYx/lCCF7R
 RMqgDA5cBPfmHW7wemPLL00kR5R/YipwZBuqXPUK3jD3j+HbZE/ScW2ycJS1FLghhCW+
 ivNkN0KKD3uLlMtNQKksoAlloNMPnaIjA1URoFwWS/N9s9QKFHvCaKpLFX2Hy1MugIne
 yEbuQWHV0f+o8Yqi8ttdKdC3HIbnsEzIaQLJ9tpuFIWxlC8+XRI0Ykf3gRW6NgEuTpYf
 Rd3LtFRnROR6lOAzlntMgQQltgk1BSSOb4yoW/75TaqJrQnrJu37lTUvVEJAuiQXNman
 XdYw==
X-Gm-Message-State: AOAM530Nqn5ANtQrx5ryH4dRg3ALJTBN9b+2iPslCdhT/fON60vd387I
 H6GtWPScD0MUpn9vC9mji+nvjcJpG+ArGML2msw=
X-Google-Smtp-Source: ABdhPJwumebLY+MNG9GT4NtBmJ3yEvXaSyGAD8ibhdSZVtvi87TEaTa4QO8H07+VA/ku/A8J1gKUL7CPjMQluYExjQA=
X-Received: by 2002:a02:90cd:: with SMTP id c13mr16049211jag.83.1589815254446; 
 Mon, 18 May 2020 08:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200518083704.52646-1-david@redhat.com>
 <20200518083704.52646-3-david@redhat.com>
In-Reply-To: <20200518083704.52646-3-david@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 18 May 2020 08:20:43 -0700
Message-ID: <CAKgT0UcimHW0fUyQRrEVeUHowkOudDAD6KM+-2MmBbn_fs8K8w@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] virtio-balloon: fix free page hinting check on
 unrealize
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alexander.duyck@gmail.com; helo=mail-io1-xd43.google.com
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
Cc: Wei Wang <wei.w.wang@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 1:37 AM David Hildenbrand <david@redhat.com> wrote:
>
> Checking against guest features is wrong. We allocated data structures
> based on host features. We can rely on "free_page_bh" as an indicator
> whether to un-do stuff instead.
>
> Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> Cc: Wei Wang <wei.w.wang@intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/virtio-balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index dc3b1067ab..a4fcf2d777 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -818,7 +818,7 @@ static void virtio_balloon_device_unrealize(DeviceSta=
te *dev)
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>      VirtIOBalloon *s =3D VIRTIO_BALLOON(dev);
>
> -    if (virtio_balloon_free_page_support(s)) {
> +    if (s->free_page_bh) {
>          qemu_bh_delete(s->free_page_bh);
>          virtio_balloon_free_page_stop(s);
>          precopy_remove_notifier(&s->free_page_report_notify);

Would it make sense to apply the same change to
virtio_balloon_device_reset and virtio_balloon_set_status? At least in
the case of virtio_balloon_set_status it seems like you could possibly
exploit it somehow as clearing the feature in the guest will prevent
the toggling of the block_iothread value.

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

