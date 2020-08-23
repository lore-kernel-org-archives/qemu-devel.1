Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EC8C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 11:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985362072D
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 11:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO987A8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985362072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9ns0-00056Y-UW
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 07:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1k9nqU-0004FB-3c
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 07:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1k9noX-0000Oo-5M
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 07:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598180727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uig1qcUKI+nlESAiXx5kqcB5MiLLSBKvK+AC0+PjcmU=;
 b=YO987A8HibgWR1BZhquvU9R+J9z48I1dc9l2KCPYT4+9CxdVsGevAgLh/JLZgwP4I2OfZi
 DCW5fVkdeEgtBUyy3ea0tNVjkzsPiTsoGdOP+WdQRqjjfpF+KfHX7MUtdvKE3ExQHZ19rb
 jlcPx3jkJqcL28dWiLlwiYnOhiTzmMc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-OM7b7ZFuOre99GxUNeNTBg-1; Sun, 23 Aug 2020 07:05:23 -0400
X-MC-Unique: OM7b7ZFuOre99GxUNeNTBg-1
Received: by mail-il1-f197.google.com with SMTP id q16so4600546ils.19
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 04:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uig1qcUKI+nlESAiXx5kqcB5MiLLSBKvK+AC0+PjcmU=;
 b=bXOTPQ3zIekh/NSuA95MtxPoHLqjqisdA63Bw+2Nelz74UFZCU8VQn5tUONbYWBA6/
 gtiYxGk+yiscNu+krsPxCzusilEPDJAQt7TTvCYubUg6YEf5gLH9jJrCG1BtuyQcZMmJ
 XzPph3XauJFGSQcZmE1OeWgk+7VrUf+xFCks1cwtN+jqgVnTppgSiN7hkR/i6uDGjL8n
 3zAYFjAWDOIAUp486XPv6GdqXv2APKxiXNb5C3cg2adpWGxZ241rz7OHzZ9o8zvfBuyS
 hqHBS/LbSsVD3vWDbPGq5o9d89DqCC671uKXzJ4GpGs+QHDzEajQw3iJ+Kf6/Eodqw2L
 cItg==
X-Gm-Message-State: AOAM5332zBcMksHb0XS5tdAtaiTF4JE61TKtfglQXDgQYti6l6soN7Ux
 kavckUcyh7Ruqf1z384LwQrEotfiHbSC+Q7ZCoFhV3/Jioop4YiU9t9NUS5BkGMLOpWFyrDSDL4
 Yj8mugr1fWvKmKJ7a7MLiO8VyZpVq2E8=
X-Received: by 2002:a6b:600a:: with SMTP id r10mr806038iog.0.1598180723030;
 Sun, 23 Aug 2020 04:05:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+jcMM6WERyxznpxaDB06oun6z9EDutYnqgOCufuZO1TkAgFTfftDSobhJlE43Mi16PIkWDtSooZtdQi7qurc=
X-Received: by 2002:a6b:600a:: with SMTP id r10mr806027iog.0.1598180722796;
 Sun, 23 Aug 2020 04:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200823083215.14952-1-thuth@redhat.com>
In-Reply-To: <20200823083215.14952-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 23 Aug 2020 15:05:11 +0400
Message-ID: <CAMxuvazPueVDHu0uFi5_EnELCUzcSiD_oCMBFUiboVxJZsXiSg@mail.gmail.com>
Subject: Re: [PATCH] meson: Build qemu-nbd on macOS again
To: Thomas Huth <thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlureau@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 06:26:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sun, Aug 23, 2020 at 12:32 PM Thomas Huth <thuth@redhat.com> wrote:
>
> Before switching to the meson build system, we used to compile qemu-nbd
> for macOS, too, which is especially important for running the iotests
> there. Commit b7c70bf2c5 disabled it by accident, since it did not take
> into consideration that the $bsd variable in the configure script was
> also set to "yes" on macOS. Fix it by enabling qemu-nbd on all systems
> but Windows now instead (which was likely the original intention of the
> old code in the configure script).
>
> Fixes: b7c70bf2c5 ("meson: qemu-{img,io,nbd}")
> Signed-off-by: Thomas Huth <thuth@redhat.com>

lgtm
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index df5bf728b5..d79f849768 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1075,7 +1075,7 @@ if have_tools
>    qemu_io =3D executable('qemu-io', files('qemu-io.c'),
>               dependencies: [block, qemuutil], install: true)
>    qemu_block_tools +=3D [qemu_img, qemu_io]
> -  if targetos =3D=3D 'linux' or targetos =3D=3D 'sunos' or targetos.ends=
with('bsd')
> +  if targetos !=3D 'windows'
>      qemu_nbd =3D executable('qemu-nbd', files('qemu-nbd.c'),
>                 dependencies: [block, qemuutil], install: true)
>      qemu_block_tools +=3D [qemu_nbd]
> --
> 2.18.2
>


