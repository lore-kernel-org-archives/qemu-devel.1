Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1EFC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AE220737
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdQsLnO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AE220737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyfXa-0002Dc-TH
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 14:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jyfWB-0001NS-9v
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 14:00:32 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:41410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jyfW9-0006Ec-II
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 14:00:31 -0400
Received: by mail-io1-xd42.google.com with SMTP id p205so7186938iod.8
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sHA8P6LbSJdOX/5X+pn5Y9btUFUZviriwjXJIdO/918=;
 b=sdQsLnO5AtTxuQUq7/AvDRUuaKOSaGHeCVIDbb7ksfG+SMx2AtPhDEJK1AzaDHWBrU
 TxdgBQPBrqGuVHMWtgk7JwBf9QZ4AZupbNbTdL/cEMEVG56DV0gEs81KT3DO+3uBcuoN
 rheQQxZtYdjHnuGGLQZlfkK515K8+NxNCPbpo8IEFlg5Ir4d6PVXl/1+Ma2TmQfd0wZH
 GSNH+Y5kT0lqCriwh9EHfA3/5rjm8Pc6G7nkFw5+AKbFylbnq40Ss1McMOE4ZL/3uNQZ
 lNyS1TlI5U9D4ZHvof4o/zTWjjK2kh7SNCINj91EQ9NvAyL872d52C+bD55P8xYgct5M
 H+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sHA8P6LbSJdOX/5X+pn5Y9btUFUZviriwjXJIdO/918=;
 b=eMQCp9GXOa5ig6CV1ODs1Vr+MHuppWI0XBSA9gXNUcu4PX6jnkdwcmJChlnuclAXPG
 Zxicl3BnOWzwvG0nHKrATLbITLamP8zz/HpEWzMFc742OF3f+/WBSD4RwbEG7b0onQcO
 fFBRG1hRJpNoUWI/qV3mtwCVGGDmGQKA4WKlAq7dlpWmYBjIxxcKcaHAjiVQbFlZ7sN9
 Mn1FqIDPc0oGm1fd4/8iI/HkKblcp6JHRX7pNilXg2KjhC5NrL2l/6Qbutu2Dhoaxa8E
 mS9jAEmmEYo/BAcOCLzWsrRbdRiOnWgnvEc8RMO+b7gJgCTBT6pNfmunehlxaInKbzPa
 WjRw==
X-Gm-Message-State: AOAM533hcKw3FYcLDGxMAUEcnn4VLjU4xwwzvLV6Y5MvOpbD3XE28Qg/
 anJr79GaZP2ZBMsMrQz/j45iwUMPadAfPjH0ImA=
X-Google-Smtp-Source: ABdhPJwj+D9qrWUTRzDUlG28bkBViXoZHT7GwC0QavHf7p/ZtBKQbv0uk5ixuQN0Ha8apxKWV2Xl3auUJQv+q5o4K1w=
X-Received: by 2002:a05:6602:160b:: with SMTP id
 x11mr6334698iow.52.1595527228366; 
 Thu, 23 Jul 2020 11:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200723171935.18535-1-philmd@redhat.com>
In-Reply-To: <20200723171935.18535-1-philmd@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 23 Jul 2020 12:00:16 -0600
Message-ID: <CAFubqFv=Y_NJbj8j7KujOt6wyn5h3-Tj+RKCEeLdSvkVWdbgAg@mail.gmail.com>
Subject: Re: [PATCH-for-5.1] libvhost-user: Report descriptor index on panic
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd42.google.com
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 11:20 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> We want to report the index of the descriptor,
> not its pointer.
>
> Fixes: 7b2e5c65f4 ("contrib: add libvhost-user")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  contrib/libvhost-user/libvhost-user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index d315db1396..53f16bdf08 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -2074,7 +2074,7 @@ virtqueue_get_head(VuDev *dev, VuVirtq *vq,
>
>      /* If their number is silly, that's a fatal mistake. */
>      if (*head >=3D vq->vring.num) {
> -        vu_panic(dev, "Guest says index %u is available", head);
> +        vu_panic(dev, "Guest says index %u is available", *head);
>          return false;
>      }
>
> @@ -2133,7 +2133,7 @@ virtqueue_read_next_desc(VuDev *dev, struct vring_d=
esc *desc,
>      smp_wmb();
>
>      if (*next >=3D max) {
> -        vu_panic(dev, "Desc next is %u", next);
> +        vu_panic(dev, "Desc next is %u", *next);
>          return VIRTQUEUE_READ_DESC_ERROR;
>      }
>
> --
> 2.21.3
>
>

